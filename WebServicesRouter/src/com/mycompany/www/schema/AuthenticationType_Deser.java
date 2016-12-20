/**
 * AuthenticationType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class AuthenticationType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public AuthenticationType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new AuthenticationType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        if (qName==QName_8_310) {
          ((AuthenticationType)value).setLogon(strValue);
          return true;}
        else if (qName==QName_8_311) {
          ((AuthenticationType)value).setPassword(strValue);
          return true;}
        else if (qName==QName_8_312) {
          ((AuthenticationType)value).setPasswordVerify(strValue);
          return true;}
        else if (qName==QName_8_313) {
          ((AuthenticationType)value).setChallengeQuestion(strValue);
          return true;}
        else if (qName==QName_8_314) {
          ((AuthenticationType)value).setChallengeAnswer(strValue);
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
    private final static javax.xml.namespace.QName QName_8_310 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Logon");
    private final static javax.xml.namespace.QName QName_8_314 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "ChallengeAnswer");
    private final static javax.xml.namespace.QName QName_8_312 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "PasswordVerify");
    private final static javax.xml.namespace.QName QName_8_313 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "ChallengeQuestion");
    private final static javax.xml.namespace.QName QName_8_311 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "Password");
}
