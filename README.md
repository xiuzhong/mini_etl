How to run:
==========
The application doesn't have any other dependencies than Ruby (no particular version requiremet, I tested on 2.7.4)
```
# in project directory
cat input_file | ruby etl.rb
```

How to run test:
================
The repo includes 4 sample inputs/outputs in `test/fixtures` directory, which can be tested as below:
```
# in project directory
ruby test/test.rb
```

Notes of the implementation:
============================
- A tree structure is used to store the items and relationship between them. When all inputs are processed, the tree should be complete (no orphan, no circle etc). Once the tree structure is set up, he output is simply traversing the tree and dumping each node (by considering the depeth of the node).
- A Hash is used to enable the quick access to the item by its id, this is useful in finding the parent item by id. This is necessary because:
  - we can't traverse the tree to find the parent, the tree is not complete in the middle of input processing
  - tree traversal is way slower than Hash/Map
- the time and space complexities are linear.
