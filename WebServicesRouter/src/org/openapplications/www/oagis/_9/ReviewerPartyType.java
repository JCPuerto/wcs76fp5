/**
 * ReviewerPartyType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ReviewerPartyType  extends org.openapplications.www.oagis._9.PartyBaseType  {
    private org.openapplications.www.oagis._9.SemanticContactType[] reviewerContact;
    private javax.xml.soap.SOAPElement[] userArea;

    public ReviewerPartyType() {
    }

    public org.openapplications.www.oagis._9.SemanticContactType[] getReviewerContact() {
        return reviewerContact;
    }

    public void setReviewerContact(org.openapplications.www.oagis._9.SemanticContactType[] reviewerContact) {
        this.reviewerContact = reviewerContact;
    }

    public org.openapplications.www.oagis._9.SemanticContactType getReviewerContact(int i) {
        return this.reviewerContact[i];
    }

    public void setReviewerContact(int i, org.openapplications.www.oagis._9.SemanticContactType value) {
        this.reviewerContact[i] = value;
    }

    public javax.xml.soap.SOAPElement[] getUserArea() {
        return userArea;
    }

    public void setUserArea(javax.xml.soap.SOAPElement[] userArea) {
        this.userArea = userArea;
    }

}
