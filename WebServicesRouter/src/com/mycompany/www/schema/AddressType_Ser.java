/**
 * AddressType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class AddressType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public AddressType_Ser(
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
        context.startElement(name, addAttributes(attributes, value, context));
        addElements(value, context);
        context.endElement();
    }
    protected org.xml.sax.Attributes addAttributes(
        org.xml.sax.Attributes attributes,
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
           javax.xml.namespace.QName
           elemQName = QName_8_315;
           context.qName2String(elemQName, true);
           elemQName = QName_8_316;
           context.qName2String(elemQName, true);
           elemQName = QName_8_317;
           context.qName2String(elemQName, true);
           elemQName = QName_8_318;
           context.qName2String(elemQName, true);
           elemQName = QName_8_319;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        AddressType bean = (AddressType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_8_315;
          propValue = bean.getStreetAddress();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              true,null,context);
          }
          propQName = QName_8_316;
          propValue = bean.getCity();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              true,null,context);
          }
          propQName = QName_8_317;
          propValue = bean.getState();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              true,null,context);
          }
          propQName = QName_8_318;
          propValue = bean.getCountry();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              true,null,context);
          }
          propQName = QName_8_319;
          propValue = bean.getZipCode();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              true,null,context);
          }
        }
    }
    private final static javax.xml.namespace.QName QName_8_318 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Country");
    private final static javax.xml.namespace.QName QName_8_319 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "ZipCode");
    private final static javax.xml.namespace.QName QName_3_8 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "string");
    private final static javax.xml.namespace.QName QName_8_316 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "City");
    private final static javax.xml.namespace.QName QName_8_315 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "StreetAddress");
    private final static javax.xml.namespace.QName QName_8_317 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "State");
}
