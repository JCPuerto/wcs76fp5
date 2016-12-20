/**
 * ContactLocationCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class ContactLocationCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected ContactLocationCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Home = "Home";
    public static final java.lang.String _Work = "Work";
    public static final ContactLocationCodeEnumerationType Home = new ContactLocationCodeEnumerationType(_Home);
    public static final ContactLocationCodeEnumerationType Work = new ContactLocationCodeEnumerationType(_Work);
    public java.lang.String getValue() { return _value_;}
    public static ContactLocationCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        ContactLocationCodeEnumerationType enumeration = (ContactLocationCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static ContactLocationCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}