/**
 * SenderType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class SenderType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public SenderType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new SenderType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_1_57) {
          ((SenderType)value).setLogicalID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_58) {
          ((SenderType)value).setComponentID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_59) {
          ((SenderType)value).setTaskID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_60) {
          ((SenderType)value).setReferenceID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_61) {
          ((SenderType)value).setConfirmationCode((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_62) {
          ((SenderType)value).setAuthorizationID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        return false;
    }
    private final static javax.xml.namespace.QName QName_1_62 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "AuthorizationID");
    private final static javax.xml.namespace.QName QName_1_60 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ReferenceID");
    private final static javax.xml.namespace.QName QName_1_61 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ConfirmationCode");
    private final static javax.xml.namespace.QName QName_1_59 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "TaskID");
    private final static javax.xml.namespace.QName QName_1_58 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ComponentID");
    private final static javax.xml.namespace.QName QName_1_57 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "LogicalID");
}
