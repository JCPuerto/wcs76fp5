/**
 * SalesActivityCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class SalesActivityCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected SalesActivityCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _LiteratureRequest = "LiteratureRequest";
    public static final java.lang.String _NewLead = "NewLead";
    public static final java.lang.String _DeadContent = "DeadContent";
    public static final java.lang.String _TrafficReport = "TrafficReport";
    public static final java.lang.String _Sold = "Sold";
    public static final java.lang.String _EMail = "EMail";
    public static final java.lang.String _Letter = "Letter";
    public static final java.lang.String _Fax = "Fax";
    public static final SalesActivityCodeEnumerationType LiteratureRequest = new SalesActivityCodeEnumerationType(_LiteratureRequest);
    public static final SalesActivityCodeEnumerationType NewLead = new SalesActivityCodeEnumerationType(_NewLead);
    public static final SalesActivityCodeEnumerationType DeadContent = new SalesActivityCodeEnumerationType(_DeadContent);
    public static final SalesActivityCodeEnumerationType TrafficReport = new SalesActivityCodeEnumerationType(_TrafficReport);
    public static final SalesActivityCodeEnumerationType Sold = new SalesActivityCodeEnumerationType(_Sold);
    public static final SalesActivityCodeEnumerationType EMail = new SalesActivityCodeEnumerationType(_EMail);
    public static final SalesActivityCodeEnumerationType Letter = new SalesActivityCodeEnumerationType(_Letter);
    public static final SalesActivityCodeEnumerationType Fax = new SalesActivityCodeEnumerationType(_Fax);
    public java.lang.String getValue() { return _value_;}
    public static SalesActivityCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        SalesActivityCodeEnumerationType enumeration = (SalesActivityCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static SalesActivityCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
