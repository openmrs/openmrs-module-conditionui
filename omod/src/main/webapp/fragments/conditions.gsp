<%  
 ui.includeCss("conditionui", "conditions.css")
%>
<div class="info-section conditions">
    <div class="info-header">
        <i class="icon-medical"></i>
        <h3>Conditions</h3>
        <i class="icon-pencil edit-action right" title="${ ui.message("coreapps.edit") }" onclick="location.href='${ui.pageLink("conditionui", "manageconditions", [patientId: patient.patient.id])}';"></i>
    </div>
    <div class="info-body">
        <ul>
            <% conditions.each { conditionhistory -> 
		conditionhistory.conditions.each { condition -> 
		if ( !condition.endDate && !condition.status.toString().equals("INACTIVE")) { %>
            <li>
                <span class="conditionStatus">
	    ${ condition.status.toString().equals("HISTORY_OF") && "History of " : "" }
		    ${ condition.concept.name }
                </span>
            </li>
	   <%
	     }
	     }
            } %>
        </ul>
    </div>
</div>
