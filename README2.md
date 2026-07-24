| Rule | Subsetting (`:>`) | Redefinition (`:>>`) |
|---|---|---|
| **Target** | Any feature (chains and unrelated types allowed). | Only a directly inherited feature (no chains, no unrelated types). |
| **Multiplicity** | Sum of all subsets must be ≤ the upper bound *and* ≥ the lower bound of `y`. | Must stay within the bounds of the original feature. |
| **Frequency** | Multiple subsets allowed. | Only one redefinition per feature. |
| **Semantics** | Values of `x` are a subset of `y`. | `x` replaces `y` in the subtype. |