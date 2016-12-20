/**
 * UserAuthorizationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class UserAuthorizationType  {
    private javax.xml.soap.SOAPElement[] ID;
    private javax.xml.soap.SOAPElement type;
    private org.openapplications.www.oagis._9.StatusType status;
    private javax.xml.soap.SOAPElement authorizedDateTime;
    private javax.xml.soap.SOAPElement effectiveTimePeriod;
    private javax.xml.soap.SOAPElement authorizationCode;
    private javax.xml.soap.SOAPElement[] userArea;

    public UserAuthorizationType() {
    }

    public javax.xml.soap.SOAPElement[] getID() {
        return ID;
    }

    public void setID(javax.xml.soap.SOAPElement[] ID) {
        this.ID = ID;
    }

    public javax.xml.soap.SOAPElement getID(int i) {
        return this.ID[i];
    }

    public void setID(int i, javax.xml.soap.SOAPElement value) {
        this.ID[i] = value;
    }

    public javax.xml.soap.SOAPElement getType() {
        return type;
    }

    public void setType(javax.xml.soap.SOAPElement type) {
        this.type = type;
    }

    public org.openapplications.www.oagis._9.StatusType getStatus() {
        return status;
    }

    public void setStatus(org.openapplications.www.oagis._9.StatusType status) {
        this.status = status;
    }

    public javax.xml.soap.SOAPElement getAuthorizedDateTime() {
        return authorizedDateTime;
    }

    public void setAuthorizedDateTime(javax.xml.soap.SOAPElement authorizedDateTime) {
        this.authorizedDateTime = authorizedDateTime;
    }

    public javax.xml.soap.SOAPElement getEffectiveTimePeriod() {
        return effectiveTimePeriod;
    }

    public void setEffectiveTimePeriod(javax.xml.soap.SOAPElement effectiveTimePeriod) {
        this.effectiveTimePeriod = effectiveTimePeriod;
    }

    public javax.xml.soap.SOAPElement getAuthorizationCode() {
        return authorizationCode;
    }

    public void setAuthorizationCode(javax.xml.soap.SOAPElement authorizationCode) {
        this.authorizationCode = authorizationCode;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
