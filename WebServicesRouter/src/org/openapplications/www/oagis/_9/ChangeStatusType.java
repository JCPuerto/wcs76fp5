/**
 * ChangeStatusType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ChangeStatusType  extends org.openapplications.www.oagis._9.StatusBasisType  {
    private javax.xml.soap.SOAPElement[] stateChange;
    private javax.xml.soap.SOAPElement[] userArea;

    public ChangeStatusType() {
    }

    public javax.xml.soap.SOAPElement[] getStateChange() {
        return stateChange;
    }

    public void setStateChange(javax.xml.soap.SOAPElement[] stateChange) {
        this.stateChange = stateChange;
    }

    public javax.xml.soap.SOAPElement getStateChange(int i) {
        return this.stateChange[i];
    }

    public void setStateChange(int i, javax.xml.soap.SOAPElement value) {
        this.stateChange[i] = value;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
