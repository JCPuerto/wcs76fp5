/**
 * CustomerPartyType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class CustomerPartyType  extends org.openapplications.www.oagis._9.PayerPartyBaseType  {
    private org.openapplications.www.oagis._9.SemanticContactType requesterContact;
    private org.openapplications.www.oagis._9.SemanticContactType plannerContact;
    private org.openapplications.www.oagis._9.SemanticContactType buyerContact;
    private org.openapplications.www.oagis._9.SemanticContactType receivingContact;
    private javax.xml.soap.SOAPElement[] userArea;

    public CustomerPartyType() {
    }

    public org.openapplications.www.oagis._9.SemanticContactType getRequesterContact() {
        return requesterContact;
    }

    public void setRequesterContact(org.openapplications.www.oagis._9.SemanticContactType requesterContact) {
        this.requesterContact = requesterContact;
    }

    public org.openapplications.www.oagis._9.SemanticContactType getPlannerContact() {
        return plannerContact;
    }

    public void setPlannerContact(org.openapplications.www.oagis._9.SemanticContactType plannerContact) {
        this.plannerContact = plannerContact;
    }

    public org.openapplications.www.oagis._9.SemanticContactType getBuyerContact() {
        return buyerContact;
    }

    public void setBuyerContact(org.openapplications.www.oagis._9.SemanticContactType buyerContact) {
        this.buyerContact = buyerContact;
    }

    public org.openapplications.www.oagis._9.SemanticContactType getReceivingContact() {
        return receivingContact;
    }

    public void setReceivingContact(org.openapplications.www.oagis._9.SemanticContactType receivingContact) {
        this.receivingContact = receivingContact;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
