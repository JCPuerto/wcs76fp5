/**
 * PaymentSchemeCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class PaymentSchemeCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected PaymentSchemeCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _ACH = "ACH";
    public static final java.lang.String _RTGS = "RTGS";
    public static final java.lang.String _Fednet = "Fednet";
    public static final java.lang.String _CHIPS = "CHIPS";
    public static final PaymentSchemeCodeEnumerationType ACH = new PaymentSchemeCodeEnumerationType(_ACH);
    public static final PaymentSchemeCodeEnumerationType RTGS = new PaymentSchemeCodeEnumerationType(_RTGS);
    public static final PaymentSchemeCodeEnumerationType Fednet = new PaymentSchemeCodeEnumerationType(_Fednet);
    public static final PaymentSchemeCodeEnumerationType CHIPS = new PaymentSchemeCodeEnumerationType(_CHIPS);
    public java.lang.String getValue() { return _value_;}
    public static PaymentSchemeCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        PaymentSchemeCodeEnumerationType enumeration = (PaymentSchemeCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static PaymentSchemeCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
