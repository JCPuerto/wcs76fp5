/**
 * TransferCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class TransferCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected TransferCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Complete = "Complete";
    public static final java.lang.String _Return = "Return";
    public static final TransferCodeEnumerationType Complete = new TransferCodeEnumerationType(_Complete);
    public static final TransferCodeEnumerationType Return = new TransferCodeEnumerationType(_Return);
    public java.lang.String getValue() { return _value_;}
    public static TransferCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        TransferCodeEnumerationType enumeration = (TransferCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static TransferCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
