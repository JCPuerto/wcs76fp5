/**
 * ContactABIEType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public abstract class ContactABIEType  {
    private javax.xml.soap.SOAPElement[] ID;
    private javax.xml.soap.SOAPElement name;
    private javax.xml.soap.SOAPElement jobTitle;
    private javax.xml.soap.SOAPElement[] responsibility;
    private javax.xml.soap.SOAPElement departmentName;
    private javax.xml.soap.SOAPElement[] communication;
    private org.openapplications.www.oagis._9.PreferenceType preference;

    public ContactABIEType() {
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

    public javax.xml.soap.SOAPElement getName() {
        return name;
    }

    public void setName(javax.xml.soap.SOAPElement name) {
        this.name = name;
    }

    public javax.xml.soap.SOAPElement getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(javax.xml.soap.SOAPElement jobTitle) {
        this.jobTitle = jobTitle;
    }

    public javax.xml.soap.SOAPElement[] getResponsibility() {
        return responsibility;
    }

    public void setResponsibility(javax.xml.soap.SOAPElement[] responsibility) {
        this.responsibility = responsibility;
    }

    public javax.xml.soap.SOAPElement getResponsibility(int i) {
        return this.responsibility[i];
    }

    public void setResponsibility(int i, javax.xml.soap.SOAPElement value) {
        this.responsibility[i] = value;
    }

    public javax.xml.soap.SOAPElement getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(javax.xml.soap.SOAPElement departmentName) {
        this.departmentName = departmentName;
    }

    public javax.xml.soap.SOAPElement[] getCommunication() {
        return communication;
    }

    public void setCommunication(javax.xml.soap.SOAPElement[] communication) {
        this.communication = communication;
    }

    public javax.xml.soap.SOAPElement getCommunication(int i) {
        return this.communication[i];
    }

    public void setCommunication(int i, javax.xml.soap.SOAPElement value) {
        this.communication[i] = value;
    }

    public org.openapplications.www.oagis._9.PreferenceType getPreference() {
        return preference;
    }

    public void setPreference(org.openapplications.www.oagis._9.PreferenceType preference) {
        this.preference = preference;
    }

}
