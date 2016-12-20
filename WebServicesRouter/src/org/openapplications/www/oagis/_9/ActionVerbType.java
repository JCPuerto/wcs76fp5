/**
 * ActionVerbType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ActionVerbType  extends org.openapplications.www.oagis._9.VerbType  {
    private org.openapplications.www.oagis._9.ActionCriteriaType[] actionCriteria;

    public ActionVerbType() {
    }

    public org.openapplications.www.oagis._9.ActionCriteriaType[] getActionCriteria() {
        return actionCriteria;
    }

    public void setActionCriteria(org.openapplications.www.oagis._9.ActionCriteriaType[] actionCriteria) {
        this.actionCriteria = actionCriteria;
    }

    public org.openapplications.www.oagis._9.ActionCriteriaType getActionCriteria(int i) {
        return this.actionCriteria[i];
    }

    public void setActionCriteria(int i, org.openapplications.www.oagis._9.ActionCriteriaType value) {
        this.actionCriteria[i] = value;
    }

}
