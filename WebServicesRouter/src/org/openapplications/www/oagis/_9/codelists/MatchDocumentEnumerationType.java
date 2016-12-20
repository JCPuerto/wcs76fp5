/**
 * MatchDocumentEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class MatchDocumentEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected MatchDocumentEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _value1 = "Invoice";
    public static final java.lang.String _value2 = "Purchase Order";
    public static final java.lang.String _value3 = "Receipt";
    public static final java.lang.String _value4 = "Inspection";
    public static final MatchDocumentEnumerationType value1 = new MatchDocumentEnumerationType(_value1);
    public static final MatchDocumentEnumerationType value2 = new MatchDocumentEnumerationType(_value2);
    public static final MatchDocumentEnumerationType value3 = new MatchDocumentEnumerationType(_value3);
    public static final MatchDocumentEnumerationType value4 = new MatchDocumentEnumerationType(_value4);
    public java.lang.String getValue() { return _value_;}
    public static MatchDocumentEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        MatchDocumentEnumerationType enumeration = (MatchDocumentEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static MatchDocumentEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
