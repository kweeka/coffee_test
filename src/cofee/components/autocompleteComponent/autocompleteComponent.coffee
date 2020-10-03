angular.module 'mainApp'
  .directive 'autocompleteComponent', [() ->
    templateUrl: 'autocompleteComponent.html'
    restrict: 'AE'
    transclude: true
    scope: {
      hide: '='
      check: '='
      words: '='
    }
    controller: ['$scope', '$timeout', autocompleteController = ($scope, $timeout) ->
      $scope.hiden = $scope.hide

      $scope.select = (word) ->
        $timeout((() ->
          $scope.hide = false
          $scope.check = word
          $scope.words = []
          $scope.$digest()
          ), 0)
    ]
  ]
