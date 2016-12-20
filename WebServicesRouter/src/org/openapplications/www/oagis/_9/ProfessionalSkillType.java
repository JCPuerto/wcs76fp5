/**
 * ProfessionalSkillType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ProfessionalSkillType  {
    private javax.xml.soap.SOAPElement code;
    private javax.xml.soap.SOAPElement[] name;
    private javax.xml.soap.SOAPElement competencyCode;
    private javax.xml.soap.SOAPElement lastUsedDateTime;
    private javax.xml.soap.SOAPElement[] trainingDateTime;
    private javax.xml.soap.SOAPElement effectiveTimePeriod;
    private javax.xml.soap.SOAPElement[] userArea;

    public ProfessionalSkillType() {
    }

    public javax.xml.soap.SOAPElement getCode() {
        return code;
    }

    public void setCode(javax.xml.soap.SOAPElement code) {
        this.code = code;
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

    public javax.xml.soap.SOAPElement getCompetencyCode() {
        return competencyCode;
    }

    public void setCompetencyCode(javax.xml.soap.SOAPElement competencyCode) {
        this.competencyCode = competencyCode;
    }

    public javax.xml.soap.SOAPElement getLastUsedDateTime() {
        return lastUsedDateTime;
    }

    public void setLastUsedDateTime(javax.xml.soap.SOAPElement lastUsedDateTime) {
        this.lastUsedDateTime = lastUsedDateTime;
    }

    public javax.xml.soap.SOAPElement[] getTrainingDateTime() {
        return trainingDateTime;
    }

    public void setTrainingDateTime(javax.xml.soap.SOAPElement[] trainingDateTime) {
        this.trainingDateTime = trainingDateTime;
    }

    public javax.xml.soap.SOAPElement getTrainingDateTime(int i) {
        return this.trainingDateTime[i];
    }

    public void setTrainingDateTime(int i, javax.xml.soap.SOAPElement value) {
        this.trainingDateTime[i] = value;
    }

    public javax.xml.soap.SOAPElement getEffectiveTimePeriod() {
        return effectiveTimePeriod;
    }

    public void setEffectiveTimePeriod(javax.xml.soap.SOAPElement effectiveTimePeriod) {
        this.effectiveTimePeriod = effectiveTimePeriod;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
