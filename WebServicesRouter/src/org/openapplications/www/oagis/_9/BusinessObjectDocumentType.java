/**
 * BusinessObjectDocumentType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class BusinessObjectDocumentType  {
    private java.lang.String releaseID;  // attribute
    private java.lang.String versionID;  // attribute
    private javax.xml.soap.SOAPElement systemEnvironmentCode;  // attribute
    private javax.xml.soap.SOAPElement languageCode;  // attribute
    private org.openapplications.www.oagis._9.ApplicationAreaType applicationArea;

    public BusinessObjectDocumentType() {
    }

    public java.lang.String getReleaseID() {
        return releaseID;
    }

    public void setReleaseID(java.lang.String releaseID) {
        this.releaseID = releaseID;
    }

    public java.lang.String getVersionID() {
        return versionID;
    }

    public void setVersionID(java.lang.String versionID) {
        this.versionID = versionID;
    }

    public javax.xml.soap.SOAPElement getSystemEnvironmentCode() {
        return systemEnvironmentCode;
    }

    public void setSystemEnvironmentCode(javax.xml.soap.SOAPElement systemEnvironmentCode) {
        this.systemEnvironmentCode = systemEnvironmentCode;
    }

    public javax.xml.soap.SOAPElement getLanguageCode() {
        return languageCode;
    }

    public void setLanguageCode(javax.xml.soap.SOAPElement languageCode) {
        this.languageCode = languageCode;
    }

    public org.openapplications.www.oagis._9.ApplicationAreaType getApplicationArea() {
        return applicationArea;
    }

    public void setApplicationArea(org.openapplications.www.oagis._9.ApplicationAreaType applicationArea) {
        this.applicationArea = applicationArea;
    }

}
