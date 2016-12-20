/**
 * ApplicationAreaType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ApplicationAreaType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public ApplicationAreaType_Ser(
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
           elemQName = QName_1_47;
           context.qName2String(elemQName, true);
           elemQName = QName_1_48;
           context.qName2String(elemQName, true);
           elemQName = QName_1_49;
           context.qName2String(elemQName, true);
           elemQName = QName_1_50;
           context.qName2String(elemQName, true);
           elemQName = QName_1_51;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        ApplicationAreaType bean = (ApplicationAreaType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_47;
          propValue = bean.getSender();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_52,
              false,null,context);
          propQName = QName_1_48;
          propValue = bean.getCreationDateTime();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_53,
              true,null,context);
          propQName = QName_1_49;
          propValue = bean.getSignature();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_54,
              false,null,context);
          propQName = QName_1_50;
          propValue = bean.getBODID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_51;
          propValue = bean.getUserArea();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_56,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_52 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SenderType");
    private final static javax.xml.namespace.QName QName_1_48 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "CreationDateTime");
    private final static javax.xml.namespace.QName QName_1_51 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserArea");
    private final static javax.xml.namespace.QName QName_1_50 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "BODID");
    private final static javax.xml.namespace.QName QName_1_47 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Sender");
    private final static javax.xml.namespace.QName QName_1_53 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DateTimeType");
    private final static javax.xml.namespace.QName QName_1_49 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Signature");
    private final static javax.xml.namespace.QName QName_1_56 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserAreaType");
    private final static javax.xml.namespace.QName QName_1_55 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "IdentifierType");
    private final static javax.xml.namespace.QName QName_1_54 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SignatureType");
}
