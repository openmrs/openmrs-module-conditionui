package org.openmrs.module.conditionui.page.controller;

/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 * <p>
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 * <p>
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.openmrs.Concept;
import org.openmrs.Condition;
import org.openmrs.Patient;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.messagesource.MessageSourceService;
import org.openmrs.module.emrapi.conditionslist.ConditionService;
import org.openmrs.module.uicommons.UiCommonsConstants;
import org.openmrs.module.uicommons.util.InfoErrorMessageUtil;
import org.openmrs.ui.framework.CodedOrFreeTextValue;
import org.openmrs.ui.framework.UiUtils;
import org.openmrs.ui.framework.annotation.BindParams;
import org.openmrs.ui.framework.annotation.MethodParam;
import org.openmrs.ui.framework.annotation.SpringBean;
import org.openmrs.ui.framework.page.PageModel;
import org.openmrs.ui.util.ByFormattedObjectComparator;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestParam;

public class AddconditionPageController {
	
	public void controller(PageModel model, @RequestParam(value = "conditionId", required = false) String conditionId,
	        @RequestParam("patientId") Patient patient,
	        @RequestParam(value = "returnUrl", required = false) String returnUrl,
	        @SpringBean("conditionService") ConditionService conditionService) {
		
		Condition condition;
		if (conditionId == null) {
			condition = newInstance(patient);
		} else {
			condition = conditionService.getConditionByUuid(conditionId);
			if (condition == null) {
				condition = newInstance(patient);
			}
		}
		
		setModelAttributes(condition, returnUrl, model);
	}
	
	public String post(@RequestParam(value = "conditionId", required = false) String conditionId,
	        @RequestParam("patientId") Patient patient, @RequestParam("conceptId") Concept concept,
	        @RequestParam("status") Condition.Status status,
	        @RequestParam(value = "returnUrl", required = false) String returnUrl, PageModel model,
	        @SpringBean("patientService") PatientService patientService,
	        @SpringBean("messageSourceService") MessageSourceService messageService,
	        @SpringBean("conditionService") ConditionService conditionService, HttpSession session, UiUtils ui)
	        throws Exception {
		
		String successMsgCode = "allergyui.message.success";
		Condition condition;
		if (conditionId == null) {
			condition = new Condition();
		} else {
			condition = conditionService.getConditionByUuid(conditionId);
		}
		
		try {
			condition.setPatient(patient);
			condition.setConcept(concept);
			condition.setStatus(status);
			condition = conditionService.save(condition);
			InfoErrorMessageUtil.flashInfoMessage(session, successMsgCode);
			
			return "redirect:conditionui/manageconditions.page?patientId=" + patient.getPatientId() + "&returnUrl="
			        + ui.urlEncode(returnUrl);
		}
		catch (Exception e) {
			session.setAttribute(UiCommonsConstants.SESSION_ATTRIBUTE_ERROR_MESSAGE, "failed");
		}
		
		setModelAttributes(condition, returnUrl, model);
		return null;
	}
	
	private void setModelAttributes(Condition condition, String returnUrl, PageModel model) {
		model.addAttribute("condition", condition);
		model.addAttribute("returnUrl", returnUrl);
		//model.addAttribute("severities", concepts);
	}
	
	private Condition newInstance(Patient patient) {
		Condition condition = new Condition();
		condition.setPatient(patient);
		return condition;
	}
}
