/**
 * StatusBasisType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class StatusBasisType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public StatusBasisType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new StatusBasisType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_1_99) {
          ((StatusBasisType)value).setCode((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_100) {
          ((StatusBasisType)value).setDescription((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_101) {
          ((StatusBasisType)value).setEffectiveDateTime((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_102) {
          ((StatusBasisType)value).setReasonCode((javax.xml.soap.SOAPElement)objValue);
          return true;}
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        if (qName==QName_1_103) {
          javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[listValue.size()];
          listValue.toArray(array);
          ((StatusBasisType)value).setReason(array);
          return true;}
        return false;
    }
    private final static javax.xml.namespace.QName QName_1_101 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "EffectiveDateTime");
    private final static javax.xml.namespace.QName QName_1_100 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Description");
    private final static javax.xml.namespace.QName QName_1_99 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Code");
    private final static javax.xml.namespace.QName QName_1_103 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Reason");
    private final static javax.xml.namespace.QName QName_1_102 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ReasonCode");
}
