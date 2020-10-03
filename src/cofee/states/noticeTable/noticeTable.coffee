angular.module 'mainApp'
  .config ["$stateProvider", "$locationProvider", "$urlRouterProvider",($stateProvider, $locationProvider, $urlRouterProvider) ->
    $stateProvider.state 'notice.table',
      url: '/table'
      templateUrl: '../../components/noticeTableComponent/noticeTableComponent.html'
      controller: ['$scope', 'noticeService', '$state', 'noticeStorage', '$interval', '$timeout',($scope, noticeService, $state, noticeStorage, $interval, $timeout) ->
        this.$onInit = () ->
          $timeout(() ->
            $scope.noticeStorage = noticeStorage
          )
          null

        $scope.readNotice = (notice) ->
          notice.read = true
          noticeService.changeNotice(notice.id)
          .then(success = (res) ->
            if res
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
          error = (res) ->
            console.log(res)
            res
          )

        null

      ]
  ]