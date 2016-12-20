/**
 * BusinessObjectDocumentType_Helper.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class BusinessObjectDocumentType_Helper {
    // Type metadata
    private static final com.ibm.ws.webservices.engine.description.TypeDesc typeDesc =
        new com.ibm.ws.webservices.engine.description.TypeDesc(BusinessObjectDocumentType.class);

    static {
        typeDesc.setOption("buildNum","cf231216.04");
        com.ibm.ws.webservices.engine.description.FieldDesc field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("releaseID");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "releaseID"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "NormalizedStringType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("versionID");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "versionID"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "NormalizedStringType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("systemEnvironmentCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "systemEnvironmentCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "SystemEnvironmentCodeContentType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.AttributeDesc();
        field.setFieldName("languageCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("", "languageCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "LanguageCodeType"));
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("applicationArea");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "ApplicationArea"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "ApplicationAreaType"));
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
          new BusinessObjectDocumentType_Ser(
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
          new BusinessObjectDocumentType_Deser(
            javaType, xmlType, typeDesc);
    };

}
