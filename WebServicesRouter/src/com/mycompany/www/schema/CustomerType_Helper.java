/**
 * CustomerType_Helper.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class CustomerType_Helper {
    // Type metadata
    private static final com.ibm.ws.webservices.engine.description.TypeDesc typeDesc =
        new com.ibm.ws.webservices.engine.description.TypeDesc(CustomerType.class);

    static {
        typeDesc.setOption("buildNum","cf231216.04");
        com.ibm.ws.webservices.engine.description.FieldDesc field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("displayName");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "DisplayName"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "string"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("parentOrganization");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "ParentOrganization"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "string"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("profileType");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "ProfileType"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "string"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("preferredCurrency");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "PreferredCurrency"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "string"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("store");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "Store"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "int"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("preferredLanguage");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "PreferredLanguage"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.w3.org/2001/XMLSchema", "int"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("authentication");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "Authentication"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "AuthenticationType"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("contact");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "Contact"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "ContactType"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("demographics");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "Demographics"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.mycompany.com/schema", "CustomerDemographicsType"));
        field.setMinOccursIs0(true);
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
          new CustomerType_Ser(
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
          new CustomerType_Deser(
            javaType, xmlType, typeDesc);
    };

}
