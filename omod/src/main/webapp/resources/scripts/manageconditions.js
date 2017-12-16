var removeConditionDialog = null;

$(document).ready( function() {
    
    removeConditionDialog = emr.setupConfirmationDialog({
        selector: '#conditionui-remove-condition-dialog',
        actions: {
            cancel: function() {
            	removeConditionDialog.close();
            }
        }
    });

});

function showRemoveConditionDialog() {
    removeConditionDialog.show();
}

function removeCondition(condition, id) {
    jq("#conditionId").val(id);
    jq("#removeConditionMessage").text(jq("#removeConditionMessageTemplate").val().replace("{0}", condition));
    showRemoveConditionDialog(condition, id);
}
