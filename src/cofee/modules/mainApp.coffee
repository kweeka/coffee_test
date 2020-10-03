angular.module 'mainApp', ['ui.router']
  .config ["$stateProvider", "$locationProvider", "$urlRouterProvider",($stateProvider, $locationProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/notice')
  ]


































