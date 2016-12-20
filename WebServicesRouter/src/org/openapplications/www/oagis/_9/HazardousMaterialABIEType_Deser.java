/**
 * HazardousMaterialABIEType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class HazardousMaterialABIEType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public HazardousMaterialABIEType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new HazardousMaterialABIEType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_1_128) {
          ((HazardousMaterialABIEType)value).setID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_188) {
          ((HazardousMaterialABIEType)value).setMFAGID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_189) {
          ((HazardousMaterialABIEType)value).setTechnicalName((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_190) {
          ((HazardousMaterialABIEType)value).setPlacardEndorsement((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_191) {
          ((HazardousMaterialABIEType)value).setPlacardNotation((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_192) {
          ((HazardousMaterialABIEType)value).setMarinePollutionLevelCode((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_193) {
          ((HazardousMaterialABIEType)value).setToxicityZoneCode((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_195) {
          ((HazardousMaterialABIEType)value).setFlashpointTemperature((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_196) {
          ((HazardousMaterialABIEType)value).setPrimaryEntryRoute((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_197) {
          ((HazardousMaterialABIEType)value).setEmergencyContact((org.openapplications.www.oagis._9.ContactType)objValue);
          return true;}
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        if (qName==QName_1_194) {
          javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[listValue.size()];
          listValue.toArray(array);
          ((HazardousMaterialABIEType)value).setTemperature(array);
          return true;}
        else if (qName==QName_1_100) {
          javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[listValue.size()];
          listValue.toArray(array);
          ((HazardousMaterialABIEType)value).setDescription(array);
          return true;}
        return false;
    }
    private final static javax.xml.namespace.QName QName_1_195 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "FlashpointTemperature");
    private final static javax.xml.namespace.QName QName_1_188 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "MFAGID");
    private final static javax.xml.namespace.QName QName_1_197 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "EmergencyContact");
    private final static javax.xml.namespace.QName QName_1_194 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Temperature");
    private final static javax.xml.namespace.QName QName_1_193 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ToxicityZoneCode");
    private final static javax.xml.namespace.QName QName_1_191 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PlacardNotation");
    private final static javax.xml.namespace.QName QName_1_100 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Description");
    private final static javax.xml.namespace.QName QName_1_190 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PlacardEndorsement");
    private final static javax.xml.namespace.QName QName_1_128 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ID");
    private final static javax.xml.namespace.QName QName_1_189 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "TechnicalName");
    private final static javax.xml.namespace.QName QName_1_196 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PrimaryEntryRoute");
    private final static javax.xml.namespace.QName QName_1_192 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "MarinePollutionLevelCode");
}
