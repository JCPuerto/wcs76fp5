/**
 * ConfirmBODDataAreaType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ConfirmBODDataAreaType  {
    private org.openapplications.www.oagis._9.ConfirmType confirm;
    private javax.xml.soap.SOAPElement[] BOD;

    public ConfirmBODDataAreaType() {
    }

    public org.openapplications.www.oagis._9.ConfirmType getConfirm() {
        return confirm;
    }

    public void setConfirm(org.openapplications.www.oagis._9.ConfirmType confirm) {
        this.confirm = confirm;
    }

    public javax.xml.soap.SOAPElement[] getBOD() {
        return BOD;
    }

    public void setBOD(javax.xml.soap.SOAPElement[] BOD) {
        this.BOD = BOD;
    }

    public javax.xml.soap.SOAPElement getBOD(int i) {
        return this.BOD[i];
    }

    public void setBOD(int i, javax.xml.soap.SOAPElement value) {
        this.BOD[i] = value;
    }

}
