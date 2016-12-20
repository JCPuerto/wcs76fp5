/**
 * CodeType_Helper.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9.unqualifieddatatypes._1._1;

public class CodeType_Helper {
    // Type metadata
    private static final com.ibm.ws.webservices.engine.description.TypeDesc typeDesc =
        new com.ibm.ws.webservices.engine.description.TypeDesc(CodeType.class);

    static {
        typeDesc.setOption("buildNum","cf231216.04");
        com.ibm.ws.webservices.engine.description.FieldDesc field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("listID");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "listID"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "normalizedString"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("listAgencyID");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "listAgencyID"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "normalizedString"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("listAgencyName");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "listAgencyName"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "string"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("listName");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "listName"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "string"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("listVersionID");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "listVersionID"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "normalizedString"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("name");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "name"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "string"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("languageID");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "languageID"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "language"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("listURI");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "listURI"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "anyURI"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("listSchemeURI");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "listSchemeURI"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "anyURI"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("_value");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "_value"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "normalizedString"));
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
          new CodeType_Ser(
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
          new CodeType_Deser(
            javaType, xmlType, typeDesc);
    };

}
