app.controller 'MainCtrl', ($scope, Restangular, DTOptionsBuilder, DTColumnBuilder) ->

  $scope.main =
    refreshTime: 0

  return