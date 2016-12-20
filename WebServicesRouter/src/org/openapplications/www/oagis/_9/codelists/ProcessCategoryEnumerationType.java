/**
 * ProcessCategoryEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class ProcessCategoryEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected ProcessCategoryEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _value1 = "Routine";
    public static final java.lang.String _value2 = "Non-Routine";
    public static final java.lang.String _value3 = "Estimating";
    public static final ProcessCategoryEnumerationType value1 = new ProcessCategoryEnumerationType(_value1);
    public static final ProcessCategoryEnumerationType value2 = new ProcessCategoryEnumerationType(_value2);
    public static final ProcessCategoryEnumerationType value3 = new ProcessCategoryEnumerationType(_value3);
    public java.lang.String getValue() { return _value_;}
    public static ProcessCategoryEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        ProcessCategoryEnumerationType enumeration = (ProcessCategoryEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static ProcessCategoryEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
