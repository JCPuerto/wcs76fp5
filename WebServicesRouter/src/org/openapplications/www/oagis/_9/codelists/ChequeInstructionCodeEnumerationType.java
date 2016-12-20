/**
 * ChequeInstructionCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class ChequeInstructionCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected ChequeInstructionCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _CCHQ = "CCHQ";
    public static final java.lang.String _CCCH = "CCCH";
    public static final java.lang.String _BCHQ = "BCHQ";
    public static final java.lang.String _DFFT = "DFFT";
    public static final java.lang.String _ELDR = "ELDR";
    public static final ChequeInstructionCodeEnumerationType CCHQ = new ChequeInstructionCodeEnumerationType(_CCHQ);
    public static final ChequeInstructionCodeEnumerationType CCCH = new ChequeInstructionCodeEnumerationType(_CCCH);
    public static final ChequeInstructionCodeEnumerationType BCHQ = new ChequeInstructionCodeEnumerationType(_BCHQ);
    public static final ChequeInstructionCodeEnumerationType DFFT = new ChequeInstructionCodeEnumerationType(_DFFT);
    public static final ChequeInstructionCodeEnumerationType ELDR = new ChequeInstructionCodeEnumerationType(_ELDR);
    public java.lang.String getValue() { return _value_;}
    public static ChequeInstructionCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        ChequeInstructionCodeEnumerationType enumeration = (ChequeInstructionCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static ChequeInstructionCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
