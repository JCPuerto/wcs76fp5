/**
 * ResponseVerbType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public abstract class ResponseVerbType  extends org.openapplications.www.oagis._9.VerbType  {
    private org.openapplications.www.oagis._9.ApplicationAreaType originalApplicationArea;
    private org.openapplications.www.oagis._9.ResponseActionCriteriaType[] responseCriteria;

    public ResponseVerbType() {
    }

    public org.openapplications.www.oagis._9.ApplicationAreaType getOriginalApplicationArea() {
        return originalApplicationArea;
    }

    public void setOriginalApplicationArea(org.openapplications.www.oagis._9.ApplicationAreaType originalApplicationArea) {
        this.originalApplicationArea = originalApplicationArea;
    }

    public org.openapplications.www.oagis._9.ResponseActionCriteriaType[] getResponseCriteria() {
        return responseCriteria;
    }

    public void setResponseCriteria(org.openapplications.www.oagis._9.ResponseActionCriteriaType[] responseCriteria) {
        this.responseCriteria = responseCriteria;
    }

    public org.openapplications.www.oagis._9.ResponseActionCriteriaType getResponseCriteria(int i) {
        return this.responseCriteria[i];
    }

    public void setResponseCriteria(int i, org.openapplications.www.oagis._9.ResponseActionCriteriaType value) {
        this.responseCriteria[i] = value;
    }

}
