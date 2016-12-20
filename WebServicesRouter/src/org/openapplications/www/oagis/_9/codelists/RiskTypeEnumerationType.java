/**
 * RiskTypeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class RiskTypeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected RiskTypeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _value1 = "Compliance with applicable laws and regulations";
    public static final java.lang.String _value2 = "Effectiveness and efficiency of operations";
    public static final java.lang.String _value3 = "Reliability of Financial Statements";
    public static final RiskTypeEnumerationType value1 = new RiskTypeEnumerationType(_value1);
    public static final RiskTypeEnumerationType value2 = new RiskTypeEnumerationType(_value2);
    public static final RiskTypeEnumerationType value3 = new RiskTypeEnumerationType(_value3);
    public java.lang.String getValue() { return _value_;}
    public static RiskTypeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        RiskTypeEnumerationType enumeration = (RiskTypeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static RiskTypeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
