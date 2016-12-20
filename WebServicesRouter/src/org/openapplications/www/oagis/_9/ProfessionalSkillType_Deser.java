/**
 * ProfessionalSkillType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ProfessionalSkillType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public ProfessionalSkillType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new ProfessionalSkillType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_1_99) {
          ((ProfessionalSkillType)value).setCode((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_157) {
          ((ProfessionalSkillType)value).setCompetencyCode((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_158) {
          ((ProfessionalSkillType)value).setLastUsedDateTime((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_122) {
          ((ProfessionalSkillType)value).setEffectiveTimePeriod((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_51) {
          if (objValue instanceof java.util.List) {
            javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[((java.util.List)objValue).size()];
            ((java.util.List)objValue).toArray(array);
            ((ProfessionalSkillType)value).setUserArea(array);
          } else { 
            ((ProfessionalSkillType)value).setUserArea((javax.xml.soap.SOAPElement[])objValue);}
          return true;}
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        if (qName==QName_1_121) {
          javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[listValue.size()];
          listValue.toArray(array);
          ((ProfessionalSkillType)value).setName(array);
          return true;}
        else if (qName==QName_1_159) {
          javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[listValue.size()];
          listValue.toArray(array);
          ((ProfessionalSkillType)value).setTrainingDateTime(array);
          return true;}
        return false;
    }
    private final static javax.xml.namespace.QName QName_1_99 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Code");
    private final static javax.xml.namespace.QName QName_1_51 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserArea");
    private final static javax.xml.namespace.QName QName_1_122 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "EffectiveTimePeriod");
    private final static javax.xml.namespace.QName QName_1_159 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "TrainingDateTime");
    private final static javax.xml.namespace.QName QName_1_121 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Name");
    private final static javax.xml.namespace.QName QName_1_158 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "LastUsedDateTime");
    private final static javax.xml.namespace.QName QName_1_157 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "CompetencyCode");
}
