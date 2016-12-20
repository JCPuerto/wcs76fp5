/**
 * ConfirmBODDataAreaType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ConfirmBODDataAreaType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public ConfirmBODDataAreaType_Ser(
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
           elemQName = QName_1_298;
           context.qName2String(elemQName, true);
           elemQName = QName_1_299;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        ConfirmBODDataAreaType bean = (ConfirmBODDataAreaType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_298;
          propValue = bean.getConfirm();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_300,
              true,null,context);
          propQName = QName_1_299;
          {
            propValue = bean.getBOD();
            if (propValue != null) {
              for (int i=0; i<java.lang.reflect.Array.getLength(propValue); i++) {
                serializeChild(propQName, null, 
                    java.lang.reflect.Array.get(propValue, i), 
                    QName_1_301,
                    true,null,context);
              }
            }
          }
        }
    }
    private final static javax.xml.namespace.QName QName_1_298 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Confirm");
    private final static javax.xml.namespace.QName QName_1_301 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "BODType");
    private final static javax.xml.namespace.QName QName_1_300 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ConfirmType");
    private final static javax.xml.namespace.QName QName_1_299 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "BOD");
}
