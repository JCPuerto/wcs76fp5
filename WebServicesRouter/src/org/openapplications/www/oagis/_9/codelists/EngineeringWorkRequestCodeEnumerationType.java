/**
 * EngineeringWorkRequestCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class EngineeringWorkRequestCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected EngineeringWorkRequestCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _ChangeOfStandard = "ChangeOfStandard";
    public static final java.lang.String _CostReduction = "CostReduction";
    public static final java.lang.String _CustomerRejection = "CustomerRejection";
    public static final java.lang.String _CustomerRequest = "CustomerRequest";
    public static final java.lang.String _DurabilityImprovement = "DurabilityImprovement";
    public static final java.lang.String _GovernmentRegulation = "GovernmentRegulation";
    public static final java.lang.String _ProcurementAlignment = "ProcurementAlignment";
    public static final java.lang.String _ProductionAlignment = "ProductionAlignment";
    public static final java.lang.String _ProductionRelief = "ProductionRelief";
    public static final java.lang.String _ProductionRequirement = "ProductionRequirement";
    public static final java.lang.String _QualityImprovement = "QualityImprovement";
    public static final java.lang.String _SecuriyReason = "SecuriyReason";
    public static final java.lang.String _Standardization = "Standardization";
    public static final java.lang.String _SupplierRequest = "SupplierRequest";
    public static final java.lang.String _TechnicalImprovement = "TechnicalImprovement";
    public static final java.lang.String _ToolImprovement = "ToolImprovement";
    public static final EngineeringWorkRequestCodeEnumerationType ChangeOfStandard = new EngineeringWorkRequestCodeEnumerationType(_ChangeOfStandard);
    public static final EngineeringWorkRequestCodeEnumerationType CostReduction = new EngineeringWorkRequestCodeEnumerationType(_CostReduction);
    public static final EngineeringWorkRequestCodeEnumerationType CustomerRejection = new EngineeringWorkRequestCodeEnumerationType(_CustomerRejection);
    public static final EngineeringWorkRequestCodeEnumerationType CustomerRequest = new EngineeringWorkRequestCodeEnumerationType(_CustomerRequest);
    public static final EngineeringWorkRequestCodeEnumerationType DurabilityImprovement = new EngineeringWorkRequestCodeEnumerationType(_DurabilityImprovement);
    public static final EngineeringWorkRequestCodeEnumerationType GovernmentRegulation = new EngineeringWorkRequestCodeEnumerationType(_GovernmentRegulation);
    public static final EngineeringWorkRequestCodeEnumerationType ProcurementAlignment = new EngineeringWorkRequestCodeEnumerationType(_ProcurementAlignment);
    public static final EngineeringWorkRequestCodeEnumerationType ProductionAlignment = new EngineeringWorkRequestCodeEnumerationType(_ProductionAlignment);
    public static final EngineeringWorkRequestCodeEnumerationType ProductionRelief = new EngineeringWorkRequestCodeEnumerationType(_ProductionRelief);
    public static final EngineeringWorkRequestCodeEnumerationType ProductionRequirement = new EngineeringWorkRequestCodeEnumerationType(_ProductionRequirement);
    public static final EngineeringWorkRequestCodeEnumerationType QualityImprovement = new EngineeringWorkRequestCodeEnumerationType(_QualityImprovement);
    public static final EngineeringWorkRequestCodeEnumerationType SecuriyReason = new EngineeringWorkRequestCodeEnumerationType(_SecuriyReason);
    public static final EngineeringWorkRequestCodeEnumerationType Standardization = new EngineeringWorkRequestCodeEnumerationType(_Standardization);
    public static final EngineeringWorkRequestCodeEnumerationType SupplierRequest = new EngineeringWorkRequestCodeEnumerationType(_SupplierRequest);
    public static final EngineeringWorkRequestCodeEnumerationType TechnicalImprovement = new EngineeringWorkRequestCodeEnumerationType(_TechnicalImprovement);
    public static final EngineeringWorkRequestCodeEnumerationType ToolImprovement = new EngineeringWorkRequestCodeEnumerationType(_ToolImprovement);
    public java.lang.String getValue() { return _value_;}
    public static EngineeringWorkRequestCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        EngineeringWorkRequestCodeEnumerationType enumeration = (EngineeringWorkRequestCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static EngineeringWorkRequestCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
