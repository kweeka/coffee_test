angular.module 'mainApp'
  .config ["$stateProvider", "$locationProvider", "$urlRouterProvider",($stateProvider, $locationProvider, $urlRouterProvider) ->
    $stateProvider.state 'notice',
      url: '/notice'
      templateUrl: '../../components/noticeRootComponent/noticeRootComponent.html'
      controller: ['$scope', 'noticeService', '$state', 'noticeStorage', '$interval', '$timeout',($scope, noticeService, $state, noticeStorage, $interval, $timeout) ->

        this.$onInit = () ->
          if localStorage.getItem("authToken")
            $timeout(() ->
              noticeService.getNotice()
              .then(success = (response) ->
                noticesArr = []
                for notice in response
                  noticesArr.push(new Notice(notice.id, notice.topic, notice.text, notice.date, notice.from, notice.read))
                noticeStorage.setNotices(noticesArr)
                localStorage.setItem('notices', JSON.stringify(noticesArr))
                $timeout(() ->
                  $scope.noticeStorage = noticeStorage
                  for item in  $scope.noticeStorage.notices
                    if !item.read
                      console.log(item)
                ,0)
              error = (response) ->
                console.log(response)
                response
              )
            , 0)

          else
            null

        null
      ]
  ]