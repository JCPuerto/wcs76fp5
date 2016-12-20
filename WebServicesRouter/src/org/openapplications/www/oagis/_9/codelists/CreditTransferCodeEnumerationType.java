/**
 * CreditTransferCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class CreditTransferCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected CreditTransferCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _CASH = "CASH";
    public static final java.lang.String _CORT = "CORT";
    public static final java.lang.String _DIVI = "DIVI";
    public static final java.lang.String _GOVT = "GOVT";
    public static final java.lang.String _HEDG = "HEDG";
    public static final java.lang.String _INTC = "INTC";
    public static final java.lang.String _INTE = "INTE";
    public static final java.lang.String _LOAN = "LOAN";
    public static final java.lang.String _PENS = "PENS";
    public static final java.lang.String _SALA = "SALA";
    public static final java.lang.String _SECU = "SECU";
    public static final java.lang.String _SSBE = "SSBE";
    public static final java.lang.String _SUPP = "SUPP";
    public static final java.lang.String _TAXS = "TAXS";
    public static final java.lang.String _TRAD = "TRAD";
    public static final java.lang.String _TREA = "TREA";
    public static final java.lang.String _VATX = "VATX";
    public static final CreditTransferCodeEnumerationType CASH = new CreditTransferCodeEnumerationType(_CASH);
    public static final CreditTransferCodeEnumerationType CORT = new CreditTransferCodeEnumerationType(_CORT);
    public static final CreditTransferCodeEnumerationType DIVI = new CreditTransferCodeEnumerationType(_DIVI);
    public static final CreditTransferCodeEnumerationType GOVT = new CreditTransferCodeEnumerationType(_GOVT);
    public static final CreditTransferCodeEnumerationType HEDG = new CreditTransferCodeEnumerationType(_HEDG);
    public static final CreditTransferCodeEnumerationType INTC = new CreditTransferCodeEnumerationType(_INTC);
    public static final CreditTransferCodeEnumerationType INTE = new CreditTransferCodeEnumerationType(_INTE);
    public static final CreditTransferCodeEnumerationType LOAN = new CreditTransferCodeEnumerationType(_LOAN);
    public static final CreditTransferCodeEnumerationType PENS = new CreditTransferCodeEnumerationType(_PENS);
    public static final CreditTransferCodeEnumerationType SALA = new CreditTransferCodeEnumerationType(_SALA);
    public static final CreditTransferCodeEnumerationType SECU = new CreditTransferCodeEnumerationType(_SECU);
    public static final CreditTransferCodeEnumerationType SSBE = new CreditTransferCodeEnumerationType(_SSBE);
    public static final CreditTransferCodeEnumerationType SUPP = new CreditTransferCodeEnumerationType(_SUPP);
    public static final CreditTransferCodeEnumerationType TAXS = new CreditTransferCodeEnumerationType(_TAXS);
    public static final CreditTransferCodeEnumerationType TRAD = new CreditTransferCodeEnumerationType(_TRAD);
    public static final CreditTransferCodeEnumerationType TREA = new CreditTransferCodeEnumerationType(_TREA);
    public static final CreditTransferCodeEnumerationType VATX = new CreditTransferCodeEnumerationType(_VATX);
    public java.lang.String getValue() { return _value_;}
    public static CreditTransferCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        CreditTransferCodeEnumerationType enumeration = (CreditTransferCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static CreditTransferCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
