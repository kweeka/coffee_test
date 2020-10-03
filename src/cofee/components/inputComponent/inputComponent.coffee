angular.module 'mainApp'
  .directive 'inputComponent', [() ->
    templateUrl: 'inputComponent.html'
    transclude: true,
    restrict: 'AE',
    scope: {
      placeholder: '=placeholder'
      value: '=value'
      errorField: '=error'
      type: '=type'
      change: '=change'
      readonlyDelete: '=readonlyDelete'
    }
    controller: ['$scope', '$filter', inputController = ($scope, $filter) ->
      $scope.type = $scope.type || "text"

    ]
]