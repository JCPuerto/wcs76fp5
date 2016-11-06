<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c)  Copyright  IBM Corp.  2000      All Rights Reserved

US Government Users Restricted Rights - Use, duplication or 
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="promoCommon.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=discountWizardNLS.get("discountWizardCustomType_title")%></title>
<%=fPromoHeader%>

<script language="JavaScript">

var incomingDiscType;
var incomingDiscSubType;

function initializeState()
{
////////////////////////////////////////////////////////////////////
// as this page is a nexus, use the last type chosen to determine
// what 'visited' flags to clear if we switch branches
////////////////////////////////////////////////////////////////////

	var visitedWizCustomType = parent.get("visitedWizCustomType", false);
	if (visitedWizCustomType)
	{
		incomingDiscType=parent.get("discType");
		incomingDiscSubType=parent.get("discSubType");

		
		if (eval(incomingDiscType)==1)
		{
			if (eval(incomingDiscSubType) == 0)
			{
				document.customTypeForm.discType[0].checked = true;
				document.customTypeForm.discType[0].focus();
			}
			else if (eval(incomingDiscSubType) == 1)
			{
				document.customTypeForm.discType[2].checked = true;
				document.customTypeForm.discType[2].focus();
			}
			else if (eval(incomingDiscSubType) == 2)
			{
				document.customTypeForm.discType[1].checked = true;
				document.customTypeForm.discType[1].focus();
			}
		}
		else
		{
			if (eval(incomingDiscSubType) == 0)
			{
				document.customTypeForm.discType[3].checked = true;
				document.customTypeForm.discType[3].focus();
			}
			else if (eval(incomingDiscSubType) == 1)
			{
				document.customTypeForm.discType[4].checked = true;
				document.customTypeForm.discType[4].focus();
			}
		}
	}
	else
	{
		document.customTypeForm.discType[0].focus();
	}
	parent.setContentFrameLoaded(true);

}


function validatePanelData()
{
// nothing to validate

}


function savePanelData()
{
	//////////////////////////////////////
	// put type & subtype into top frame//
	// 0 == order level                 //
	// 1 == product level               //
	// 0 == percentage					//
	// 1 == amount (fixed)
	// 2 == amount (per unit)
	//////////////////////////////////////


	var dTp=0;
	var i = 0;
	var outgoingDiscType;
	var outgoingDiscSubType;
	
	
	while (!document.customTypeForm.discType[i].checked)
	{
		i++;
	}


	switch(eval(i))
	{
		case 0: // Product Level (percentage)
			outgoingDiscType = 1;
			outgoingDiscSubType = 0;
			parent.put("discSubType", outgoingDiscSubType);
		    	parent.put("discType", outgoingDiscType);
			parent.setNextBranch("DiscountWizardCustom");
			break;
		case 1: // Product Level (amount per unit)
			
			outgoingDiscType = 1;
			outgoingDiscSubType = 2;
			parent.put("discSubType", outgoingDiscSubType);
		    	parent.put("discType", outgoingDiscType);
		    	parent.setNextBranch("DiscountWizardCustom");
			break;
		case 2: // Product Level (fixed amount)
			outgoingDiscType = 1;
			outgoingDiscSubType = 1;
			parent.put("discSubType", outgoingDiscSubType);
		    	parent.put("discType", outgoingDiscType);
		    	parent.setNextBranch("DiscountWizardCustom");
			break;

		case 3: // Order Level (percentage)
			outgoingDiscType = 0;
			outgoingDiscSubType = 0;
			parent.put("discSubType", outgoingDiscSubType);
		    	parent.put("discType", outgoingDiscType);
		    	parent.put("rangeType",0);
			parent.setNextBranch("DiscountWizardRanges");
			break;
		case 4: // Order Level ( fixed amount)
			outgoingDiscType = 0;
			outgoingDiscSubType = 1;
			parent.put("discSubType", outgoingDiscSubType);
		    	parent.put("discType", outgoingDiscType);
		    	parent.put("rangeType",0);
		    	parent.setNextBranch("DiscountWizardRanges");
			break;
		

	}


	//////////////////////////////////////////////////////////////
	// if user is changing types ... set the visited flags
	// to false to avoid reading incorrect data
	//////////////////////////////////////////////////////////////

	parent.put("visitedWizCustomType", true);
    return true;
}





</script>
</head>
<body class="content" onload="initializeState();">
<!-- ============================================================================
The sample Templates, HTML and Macros are furnished by IBM as simple
examples to provide an illustration. These examples have not been
thoroughly tested under all conditions.  IBM, therefore, cannot guarantee reliability, 
serviceability or function of these programs. All programs contained herein are provided 
to you "AS IS".

The sample Templates, HTML and Macros may include the names of individuals,
companies, brands and products in order to illustrate them as completely as
possible.  All of these are names are ficticious and any similarity to the names
and addresses used by actual persons or business enterprises is entirely coincidental.

Licensed Materials - Property of IBM

5697-D24

(c)  Copyright  IBM Corp.  1997, 1999.      All Rights Reserved

US Government Users Restricted Rights - Use, duplication or 
disclosure restricted by GSA ADP Schedule Contract with IBM Corp

=============================================================================== -->

<form name="customTypeForm" id="customTypeForm">

<h1><%=discountWizardNLS.get("discCustomType")%></h1>

<p><input name="discType" type="radio" checked ="checked" id="WC_DiscountWizardCustomType_FormInput_discType_In_customTypeForm_1" /><%=discountWizardNLS.get("discPercentOffPerItem")%></p>
<p><input name="discType" type="radio" id="WC_DiscountWizardCustomType_FormInput_discType_In_customTypeForm_2" /><%=discountWizardNLS.get("discAmountOffPerItem")%></p>
<p><input name="discType" type="radio" id="WC_DiscountWizardCustomType_FormInput_discType_In_customTypeForm_3" /><%=discountWizardNLS.get("discAmtOffQualProducts")%></p>
<p><input name="discType" type="radio" id="WC_DiscountWizardCustomType_FormInput_discType_In_customTypeForm_4" /><%=discountWizardNLS.get("discPercentOffTotal")%></p>
<p><input name="discType" type="radio" id="WC_DiscountWizardCustomType_FormInput_discType_In_customTypeForm_5" /><%=discountWizardNLS.get("discAmountOffTotal")%></p>

</form>
</body>
</html>


