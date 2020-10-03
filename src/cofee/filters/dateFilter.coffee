angular.module 'mainApp'
  .filter 'dateFilter', ->
    (dateMs) ->
      new Date(dateMs).toLocaleString()
  .filter 'dateFilterDDMMYY', ->
    (dateMs) ->
      options = {
        day: 'numeric'
        month: 'numeric'
        year: 'numeric'
      }
      new Date(dateMs).toLocaleString('en-GB', options)