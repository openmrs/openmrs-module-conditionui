<%
    ui.decorateWith("appui", "standardEmrPage")
    ui.includeJavascript("uicommons", "angular.min.js")
    ui.includeJavascript("uicommons", "angular-ui/ui-bootstrap-tpls-0.11.2.min.js")
    ui.includeJavascript("allergyui", "allergy.js")
    ui.includeJavascript("uicommons", "angular-resource.min.js")
    ui.includeJavascript("uicommons", "angular-common.js")
    ui.includeJavascript("uicommons", "ngDialog/ngDialog.js")
    ui.includeJavascript("uicommons", "ngDialog/ngDialog.js")
    ui.includeJavascript("uicommons", "services/conceptSearchService.js")
    ui.includeJavascript("uicommons", "directives/coded-or-free-text-answer.js")
    ui.includeCss("uicommons", "ngDialog/ngDialog.min.css")

    ui.includeCss("conditionui", "conditions.css")
    def isEdit = condition.id != null;
    def title = ui.message("Add");
%>
<script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: "${ ui.escapeJs(ui.encodeHtmlContent(ui.format(patient.familyName))) }, ${ ui.escapeJs(ui.encodeHtmlContent(ui.format(patient.givenName))) }" , link: '${ui.pageLink("coreapps", "clinicianfacing/patient", [patientId: patient.id])}'},
        { label: "${ ui.message("Condition List") }", link: '${ui.pageLink("conditionui", "conditions", [patientId: patient.id, returnUrl: returnUrl])}'},
        { label: "${ title }" }
    ];

</script>

${ ui.includeFragment("coreapps", "patientHeader", [ patient: patient ]) }

${ ui.includeFragment("allergyui", "removeAllergyDialog") }

<% ui.includeJavascript("conditionui", "addcondition.js") %>

<div id="condition" ng-app="conditionApp" ng-controller="conditionController">

    <h2 class="inline">${ title }</h2>

    <% if (isEdit) { %>
    <button type="button" class="cancel inline right">
        ${ ui.message("Remove Condition") }
    </button>
    <% } %>

    <form method="post" id="condition" action="${ ui.pageLink("conditionui", "conditions", [patientId: patient.id, returnUrl: returnUrl]) }">

        <% if (isEdit) { %>
        <input type="hidden" name="conditionId" value="${condition.id}" />
        <% } %>

        <% if (!isEdit) { %>
        <div id="concept">
            <ul>
                <li>
                    <input type="hidden" name="concept" ng-value="concept ? 'CONCEPT:'+concept.uuid : 'NON_CODED:'+word">
                    <coded-or-free-text-answer id="concept" concept-classes="8d490dfc-c2cc-11de-8d13-0010c6dffd0f,b4535251-9183-4175-959e-9ee67dc71e78"
                                               ng-model="concept" ng-click="otherFieldFocus()" />
                </li>
            </ul>
            <% } %>
        </div>

        <div id="status" class="horizontal">
            <label class="heading">${ ui.message("Status") }:</label>
            <p>
                <input type="radio" id="status-1" class="condition-status" name="status" value="ACTIVE" ng-model="status"/>
                <label for="status-1">Status</label>
            </p>
            <p>
                <input type="radio" id="status-2" class="condition-status" name="status" value="INACTIVE" ng-model="status"/>
                <label for="status-2">Status</label>
            </p>
            <p>
                <input type="radio" id="status-3" class="condition-status" name="status" value="HISTORY_OF" ng-model="status"/>
                <label for="status-3">Status</label>
            </p>
            <i class="icon-remove delete-item" title="${ ui.message("general.clear") }" ng-click="status = null"></i>
        </div>

        <div id="actions">
            <input type="submit" id="addConditionBtn" class="confirm right" value="${ ui.message("coreapps.save") }" <% if(!isEdit){ %> ng-disabled="!canSave()" <% } %>/>
            <input type="button" class="cancel" value="${ ui.message("coreapps.cancel") }"
                   onclick="location.href='${ ui.pageLink("conditionui", "conditions", [patientId: patient.id, returnUrl: returnUrl ]) }'" />
        </div>
    </form>
</div>
