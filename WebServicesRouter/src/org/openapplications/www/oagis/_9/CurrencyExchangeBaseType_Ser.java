/**
 * CurrencyExchangeBaseType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class CurrencyExchangeBaseType_Ser extends org.openapplications.www.oagis._9.CurrencyExchangeABIEType_Ser {
    /**
     * Constructor
     */
    public CurrencyExchangeBaseType_Ser(
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
        CurrencyExchangeBaseType bean = (CurrencyExchangeBaseType) value;
        java.lang.Object propValue;
        org.xml.sax.helpers.AttributesImpl attrs;
        if (attributes==null || attributes.getLength() == 0) {
          attrs = new org.xml.sax.helpers.AttributesImpl();
        } else {
          attrs = new org.xml.sax.helpers.AttributesImpl(attributes);
        }
        {
          javax.xml.namespace.QName attrQName;
          javax.xml.namespace.QName attrTypeQName;
          propValue = bean.getType();
          if (propValue != null) {        
            attrQName = QName_0_126;
            attrTypeQName = QName_1_39;
            attrs.addAttribute(
              "",
              "type",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
        }
        attributes = attrs;
           javax.xml.namespace.QName
           elemQName = QName_1_127;
           context.qName2String(elemQName, true);
           elemQName = QName_1_122;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        super.addElements(value, context);
        CurrencyExchangeBaseType bean = (CurrencyExchangeBaseType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_127;
          propValue = bean.getSourceID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_122;
          propValue = bean.getEffectiveTimePeriod();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_125,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_55 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "IdentifierType");
    private final static javax.xml.namespace.QName QName_1_127 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SourceID");
    private final static javax.xml.namespace.QName QName_1_122 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "EffectiveTimePeriod");
    private final static javax.xml.namespace.QName QName_0_126 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "type");
    private final static javax.xml.namespace.QName QName_1_125 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "TimePeriodType");
    private final static javax.xml.namespace.QName QName_1_39 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NormalizedStringType");
}
