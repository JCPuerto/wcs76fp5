/**
 * RecurrenceType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class RecurrenceType  {
    private javax.xml.soap.SOAPElement pattern;  // attribute
    private javax.xml.soap.SOAPElement occursEveryQuantity;
    private java.lang.Boolean everyDayIndicator;
    private java.math.BigDecimal frequency;
    private javax.xml.soap.SOAPElement[] dayOfWeek;
    private javax.xml.soap.SOAPElement ofEveryQuantity;

    public RecurrenceType() {
    }

    public javax.xml.soap.SOAPElement getPattern() {
        return pattern;
    }

    public void setPattern(javax.xml.soap.SOAPElement pattern) {
        this.pattern = pattern;
    }

    public javax.xml.soap.SOAPElement getOccursEveryQuantity() {
        return occursEveryQuantity;
    }

    public void setOccursEveryQuantity(javax.xml.soap.SOAPElement occursEveryQuantity) {
        this.occursEveryQuantity = occursEveryQuantity;
    }

    public java.lang.Boolean getEveryDayIndicator() {
        return everyDayIndicator;
    }

    public void setEveryDayIndicator(java.lang.Boolean everyDayIndicator) {
        this.everyDayIndicator = everyDayIndicator;
    }

    public java.math.BigDecimal getFrequency() {
        return frequency;
    }

    public void setFrequency(java.math.BigDecimal frequency) {
        this.frequency = frequency;
    }

    public javax.xml.soap.SOAPElement[] getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(javax.xml.soap.SOAPElement[] dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public javax.xml.soap.SOAPElement getDayOfWeek(int i) {
        return this.dayOfWeek[i];
    }

    public void setDayOfWeek(int i, javax.xml.soap.SOAPElement value) {
        this.dayOfWeek[i] = value;
    }

    public javax.xml.soap.SOAPElement getOfEveryQuantity() {
        return ofEveryQuantity;
    }

    public void setOfEveryQuantity(javax.xml.soap.SOAPElement ofEveryQuantity) {
        this.ofEveryQuantity = ofEveryQuantity;
    }

}
