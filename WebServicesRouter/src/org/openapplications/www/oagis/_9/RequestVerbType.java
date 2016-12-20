/**
 * RequestVerbType.java
 *
 * This file was auto-generated from WSDL
 * by the IBM Web services WSDL2Java emitter.
 * cf231216.04 v42612222534
 */

package org.openapplications.www.oagis._9;

public abstract class RequestVerbType  extends org.openapplications.www.oagis._9.VerbType  {
    private org.openapplications.www.oagis._9.ExpressionType[] expression;

    public RequestVerbType() {
    }

    public org.openapplications.www.oagis._9.ExpressionType[] getExpression() {
        return expression;
    }

    public void setExpression(org.openapplications.www.oagis._9.ExpressionType[] expression) {
        this.expression = expression;
    }

    public org.openapplications.www.oagis._9.ExpressionType getExpression(int i) {
        return this.expression[i];
    }

    public void setExpression(int i, org.openapplications.www.oagis._9.ExpressionType value) {
        this.expression[i] = value;
    }

}
