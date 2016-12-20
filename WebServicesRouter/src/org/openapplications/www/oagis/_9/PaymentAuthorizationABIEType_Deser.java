/**
 * PaymentAuthorizationABIEType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class PaymentAuthorizationABIEType_Deser extends org.openapplications.www.oagis._9.AuthorizationABIEType_Deser {
    /**
     * Constructor
     */
    public PaymentAuthorizationABIEType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new PaymentAuthorizationABIEType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return super.tryElementSetFromString(qName, strValue);
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return super.tryAttributeSetFromString(qName, strValue);
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_1_149) {
          ((PaymentAuthorizationABIEType)value).setReferenceOrderNumber((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_150) {
          ((PaymentAuthorizationABIEType)value).setRevenueSourceID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_151) {
          ((PaymentAuthorizationABIEType)value).setRemittanceBankID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        return super.tryElementSetFromObject(qName, objValue);
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        return super.tryElementSetFromList(qName, listValue);
    }
    private final static javax.xml.namespace.QName QName_1_149 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ReferenceOrderNumber");
    private final static javax.xml.namespace.QName QName_1_150 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "RevenueSourceID");
    private final static javax.xml.namespace.QName QName_1_151 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "RemittanceBankID");
}
