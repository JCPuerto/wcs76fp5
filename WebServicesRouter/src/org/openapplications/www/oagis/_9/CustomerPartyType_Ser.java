/**
 * CustomerPartyType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class CustomerPartyType_Ser extends org.openapplications.www.oagis._9.PayerPartyBaseType_Ser {
    /**
     * Constructor
     */
    public CustomerPartyType_Ser(
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
        attributes = super.addAttributes(attributes, value, context);
           javax.xml.namespace.QName
           elemQName = QName_1_212;
           context.qName2String(elemQName, true);
           elemQName = QName_1_213;
           context.qName2String(elemQName, true);
           elemQName = QName_1_214;
           context.qName2String(elemQName, true);
           elemQName = QName_1_215;
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
        super.addElements(value, context);
        CustomerPartyType bean = (CustomerPartyType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_212;
          propValue = bean.getRequesterContact();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_216,
              false,null,context);
          propQName = QName_1_213;
          propValue = bean.getPlannerContact();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_216,
              false,null,context);
          propQName = QName_1_214;
          propValue = bean.getBuyerContact();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_216,
              false,null,context);
          propQName = QName_1_215;
          propValue = bean.getReceivingContact();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_216,
              false,null,context);
          propQName = QName_1_51;
          propValue = bean.getUserArea();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_56,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_213 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PlannerContact");
    private final static javax.xml.namespace.QName QName_1_212 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "RequesterContact");
    private final static javax.xml.namespace.QName QName_1_51 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserArea");
    private final static javax.xml.namespace.QName QName_1_56 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserAreaType");
    private final static javax.xml.namespace.QName QName_1_215 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ReceivingContact");
    private final static javax.xml.namespace.QName QName_1_216 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SemanticContactType");
    private final static javax.xml.namespace.QName QName_1_214 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "BuyerContact");
}
