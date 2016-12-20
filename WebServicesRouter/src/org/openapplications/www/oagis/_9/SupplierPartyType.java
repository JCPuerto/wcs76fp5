/**
 * SupplierPartyType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class SupplierPartyType  extends org.openapplications.www.oagis._9.PartyBaseType  {
    private org.openapplications.www.oagis._9.SemanticContactType[] salesContact;
    private org.openapplications.www.oagis._9.SemanticContactType[] shippingContact;
    private org.openapplications.www.oagis._9.SemanticContactType[] customerServiceContact;
    private javax.xml.soap.SOAPElement[] userArea;

    public SupplierPartyType() {
    }

    public org.openapplications.www.oagis._9.SemanticContactType[] getSalesContact() {
        return salesContact;
    }

    public void setSalesContact(org.openapplications.www.oagis._9.SemanticContactType[] salesContact) {
        this.salesContact = salesContact;
    }

    public org.openapplications.www.oagis._9.SemanticContactType getSalesContact(int i) {
        return this.salesContact[i];
    }

    public void setSalesContact(int i, org.openapplications.www.oagis._9.SemanticContactType value) {
        this.salesContact[i] = value;
    }

    public org.openapplications.www.oagis._9.SemanticContactType[] getShippingContact() {
        return shippingContact;
    }

    public void setShippingContact(org.openapplications.www.oagis._9.SemanticContactType[] shippingContact) {
        this.shippingContact = shippingContact;
    }

    public org.openapplications.www.oagis._9.SemanticContactType getShippingContact(int i) {
        return this.shippingContact[i];
    }

    public void setShippingContact(int i, org.openapplications.www.oagis._9.SemanticContactType value) {
        this.shippingContact[i] = value;
    }

    public org.openapplications.www.oagis._9.SemanticContactType[] getCustomerServiceContact() {
        return customerServiceContact;
    }

    public void setCustomerServiceContact(org.openapplications.www.oagis._9.SemanticContactType[] customerServiceContact) {
        this.customerServiceContact = customerServiceContact;
    }

    public org.openapplications.www.oagis._9.SemanticContactType getCustomerServiceContact(int i) {
        return this.customerServiceContact[i];
    }

    public void setCustomerServiceContact(int i, org.openapplications.www.oagis._9.SemanticContactType value) {
        this.customerServiceContact[i] = value;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
