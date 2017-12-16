var removeConditionDialog = null;
var activateConditionDialog = null;
var deactivateConditionDialog = null;
var archiveConditionDialog = null;

$(document).ready( function() {
    
    removeConditionDialog = emr.setupConfirmationDialog({
        selector: '#conditionui-remove-condition-dialog',
        actions: {
            cancel: function() {
            	removeConditionDialog.close();
            }
        }
    });

    activateConditionDialog = emr.setupConfirmationDialog({
        selector: '#conditionui-activate-condition-dialog',
        actions: {
            cancel: function() {
            	acvtivateConditionDialog.close();
            }
        }
    });

    deactivateConditionDialog = emr.setupConfirmationDialog({
        selector: '#conditionui-deactivate-condition-dialog',
        actions: {
            cancel: function() {
            	deactivateConditionDialog.close();
            }
        }
    });

    archiveConditionDialog = emr.setupConfirmationDialog({
        selector: '#conditionui-archive-condition-dialog',
        actions: {
            cancel: function() {
            	archiveConditionDialog.close();
            }
        }
    });

});

function removeCondition(uuid) {
}

function activateCondition(uuid) {
	jQuery.ajax({url: "/openmrs/module/conditionui/manage/activate.json?&conditionUuid=" + uuid, success: function(result){
		alert(result);
    }});
}

function deactivateCondition(uuid) {
	jQuery.ajax({url: "/openmrs/module/conditionui/manage/deactivate.json?conditionUuid=" + uuid, success: function(result){
		alert(result);
    }});
}

function archiveCondition(uuid) {
	jQuery.ajax({url: "/openmrs/module/conditionui/manage/archive.json?conditionUuid=" + uuid, success: function(result){
		alert(result);
    }});
}
