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
<title><%=discountWizardNLS.get("discountWizardOrderLevel_title")%></title>
<%=fPromoHeader%>
<script src="/wcs/javascript/tools/common/Util.js">
</script>

<script language="JavaScript">

var subType=0;
var fCurr=parent.get("discCurr");
var numNet=0;
var numMin=0;



function initializeState()
{
	

	subType=parent.get("discSubType");
	setInputAreaVis();

	var visitedWizOrderLevel = parent.get("visitedWizOrderLevel", false);
	if (visitedWizOrderLevel)
	{
		if (eval(subType)==0)
		{
			document.orderForm.orderPercentage.value=parent.get("orderPercentage");
			parent.pageArray["DiscountWizardOrderLevel"].helpKey="MC.discount.order.Help";
		}
		else
		{
			oNet=parent.get("orderNet");
			if ((oNet != null)&&(oNet != ""))
			{
				document.orderForm.orderNet.value=parent.numberToCurrency(oNet,fCurr,"<%=fLanguageId%>");
			}
			parent.pageArray["DiscountWizardOrderLevel"].helpKey="MC.discount.orderamount.Help";
		}

		var hasMin=	parent.get("hasMin");
		if (hasMin)
		{
			document.orderForm.minRad[1].checked = true;
			oMin = parent.get("orderMin");
			if ((oMin != null) && (oMin != ""))
			{
				document.orderForm.orderMin.value=parent.numberToCurrency(oMin,fCurr,"<%=fLanguageId%>");
			}
		}
		else
		{
			document.orderForm.minRad[0].checked = true;
		}	
		checkMinArea(hasMin);
	}

	if (eval(subType)==0)
	{
		document.orderForm.orderPercentage.focus();
		parent.pageArray["DiscountWizardOrderLevel"].helpKey="MC.discount.order.Help";
	}
	else
	{
		document.orderForm.orderNet.focus();
		parent.pageArray["DiscountWizardOrderLevel"].helpKey="MC.discount.orderamount.Help";
	}
	parent.setContentFrameLoaded(true);

}

function removeTopFrameEntries()
{
/*	if (eval(subType)==0)
	{
		parent.remove("orderPercentage");
	}
	else
	{
		parent.remove("orderNet");
	}

	if (document.orderForm.minRad[1].checked)
	{
		parent.remove("orderMin");
	}*/
	parent.put("visitedWizOrderLevel", false);
	
}


function validatePanelData()
{

	parent.put("visitedWizOrderLevel", true);

	if (eval(subType)==0)
	{
		if (!isValidPercentage(trim(document.orderForm.orderPercentage.value),"<%=fLanguageId%>"))
		{
			reprompt(document.orderForm.orderPercentage,"<%= UIUtil.toJavaScript(discountWizardNLS.get("percentageInvalid").toString())%>");
			removeTopFrameEntries();
			return false;
		}
	}
	else
	{

		if (parent.currencyToNumber(trim(document.orderForm.orderNet.value), fCurr,"<%=fLanguageId%>").toString().length >14)
		{
			reprompt(document.orderForm.orderNet,"<%= UIUtil.toJavaScript(discountWizardNLS.get("currencyTooLong").toString())%>");
			removeTopFrameEntries();
			return false;
		}
		else if ( !parent.isValidCurrency(trim(document.orderForm.orderNet.value), fCurr, "<%=fLanguageId%>"))
		{
			reprompt(document.orderForm.orderNet,"<%= UIUtil.toJavaScript(discountWizardNLS.get("currencyInvalid").toString())%>");
			removeTopFrameEntries();
			return false;
		}
	}

	if (document.orderForm.minRad[1].checked)
	{
		if (parent.currencyToNumber(trim(document.orderForm.orderMin.value), fCurr,"<%=fLanguageId%>").toString().length > 14)
		{
			reprompt(document.orderForm.orderMin,"<%= UIUtil.toJavaScript(discountWizardNLS.get("currencyTooLong").toString())%>");
			removeTopFrameEntries();
			return false;
		}
		else if ( !parent.isValidCurrency(trim(document.orderForm.orderMin.value), fCurr, "<%=fLanguageId%>"))
		{
			reprompt(document.orderForm.orderMin,"<%= UIUtil.toJavaScript(discountWizardNLS.get("minQualPurchaseAmountInvalid").toString())%>");
			removeTopFrameEntries();
			return false;
		}
		else if (eval(subType)==1 && (numMin <= numNet))
		{
			reprompt(document.orderForm.orderMin,"<%= UIUtil.toJavaScript(discountWizardNLS.get("minQualPurchaseAmountTooLow").toString())%>");
			removeTopFrameEntries();
			return false;
		}
		else if( eval(parent.currencyToNumber(trim(document.orderForm.orderMin.value), fCurr,"<%=fLanguageId%>")) == 0)
		{
			parent.put("hasMin", false);
		}
	}

	return true;
}




