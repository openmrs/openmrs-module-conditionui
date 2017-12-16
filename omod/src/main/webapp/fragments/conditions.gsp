<div class="info-section conditions">
    <div class="info-header">
        <i class="icon-medical"></i>
        <h3>Conditions</h3>
        <i class="icon-pencil edit-action right" title="${ ui.message("coreapps.edit") }" onclick="location.href='${ui.pageLink("conditionui", "conditions", [patientId: patient.patient.id])}';"></i>
    </div>
    <div class="info-body">
        <ul>
            <% conditions.each { condition -> %>
            <li>
                <span class="allergen">
                    ${ ui.encodeHtmlContent(ui.format(condition.conceptUuid)) }
                </span>
            </li>
            <% } %>
        </ul>
    </div>
</div>
