<%  
    ui.includeCss("conditionui", "conditions.css")
%>

<div class="info-section conditions">
    <div class="info-header">
        <i class="icon-medical"></i>
        <h3>${ ui.message("conditionui.conditions").toUpperCase() }</h3>
        <i class="icon-pencil edit-action right" title="${ ui.message("coreapps.edit") }" onclick="location.href='${ui.pageLink("conditionui", "conditions", [patientId: patient.patient.id])}';"></i>
    </div>
Nothing here yet
</div>
