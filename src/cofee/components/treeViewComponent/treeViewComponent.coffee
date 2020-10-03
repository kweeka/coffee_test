angular.module 'mainApp'
  .directive 'treeViewComponent', ['RecursionHelper', (RecursionHelper) ->
    templateUrl: '../../components/treeViewComponent/treeViewComponent.html'
    restrict: 'E'
    scope: {
      treeArr: '='
      multiple: '='
      selected: '='
      sendChild: '='
      parent: '='
      sendSelect: '='
      showChild: '='
      changeSelect: '='
    }
    compile: (element) ->
      RecursionHelper.compile(element, (scope, iElement, iAttrs, controller, transcludeFn) ->
      )
    controller: ['$scope', '$timeout', treeViewController = ($scope, $timeout) ->
      this.$onInit = () ->
        $scope.selectParent()
        console.log(54)

      $scope.selectCheckbox = (item) ->
        console.log(item)
        if item.select == false || item.select == null
          item.select = true
        else
          item.select = null
        $scope.changeSelect(item)
        $scope.selectParent()
        $scope.sendChild()

      $scope.changeSelect = (item) ->
        if item.select == true
          if item.children
            for y in item.children
              y.select = true
              $scope.changeSelect(y)
        else
          if item.children
            for y in item.children
              y.select = null
              $scope.changeSelect(y)


      $scope.selectParent =() ->
        if $scope.parent
          resultAllSelect = []
          resultNotSelect = []
          for y in $scope.parent.children
            if y.select
              resultAllSelect.push(y)
            if y.select == null
              resultNotSelect.push(y)
          if $scope.parent.children.length == resultAllSelect.length
            $scope.parent.select = true
          else if $scope.parent.children.length == resultNotSelect.length
            $scope.parent.select = null
          else
            $scope.parent.select = false
          if $scope.$parent.item
            console.log($scope.$parent.item)
            $scope.$parent.selectParent()

      null
    ]
  ]