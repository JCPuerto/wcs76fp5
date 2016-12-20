/**
 * ConvertedAmountType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ConvertedAmountType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public ConvertedAmountType_Ser(
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
           elemQName = QName_1_131;
           context.qName2String(elemQName, true);
           elemQName = QName_1_269;
           context.qName2String(elemQName, true);
           elemQName = QName_1_270;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        ConvertedAmountType bean = (ConvertedAmountType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_131;
          propValue = bean.getAmount();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_133,
              true,null,context);
          propQName = QName_1_269;
          propValue = bean.getExchangeRate();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_271,
              true,null,context);
          propQName = QName_1_270;
          propValue = bean.getBaseAmount();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_133,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_271 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "CurrencyExchangeRateType");
    private final static javax.xml.namespace.QName QName_1_269 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ExchangeRate");
    private final static javax.xml.namespace.QName QName_1_270 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "BaseAmount");
    private final static javax.xml.namespace.QName QName_1_133 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "AmountType");
    private final static javax.xml.namespace.QName QName_1_131 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Amount");
}
