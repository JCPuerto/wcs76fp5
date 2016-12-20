/**
 * SyncCustomerType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class SyncCustomerType_Deser extends org.openapplications.www.oagis._9.BusinessObjectDocumentType_Deser {
    /**
     * Constructor
     */
    public SyncCustomerType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new SyncCustomerType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return super.tryElementSetFromString(qName, strValue);
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return super.tryAttributeSetFromString(qName, strValue);
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_8_296) {
          ((SyncCustomerType)value).setDataArea((com.mycompany.www.schema.SyncCustomerDataAreaType)objValue);
          return true;}
        return super.tryElementSetFromObject(qName, objValue);
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        return super.tryElementSetFromList(qName, listValue);
    }
    private final static javax.xml.namespace.QName QName_8_296 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.mycompany.com/schema",
                  "DataArea");
}
