/**
 * AgencyRoleCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class AgencyRoleCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected AgencyRoleCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Customer = "Customer";
    public static final java.lang.String _Supplier = "Supplier";
    public static final java.lang.String _Manufacturer = "Manufacturer";
    public static final java.lang.String _Broker = "Broker";
    public static final java.lang.String _Carrier = "Carrier";
    public static final AgencyRoleCodeEnumerationType Customer = new AgencyRoleCodeEnumerationType(_Customer);
    public static final AgencyRoleCodeEnumerationType Supplier = new AgencyRoleCodeEnumerationType(_Supplier);
    public static final AgencyRoleCodeEnumerationType Manufacturer = new AgencyRoleCodeEnumerationType(_Manufacturer);
    public static final AgencyRoleCodeEnumerationType Broker = new AgencyRoleCodeEnumerationType(_Broker);
    public static final AgencyRoleCodeEnumerationType Carrier = new AgencyRoleCodeEnumerationType(_Carrier);
    public java.lang.String getValue() { return _value_;}
    public static AgencyRoleCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        AgencyRoleCodeEnumerationType enumeration = (AgencyRoleCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static AgencyRoleCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
