/**
 * DocumentIDType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class DocumentIDType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public DocumentIDType_Ser(
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
        DocumentIDType bean = (DocumentIDType) value;
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
          propValue = bean.getAgencyRole();
          if (propValue != null) {        
            attrQName = QName_0_282;
            attrTypeQName = QName_3_283;
            attrs.addAttribute(
              "",
              "agencyRole",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
        }
        attributes = attrs;
           javax.xml.namespace.QName
           elemQName = QName_1_128;
           context.qName2String(elemQName, true);
           elemQName = QName_1_284;
           context.qName2String(elemQName, true);
           elemQName = QName_1_285;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        DocumentIDType bean = (DocumentIDType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_128;
          propValue = bean.getID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              true,null,context);
          propQName = QName_1_284;
          propValue = bean.getRevisionID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_285;
          propValue = bean.getVariationID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_285 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "VariationID");
    private final static javax.xml.namespace.QName QName_3_283 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.w3.org/2001/XMLSchema",
                  "anyType");
    private final static javax.xml.namespace.QName QName_1_55 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "IdentifierType");
    private final static javax.xml.namespace.QName QName_1_284 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "RevisionID");
    private final static javax.xml.namespace.QName QName_1_128 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ID");
    private final static javax.xml.namespace.QName QName_0_282 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "agencyRole");
}
