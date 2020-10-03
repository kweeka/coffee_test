angular.module 'mainApp'
  .directive 'noticeComponent', ->
    templateUrl: 'noticeComponent.html'
    transclude: true,
    restrict: 'AE',
    scope: {
      noticeStorage: '='
    }
    controller: ['$scope', 'noticeService', '$state', 'noticeStorage', '$interval', '$timeout',($scope, noticeService, $state, noticeStorage, $interval, $timeout) ->



      this.$onInit = () ->
        console.log(34)

        ###if localStorage.getItem("noticesDate")
          $scope.data = JSON.parse(localStorage.getItem('noticesDate'))
        else
          $scope.data = [
            {
              data: [
                {
                  id: 1
                  topic: "Today 01/10/20"
                  text: "The weather today is sunny"
                  date: new Date()
                  from: "Me"
                  read: true
                }
                {
                  id: 2
                  topic: "Today 01/10/20"
                  text: "The weather today is sunny"
                  date: new Date()
                  from: "Me"
                  read: true
                }
              ]
              countNewNotices: 0
              countReadNotices: 2
            }
          ]
        if localStorage.getItem("authToken")
          $interval(() ->
            noticeService.setNotice($scope.data)
              .then(success = (response) ->
                console.log(response)
                noticesArr = []
                for notice in response[0].data
                  noticesArr.push(new Notice(notice.id, notice.topic, notice.text, new Date(), notice.from, notice.read))
                noticeStorage.setNotices(noticesArr)
                noticeStorage.setCountNewNotices(response[0].countNewNotices)
                noticeStorage.setCountReadNotices(response[0].countReadNotices)
                console.log(noticeStorage)
                $timeout(() ->
                  $scope.noticeStorage = noticeStorage
                  for item in  $scope.noticeStorage.notices
                    if !item.read
                      alert("You have new notice from " + item.from)
                , 0)
              error = (response) ->
                console.log(response)
                response
            )
          , 10000)
        else###
        null


      null
    ]