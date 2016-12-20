/**
 * ContactABIEType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ContactABIEType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public ContactABIEType_Ser(
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
           elemQName = QName_1_128;
           context.qName2String(elemQName, true);
           elemQName = QName_1_121;
           context.qName2String(elemQName, true);
           elemQName = QName_1_240;
           context.qName2String(elemQName, true);
           elemQName = QName_1_241;
           context.qName2String(elemQName, true);
           elemQName = QName_1_242;
           context.qName2String(elemQName, true);
           elemQName = QName_1_243;
           context.qName2String(elemQName, true);
           elemQName = QName_1_244;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        ContactABIEType bean = (ContactABIEType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_128;
          {
            propValue = bean.getID();
            if (propValue != null) {
              for (int i=0; i<java.lang.reflect.Array.getLength(propValue); i++) {
                serializeChild(propQName, null, 
                    java.lang.reflect.Array.get(propValue, i), 
                    QName_1_55,
                    true,null,context);
              }
            }
          }
          propQName = QName_1_121;
          propValue = bean.getName();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_124,
              false,null,context);
          propQName = QName_1_240;
          propValue = bean.getJobTitle();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_106,
              false,null,context);
          propQName = QName_1_241;
          {
            propValue = bean.getResponsibility();
            if (propValue != null) {
              for (int i=0; i<java.lang.reflect.Array.getLength(propValue); i++) {
                serializeChild(propQName, null, 
                    java.lang.reflect.Array.get(propValue, i), 
                    QName_1_106,
                    true,null,context);
              }
            }
          }
          propQName = QName_1_242;
          propValue = bean.getDepartmentName();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_124,
              false,null,context);
          propQName = QName_1_243;
          {
            propValue = bean.getCommunication();
            if (propValue != null) {
              for (int i=0; i<java.lang.reflect.Array.getLength(propValue); i++) {
                serializeChild(propQName, null, 
                    java.lang.reflect.Array.get(propValue, i), 
                    QName_1_245,
                    true,null,context);
              }
            }
          }
          propQName = QName_1_244;
          propValue = bean.getPreference();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_246,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_244 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Preference");
    private final static javax.xml.namespace.QName QName_1_121 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Name");
    private final static javax.xml.namespace.QName QName_1_241 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Responsibility");
    private final static javax.xml.namespace.QName QName_1_243 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Communication");
    private final static javax.xml.namespace.QName QName_1_240 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "JobTitle");
    private final static javax.xml.namespace.QName QName_1_106 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "TextType");
    private final static javax.xml.namespace.QName QName_1_128 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ID");
    private final static javax.xml.namespace.QName QName_1_242 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DepartmentName");
    private final static javax.xml.namespace.QName QName_1_55 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "IdentifierType");
    private final static javax.xml.namespace.QName QName_1_246 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PreferenceType");
    private final static javax.xml.namespace.QName QName_1_245 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "CommunicationType");
    private final static javax.xml.namespace.QName QName_1_124 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NameType");
}
