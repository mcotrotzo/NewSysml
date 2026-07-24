# Subject: Follow-up — multiplicity checking gaps for subsetting/redefinition, and `size()` semantics on unbound redefinitions

Hello to the community,

I've been running a series of small tests to understand exactly which multiplicity checks the Pilot performs, and I want to make sure I understand the current behavior correctly before asking my real question.

## What I've confirmed so far (redefinition checks both bounds, subsetting only checks the upper bound)

```sysml
part def Battery {
    part p11 [3];
}
part def Test :> Battery {
    g[4] :>> p11;   // WARNING: Subsetting/redefining feature should not have larger multiplicity upper bound
}
```

```sysml
part def Test :> Battery {
    g[1] :>> p11;   // WARNING: Redefining feature should not have smaller multiplicity lower bound
}
```

```sysml
part def Test :> Battery {
    g[4] :> p11;   
}
part def Test :> Battery {
    g[1] :> p11;   
}
```
So for **redefinition** (`:>>`), both the lower and upper bound are checked against the target's declared bounds. For **subsetting** (`:>`), only the upper bound seems to be checked:


```sysml
part def Battery {
    part p11 [3];
}
part def Test :> Battery {
    g[3] :>> p11;
    g[3] :>> p11; 
    g[3] :>> p11;    
```
This is interesting it works for both redefining and subsetting. Why is this valid? Because Battery said i should only have 3 p11. But now test has 9. 


## Question 1 — `size()` on an unbound redefinition

```sysml
private import SequenceFunctions::size;

part def Battery {
    part p11 [3];
}
part def Test :> Battery {
    g[3] :>> p11;   // no own value assignment
}
part test4 : Test;
attribute gggt = size(test4.g);
```

`size(test4.g)` evaluates to **1** — not 3 (the declared multiplicity) and not whatever `p11` itself might resolve to. Is this because an unbound redefined feature is treated as a single symbolic Usage element when referenced as a sequence, rather than resolving to any inherited value or to an empty sequence? I'd like to understand the underlying semantics here, since `SequenceFunctions::size` itself is just a straightforward recursive count — so the "1" must come from how the feature reference itself evaluates as a sequence, not from `size()`.

## Question 2 — bounds not checked at value assignment

```sysml
part def Battery {
    part p11 [3];
}
part def Test :> Battery {
    g[3] :>> p11 = (2,3,5,7);   // 4 literal values, but g is declared [3]
}
```

This compiles without any warning, and `size(test4.g)` correctly returns 4 — so the literal sequence itself is evaluated correctly, but its length is never checked against `g`'s declared multiplicity `[3]`. I even reproduced this with a plain top-level attribute, no redefinition involved:

```sysml
attribute p12 : ScalarValues::Integer = (2,3,5,7);   // implicit [1..1], 4 values, no error
```

Is the length of a directly assigned literal sequence simply never checked against the feature's declared (or inherited) multiplicity bound? Or is there a check I'm missing that would explain why this passes silently?

Thanks again for your time — these edge cases matter a lot for us, since we're building a validation tool and need to know precisely which structural checks we can rely on and which ones we have to implement ourselves.

Best,
Marco
