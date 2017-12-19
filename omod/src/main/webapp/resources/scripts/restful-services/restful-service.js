(function () {
    'use strict';
    var app = angular.module('app.restfulServices', ['restangular']);

    app.service('RestfulService', RestfulService);

    RestfulService.$inject = ['Restangular'];

    function RestfulService(Restangular) {
        var service;

        service = {
            setBaseUrl: setBaseUrl,
            get: get,
            save: save
        };

        return service;

        function setBaseUrl(restWsUrl) {
            if (!angular.isUndefined(restWsUrl)) {
                Restangular.setBaseUrl(restWsUrl);
            }
        }

        function get(resource, request, successCallback, errorCallback) {
            Restangular.all(resource).customGET('', request).then(function (data) {
                if (typeof successCallback === 'function') {
                    successCallback(data);
                }
            }, function (error) {
                if (typeof errorCallback === 'function') {
                    errorCallback(error);
                }
            });
        }

        function save(resource, uuid, request, successCallback, errorCallback) {
            var params = JSON.stringify(request);

            Restangular.one(resource, uuid).customPOST(params).then(function (data) {
                if (typeof successCallback === 'function') successCallback(data);
            }, function (error) {
                if (typeof errorCallback === 'function') {
                    errorCallback(error);
                }
            });
        }
    }
})();