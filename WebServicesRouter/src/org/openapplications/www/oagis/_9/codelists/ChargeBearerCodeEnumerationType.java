/**
 * ChargeBearerCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class ChargeBearerCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected ChargeBearerCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _OUR = "OUR";
    public static final java.lang.String _BEN = "BEN";
    public static final java.lang.String _SHA = "SHA";
    public static final ChargeBearerCodeEnumerationType OUR = new ChargeBearerCodeEnumerationType(_OUR);
    public static final ChargeBearerCodeEnumerationType BEN = new ChargeBearerCodeEnumerationType(_BEN);
    public static final ChargeBearerCodeEnumerationType SHA = new ChargeBearerCodeEnumerationType(_SHA);
    public java.lang.String getValue() { return _value_;}
    public static ChargeBearerCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        ChargeBearerCodeEnumerationType enumeration = (ChargeBearerCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static ChargeBearerCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
