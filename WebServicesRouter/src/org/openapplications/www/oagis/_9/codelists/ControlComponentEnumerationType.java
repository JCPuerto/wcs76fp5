/**
 * ControlComponentEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class ControlComponentEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected ControlComponentEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _value1 = "Risk Assessment";
    public static final java.lang.String _value2 = "Monitoring";
    public static final java.lang.String _value3 = "Control Environment";
    public static final java.lang.String _value4 = "Control Activities";
    public static final java.lang.String _value5 = "Information and Communication";
    public static final ControlComponentEnumerationType value1 = new ControlComponentEnumerationType(_value1);
    public static final ControlComponentEnumerationType value2 = new ControlComponentEnumerationType(_value2);
    public static final ControlComponentEnumerationType value3 = new ControlComponentEnumerationType(_value3);
    public static final ControlComponentEnumerationType value4 = new ControlComponentEnumerationType(_value4);
    public static final ControlComponentEnumerationType value5 = new ControlComponentEnumerationType(_value5);
    public java.lang.String getValue() { return _value_;}
    public static ControlComponentEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        ControlComponentEnumerationType enumeration = (ControlComponentEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static ControlComponentEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
