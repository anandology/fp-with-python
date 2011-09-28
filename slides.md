
# Functional Programming With Python

.fx: title-slide middle

<br/>

<p class="title-p">
    <a href="http://in.pycon.org/2011/" class="conf">PyCon India 2011</a>
    <br/>
    <span class="small">September 16, 2011</span>
</p>

<br/>
<br/>

<p class="title-p">
    <a class="author" href="http://anandology.com/">Anand Chitipothu</a>
    <br/>
    <a href="http://twitter.com/anandology" class="download-slides">@anandology</a>
</p>

<br/>
<br/>
<br/>

<a href="http://bit.ly/pycon-fp" class="download-slides">http://bit.ly/pycon-fp</a>

---


# Outline

* Getting Started
    * Functions
    * Lists
    * Dictionaries
    * List Comprehensions
* Recursion
* Higher-order functions
* Iterators & Generators
    * Iterators
    * Generators
    * Generator Expressions
    
With lot of interesting examples!

---

# Getting Started

---

## Functions

    !python
    >>> def square(x):
    ...     return x *x
    ... 
    >>> square(4)
    16

Functions can be assigned like any other objects.

    !python
    >>> f = square
    >>> f(4)
    16

They can be passed as arguments to other functions.

    !python
    >>> def fsum(f, x, y):
    ...     return f(x) + f(y)
    ... 
    >>> fsum(square, 3, 4)
    25
    
Anonymous functions can be created using the lambda operator.

    !python
    >>> fsum(lambda x: x*x, 3, 4)
    25
    
Functions can even return new functions. We'll see that later.

--- 

## Lists

Python has built-in support for lists.

    !python
    >>> [1, 2, 3, 4]
    [1, 2, 3, 4]
    >>> ["hello", "world"]
    ["hello", "world"]
    >>> [0, 1.5, "hello"]
    [0, 1.5, "hello"]

A List can contain another list as member.

    !python
    >>> a = [1, 2]
    >>> b = [1.5, 2, a]
    >>> b
    [1.5, 2, [1, 2]]
    
A list can contain even it self.

    !python
    >>> a = [1, 2]
    >>> a.append(a)
    >>> a
    [1, 2, [...]]
    
----

## Lists

Some operations on lists.

    !python
    >>> x = [5, 2, 3, 1]
    >>> len(x)
    5
    >>> 2 in x
    True
    >>> 4 in x
    False
    >>> x.sort()
    >>> x
    [1, 2, 3, 5]

The `sorted` function returns a new sorted list instead of modifying the original.

    !python
    >>> x = [5, 2, 3, 1]
    >>> sorted(x)
    [1, 2, 3, 5]
    
The `sorted` function and `sort` method can take a `key` function as argument.

    !python
    >>> x = ["a", "c", "D", "B"]
    >>> sorted(x)
    ['B', 'D', 'a', 'c']
    >>> sorted(x, key=lambda a: a.lower())
    ['a', 'B', 'c', 'D']
  
---  

## Dictionaries (1)

Dictionaries are like lists, but they can be indexed with non integer keys also. Unlike lists, dictionaries are not ordered.

    !python
    >>> a = {'x': 1, 'y': 2, 'z': 3}
    >>> a['x']
    1
    >>> a['z']
    3
    >>> a['zz']
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    KeyError: 'zz'
    >>> a.get('zz', 0)
    0

The `in` operator can be used to check if a key is present in the dictionary.

    !python
    >>> 'z' in a
    True
    >>> 'zz' in a
    False
    
---

## Dictionaries (2)

The `del` operator can be used to delete an item from a dictionary.

    !python
    >>> del a['x']
    >>> a
    {'y': 2, 'z': 3}
    >>> 'x' in a
    False

---

## Example: Word Frequency

Compute frequency of words in a given file.

Lets start with a function to count frequency of words, given a list of words.

    !python
    def word_frequency(words):
        """Returns frequency of each word given a list of words.

            >>> word_frequency(['a', 'b', 'a'])
            {'a': 2, 'b': 1}
        """
        frequency = {}
        for w in words:
            frequency[w] = frequency.get(w, 0) + 1
        return frequency

Getting words from a file is very easy.

    !python
    def read_words(filename):
        return open(filename).read().split()

---

## Example: Word Frequency

We can combine these two functions to find frequency of all words in a file.

    !python
    def main(filename):
        words = read_words(filename)
        frequency = word_frequency(words)
        for word, count in frequency.items():
            print word, count

    if __name__ == "__main__":
        import sys
        main(sys.argv[1])


---

## Exercises

* Write a program to count frequency of characters in a given file. 

