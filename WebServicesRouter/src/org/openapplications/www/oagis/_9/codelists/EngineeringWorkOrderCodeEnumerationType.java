/**
 * EngineeringWorkOrderCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class EngineeringWorkOrderCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected EngineeringWorkOrderCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _designDeviationPermit = "designDeviationPermit";
    public static final java.lang.String _designRelease = "designRelease";
    public static final java.lang.String _managementResolution = "managementResolution";
    public static final java.lang.String _manufacturingRelease = "manufacturingRelease";
    public static final java.lang.String _productionDeviationPermit = "productionDeviationPermit";
    public static final EngineeringWorkOrderCodeEnumerationType designDeviationPermit = new EngineeringWorkOrderCodeEnumerationType(_designDeviationPermit);
    public static final EngineeringWorkOrderCodeEnumerationType designRelease = new EngineeringWorkOrderCodeEnumerationType(_designRelease);
    public static final EngineeringWorkOrderCodeEnumerationType managementResolution = new EngineeringWorkOrderCodeEnumerationType(_managementResolution);
    public static final EngineeringWorkOrderCodeEnumerationType manufacturingRelease = new EngineeringWorkOrderCodeEnumerationType(_manufacturingRelease);
    public static final EngineeringWorkOrderCodeEnumerationType productionDeviationPermit = new EngineeringWorkOrderCodeEnumerationType(_productionDeviationPermit);
    public java.lang.String getValue() { return _value_;}
    public static EngineeringWorkOrderCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        EngineeringWorkOrderCodeEnumerationType enumeration = (EngineeringWorkOrderCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static EngineeringWorkOrderCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
