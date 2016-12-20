/**
 * UserAuthorizationType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class UserAuthorizationType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public UserAuthorizationType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new UserAuthorizationType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_1_134) {
          ((UserAuthorizationType)value).setType((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_168) {
          ((UserAuthorizationType)value).setStatus((org.openapplications.www.oagis._9.StatusType)objValue);
          return true;}
        else if (qName==QName_1_169) {
          ((UserAuthorizationType)value).setAuthorizedDateTime((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_122) {
          ((UserAuthorizationType)value).setEffectiveTimePeriod((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_170) {
          ((UserAuthorizationType)value).setAuthorizationCode((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_51) {
          if (objValue instanceof java.util.List) {
            javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[((java.util.List)objValue).size()];
            ((java.util.List)objValue).toArray(array);
            ((UserAuthorizationType)value).setUserArea(array);
          } else { 
            ((UserAuthorizationType)value).setUserArea((javax.xml.soap.SOAPElement[])objValue);}
          return true;}
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        if (qName==QName_1_128) {
          javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[listValue.size()];
          listValue.toArray(array);
          ((UserAuthorizationType)value).setID(array);
          return true;}
        return false;
    }
    private final static javax.xml.namespace.QName QName_1_168 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Status");
    private final static javax.xml.namespace.QName QName_1_51 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserArea");
    private final static javax.xml.namespace.QName QName_1_122 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "EffectiveTimePeriod");
    private final static javax.xml.namespace.QName QName_1_128 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ID");
    private final static javax.xml.namespace.QName QName_1_169 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "AuthorizedDateTime");
    private final static javax.xml.namespace.QName QName_1_170 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "AuthorizationCode");
    private final static javax.xml.namespace.QName QName_1_134 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Type");
}
