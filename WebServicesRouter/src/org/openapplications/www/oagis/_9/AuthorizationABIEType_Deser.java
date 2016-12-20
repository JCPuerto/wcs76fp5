/**
 * AuthorizationABIEType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class AuthorizationABIEType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public AuthorizationABIEType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new AuthorizationABIEType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_1_129) {
          ((AuthorizationABIEType)value).setResponseCode((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_130) {
          ((AuthorizationABIEType)value).setAuthorizationDate((java.util.Calendar)objValue);
          return true;}
        else if (qName==QName_1_131) {
          ((AuthorizationABIEType)value).setAmount((javax.xml.soap.SOAPElement)objValue);
          return true;}
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        if (qName==QName_1_128) {
          javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[listValue.size()];
          listValue.toArray(array);
          ((AuthorizationABIEType)value).setID(array);
          return true;}
        return false;
    }
    private final static javax.xml.namespace.QName QName_1_128 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ID");
    private final static javax.xml.namespace.QName QName_1_131 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Amount");
    private final static javax.xml.namespace.QName QName_1_130 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "AuthorizationDate");
    private final static javax.xml.namespace.QName QName_1_129 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ResponseCode");
}
