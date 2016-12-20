/**
 * ResponseActionCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class ResponseActionCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected ResponseActionCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Accepted = "Accepted";
    public static final java.lang.String _Modified = "Modified";
    public static final java.lang.String _Rejected = "Rejected";
    public static final ResponseActionCodeEnumerationType Accepted = new ResponseActionCodeEnumerationType(_Accepted);
    public static final ResponseActionCodeEnumerationType Modified = new ResponseActionCodeEnumerationType(_Modified);
    public static final ResponseActionCodeEnumerationType Rejected = new ResponseActionCodeEnumerationType(_Rejected);
    public java.lang.String getValue() { return _value_;}
    public static ResponseActionCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        ResponseActionCodeEnumerationType enumeration = (ResponseActionCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static ResponseActionCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
