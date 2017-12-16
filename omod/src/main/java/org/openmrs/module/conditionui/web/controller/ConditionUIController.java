/**
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at http://mozilla.org/MPL/2.0/. OpenMRS is also distributed under
 * the terms of the Healthcare Disclaimer located at http://openmrs.org/license.
 *
 * Copyright (C) OpenMRS Inc. OpenMRS is a registered trademark and the OpenMRS
 * graphic logo is a trademark of OpenMRS Inc.
 */
package org.openmrs.module.conditionui.web.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.Condition;
import org.openmrs.Condition.Status;
import org.openmrs.module.emrapi.conditionslist.ConditionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * This class configured as controller using annotation and mapped with the URL of
 * 'module/conditionui/conditionuiLink.form'.
 */
@Controller("${rootrootArtifactId}.ConditionUIController")
@RequestMapping(value = "module/conditionui/manage")
public class ConditionUIController {
	
	/** Logger for this class and subclasses */
	protected final Log log = LogFactory.getLog(getClass());
	
	@Autowired
	ConditionService conditionService;
	
	@RequestMapping("activate")
	public @ResponseBody
	String activate(@RequestParam("conditionUuid") String conditionUuid) {
		Condition condition = conditionService.getConditionByUuid(conditionUuid);
		condition.setStatus(Status.ACTIVE);
		try {
			conditionService.save(condition);
		}
		catch (Exception e) {
			return "ERROR";
		}
		return "SUCCESS";
	}
	
	@RequestMapping("deactivate")
	public @ResponseBody
	String deactivate(@RequestParam("conditionUuid") String conditionUuid) {
		Condition condition = conditionService.getConditionByUuid(conditionUuid);
		condition.setStatus(Status.INACTIVE);
		try {
			conditionService.save(condition);
		}
		catch (Exception e) {
			return "ERROR";
		}
		return "SUCCESS";
	}
	
	@RequestMapping("archive")
	public @ResponseBody
	String archive(@RequestParam("conditionUuid") String conditionUuid) {
		Condition condition = conditionService.getConditionByUuid(conditionUuid);
		condition.setStatus(Status.HISTORY_OF);
		try {
			conditionService.save(condition);
		}
		catch (Exception e) {
			return "ERROR";
		}
		return "SUCCESS";
	}
}
