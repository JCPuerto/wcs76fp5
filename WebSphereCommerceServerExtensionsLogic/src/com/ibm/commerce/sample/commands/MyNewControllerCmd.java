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
//*

import com.ibm.commerce.command.ControllerCommand;

public interface MyNewControllerCmd extends ControllerCommand {
	/**
	*	defaultCommandClassName is the default implementation
	*	class used by command factory to instantiate this
	*	command if this interface is not defined in the CMDREG table.
	*/

	public static final String COPYRIGHT = com.ibm.commerce.copyright.IBMCopyright.SHORT_COPYRIGHT;


/// Section 1 //////////////////////////////////////////////

// set default command implement class

	static final String defaultCommandClassName = "com.ibm.commerce.sample.commands.MyNewControllerCmdImpl";


/// End of section 1//////////////////////////////////////////////////////////



/// Section 2 ////////////////////////////////////////////////

// set interface methods


	public Integer getPoints() ;

	public String getUserName() ;

	public void setPoints(Integer newPoints) ;

	public void setUserName(String newUserName)  ;


/// End of section 2//////////////////////////////////////////


}