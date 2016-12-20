/**
 * ControlCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class ControlCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected ControlCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Trigger = "Trigger";
    public static final java.lang.String _Workflow = "Workflow";
    public static final java.lang.String _Measurement = "Measurement";
    public static final ControlCodeEnumerationType Trigger = new ControlCodeEnumerationType(_Trigger);
    public static final ControlCodeEnumerationType Workflow = new ControlCodeEnumerationType(_Workflow);
    public static final ControlCodeEnumerationType Measurement = new ControlCodeEnumerationType(_Measurement);
    public java.lang.String getValue() { return _value_;}
    public static ControlCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        ControlCodeEnumerationType enumeration = (ControlCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static ControlCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
