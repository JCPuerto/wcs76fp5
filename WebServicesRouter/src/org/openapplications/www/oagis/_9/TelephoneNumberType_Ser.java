/**
 * TelephoneNumberType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class TelephoneNumberType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.SimpleBeanSerializer {
    /**
     * Constructor
     */
    public TelephoneNumberType_Ser(
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
        TelephoneNumberType bean = (TelephoneNumberType) value;
        java.lang.Object propValue = null;
        java.lang.String retValue = "";
        propValue = bean.get_value();
        if (propValue != null) {
          javax.xml.namespace.QName  typeQName = QName_1_289;
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
        TelephoneNumberType bean = (TelephoneNumberType) value;
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
          propValue = bean.getNumberFormat();
          if (propValue != null) {        
            attrQName = QName_0_290;
            attrTypeQName = QName_1_39;
            attrs.addAttribute(
              "",
              "numberFormat",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getAccessCode();
          if (propValue != null) {        
            attrQName = QName_0_291;
            attrTypeQName = QName_1_91;
            attrs.addAttribute(
              "",
              "accessCode",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getCountryCode();
          if (propValue != null) {        
            attrQName = QName_0_292;
            attrTypeQName = QName_1_91;
            attrs.addAttribute(
              "",
              "countryCode",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getAreaCode();
          if (propValue != null) {        
            attrQName = QName_0_293;
            attrTypeQName = QName_1_91;
            attrs.addAttribute(
              "",
              "areaCode",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getExchangeCode();
          if (propValue != null) {        
            attrQName = QName_0_294;
            attrTypeQName = QName_1_91;
            attrs.addAttribute(
              "",
              "exchangeCode",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getExtension();
          if (propValue != null) {        
            attrQName = QName_0_295;
            attrTypeQName = QName_1_91;
            attrs.addAttribute(
              "",
              "extension",
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
    private final static javax.xml.namespace.QName QName_1_289 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "StringType");
    private final static javax.xml.namespace.QName QName_0_294 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "exchangeCode");
    private final static javax.xml.namespace.QName QName_1_39 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NormalizedStringType");
    private final static javax.xml.namespace.QName QName_0_291 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "accessCode");
    private final static javax.xml.namespace.QName QName_0_292 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "countryCode");
    private final static javax.xml.namespace.QName QName_0_293 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "areaCode");
    private final static javax.xml.namespace.QName QName_1_91 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PositiveIntegerNumericType");
    private final static javax.xml.namespace.QName QName_0_290 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "numberFormat");
    private final static javax.xml.namespace.QName QName_0_295 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "extension");
    private final static javax.xml.namespace.QName QName_0_2 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "_value");
}
