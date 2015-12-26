class BasicTestCase extends ClassyTestCase
  @testName: 'data-lookup - basic'

  testBasic: ->
    @assertEqual DataLookup.lookup({}, 'foo'), undefined
    @assertEqual DataLookup.lookup(null, 'foo'), undefined
    @assertEqual DataLookup.lookup(undefined, 'foo'), undefined
    @assertEqual DataLookup.lookup(1, 'foo'), undefined

    @assertEqual DataLookup.lookup({}), {}
    @assertEqual DataLookup.lookup(null), null
    @assertEqual DataLookup.lookup(undefined), undefined
    @assertEqual DataLookup.lookup(1), 1

    @assertEqual DataLookup.lookup({}, ''), undefined
    @assertEqual DataLookup.lookup(null, ''), undefined
    @assertEqual DataLookup.lookup(undefined, ''), undefined
    @assertEqual DataLookup.lookup(1, ''), undefined

    @assertEqual DataLookup.lookup({}, []), {}
    @assertEqual DataLookup.lookup(null, []), null
    @assertEqual DataLookup.lookup(undefined, []), undefined
    @assertEqual DataLookup.lookup(1, []), 1

    @assertEqual DataLookup.lookup({foo: 'bar'}, 'foo'), 'bar'
    @assertEqual DataLookup.lookup({foo: {bar: 'baz'}}, 'foo'), {bar: 'baz'}
    @assertEqual DataLookup.lookup({foo: {bar: 'baz'}}, 'faa'), undefined
    @assertEqual DataLookup.lookup({foo: {bar: 'baz'}}, 'foo.faa'), undefined
    @assertEqual DataLookup.lookup({foo: {bar: 'baz'}}, 'foo.bar'), 'baz'
    @assertEqual DataLookup.lookup({foo: null}, 'foo.bar'), undefined
    @assertEqual DataLookup.lookup({foo: null}, 'foo'), null

    @assertEqual DataLookup.lookup((-> {foo: {bar: 'baz'}}), 'foo'), {bar: 'baz'}
    @assertEqual DataLookup.lookup({foo: -> {bar: 'baz'}}, 'foo'), {bar: 'baz'}
    @assertEqual DataLookup.lookup((-> {foo: -> {bar: 'baz'}}), 'foo.bar'), 'baz'

  testReactive: ->
    testVar = new ReactiveVar null
    runs = []

    @autorun (computation) =>
      runs.push DataLookup.get =>
        testVar.get()
      ,
        'foo.bar'

    @assertEqual runs, [undefined]
    runs = []

    testVar.set 'something'
    Tracker.flush()

    @assertEqual runs, []
    runs = []

    testVar.set {foo: {test: 'baz'}}
    Tracker.flush()

    @assertEqual runs, []
    runs = []

    testVar.set {foo: {bar: 'baz'}}
    Tracker.flush()

    @assertEqual runs, ['baz']
    runs = []

    testVar.set {foo: {bar: 'baz', test: 'baz'}}
    Tracker.flush()

    @assertEqual runs, []
    runs = []

    testVar.set {foo: {test: 'baz'}}
    Tracker.flush()

    @assertEqual runs, [undefined]
    runs = []

    testVar.set {foo: {bar: 'baz', test: 'baz'}}
    Tracker.flush()

    @assertEqual runs, ['baz']
    runs = []

    testVar.set {foo: {bar: 'bak', test: 'baz'}}
    Tracker.flush()

    @assertEqual runs, ['bak']
    runs = []

    testVar2 = new ReactiveVar null

    testVar.set {foo: => testVar2.get()}
    Tracker.flush()

    @assertEqual runs, [undefined]
    runs = []

    testVar2.set {bar: 'bak', test: 'baz'}
    Tracker.flush()

    @assertEqual runs, ['bak']

ClassyTestCase.addTest new BasicTestCase()
