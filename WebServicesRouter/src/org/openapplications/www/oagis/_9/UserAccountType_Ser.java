/**
 * UserAccountType_Ser.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class UserAccountType_Ser extends com.ibm.ws.webservices.engine.encoding.ser.BeanSerializer {
    /**
     * Constructor
     */
    public UserAccountType_Ser(
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType, 
           com.ibm.ws.webservices.engine.description.TypeDesc _typeDesc) {
        super(_javaType, _xmlType, _typeDesc);
    }
    public void serialize(
        javax.xml.namespace.QName name,
        org.xml.sax.Attributes attributes,
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        context.startElement(name, addAttributes(attributes, value, context));
        addElements(value, context);
        context.endElement();
    }
    protected org.xml.sax.Attributes addAttributes(
        org.xml.sax.Attributes attributes,
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
           javax.xml.namespace.QName
           elemQName = QName_1_163;
           context.qName2String(elemQName, true);
           elemQName = QName_1_164;
           context.qName2String(elemQName, true);
           elemQName = QName_1_165;
           context.qName2String(elemQName, true);
           elemQName = QName_1_166;
           context.qName2String(elemQName, true);
           elemQName = QName_1_51;
           context.qName2String(elemQName, true);
        return attributes;
    }
    protected void addElements(
        java.lang.Object value,
        com.ibm.ws.webservices.engine.encoding.SerializationContext context)
        throws java.io.IOException
    {
        UserAccountType bean = (UserAccountType) value;
        java.lang.Object propValue;
        javax.xml.namespace.QName propQName;
        {
          propQName = QName_1_163;
          propValue = bean.getSystemID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_164;
          propValue = bean.getAccountID();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_55,
              false,null,context);
          propQName = QName_1_165;
          propValue = bean.getAccountType();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_104,
              false,null,context);
          propQName = QName_1_166;
          {
            propValue = bean.getUserAuthorization();
            if (propValue != null) {
              for (int i=0; i<java.lang.reflect.Array.getLength(propValue); i++) {
                serializeChild(propQName, null, 
                    java.lang.reflect.Array.get(propValue, i), 
                    QName_1_167,
                    true,null,context);
              }
            }
          }
          propQName = QName_1_51;
          propValue = bean.getUserArea();
          serializeChild(propQName, null, 
              propValue, 
              QName_1_56,
              false,null,context);
        }
    }
    private final static javax.xml.namespace.QName QName_1_51 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserArea");
    private final static javax.xml.namespace.QName QName_1_164 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "AccountID");
    private final static javax.xml.namespace.QName QName_1_163 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "SystemID");
    private final static javax.xml.namespace.QName QName_1_167 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserAuthorizationType");
    private final static javax.xml.namespace.QName QName_1_56 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserAreaType");
    private final static javax.xml.namespace.QName QName_1_104 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "CodeType");
    private final static javax.xml.namespace.QName QName_1_165 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "AccountType");
    private final static javax.xml.namespace.QName QName_1_55 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "IdentifierType");
    private final static javax.xml.namespace.QName QName_1_166 = 
           com.ibm.ws.webservices.engine.utils.QNameTable.createQName(
                  "http://www.openapplications.org/oagis/9",
                  "UserAuthorization");
}
