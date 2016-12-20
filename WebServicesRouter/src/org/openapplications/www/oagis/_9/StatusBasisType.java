/**
 * StatusBasisType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class StatusBasisType  {
    private javax.xml.soap.SOAPElement code;
    private javax.xml.soap.SOAPElement description;
    private javax.xml.soap.SOAPElement effectiveDateTime;
    private javax.xml.soap.SOAPElement reasonCode;
    private javax.xml.soap.SOAPElement[] reason;

    public StatusBasisType() {
    }

    public javax.xml.soap.SOAPElement getCode() {
        return code;
    }

    public void setCode(javax.xml.soap.SOAPElement code) {
        this.code = code;
    }

    public javax.xml.soap.SOAPElement getDescription() {
        return description;
    }

    public void setDescription(javax.xml.soap.SOAPElement description) {
        this.description = description;
    }

    public javax.xml.soap.SOAPElement getEffectiveDateTime() {
        return effectiveDateTime;
    }

    public void setEffectiveDateTime(javax.xml.soap.SOAPElement effectiveDateTime) {
        this.effectiveDateTime = effectiveDateTime;
    }

    public javax.xml.soap.SOAPElement getReasonCode() {
        return reasonCode;
    }

    public void setReasonCode(javax.xml.soap.SOAPElement reasonCode) {
        this.reasonCode = reasonCode;
    }

    public javax.xml.soap.SOAPElement[] getReason() {
        return reason;
    }

    public void setReason(javax.xml.soap.SOAPElement[] reason) {
        this.reason = reason;
    }

    public javax.xml.soap.SOAPElement getReason(int i) {
        return this.reason[i];
    }

    public void setReason(int i, javax.xml.soap.SOAPElement value) {
        this.reason[i] = value;
    }

}
