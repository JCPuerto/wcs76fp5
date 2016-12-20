/**
 * PositionType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class PositionType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public PositionType_Ser(
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
           elemQName = QName_1_234;
           context.qName2String(elemQName, true);
           elemQName = QName_1_235;
           context.qName2String(elemQName, true);
           elemQName = QName_1_236;
           context.qName2String(elemQName, true);
           elemQName = QName_1_237;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        PositionType bean = (PositionType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_234;
          propValue = bean.getDegreeMeasure();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_183,
              false,null,context);
          propQName = QName_1_235;
          propValue = bean.getMinuteMeasure();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_183,
              false,null,context);
          propQName = QName_1_236;
          propValue = bean.getSecondMeasure();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_183,
              false,null,context);
          propQName = QName_1_237;
          propValue = bean.getDirectionCode();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_104,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_234 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DegreeMeasure");
    private final static javax.xml.namespace.QName QName_1_236 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SecondMeasure");
    private final static javax.xml.namespace.QName QName_1_235 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "MinuteMeasure");
    private final static javax.xml.namespace.QName QName_1_183 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "MeasureType");
    private final static javax.xml.namespace.QName QName_1_104 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "CodeType");
    private final static javax.xml.namespace.QName QName_1_237 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DirectionCode");
}
