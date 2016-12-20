/**
 * FinalAgentInstructionCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class FinalAgentInstructionCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected FinalAgentInstructionCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _CHQB = "CHQB";
    public static final java.lang.String _HOLD = "HOLD";
    public static final java.lang.String _PHOB = "PHOB";
    public static final java.lang.String _TELB = "TELB";
    public static final FinalAgentInstructionCodeEnumerationType CHQB = new FinalAgentInstructionCodeEnumerationType(_CHQB);
    public static final FinalAgentInstructionCodeEnumerationType HOLD = new FinalAgentInstructionCodeEnumerationType(_HOLD);
    public static final FinalAgentInstructionCodeEnumerationType PHOB = new FinalAgentInstructionCodeEnumerationType(_PHOB);
    public static final FinalAgentInstructionCodeEnumerationType TELB = new FinalAgentInstructionCodeEnumerationType(_TELB);
    public java.lang.String getValue() { return _value_;}
    public static FinalAgentInstructionCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        FinalAgentInstructionCodeEnumerationType enumeration = (FinalAgentInstructionCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static FinalAgentInstructionCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
