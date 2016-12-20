/**
 * NameValuePairType_Helper.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class NameValuePairType_Helper {
    // Type metadata
    private static final com.ibm.ws.webservices.engine.description.TypeDesc typeDesc =
        new com.ibm.ws.webservices.engine.description.TypeDesc(NameValuePairType.class);

    static {
        typeDesc.setOption("buildNum","cf231216.04");
        com.ibm.ws.webservices.engine.description.FieldDesc field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("name");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "name"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "NormalizedStringType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("type");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "type"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "NormalizedStringType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("unitCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "unitCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "UnitCodeContentType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("unitCodeListVersionID");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "unitCodeListVersionID"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "NormalizedStringType"));
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
          new NameValuePairType_Ser(
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
          new NameValuePairType_Deser(
            javaType, xmlType, typeDesc);
    };

}
