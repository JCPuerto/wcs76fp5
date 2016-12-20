/**
 * CreditCardType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class CreditCardType  extends org.openapplications.www.oagis._9.CardBaseType  {
    private javax.xml.soap.SOAPElement cardCode;
    private javax.xml.soap.SOAPElement billingAddress;
    private javax.xml.soap.SOAPElement ownerAddress;
    private javax.xml.soap.SOAPElement[] userArea;

    public CreditCardType() {
    }

    public javax.xml.soap.SOAPElement getCardCode() {
        return cardCode;
    }

    public void setCardCode(javax.xml.soap.SOAPElement cardCode) {
        this.cardCode = cardCode;
    }

    public javax.xml.soap.SOAPElement getBillingAddress() {
        return billingAddress;
    }

    public void setBillingAddress(javax.xml.soap.SOAPElement billingAddress) {
        this.billingAddress = billingAddress;
    }

    public javax.xml.soap.SOAPElement getOwnerAddress() {
        return ownerAddress;
    }

    public void setOwnerAddress(javax.xml.soap.SOAPElement ownerAddress) {
        this.ownerAddress = ownerAddress;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
