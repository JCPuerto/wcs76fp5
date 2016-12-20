/**
 * SpecificationType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class SpecificationType  {
    private java.lang.String type;  // attribute
    private javax.xml.soap.SOAPElement[] property;

    public SpecificationType() {
    }

    public java.lang.String getType() {
        return type;
    }

    public void setType(java.lang.String type) {
        this.type = type;
    }

    public javax.xml.soap.SOAPElement[] getProperty() {
        return property;
    }

    public void setProperty(javax.xml.soap.SOAPElement[] property) {
        this.property = property;
    }

    public javax.xml.soap.SOAPElement getProperty(int i) {
        return this.property[i];
    }

    public void setProperty(int i, javax.xml.soap.SOAPElement value) {
        this.property[i] = value;
    }

}
