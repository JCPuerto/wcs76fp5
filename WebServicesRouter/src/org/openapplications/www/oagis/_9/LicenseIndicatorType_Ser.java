/**
 * LicenseIndicatorType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class LicenseIndicatorType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.SimpleBeanSerializer {
    /**
     * Constructor
     */
    public LicenseIndicatorType_Ser(
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
        LicenseIndicatorType bean = (LicenseIndicatorType) value;
        java.lang.Object propValue = null;
        java.lang.String retValue = "";
        propValue = new java.lang.Boolean(bean.is_value());
        if (propValue != null) {
          javax.xml.namespace.QName  typeQName = QName_1_3;
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
        LicenseIndicatorType bean = (LicenseIndicatorType) value;
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
          propValue = bean.getName();
          if (propValue != null) {        
            attrQName = QName_0_0;
            attrTypeQName = QName_1_1;
            attrs.addAttribute(
              "",
              "name",
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
    private final static javax.xml.namespace.QName QName_0_2 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "_value");
    private final static javax.xml.namespace.QName QName_0_0 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "name");
    private final static javax.xml.namespace.QName QName_1_1 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "LicenseTypeCodeContentType");
    private final static javax.xml.namespace.QName QName_1_3 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "IndicatorType");
}
