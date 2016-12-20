/**
 * CustomerType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class CustomerType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public CustomerType_Ser(
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
           elemQName = QName_8_325;
           context.qName2String(elemQName, true);
           elemQName = QName_8_326;
           context.qName2String(elemQName, true);
           elemQName = QName_8_327;
           context.qName2String(elemQName, true);
           elemQName = QName_8_328;
           context.qName2String(elemQName, true);
           elemQName = QName_8_329;
           context.qName2String(elemQName, true);
           elemQName = QName_8_330;
           context.qName2String(elemQName, true);
           elemQName = QName_8_331;
           context.qName2String(elemQName, true);
           elemQName = QName_8_207;
           context.qName2String(elemQName, true);
           elemQName = QName_8_332;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        CustomerType bean = (CustomerType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_8_325;
          propValue = bean.getDisplayName();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              false,null,context);
          }
          propQName = QName_8_326;
          propValue = bean.getParentOrganization();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              false,null,context);
          }
          propQName = QName_8_327;
          propValue = bean.getProfileType();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              false,null,context);
          }
          propQName = QName_8_328;
          propValue = bean.getPreferredCurrency();
          if (propValue != null && !context.shouldSendXSIType()) {
            context.simpleElement(propQName, null, propValue.toString()); 
          } else {
            serializeChild(propQName, null, 
              propValue, 
              QName_3_8,
              false,null,context);
          }
          propQName = QName_8_329;
          propValue = bean.getStore();
          serializeChild(propQName, null, 
              propValue, 
              QName_3_309,
              false,null,context);
          propQName = QName_8_330;
          propValue = bean.getPreferredLanguage();
          serializeChild(propQName, null, 
              propValue, 
              QName_3_309,
              false,null,context);
          propQName = QName_8_331;
          propValue = bean.getAuthentication();
          serializeChild(propQName, null, 
              propValue, 
              QName_8_333,
              false,null,context);
          propQName = QName_8_207;
          propValue = bean.getContact();
          serializeChild(propQName, null, 
              propValue, 
              QName_8_199,
              false,null,context);
          propQName = QName_8_332;
          propValue = bean.getDemographics();
          serializeChild(propQName, null, 
              propValue, 
              QName_8_334,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_8_332 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Demographics");
    private final static javax.xml.namespace.QName QName_8_327 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "ProfileType");
    private final static javax.xml.namespace.QName QName_8_330 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "PreferredLanguage");
    private final static javax.xml.namespace.QName QName_8_328 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "PreferredCurrency");
    private final static javax.xml.namespace.QName QName_8_329 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Store");
    private final static javax.xml.namespace.QName QName_8_325 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "DisplayName");
    private final static javax.xml.namespace.QName QName_8_331 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Authentication");
    private final static javax.xml.namespace.QName QName_8_333 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "AuthenticationType");
    private final static javax.xml.namespace.QName QName_8_334 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "CustomerDemographicsType");
    private final static javax.xml.namespace.QName QName_8_199 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "ContactType");
    private final static javax.xml.namespace.QName QName_8_207 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Contact");
    private final static javax.xml.namespace.QName QName_3_309 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "int");
    private final static javax.xml.namespace.QName QName_3_8 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "string");
    private final static javax.xml.namespace.QName QName_8_326 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "ParentOrganization");
}
