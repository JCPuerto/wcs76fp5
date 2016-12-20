/**
 * EngineeringActivityCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class EngineeringActivityCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected EngineeringActivityCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _amendment = "amendment";
    public static final java.lang.String _analysis = "analysis";
    public static final java.lang.String _cancellation = "cancellation";
    public static final java.lang.String _deliveryChange = "deliveryChange";
    public static final java.lang.String _designChange = "designChange";
    public static final java.lang.String _design = "design";
    public static final java.lang.String _mockUpCreation = "mockUpCreation";
    public static final java.lang.String _protoypeBuilding = "protoypeBuilding";
    public static final java.lang.String _rectification = "rectification";
    public static final java.lang.String _restructuring = "restructuring";
    public static final java.lang.String _sparePartCreation = "sparePartCreation";
    public static final java.lang.String _stopNotice = "stopNotice";
    public static final java.lang.String _testing = "testing";
    public static final EngineeringActivityCodeEnumerationType amendment = new EngineeringActivityCodeEnumerationType(_amendment);
    public static final EngineeringActivityCodeEnumerationType analysis = new EngineeringActivityCodeEnumerationType(_analysis);
    public static final EngineeringActivityCodeEnumerationType cancellation = new EngineeringActivityCodeEnumerationType(_cancellation);
    public static final EngineeringActivityCodeEnumerationType deliveryChange = new EngineeringActivityCodeEnumerationType(_deliveryChange);
    public static final EngineeringActivityCodeEnumerationType designChange = new EngineeringActivityCodeEnumerationType(_designChange);
    public static final EngineeringActivityCodeEnumerationType design = new EngineeringActivityCodeEnumerationType(_design);
    public static final EngineeringActivityCodeEnumerationType mockUpCreation = new EngineeringActivityCodeEnumerationType(_mockUpCreation);
    public static final EngineeringActivityCodeEnumerationType protoypeBuilding = new EngineeringActivityCodeEnumerationType(_protoypeBuilding);
    public static final EngineeringActivityCodeEnumerationType rectification = new EngineeringActivityCodeEnumerationType(_rectification);
    public static final EngineeringActivityCodeEnumerationType restructuring = new EngineeringActivityCodeEnumerationType(_restructuring);
    public static final EngineeringActivityCodeEnumerationType sparePartCreation = new EngineeringActivityCodeEnumerationType(_sparePartCreation);
    public static final EngineeringActivityCodeEnumerationType stopNotice = new EngineeringActivityCodeEnumerationType(_stopNotice);
    public static final EngineeringActivityCodeEnumerationType testing = new EngineeringActivityCodeEnumerationType(_testing);
    public java.lang.String getValue() { return _value_;}
    public static EngineeringActivityCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        EngineeringActivityCodeEnumerationType enumeration = (EngineeringActivityCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static EngineeringActivityCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
