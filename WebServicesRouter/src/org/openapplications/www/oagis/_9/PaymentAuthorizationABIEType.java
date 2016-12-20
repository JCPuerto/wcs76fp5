/**
 * PaymentAuthorizationABIEType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class PaymentAuthorizationABIEType  extends org.openapplications.www.oagis._9.AuthorizationABIEType  {
    private javax.xml.soap.SOAPElement referenceOrderNumber;
    private javax.xml.soap.SOAPElement revenueSourceID;
    private javax.xml.soap.SOAPElement remittanceBankID;

    public PaymentAuthorizationABIEType() {
    }

    public javax.xml.soap.SOAPElement getReferenceOrderNumber() {
        return referenceOrderNumber;
    }

    public void setReferenceOrderNumber(javax.xml.soap.SOAPElement referenceOrderNumber) {
        this.referenceOrderNumber = referenceOrderNumber;
    }

    public javax.xml.soap.SOAPElement getRevenueSourceID() {
        return revenueSourceID;
    }

    public void setRevenueSourceID(javax.xml.soap.SOAPElement revenueSourceID) {
        this.revenueSourceID = revenueSourceID;
    }

    public javax.xml.soap.SOAPElement getRemittanceBankID() {
        return remittanceBankID;
    }

    public void setRemittanceBankID(javax.xml.soap.SOAPElement remittanceBankID) {
        this.remittanceBankID = remittanceBankID;
    }

}
