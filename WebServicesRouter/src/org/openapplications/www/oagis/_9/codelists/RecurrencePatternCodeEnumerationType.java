/**
 * RecurrencePatternCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class RecurrencePatternCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected RecurrencePatternCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Daily = "Daily";
    public static final java.lang.String _Weekly = "Weekly";
    public static final java.lang.String _Monthly = "Monthly";
    public static final java.lang.String _Yearly = "Yearly";
    public static final RecurrencePatternCodeEnumerationType Daily = new RecurrencePatternCodeEnumerationType(_Daily);
    public static final RecurrencePatternCodeEnumerationType Weekly = new RecurrencePatternCodeEnumerationType(_Weekly);
    public static final RecurrencePatternCodeEnumerationType Monthly = new RecurrencePatternCodeEnumerationType(_Monthly);
    public static final RecurrencePatternCodeEnumerationType Yearly = new RecurrencePatternCodeEnumerationType(_Yearly);
    public java.lang.String getValue() { return _value_;}
    public static RecurrencePatternCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        RecurrencePatternCodeEnumerationType enumeration = (RecurrencePatternCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static RecurrencePatternCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
