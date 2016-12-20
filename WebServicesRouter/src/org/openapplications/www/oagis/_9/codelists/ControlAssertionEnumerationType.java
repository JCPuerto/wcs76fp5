/**
 * ControlAssertionEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class ControlAssertionEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected ControlAssertionEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _value1 = "Completeness";
    public static final java.lang.String _value2 = "Existence or Occurance";
    public static final java.lang.String _value3 = "Presentation and Disclosure";
    public static final java.lang.String _value4 = "Rights and Obligations";
    public static final java.lang.String _value5 = "Valuation or Measurement";
    public static final ControlAssertionEnumerationType value1 = new ControlAssertionEnumerationType(_value1);
    public static final ControlAssertionEnumerationType value2 = new ControlAssertionEnumerationType(_value2);
    public static final ControlAssertionEnumerationType value3 = new ControlAssertionEnumerationType(_value3);
    public static final ControlAssertionEnumerationType value4 = new ControlAssertionEnumerationType(_value4);
    public static final ControlAssertionEnumerationType value5 = new ControlAssertionEnumerationType(_value5);
    public java.lang.String getValue() { return _value_;}
    public static ControlAssertionEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        ControlAssertionEnumerationType enumeration = (ControlAssertionEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static ControlAssertionEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
