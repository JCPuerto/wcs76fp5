/**
 * RecurrenceType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class RecurrenceType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public RecurrenceType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new RecurrenceType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        if (qName==QName_1_256) {
          ((RecurrenceType)value).setEveryDayIndicator(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBoolean(strValue));
          return true;}
        else if (qName==QName_1_257) {
          ((RecurrenceType)value).setFrequency(com.ibm.ws.webservices.engine.encoding.ser.SimpleDeserializer.parseBigDecimal(strValue));
          return true;}
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_1_255) {
          ((RecurrenceType)value).setOccursEveryQuantity((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_259) {
          ((RecurrenceType)value).setOfEveryQuantity((javax.xml.soap.SOAPElement)objValue);
          return true;}
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        if (qName==QName_1_258) {
          javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[listValue.size()];
          listValue.toArray(array);
          ((RecurrenceType)value).setDayOfWeek(array);
          return true;}
        return false;
    }
    private final static javax.xml.namespace.QName QName_1_256 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "EveryDayIndicator");
    private final static javax.xml.namespace.QName QName_1_254 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "RecurrencePatternCodeContentType");
    private final static javax.xml.namespace.QName QName_1_258 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DayOfWeek");
    private final static javax.xml.namespace.QName QName_1_257 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Frequency");
    private final static javax.xml.namespace.QName QName_1_259 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "OfEveryQuantity");
    private final static javax.xml.namespace.QName QName_0_253 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "",
                  "pattern");
    private final static javax.xml.namespace.QName QName_1_255 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "OccursEveryQuantity");
}
