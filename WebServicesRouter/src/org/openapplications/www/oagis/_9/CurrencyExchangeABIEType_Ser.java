/**
 * CurrencyExchangeABIEType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class CurrencyExchangeABIEType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public CurrencyExchangeABIEType_Ser(
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
           elemQName = QName_1_272;
           context.qName2String(elemQName, true);
           elemQName = QName_1_273;
           context.qName2String(elemQName, true);
           elemQName = QName_1_274;
           context.qName2String(elemQName, true);
           elemQName = QName_1_275;
           context.qName2String(elemQName, true);
           elemQName = QName_1_276;
           context.qName2String(elemQName, true);
           elemQName = QName_1_277;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        CurrencyExchangeABIEType bean = (CurrencyExchangeABIEType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_272;
          propValue = bean.getSourceCurrencyCode();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_278,
              false,null,context);
          propQName = QName_1_273;
          propValue = bean.getSourceUnitBaseNumeric();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_260,
              false,null,context);
          propQName = QName_1_274;
          propValue = bean.getTargetCurrencyCode();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_278,
              false,null,context);
          propQName = QName_1_275;
          propValue = bean.getTargetUnitBaseNumeric();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_260,
              false,null,context);
          propQName = QName_1_276;
          propValue = bean.getRateNumeric();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_260,
              false,null,context);
          propQName = QName_1_277;
          propValue = bean.getSetDateTime();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_53,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_277 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SetDateTime");
    private final static javax.xml.namespace.QName QName_1_273 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SourceUnitBaseNumeric");
    private final static javax.xml.namespace.QName QName_1_260 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NumericType");
    private final static javax.xml.namespace.QName QName_1_53 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DateTimeType");
    private final static javax.xml.namespace.QName QName_1_274 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "TargetCurrencyCode");
    private final static javax.xml.namespace.QName QName_1_272 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SourceCurrencyCode");
    private final static javax.xml.namespace.QName QName_1_276 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "RateNumeric");
    private final static javax.xml.namespace.QName QName_1_278 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "CurrencyCodeType");
    private final static javax.xml.namespace.QName QName_1_275 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "TargetUnitBaseNumeric");
}
