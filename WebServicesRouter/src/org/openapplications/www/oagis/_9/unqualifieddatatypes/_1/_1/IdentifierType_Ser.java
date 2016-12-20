/**
 * IdentifierType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.unqualifieddatatypes._1._1;

public class IdentifierType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.SimpleBeanSerializer {
    /**
     * Constructor
     */
    public IdentifierType_Ser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    public void serialize(
        javax.xml.namespace.QName name,
        org.xml.sax.Attributes attributes,
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        java.lang.String stringValue = getValueAsString(value, context);
        context.simpleElement(name,
                              addAttributes(attributes, value, context),
                              stringValue);
    }
    public java.lang.String getValueAsString(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
    {
        IdentifierType bean = (IdentifierType) value;
        java.lang.Object propValue = null;
        java.lang.String retValue = "";
        propValue = bean.get_value();
        if (propValue != null) {
          javax.xml.namespace.QName  typeQName = QName_3_12;
          try {
            retValue = context.getValueAsString(propValue, typeQName);
          } catch (Exception _e) {
            throw new java.lang.RuntimeException(_e);
          }
        }
        return retValue;
    }
    protected org.xml.sax.Attributes addAttributes(
        org.xml.sax.Attributes attributes,
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        IdentifierType bean = (IdentifierType) value;
        java.lang.Object propValue;
        org.xml.sax.helpers.AttributesImpl attrs;
        if (attributes==null || attributes.getLength() == 0) {
          attrs = new org.xml.sax.helpers.AttributesImpl();
        } else {
          attrs = new org.xml.sax.helpers.AttributesImpl(attributes);
        }
        {
          javax.xml.namespace.QName attrQName;
          javax.xml.namespace.QName attrTypeQName;
          propValue = bean.getSchemeID();
          if (propValue != null) {        
            attrQName = QName_0_27;
            attrTypeQName = QName_3_12;
            attrs.addAttribute(
              "",
              "schemeID",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getSchemeName();
          if (propValue != null) {        
            attrQName = QName_0_28;
            attrTypeQName = QName_3_8;
            attrs.addAttribute(
              "",
              "schemeName",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getSchemeAgencyID();
          if (propValue != null) {        
            attrQName = QName_0_29;
            attrTypeQName = QName_3_12;
            attrs.addAttribute(
              "",
              "schemeAgencyID",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getSchemeAgencyName();
          if (propValue != null) {        
            attrQName = QName_0_30;
            attrTypeQName = QName_3_8;
            attrs.addAttribute(
              "",
              "schemeAgencyName",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getSchemeVersionID();
          if (propValue != null) {        
            attrQName = QName_0_31;
            attrTypeQName = QName_3_12;
            attrs.addAttribute(
              "",
              "schemeVersionID",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getSchemeDataURI();
          if (propValue != null) {        
            attrQName = QName_0_32;
            attrTypeQName = QName_3_15;
            attrs.addAttribute(
              "",
              "schemeDataURI",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getSchemeURI();
          if (propValue != null) {        
            attrQName = QName_0_33;
            attrTypeQName = QName_3_15;
            attrs.addAttribute(
              "",
              "schemeURI",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
        }
        attributes = attrs;
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        java.lang.String stringValue = getValueAsString(value, context);
        context.simpleElement(null, null, stringValue);
    }
    private final static javax.xml.namespace.QName QName_0_30 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "schemeAgencyName");
    private final static javax.xml.namespace.QName QName_0_33 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "schemeURI");
    private final static javax.xml.namespace.QName QName_0_28 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "schemeName");
    private final static javax.xml.namespace.QName QName_0_27 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "schemeID");
    private final static javax.xml.namespace.QName QName_0_29 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "schemeAgencyID");
    private final static javax.xml.namespace.QName QName_3_15 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "anyURI");
    private final static javax.xml.namespace.QName QName_0_31 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "schemeVersionID");
    private final static javax.xml.namespace.QName QName_3_8 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "string");
    private final static javax.xml.namespace.QName QName_0_32 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "schemeDataURI");
    private final static javax.xml.namespace.QName QName_3_12 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "normalizedString");
    private final static javax.xml.namespace.QName QName_0_2 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "_value");
}
