/**
 * SyncCustomerDataAreaType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class SyncCustomerDataAreaType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public SyncCustomerDataAreaType_Ser(
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
           elemQName = QName_1_335;
           context.qName2String(elemQName, true);
           elemQName = QName_8_336;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        SyncCustomerDataAreaType bean = (SyncCustomerDataAreaType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_335;
          propValue = bean.getSync();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_337,
              true,null,context);
          propQName = QName_8_336;
          propValue = bean.getCustomer();
          serializeChild(propQName, null, 
              propValue, 
              QName_8_338,
              true,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_8_338 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "CustomerType");
    private final static javax.xml.namespace.QName QName_1_337 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SyncType");
    private final static javax.xml.namespace.QName QName_8_336 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Customer");
    private final static javax.xml.namespace.QName QName_1_335 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Sync");
}
