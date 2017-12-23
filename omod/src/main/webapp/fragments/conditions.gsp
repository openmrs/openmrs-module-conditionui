<%

    ui.includeJavascript("uicommons", "angular.min.js")
    ui.includeJavascript("uicommons", "angular-ui/ui-bootstrap-tpls-0.11.2.min.js")
    ui.includeJavascript("uicommons", "angular-resource.min.js")
    ui.includeJavascript("uicommons", "angular-common.js")

    ui.includeJavascript("conditionui", "lib/restangular.min.js")
    ui.includeJavascript("conditionui", "restful-services/restful-service.js");
    ui.includeJavascript("conditionui", "models/model.module.js")
    ui.includeJavascript("conditionui", "models/concept.model.js")
    ui.includeJavascript("conditionui", "models/condition.model.js")
    ui.includeJavascript("conditionui", "emr.messages.js")
    ui.includeJavascript("conditionui", "common.functions.js")
    ui.includeJavascript("conditionui", "controllers/manageconditions.controller.js")

    ui.includeJavascript("conditionui", "common.functions.js")

    ui.includeCss("conditionui", "conditions.css")
%>

<div class="info-section conditions" ng-app="manageConditionsApp" ng-controller="ManageConditionsController"
     ng-init="conditionHistoryList = getConditions('${patient.patient.uuid}')">
    <div class="info-header">
        <i class="icon-diagnosis"></i>

        <h3>${ui.message('conditionui.conditions').toUpperCase()}</h3>
        <i class="icon-pencil edit-action right" title="${ui.message("coreapps.edit")}"
           onclick="location.href = '${ui.pageLink("conditionui", "manageconditions", [patientId: patient.patient.uuid])}'"></i>
    </div>

    <div class="info-body">
        <ul ng-repeat="conditionHistory in conditionHistoryList">
            <li class="conditionStatus" ng-repeat="condition in conditionHistory.conditions"
                ng-show="condition.status === 'ACTIVE'">
                {{condition.concept.name}}
                <i class="icon-remove delete-action" title="${ui.message("coreapps.delete")}"
                   ng-click="removeCondition(condition)" ng-if="condition.voided===false"></i>
                <i class="icon-undo delete-action" title="${ui.message("conditionui.undo")}"
                   ng-click="undoCondition(condition)" ng-if="condition.voided===true"></i>
            </li>
        </ul>
    </div>
</div>
