/**
 * ShipUnitReferenceType_Deser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ShipUnitReferenceType_Deser extends com.ibm.ws.webservices.engine.encoding.ser.BeanDeserializer {
    /**
     * Constructor
     */
    public ShipUnitReferenceType_Deser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    /**
     * Create instance of java bean
     */
    public void createValue() {
        value = new ShipUnitReferenceType();
    }
    protected boolean tryElementSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryAttributeSetFromString(javax.xml.namespace.QName qName, java.lang.String strValue) {
        return false;
    }
    protected boolean tryElementSetFromObject(javax.xml.namespace.QName qName, java.lang.Object objValue) {
        if (qName==QName_1_128) {
          ((ShipUnitReferenceType)value).setID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_200) {
          ((ShipUnitReferenceType)value).setSealID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_134) {
          ((ShipUnitReferenceType)value).setType((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_201) {
          ((ShipUnitReferenceType)value).setFreightItemID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_202) {
          ((ShipUnitReferenceType)value).setShippingTrackingID((javax.xml.soap.SOAPElement)objValue);
          return true;}
        else if (qName==QName_1_51) {
          if (objValue instanceof java.util.List) {
            javax.xml.soap.SOAPElement[] array = new javax.xml.soap.SOAPElement[((java.util.List)objValue).size()];
            ((java.util.List)objValue).toArray(array);
            ((ShipUnitReferenceType)value).setUserArea(array);
          } else { 
            ((ShipUnitReferenceType)value).setUserArea((javax.xml.soap.SOAPElement[])objValue);}
          return true;}
        return false;
    }
    protected boolean tryElementSetFromList(javax.xml.namespace.QName qName, java.util.List listValue) {
        return false;
    }
    private final static javax.xml.namespace.QName QName_1_202 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ShippingTrackingID");
    private final static javax.xml.namespace.QName QName_1_51 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserArea");
    private final static javax.xml.namespace.QName QName_1_201 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "FreightItemID");
    private final static javax.xml.namespace.QName QName_1_128 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "ID");
    private final static javax.xml.namespace.QName QName_1_200 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SealID");
    private final static javax.xml.namespace.QName QName_1_134 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "Type");
}
