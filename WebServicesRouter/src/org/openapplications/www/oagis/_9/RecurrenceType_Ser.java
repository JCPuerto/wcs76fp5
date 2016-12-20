/**
 * RecurrenceType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class RecurrenceType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public RecurrenceType_Ser(
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
        RecurrenceType bean = (RecurrenceType) value;
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
          propValue = bean.getPattern();
          if (propValue != null) {        
            attrQName = QName_0_253;
            attrTypeQName = QName_1_254;
            attrs.addAttribute(
              "",
              "pattern",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
        }
        attributes = attrs;
           javax.xml.namespace.QName
           elemQName = QName_1_255;
           context.qName2String(elemQName, true);
           elemQName = QName_1_256;
           context.qName2String(elemQName, true);
           elemQName = QName_1_257;
           context.qName2String(elemQName, true);
           elemQName = QName_1_258;
           context.qName2String(elemQName, true);
           elemQName = QName_1_259;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        RecurrenceType bean = (RecurrenceType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_255;
          propValue = bean.getOccursEveryQuantity();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_178,
              false,null,context);
          propQName = QName_1_256;
          propValue = bean.getEveryDayIndicator();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_3,
              false,null,context);
          propQName = QName_1_257;
          propValue = bean.getFrequency();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_260,
              false,null,context);
          propQName = QName_1_258;
          {
            propValue = bean.getDayOfWeek();
            if (propValue != null) {
              for (int i=0; i<java.lang.reflect.Array.getLength(propValue); i++) {
                serializeChild(propQName, null, 
                    java.lang.reflect.Array.get(propValue, i), 
                    QName_1_261,
                    true,null,context);
              }
            }
          }
          propQName = QName_1_259;
          propValue = bean.getOfEveryQuantity();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_178,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_256 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "EveryDayIndicator");
    private final static javax.xml.namespace.QName QName_1_260 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NumericType");
    private final static javax.xml.namespace.QName QName_1_255 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "OccursEveryQuantity");
    private final static javax.xml.namespace.QName QName_1_261 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DayOfWeekCodeType");
    private final static javax.xml.namespace.QName QName_1_178 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "QuantityType");
    private final static javax.xml.namespace.QName QName_1_257 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Frequency");
    private final static javax.xml.namespace.QName QName_0_253 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "pattern");
    private final static javax.xml.namespace.QName QName_1_259 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "OfEveryQuantity");
    private final static javax.xml.namespace.QName QName_1_258 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DayOfWeek");
    private final static javax.xml.namespace.QName QName_1_3 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "IndicatorType");
    private final static javax.xml.namespace.QName QName_1_254 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "RecurrencePatternCodeContentType");
}
