/**
 * LotSerialType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class LotSerialType  {
    private javax.xml.soap.SOAPElement lotIDs;
    private javax.xml.soap.SOAPElement[] serialNumber;
    private javax.xml.soap.SOAPElement[] userArea;

    public LotSerialType() {
    }

    public javax.xml.soap.SOAPElement getLotIDs() {
        return lotIDs;
    }

    public void setLotIDs(javax.xml.soap.SOAPElement lotIDs) {
        this.lotIDs = lotIDs;
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

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
