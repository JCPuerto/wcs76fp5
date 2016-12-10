package com.ibm.commerce.sample.commands;
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


/// Import section 1 ///////////////////////////////////////
import com.ibm.commerce.user.objects.UserRegistryAccessBean;
///  End of Import section 1 ///////////////////////////////



/*
/// Import section 2 //////////////////////////////////////
import com.ibm.commerce.extension.objects.BonusAccessBean;
///  End of Import section 2 ///////////////////////////////
*/

import com.ibm.commerce.exception.ECException;
import com.ibm.commerce.exception.ECSystemException;
import com.ibm.commerce.ras.ECMessage;



public class MyNewTaskCmdImpl extends com.ibm.commerce.command.TaskCommandImpl implements MyNewTaskCmd {

	private static final String COPYRIGHT = com.ibm.commerce.copyright.IBMCopyright.SHORT_COPYRIGHT;

/// implement command's input fields and methods defined in interface


//// Section 1A //////////////////////////////////////////////

	private String inputUserName;
	private String greetings;
	private Integer inputPoints;

////End of Section 1A /////////////////////////////////////////


//// Section 2A //////////////////////////////////////////////

	private String foundUserId = null;

	private UserRegistryAccessBean rrb = null;

////End of Section 2A /////////////////////////////////////////


/*
//// Section 3A //////////////////////////////////////////////

	private java.lang.Integer oldBonusPoints;
	private java.lang.Integer totalBonusPoints;


	private BonusAccessBean bb = null;

////End of Section 3A /////////////////////////////////////////
*/


//// Section 1B //////////////////////////////////////////////

	public void setInputUserName(String newInputUserName) {
		inputUserName = newInputUserName;
	}

	public void setInputPoints(Integer newInputPoints) {
		inputPoints = newInputPoints;
	}

	public void setGreetings(String newGreetings) {
		greetings = newGreetings;
	}

	public String getInputUserName() {
		return inputUserName;
	}

	public Integer getInputPoints() {
		return inputPoints;
	}

	public String getGreetings() {
		return greetings;
	}


////End of Section 1B /////////////////////////////////////////


//// Section 2B //////////////////////////////////////////////

	public void setUserRegistryAccessBean(UserRegistryAccessBean newRRB) {
		rrb = newRRB;
	}

	public void setFoundUserId(String newFoundUserId) {
		foundUserId = newFoundUserId;
	}

