AlgebraicDataType provides a structured way of modelling algebraic data types, also known as sum and product types.

For instance, in ML one might define a tree as

    type tree =
      Empty
      | Leaf of int
      | Node of tree list;;

or "a tree is either the Empty tree, a Leaf containing an integer, or a Node containing a list of trees."

An AlgebraicDataType in this library is an object that can decompose itself into an array (via `#unapply`), and may be constructed from the same. For instance,

    | applied created |
    applied := Tree apply: #(TreeNode #(Leaf 1) #(Leaf 2)).
    created := TreeNode left: (Leaf value: 1) right: (Leaf value: 2).
    applied = created.

Note that the above also demonstrates AlgebraicDataType subclasses use structural equality (although of course referential equalit - identity - is still available through `#==`).