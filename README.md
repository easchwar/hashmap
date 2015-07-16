# MyHashMap
Lecture should cover principles of hashing.

## Phase 1: Set
A set is a  data structure that can store certain values, without 
any particular order, and no repeated values. Some useful aspects
of a set is that it has remarkably fast retrieval time, being able
to quickly determine the presence of values. 

### MaxIntSet
- Initialize with integer `max` to define the range
of integers that we're keeping track of.
- methods:
  - `insert`
  - `remove`
  - `include?`

### IntSet
- Starts to get interesting here. Still define the size of the
hash, but now instead of pointing to `true` or `false` it points to
an array.
- can now keep track of an arbitrary range of integers.

### ResizingIntSet
- The previous example suffers as N increases. Let's increase the number
of buckets as the size of the set increases. Goal is to have `buckets.length > N`
at all times.

## Phase 2: HashMap
Now let's store more than just integers. Let's store any data type in our Set.

### 2: Hashing
Hashing is a mathematical operation to return a fixed-length 
number from an arbitrary length sequence of characters. Need a (nearly)
unique hash for unique items, so need to compare each item in a string, 
or array.
- Write hash functions for Array, String, Hash
  - order is important for arrays and strings, not for hashes
    - keep track of indexes for arrays and strings
    - turn the hash into an array and then sort it before hashing to
      make it order agnostic

### MyHashSet
Simple improvement on ResizingIntSet. Just hash every item before
performing any operation on it. This will return an integer which can
then just be modulo'd by the number of buckets. Easy as pie.

### MyHashMap
Up until now, we couldn't store any associated values in our set. We
could only check if a given value had been inserted or not. Let's change
that.

#### Linked List
A linked list (throw a link in there for some background) is a data structure
which is consists of a series of nodes. Each node consists of a value and a pointer
to the next node. When referencing a linked list, all you have to do is point to 
the first (or root) node, and you can then access the entirety of the list simply by 
traversing the nodes.

Let's implement a Linked List for our hash buckets. Each node will need to contain a 
key and a value, so that we can store key-value pairs in the hash like we're used to. 
If you're struggling to implement this, think back to the TreeNode problems we did. 
Some useful methods:
- `insert(key, val)`
- `remove(key)`
- `include?(key)`
- `retrieve(key)`

#### Linked List Hash Buckets 
So now let's incorporate our linked lists into our hash buckets. Instead of having
each bucket be an array which we'll push items into, we'll have each bucket be 
a pointer to a linked list node. We'll define a root node for each bucket whose 
key and value will both be `nil`. When inserting or retrieving items, all we 
have to do is hash the key, and then call the corresponding method on the 
linked list our hash led us to.

## Phase 3: LRU Cache



