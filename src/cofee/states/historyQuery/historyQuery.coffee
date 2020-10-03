angular.module 'mainApp'
  .config ["$stateProvider", "$locationProvider", "$urlRouterProvider",($stateProvider, $locationProvider, $urlRouterProvider) ->
    $stateProvider.state 'historyQueryComponent',
      url: '/historyQueryComponent'
      templateUrl: '../../components/historyQueryComponent/historyQueryComponent.html'
      controller: ['$scope', 'userService', '$state', 'storage', '$filter', '$timeout', ($scope, userService, $state, storage, $filter, $timeout) ->
        $scope.selectOne = ''
        $scope.multiple = false
        $scope.result = []
        $scope.root = [
          {
            id: 1,
            name: "root"
            showChildren: false
            select: null
            children: [
              {
                id: 11
                name: "Node 11"
                showChildren: false
                select: null
                children: [
                  {
                    id: 111
                    name: "Node 111"
                    showChildren: false
                    select: null
                    children: [
                      {
                        id: 1111
                        name: "Node 1111"
                        showChildren: false
                        select: null
                        children: [
                          {
                            id: 11111
                            name: "Node 11111"
                            showChildren: false
                            select: null
                          }
                        ]
                      }
                      {
                        id: 1112
                        name: "Node 1112"
                        showChildren: false
                        select: null
                      }
                    ]
                  }
                  {
                    id: 112
                    name: "Node 112"
                    showChildren: false
                    select: null
                  }
                ]
              }
              {
                id: 12
                name: "Node 12"
                showChildren: false
                select: null
                children: [
                  {
                    id: 121
                    name: "Node 121"
                    showChildren: false
                    select: null
                  }
                ]
              }
              {
                id: 13,
                name: "Node 13"
                showChildren: false
                select: null
                children: [
                  {
                    id: 131
                    name: "Node 131"
                    showChildren: false
                    select: null
                  }
                ]
              }
              {
                id: 14,
                name: "Node 14"
                showChildren: false
                select: null
                children: [
                  {
                    id: 141
                    name: "Node 141"
                    showChildren: false
                    select: null
                  }
                ]
              }
            ]
          }
          {
            id: 2,
            name: "root2"
            showChildren: false
            select: null
          }
        ]

        $scope.selectTree = []
        $scope.selectTreeId = []
        $scope.selectTreeObj = []


        $scope.putDownSelect = (arr) ->
          for item in arr
            if item.children
              $scope.putDownSelect(item.children)
            else
              for u in $scope.selectTreeId
                if u == item.id
                  item.select = true


        $scope.sendSelect = (item) ->
          $scope.selectOne = item
          $scope.showChild(item)


        $scope.showChild = (child) ->
          child.showChildren = !child.showChildren
          if !child.showChildren
            if child.children
              for item in child.children
                item.showChildren = false
                $scope.deletedSelect(item)
          if !$scope.multiple
            $scope.selected(child)

        $scope.sendChild = (item) ->
          $scope.result = []
          $scope.selectTreeObj = []
          $scope.selectTree = []
          for item in $scope.root
            if item.children
              for y in item.children
                $scope.selectChild(y)
            else
              if item.select
                $scope.result.push(item)
          $scope.result
          $scope.selectTreeObj = $scope.result
          for y in $scope.selectTreeObj
            $scope.selectTree.push(y.name)
          localStorage.setItem('selectCategories', JSON.stringify($scope.selectTreeObj))


        $scope.selectChild = (item) ->
          if item.children
            for y in item.children
              $scope.selectChild(y)
          else
            if item.select
              $scope.result.push(item)



        this.$onInit = () ->
          $scope.getRequestHistoryAll = false
          $scope.showTreeList = false
          $scope.showTreeListTable = false
          userService.getHistorySearch()
            .then(success = (item) ->
              $scope.historySearch = item
            error = (item) ->
              console.log(item)
              item
          if localStorage.getItem('selectCategories')
            $scope.selectTreeObj = JSON.parse(localStorage.getItem('selectCategories'))
            for y in $scope.selectTreeObj
              $scope.selectTree.push(y.name)
              $scope.selectTreeId.push(y.id)
            $scope.putDownSelect($scope.root)
          )


        $scope.sendByDay = () ->
          $scope.historySearchByDay =[]
          $scope.getRequestHistoryByDay = !$scope.getRequestHistoryByDay
          $scope.checkArr($scope.historySearch, $scope.historySearchByDay)
          console.log($scope.historySearchByDay)

        $scope.checkArr = (arr1, arr2) ->
          for item in arr1
            if arr2.length == 0
              count = []
              count.push(item.query)
              res = {
                date: $filter('dateFilterDDMMYY')(item.date)
                items: count
              }
              arr2.push(res)
            else
              for val in arr2
                index = val.date.indexOf($filter('dateFilterDDMMYY')(item.date))
                if index == -1
                  count = []
                  count.push(item.query)
                  res = {
                    date: $filter('dateFilterDDMMYY')(item.date)
                    items: count
                  }
                  arr2.push(res)
                else
                  val.items.push(item.query)
          arr2

        $scope.backQuery = () ->
          $state.go('searchFormComponent')

        ###$scope.iteratingDate = (arr) ->
          result = []
          for item in arr
            result.push(item.date)
          console.log(result)
          result


        $scope.iteratingQuery = (arr) ->
          result = []
          for item in arr
            res = {
              name: item.query
              data: [1, 3, 5]
            }
            result.push(res)
          console.log(result)
          result###

        $scope.formChart = () ->
          $scope.showChart = !$scope.showChart
          myChart = Highcharts.chart('container', {
            title: {
              text: 'My Quests today'
            }
            plotOptions: {
              series: {
                pointStart: Date.UTC(2020, 8, 10),
                pointInterval: 36e5
                #24 * 3600 * 1000 // one day
              }
            },

            xAxis: {
              type: 'datetime',
              #offset: 40 / подвал оси y
            }
            series: [
              {
                data: [
                  {
                    x: 1600033067317
                    y: 1
                    name: 'Query'
                  }
                  {
                    x: 1600033178357
                    y: 2
                    name: 'Query'
                  }
                  {
                    x: 1600133178357
                    y: 1
                    name: 'Query'
                  }
                ]
              }
            ]
          })
        null
      ]
]