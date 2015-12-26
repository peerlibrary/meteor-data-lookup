class DataLookup
  @lookup: (obj, path) ->
    path = path.split '.' if _.isString path

    obj = obj() if _.isFunction obj

    return obj unless _.isArray path

    while path.length > 0
      segment = path.shift()
      if _.isObject(obj) and segment of obj
        obj = obj[segment]
        obj = obj() if _.isFunction obj
      else
        return undefined

    obj

  @get: (obj, path, equalsFunc) ->
    return @lookup obj, path unless Tracker.active

    result = new ComputedField =>
      @lookup obj, path
    ,
      equalsFunc

    result()
