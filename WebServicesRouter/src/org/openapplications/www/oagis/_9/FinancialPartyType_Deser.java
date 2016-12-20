/**
 * FinancialPartyType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class FinancialPartyType_Deser extends org.openapplications.www.oagis._9.PartyBaseType_Deser {
    /**
     * Constructor
     */
    public FinancialPartyType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new FinancialPartyType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return super.tryElementSetFromString(qName, strValue);
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return super.tryAttributeSetFromString(qName, strValue);
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_1_217) {
          ((FinancialPartyType)value).setClearingSystemMemberID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_218) {
          ((FinancialPartyType)value).setBranchParty((org.openapplications.www.oagis._9.SemanticPartyType)objValue);
          return true;}
        else if (qName==QName_1_220) {
          ((FinancialPartyType)value).setCountryCode((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_51) {
          if (objValue instanceof java.util.List) {
            javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[((java.util.List)objValue).size()];
            ((java.util.List)objValue).toArray(array);
            ((FinancialPartyType)value).setUserArea(array);
          } else { 
            ((FinancialPartyType)value).setUserArea((javax.xml.soap.SOAPElement[])objValue);}
          return true;}
        return super.tryElementSetFromObject(qName, objValue);
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        if (qName==QName_1_219) {
          javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[listValue.size()];
          listValue.toArray(array);
          ((FinancialPartyType)value).setFinancialAccount(array);
          return true;}
        return super.tryElementSetFromList(qName, listValue);
    }
    private final static javax.xml.namespace.QName QName_1_220 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "CountryCode");
    private final static javax.xml.namespace.QName QName_1_51 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserArea");
    private final static javax.xml.namespace.QName QName_1_219 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "FinancialAccount");
    private final static javax.xml.namespace.QName QName_1_218 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "BranchParty");
    private final static javax.xml.namespace.QName QName_1_217 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ClearingSystemMemberID");
}
