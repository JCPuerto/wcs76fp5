/**
 * LocationABIEType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class LocationABIEType  {
    private java.lang.String type;  // attribute
    private javax.xml.soap.SOAPElement[] ID;
    private javax.xml.soap.SOAPElement[] name;
    private javax.xml.soap.SOAPElement directions;
    private javax.xml.soap.SOAPElement coordinate;
    private javax.xml.soap.SOAPElement[] address;

    public LocationABIEType() {
    }

    public java.lang.String getType() {
        return type;
    }

    public void setType(java.lang.String type) {
        this.type = type;
    }

    public javax.xml.soap.SOAPElement[] getID() {
        return ID;
    }

    public void setID(javax.xml.soap.SOAPElement[] ID) {
        this.ID = ID;
    }

    public javax.xml.soap.SOAPElement getID(int i) {
        return this.ID[i];
    }

    public void setID(int i, javax.xml.soap.SOAPElement value) {
        this.ID[i] = value;
    }

    public javax.xml.soap.SOAPElement[] getName() {
        return name;
    }

    public void setName(javax.xml.soap.SOAPElement[] name) {
        this.name = name;
    }

    public javax.xml.soap.SOAPElement getName(int i) {
        return this.name[i];
    }

    public void setName(int i, javax.xml.soap.SOAPElement value) {
        this.name[i] = value;
    }

    public javax.xml.soap.SOAPElement getDirections() {
        return directions;
    }

    public void setDirections(javax.xml.soap.SOAPElement directions) {
        this.directions = directions;
    }

    public javax.xml.soap.SOAPElement getCoordinate() {
        return coordinate;
    }

    public void setCoordinate(javax.xml.soap.SOAPElement coordinate) {
        this.coordinate = coordinate;
    }

    public javax.xml.soap.SOAPElement[] getAddress() {
        return address;
    }

    public void setAddress(javax.xml.soap.SOAPElement[] address) {
        this.address = address;
    }

    public javax.xml.soap.SOAPElement getAddress(int i) {
        return this.address[i];
    }

    public void setAddress(int i, javax.xml.soap.SOAPElement value) {
        this.address[i] = value;
    }

}
