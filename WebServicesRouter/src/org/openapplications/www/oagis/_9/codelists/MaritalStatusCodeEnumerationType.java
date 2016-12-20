/**
 * MaritalStatusCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class MaritalStatusCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected MaritalStatusCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Divorced = "Divorced";
    public static final java.lang.String _Married = "Married";
    public static final java.lang.String _NeverMarried = "NeverMarried";
    public static final java.lang.String _Separated = "Separated";
    public static final java.lang.String _SignificantOther = "SignificantOther";
    public static final java.lang.String _Widowed = "Widowed";
    public static final java.lang.String _Unknown = "Unknown";
    public static final MaritalStatusCodeEnumerationType Divorced = new MaritalStatusCodeEnumerationType(_Divorced);
    public static final MaritalStatusCodeEnumerationType Married = new MaritalStatusCodeEnumerationType(_Married);
    public static final MaritalStatusCodeEnumerationType NeverMarried = new MaritalStatusCodeEnumerationType(_NeverMarried);
    public static final MaritalStatusCodeEnumerationType Separated = new MaritalStatusCodeEnumerationType(_Separated);
    public static final MaritalStatusCodeEnumerationType SignificantOther = new MaritalStatusCodeEnumerationType(_SignificantOther);
    public static final MaritalStatusCodeEnumerationType Widowed = new MaritalStatusCodeEnumerationType(_Widowed);
    public static final MaritalStatusCodeEnumerationType Unknown = new MaritalStatusCodeEnumerationType(_Unknown);
    public java.lang.String getValue() { return _value_;}
    public static MaritalStatusCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        MaritalStatusCodeEnumerationType enumeration = (MaritalStatusCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static MaritalStatusCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
