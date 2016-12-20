/**
 * ContactType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package com.mycompany.www.schema;

public class ContactType  {
    private java.lang.String firstName;
    private java.lang.String lastName;
    private java.lang.String phoneNumber;
    private java.lang.String faxNumber;
    private java.lang.String email;
    private com.mycompany.www.schema.AddressType address;

    public ContactType() {
    }

    public java.lang.String getFirstName() {
        return firstName;
    }

    public void setFirstName(java.lang.String firstName) {
        this.firstName = firstName;
    }

    public java.lang.String getLastName() {
        return lastName;
    }

    public void setLastName(java.lang.String lastName) {
        this.lastName = lastName;
    }

    public java.lang.String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(java.lang.String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public java.lang.String getFaxNumber() {
        return faxNumber;
    }

    public void setFaxNumber(java.lang.String faxNumber) {
        this.faxNumber = faxNumber;
    }

    public java.lang.String getEmail() {
        return email;
    }

    public void setEmail(java.lang.String email) {
        this.email = email;
    }

    public com.mycompany.www.schema.AddressType getAddress() {
        return address;
    }

    public void setAddress(com.mycompany.www.schema.AddressType address) {
        this.address = address;
    }

}
