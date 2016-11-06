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
<title><%=discountWizardNLS.get("discountWizardCustom_title")%></title>
<%=fPromoHeader%>

<script language="JavaScript">

var discType = 0;

function initializeState()
{

	//////////////////////////////////////////////////////////////
	// get the type that has been chosen
	//////////////////////////////////////////////////////////////
	discType=parent.get("discType");

	//////////////////////////////////////////////////////////////
	// see if we've been here before
	//////////////////////////////////////////////////////////////
	var visitedWizCustom = parent.get("visitedWizCustom", false);

	//////////////////////////////////////////////////////////////
	// prepare page according to available information
	// to reflect user's previous choices ... 
	//////////////////////////////////////////////////////////////
	
	if (visitedWizCustom) // if we've been here before .... 
	{
		//////////////////////////////////////////////////////////////
		// get whether product combinations are allowed ... 
		//////////////////////////////////////////////////////////////
		var prodGrpAllowed=parent.get("prodGrpAllowed");
		if (prodGrpAllowed)
		{
			document.customForm.prodGrpRad[0].checked = true;
			document.customForm.prodGrpRad[0].focus();
		}
		else
		{
			document.customForm.prodGrpRad[1].checked = true;
			document.customForm.prodGrpRad[1].focus();
		}

		//////////////////////////////////////////////////////////////
		// get the rangetype
		//////////////////////////////////////////////////////////////
		var rType=parent.get("rangeType");
		if (eval(rType)==0)
		{
			document.customForm.discRT[0].checked = true;
		}
		else
		{
			document.customForm.discRT[1].checked = true;
		}

	}

	parent.setContentFrameLoaded(true);

}

function validatePanelData()
{
}

function savePanelData()
{
	//////////////////////////////////////////////////////////////
	// this records whether combinations are allowed ... 
	//////////////////////////////////////////////////////////////
	if (document.customForm.prodGrpRad[0].checked)
	{
		parent.put("prodGrpAllowed", true);
	}
	else
	{
		parent.put("prodGrpAllowed", false);
	}
	//////////////////////////////////////////////////////////////
	// record the the rangetype 0==price, 1==qty
	//////////////////////////////////////////////////////////////
	if (document.customForm.discRT[0].checked)
	{
		parent.put("rangeType",0);
	}
	else
	{
		parent.put("rangeType", 1);
	}

	parent.put("visitedWizCustom", true);
    return true;
}


</script>

</head>

<body class="content" onload="javascript:initializeState();">
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

<form name="customForm" id="customForm">

<h1><%=discountWizardNLS.get("discAttachedToItems")%></h1>

<p><%=discountWizardNLS.get("discountProductQualification")%></p>
<blockquote>
	<input type="radio" name="prodGrpRad" checked ="checked" id="WC_DiscountWizardCustom_FormInput_prodGrpRad_In_customForm_1" /><%=discountWizardNLS.get("discountAllowProdGrps")%><br />
	<input type="radio" name="prodGrpRad" id="WC_DiscountWizardCustom_FormInput_prodGrpRad_In_customForm_2" /><%=discountWizardNLS.get("discountDisallowProdGrps")%>
</blockquote>


<p><%=discountWizardNLS.get("discountCustomAttrChoice")%></p>

<blockquote>
	<input name="discRT" type="radio" checked ="checked" id="WC_DiscountWizardCustom_FormInput_discRT_In_customForm_1" /><%=discountWizardNLS.get("discountNetPrice")%><br />
	<input name="discRT" type="radio" id="WC_DiscountWizardCustom_FormInput_discRT_In_customForm_2" /><%=discountWizardNLS.get("discountQtyItems")%>
</blockquote>



</form>
</body>
</html>
