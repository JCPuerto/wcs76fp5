/**
 * EMailFormatCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class EMailFormatCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected EMailFormatCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _value1 = "HTML";
    public static final java.lang.String _value2 = "Rich Text";
    public static final java.lang.String _value3 = "Plain Text";
    public static final EMailFormatCodeEnumerationType value1 = new EMailFormatCodeEnumerationType(_value1);
    public static final EMailFormatCodeEnumerationType value2 = new EMailFormatCodeEnumerationType(_value2);
    public static final EMailFormatCodeEnumerationType value3 = new EMailFormatCodeEnumerationType(_value3);
    public java.lang.String getValue() { return _value_;}
    public static EMailFormatCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        EMailFormatCodeEnumerationType enumeration = (EMailFormatCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static EMailFormatCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
