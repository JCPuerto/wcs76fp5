/**
 * FinancialPartyType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class FinancialPartyType  extends org.openapplications.www.oagis._9.PartyBaseType  {
    private javax.xml.soap.SOAPElement clearingSystemMemberID;
    private org.openapplications.www.oagis._9.SemanticPartyType branchParty;
    private javax.xml.soap.SOAPElement[] financialAccount;
    private javax.xml.soap.SOAPElement countryCode;
    private javax.xml.soap.SOAPElement[] userArea;

    public FinancialPartyType() {
    }

    public javax.xml.soap.SOAPElement getClearingSystemMemberID() {
        return clearingSystemMemberID;
    }

    public void setClearingSystemMemberID(javax.xml.soap.SOAPElement clearingSystemMemberID) {
        this.clearingSystemMemberID = clearingSystemMemberID;
    }

    public org.openapplications.www.oagis._9.SemanticPartyType getBranchParty() {
        return branchParty;
    }

    public void setBranchParty(org.openapplications.www.oagis._9.SemanticPartyType branchParty) {
        this.branchParty = branchParty;
    }

    public javax.xml.soap.SOAPElement[] getFinancialAccount() {
        return financialAccount;
    }

    public void setFinancialAccount(javax.xml.soap.SOAPElement[] financialAccount) {
        this.financialAccount = financialAccount;
    }

    public javax.xml.soap.SOAPElement getFinancialAccount(int i) {
        return this.financialAccount[i];
    }

    public void setFinancialAccount(int i, javax.xml.soap.SOAPElement value) {
        this.financialAccount[i] = value;
    }

    public javax.xml.soap.SOAPElement getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(javax.xml.soap.SOAPElement countryCode) {
        this.countryCode = countryCode;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
