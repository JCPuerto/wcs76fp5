/**
 * DimensionABIEType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class DimensionABIEType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public DimensionABIEType_Ser(
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
        DimensionABIEType bean = (DimensionABIEType) value;
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
           elemQName = QName_1_180;
           context.qName2String(elemQName, true);
           elemQName = QName_1_181;
           context.qName2String(elemQName, true);
           elemQName = QName_1_182;
           context.qName2String(elemQName, true);
           elemQName = QName_1_100;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        DimensionABIEType bean = (DimensionABIEType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_180;
          propValue = bean.getWidthMeasure();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_183,
              false,null,context);
          propQName = QName_1_181;
          propValue = bean.getLengthMeasure();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_183,
              false,null,context);
          propQName = QName_1_182;
          propValue = bean.getHeightMeasure();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_183,
              false,null,context);
          propQName = QName_1_100;
          propValue = bean.getDescription();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_105,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_100 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Description");
    private final static javax.xml.namespace.QName QName_1_180 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "WidthMeasure");
    private final static javax.xml.namespace.QName QName_1_183 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "MeasureType");
    private final static javax.xml.namespace.QName QName_0_126 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "type");
    private final static javax.xml.namespace.QName QName_1_181 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "LengthMeasure");
    private final static javax.xml.namespace.QName QName_1_39 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NormalizedStringType");
    private final static javax.xml.namespace.QName QName_1_105 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DescriptionType");
    private final static javax.xml.namespace.QName QName_1_182 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "HeightMeasure");
}
