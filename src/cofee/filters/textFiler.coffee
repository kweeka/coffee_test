angular.module 'mainApp'
  .filter 'concatArray', ->
    (arr) ->
      if not arr || arr.length == 0
        ''
      else
        arr.join(', ')
  .filter 'noticesNewCount', ->
    (arr) ->
      if arr
        result = []
        for item in arr
          if !item.read
            result.push(item)
        result.length
  .filter 'noticesReadCount', ->
    (arr) ->
      if arr
        result = []
        for item in arr
          if item.read
            result.push(item)
        result.length