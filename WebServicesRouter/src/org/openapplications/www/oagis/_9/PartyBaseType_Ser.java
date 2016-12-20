/**
 * PartyBaseType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class PartyBaseType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public PartyBaseType_Ser(
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
        PartyBaseType bean = (PartyBaseType) value;
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
          propValue = bean.getCategory();
          if (propValue != null) {        
            attrQName = QName_0_203;
            attrTypeQName = QName_1_204;
            attrs.addAttribute(
              "",
              "category",
              context.qName2String(attrQName, true),
              "CDATA",
              context.getValueAsString(propValue, attrTypeQName));
          }
        }
        attributes = attrs;
           javax.xml.namespace.QName
           elemQName = QName_1_205;
           context.qName2String(elemQName, true);
           elemQName = QName_1_121;
           context.qName2String(elemQName, true);
           elemQName = QName_1_206;
           context.qName2String(elemQName, true);
           elemQName = QName_1_207;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        PartyBaseType bean = (PartyBaseType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_205;
          propValue = bean.getPartyIDs();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_208,
              false,null,context);
          propQName = QName_1_121;
          {
            propValue = bean.getName();
            if (propValue != null) {
              for (int i=0; i<java.lang.reflect.Array.getLength(propValue); i++) {
                serializeChild(propQName, null, 
                    java.lang.reflect.Array.get(propValue, i), 
                    QName_1_124,
                    true,null,context);
              }
            }
          }
          propQName = QName_1_206;
          {
            propValue = bean.getLocation();
            if (propValue != null) {
              for (int i=0; i<java.lang.reflect.Array.getLength(propValue); i++) {
                serializeChild(propQName, null, 
                    java.lang.reflect.Array.get(propValue, i), 
                    QName_1_113,
                    true,null,context);
              }
            }
          }
          propQName = QName_1_207;
          {
            propValue = bean.getContact();
            if (propValue != null) {
              for (int i=0; i<java.lang.reflect.Array.getLength(propValue); i++) {
                serializeChild(propQName, null, 
                    java.lang.reflect.Array.get(propValue, i), 
                    QName_1_199,
                    true,null,context);
              }
            }
          }
        }
    }
    private final static javax.xml.namespace.QName QName_1_206 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Location");
    private final static javax.xml.namespace.QName QName_0_203 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "category");
    private final static javax.xml.namespace.QName QName_1_207 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Contact");
    private final static javax.xml.namespace.QName QName_1_205 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PartyIDs");
    private final static javax.xml.namespace.QName QName_1_121 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Name");
    private final static javax.xml.namespace.QName QName_1_208 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PartyIDsType");
    private final static javax.xml.namespace.QName QName_1_199 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ContactType");
    private final static javax.xml.namespace.QName QName_1_113 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "LocationType");
    private final static javax.xml.namespace.QName QName_1_204 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PartyCategoryCodeContentType");
    private final static javax.xml.namespace.QName QName_1_124 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NameType");
}