	public String getFoundUserId() {
		return foundUserId;
	}


/// End of section 2B ///////////////////////////////////////////


/*
//// Section 3B //////////////////////////////////////////////

	public void setBonusAccessBean(BonusAccessBean newBB) {
		bb = newBB;
	}

	public BonusAccessBean getBonusAccessBean(){
		return bb;
	}

    public java.lang.Integer getOldBonusPoints() {
		return oldBonusPoints;
	}

	public Integer getTotalBonusPoints(){
		return totalBonusPoints;
	}


/// End of section 3B ///////////////////////////////////////////
*/

/**
 * This constructor does nothing but call the superclass constructor.
 */
public MyNewTaskCmdImpl() {
	super();
}



/**
 * Adds the greeting to the NVP list and adds the new bonus points to the existing bonus points.
 *
 */
public void performExecute() throws ECException {

	super.performExecute();

/// Section 1 ////////////////////////////////////////////////

    /// modify the greetings and see it in the NVP list

	setGreetings( "Hello " + getInputUserName() );

/// End of section 1 ////////////////////////////////////////////


/*
/// Section 2 ///////////////////////////////////////////////////
/// use BonusAccessBean to update new bonus point

	int newBP =  oldBonusPoints.intValue() + getInputPoints().intValue();
	totalBonusPoints = new Integer (newBP);
	bb.setBonusPoint(totalBonusPoints)   ;

	try {
	 	bb.commitCopyHelper();
	} catch (javax.ejb.FinderException e) {
		throw new ECSystemException(ECMessage._ERR_FINDER_EXCEPTION,
	                                 this.getClass().getName(), "performExecute");
	} catch (javax.naming.NamingException e) {
		throw new ECSystemException(ECMessage._ERR_NAMING_EXCEPTION,
	                                 this.getClass().getName(), "performExecute");
	} catch (java.rmi.RemoteException e) {
		throw new ECSystemException(ECMessage._ERR_REMOTE_EXCEPTION,
	                                 this.getClass().getName(), "performExecute");
	} catch (javax.ejb.CreateException e) {
		throw new ECSystemException(ECMessage._ERR_CREATE_EXCEPTION,
	                                 this.getClass().getName(), "performExecute");
	}

/// End of section 2 ////////////////////////////////////////////
*/

}


/**
 *
 * ControllerCommandImpl calls validateParameters in performExecute.
 * It is the responsibility of the command writer to implement
 * this method if they want to perform server side parameter checking.
 * They should either call validateParameters inside their performExecute
 * or calls super.performExecute() as the first statement in the
 * performExecute method.
 *
 *
 * @exception ECException CommandException.
 */

public void validateParameters() throws ECException {


// section 1 ///////////////////////////////////////////////////
// use UserRegistryAccessBean to check user Id

 	try {

 		if (rrb!=null){
	 	  setFoundUserId(rrb.getUserId());
 		} else {
 		  rrb = new UserRegistryAccessBean();
 		  rrb = rrb.findByUserLogonId(getInputUserName());
	 	  setFoundUserId(rrb.getUserId());
 		}

 	} catch (javax.ejb.FinderException e) {
	 		return;

 	} catch (java.rmi.RemoteException e) {
	 	throw new ECSystemException(ECMessage._ERR_REMOTE_EXCEPTION,
		 	this.getClass().getName(), "validateParameters");
 	} catch (javax.naming.NamingException e) {
	 	throw new ECSystemException(ECMessage._ERR_NAMING_EXCEPTION,
		 	this.getClass().getName(), "validateParameters");
 	} catch (javax.ejb.CreateException e) {
	 	throw new ECSystemException(ECMessage._ERR_CREATE_EXCEPTION,
		 	this.getClass().getName(), "validateParameters");
 	}

// end of section 1 ///////////////////////////////////////////////


/*
// section 2 /////////////////////////////////////////////////////
// check if bonus bean instance variable bb == null


 	try {
		 	oldBonusPoints = bb.getBonusPoint();
 	} catch (javax.ejb.FinderException e) {
		try {
			// If bb is null, create a new instance
		 	bb = new BonusAccessBean(new Long(foundUserId), new Integer(0));
		 	oldBonusPoints = new Integer(0);
	 	} catch (javax.ejb.CreateException ec) {
		 	throw new ECSystemException(ECMessage._ERR_CREATE_EXCEPTION,
			 	this.getClass().getName(), "validateParameters");
	 	} catch (javax.naming.NamingException ec) {
		 	throw new ECSystemException(ECMessage._ERR_NAMING_EXCEPTION,
			 	this.getClass().getName(), "validateParameters");
	 	} catch (java.rmi.RemoteException ec) {
		 	throw new ECSystemException(ECMessage._ERR_REMOTE_EXCEPTION,
			 	this.getClass().getName(), "validateParameters");
	 	}
 	} catch (javax.naming.NamingException e) {
	 	throw new ECSystemException(ECMessage._ERR_NAMING_EXCEPTION,
		 	this.getClass().getName(), "validateParameters");
 	} catch (java.rmi.RemoteException e) {
	 	throw new ECSystemException(ECMessage._ERR_REMOTE_EXCEPTION,
		 	this.getClass().getName(), "validateParameters");
 	} catch (javax.ejb.CreateException e) {
	 	throw new ECSystemException(ECMessage._ERR_CREATE_EXCEPTION,
		 	this.getClass().getName(), "validateParameters");
 	}

// end of section 2 ///////////////////////////////////////////////
*/

 }

}

