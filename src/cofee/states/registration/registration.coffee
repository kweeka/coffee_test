angular.module 'mainApp'
  .config ["$stateProvider", "$locationProvider", "$urlRouterProvider",($stateProvider, $locationProvider, $urlRouterProvider) ->
    $stateProvider.state 'registration',
      url: '/registration'
      templateUrl: '../../components/registrationComponent/registrationComponent.html'
      controller: ['$scope', 'userService', 'validationAuth', '$state', ($scope, userService, validationAuth, $state) ->
        $scope.userData = {}
        $scope.userDataErr = {}
        $scope.changeName = (value) ->
          $scope.userDataErr.name = validationAuth.validationName(value)
        $scope.changeEmail = (value) ->
          $scope.userDataErr.email = validationAuth.validationEmail(value)
        $scope.changePassword = (value) ->
          $scope.userDataErr.password = validationAuth.validationPassword(value)
        $scope.registration = (email, name, password) ->
          if ($scope.nameErr.length == 0 && $scope.emailErr.length == 0 && $scope.passwordErr.length == 0)
            userService.registration(email, name, password)
              .then(success = (response) ->
                localStorage.setItem("authToken", response.data.token)
                $state.go('personal')
                console.log(response)
              error = (response) ->
                console.log(response)
                errsArr = response.data.errors
                if errsArr.length > 0
                  for err in errsArr
                    $scope.userDataErr[err.field].push(err.message)
                console.log($scope.userDataErr)
            )
      ]
  ]