/**
 * DayOfWeekCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class DayOfWeekCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected DayOfWeekCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Sunday = "Sunday";
    public static final java.lang.String _Monday = "Monday";
    public static final java.lang.String _Tuesday = "Tuesday";
    public static final java.lang.String _Wednesday = "Wednesday";
    public static final java.lang.String _Thursday = "Thursday";
    public static final java.lang.String _Friday = "Friday";
    public static final java.lang.String _Saturday = "Saturday";
    public static final DayOfWeekCodeEnumerationType Sunday = new DayOfWeekCodeEnumerationType(_Sunday);
    public static final DayOfWeekCodeEnumerationType Monday = new DayOfWeekCodeEnumerationType(_Monday);
    public static final DayOfWeekCodeEnumerationType Tuesday = new DayOfWeekCodeEnumerationType(_Tuesday);
    public static final DayOfWeekCodeEnumerationType Wednesday = new DayOfWeekCodeEnumerationType(_Wednesday);
    public static final DayOfWeekCodeEnumerationType Thursday = new DayOfWeekCodeEnumerationType(_Thursday);
    public static final DayOfWeekCodeEnumerationType Friday = new DayOfWeekCodeEnumerationType(_Friday);
    public static final DayOfWeekCodeEnumerationType Saturday = new DayOfWeekCodeEnumerationType(_Saturday);
    public java.lang.String getValue() { return _value_;}
    public static DayOfWeekCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        DayOfWeekCodeEnumerationType enumeration = (DayOfWeekCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static DayOfWeekCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
