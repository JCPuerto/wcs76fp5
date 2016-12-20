/**
 * ChequeType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ChequeType  extends org.openapplications.www.oagis._9.EFTDetailBaseType  {
    private javax.xml.soap.SOAPElement chequeNumber;
    private javax.xml.soap.SOAPElement[] userArea;

    public ChequeType() {
    }

    public javax.xml.soap.SOAPElement getChequeNumber() {
        return chequeNumber;
    }

    public void setChequeNumber(javax.xml.soap.SOAPElement chequeNumber) {
        this.chequeNumber = chequeNumber;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
