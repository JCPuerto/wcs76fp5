/**
 * CurrencyCodeType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.currencycode._54217._2001;

public class CurrencyCodeType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.SimpleBeanSerializer {
    /**
     * Constructor
     */
    public CurrencyCodeType_Ser(
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
        java.lang.String stringValue = getValueAsString(value, context);
        context.simpleElement(name,
                              addAttributes(attributes, value, context),
                              stringValue);
    }
    public java.lang.String getValueAsString(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
    {
        CurrencyCodeType bean = (CurrencyCodeType) value;
        java.lang.Object propValue = null;
        java.lang.String retValue = "";
        propValue = bean.get_value();
        if (propValue != null) {
          javax.xml.namespace.QName  typeQName = QName_4_5;
          try {
            retValue = context.getValueAsString(propValue, typeQName);
          } catch (Exception _e) {
            throw new java.lang.RuntimeException(_e);
          }
        }
        return retValue;
    }
    protected org.xml.sax.Attributes addAttributes(
        org.xml.sax.Attributes attributes,
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        java.lang.String stringValue = getValueAsString(value, context);
        context.simpleElement(null, null, stringValue);
    }
    private final static javax.xml.namespace.QName QName_0_2 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "_value");
    private final static javax.xml.namespace.QName QName_4_5 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9/currencycode/54217:2001",
                  "CurrencyCodeContentType");
}
