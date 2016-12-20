/**
 * PartyCategoryCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class PartyCategoryCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected PartyCategoryCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Organization = "Organization";
    public static final java.lang.String _Individual = "Individual";
    public static final PartyCategoryCodeEnumerationType Organization = new PartyCategoryCodeEnumerationType(_Organization);
    public static final PartyCategoryCodeEnumerationType Individual = new PartyCategoryCodeEnumerationType(_Individual);
    public java.lang.String getValue() { return _value_;}
    public static PartyCategoryCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        PartyCategoryCodeEnumerationType enumeration = (PartyCategoryCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static PartyCategoryCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
