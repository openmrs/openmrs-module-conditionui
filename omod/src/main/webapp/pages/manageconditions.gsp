<%
    ui.decorateWith("appui", "standardEmrPage")

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

${ui.includeFragment("coreapps", "patientHeader", [patient: patient])}

<script type="text/javascript">
    var breadcrumbs = [
        {icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm'},
        {
            label: "${ ui.escapeJs(ui.encodeHtmlContent(ui.format(patient.familyName))) }, ${ ui.escapeJs(ui.encodeHtmlContent(ui.format(patient.givenName))) }",
            link: '${ui.pageLink("coreapps", "clinicianfacing/patient", [patientId: patient.id])}'
        },
        {label: "${ ui.message("conditionui.conditions") }"}
    ];
</script>

<script>
    jQuery.noConflict();
    jQuery(function () {
        jQuery("#tabs").tabs();
    });
</script>

<h2>${ui.message("conditionui.manageConditions")}<td></h2>

<div id="condition" ng-app="manageConditionsApp" ng-controller="ManageConditionsController">
    <div id="tabs">
        <ul>
            <li>
                <a href="#ACTIVE" class="tabs-height">
                    ${ui.message('conditionui.activeConditions')}
                </a>
            </li>
            <li>
                <a href="#INACTIVE" class="tabs-height">
                    ${ui.message('conditionui.inactiveConditions')}
                </a>
            </li>
        </ul>

        <span ng-repeat="tab in tabs">
            <div id="{{tab}}">
                <table class="conditions-table">
                    <thead>
                    <tr>
                        <th>${ui.message("conditionui.condition")}</th>
                        <th>${ui.message("conditionui.status")}</th>
                        <th>${ui.message("conditionui.onsetdate")}</th>
                        <th>${ui.message("coreapps.actions")}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr ng-if="conditions.size() == 0">
                        <td colspan="6" align="center">
                            ${ui.message("conditionui.noKnownConditions")}
                        </td>
                    </tr>
                    <tbody ng-repeat="conditionHistory in conditionHistoryList">
                    <tr class="clickable-tr" ng-repeat="condition in conditionHistory.conditions"
                        ng-show="condition.status===tab">
                        <td ng-style="strikeThrough(condition.voided)">{{condition.concept.name}}</td>
                        <td ng-style="strikeThrough(condition.voided)">{{condition.status}}</td>
                        <td ng-style="strikeThrough(condition.voided)">{{formatDate(condition.onSetDate)}}</td>
                        <td>
                            <i class="icon-plus-sign edit-action" title="${ui.message("conditionui.active")}"
                               ng-click="activateCondition(condition)" ng-if="condition.status==='INACTIVE' && condition.voided===false"></i>
                            <i class="icon-minus-sign edit-action" title="${ui.message("conditionui.inactive")}"
                               ng-click="deactivateCondition(condition)" ng-if="condition.status==='ACTIVE' && condition.voided===false"></i>
                            <i class="icon-folder-close edit-action" title="${ui.message("conditionui.historyof")}"
                               ng-click="moveToHistoryCondition(condition)" ng-if="condition.status!=='HISTORY_OF' && condition.voided===false"></i>
                            <i class="icon-remove delete-action" title="${ui.message("coreapps.delete")}"
                               ng-click="removeCondition(condition)" ng-if="condition.voided===false"></i>
                            <i class="icon-undo delete-action" title="${ui.message("conditionui.undo")}"
                               ng-click="undoCondition(condition)" ng-if="condition.voided===true"></i>
                        </td>
                    </tr>
                    </tbody>
                </tbody>
                </table>
            </div>
        </span>
    </div>

    <div class="actions">
        <button class="cancel"
                onclick="location.href = '${ ui.encodeHtml(returnUrl) }'">${ui.message("coreapps.cancel")}</button>
        <button id="conditionui-addNewCondition" class="confirm right"
                onclick="location.href = '${ ui.pageLink("conditionui", "addcondition", [patientId: patient.uuid, returnUrl: returnUrl]) }'">
            ${ui.message("conditionui.addNewCondition")}
        </button>
    </div>
</div>