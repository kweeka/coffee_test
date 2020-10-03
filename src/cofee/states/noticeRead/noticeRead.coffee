angular.module 'mainApp'
  .config ["$stateProvider", "$locationProvider", "$urlRouterProvider", ($stateProvider, $locationProvider, $urlRouterProvider) ->
    $stateProvider.state 'notice.read',
      url: '/read'
      templateUrl: '../../components/noticeReadComponent/noticeReadComponent.html'
      params: {
        id: null
      }
      controller: ['$scope', 'noticeService', '$state', 'noticeStorage', '$interval', '$timeout', '$stateParams',($scope, noticeService, $state, noticeStorage, $interval, $timeout, $stateParams) ->
        this.$onInit = () ->
          $timeout(() ->
            $scope.noticeStorage = noticeStorage
            $scope.notice = $stateParams.id
            console.log($stateParams.id)
          )
          null

        null

      ]
  ]