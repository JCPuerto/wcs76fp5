/**
 * ShowType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public class ShowType  extends org.openapplications.www.oagis._9.ResponseVerbType  {
    private java.math.BigInteger recordSetStartNumber;  // attribute
    private java.math.BigInteger recordSetCount;  // attribute
    private java.math.BigInteger recordSetTotal;  // attribute
    private java.lang.Boolean recordSetCompleteIndicator;  // attribute
    private java.lang.String recordSetReferenceId;  // attribute

    public ShowType() {
    }

    public java.math.BigInteger getRecordSetStartNumber() {
        return recordSetStartNumber;
    }

    public void setRecordSetStartNumber(java.math.BigInteger recordSetStartNumber) {
        this.recordSetStartNumber = recordSetStartNumber;
    }

    public java.math.BigInteger getRecordSetCount() {
        return recordSetCount;
    }

    public void setRecordSetCount(java.math.BigInteger recordSetCount) {
        this.recordSetCount = recordSetCount;
    }

    public java.math.BigInteger getRecordSetTotal() {
        return recordSetTotal;
    }

    public void setRecordSetTotal(java.math.BigInteger recordSetTotal) {
        this.recordSetTotal = recordSetTotal;
    }

    public java.lang.Boolean getRecordSetCompleteIndicator() {
        return recordSetCompleteIndicator;
    }

    public void setRecordSetCompleteIndicator(java.lang.Boolean recordSetCompleteIndicator) {
        this.recordSetCompleteIndicator = recordSetCompleteIndicator;
    }

    public java.lang.String getRecordSetReferenceId() {
        return recordSetReferenceId;
    }

    public void setRecordSetReferenceId(java.lang.String recordSetReferenceId) {
        this.recordSetReferenceId = recordSetReferenceId;
    }

}
