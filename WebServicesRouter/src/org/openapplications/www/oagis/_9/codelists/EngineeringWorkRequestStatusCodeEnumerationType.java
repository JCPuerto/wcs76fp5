/**
 * EngineeringWorkRequestStatusCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class EngineeringWorkRequestStatusCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected EngineeringWorkRequestStatusCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _inWork = "inWork";
    public static final java.lang.String _issued = "issued";
    public static final EngineeringWorkRequestStatusCodeEnumerationType inWork = new EngineeringWorkRequestStatusCodeEnumerationType(_inWork);
    public static final EngineeringWorkRequestStatusCodeEnumerationType issued = new EngineeringWorkRequestStatusCodeEnumerationType(_issued);
    public java.lang.String getValue() { return _value_;}
    public static EngineeringWorkRequestStatusCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        EngineeringWorkRequestStatusCodeEnumerationType enumeration = (EngineeringWorkRequestStatusCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static EngineeringWorkRequestStatusCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
