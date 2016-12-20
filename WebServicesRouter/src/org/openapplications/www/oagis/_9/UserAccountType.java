/**
 * UserAccountType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class UserAccountType  {
    private javax.xml.soap.SOAPElement systemID;
    private javax.xml.soap.SOAPElement accountID;
    private javax.xml.soap.SOAPElement accountType;
    private org.openapplications.www.oagis._9.UserAuthorizationType[] userAuthorization;
    private javax.xml.soap.SOAPElement[] userArea;

    public UserAccountType() {
    }

    public javax.xml.soap.SOAPElement getSystemID() {
        return systemID;
    }

    public void setSystemID(javax.xml.soap.SOAPElement systemID) {
        this.systemID = systemID;
    }

    public javax.xml.soap.SOAPElement getAccountID() {
        return accountID;
    }

    public void setAccountID(javax.xml.soap.SOAPElement accountID) {
        this.accountID = accountID;
    }

    public javax.xml.soap.SOAPElement getAccountType() {
        return accountType;
    }

    public void setAccountType(javax.xml.soap.SOAPElement accountType) {
        this.accountType = accountType;
    }

    public org.openapplications.www.oagis._9.UserAuthorizationType[] getUserAuthorization() {
        return userAuthorization;
    }

    public void setUserAuthorization(org.openapplications.www.oagis._9.UserAuthorizationType[] userAuthorization) {
        this.userAuthorization = userAuthorization;
    }

    public org.openapplications.www.oagis._9.UserAuthorizationType getUserAuthorization(int i) {
        return this.userAuthorization[i];
    }

    public void setUserAuthorization(int i, org.openapplications.www.oagis._9.UserAuthorizationType value) {
        this.userAuthorization[i] = value;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
