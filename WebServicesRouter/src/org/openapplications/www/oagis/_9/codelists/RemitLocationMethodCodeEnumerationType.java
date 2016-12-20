/**
 * RemitLocationMethodCodeEnumerationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.codelists;

public class RemitLocationMethodCodeEnumerationType  {
    private java.lang.String _value_;
    private static java.util.HashMap _table_ = new java.util.HashMap();

    // Constructor
    protected RemitLocationMethodCodeEnumerationType(java.lang.String value) {
        _value_ = value;
        _table_.put(_value_,this);
    };

    public static final java.lang.String _FAX = "FAX";
    public static final java.lang.String _EDI = "EDI";
    public static final java.lang.String _URI = "URI";
    public static final java.lang.String _EML = "EML";
    public static final java.lang.String _PST = "PST";
    public static final RemitLocationMethodCodeEnumerationType FAX = new RemitLocationMethodCodeEnumerationType(_FAX);
    public static final RemitLocationMethodCodeEnumerationType EDI = new RemitLocationMethodCodeEnumerationType(_EDI);
    public static final RemitLocationMethodCodeEnumerationType URI = new RemitLocationMethodCodeEnumerationType(_URI);
    public static final RemitLocationMethodCodeEnumerationType EML = new RemitLocationMethodCodeEnumerationType(_EML);
    public static final RemitLocationMethodCodeEnumerationType PST = new RemitLocationMethodCodeEnumerationType(_PST);
    public java.lang.String getValue() { return _value_;}
    public static RemitLocationMethodCodeEnumerationType fromValue(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        RemitLocationMethodCodeEnumerationType enumeration = (RemitLocationMethodCodeEnumerationType)
            _table_.get(value);
        if (enumeration==null) throw new java.lang.IllegalArgumentException();
        return enumeration;
    }
    public static RemitLocationMethodCodeEnumerationType fromString(java.lang.String value)
          throws java.lang.IllegalArgumentException {
        return fromValue(value);
    }
    public boolean equals(java.lang.Object obj) {return (obj == this);}
    public int hashCode() { return toString().hashCode();}
    public java.lang.String toString() { return _value_;}

}
