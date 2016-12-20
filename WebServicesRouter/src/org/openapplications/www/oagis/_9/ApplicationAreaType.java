/**
 * ApplicationAreaType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ApplicationAreaType  {
    private org.openapplications.www.oagis._9.SenderType sender;
    private javax.xml.soap.SOAPElement creationDateTime;
    private org.openapplications.www.oagis._9.SignatureType signature;
    private javax.xml.soap.SOAPElement BODID;
    private javax.xml.soap.SOAPElement[] userArea;

    public ApplicationAreaType() {
    }

    public org.openapplications.www.oagis._9.SenderType getSender() {
        return sender;
    }

    public void setSender(org.openapplications.www.oagis._9.SenderType sender) {
        this.sender = sender;
    }

    public javax.xml.soap.SOAPElement getCreationDateTime() {
        return creationDateTime;
    }

    public void setCreationDateTime(javax.xml.soap.SOAPElement creationDateTime) {
        this.creationDateTime = creationDateTime;
    }

    public org.openapplications.www.oagis._9.SignatureType getSignature() {
        return signature;
    }

    public void setSignature(org.openapplications.www.oagis._9.SignatureType signature) {
        this.signature = signature;
    }

    public javax.xml.soap.SOAPElement getBODID() {
        return BODID;
    }

    public void setBODID(javax.xml.soap.SOAPElement BODID) {
        this.BODID = BODID;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
