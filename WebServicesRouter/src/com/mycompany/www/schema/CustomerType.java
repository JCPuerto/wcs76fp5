/**
 * CustomerType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class CustomerType  {
    private java.lang.String displayName;
    private java.lang.String parentOrganization;
    private java.lang.String profileType;
    private java.lang.String preferredCurrency;
    private java.lang.Integer store;
    private java.lang.Integer preferredLanguage;
    private com.mycompany.www.schema.AuthenticationType authentication;
    private com.mycompany.www.schema.ContactType contact;
    private com.mycompany.www.schema.CustomerDemographicsType demographics;

    public CustomerType() {
    }

    public java.lang.String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(java.lang.String displayName) {
        this.displayName = displayName;
    }

    public java.lang.String getParentOrganization() {
        return parentOrganization;
    }

    public void setParentOrganization(java.lang.String parentOrganization) {
        this.parentOrganization = parentOrganization;
    }

    public java.lang.String getProfileType() {
        return profileType;
    }

    public void setProfileType(java.lang.String profileType) {
        this.profileType = profileType;
    }

    public java.lang.String getPreferredCurrency() {
        return preferredCurrency;
    }

    public void setPreferredCurrency(java.lang.String preferredCurrency) {
        this.preferredCurrency = preferredCurrency;
    }

    public java.lang.Integer getStore() {
        return store;
    }

    public void setStore(java.lang.Integer store) {
        this.store = store;
    }

    public java.lang.Integer getPreferredLanguage() {
        return preferredLanguage;
    }

    public void setPreferredLanguage(java.lang.Integer preferredLanguage) {
        this.preferredLanguage = preferredLanguage;
    }

    public com.mycompany.www.schema.AuthenticationType getAuthentication() {
        return authentication;
    }

    public void setAuthentication(com.mycompany.www.schema.AuthenticationType authentication) {
        this.authentication = authentication;
    }

    public com.mycompany.www.schema.ContactType getContact() {
        return contact;
    }

    public void setContact(com.mycompany.www.schema.ContactType contact) {
        this.contact = contact;
    }

    public com.mycompany.www.schema.CustomerDemographicsType getDemographics() {
        return demographics;
    }

    public void setDemographics(com.mycompany.www.schema.CustomerDemographicsType demographics) {
        this.demographics = demographics;
    }

}
