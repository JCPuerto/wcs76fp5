/**
 * PositionType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class PositionType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public PositionType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new PositionType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_1_234) {
          ((PositionType)value).setDegreeMeasure((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_235) {
          ((PositionType)value).setMinuteMeasure((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_236) {
          ((PositionType)value).setSecondMeasure((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_237) {
          ((PositionType)value).setDirectionCode((javax.xml.soap.SOAPElement)objValue);
          return true;}
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        return false;
    }
    private final static javax.xml.namespace.QName QName_1_234 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DegreeMeasure");
    private final static javax.xml.namespace.QName QName_1_236 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SecondMeasure");
    private final static javax.xml.namespace.QName QName_1_235 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "MinuteMeasure");
    private final static javax.xml.namespace.QName QName_1_237 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "DirectionCode");
}
