/**
 * SalesTaskCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class SalesTaskCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected SalesTaskCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Meeting = "Meeting";
    public static final java.lang.String _ConferenceCall = "ConferenceCall";
    public static final java.lang.String _FollowUp = "FollowUp";
    public static final java.lang.String _EMail = "EMail";
    public static final SalesTaskCodeEnumerationType Meeting = new SalesTaskCodeEnumerationType(_Meeting);
    public static final SalesTaskCodeEnumerationType ConferenceCall = new SalesTaskCodeEnumerationType(_ConferenceCall);
    public static final SalesTaskCodeEnumerationType FollowUp = new SalesTaskCodeEnumerationType(_FollowUp);
    public static final SalesTaskCodeEnumerationType EMail = new SalesTaskCodeEnumerationType(_EMail);
    public java.lang.String getValue() { return _value_;}
    public static SalesTaskCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        SalesTaskCodeEnumerationType enumeration = (SalesTaskCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static SalesTaskCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
