package com.ibm.commerce.sample.databeans;

//*
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright International Business Machines Corporation. 2001, 2003, 2005
//*     All rights reserved.
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been  
//* thoroughly tested under all conditions.  IBM, therefore, cannot guarantee its 
//* reliability, serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands 
//* and products in order to illustrate concepts as completely as 
//* possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by 
//* actual persons or business enterprises is entirely coincidental.
//*---------------------------------------------------------------------

import com.ibm.commerce.beans.SmartDataBean;
import com.ibm.commerce.beans.SmartDataBeanImpl;
 /*
* This bean is used by the WebSphere Commerce programming tutorials. For information about this bean, see
* your WebSphere Commerce information center. 
*/

public class MyNewDataBean extends SmartDataBeanImpl implements SmartDataBean {

	public static final String COPYRIGHT = com.ibm.commerce.copyright.IBMCopyright.SHORT_COPYRIGHT;

	 
	

/*	
/// Section 1 /////////////////////////////////////////////
// create fields and accessors (setter/getter methods) 
	
	private java.lang.String callingCommandName = null;
	private boolean calledByControllerCmd = false;

	
	public java.lang.String getCallingCommandName() {
		return callingCommandName;
	}
	
	public void setCallingCommandName(java.lang.String newCallingCommandName) {
		callingCommandName = newCallingCommandName;
	}
	
	public boolean getCalledByControllerCmd() {
		return calledByControllerCmd;
	}
	
	public void setCalledByControllerCmd(boolean newCalledByControllerCmd) {
		calledByControllerCmd = newCalledByControllerCmd;
	}
	
/// End of Section 1 ////////////////////////////////////
*/

/*
/// Section 2 ///////////////////////////////////////////

	private java.lang.String userName = null;
	private java.lang.Integer points;
	
	
	public String getUserName() {
		return userName;
	}
	
	public void setUserName(java.lang.String newUserName) {
		userName = newUserName;
	}
	
	
	public Integer getPoints() {
		return points;
	}
	
	public void setPoints(java.lang.Integer newPoints) {
		points = newPoints;
	}
	
	
/// End of Section 2 ////////////////////////////////////
*/

/**
 * Constructor for an ErrorDataBean.
 *
 */
public MyNewDataBean() {
	super();
}

/*
 * Populate the databean. The bean properties will be populated
 * from the requestProperties associated with the bean.
 * 
 */
public void populate() throws com.ibm.commerce.exception.ECException {
	
}

}
