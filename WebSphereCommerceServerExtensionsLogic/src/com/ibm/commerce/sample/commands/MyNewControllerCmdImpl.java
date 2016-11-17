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


/// Import Section 1 ///////////////////////////////

import com.ibm.commerce.sample.databeans.MyNewDataBean;
/// End of Import Section 1 ////////////////////////



/*
/// Import Section 2 ///////////////////////////////
import com.ibm.commerce.extension.objects.BonusAccessBean;
import com.ibm.commerce.sample.databeans.BonusDataBean;
/// End of Import Section 2 ////////////////////////
*/


import com.ibm.commerce.datatype.TypedProperty;
import com.ibm.commerce.user.objects.UserRegistryAccessBean;
import com.ibm.commerce.user.objects.UserAccessBean;
import com.ibm.commerce.exception.ECApplicationException;
import com.ibm.commerce.exception.ECException;
import com.ibm.commerce.exception.ECSystemException;
import com.ibm.commerce.exception.ParameterNotFoundException;
import com.ibm.commerce.ras.ECMessage;
import com.ibm.commerce.ras.ECMessageHelper;
import com.ibm.commerce.server.ECConstants;
import com.ibm.commerce.command.CommandFactory;
import com.ibm.commerce.command.ControllerCommandImpl;
import com.ibm.commerce.accesscontrol.AccessVector;


public class MyNewControllerCmdImpl extends ControllerCommandImpl implements MyNewControllerCmd {

