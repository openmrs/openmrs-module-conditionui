/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.conditionui.page.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.openmrs.Condition.Status;
import org.openmrs.Patient;
import org.openmrs.module.emrapi.conditionslist.ConditionService;
import org.openmrs.module.emrapi.conditionslist.contract.Concept;
import org.openmrs.module.emrapi.conditionslist.contract.Condition;
import org.openmrs.module.emrapi.conditionslist.contract.ConditionHistory;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.page.PageModel;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * Controller for a fragment that displays conditions for a patient
 * 
 * @author owais.hussain@ihsinformatics.com
 */
public class ManageConditionsPageController {
	
	public void controller(PageModel model, @RequestParam("patientId") Patient patient,
	        @SpringBean("conditionService") ConditionService service) {
		// model.addAttribute("conditions",
		// service.getConditionHistory(patient));
		model.addAttribute("conditions", dummyConditionHistory());
	}
	
	private List<ConditionHistory> dummyConditionHistory() {
		List<ConditionHistory> conditionHistories = new ArrayList<ConditionHistory>();
		ConditionHistory conditionHistory = new ConditionHistory();
		conditionHistory.setConceptUuid("e5d6453f-4e14-11e4-8a57-0800271c1b75");
		
		List<Condition> conditions = new ArrayList<Condition>();
		Condition condition = new Condition();
		condition.setDateCreated(new Date());
		condition.setConcept(new Concept("11", "Asthma, extrinsic, acute exacerbation"));
		condition.setPatientUuid("3ae1ee52-e9b2-4934-876d-30711c0e3e2f");
		condition.setCreator("Admin");
		condition.setStatus(Status.ACTIVE);
		condition.setUuid("080adc37-ad09-4825-b84e-abeb18d17085");
		
		conditions.add(condition);
		conditionHistory.setConditions(conditions);
		conditionHistories.add(conditionHistory);
		
		// ----------------------------------------------------\\
		ConditionHistory conditionHistory2 = new ConditionHistory();
		conditionHistory2.setConceptUuid("e5d6453f-4e14-11e4-8a57-0800271c1b75");
		
		List<Condition> conditions2 = new ArrayList<Condition>();
		Condition condition2 = new Condition();
		condition2.setDateCreated(new Date());
		condition2.setConcept(new Concept("12", "Vomiting of pregnancy, unspec."));
		condition2.setPatientUuid("3ae1ee52-e9b2-4934-876d-30711c0e3e2f");
		condition2.setCreator("Admin");
		condition2.setStatus(Status.INACTIVE);
		condition2.setUuid("080adc37-ad09-4825-b84e-abeb18d17088");
		
		conditions2.add(condition2);
		conditionHistory2.setConditions(conditions2);
		conditionHistories.add(conditionHistory2);
		
		return conditionHistories;
	}
}
