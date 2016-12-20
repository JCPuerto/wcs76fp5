/**
 * BinaryObjectType_Helper.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.unqualifieddatatypes._1._1;

public class BinaryObjectType_Helper {
    // Type metadata
    private static final com.ibm.ws.webservices.engine.description.TypeDesc typeDesc =
        new com.ibm.ws.webservices.engine.description.TypeDesc(BinaryObjectType.class);

    static {
        typeDesc.setOption("buildNum","cf231216.04");
        com.ibm.ws.webservices.engine.description.FieldDesc field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("format");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "format"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "string"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("mimeCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "mimeCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9/codelists", "MIMECodeContentType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("encodingCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "encodingCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "normalizedString"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("characterSetCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "characterSetCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "normalizedString"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("uri");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "uri"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "anyURI"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("filename");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "filename"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "string"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("_value");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "_value"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "base64Binary"));
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
          new BinaryObjectType_Ser(
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
          new BinaryObjectType_Deser(
            javaType, xmlType, typeDesc);
    };

}
