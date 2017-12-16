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
	${ ui.message("conditionui.conditions") }
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
					<i class="icon-pencil edit-action" title="${ ui.message("coreapps.edit") }"
					   onclick="location.href='${ ui.pageLink("conditionui", "condition", [condition: condition.uuid, patientId: patient.id, returnUrl: returnUrl]) }'"></i>
					<i class="icon-remove delete-action" title="${ ui.message("coreapps.delete") }" onclick="removeCondition('${ ui.encodeJavaScriptAttribute(ui.format(condition)) }', ${ condition.uuid})"></i>
				</td>

			</tr>
		<% } %>
	<% } %>
</tbody>
</table>
