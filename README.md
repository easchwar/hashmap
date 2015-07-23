# MyHashMap
Lecture should cover principles of hashing.

## Phase 1: Set
A set is a data structure that can store certain values, without 
any particular order, and no repeated values. Sets have remarkably 
fast retrieval time, being able to quickly determine the presence 
of values. 

### MaxIntSet
- Initialize with integer `max` to define the range
of integers that we're keeping track of.
- internal structure:
  - array of length `max`
  - index corresponds to item, value corresponds to presence (either true
  or false)
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
- Also, let's implement a simple `inspect` method to make debugging
easier.

**Code Review**

## Phase 2: HashMap
Now let's store more than just integers. Let's store any data type in our Set.

### 2: Hashing
Hashing is a mathematical operation to return a fixed-length 
number from an arbitrary length sequence of characters. Need a (nearly)
unique hash for unique items, so need to account foeach item in a string, 
or array.
- Write hash functions for Array, String, Hash
  - order is important for arrays and strings, not for hashes
    - keep track of indexes for arrays and strings
    - turn the hash into an array and then sort it before hashing to
      make it order agnostic

### MyHashSet
Simple improvement on ResizingIntSet. Just hash every item before
performing any operation on it. This will return an integer which can
then just be modulo'd by the number of buckets. Now your set can handle
keys of any data type. Easy as pie.

### MyHashMap
Up until now, we couldn't store any associated values in our set. We
could only check if a given value had been inserted or not. Let's change
that. But first, we're going to make a slight improvement in our underlying
data structure.

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

**Code Review**
## Phase 3: LRU Cache
By now, you should have a working hashmap with 100% hash functionality. Let's upgrade
to make an LRU Cache. LRU stands for Least Recently Updated. See here for an 
explanation.

If this sounds confusing, that's alright. Here are the basic principles that you 
need to know:
- The cache can only hold `max` items (it should be initialized with this number).
- When retrieving an item, set it to be the most recently updated item.
- When inserting an item, if the cache would exceed size `max`, delete the least 
  recently accessed item.

General strategy:
Instead of having the `value` of each hash node simply store the value, `value` 
should point to a node in another linked list. The value associated with the key
will actually be the `value` of this node. We'll call this list the LRU list. 
Every time the cache "hits" a node in its bucket, it should access the node in 
the LRU list, and move it to the front. If an action puts the size over `max`, 
the cache should remove the node at the end of the LRU list.

Tips:
- The LRU list will probably differ enough from your cache's bucket linked list
that it's worth making a new class.
  - The LRU list should be doubly linked (that is, each node points to the nodes
  before and after it) in order to easily remove the last item.
- After removing the least recently accessed node from the LRU list, be 
sure to physically remove it from the cache as well. Otherwise the cache will
continue to track it, despite it having been removed from the LRU list.

## Phase 4: enumerable methods
