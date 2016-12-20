/**
 * CustomerDemographicsType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class CustomerDemographicsType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public CustomerDemographicsType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new CustomerDemographicsType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        if (qName==QName_8_302) {
          ((CustomerDemographicsType)value).setGender(strValue);
          return true;}
        else if (qName==QName_8_303) {
          ((CustomerDemographicsType)value).setIncomeCurrency(strValue);
          return true;}
        else if (qName==QName_8_304) {
          ((CustomerDemographicsType)value).setMaritalStatus(strValue);
          return true;}
        else if (qName==QName_8_305) {
          ((CustomerDemographicsType)value).setHobbies(strValue);
          return true;}
        else if (qName==QName_8_306) {
          ((CustomerDemographicsType)value).setAdditionalInformation(strValue);
          return true;}
        else if (qName==QName_8_307) {
          ((CustomerDemographicsType)value).setAge(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseInteger(strValue));
          return true;}
        else if (qName==QName_8_308) {
          ((CustomerDemographicsType)value).setIncome(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseInteger(strValue));
          return true;}
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        return false;
    }
    private final static javax.xml.namespace.QName QName_8_307 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Age");
    private final static javax.xml.namespace.QName QName_8_304 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "MaritalStatus");
    private final static javax.xml.namespace.QName QName_8_306 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "AdditionalInformation");
    private final static javax.xml.namespace.QName QName_8_308 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Income");
    private final static javax.xml.namespace.QName QName_8_305 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Hobbies");
    private final static javax.xml.namespace.QName QName_8_303 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "IncomeCurrency");
    private final static javax.xml.namespace.QName QName_8_302 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Gender");
}
