# TwinLibrary — SysML v2 Digital Twin Modeling Library

A SysML v2 library for modeling Digital Twins as a composition of five sub-models with strictly controlled data flow between them. User models built on this library are validated and processed by a companion Java tool.

## Architecture

A Twin is a single flat definition — the five classic sub-models (physical twin, shadow, descriptive, predictive, prescriptive) exist implicitly through the *kinds* of elements a user fills in:

```
part def Twin {
    // Physical twin
    out port  sensors [0..*]              : Sensor;
    in  port  actuators [0..*]            : Actuator;
    state     controlUnit [0..*]          : ControlUnit;
    attribute constAttributes [0..*]      : TwinAttribute;

    // Shadow
    part      databases [0..*]            : Database;

    // Descriptive
    calc  query [0..*]                : QueryHistory;
    attribute derivedAttributes [0..*]: TwinAttribute;
    state     descriptiveStateMachine_ [0..*] : DescriptiveStateMachine;

    // Predictive
    part      predictiveStrategies [0..*] : PredictiveStrategy;

    // Prescriptive
    part      prescriptiveStrategies [0..*] : CustomPrescriptiveStrategy;
}
```

Data flows in one direction through the pipeline, and only the prescriptive model may close the loop back to the physical world:

```
Sensors ──▶ Shadow ──▶ DescriptiveModel ──▶ PredictiveModel ──▶ PrescriptiveModel ──▶ Actuators / Shadow
 (measure)   (persist)   (derive / query)     (predict)           (decide)              (act / persist)
```

The shadow stage is simply the twin's database.

## Repository layout

```
Library/
├── BaseTwin/
│   ├── BaseElements/        Core building blocks (type system, enums, state machines, triggers)
│   ├── PhysicalTwin/        Physical asset: sensors, actuators, control units, protocols
│   ├── Shadow/              Persistence layer: databases
│   ├── Descriptive/         Derived attributes, history queries, descriptive state machines
│   ├── PredictiveModel/     Prediction strategies (lambda-based)
│   ├── Prescriptive/        Decision strategies — the only path back to actuators
│   └── Twin/                Twin composition, public API (TwinLibrary), user extension root (UserLibrary)
└── FedTwin/                 Federation (work in progress)

Test.sysml                                   Full example model (Battery twin)
UserDefinedLibraryBatteryControlUnit.sysml   Example user library (custom calc `All`)
```

## The TwinTypeSystem

- `TwinAttribute` — base type for every value
- `TwinBoolean` — e.g. `true`, `false`, `new TwinBoolean(true)`
- `TwinString` — e.g. `"Hel"`, `new TwinString("Hel")`
- `TwinReal`, `TwinInteger`
- `Twin(Integer|Real|Boolean|Attribute)[x..y]` are considered **lists**

Users create custom attributes by subclassifying `TwinAttribute` (via `TwinCustomType`, see the Model elements reference below for what is closed vs. extensible). All permitted standard-library functions are re-exported as stable aliases (`PLUS_real`, `EQ_int`, `AND_bool`, `SIZE_seq`, …) — these aliases are the whitelist of operations the tool accepts.

## Actions & calcs

Users create their own functions by subclassifying `CustomCalculationAction`. Such calculations should be **pure, with no side effects**, and may use exactly these constructs:

- `if <TwinBoolean> then <action> else <action>`
- `while <condition> { <action> }`
- `for <twinAttribute>:Type of <TwinAttribute> in { <TwinAttribute[x..y]> } { <action> }`
- **Assign**: `<TwinAttribute> := <TwinAttribute>` / `new Attribute(…)` (*)
- `first <action> then <action> …` (sequencing)

Where:

- `<action>` always has to be an **Assign action** as described in (*) — no other SysML action kinds (`send`/`accept`, `perform`, own `action def`s) are permitted anywhere.
- `<TwinAttribute>` has to be a type of `TwinAttribute`. On the **right side** of an assign you may also use the provided calculations or your own functions subclassifying `CustomCalculationAction`.

**Using calculations:** everywhere a `TwinAttribute` is expected (assign or binding) you may use a calculation **call** instead — e.g. `PLUS_real(…)`, `AddPosition(pos_a=…, pos_b=…)`. Calculations can **never** be placed as usages: `calc test : PLUS_real` is illegal; only calling them is allowed.

## Model elements

What each slot of `Twin` is for, and what its features may be bound to.Except for calcultions in the controlUnit: **Any read binding is resolved by the tool as a query against the database (shadow)** — this holds for derived attributes and for all strategy inputs alike. Calculation expressions (e.g. `PLUS_real(p11.temp, 1)`) are allowed anywhere a plain reference is allowed.

### Physical twin

| Element | Description | Binding rules |
|---|---|---|
| `sensors : Sensor` | Out-ports of the physical asset. Each port declares its `measurements` (e.g. `attribute temp : TwinReal :> measurements`). Port arrays are supported (`port p15[100] :> sensors`). | Declarations only — values come from the real device. |
| `actuators : Actuator` | In-ports carrying `commands` toward the device (e.g. `attribute charge : TwinReal :> commands`). | Declarations only. |
| `constAttributes` | Twin-level configuration constants. | Literals only (e.g. `= 100`). |
| `controlUnit : ControlUnit` | State machine running **on the device**. Declares its I/O via category bags: `sensorAttributes` and `constAttributes` (read) and `actuatorAttributes` (write), each bound at embedding time to concrete port/const features (`attribute temp :> sensorAttributes = p11.temp`). Bags may be arrays (`sensorAttributes[100] = p15.plug`). States support `entry`/`do` /`assign` and guarded `transition`s;Again only assign actions guards may use custom calcs from UserLibraries (e.g. `All(bools = plug)`). | `sensorAttributes` → sensor measurements; `constAttributes` → const attributes; `actuatorAttributes` → actuator commands. |

