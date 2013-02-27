AlgebraicDataType provides a structured way of modelling algebraic data types, also known as sum and product types.

For instance, in ML one might define a tree as
````ml
type tree =
  Empty
  | Leaf of int
  | Node of tree list;;
````
or "a tree is either the Empty tree, a Leaf containing an integer, or a Node containing a list of trees."

An AlgebraicDataType in this library is an object that can decompose itself into an array (via `#unapply`), and may be constructed from the same. For instance,
````smalltalk
| applied created |
applied := Tree apply: #(TreeNode #(Leaf 1) #(Leaf 2)).
created := TreeNode left: (Leaf value: 1) right: (Leaf value: 2).
applied = created.
````
Note that the above also demonstrates AlgebraicDataType subclasses use structural equality (although of course referential equality - identity - is still available through `#==`).

Copyright (C) 2012 by Frank Shearar

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
