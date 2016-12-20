/**
 * CustomerDemographicsType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class CustomerDemographicsType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public CustomerDemographicsType_Ser(
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
           elemQName = QName_8_302;
           context.qName2String(elemQName, true);
           elemQName = QName_8_303;
           context.qName2String(elemQName, true);
           elemQName = QName_8_304;
           context.qName2String(elemQName, true);
           elemQName = QName_8_305;
           context.qName2String(elemQName, true);
           elemQName = QName_8_306;
           context.qName2String(elemQName, true);
           elemQName = QName_8_307;
           context.qName2String(elemQName, true);
           elemQName = QName_8_308;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        CustomerDemographicsType bean = (CustomerDemographicsType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_8_302;
          propValue = bean.getGender();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              false,null,context);
          }
          propQName = QName_8_303;
          propValue = bean.getIncomeCurrency();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              false,null,context);
          }
          propQName = QName_8_304;
          propValue = bean.getMaritalStatus();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              false,null,context);
          }
          propQName = QName_8_305;
          propValue = bean.getHobbies();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              false,null,context);
          }
          propQName = QName_8_306;
          propValue = bean.getAdditionalInformation();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              false,null,context);
          }
          propQName = QName_8_307;
          propValue = bean.getAge();
          serializeChild(propQName, null, 
              propValue, 
              QName_3_309,
              false,null,context);
          propQName = QName_8_308;
          propValue = bean.getIncome();
          serializeChild(propQName, null, 
              propValue, 
              QName_3_309,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_8_308 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Income");
    private final static javax.xml.namespace.QName QName_8_307 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Age");
    private final static javax.xml.namespace.QName QName_8_303 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "IncomeCurrency");
    private final static javax.xml.namespace.QName QName_8_302 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Gender");
    private final static javax.xml.namespace.QName QName_8_305 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Hobbies");
    private final static javax.xml.namespace.QName QName_3_309 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "int");
    private final static javax.xml.namespace.QName QName_3_8 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "string");
    private final static javax.xml.namespace.QName QName_8_304 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "MaritalStatus");
    private final static javax.xml.namespace.QName QName_8_306 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "AdditionalInformation");
}
