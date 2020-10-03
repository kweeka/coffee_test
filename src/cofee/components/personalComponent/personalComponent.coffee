angular.module 'mainApp'
  .directive 'personalComponent', ->
    transclude: true
    scope: {}
    bindToController: true