* Write a function `invertdict` to interchange keys and values in a dictionary.
  For simplicity, assume that all values are unique.

        !python
        >>> invertdict({'x': 1, 'y': 2, 'z': 3})
        {1: 'x', 2: 'y', 3: 'z'}

* Write a program to find anagrams in a given list of words. Two words are
  called anagrams if one word can be formed by rearranging letters of another.
  For example "eat", "ate" and "tea" are anagrams.

        >>> anagrams(['eat', 'ate', 'done', 'tea', 'soup', 'node'])
        [['eat', 'ate', 'tea], ['done', 'node'], ['soup']]
    
---

## List Comprehensions (1)

List Comprehensions provide a concise way of creating lists.

Here are some simple examples for transforming a list.

    !python
    >>> a = range(10)
    >>> a
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

    >>> [x for x in a]
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

    >>> [x*x for x in a]
    [0, 1, 4, 9, 16, 25, 36, 49, 64, 81]

---

## List Comprehensions (2)


It is also possible to filter a list using `if` condition inside a list comprehension.

    !python
    >>> a = range(10)
    >>> [x for x in a if x%2 == 0]
    [0, 2, 4, 6, 8]
    >>> [x*x for x in a if x%2 == 0]
    [0, 4, 8, 36, 64]

---

## List Comprehensions (3)
    
We can even use multiple ``for``s in single list comprehension.

    !python
    >>> [(x, y) for x in range(5) for y in range(x) if (x+y)%2 == 0]
    [(2, 0), (3, 1), (4, 0), (4, 2)]

Same as above, indented for clarity.

    !python
    >>> [(x, y) 
    ...     for x in range(5) 
    ...     for y in range(x) 
    ...     if (x+y)%2 == 0]
    ...
    [(2, 0), (3, 1), (4, 0), (4, 2)]
    
---

## Exercises

* Write a function `mutate` to compute all words generated by a single mutation on
a given word. A mutation is defined as inserting a character, deleting a
character, replacing a character, or swapping 2 consecutive characters in a
string. For simplicity consider only letters from a to z.

        !python
        >>> words = mutate('hello')
        >>> 'helo' in words
        True
        >>> 'yello' in words
        True
        >>> 'helol' in words
        True

* Write a function `nearly_equal` to test whether two strings are nearly equal.
Two strings a and b are nearly equal when a can be generated by a single
mutation on b.

        !python
        >>> nearly_equal('python', 'perl')
        False
        >>> nearly_equal('python', 'jython')
        True
        >>> nearly_equal('man', 'woman')
        False
        
----

# Recursion


Defining solution of a problem in terms of the same problem, typically of smaller size, is called recursion.

Recursion makes it possible to express solution of a problem very concisely and elegantly.

--- 

<!--

## Hofstadter's Law

"It always takes longer than you expect, even when you take into account Hofstadter's Law."

-->

## Example: Computing Exponent

    !python
    def exp(x, n):
        """Computes the result of x raised to the power of n."""
        if n == 0:
            return 1
        else:
            return x * exp(x, n-1)

### Execution Pattern:

    exp(2, 4)
    +-- 2 * exp(2, 3)
    |       +-- 2 * exp(2, 2)
    |       |       +-- 2 * exp(2, 1)
    |       |       |       +-- 2 * exp(2, 0)
    |       |       |       |       +-- 1
    |       |       |       +-- 2 * 1
    |       |       |       +-- 2
    |       |       +-- 2 * 2
    |       |       +-- 4
    |       +-- 2 * 4
    |       +-- 8
    +-- 2 * 8
    +-- 16

---
## Example: Computing Exponent (2)
Faster implementation of exponent function.

    !python
    def fast_exp(x, n):
        if n == 0:
            return 1
        elif n % 2 == 0:
            return fast_exp(x*x, n/2))
        else:
            return x * fast_exp(x, n-1)
            
### Execution Pattern:

    fast_exp(2, 10)
    +-- fast_exp(4, 5) # 2 * 2
    |   +-- 4 * fast_exp(4, 4)
    |   |       +-- fast_exp(16, 2) # 4 * 4
    |   |       |   +-- fast_exp(256, 1) # 16 * 16
    |   |       |   |   +-- 256 * fast_exp(256, 0)
    |   |       |   |             +-- 1
    |   |       |   |   +-- 256 * 1
    |   |       |   |   +-- 256
    |   |       |   +-- 256
    |   |       +-- 256
    |   +-- 4 * 256
    |   +-- 1024
    +-- 1024
    1024

----

## Exercise: Factorial

The following function computes factorial of a number. 

    !python
    def fact(n):
        if n == 0:
            return 1
        else:
            return n * fact(n-1)

It looks quite similar to our `exp` function. Can you improve the execution
time of this program by writing a `fast_fact` function? If not, explain why?

---

## Example: Fibonacci Number

The sequence F(n) of Fibonacci numbers is defined by the recurrence relation:

    F(n) = F(n-1) + F(n-2)
    F(0) = 0 
    F(1) = 1

And here is the Python version:

    !python
    def fib(n):
        if n == 0 or n == 1:
            return 1
        else:
            return fib(n-1) + fib(n-2)
    
### Execution Pattern:

                         fib(4)
                 +---------+--------+
                 |                  |
               fib(3)             fib(2)     
           +-----+-----+         +---+---+   
        fib(2)       fib(1)      |       |   
       +---+---+       |       fib(1)  fib(0)
       |       |       1         |       |
     fib(1)  fib(0)              1       1   
       |       |
       1       1

----

## Example: Count Change

How many different ways can we make change of 50 using coins of denomination 50, 25, 10 and 5?

    50
    25 + 25
    25 + 10 + 10 + 5
    25 + 10 + 5 + 5 + 5
    25 + 5 * 5
    5 * 10
    4 * 10 + 2 * 5
    3 * 10 + 4 * 5
    2 * 10 + 6 * 5
    1 * 10 + 8 * 5
    10 * 5

11 ways.

What will be the number if we also have coin of denomination 1? Can we write a program to compute that?

----

## Example: Count Change (2)

The number of ways to change amount `A` is equal to:

* the number of ways to change amount `A` using all but the largest coin, plus
* the number of ways to change amount `A - D` using all kinds of coins, where `D` is the denomination of the largest kind of coin.

---

## Example: Count Change (3)

    !python
    def count_change(amount, coins):
        """Counts the number ways in which amount can be made using the provided coins.
    
        Assumes that the coins are sorted in desceding order.
        """
        if amount < 0:
            return 0
        elif amount == 0:
            return 1
        elif not coins:
            return 0
        else:
            return count_change(amount-coins[0], coins) + \
                count_change(amount, coins[1:])

Lets try some examples.

    >>> count_change(50, [50, 25, 10, 5])
    11
    >>> count_change(50, [50, 25, 10, 5, 1])
    50
    >>> count_change(100, [50, 25, 10, 5, 1])
    292
    >>> count_change(200, [50, 25, 10, 5, 1])
    2435
    >>> count_change(200, [50, 25, 10, 5, 2, 1])
    58030

---


# Higher Order Functions

Functions that take functions as arguments or return other functions.

---

## Example: Tracing Function Calls

Consider the earlier fibonacci example.

    !python
    def fib(n):
        if n == 0 or n == 1:
            return 1
        else:
            return fib(n-1) + fib(n-2)
            
Can we write a higher-order function to trace the execution of this function?

---

## Example: Tracing Function Calls (2)

Here is the first attempt.

    !python
    def trace(f):
        def g(x):
            print f.__name__, x
            value = f(x)
            print 'return', repr(value)
            return value
        return g

    fib = trace(fib)
    print fib(3)

Output:

    fib 3
    fib 2
    fib 1
    return 1
    fib 0
    return 1
    return 2
    fib 1
    return 1
    return 3
    3
---

## Example: Tracing Function Calls (3)
Lets try to pretty print the call log.

    !python
    level = 0
    def trace(f):
        def g(*args):
            global level
            indent = '|   ' * level + '|-- '
            
            argstr = ", ".join([repr(a) for a in args])
            print indent + f.__name__ + argstr
            
            level += 1
            value = f(*args)
            level -= 1
            
            print indent + ' return ' + repr(value)
            return value
        return g
    

---
## Example: Tracing Function Calls (4)

Lets try our `fib` example.

    !python
    fib = trace(fib)
    print fib(4)

Output:

    >>> print fib(4)
    |-- fib(4)
    |   |-- fib(3)
    |   |   |-- fib(2)
    |   |   |   |-- fib(1)
    |   |   |   |   |-- return 1
    |   |   |   |-- fib(0)
    |   |   |   |   |-- return 1
    |   |   |   |-- return 2
    |   |   |-- fib(1)
    |   |   |   |-- return 1
    |   |   |-- return 3
    |   |-- fib(2)
    |   |   |-- fib(1)
    |   |   |   |-- return 1
    |   |   |-- fib(0)
    |   |   |   |-- return 1
    |   |   |-- return 2
    |   |-- return 5
    5

---
## Example: Tracing Function Calls (5)

This can be very useful debugging tool.

    !python
    @trace
    def square(x):
        return x*x

    @trace
    def sum_of_squares(x, y):
        return square(x) + square(y)

    print sum_of_square(3, 4)

Output:

    |-- sum_of_squares(3, 4)
    |   |-- square(3)
    |   |   |-- return 9
    |   |-- square(4)
    |   |   |-- return 16
    |   |-- return 25
    25

---

## Example: memoize

* How can we get rid of the redundant computation in our `fib` function? 
* How about caching the return values?

Doing this is very popular in functional programming world and it is called `memoize`.

    !python
    def memoize(f):
        cache = {}
        def g(x):
            if x not in cache:
                cache[x] = f(x)
            return cache[x]
        return g

    fib = trace(fib)
    fib = memoize(fib)
    print fib(4)

---
## Example: memoize (2)

Output:

    |-- fib(4)
    |   |-- fib(3)
    |   |   |-- fib(2)
    |   |   |   |-- fib(1)
    |   |   |   |   |-- return 1
    |   |   |   |-- fib(0)
    |   |   |   |   |-- return 1
    |   |   |   |-- return 2
    |   |   |-- return 3
    |   |-- return 5
    5

Notice that the redundant computation is gone now.

---

## Exercices

* Write a function profile, which takes a function as argument and returns a
  new function, which behaves exactly similar to the given function, except
  that it prints the time consumed in executing it.

        !python
        >>> fib = profile(fib)
        >>> fib(20)
        time taken: 0.1 sec
        10946

* Write a function `vectorize` which takes a function `f` and returns a new
  function, which takes a list as argument and calls f for every element and
  returns the result as a list.
  
        !python
        >>> def square(x): return x * x
        ...
        >>> f = vectorize(square)
        >>> f([1, 2, 3])
        [1, 4, 9]
        >>> g = vectorize(len)
        >>> g(["hello", "world"])
        [5, 5]

---

# Iterators & Generators

---

## Iterators

Iterators are special objects that can be iterated through.

    !python
    >>> x = iter([1, 2, 3])
    >>> x
    <listiterator object at 0x1004ca850>
    >>> x.next()
    1
    >>> x.next()
    2
    >>> x.next()
    3
    >>> x.next()
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    StopIteration
    
---

## Example: yrange

Iterators can be implemented as classes. Here is an iterator that works like `xrange`.

    !python
    class yrange:
        def __init__(self, n):
            self.i = 0
            self.n = n
            
        def __iter__(self):
            return self
        
        def next(self):
            if self.i < self.n:
                i = self.i
                self.i += 1
                return i
            else:
                raise StopIteration()

---

## Example: yrange

Lets see it working:

    !python
    >>> y = yrange(3)
    >>> y.next()
    0
    >>> y.next()
    1
    >>> y.next()
    2
    >>> y.next()
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
      File "<stdin>", line 14, in next
    StopIteration

Many built-in functions accept iterators as arguments.

    >>> list(yrange(3))
    [0, 1, 2]

---

## Generators

Generators simplifies creation of iterators.

    !python
    def yrange(n):
        i = 0
        while i < n:
            yield i
            i += 1

Lets try it out.

    !python
    >>> y = yrange(3)
    >>> y.next()
    0
    >>> y.next()
    1
    >>> y.next()
    2
    >>> y.next()
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
      File "<stdin>", line 14, in next
    StopIteration

    >>> list(yrange(3))
    [0, 1, 2]

---

## More Generators
        
    !python
    def integers():
        i = 1
        while True:
            yield i
            i = i + 1
            
    def squares():
        for i in integers():
            yield i * i
            
    def take(n, seq):
        """Returns first n values from the given sequence."""
        seq = iter(seq)
        result = []
        try:
            for i in range(n):
                result.append(seq.next())
        except StopIteration:
            pass
        return result

Lets try it.

    !python
    >>> take(5, squares())
    [1, 4, 9, 16, 25]

---

## Generator Expressions

Generator expressions take generators to the next level.

See improved versions of `squares` and `take` functions using generator expressions.
    
    !python
    def integers():
        i = 1
        while True:
            yield i
            i = i + 1

    def squares():
        return (i*i for i in integers())

    def take(n, seq):
        seq = iter(seq)
        return list(seq.next() for i in range(n))

See it in action.

    !python
    >>> take(5, squares())
    [1, 4, 9, 16, 25]
    
<!--


# The eight-queen puzzle

Here is a brute-force solution to eight-queen puzzle.

    !python
    from itertools import permutations
 
    n = 8
    cols = range(n)
    for vec in permutations(cols):
        if (n == len(set(vec[i]+i for i in cols))
              == len(set(vec[i]-i for i in cols))):
            print vec

Credit: https://secure.wikimedia.org/wikipedia/en/wiki/Eight_queens_puzzle

-->

---
# Questions?