function isValidPercentage(pValue, languageId)
{
	if ( !parent.isValidInteger(pValue, languageId))
	{
		return false;
	}
	else if( ! (eval(pValue) <= 100))
	{
		return false;
	}
	else if (! (eval(pValue) >= 0) )
	{
		return false;
	}
	return true;
}



function savePanelData()
{
	if (eval(subType)==0)
	{
	    parent.put("orderPercentage", parent.strToNumber(trim(document.orderForm.orderPercentage.value),"<%=fLanguageId%>"));

	}
	else
	{
		numNet=parent.currencyToNumber(trim(document.orderForm.orderNet.value), fCurr,"<%=fLanguageId%>");
	    parent.put("orderNet", numNet);
	}

	if (document.orderForm.minRad[1].checked)
	{
		parent.put("hasMin", true);
		numMin=parent.currencyToNumber(trim(document.orderForm.orderMin.value), fCurr,"<%=fLanguageId%>");
		parent.put("orderMin", numMin);
	}
	else
	{
		parent.put("hasMin", false);
	}


    return true;
}


function hidePercentageInputArea()
{
	document.all["percentageInputArea"].style.display = "none";
}

function hideAmountInputArea()
{
	document.all["amountInputArea"].style.display = "none";
}

function showPercentageInputArea()
{
	document.all["percentageInputArea"].style.display = "block";
}

function showAmountInputArea()
{
	document.all["amountInputArea"].style.display = "block";
}

function setInputAreaVis()
{
	switch(eval(subType))
	{
		case 0: // percentage currently selected
			showPercentageInputArea();
			hideAmountInputArea();
			break;
		case 1: // by total
			showAmountInputArea();
			hidePercentageInputArea();
			break;
	}
	
}

function checkMinArea(hasMin)
{
	if (hasMin)
	{
		document.all["minArea"].style.display = "block";
	}
	else
	{
		document.all["minArea"].style.display = "none";
	}
}


function writeCurrency()
{
	var storeCurrs = parent.get("storeCurrArray");
	document.write(storeCurrs[parent.get("discCurrSelectedIndex")]);
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

<form name="orderForm" id="orderForm">

<h1><%=discountWizardNLS.get("DiscountWizardOrderLevel")%></h1>
<div id="percentageInputArea" style="display:block">
<%=discountWizardNLS.get("discPercentOffTotal")%><br />
<input name="orderPercentage" type="text" size="3" maxlength="3" id="WC_DiscountWizardOrderLevel_FormInput_orderPercentage_In_orderForm_1" /> <%=discountWizardNLS.get("percentage_symbol")%>
</div>


<div id="amountInputArea" style="display:none">
<%=discountWizardNLS.get("discAmountOffTotal")%><br />
<input name="orderNet" type="text" size="14" maxlength="14" id="WC_DiscountWizardOrderLevel_FormInput_orderNet_In_orderForm_1" />
	<script language="JavaScript">
		writeCurrency();
	
</script>
</div>


<p><%=discountWizardNLS.get("discountMinQualTitle")%></p>
<input type="radio" name="minRad" onclick="javascript:checkMinArea(false);" checked ="checked" id="WC_DiscountWizardOrderLevel_FormInput_minRad_In_orderForm_1" /><%=discountWizardNLS.get("None")%><br />
<input type="radio" name="minRad" onclick="javascript:checkMinArea(true);" id="WC_DiscountWizardOrderLevel_FormInput_minRad_In_orderForm_2" /><%=discountWizardNLS.get("discountMinQual")%>
<div id="minArea" style="display:none">
	<blockquote>
		<p><%=discountWizardNLS.get("purchaseAmount")%><br />
		<input name="orderMin" type="text" size="14" maxlength="14" id="WC_DiscountWizardOrderLevel_FormInput_orderMin_In_orderForm_1" />
			<script language="JavaScript">
				writeCurrency();
			
</script></p>
	</blockquote>
</div>

</form>
</body>
</html>


