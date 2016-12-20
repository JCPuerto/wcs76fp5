/**
 * PaymentMethodCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class PaymentMethodCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected PaymentMethodCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Cash = "Cash";
    public static final java.lang.String _Cheque = "Cheque";
    public static final java.lang.String _CreditCard = "CreditCard";
    public static final java.lang.String _DebitCard = "DebitCard";
    public static final java.lang.String _ElectronicFundsTransfer = "ElectronicFundsTransfer";
    public static final java.lang.String _ProcurementCard = "ProcurementCard";
    public static final java.lang.String _BankDraft = "BankDraft";
    public static final java.lang.String _PurchaseOrder = "PurchaseOrder";
    public static final java.lang.String _CreditTransfer = "CreditTransfer";
    public static final PaymentMethodCodeEnumerationType Cash = new PaymentMethodCodeEnumerationType(_Cash);
    public static final PaymentMethodCodeEnumerationType Cheque = new PaymentMethodCodeEnumerationType(_Cheque);
    public static final PaymentMethodCodeEnumerationType CreditCard = new PaymentMethodCodeEnumerationType(_CreditCard);
    public static final PaymentMethodCodeEnumerationType DebitCard = new PaymentMethodCodeEnumerationType(_DebitCard);
    public static final PaymentMethodCodeEnumerationType ElectronicFundsTransfer = new PaymentMethodCodeEnumerationType(_ElectronicFundsTransfer);
    public static final PaymentMethodCodeEnumerationType ProcurementCard = new PaymentMethodCodeEnumerationType(_ProcurementCard);
    public static final PaymentMethodCodeEnumerationType BankDraft = new PaymentMethodCodeEnumerationType(_BankDraft);
    public static final PaymentMethodCodeEnumerationType PurchaseOrder = new PaymentMethodCodeEnumerationType(_PurchaseOrder);
    public static final PaymentMethodCodeEnumerationType CreditTransfer = new PaymentMethodCodeEnumerationType(_CreditTransfer);
    public java.lang.String getValue() { return _value_;}
    public static PaymentMethodCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        PaymentMethodCodeEnumerationType enumeration = (PaymentMethodCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static PaymentMethodCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
