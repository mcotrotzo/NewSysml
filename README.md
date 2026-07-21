Library Rules:
# Specialication and Multiplciity
1. The sum of children targeting a subsetted/redefined feature must stay within its declared/      
   inherited multiplicity bounds.
   1. Subsetting: sum of the parent's own binding (if it has one) + the multiplicities of all subsetting children. 
   2. Redefinition: sum of only the redefining children (the parent's own binding is dropped/replaced).
2. This resulting pool becomes the materialized content of the subsetted/redefined feature.
3. Only elements that specialize a library feature (via the subsets/redefines/defines/classifies    
   chain) are considered by the tool.
4. Multiple typing of libray elemets is not allows for example <any typed feature:TwinBoolean,TwinReal>

# The TwinTypeSystem
- TwinAttribute 
- TwinBoolean e.g true,false, new TwinBoolean(true) 
- TwinString e.g "Hel",new TwinString("HEl")
- TwinReal
- TwinInteger
- Twin(Integer,Real,Boolean,Attribute)[x..y] are considered as lists
When using the library the user can create <custom Attributes> by subclassifing TwinAttribute.

# Actions and Calcs
For calculations user can create their own functions by subclassifing CustomCalculationAction.
Calculations which subclassifies CustomCalculationAction shoud be pure with no sideeffects and can use the following:
- If <TwinBoolean> then <action> else <action>
- While <condition> {<action>}
- For <twinAttribute>:Type of <TwinAttribute> in {<TwinAttribute[x..y]>} { <action>}
- Assigns <TwinAttribute> := <TwinAttribute>/<new Attribute()>*
- first <action> then <action> ...

On each place where a twinAttribute is expected to assign, or bind it you can use also <Calculations>. You can never place calculation as usages. For example <calc test:Plus_real>
Calculations can only be used with calling. <Plus_real()>



<action> has to be a Assign action like descripde in *
<TwinAttribute> has to be a type of TwinAttribute. On the right side of a assign you can alsop use the provided Calculations or your own defined functions, which subclassfies CustomCalculationAction


State Machine

Aswell physical twin can have state machines(for the control unit) also descriptive state machine
Here we also have restrictions:
- Each <state> has to be a type of State
- Each <state> can have a entryAction,doAction,exitAction
- Each <state> can have <localAttributes> which are a type of TwinAttribute
  - All actions of a <state> has to be  a Assign action like descripde in *. 
- A transition can have only 
  - if <TwinBoolean>
  - first <state>
  - <optional>
    - if <TwinBoolean>
    - do <action>
  - then <state>;

Again
<action> has to be a Assign action like descripde in *
<TwinBoolean> here can be a simple boolean or also a expression which can be either again own custom functions or the provided one



Additonal rules.

All defs has to be on Packagelevel. You can define it on other files and import it but never create definitions within other elements.


