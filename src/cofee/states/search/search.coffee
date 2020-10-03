angular.module 'mainApp'
  .config ["$stateProvider", "$locationProvider", "$urlRouterProvider",($stateProvider, $locationProvider, $urlRouterProvider) ->
    $stateProvider.state 'searchFormComponent',
      url: '/searchFormComponent'
      templateUrl: '../../components/searchFormComponent/searchFormComponent.html'
      controller: ['$scope', 'userService', '$state', 'storage', ($scope, userService, $state, storage) ->
        $scope.query = ''
        $scope.resultSearch = [];
        $scope.hide = false;
        $scope.search = () ->
          $scope.hide = true
          dateNow = new Date().getTime()
          userService.getAutocomplete([$scope.query], "en_US", 1)
            .then(success = (response) ->
              if response.data.items.length > 0 && response.data.items[0].autocomplete.length > 0
                $scope.resultSearch = response.data.items[0].autocomplete
                nowSearchHistory = {
                  query: $scope.query
                  date: dateNow
                  answer: $scope.resultSearch
                }
                userService.setHistorySearch(nowSearchHistory)
                  .then(success = (item) ->
                    storage.setHistorySearch(item)
                    console.log(storage.getHistorySearch())
                  error = (item) ->
                    console.log(item)
                  response
                )
            error = (response) ->
              console.log(response)
              response
          )
        $scope.showHistoryQuery = () ->
          $state.go('historyQueryComponent')
      ]
  ]