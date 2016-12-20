/**
 * PaymentBasisCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class PaymentBasisCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected PaymentBasisCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _InvoiceDate = "InvoiceDate";
    public static final java.lang.String _ShippingDate = "ShippingDate";
    public static final java.lang.String _DeliveryDate = "DeliveryDate";
    public static final java.lang.String _PurchaseOrderDate = "PurchaseOrderDate";
    public static final java.lang.String _ReceiptOfGoodsDate = "ReceiptOfGoodsDate";
    public static final java.lang.String _AcceptanceOfGoodsDate = "AcceptanceOfGoodsDate";
    public static final java.lang.String _AcceptanceOfOrderDate = "AcceptanceOfOrderDate";
    public static final PaymentBasisCodeEnumerationType InvoiceDate = new PaymentBasisCodeEnumerationType(_InvoiceDate);
    public static final PaymentBasisCodeEnumerationType ShippingDate = new PaymentBasisCodeEnumerationType(_ShippingDate);
    public static final PaymentBasisCodeEnumerationType DeliveryDate = new PaymentBasisCodeEnumerationType(_DeliveryDate);
    public static final PaymentBasisCodeEnumerationType PurchaseOrderDate = new PaymentBasisCodeEnumerationType(_PurchaseOrderDate);
    public static final PaymentBasisCodeEnumerationType ReceiptOfGoodsDate = new PaymentBasisCodeEnumerationType(_ReceiptOfGoodsDate);
    public static final PaymentBasisCodeEnumerationType AcceptanceOfGoodsDate = new PaymentBasisCodeEnumerationType(_AcceptanceOfGoodsDate);
    public static final PaymentBasisCodeEnumerationType AcceptanceOfOrderDate = new PaymentBasisCodeEnumerationType(_AcceptanceOfOrderDate);
    public java.lang.String getValue() { return _value_;}
    public static PaymentBasisCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        PaymentBasisCodeEnumerationType enumeration = (PaymentBasisCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static PaymentBasisCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