	private static final String COPYRIGHT = com.ibm.commerce.copyright.IBMCopyright.SHORT_COPYRIGHT;

/*
/// Section 1 ////////////////////////////////////////////////
/// create and implement controller command's fields and accessors (setter/getter methods)

	private java.lang.String userName = null;
	private java.lang.Integer points;


	public java.lang.Integer getPoints() {
		return points;
	}

	public java.lang.String getUserName() {
		return userName;
	}

	public void setPoints(java.lang.Integer newPoints) {
		points = newPoints;
	}

	public void setUserName(java.lang.String newUserName) {
		userName = newUserName;
	}

/// End of Section 1 /////////////////////////////////////////
*/


/*
/// Section 2 ////////////////////////////////////////////////
/// create a user registry accessbean resource instance variable

    private UserRegistryAccessBean rrb = null;

/// End of Section 2 /////////////////////////////////////////
*/


/*
/// Section 3 ////////////////////////////////////////////////
/// Create an instance variable of type AccessVector to hold the resources
/// and a BonusAccessBean instance variable for access control purposes.

    private AccessVector resources = null;
    private BonusAccessBean bb = null;

/// End of Section 3 /////////////////////////////////////////
*/


/*
/// AccessControl Section ////////////////////////////////////

public AccessVector getResources() throws ECException{

 if (resources == null ) {

    /// use UserRegistryAccessBean to check user reference number

	String refNum = null;
	String methodName = "getResources";

 	rrb = new UserRegistryAccessBean();

 	try {
	 	rrb = rrb.findByUserLogonId(getUserName());
	 	refNum = rrb.getUserId();
 	} catch (javax.ejb.FinderException e) {
	 	throw new ECSystemException(ECMessage._ERR_FINDER_EXCEPTION,this.getClass().getName(),methodName,e);
 	} catch (javax.naming.NamingException e) {
	 	throw new ECSystemException(ECMessage._ERR_NAMING_EXCEPTION,this.getClass().getName(), methodName,e);
 	} catch (java.rmi.RemoteException e) {
	 	throw new ECSystemException(ECMessage._ERR_REMOTE_EXCEPTION,this.getClass().getName(), methodName,e);
 	} catch (javax.ejb.CreateException e) {
	 	throw new ECSystemException(ECMessage._ERR_CREATE_EXCEPTION,this.getClass().getName(), methodName,e);
 	}


	/// find the bonus bean for this registered user

    bb = new com.ibm.commerce.extension.objects.BonusAccessBean();

 	try {
	 	if (refNum != null) {
		 	bb.setInitKey_memberId(new Long(refNum));
		 	bb.refreshCopyHelper();
		 	resources = new AccessVector(bb);
	 	}
 	} catch (javax.ejb.FinderException e) {

	 	//We don't have a bonus object so return the container that will hold the 
		//bonus object when it's created
		UserAccessBean uab = new UserAccessBean();
		uab.setInitKey_MemberId(refNum);
		resources = new AccessVector(uab);
		return resources;

 	} catch (javax.naming.NamingException e) {
	 	throw new ECSystemException(ECMessage._ERR_NAMING_EXCEPTION, this.getClass().getName(), methodName);
 	} catch (java.rmi.RemoteException e) {
	 	throw new ECSystemException(ECMessage._ERR_REMOTE_EXCEPTION, this.getClass().getName(), methodName);
 	} catch (javax.ejb.CreateException e) {
	 	throw new ECSystemException(ECMessage._ERR_CREATE_EXCEPTION, this.getClass().getName(), methodName);
 	}

 }
	return resources;
}

/// End of AccessControl Section //////////////////////////////////
*/


/**
 * This constructor calls the superclass constructor.
 */
public MyNewControllerCmdImpl() {
	super();
}



/**
 * The business logic for this controller command. For this default implementation
 * we simply call validateParameters. Command writers who overwrite this method
 * call super() as the first line in their method if they want to call validateParameters.
 *
 * @exception com.ibm.commerce.exception.ECException An ECException is thrown in the case of an error .
 */
public void performExecute() throws ECException {

    /// perform server side parameter checking

	super.performExecute();


/// Section 1 ////////////////////////////////////////////////
    /// Create a new TypedProperties for output purposes.

 	TypedProperty rspProp = new TypedProperty();

/// End of section 1 /////////////////////////////////////////



/// Section 2 ////////////////////////////////////////////////

    /// The controller command passes variables to the JSP page

	/// add additional parameters in controller command to rspProp for response
    String message1 = "Hello!";

	rspProp.put("controllerParm1", message1);
	rspProp.put("controllerParm2", "Have a nice day!");

/// End of section 2/////////////////////////////////////////




/// Section 3A/////////////////////////////////////////

	/// instantiate the MyNewDataBean databean and set the properties, then add the instance to resProp for response
	MyNewDataBean mndb = new MyNewDataBean();
	mndb.setCallingCommandName(this.getClass().getName());
	mndb.setCalledByControllerCmd(true);

/// end of section 3A/////////////////////////////////////////


/*
/// Section 3C/////////////////////////////////////////

	// pass the input information to the databean
	mndb.setUserName(this.getUserName());
	mndb.setPoints(this.getPoints());

/// end of section 3C/////////////////////////////////////////
*/

/// Section 3B/////////////////////////////////////////
	rspProp.put("mndbInstance", mndb);

/// end of section 3B/////////////////////////////////////////




/// Area 4 ////////////////////////////////////////////////
/*
/// Section 4A
    /// The controller command calls a task command

	MyNewTaskCmd cmd = null;

	try {

		cmd = (MyNewTaskCmd) CommandFactory.createCommand("com.ibm.commerce.sample.commands.MyNewTaskCmd", getStoreId());

        // this is required for all commands
        cmd.setCommandContext(getCommandContext());

		/// set input parameters to task command
		cmd.setInputUserName(getUserName());
		cmd.setInputPoints(getPoints()); // change to Integer

/// End Section 4A ///////////////////////////////////////
*/
		/*
		// Section 4D ////////////////////////////////////
		/// pass rrb instance variable to the task command

		cmd.setUserRegistryAccessBean(rrb);

		// End of section 4D /////////////////////////////
		*/


		/*
		// Section 4E ////////////////////////////////////
		/// pass bb instance variable to the task command
		cmd.setBonusAccessBean(bb);
		// End of section 4E /////////////////////////////
		*/
/*
/// Section 4B ///////////////////////////////////

		/// invoke the command's performExecute method
		cmd.execute();

		/// retrieve output parameter from task command, then put it to response properties
		rspProp.put("taskOutputGreetings", cmd.getGreetings());

/// End Section 4B /////////////////////////////////////
*/

		/*
		// Section 4F ///////////////////////////////////////
		///using access bean to get information from databse
		if (cmd.getFoundUserId() != null) {
			rspProp.put("taskOutputUserId", cmd.getFoundUserId());
		}
		// End of section 4F /////////////////////////////
		*/


		/*
		// Section 4G ///////////////////////////////////////
		if (cmd.getOldBonusPoints() != null) {
			rspProp.put("oldBonusPoints", cmd.getOldBonusPoints());
		}
		// End of section 4G /////////////////////////////
		*/


		/*
        // Section 4H ///////////////////////////////////////
	    ///Instantiate the bonus databean , then put it into response properties
        BonusDataBean bdb  = new com.ibm.commerce.sample.databeans.BonusDataBean(cmd.getBonusAccessBean());
	    rspProp.put("bdbInstance", bdb );
	    // End of section 4H ////////////////////////////////
		*/

/*
/// Start Section 4C ////////////////////////////////////
	} catch (ECException ex) {
		/// throw the exception as is
		throw (ECException) ex;
	}

/// End Section 4C //////////////////////////////////////
*/

/// End of Area 4///////////////////////////////////////////





/// Section 5 /////////////////////////////////////////////////

    /// see how the controller command calls the JSP

	rspProp.put(ECConstants.EC_VIEWTASKNAME, "MyNewView");
	setResponseProperties(rspProp);

/// End of section 5///////////////////////////////////////////



}

/**
 *
 * ControllerCommandImpl calls validateParameter in performExecute.
 * It is the responsibility of the command writers to implements
 * this method if they want to perform server side parameter checking.
 * They should either calls validateParameters inside their performExecute
 * or calls super.performExecute() as the first statement in the
 * performExecute method.
 *
 *
 * @exception CommandException.
 */

public void validateParameters() throws ECException {

/*
/// Section 1 /////////////////////////////////////////////////
/// uncomment to check parameters

    final String strMethodName = "validateParameters";

	TypedProperty prop = getRequestProperties();

	/// retrieve required parameters
	try {
		setUserName(prop.getString("input1"));

	} catch (ParameterNotFoundException e) {
		/// the next exception uses _ERR_CMD_MISSING_PARAM ECMessage object defined in ECMessage class
		throw new ECApplicationException(ECMessage._ERR_CMD_MISSING_PARAM, this.getClass().getName(), strMethodName,
		ECMessageHelper.generateMsgParms(e.getParamName()));
	}

	/// retrieve optional Integer
	// set input2 = 0 if no input value
	setPoints(prop.getInteger("input2",0));

/// End of section 1//////////////////////////////////////////////////////////
*/
}
}
