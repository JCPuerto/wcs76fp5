/**
 * EFTDetailBaseType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class EFTDetailBaseType  extends org.openapplications.www.oagis._9.AccountInformationType  {
    private javax.xml.soap.SOAPElement routingNumber;
    private javax.xml.soap.SOAPElement bankName;

    public EFTDetailBaseType() {
    }

    public javax.xml.soap.SOAPElement getRoutingNumber() {
        return routingNumber;
    }

    public void setRoutingNumber(javax.xml.soap.SOAPElement routingNumber) {
        this.routingNumber = routingNumber;
    }

    public javax.xml.soap.SOAPElement getBankName() {
        return bankName;
    }

    public void setBankName(javax.xml.soap.SOAPElement bankName) {
        this.bankName = bankName;
    }

}
