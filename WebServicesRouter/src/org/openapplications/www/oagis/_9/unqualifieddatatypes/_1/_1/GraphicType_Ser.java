/**
 * GraphicType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.unqualifieddatatypes._1._1;

public class GraphicType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.SimpleBeanSerializer {
    /**
     * Constructor
     */
    public GraphicType_Ser(
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
        GraphicType bean = (GraphicType) value;
        java.lang.Object propValue = null;
        java.lang.String retValue = "";
        propValue = bean.get_value();
        if (propValue != null) {
          javax.xml.namespace.QName  typeQName = QName_3_17;
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
        GraphicType bean = (GraphicType) value;
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
          propValue = bean.getFormat();
          if (propValue != null) {        
            attrQName = QName_0_7;
            attrTypeQName = QName_3_8;
            attrs.addAttribute(
              "",
              "format",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getMimeCode();
          if (propValue != null) {        
            attrQName = QName_0_9;
            attrTypeQName = QName_2_10;
            attrs.addAttribute(
              "",
              "mimeCode",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getEncodingCode();
          if (propValue != null) {        
            attrQName = QName_0_11;
            attrTypeQName = QName_3_12;
            attrs.addAttribute(
              "",
              "encodingCode",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getUri();
          if (propValue != null) {        
            attrQName = QName_0_14;
            attrTypeQName = QName_3_15;
            attrs.addAttribute(
              "",
              "uri",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
          propValue = bean.getFilename();
          if (propValue != null) {        
            attrQName = QName_0_16;
            attrTypeQName = QName_3_8;
            attrs.addAttribute(
              "",
              "filename",
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
    private final static javax.xml.namespace.QName QName_0_16 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "filename");
    private final static javax.xml.namespace.QName QName_0_14 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "uri");
    private final static javax.xml.namespace.QName QName_0_9 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "mimeCode");
    private final static javax.xml.namespace.QName QName_0_11 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "encodingCode");
    private final static javax.xml.namespace.QName QName_3_15 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "anyURI");
    private final static javax.xml.namespace.QName QName_3_17 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "base64Binary");
    private final static javax.xml.namespace.QName QName_3_8 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "string");
    private final static javax.xml.namespace.QName QName_0_7 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "format");
    private final static javax.xml.namespace.QName QName_2_10 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9/codelists",
                  "MIMECodeContentType");
    private final static javax.xml.namespace.QName QName_3_12 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "normalizedString");
    private final static javax.xml.namespace.QName QName_0_2 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "_value");
}
