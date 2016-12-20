/**
 * PaymentTermCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class PaymentTermCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected PaymentTermCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _value1 = "Net20";
    public static final java.lang.String _value2 = "Net30";
    public static final java.lang.String _value3 = "Net45";
    public static final java.lang.String _value4 = "Net60";
    public static final java.lang.String _value5 = "10Percent30";
    public static final PaymentTermCodeEnumerationType value1 = new PaymentTermCodeEnumerationType(_value1);
    public static final PaymentTermCodeEnumerationType value2 = new PaymentTermCodeEnumerationType(_value2);
    public static final PaymentTermCodeEnumerationType value3 = new PaymentTermCodeEnumerationType(_value3);
    public static final PaymentTermCodeEnumerationType value4 = new PaymentTermCodeEnumerationType(_value4);
    public static final PaymentTermCodeEnumerationType value5 = new PaymentTermCodeEnumerationType(_value5);
    public java.lang.String getValue() { return _value_;}
    public static PaymentTermCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        PaymentTermCodeEnumerationType enumeration = (PaymentTermCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static PaymentTermCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
