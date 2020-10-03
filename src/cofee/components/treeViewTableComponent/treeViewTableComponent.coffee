angular.module 'mainApp'
  .directive 'treeViewTableComponent', ['RecursionHelper', (RecursionHelper) ->
    templateUrl: '../../components/treeViewTableComponent/treeViewTableComponent.html'
    restrict: 'AE'
    scope: {
      treeArr: '='
      select: '='
      multiple: '='
      selected: '='
      sendChild: '='
    }
    compile: (element) ->
      RecursionHelper.compile(element, (scope, iElement, iAttrs, controller, transcludeFn) ->
      )
    controller: ['$scope', treeViewTableController = ($scope) ->
      this.$onInit = () ->
        console.log(54)

      $scope.showChild = (child) ->
        child.showChildren = !child.showChildren
        if !child.showChildren
          if child.children
            for item in child.children
              item.showChildren = false
              $scope.deletedSelect(item)
        if !$scope.multiple
          $scope.selected(child)

      $scope.deletedSelect = (item) ->
        if !item.select
          if item.children
            for y in item.children
              y.select = false
              $scope.deletedSelect(y)
          else
            item.select = false

      null
    ]
  ]