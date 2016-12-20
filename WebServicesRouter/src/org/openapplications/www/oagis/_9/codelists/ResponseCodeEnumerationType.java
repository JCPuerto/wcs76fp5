/**
 * ResponseCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class ResponseCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected ResponseCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Always = "Always";
    public static final java.lang.String _Never = "Never";
    public static final ResponseCodeEnumerationType Always = new ResponseCodeEnumerationType(_Always);
    public static final ResponseCodeEnumerationType Never = new ResponseCodeEnumerationType(_Never);
    public java.lang.String getValue() { return _value_;}
    public static ResponseCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        ResponseCodeEnumerationType enumeration = (ResponseCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static ResponseCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
