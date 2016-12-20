/**
 * AmountType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.unqualifieddatatypes._1._1;

public class AmountType  {
    private javax.xml.soap.SOAPElement currencyID;  // attribute
    private java.math.BigDecimal _value;

    public AmountType() {
    }

    public javax.xml.soap.SOAPElement getCurrencyID() {
        return currencyID;
    }

    public void setCurrencyID(javax.xml.soap.SOAPElement currencyID) {
        this.currencyID = currencyID;
    }

    public java.math.BigDecimal get_value() {
        return _value;
    }

    public void set_value(java.math.BigDecimal _value) {
        this._value = _value;
    }

}
