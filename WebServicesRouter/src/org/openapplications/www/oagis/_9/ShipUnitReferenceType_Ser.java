/**
 * ShipUnitReferenceType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ShipUnitReferenceType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public ShipUnitReferenceType_Ser(
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
           elemQName = QName_1_128;
           context.qName2String(elemQName, true);
           elemQName = QName_1_200;
           context.qName2String(elemQName, true);
           elemQName = QName_1_134;
           context.qName2String(elemQName, true);
           elemQName = QName_1_201;
           context.qName2String(elemQName, true);
           elemQName = QName_1_202;
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
        ShipUnitReferenceType bean = (ShipUnitReferenceType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_128;
          propValue = bean.getID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_200;
          propValue = bean.getSealID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_134;
          propValue = bean.getType();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_104,
              false,null,context);
          propQName = QName_1_201;
          propValue = bean.getFreightItemID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_202;
          propValue = bean.getShippingTrackingID();
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
    private final static javax.xml.namespace.QName QName_1_51 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserArea");
    private final static javax.xml.namespace.QName QName_1_200 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SealID");
    private final static javax.xml.namespace.QName QName_1_202 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ShippingTrackingID");
    private final static javax.xml.namespace.QName QName_1_134 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Type");
    private final static javax.xml.namespace.QName QName_1_201 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "FreightItemID");
    private final static javax.xml.namespace.QName QName_1_128 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ID");
    private final static javax.xml.namespace.QName QName_1_56 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserAreaType");
    private final static javax.xml.namespace.QName QName_1_104 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "CodeType");
    private final static javax.xml.namespace.QName QName_1_55 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "IdentifierType");
}
