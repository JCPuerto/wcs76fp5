/**
 * SignatoryPartyType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class SignatoryPartyType  extends org.openapplications.www.oagis._9.PartyBaseType  {
    private org.openapplications.www.oagis._9.SignatoryContactType[] signatoryContact;
    private javax.xml.soap.SOAPElement[] userArea;

    public SignatoryPartyType() {
    }

    public org.openapplications.www.oagis._9.SignatoryContactType[] getSignatoryContact() {
        return signatoryContact;
    }

    public void setSignatoryContact(org.openapplications.www.oagis._9.SignatoryContactType[] signatoryContact) {
        this.signatoryContact = signatoryContact;
    }

    public org.openapplications.www.oagis._9.SignatoryContactType getSignatoryContact(int i) {
        return this.signatoryContact[i];
    }

    public void setSignatoryContact(int i, org.openapplications.www.oagis._9.SignatoryContactType value) {
        this.signatoryContact[i] = value;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
