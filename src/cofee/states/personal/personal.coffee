angular.module 'mainApp'
  .config ["$stateProvider", "$locationProvider", "$urlRouterProvider",($stateProvider, $locationProvider, $urlRouterProvider) ->
    $stateProvider.state 'personal',
      url: '/personal'
      templateUrl: '../../components/personalComponent/personalComponent.html'
      controller: ['$scope', 'userService', '$state', 'storage', 'validationAuth', '$timeout', ($scope, userService, $state, storage, validationAuth, $timeout) ->
        $scope.readonlyDelete = true
        $scope.checkedGroups = []
        $scope.showChandeGroup = false
        $scope.userData = {}
        $scope.userDataErr = {}

        $scope.changeName = (value) ->
          $scope.userDataErr.name = validationAuth.validationName(value)

        $scope.changePassword = (value) ->
          $scope.userDataErr.password = validationAuth.validationPassword(value)

        $scope.changePasswordAgain = (value) ->
          $scope.userDataErr.passwordAgain = validationAuth.validationPassword(value, $scope.userData.password)

        $scope.cancel = () ->
          $scope.userData.name = storage.user.name
          $scope.userData.group = storage.user.group
          $scope.userData.password = ''
          $scope.userData.passwordAgain = ''
          $scope.readonlyDelete = true
          $scope.checkedGroups = []
          for group in storage.groupsAll
            group.checked = false

        $scope.validChangeStr = (value, obj, arr, str) ->
          if obj != value
            res = {}
            res[str] = value
            arr.push(res)

        $scope.validChangeArr = (arrNew, arrOld, arr, str) ->
          for groupOld in arrOld
            for groupNew in arrNew
              if groupOld.indexOf(groupNew) == -1
                res = {}
                res[str] = arrNew
                arr.push(res)

        $scope.validObj = (objNew, objOld) ->
          $scope.sendUser = {}
          if objNew.name != objOld.name
            $scope.sendUser.name = objNew.name
          if objNew.password
            $scope.sendUser.password = objNew.password
          for groupOld in objOld.group
            for groupNew in objNew.group
              if groupOld.indexOf(groupNew) == -1
                $scope.sendUser.group = objNew.group

        $scope.sendChangeDatePersonal = () ->
          $scope.validObj($scope.userData, storage.user)
          userService.changeUser($scope.sendUser)
            .then(success = (response) ->
              console.log(response)
              storage.setUser(new User(response.data.name, response.data.email, response.data.groups))
              $timeout((() ->
                  $scope.userData.name = storage.user.name
                  $scope.userData.group = storage.user.group
                ), 0
              )
            error = (response) ->
              console.log('err' + response)
              response
          )
          $scope.readonlyDelete = true

        $scope.changeDatePersonal = () ->
          for group in $scope.userData.group
            if group == "ADMIN"
              $scope.showChandeGroup = true
          $scope.checkedGroups = []
          $scope.readonlyDelete = false
          if $scope.userData.group.length > 0
            for i in $scope.userData.group
              for y in storage.groupsAll
                if i == y.name
                  y.checked = true
                  $scope.checkedGroups.push(y.name)


        $scope.selected = () ->
          $scope.checkedGroups = []
          for group in  storage.groupsAll
            if group.checked
              $scope.checkedGroups.push(group.name)

        this.$onInit = () ->
          console.log(54)
          if localStorage.getItem("authToken")
            userService.getUserInfo()
              .then(success = (response) ->
                console.log(response)
                $scope.storage = storage
                storage.setUser(new User(response.data.name, response.data.email, response.data.groups))
                $scope.userData.name = storage.user.name
                $scope.userData.group = storage.user.group
                $scope.user = new User(storage.user.name, storage.user.email, storage.user.group)
              error = (response) ->
                console.log(response)
                response
            )
          else
            null
        null
      ]
  ]