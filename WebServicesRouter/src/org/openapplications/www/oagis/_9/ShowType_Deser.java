/**
 * ShowType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ShowType_Deser extends org.openapplications.www.oagis._9.ResponseVerbType_Deser {
    /**
     * Constructor
     */
    public ShowType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new ShowType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return super.tryElementSetFromString(qName, strValue);
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        if (qName==QName_0_93) {
          ((ShowType)value).setRecordSetStartNumber(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBigInteger(strValue));
          return true;}
        else if (qName==QName_0_96) {
          ((ShowType)value).setRecordSetCount(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBigInteger(strValue));
          return true;}
        else if (qName==QName_0_97) {
          ((ShowType)value).setRecordSetTotal(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBigInteger(strValue));
          return true;}
        else if (qName==QName_0_98) {
          ((ShowType)value).setRecordSetCompleteIndicator(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBoolean(strValue));
          return true;}
        else if (qName==QName_0_94) {
          ((ShowType)value).setRecordSetReferenceId(strValue);
          return true;}
        return super.tryAttributeSetFromString(qName, strValue);
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        return super.tryElementSetFromObject(qName, objValue);
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        return super.tryElementSetFromList(qName, listValue);
    }
    private final static javax.xml.namespace.QName QName_0_98 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "recordSetCompleteIndicator");
    private final static javax.xml.namespace.QName QName_0_93 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "recordSetStartNumber");
    private final static javax.xml.namespace.QName QName_1_3 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "IndicatorType");
    private final static javax.xml.namespace.QName QName_0_94 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "recordSetReferenceId");
    private final static javax.xml.namespace.QName QName_1_39 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NormalizedStringType");
    private final static javax.xml.namespace.QName QName_0_97 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "recordSetTotal");
    private final static javax.xml.namespace.QName QName_0_96 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "recordSetCount");
    private final static javax.xml.namespace.QName QName_1_91 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PositiveIntegerNumericType");
}
