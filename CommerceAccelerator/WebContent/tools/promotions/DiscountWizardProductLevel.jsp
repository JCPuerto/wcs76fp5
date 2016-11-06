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
<title><%=discountWizardNLS.get("discountWizardProductLevel_title")%></title>
<%=fPromoHeader%>
<script src="/wcs/javascript/tools/common/Util.js">
</script>


<script language="JavaScript">

//global var to get the selected currency
var fCurr=parent.get("discCurr");
var subType=0;


function initializeState()
{
	subType=parent.get("discSubType");
	setInputAreaVis();


	var visitedWizProductLevel = parent.get("visitedWizProductLevel", false);
	if (visitedWizProductLevel)
	{
		if (eval(subType)==0)
		{
			document.productForm.productPercentage.value=parent.get("productPercentage");
			parent.pageArray["DiscountWizardProductLevel"].helpKey="MC.discount.product.Help";
		}
		else
		{
			pAmt=parent.get("productAmtPerItem");
			if ((pAmt != null) && (pAmt !=""))
			{
				document.productForm.productAmtPerItem.value=parent.numberToCurrency(pAmt,fCurr,"<%=fLanguageId%>");
			}
			parent.pageArray["DiscountWizardProductLevel"].helpKey="MC.discount.productamount.Help";
		}

		var hasMin=	parent.get("hasMin");
		if (hasMin)
		{
			document.productForm.minRad[1].checked = true;
			pMin=parent.get("productMin");
			if ((pMin != null)&&(pMin!=""))
			{
				document.productForm.productMin.value=parent.numberToStr(pMin,"<%=fLanguageId%>",0);
			}
			var prodGrpAllowed=parent.get("prodGrpAllowed");
			if (prodGrpAllowed)
			{
				document.productForm.prodGrpRad[0].checked = true;
			}
			else
			{
				document.productForm.prodGrpRad[1].checked = true;
			}
			
		}
		else
		{
			document.productForm.minRad[0].checked = true;
		}	
		checkMinArea(hasMin);
	}
	
	if (eval(subType)==0)
	{
		document.productForm.productPercentage.focus();
		parent.pageArray["DiscountWizardProductLevel"].helpKey="MC.discount.product.Help";
	}
	else
	{
		document.productForm.productAmtPerItem.focus();
		parent.pageArray["DiscountWizardProductLevel"].helpKey="MC.discount.productamount.Help";
	}
	
	parent.setContentFrameLoaded(true);
}

function removeTopFrameEntries()
{
/*	if (eval(subType)==0)
	{
		parent.remove("productPercentage");
	}
	else
	{
		parent.remove("productAmtPerItem");
	}

	if (document.productForm.minRad[1].checked)
	{
		parent.remove("productMin");
	}*/
	parent.put("visitedWizProductLevel", false);
}


function validatePanelData()
{

	parent.put("visitedWizProductLevel", true);

	if (eval(subType)==0)
	{
		if (!isValidPercentage(trim(document.productForm.productPercentage.value),"<%=fLanguageId%>"))
		{
			reprompt(document.productForm.productPercentage,"<%= UIUtil.toJavaScript(discountWizardNLS.get("percentageInvalid").toString())%>");
			removeTopFrameEntries();
			return false;
		}
	}
	else
	{
		if(parent.currencyToNumber(trim(document.productForm.productAmtPerItem.value), fCurr, "<%=fLanguageId%>").toString().length > 14)
		{
			reprompt(document.productForm.productAmtPerItem, "<%= UIUtil.toJavaScript(discountWizardNLS.get("currencyTooLong").toString())%>");
			removeTopFrameEntries();
			return false;
		}
		else if (!parent.isValidCurrency(trim(document.productForm.productAmtPerItem.value), fCurr, "<%=fLanguageId%>"))
		{
			reprompt(document.productForm.productAmtPerItem,"<%= UIUtil.toJavaScript(discountWizardNLS.get("currencyInvalid").toString())%>");
			removeTopFrameEntries();
			return false;
		}
	}

	if (document.productForm.minRad[1].checked)
	{
		if(parent.strToNumber(trim(document.productForm.productMin.value),"<%=fLanguageId%>").toString().length > 14)
		{
			reprompt(document.productForm.productMin,"<%= UIUtil.toJavaScript(discountWizardNLS.get("numberTooLong").toString())%>");
			removeTopFrameEntries();
			return false;
		}
		else if ( !parent.isValidInteger(trim(document.productForm.productMin.value), "<%=fLanguageId%>")) 
		{
			reprompt(document.productForm.productMin,"<%= UIUtil.toJavaScript(discountWizardNLS.get("prodMinNotNumber").toString())%>");
			removeTopFrameEntries();
			return false;
		}
		else if (!(eval(parent.strToNumber(trim(document.productForm.productMin.value),"<%=fLanguageId%>")) > 0))
		{
			reprompt(document.productForm.productMin,"<%= UIUtil.toJavaScript(discountWizardNLS.get("prodMinNotNumber").toString())%>");
			removeTopFrameEntries();
			return false;
		}
		else if( eval(parent.strToNumber(trim(document.productForm.productMin.value), "<%=fLanguageId%>")) == 0)
		{
			parent.put("hasMin", false);
		}

	}

	return true;

}

