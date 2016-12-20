/**
 * HazardousMaterialABIEType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class HazardousMaterialABIEType  {
    private javax.xml.soap.SOAPElement ID;
    private javax.xml.soap.SOAPElement MFAGID;
    private javax.xml.soap.SOAPElement technicalName;
    private javax.xml.soap.SOAPElement placardEndorsement;
    private javax.xml.soap.SOAPElement placardNotation;
    private javax.xml.soap.SOAPElement marinePollutionLevelCode;
    private javax.xml.soap.SOAPElement toxicityZoneCode;
    private javax.xml.soap.SOAPElement[] temperature;
    private javax.xml.soap.SOAPElement flashpointTemperature;
    private javax.xml.soap.SOAPElement primaryEntryRoute;
    private javax.xml.soap.SOAPElement[] description;
    private org.openapplications.www.oagis._9.ContactType emergencyContact;

    public HazardousMaterialABIEType() {
    }

    public javax.xml.soap.SOAPElement getID() {
        return ID;
    }

    public void setID(javax.xml.soap.SOAPElement ID) {
        this.ID = ID;
    }

    public javax.xml.soap.SOAPElement getMFAGID() {
        return MFAGID;
    }

    public void setMFAGID(javax.xml.soap.SOAPElement MFAGID) {
        this.MFAGID = MFAGID;
    }

    public javax.xml.soap.SOAPElement getTechnicalName() {
        return technicalName;
    }

    public void setTechnicalName(javax.xml.soap.SOAPElement technicalName) {
        this.technicalName = technicalName;
    }

    public javax.xml.soap.SOAPElement getPlacardEndorsement() {
        return placardEndorsement;
    }

    public void setPlacardEndorsement(javax.xml.soap.SOAPElement placardEndorsement) {
        this.placardEndorsement = placardEndorsement;
    }

    public javax.xml.soap.SOAPElement getPlacardNotation() {
        return placardNotation;
    }

    public void setPlacardNotation(javax.xml.soap.SOAPElement placardNotation) {
        this.placardNotation = placardNotation;
    }

    public javax.xml.soap.SOAPElement getMarinePollutionLevelCode() {
        return marinePollutionLevelCode;
    }

    public void setMarinePollutionLevelCode(javax.xml.soap.SOAPElement marinePollutionLevelCode) {
        this.marinePollutionLevelCode = marinePollutionLevelCode;
    }

    public javax.xml.soap.SOAPElement getToxicityZoneCode() {
        return toxicityZoneCode;
    }

    public void setToxicityZoneCode(javax.xml.soap.SOAPElement toxicityZoneCode) {
        this.toxicityZoneCode = toxicityZoneCode;
    }

    public javax.xml.soap.SOAPElement[] getTemperature() {
        return temperature;
    }

    public void setTemperature(javax.xml.soap.SOAPElement[] temperature) {
        this.temperature = temperature;
    }

    public javax.xml.soap.SOAPElement getTemperature(int i) {
        return this.temperature[i];
    }

    public void setTemperature(int i, javax.xml.soap.SOAPElement value) {
        this.temperature[i] = value;
    }

    public javax.xml.soap.SOAPElement getFlashpointTemperature() {
        return flashpointTemperature;
    }

    public void setFlashpointTemperature(javax.xml.soap.SOAPElement flashpointTemperature) {
        this.flashpointTemperature = flashpointTemperature;
    }

    public javax.xml.soap.SOAPElement getPrimaryEntryRoute() {
        return primaryEntryRoute;
    }

    public void setPrimaryEntryRoute(javax.xml.soap.SOAPElement primaryEntryRoute) {
        this.primaryEntryRoute = primaryEntryRoute;
    }

    public javax.xml.soap.SOAPElement[] getDescription() {
        return description;
    }

    public void setDescription(javax.xml.soap.SOAPElement[] description) {
        this.description = description;
    }

    public javax.xml.soap.SOAPElement getDescription(int i) {
        return this.description[i];
    }

    public void setDescription(int i, javax.xml.soap.SOAPElement value) {
        this.description[i] = value;
    }

    public org.openapplications.www.oagis._9.ContactType getEmergencyContact() {
        return emergencyContact;
    }

    public void setEmergencyContact(org.openapplications.www.oagis._9.ContactType emergencyContact) {
        this.emergencyContact = emergencyContact;
    }

}
