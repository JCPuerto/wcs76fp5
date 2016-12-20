/**
 * TelephoneNumberType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class TelephoneNumberType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.SimpleBeanDeserializer {
    /**
     * Constructor
     */
    public TelephoneNumberType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new TelephoneNumberType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        if (qName==QName_0_2) {
          ((TelephoneNumberType)value).set_value(strValue);
          return true;}
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        if (qName==QName_0_290) {
          ((TelephoneNumberType)value).setNumberFormat(strValue);
          return true;}
        else if (qName==QName_0_291) {
          ((TelephoneNumberType)value).setAccessCode(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBigInteger(strValue));
          return true;}
        else if (qName==QName_0_292) {
          ((TelephoneNumberType)value).setCountryCode(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBigInteger(strValue));
          return true;}
        else if (qName==QName_0_293) {
          ((TelephoneNumberType)value).setAreaCode(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBigInteger(strValue));
          return true;}
        else if (qName==QName_0_294) {
          ((TelephoneNumberType)value).setExchangeCode(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBigInteger(strValue));
          return true;}
        else if (qName==QName_0_295) {
          ((TelephoneNumberType)value).setExtension(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBigInteger(strValue));
          return true;}
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        return false;
    }
    private final static javax.xml.namespace.QName QName_0_294 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "exchangeCode");
    private final static javax.xml.namespace.QName QName_1_39 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NormalizedStringType");
    private final static javax.xml.namespace.QName QName_0_291 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "accessCode");
    private final static javax.xml.namespace.QName QName_0_292 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "countryCode");
    private final static javax.xml.namespace.QName QName_0_293 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "areaCode");
    private final static javax.xml.namespace.QName QName_1_91 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PositiveIntegerNumericType");
    private final static javax.xml.namespace.QName QName_0_290 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "numberFormat");
    private final static javax.xml.namespace.QName QName_0_295 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "extension");
    private final static javax.xml.namespace.QName QName_0_2 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "_value");
}
