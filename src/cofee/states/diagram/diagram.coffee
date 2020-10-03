angular.module 'mainApp'
  .config ["$stateProvider", "$locationProvider", "$urlRouterProvider",($stateProvider, $locationProvider, $urlRouterProvider) ->
    $stateProvider.state 'diagramComponent',
      url: '/diagram'
      templateUrl: '../../components/diagramComponent/diagramComponent.html'
      controller: ['$scope', ($scope) ->
        ###myChart = Highcharts.chart('container', {
          chart: {
            type: 'packedbubble'
          },
          plotOptions: {
            packedbubble: {
              minSize: '20%',
              maxSize: '100%',
              zMin: 0,
              zMax: 1000,
              layoutAlgorithm: {
                gravitationalConstant: 0,
                splitSeries: true,
                seriesInteraction: true,
                dragBetweenSeries: true,
                parentNodeLimit: true
                parentNodeOptions: initialPositions: "circle"
              },
              dataLabels: {
                enabled: true,
                format: '{point.name}',
                filter: {
                  property: 'y',
                  operator: '>',
                  value: 250
                },
                style: {
                  color: 'black',
                  textOutline: 'none',
                  fontWeight: 'normal'
                }
              }
            }
          },
          series: [
            {
              name: 'Coffee'
              data: [{
                value: 12,
                name: 'Bert’'
              }, {
                value: 5,
                name: 'John’'
              }, {
                value: 10,
                name: 'Sandra'
              }, {
                value: 7,
                name: 'Cecile'
              }]
            }
          ]
        });###
        Highcharts.chart('container', {

          title: {
            text: 'Highcharts Dependency Wheel'
          },

          accessibility: {
            point: {
              valueDescriptionFormat: '{index}. From {point.from} to {point.to}: {point.weight}.'
            }
          },

          series: [{
            keys: ['from', 'to', 'weight'],
            data: [
              ['Brazil', 'Portugal', 5],
              ['Brazil', 'France', 1],
              ['Brazil', 'Spain', 1],
              ['Brazil', 'England', 1],
              ['Canada', 'Portugal', 1],
              ['Canada', 'France', 5],
              ['Canada', 'England', 1],
              ['Mexico', 'Portugal', 1],
              ['Mexico', 'France', 1],
              ['Mexico', 'Spain', 5],
              ['Mexico', 'England', 1],
              ['USA', 'Portugal', 1],
              ['USA', 'France', 1],
              ['USA', 'Spain', 1],
              ['USA', 'England', 5],
              ['Portugal', 'Angola', 2],
              ['Portugal', 'Senegal', 1],
              ['Portugal', 'Morocco', 1],
              ['Portugal', 'South Africa', 3],
              ['France', 'Angola', 1],
              ['France', 'Senegal', 3],
              ['France', 'Mali', 3],
              ['France', 'Morocco', 3],
              ['France', 'South Africa', 1],
              ['Spain', 'Senegal', 1],
              ['Spain', 'Morocco', 3],
              ['Spain', 'South Africa', 1],
              ['England', 'Angola', 1],
              ['England', 'Senegal', 1],
              ['England', 'Morocco', 2],
              ['England', 'South Africa', 7],
              ['South Africa', 'China', 5],
              ['South Africa', 'India', 1],
              ['South Africa', 'Japan', 3],
              ['Angola', 'China', 5],
              ['Angola', 'India', 1],
              ['Angola', 'Japan', 3],
              ['Senegal', 'China', 5],
              ['Senegal', 'India', 1],
              ['Senegal', 'Japan', 3],
              ['Mali', 'China', 5],
              ['Mali', 'India', 1],
              ['Mali', 'Japan', 3],
              ['Morocco', 'China', 5],
              ['Morocco', 'India', 1],
              ['Morocco', 'Japan', 3],
              ['Japan', 'Brazil', 1]
            ],
            type: 'dependencywheel',
            name: 'Dependency wheel series',
            dataLabels: {
              color: '#333',
              textPath: {
                enabled: true,
                attributes: {
                  dy: 5
                }
              },
              distance: 10
            },
            size: '95%'
          }]

        });
      ]
  ]

























