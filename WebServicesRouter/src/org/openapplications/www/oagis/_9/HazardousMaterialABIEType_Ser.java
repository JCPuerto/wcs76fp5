/**
 * HazardousMaterialABIEType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class HazardousMaterialABIEType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public HazardousMaterialABIEType_Ser(
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
           elemQName = QName_1_188;
           context.qName2String(elemQName, true);
           elemQName = QName_1_189;
           context.qName2String(elemQName, true);
           elemQName = QName_1_190;
           context.qName2String(elemQName, true);
           elemQName = QName_1_191;
           context.qName2String(elemQName, true);
           elemQName = QName_1_192;
           context.qName2String(elemQName, true);
           elemQName = QName_1_193;
           context.qName2String(elemQName, true);
           elemQName = QName_1_194;
           context.qName2String(elemQName, true);
           elemQName = QName_1_195;
           context.qName2String(elemQName, true);
           elemQName = QName_1_196;
           context.qName2String(elemQName, true);
           elemQName = QName_1_100;
           context.qName2String(elemQName, true);
           elemQName = QName_1_197;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        HazardousMaterialABIEType bean = (HazardousMaterialABIEType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_128;
          propValue = bean.getID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_188;
          propValue = bean.getMFAGID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_189;
          propValue = bean.getTechnicalName();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_124,
              false,null,context);
          propQName = QName_1_190;
          propValue = bean.getPlacardEndorsement();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_106,
              false,null,context);
          propQName = QName_1_191;
          propValue = bean.getPlacardNotation();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_106,
              false,null,context);
          propQName = QName_1_192;
          propValue = bean.getMarinePollutionLevelCode();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_104,
              false,null,context);
          propQName = QName_1_193;
          propValue = bean.getToxicityZoneCode();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_104,
              false,null,context);
          propQName = QName_1_194;
          {
            propValue = bean.getTemperature();
            if (propValue != null) {
              for (int i=0; i<java.lang.reflect.Array.getLength(propValue); i++) {
                serializeChild(propQName, null, 
                    java.lang.reflect.Array.get(propValue, i), 
                    QName_1_198,
                    true,null,context);
              }
            }
          }
          propQName = QName_1_195;
          propValue = bean.getFlashpointTemperature();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_198,
              false,null,context);
          propQName = QName_1_196;
          propValue = bean.getPrimaryEntryRoute();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_106,
              false,null,context);
          propQName = QName_1_100;
          {
            propValue = bean.getDescription();
            if (propValue != null) {
              for (int i=0; i<java.lang.reflect.Array.getLength(propValue); i++) {
                serializeChild(propQName, null, 
                    java.lang.reflect.Array.get(propValue, i), 
                    QName_1_105,
                    true,null,context);
              }
            }
          }
          propQName = QName_1_197;
          propValue = bean.getEmergencyContact();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_199,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_100 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Description");
    private final static javax.xml.namespace.QName QName_1_193 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ToxicityZoneCode");
    private final static javax.xml.namespace.QName QName_1_106 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "TextType");
    private final static javax.xml.namespace.QName QName_1_199 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ContactType");
    private final static javax.xml.namespace.QName QName_1_192 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "MarinePollutionLevelCode");
    private final static javax.xml.namespace.QName QName_1_198 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "TemperatureMeasureType");
    private final static javax.xml.namespace.QName QName_1_105 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DescriptionType");
    private final static javax.xml.namespace.QName QName_1_194 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Temperature");
    private final static javax.xml.namespace.QName QName_1_195 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "FlashpointTemperature");
    private final static javax.xml.namespace.QName QName_1_191 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PlacardNotation");
    private final static javax.xml.namespace.QName QName_1_190 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PlacardEndorsement");
    private final static javax.xml.namespace.QName QName_1_104 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "CodeType");
    private final static javax.xml.namespace.QName QName_1_197 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "EmergencyContact");
    private final static javax.xml.namespace.QName QName_1_55 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "IdentifierType");
    private final static javax.xml.namespace.QName QName_1_128 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ID");
    private final static javax.xml.namespace.QName QName_1_196 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PrimaryEntryRoute");
    private final static javax.xml.namespace.QName QName_1_124 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NameType");
    private final static javax.xml.namespace.QName QName_1_188 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "MFAGID");
    private final static javax.xml.namespace.QName QName_1_189 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "TechnicalName");
}
