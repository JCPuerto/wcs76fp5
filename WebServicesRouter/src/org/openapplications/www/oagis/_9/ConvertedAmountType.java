/**
 * ConvertedAmountType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ConvertedAmountType  {
    private javax.xml.soap.SOAPElement amount;
    private org.openapplications.www.oagis._9.CurrencyExchangeRateType exchangeRate;
    private javax.xml.soap.SOAPElement baseAmount;

    public ConvertedAmountType() {
    }

    public javax.xml.soap.SOAPElement getAmount() {
        return amount;
    }

    public void setAmount(javax.xml.soap.SOAPElement amount) {
        this.amount = amount;
    }

    public org.openapplications.www.oagis._9.CurrencyExchangeRateType getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(org.openapplications.www.oagis._9.CurrencyExchangeRateType exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public javax.xml.soap.SOAPElement getBaseAmount() {
        return baseAmount;
    }

    public void setBaseAmount(javax.xml.soap.SOAPElement baseAmount) {
        this.baseAmount = baseAmount;
    }

}
