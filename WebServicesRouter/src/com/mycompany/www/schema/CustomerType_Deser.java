/**
 * CustomerType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class CustomerType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public CustomerType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new CustomerType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        if (qName==QName_8_325) {
          ((CustomerType)value).setDisplayName(strValue);
          return true;}
        else if (qName==QName_8_326) {
          ((CustomerType)value).setParentOrganization(strValue);
          return true;}
        else if (qName==QName_8_327) {
          ((CustomerType)value).setProfileType(strValue);
          return true;}
        else if (qName==QName_8_328) {
          ((CustomerType)value).setPreferredCurrency(strValue);
          return true;}
        else if (qName==QName_8_329) {
          ((CustomerType)value).setStore(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseInteger(strValue));
          return true;}
        else if (qName==QName_8_330) {
          ((CustomerType)value).setPreferredLanguage(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseInteger(strValue));
          return true;}
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_8_331) {
          ((CustomerType)value).setAuthentication((com.mycompany.www.schema.AuthenticationType)objValue);
          return true;}
        else if (qName==QName_8_207) {
          ((CustomerType)value).setContact((com.mycompany.www.schema.ContactType)objValue);
          return true;}
        else if (qName==QName_8_332) {
          ((CustomerType)value).setDemographics((com.mycompany.www.schema.CustomerDemographicsType)objValue);
          return true;}
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        return false;
    }
    private final static javax.xml.namespace.QName QName_8_332 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Demographics");
    private final static javax.xml.namespace.QName QName_8_327 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "ProfileType");
    private final static javax.xml.namespace.QName QName_8_330 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "PreferredLanguage");
    private final static javax.xml.namespace.QName QName_8_328 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "PreferredCurrency");
    private final static javax.xml.namespace.QName QName_8_329 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Store");
    private final static javax.xml.namespace.QName QName_8_325 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "DisplayName");
    private final static javax.xml.namespace.QName QName_8_331 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Authentication");
    private final static javax.xml.namespace.QName QName_8_207 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Contact");
    private final static javax.xml.namespace.QName QName_8_326 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "ParentOrganization");
}
