/**
 * DebitCreditCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class DebitCreditCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected DebitCreditCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Debit = "Debit";
    public static final java.lang.String _Credit = "Credit";
    public static final DebitCreditCodeEnumerationType Debit = new DebitCreditCodeEnumerationType(_Debit);
    public static final DebitCreditCodeEnumerationType Credit = new DebitCreditCodeEnumerationType(_Credit);
    public java.lang.String getValue() { return _value_;}
    public static DebitCreditCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        DebitCreditCodeEnumerationType enumeration = (DebitCreditCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static DebitCreditCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
