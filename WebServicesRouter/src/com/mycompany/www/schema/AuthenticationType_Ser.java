/**
 * AuthenticationType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class AuthenticationType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public AuthenticationType_Ser(
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
           elemQName = QName_8_310;
           context.qName2String(elemQName, true);
           elemQName = QName_8_311;
           context.qName2String(elemQName, true);
           elemQName = QName_8_312;
           context.qName2String(elemQName, true);
           elemQName = QName_8_313;
           context.qName2String(elemQName, true);
           elemQName = QName_8_314;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        AuthenticationType bean = (AuthenticationType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_8_310;
          propValue = bean.getLogon();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              true,null,context);
          }
          propQName = QName_8_311;
          propValue = bean.getPassword();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              true,null,context);
          }
          propQName = QName_8_312;
          propValue = bean.getPasswordVerify();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              true,null,context);
          }
          propQName = QName_8_313;
          propValue = bean.getChallengeQuestion();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              true,null,context);
          }
          propQName = QName_8_314;
          propValue = bean.getChallengeAnswer();
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
    private final static javax.xml.namespace.QName QName_8_310 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Logon");
    private final static javax.xml.namespace.QName QName_8_314 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "ChallengeAnswer");
    private final static javax.xml.namespace.QName QName_3_8 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "string");
    private final static javax.xml.namespace.QName QName_8_312 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "PasswordVerify");
    private final static javax.xml.namespace.QName QName_8_313 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "ChallengeQuestion");
    private final static javax.xml.namespace.QName QName_8_311 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Password");
}
