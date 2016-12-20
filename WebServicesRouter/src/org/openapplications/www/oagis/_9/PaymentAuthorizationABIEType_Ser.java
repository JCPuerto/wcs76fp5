/**
 * PaymentAuthorizationABIEType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class PaymentAuthorizationABIEType_Ser extends org.openapplications.www.oagis._9.AuthorizationABIEType_Ser {
    /**
     * Constructor
     */
    public PaymentAuthorizationABIEType_Ser(
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
           elemQName = QName_1_149;
           context.qName2String(elemQName, true);
           elemQName = QName_1_150;
           context.qName2String(elemQName, true);
           elemQName = QName_1_151;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        super.addElements(value, context);
        PaymentAuthorizationABIEType bean = (PaymentAuthorizationABIEType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_149;
          propValue = bean.getReferenceOrderNumber();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_150;
          propValue = bean.getRevenueSourceID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_151;
          propValue = bean.getRemittanceBankID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_55 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "IdentifierType");
    private final static javax.xml.namespace.QName QName_1_149 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ReferenceOrderNumber");
    private final static javax.xml.namespace.QName QName_1_150 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "RevenueSourceID");
    private final static javax.xml.namespace.QName QName_1_151 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "RemittanceBankID");
}
