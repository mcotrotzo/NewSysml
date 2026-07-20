Use of Library Rules whcih will resolve in Validation Rules in the Java Tool:

1. When you subset or redefine a feature, the number of children targeting that same library feature must stay within its declared multiplicity bounds (default 1..1 if unspecified).
2. The tool only considers elements which resolve, through the subsets/redefines/defines/classifies chain, up to a library element — non-library features are irrelevant for the tool
3. If the target feature has multiplicity 1..1, subsetting (:>) creates a new, independent feature constrained to be a subset of the target. In the materialized model, this adds a separate entry alongside the (unmodified) target.
4. If the target feature has multiplicity >1 (a collection), both subsetting and redefinition behave the same way for materialization: each occurrence (pos1, pos2, ...) becomes its own separate entry, representing one slot within the collection — neither relation replaces or exhausts the whole collection.