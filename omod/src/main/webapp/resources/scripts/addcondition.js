var app = angular.module("conditionApp", ['uicommons.widget.coded-or-free-text-answer']);

app.controller("conditionController", [ '$scope', function($scope) {

    $scope.concept = null;
    $scope.status = null;

}]);