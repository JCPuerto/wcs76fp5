/**
 * CurrencyExchangeABIEType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public abstract class CurrencyExchangeABIEType  {
    private javax.xml.soap.SOAPElement sourceCurrencyCode;
    private java.math.BigDecimal sourceUnitBaseNumeric;
    private javax.xml.soap.SOAPElement targetCurrencyCode;
    private java.math.BigDecimal targetUnitBaseNumeric;
    private java.math.BigDecimal rateNumeric;
    private javax.xml.soap.SOAPElement setDateTime;

    public CurrencyExchangeABIEType() {
    }

    public javax.xml.soap.SOAPElement getSourceCurrencyCode() {
        return sourceCurrencyCode;
    }

    public void setSourceCurrencyCode(javax.xml.soap.SOAPElement sourceCurrencyCode) {
        this.sourceCurrencyCode = sourceCurrencyCode;
    }

    public java.math.BigDecimal getSourceUnitBaseNumeric() {
        return sourceUnitBaseNumeric;
    }

    public void setSourceUnitBaseNumeric(java.math.BigDecimal sourceUnitBaseNumeric) {
        this.sourceUnitBaseNumeric = sourceUnitBaseNumeric;
    }

    public javax.xml.soap.SOAPElement getTargetCurrencyCode() {
        return targetCurrencyCode;
    }

    public void setTargetCurrencyCode(javax.xml.soap.SOAPElement targetCurrencyCode) {
        this.targetCurrencyCode = targetCurrencyCode;
    }

    public java.math.BigDecimal getTargetUnitBaseNumeric() {
        return targetUnitBaseNumeric;
    }

    public void setTargetUnitBaseNumeric(java.math.BigDecimal targetUnitBaseNumeric) {
        this.targetUnitBaseNumeric = targetUnitBaseNumeric;
    }

    public java.math.BigDecimal getRateNumeric() {
        return rateNumeric;
    }

    public void setRateNumeric(java.math.BigDecimal rateNumeric) {
        this.rateNumeric = rateNumeric;
    }

    public javax.xml.soap.SOAPElement getSetDateTime() {
        return setDateTime;
    }

    public void setSetDateTime(javax.xml.soap.SOAPElement setDateTime) {
        this.setDateTime = setDateTime;
    }

}
