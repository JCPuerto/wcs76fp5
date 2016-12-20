/**
 * PriceABIEType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class PriceABIEType  extends org.openapplications.www.oagis._9.AmountPerQuantityType  {
    private javax.xml.soap.SOAPElement[] code;
    private javax.xml.soap.SOAPElement timePeriod;

    public PriceABIEType() {
    }

    public javax.xml.soap.SOAPElement[] getCode() {
        return code;
    }

    public void setCode(javax.xml.soap.SOAPElement[] code) {
        this.code = code;
    }

    public javax.xml.soap.SOAPElement getCode(int i) {
        return this.code[i];
    }

    public void setCode(int i, javax.xml.soap.SOAPElement value) {
        this.code[i] = value;
    }

    public javax.xml.soap.SOAPElement getTimePeriod() {
        return timePeriod;
    }

    public void setTimePeriod(javax.xml.soap.SOAPElement timePeriod) {
        this.timePeriod = timePeriod;
    }

}
