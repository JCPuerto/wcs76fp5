/**
 * ActionCriteriaType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ActionCriteriaType  {
    private org.openapplications.www.oagis._9.ActionExpressionType[] actionExpression;
    private org.openapplications.www.oagis._9.ChangeStatusType changeStatus;

    public ActionCriteriaType() {
    }

    public org.openapplications.www.oagis._9.ActionExpressionType[] getActionExpression() {
        return actionExpression;
    }

    public void setActionExpression(org.openapplications.www.oagis._9.ActionExpressionType[] actionExpression) {
        this.actionExpression = actionExpression;
    }

    public org.openapplications.www.oagis._9.ActionExpressionType getActionExpression(int i) {
        return this.actionExpression[i];
    }

    public void setActionExpression(int i, org.openapplications.www.oagis._9.ActionExpressionType value) {
        this.actionExpression[i] = value;
    }

    public org.openapplications.www.oagis._9.ChangeStatusType getChangeStatus() {
        return changeStatus;
    }

    public void setChangeStatus(org.openapplications.www.oagis._9.ChangeStatusType changeStatus) {
        this.changeStatus = changeStatus;
    }

}
