/**
 * CardBaseType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public abstract class CardBaseType  extends org.openapplications.www.oagis._9.AccountInformationType  {
    private org.openapplications.www.oagis._9.ExpirationType expiration;
    private javax.xml.soap.SOAPElement companyName;
    private org.openapplications.www.oagis._9.PaymentAuthorizationType paymentAuthorization;

    public CardBaseType() {
    }

    public org.openapplications.www.oagis._9.ExpirationType getExpiration() {
        return expiration;
    }

    public void setExpiration(org.openapplications.www.oagis._9.ExpirationType expiration) {
        this.expiration = expiration;
    }

    public javax.xml.soap.SOAPElement getCompanyName() {
        return companyName;
    }

    public void setCompanyName(javax.xml.soap.SOAPElement companyName) {
        this.companyName = companyName;
    }

    public org.openapplications.www.oagis._9.PaymentAuthorizationType getPaymentAuthorization() {
        return paymentAuthorization;
    }

    public void setPaymentAuthorization(org.openapplications.www.oagis._9.PaymentAuthorizationType paymentAuthorization) {
        this.paymentAuthorization = paymentAuthorization;
    }

}
