/**
 * LotType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class LotType  {
    private java.math.BigInteger displaySequence;  // attribute
    private javax.xml.soap.SOAPElement lotIDs;
    private javax.xml.soap.SOAPElement effectiveTimePeriod;
    private javax.xml.soap.SOAPElement quantity;
    private javax.xml.soap.SOAPElement[] serialNumber;
    private javax.xml.soap.SOAPElement[] RFID;
    private javax.xml.soap.SOAPElement[] userArea;

    public LotType() {
    }

    public java.math.BigInteger getDisplaySequence() {
        return displaySequence;
    }

    public void setDisplaySequence(java.math.BigInteger displaySequence) {
        this.displaySequence = displaySequence;
    }

    public javax.xml.soap.SOAPElement getLotIDs() {
        return lotIDs;
    }

    public void setLotIDs(javax.xml.soap.SOAPElement lotIDs) {
        this.lotIDs = lotIDs;
    }

    public javax.xml.soap.SOAPElement getEffectiveTimePeriod() {
        return effectiveTimePeriod;
    }

    public void setEffectiveTimePeriod(javax.xml.soap.SOAPElement effectiveTimePeriod) {
        this.effectiveTimePeriod = effectiveTimePeriod;
    }

    public javax.xml.soap.SOAPElement getQuantity() {
        return quantity;
    }

    public void setQuantity(javax.xml.soap.SOAPElement quantity) {
        this.quantity = quantity;
    }

    public javax.xml.soap.SOAPElement[] getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(javax.xml.soap.SOAPElement[] serialNumber) {
        this.serialNumber = serialNumber;
    }

    public javax.xml.soap.SOAPElement getSerialNumber(int i) {
        return this.serialNumber[i];
    }

    public void setSerialNumber(int i, javax.xml.soap.SOAPElement value) {
        this.serialNumber[i] = value;
    }

    public javax.xml.soap.SOAPElement[] getRFID() {
        return RFID;
    }

    public void setRFID(javax.xml.soap.SOAPElement[] RFID) {
        this.RFID = RFID;
    }

    public javax.xml.soap.SOAPElement getRFID(int i) {
        return this.RFID[i];
    }

    public void setRFID(int i, javax.xml.soap.SOAPElement value) {
        this.RFID[i] = value;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
