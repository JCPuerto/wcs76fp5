/**
 * SuccessMessageType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class SuccessMessageType  {
    private javax.xml.soap.SOAPElement[] warningProcessMessage;
    private javax.xml.soap.SOAPElement[] userArea;

    public SuccessMessageType() {
    }

    public javax.xml.soap.SOAPElement[] getWarningProcessMessage() {
        return warningProcessMessage;
    }

    public void setWarningProcessMessage(javax.xml.soap.SOAPElement[] warningProcessMessage) {
        this.warningProcessMessage = warningProcessMessage;
    }

    public javax.xml.soap.SOAPElement getWarningProcessMessage(int i) {
        return this.warningProcessMessage[i];
    }

    public void setWarningProcessMessage(int i, javax.xml.soap.SOAPElement value) {
        this.warningProcessMessage[i] = value;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
