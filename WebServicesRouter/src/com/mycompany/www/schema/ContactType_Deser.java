/**
 * ContactType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class ContactType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public ContactType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new ContactType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        if (qName==QName_8_320) {
          ((ContactType)value).setFirstName(strValue);
          return true;}
        else if (qName==QName_8_321) {
          ((ContactType)value).setLastName(strValue);
          return true;}
        else if (qName==QName_8_322) {
          ((ContactType)value).setPhoneNumber(strValue);
          return true;}
        else if (qName==QName_8_323) {
          ((ContactType)value).setFaxNumber(strValue);
          return true;}
        else if (qName==QName_8_324) {
          ((ContactType)value).setEmail(strValue);
          return true;}
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_8_232) {
          ((ContactType)value).setAddress((com.mycompany.www.schema.AddressType)objValue);
          return true;}
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        return false;
    }
    private final static javax.xml.namespace.QName QName_8_322 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "PhoneNumber");
    private final static javax.xml.namespace.QName QName_8_323 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "FaxNumber");
    private final static javax.xml.namespace.QName QName_8_321 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "LastName");
    private final static javax.xml.namespace.QName QName_8_232 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Address");
    private final static javax.xml.namespace.QName QName_8_324 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Email");
    private final static javax.xml.namespace.QName QName_8_320 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "FirstName");
}