### Shadow

The shadow is simply the twin's database — nothing more. Persistence happens automatically: every read binding outside of a controlunit  resolves as a DB query, a `QueryHistory` on an attribute implies its historization, and unbound strategy outputs are persisted (one table per strategy). 

| Element | Description
|---|---|---|
| `databases : Database` | Storage backends (`RelationalDatabase`, `KeyValueDatabase`) with retention config (`durationInDays`, default `-1` = unlimited). 

### Descriptive model

| Element | Description | Binding rules |
|---|---|---|
| `query : QueryHistory` | History queries against the shadow. Parameters: `twinAttribute` (what to query), `since` + `sinceUnit`, `orderBy`, `limit`, `filterExpression`; returns `result[0..*]`. | `twinAttribute` references the attribute whose history is queried. |
| `derivedAttributes` | Computed twin attributes. | May bind to **derived attributes, const attributes, sensor attributes, actuator attributes, and query results** — every reference resolves as a DB query. Literals and calc expressions are allowed (`PLUS_real(p11.temp, 1)`), as are unbound declarations that are written by a descriptive state machine. |
| `descriptiveStateMachine_` | State machine running **in the cloud** over shadow data. Read bags: `sensorAttributes`, `constAttributes`, `actuatorAttributes`, `derivedReadAttributes`, `queryHistoryAttributes`. Write bag: `derivedWriteAttributes`. | Write bag may only bind **unbound derived attributes** of the twin — this is how a DSM publishes its results (e.g. a state label as `TwinString`). |

### Predictive model

| Element | Description | Binding rules |
|---|---|---|
| `predictiveStrategies : PredictiveStrategy` | Prediction step, implemented externally and referenced via `lambdaPath`. | **Inputs** may bind to sensor attributes, derived attributes, and const attributes (all DB-resolved; calc expressions allowed). **Outputs bind to nothing** — they are pure declarations. Outputs are persisted automatically: each strategy gets its own table in the database for its outputs. |

### Prescriptive model

| Element | Description | Binding rules |
|---|---|---|
| `prescriptiveStrategies : CustomPrescriptiveStrategy` | Decision step (`lambdaPath`), the **only** element allowed to act back on the physical twin. | **Inputs** may bind to sensor attributes, derived attributes, const attributes, **and output attributes of predictive strategies** (all DB-resolved). **Outputs** may either bind to an **actuator attribute** — this is treated as a send to the actuator and is additionally persisted to the shadow — or stay **unbound**, in which case they are persisted like predictive outputs (one table per strategy). |

## Example model (`Test.sysml`)

`part def Battery :> Twin` demonstrates every element once:

- **Sensor ports** `p11` (measurements `temp`, `voltage`, `current` : `TwinReal`, `plug` : `TwinBoolean`) and `p15[100]` (a 100-sensor array of `plug` values); **actuator port** `p12` (command `charge`).
- **Const attribute** `maxCharge = 100`.
- **Control unit** `cm1` binding `p11.*` into `sensorAttributes`, `p15.plug` into a `sensorAttributes[100]` array, `p12.charge` into `actuatorAttributes`, `maxCharge` into `constAttributes`. States `idle`/`charging` with `entry`/`do` assigns (`charge := current + 1`) and a transition guarded by the user-defined calc `All(bools = plug)` from `BatteryControlUnitLibrary`.
- **Query** `temp30 :> query` — history of `p11.temp` over the last 30 seconds.
- **Derived attributes** `temp30Plus1` (expression), `tempPlus1` (`PLUS_real(p11.temp, 1)`), `constTemp` (literal), `cm2State` (literal, later written by `cm2`).
- **Descriptive state machine** `cm2` reading `p11.temp`/`p11.voltage` and writing the derived attribute `cm2State` via `derivedWriteAttributes` (`cm2State := "charging"` on entering `charging`).
- **Predictive strategy** `pred1` with `lambdaPath`, inputs `p11.temp/voltage/current`, and two unbound outputs (`testr`, `testp`) that are persisted to the strategy's own table.
- **Prescriptive strategy** `prec1` with the same inputs, one output bound to `p12.charge` (send to actuator + shadow persist) and one unbound persisted output.

## General use rules

There are two user-facing zones. Which one a file belongs to is detected structurally via the import graph — no tags or annotations.

### 1. TwinModel

1. A Twin model has to import `TwinLibrary`.
2. A Twin model can import UserLibraries.
3. A Twin model may only import `TwinLibrary` and UserLibraries — nothing else.
4. In a TwinModel only redefinition (`:>>`), subsetting (`:>`), and typing (`:Type`) are allowed (see exception below).
5. Starting point is specializing/subsetting `Twin`.
6. No definitions are allowed — **exception:** a TwinModel may define **exactly one** `part def` that specializes `Twin` (e.g. `part def Battery :> Twin { … }`) so a Federation can reference/type against it. Only one such definition per TwinModel.
7. `Twin` may only be subsetted/redefined **once** per TwinModel — `part battery :> twin` and `part pv :> twin` in the same model is an error.

### 2. UserLibrary

1. Only definitions are allowed here — this is where users extend library elements.
2. A package is a UserLibrary when it imports `UserLibrary` (directly, or transitively only other UserLibraries).
3. A UserLibrary may only import `UserLibrary` itself or other UserLibraries — never anything from the base library directly.
4. Definitions are only allowed at package level, never nested inside another def.
5. Inside def bodies only `:>>`, `:>`, and `:Type` are permitted — no nested defs.
6. Feature-chain referencing between definitions is not allowed.