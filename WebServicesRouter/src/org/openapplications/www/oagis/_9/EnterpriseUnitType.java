/**
 * EnterpriseUnitType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class EnterpriseUnitType  {
    private javax.xml.soap.SOAPElement costCenterID;
    private javax.xml.soap.SOAPElement profitCenterID;
    private javax.xml.soap.SOAPElement[] GLEntityID;
    private org.openapplications.www.oagis._9.GLElementType GLElement;
    private javax.xml.soap.SOAPElement[] userArea;

    public EnterpriseUnitType() {
    }

    public javax.xml.soap.SOAPElement getCostCenterID() {
        return costCenterID;
    }

    public void setCostCenterID(javax.xml.soap.SOAPElement costCenterID) {
        this.costCenterID = costCenterID;
    }

    public javax.xml.soap.SOAPElement getProfitCenterID() {
        return profitCenterID;
    }

    public void setProfitCenterID(javax.xml.soap.SOAPElement profitCenterID) {
        this.profitCenterID = profitCenterID;
    }

    public javax.xml.soap.SOAPElement[] getGLEntityID() {
        return GLEntityID;
    }

    public void setGLEntityID(javax.xml.soap.SOAPElement[] GLEntityID) {
        this.GLEntityID = GLEntityID;
    }

    public javax.xml.soap.SOAPElement getGLEntityID(int i) {
        return this.GLEntityID[i];
    }

    public void setGLEntityID(int i, javax.xml.soap.SOAPElement value) {
        this.GLEntityID[i] = value;
    }

    public org.openapplications.www.oagis._9.GLElementType getGLElement() {
        return GLElement;
    }

    public void setGLElement(org.openapplications.www.oagis._9.GLElementType GLElement) {
        this.GLElement = GLElement;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
