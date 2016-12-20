/**
 * ActionCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class ActionCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected ActionCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _Add = "Add";
    public static final java.lang.String _Change = "Change";
    public static final java.lang.String _Delete = "Delete";
    public static final java.lang.String _Replace = "Replace";
    public static final java.lang.String _Accepted = "Accepted";
    public static final java.lang.String _Modified = "Modified";
    public static final java.lang.String _Rejected = "Rejected";
    public static final ActionCodeEnumerationType Add = new ActionCodeEnumerationType(_Add);
    public static final ActionCodeEnumerationType Change = new ActionCodeEnumerationType(_Change);
    public static final ActionCodeEnumerationType Delete = new ActionCodeEnumerationType(_Delete);
    public static final ActionCodeEnumerationType Replace = new ActionCodeEnumerationType(_Replace);
    public static final ActionCodeEnumerationType Accepted = new ActionCodeEnumerationType(_Accepted);
    public static final ActionCodeEnumerationType Modified = new ActionCodeEnumerationType(_Modified);
    public static final ActionCodeEnumerationType Rejected = new ActionCodeEnumerationType(_Rejected);
    public java.lang.String getValue() { return _value_;}
    public static ActionCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        ActionCodeEnumerationType enumeration = (ActionCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static ActionCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
