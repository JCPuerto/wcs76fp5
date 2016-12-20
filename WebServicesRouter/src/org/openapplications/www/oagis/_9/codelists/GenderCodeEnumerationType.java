/**
 * GenderCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class GenderCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected GenderCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Male = "Male";
    public static final java.lang.String _Female = "Female";
    public static final java.lang.String _Unknown = "Unknown";
    public static final GenderCodeEnumerationType Male = new GenderCodeEnumerationType(_Male);
    public static final GenderCodeEnumerationType Female = new GenderCodeEnumerationType(_Female);
    public static final GenderCodeEnumerationType Unknown = new GenderCodeEnumerationType(_Unknown);
    public java.lang.String getValue() { return _value_;}
    public static GenderCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        GenderCodeEnumerationType enumeration = (GenderCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static GenderCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
