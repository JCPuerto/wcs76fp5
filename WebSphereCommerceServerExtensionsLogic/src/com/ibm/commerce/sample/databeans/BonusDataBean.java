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

import javax.ejb.CreateException;

import com.ibm.commerce.beans.SmartDataBean;
import com.ibm.commerce.command.CommandContext;
import com.ibm.commerce.datatype.TypedProperty;
import com.ibm.commerce.exception.ECSystemException;
import com.ibm.commerce.exception.ParameterNotFoundException;
import com.ibm.commerce.extension.objects.BonusAccessBean;
import com.ibm.commerce.ras.ECMessage;

/*
* This bean is used by the WebSphere Commerce programming tutorials. For information about this bean, see
* your WebSphere Commerce information center. 
*/


// Extend the databean to BonusAccessBean

public class BonusDataBean extends BonusAccessBean implements SmartDataBean {


	public static final String COPYRIGHT = com.ibm.commerce.copyright.IBMCopyright.SHORT_COPYRIGHT;
	private CommandContext iCommandContext = null;
	private com.ibm.commerce.datatype.TypedProperty requestProperties;

/// Section 1 ///////////////////////////////////////////////
// create fields and accessors (setter/getter methods)

	private String userId;
	private Integer totalBonusPoints;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String newUserId) {
		userId = newUserId;

		///////////////////////////////////////
		/// Section A : instantiate BonusAccessbean

		if (userId != null)
			this.setInitKey_memberId(new Long(newUserId));

		///////////////////////////////////////
	}


    public Integer getTotalBonusPoints() {
		return totalBonusPoints;
	}
	public void setTotalBonusPoints(Integer newTotalBonusPoints) {
		totalBonusPoints = newTotalBonusPoints;
	}


//// End of section 1 ////////////////////////////////////////////


/**
 * Constructor for an ErrorDataBean.
 *
 */
public BonusDataBean() {
	super();
}


/// Section 2///////////////////////////////////////////////
// create a new constructor for passing access bean into databean so that JSP can work with the access bean

public BonusDataBean(BonusAccessBean bb) throws com.ibm.commerce.exception.ECException {
	try {
		super.setEJBRef(bb.getEJBRef());
	}  catch (javax.ejb.FinderException e) {
 			 	throw new ECSystemException(ECMessage._ERR_CREATE_EXCEPTION,
			 	"BonusDataBean", "BonusDataBean(bb)");
 	} catch (javax.naming.NamingException e) {
	 	throw new ECSystemException(ECMessage._ERR_NAMING_EXCEPTION, "BonusDataBean", "BonusDataBean(bb)");
 	} catch (java.rmi.RemoteException e) {
	 	throw new ECSystemException(ECMessage._ERR_REMOTE_EXCEPTION, "BonusDataBean", "BonusDataBean(bb)");
 	} catch (javax.ejb.CreateException e) {
	 	throw new ECSystemException(ECMessage._ERR_CREATE_EXCEPTION,  "BonusDataBean", "BonusDataBean(bb)");
 	}
}

//// End of section 2 ////////////////////////////////////////////


/*
 * Populate the databean. The bean properties will be populated
 * from the requestProperties associated with the bean.
 *
 */
public void populate() throws com.ibm.commerce.exception.ECException, CreateException{

//// Section 3 /////////////////////////////////////////////////
// set additional data field that is used for instantiating BonusAccessbean

	try
	{

		setUserId(getRequestProperties().getString("taskOutputUserId"));

		try {
			super.refreshCopyHelper();
		} catch (javax.ejb.FinderException e) {
 			 	throw new ECSystemException(ECMessage._ERR_CREATE_EXCEPTION,
			 	"BonusDataBean", "populate");
 	} catch (javax.naming.NamingException e) {
	 	throw new ECSystemException(ECMessage._ERR_NAMING_EXCEPTION, "BonusDataBean", "populate");
 	} catch (java.rmi.RemoteException e) {
	 	throw new ECSystemException(ECMessage._ERR_REMOTE_EXCEPTION, "BonusDataBean", "populate");
 	} catch (javax.ejb.CreateException e) {
	 	throw new ECSystemException(ECMessage._ERR_CREATE_EXCEPTION,  "BonusDataBean", "populate");
 	}


	}
	catch (ParameterNotFoundException e){}


///// End of Section 3 /////////////////////////////////////////


}



/**
 * Returns the current command's context
 * @return com.ibm.commerce.command.CommandContext
 * @see com.ibm.commerce.beans.SmartDataBean#getCommandContext()
 */
public com.ibm.commerce.command.CommandContext getCommandContext()
{
	return iCommandContext;
}

/**
 * Sets the command context
 * @param aCommandContext com.ibm.commerce.command.CommandContext
 * @see com.ibm.commerce.beans.SmartDataBean#setCommandContext(CommandContext)
 */
public void setCommandContext(com.ibm.commerce.command.CommandContext aCommandContext)
{
	iCommandContext = aCommandContext;
}

/**
 * Returns the request properties.
 * @return com.ibm.commerce.datatype.TypedProperty
 * @see com.ibm.commerce.beans.InputDataBean#getRequestProperties()
 */
public TypedProperty getRequestProperties() {
	return requestProperties;
}

/**
 * Sets the request properties and populates the parameters that are needed by the bean
 * @param aParam com.ibm.commerce.datatype.TypedProperty
 * @see com.ibm.commerce.beans.InputDataBean#setRequestProperties(TypedProperty)
 */

public void setRequestProperties(com.ibm.commerce.datatype.TypedProperty aParam)
{

/// Section 4 ///////////////////////////////////////////
// copy input TypedProperties to local

	requestProperties = aParam;

/// End of section 4 ////////////////////////////////////

}

}
