/**
 * UserType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class UserType  {
    private javax.xml.soap.SOAPElement ID;
    private javax.xml.soap.SOAPElement[] groupID;
    private org.openapplications.www.oagis._9.UserAccountType[] userAccount;
    private javax.xml.soap.SOAPElement[] userArea;

    public UserType() {
    }

    public javax.xml.soap.SOAPElement getID() {
        return ID;
    }

    public void setID(javax.xml.soap.SOAPElement ID) {
        this.ID = ID;
    }

    public javax.xml.soap.SOAPElement[] getGroupID() {
        return groupID;
    }

    public void setGroupID(javax.xml.soap.SOAPElement[] groupID) {
        this.groupID = groupID;
    }

    public javax.xml.soap.SOAPElement getGroupID(int i) {
        return this.groupID[i];
    }

    public void setGroupID(int i, javax.xml.soap.SOAPElement value) {
        this.groupID[i] = value;
    }

    public org.openapplications.www.oagis._9.UserAccountType[] getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(org.openapplications.www.oagis._9.UserAccountType[] userAccount) {
        this.userAccount = userAccount;
    }

    public org.openapplications.www.oagis._9.UserAccountType getUserAccount(int i) {
        return this.userAccount[i];
    }

    public void setUserAccount(int i, org.openapplications.www.oagis._9.UserAccountType value) {
        this.userAccount[i] = value;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
