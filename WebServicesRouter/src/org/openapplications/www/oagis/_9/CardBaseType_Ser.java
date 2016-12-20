/**
 * CardBaseType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class CardBaseType_Ser extends org.openapplications.www.oagis._9.AccountInformationType_Ser {
    /**
     * Constructor
     */
    public CardBaseType_Ser(
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
           elemQName = QName_1_137;
           context.qName2String(elemQName, true);
           elemQName = QName_1_138;
           context.qName2String(elemQName, true);
           elemQName = QName_1_139;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        super.addElements(value, context);
        CardBaseType bean = (CardBaseType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_137;
          propValue = bean.getExpiration();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_140,
              false,null,context);
          propQName = QName_1_138;
          propValue = bean.getCompanyName();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_124,
              false,null,context);
          propQName = QName_1_139;
          propValue = bean.getPaymentAuthorization();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_141,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_124 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NameType");
    private final static javax.xml.namespace.QName QName_1_137 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Expiration");
    private final static javax.xml.namespace.QName QName_1_138 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "CompanyName");
    private final static javax.xml.namespace.QName QName_1_139 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PaymentAuthorization");
    private final static javax.xml.namespace.QName QName_1_141 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PaymentAuthorizationType");
    private final static javax.xml.namespace.QName QName_1_140 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ExpirationType");
}
