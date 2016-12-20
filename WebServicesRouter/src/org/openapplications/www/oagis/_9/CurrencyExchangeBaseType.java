/**
 * CurrencyExchangeBaseType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class CurrencyExchangeBaseType  extends org.openapplications.www.oagis._9.CurrencyExchangeABIEType  {
    private java.lang.String type;  // attribute
    private javax.xml.soap.SOAPElement sourceID;
    private javax.xml.soap.SOAPElement effectiveTimePeriod;

    public CurrencyExchangeBaseType() {
    }

    public java.lang.String getType() {
        return type;
    }

    public void setType(java.lang.String type) {
        this.type = type;
    }

    public javax.xml.soap.SOAPElement getSourceID() {
        return sourceID;
    }

    public void setSourceID(javax.xml.soap.SOAPElement sourceID) {
        this.sourceID = sourceID;
    }

    public javax.xml.soap.SOAPElement getEffectiveTimePeriod() {
        return effectiveTimePeriod;
    }

    public void setEffectiveTimePeriod(javax.xml.soap.SOAPElement effectiveTimePeriod) {
        this.effectiveTimePeriod = effectiveTimePeriod;
    }

}
