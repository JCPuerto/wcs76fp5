/**
 * SignatoryContactType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class SignatoryContactType  extends org.openapplications.www.oagis._9.ContactABIEType  {
    private javax.xml.soap.SOAPElement signedDateTime;
    private javax.xml.soap.SOAPElement[] userArea;

    public SignatoryContactType() {
    }

    public javax.xml.soap.SOAPElement getSignedDateTime() {
        return signedDateTime;
    }

    public void setSignedDateTime(javax.xml.soap.SOAPElement signedDateTime) {
        this.signedDateTime = signedDateTime;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
