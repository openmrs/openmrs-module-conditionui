(function() {
    'use strict';

    var baseModel = angular.module('app.models', []);

    function ConditionModel() {

        function ConditionModel(patient) {
            this.status = 'ACTIVE';
            this.patient = patient;
            this.previousCondition = '';
            this.concept = '';
            this.conditionNonCoded = '';

            this.onsetDate = '';
            this.additionalDetail = '';
            this.endDate = '';
            this.endReason = '';
        }

        ConditionModel.prototype = {

            getStatus: function() {
                return this.status;
            },

            setStatus: function(status) {
                this.status = status;
            },

            getPatient: function() {
                return this.patient;
            },

            setPatient: function(patient) {
                this.patient = patient;
            },

            getPreviousCondition: function() {
                return this.previousCondition;
            },

            setPreviousCondition: function(previousCondition) {
                this.previousCondition = previousCondition;
            },

            setConditionNonCoded: function(conditionNonCoded) {
                this.conditionNonCoded = conditionNonCoded;
            },

            getConditionNonCoded: function() {
                return this.conditionNonCoded;
            },

            getOnsetDate: function() {
                return this.onsetDate;
            },

            setOnsetDate: function(onsetDate) {
                this.onsetDate = onsetDate;
            },

            getAdditionalDetail: function() {
                return this.additionalDetail;
            },

            setAdditionalDetail: function(additionalDetail) {
                this.additionalDetail = additionalDetail;
            },

            setEndDate: function(endDate) {
                this.endDate = endDate;
            },

            getEndDate: function() {
                return this.endDate;
            },

            setEndReason: function(endReason) {
                this.endReason = endReason;
            },

            getEndReason: function() {
                return this.endReason;
            }
        };

        return ConditionModel;
    }

    baseModel.factory("ConditionModel", ConditionModel);
    ConditionModel.$inject = [];
})();
