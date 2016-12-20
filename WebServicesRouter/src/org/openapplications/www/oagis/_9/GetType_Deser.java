/**
 * GetType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class GetType_Deser extends org.openapplications.www.oagis._9.RequestVerbType_Deser {
    /**
     * Constructor
     */
    public GetType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new GetType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return super.tryElementSetFromString(qName, strValue);
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        if (qName==QName_0_89) {
          ((GetType)value).setUniqueIndicator(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBoolean(strValue));
          return true;}
        else if (qName==QName_0_90) {
          ((GetType)value).setMaxItems(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBigInteger(strValue));
          return true;}
        else if (qName==QName_0_92) {
          ((GetType)value).setRecordSetSaveIndicator(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBoolean(strValue));
          return true;}
        else if (qName==QName_0_93) {
          ((GetType)value).setRecordSetStartNumber(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBigInteger(strValue));
          return true;}
        else if (qName==QName_0_94) {
          ((GetType)value).setRecordSetReferenceId(strValue);
          return true;}
        return super.tryAttributeSetFromString(qName, strValue);
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        return super.tryElementSetFromObject(qName, objValue);
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        return super.tryElementSetFromList(qName, listValue);
    }
    private final static javax.xml.namespace.QName QName_0_90 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "maxItems");
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
    private final static javax.xml.namespace.QName QName_0_92 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "recordSetSaveIndicator");
    private final static javax.xml.namespace.QName QName_1_39 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "NormalizedStringType");
    private final static javax.xml.namespace.QName QName_0_89 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "uniqueIndicator");
    private final static javax.xml.namespace.QName QName_1_91 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "PositiveIntegerNumericType");
}
