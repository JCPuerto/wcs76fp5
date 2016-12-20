/**
 * ChequeDeliveryMethodCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class ChequeDeliveryMethodCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected ChequeDeliveryMethodCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _MLDB = "MLDB";
    public static final java.lang.String _MLCD = "MLCD";
    public static final java.lang.String _MLFA = "MLFA";
    public static final java.lang.String _CRDB = "CRDB";
    public static final java.lang.String _CRCD = "CRCD";
    public static final java.lang.String _CRFA = "CRFA";
    public static final java.lang.String _PUDB = "PUDB";
    public static final java.lang.String _PUCD = "PUCD";
    public static final java.lang.String _PUFA = "PUFA";
    public static final java.lang.String _RGDB = "RGDB";
    public static final java.lang.String _RGCD = "RGCD";
    public static final java.lang.String _RGFA = "RGFA";
    public static final ChequeDeliveryMethodCodeEnumerationType MLDB = new ChequeDeliveryMethodCodeEnumerationType(_MLDB);
    public static final ChequeDeliveryMethodCodeEnumerationType MLCD = new ChequeDeliveryMethodCodeEnumerationType(_MLCD);
    public static final ChequeDeliveryMethodCodeEnumerationType MLFA = new ChequeDeliveryMethodCodeEnumerationType(_MLFA);
    public static final ChequeDeliveryMethodCodeEnumerationType CRDB = new ChequeDeliveryMethodCodeEnumerationType(_CRDB);
    public static final ChequeDeliveryMethodCodeEnumerationType CRCD = new ChequeDeliveryMethodCodeEnumerationType(_CRCD);
    public static final ChequeDeliveryMethodCodeEnumerationType CRFA = new ChequeDeliveryMethodCodeEnumerationType(_CRFA);
    public static final ChequeDeliveryMethodCodeEnumerationType PUDB = new ChequeDeliveryMethodCodeEnumerationType(_PUDB);
    public static final ChequeDeliveryMethodCodeEnumerationType PUCD = new ChequeDeliveryMethodCodeEnumerationType(_PUCD);
    public static final ChequeDeliveryMethodCodeEnumerationType PUFA = new ChequeDeliveryMethodCodeEnumerationType(_PUFA);
    public static final ChequeDeliveryMethodCodeEnumerationType RGDB = new ChequeDeliveryMethodCodeEnumerationType(_RGDB);
    public static final ChequeDeliveryMethodCodeEnumerationType RGCD = new ChequeDeliveryMethodCodeEnumerationType(_RGCD);
    public static final ChequeDeliveryMethodCodeEnumerationType RGFA = new ChequeDeliveryMethodCodeEnumerationType(_RGFA);
    public java.lang.String getValue() { return _value_;}
    public static ChequeDeliveryMethodCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        ChequeDeliveryMethodCodeEnumerationType enumeration = (ChequeDeliveryMethodCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static ChequeDeliveryMethodCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
