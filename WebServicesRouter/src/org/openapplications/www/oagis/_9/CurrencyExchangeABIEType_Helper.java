/**
 * CurrencyExchangeABIEType_Helper.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class CurrencyExchangeABIEType_Helper {
    // Type metadata
    private static final com.ibm.ws.webservices.engine.description.TypeDesc typeDesc =
        new com.ibm.ws.webservices.engine.description.TypeDesc(CurrencyExchangeABIEType.class);

    static {
        typeDesc.setOption("buildNum","cf231216.04");
        com.ibm.ws.webservices.engine.description.FieldDesc field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("sourceCurrencyCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "SourceCurrencyCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "CurrencyCodeType"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("sourceUnitBaseNumeric");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "SourceUnitBaseNumeric"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "NumericType"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("targetCurrencyCode");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "TargetCurrencyCode"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "CurrencyCodeType"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("targetUnitBaseNumeric");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "TargetUnitBaseNumeric"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "NumericType"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("rateNumeric");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "RateNumeric"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "NumericType"));
        field.setMinOccursIs0(true);
        typeDesc.addFieldDesc(field);
        field = new com.ibm.ws.webservices.engine.description.ElementDesc();
        field.setFieldName("setDateTime");
        field.setXmlName(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "SetDateTime"));
        field.setXmlType(com.ibm.ws.webservices.engine.utils.QNameTable.createQName("http://www.openapplications.org/oagis/9", "DateTimeType"));
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
          new CurrencyExchangeABIEType_Ser(
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
          new CurrencyExchangeABIEType_Deser(
            javaType, xmlType, typeDesc);
    };

}