function savePanelData()
{
	if (eval(subType)==0)
	{
	    parent.put("productPercentage", parent.strToNumber(trim(document.productForm.productPercentage.value),"<%=fLanguageId%>"));
	}
	else
	{
	    parent.put("productAmtPerItem", parent.currencyToNumber(trim(document.productForm.productAmtPerItem.value), fCurr, "<%=fLanguageId%>"));
	}

	if (document.productForm.minRad[1].checked)
	{
		parent.put("hasMin", true);
		parent.put("productMin", parent.strToNumber(trim(document.productForm.productMin.value),"<%=fLanguageId%>"));

		if (document.productForm.prodGrpRad[0].checked)
		{
			parent.put("prodGrpAllowed", true);
		}
		else
		{
			parent.put("prodGrpAllowed", false);
		}
	}
	else
	{
		parent.put("hasMin", false);
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
		case 2: // by amount per unit
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
companies, brands and products in product to illustrate them as completely as
possible.  All of these are names are ficticious and any similarity to the names
and addresses used by actual persons or business enterprises is entirely coincidental.

Licensed Materials - Property of IBM

5697-D24

(c)  Copyright  IBM Corp.  1997, 1999.      All Rights Reserved

US Government Users Restricted Rights - Use, duplication or 
disclosure restricted by GSA ADP Schedule Contract with IBM Corp

=============================================================================== -->

<form name="productForm" id="productForm">

<h1><%=discountWizardNLS.get("DiscountWizardProductLevel")%></h1>
<div id="percentageInputArea" style="display:block">
<%=discountWizardNLS.get("discPercentOffPerItem")%><br />
<input name="productPercentage" type="text" size="3" maxlength="3" id="WC_DiscountWizardProductLevel_FormInput_productPercentage_In_productForm_1" /> <%=discountWizardNLS.get("percentage_symbol")%>
</div>


<div id="amountInputArea" style="display:none">
<%=discountWizardNLS.get("discAmountOffPerItem")%><br />
	<input name="productAmtPerItem" type="text" size="14" maxlength="14" id="WC_DiscountWizardProductLevel_FormInput_productAmtPerItem_In_productForm_1" />
			<script language="JavaScript">
				writeCurrency();
			
</script>
</div>


<p><%=discountWizardNLS.get("discountMinQualTitle")%></p>


<input type="radio" name="minRad" onclick="javascript:checkMinArea(false);" checked ="checked"id="WC_DiscountWizardProductLevel_FormInput_minRad_In_productForm_1" /><%=discountWizardNLS.get("None")%><br />
<input type="radio" name="minRad" onclick="javascript:checkMinArea(true);" id="WC_DiscountWizardProductLevel_FormInput_minRad_In_productForm_2" /><label for="productMin"><%=discountWizardNLS.get("discountMinQualProd")%></label>
<div id="minArea" style="display:none">
	<blockquote>
		<input name="productMin" id="productMin" type="text" size="14" maxlength="14" />
	</blockquote>
<p><%=discountWizardNLS.get("discountProductQualification")%></p>
<blockquote>
<input type="radio" name="prodGrpRad" checked ="checked" id="WC_DiscountWizardProductLevel_FormInput_prodGrpRad_In_productForm_1" /><%=discountWizardNLS.get("discountAllowProdGrps")%><br />
<input type="radio" name="prodGrpRad" id="WC_DiscountWizardProductLevel_FormInput_prodGrpRad_In_productForm_2" /><%=discountWizardNLS.get("discountDisallowProdGrps")%>
</blockquote>


</div>

</form>
</body>
</html>


