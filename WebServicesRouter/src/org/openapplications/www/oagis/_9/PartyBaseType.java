/**
 * PartyBaseType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public abstract class PartyBaseType  {
    private javax.xml.soap.SOAPElement category;  // attribute
    private javax.xml.soap.SOAPElement partyIDs;
    private javax.xml.soap.SOAPElement[] name;
    private javax.xml.soap.SOAPElement[] location;
    private org.openapplications.www.oagis._9.ContactType[] contact;

    public PartyBaseType() {
    }

    public javax.xml.soap.SOAPElement getCategory() {
        return category;
    }

    public void setCategory(javax.xml.soap.SOAPElement category) {
        this.category = category;
    }

    public javax.xml.soap.SOAPElement getPartyIDs() {
        return partyIDs;
    }

    public void setPartyIDs(javax.xml.soap.SOAPElement partyIDs) {
        this.partyIDs = partyIDs;
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

    public javax.xml.soap.SOAPElement[] getLocation() {
        return location;
    }

    public void setLocation(javax.xml.soap.SOAPElement[] location) {
        this.location = location;
    }

    public javax.xml.soap.SOAPElement getLocation(int i) {
        return this.location[i];
    }

    public void setLocation(int i, javax.xml.soap.SOAPElement value) {
        this.location[i] = value;
    }

    public org.openapplications.www.oagis._9.ContactType[] getContact() {
        return contact;
    }

    public void setContact(org.openapplications.www.oagis._9.ContactType[] contact) {
        this.contact = contact;
    }

    public org.openapplications.www.oagis._9.ContactType getContact(int i) {
        return this.contact[i];
    }

    public void setContact(int i, org.openapplications.www.oagis._9.ContactType value) {
        this.contact[i] = value;
    }

}
