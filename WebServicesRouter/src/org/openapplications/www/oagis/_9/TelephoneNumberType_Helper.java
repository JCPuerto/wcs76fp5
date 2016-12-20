/**
 * TelephoneNumberType_Helper.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class TelephoneNumberType_Helper {
    // Type metadata
    private static final com.ibm.ws.webservices.engine.description.TypeDesc typeDesc =
        new com.ibm.ws.webservices.engine.description.TypeDesc(TelephoneNumberType.class);

    static {
        typeDesc.setOption("buildNum","cf231216.04");
        com.ibm.ws.webservices.engine.description.FieldDesc field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("numberFormat");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "numberFormat"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "NormalizedStringType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("accessCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "accessCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "PositiveIntegerNumericType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("countryCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "countryCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "PositiveIntegerNumericType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("areaCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "areaCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "PositiveIntegerNumericType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("exchangeCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "exchangeCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "PositiveIntegerNumericType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("extension");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "extension"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "PositiveIntegerNumericType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("_value");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "_value"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "StringType"));
        typeDesc.addFieldDesc(field);
    };

    /**
     * Return type metadata object
     */
    public static com.ibm.ws.webservices.engine.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static com.ibm.ws.webservices.engine.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class javaType,  
           javax.xml.namespace.QName xmlType) {
        return 
          new TelephoneNumberType_Ser(
            javaType, xmlType, typeDesc);
    };

    /**
     * Get Custom Deserializer
     */
    public static com.ibm.ws.webservices.engine.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class javaType,  
           javax.xml.namespace.QName xmlType) {
        return 
          new TelephoneNumberType_Deser(
            javaType, xmlType, typeDesc);
    };

}
