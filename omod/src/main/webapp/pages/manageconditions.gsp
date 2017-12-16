<% ui.decorateWith("appui", "standardEmrPage") %>

<script type="text/javascript">
var breadcrumbs = [
	{ icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
	{ label: "${ ui.escapeJs(ui.encodeHtmlContent(ui.format(patient.familyName))) }, ${ ui.escapeJs(ui.encodeHtmlContent(ui.format(patient.givenName))) }" , link: '${ui.pageLink("coreapps", "clinicianfacing/patient", [patientId: patient.id])}'},
	{ label: "${ ui.message("conditionui.conditions") }" }
];
</script>


${ ui.includeFragment("coreapps", "patientHeader", [ patient: patient ]) }

<% ui.includeJavascript("conditionui", "manageconditions.js") %>

${ ui.includeFragment("uicommons", "infoAndErrorMessage")}

<h2>
	${ ui.message("conditionui.conditions") }<td>
	<input type="checkbox" id="conditionui-showVoidedConditions">${ ui.message("conditionui.showVoided") }</input>
</h2>

<table id="conditions" width="100%" border="1" cellspacing="0" cellpadding="2">
<thead>
	<tr>
		<th>${ ui.message("conditionui.condition") }</th>
		<th>${ ui.message("conditionui.status") }</th>
		<th>${ ui.message("conditionui.onsetdate") }</th>
		<th>${ ui.message("coreapps.actions") }</th>
	</tr>
</thead>

<tbody>
	<% if (conditions.size() == 0) { %>
		<tr>
			<td colspan="6" align="center" >
			${ ui.message("conditionui.noKnownConditions") }
			</td>
		</tr>
	<% } %>
	
	<% conditions.each { conditionHistory -> %>
		<% conditionHistory.conditions.each { condition -> %>
			<tr>
				<td>${ ui.encodeHtmlContent(ui.format(condition.concept.name)) }</td>
				<td>${ ui.encodeHtmlContent(ui.format(condition.status)) }</td>
				<td>${ ui.formatDatetimePretty(condition.onSetDate) }</td>
					<td>
					<i class="icon-plus-sign edit-action" title="${ ui.message("conditionui.active") }" onclick="activateCondition('${ condition.uuid}')"></i>
					<i class="icon-minus-sign edit-action" title="${ ui.message("conditionui.inactive") }" onclick="deactivateCondition('${ condition.uuid}')"></i>
					<i class="icon-folder-close edit-action" title="${ ui.message("conditionui.historyof") }" onclick="archiveCondition('${ condition.uuid}')"></i>
					<i class="icon-remove delete-action" title="${ ui.message("coreapps.delete") }" onclick="removeCondition('${ condition.uuid}')"></i>
				</td>
			</tr>
		<% } %>
	<% } %>
</tbody>
</table>

<button class="cancel" onclick="location.href='${ ui.encodeHtml(returnUrl) }'">
	${ ui.message("uicommons.return") }
</button>
<button id ="conditionui-addNewCondition" class="confirm right" onclick="location.href='${ ui.pageLink("conditionui", "addcondition", [patientId: patient.id, returnUrl: returnUrl]) }'">
	${ ui.message("conditionui.addNewCondition") }
</button>
