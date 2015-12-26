data lookup
===========

This Meteor smart package provides a reactive lookup of a field in the object.
It matches the behavior of the lookup in Spacebars, so `{{foo.bar}}` resolves
the same as `DataLookup.get(dataContext, 'foo.bar')`.

Adding this package to your [Meteor](http://www.meteor.com/) application adds `DataLookup` class
into the global scope.

Both client and server side.

Installation
------------

```
meteor add peerlibrary:data-lookup
```

API
---

`DataLookup` provides the following static methods:

* `lookup(obj, path)` – resolves the value by traversing the `obj` object using the `path`; if `path` is
  a string, it is first split on `.`; if a value is not found, `undefined` is returned; if any value on
  path is a function, it is first called
* `get(obj, path, equalsFunc)` - same as `lookup`, but if called inside a reactive computation, it uses
  [ComputedField](https://github.com/peerlibrary/meteor-computed-field) to minimize invalidations so that the
  reactive computation is invalided only when the value looked up itself changes, and not every time the input object
  changes; you can use `equalsFunc` to use a different equality function to determine when the value has changed
