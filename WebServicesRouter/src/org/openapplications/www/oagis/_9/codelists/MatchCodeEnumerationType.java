/**
 * MatchCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class MatchCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected MatchCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _value1 = "2";
    public static final java.lang.String _value2 = "3";
    public static final java.lang.String _value3 = "4";
    public static final MatchCodeEnumerationType value1 = new MatchCodeEnumerationType(_value1);
    public static final MatchCodeEnumerationType value2 = new MatchCodeEnumerationType(_value2);
    public static final MatchCodeEnumerationType value3 = new MatchCodeEnumerationType(_value3);
    public java.lang.String getValue() { return _value_;}
    public static MatchCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        MatchCodeEnumerationType enumeration = (MatchCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static MatchCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
