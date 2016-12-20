/**
 * AuthorizationABIEType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class AuthorizationABIEType  {
    private javax.xml.soap.SOAPElement[] ID;
    private javax.xml.soap.SOAPElement responseCode;
    private java.util.Calendar authorizationDate;
    private javax.xml.soap.SOAPElement amount;

    public AuthorizationABIEType() {
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

    public javax.xml.soap.SOAPElement getResponseCode() {
        return responseCode;
    }

    public void setResponseCode(javax.xml.soap.SOAPElement responseCode) {
        this.responseCode = responseCode;
    }

    public java.util.Calendar getAuthorizationDate() {
        return authorizationDate;
    }

    public void setAuthorizationDate(java.util.Calendar authorizationDate) {
        this.authorizationDate = authorizationDate;
    }

    public javax.xml.soap.SOAPElement getAmount() {
        return amount;
    }

    public void setAmount(javax.xml.soap.SOAPElement amount) {
        this.amount = amount;
    }

}
