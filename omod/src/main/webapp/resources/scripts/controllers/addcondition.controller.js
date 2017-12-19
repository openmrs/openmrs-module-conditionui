var app = angular.module("conditionApp",
    ['uicommons.widget.coded-or-free-text-answer', 'app.restfulServices', 'app.models']);

app.controller("ConditionController", ConditionController);
ConditionController.$inject = ['$scope', 'RestfulService', 'ConditionModel'];

function ConditionController($scope, RestfulService, ConditionModel) {
    var self = this;

    $scope.patientUuid = null;
    $scope.condition = null;

    // this is required inorder to initialize the Restangular service
    RestfulService.setBaseUrl('/' + OPENMRS_CONTEXT_PATH + '/ws/rest/emrapi');

    /**
     * Still working on it (WIP)
     * @type {Function}
     */
    self.saveCondition = self.saveCondition || function () {
            var requestParams = {};
            requestParams['conditions'] = $scope.conditions;
            RestfulService.get('condition', requestParams, function (data) {
                $scope.conditions = data;
            }, function (error) {
                console.log(error);
            })
        }

    self.initCondition = self.initCondition || function () {
            $scope.patientUuid = self.extractUrlArgs(window.location.search)['patientId'];
            $scope.condition = new ConditionModel($scope.patientUuid);
        }

    self.validateCondition = self.validateCondition || function () {
        }

    self.unselectStatus = self.unselectStatus || function () {
            $scope.condition.status = null;
        }

    self.extractUrlArgs = self.extractUrlArgs || function (urlArgs) {
            var urlParams = [];
            urlArgs = urlArgs.replace('?', '');
            if (urlArgs.indexOf("&") > 0) {
                var params = urlArgs.split("&");
                for (var i = 0; i < params.length; i++) {
                    var param = params[i];
                    var paramArgs = param.split("=");
                    urlParams[paramArgs[0]] = paramArgs[1];
                }
            }

            return urlParams;
        }

    // init page
    self.initCondition();

    // bind functions to scope
    $scope.saveCondition = self.saveCondition;
    $scope.unselectStatus = self.unselectStatus;
}
