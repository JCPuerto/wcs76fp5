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


<jsp:useBean id="discountDetails" scope="request" class="com.ibm.commerce.tools.promotions.DiscountDetailsBean">
</jsp:useBean>
<%
	com.ibm.commerce.beans.DataBeanManager.activate(discountDetails, request);
%>

<title><%=discountWizardNLS.get("DiscountDetailsDialog_title")%></title>
<%=fPromoHeader%>
<script>
function initializeState() 
{
	parent.setContentFrameLoaded(true);
}

function savePanelData() {}

function writeIsImportedDiscount()
{
<% if(discountDetails.isImportedDiscount())
{%>
	document.write('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountDetailsImported").toString())%>');
<%}%>
}

function writeCurrency() 
{
	if ( (eval(<%=discountDetails.getDiscSubType()%>) == 0) && (eval(<%=discountDetails.getRangeType()%>) == 1) )
	{
		document.write('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountDetailsNoCurrency").toString())%>');
	}
	else
	{	
		document.write("<%=discountDetails.getCurrency()%>");
	}
}

function writeDiscountType() 
{
	if (eval(<%=discountDetails.getDiscType()%>) ==0)
	{
		document.write('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountDetailsOLevel").toString())%>');
	}
	else
	{
		document.write('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountDetailsPLevel").toString())%>');
		
		if (eval(<%=discountDetails.getGroupBy()%>) == 0)
		{
			document.write('<br><%= UIUtil.toJavaScript(discountWizardNLS.get("discountDetailsGrpAllowed").toString())%>');
		}
		else
		{
			document.write('<br><%= UIUtil.toJavaScript(discountWizardNLS.get("discountDetailsGrpNotAllowed").toString())%>');
		}
	}
}

function writeDateTime() 
{
	<% if (discountDetails.isAlwaysInEffect())
	{%>
		document.write('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountAlways").toString())%>');
	<%}
	else
	{%>
		document.write("<br>");
		document.write("<table>");
		document.write("<tr>");
		document.write('<td><%= UIUtil.toJavaScript(discountWizardNLS.get("discountDetailsStartDateLabel").toString())%></td>');
		document.write("<td><i><%=discountDetails.getStartDate()%></td></i>");
		document.write("</tr>");
		document.write("<tr>");
		document.write('<td><%= UIUtil.toJavaScript(discountWizardNLS.get("discountDetailsEndDateLabel").toString())%></td>');
		document.write("<td><i><%=discountDetails.getEndDate()%></i></td>");
		document.write("</tr>");
		document.write("</table>");
		document.write("<br>");
	<%}%>
}

function writeShopperGroups()
{
<% if(discountDetails.isAllShoppers())
{%>
document.write('<%= UIUtil.toJavaScript(discountWizardNLS.get("allShopperGroups").toString())%>');
<%}
else
{%>
	document.write("<table>");

<%
	Vector mbrVector = discountDetails.getMemberGroupVector();
	Vector mbrNameVector = discountDetails.getMemberGroupNameVector();
	int i=0;
	while (i < mbrVector.size()) 
	{%>

		document.write("<tr>");
		document.write("<td><i><%=mbrVector.elementAt(i)%></i></td>");
		document.write("<td><i><%=mbrNameVector.elementAt(i)%></i></td>");
		document.write("</tr>");

		<%i++;
	}%>
	document.write("</table>");
	document.write("<br>");
<%}%>
}


function writeRangeTable() 
{
	var increValue= 1; 
	var rangeToArray = new Array();
	var rangeFromArray = new Array();
	var dValueArray = new Array();
	var classId = "list_row1";

	
	if (eval(<%=discountDetails.getRangeType()%>) == 0)
	{
		// increValue = 1 / Math.pow(10,parent.numericInfo["<%=discountDetails.getCurrency()%>"]["<%=fLanguageId%>"]["currency"]["minFrac"]);    
		var ninfo = parent.getNumericInfo("<%=discountDetails.getCurrency()%>","<%=fLanguageId%>");
		increValue = 1 / Math.pow(10,ninfo["minFrac"]);    
	}
	
	<% int x=0;
	Vector dValueVector = discountDetails.getDiscountValueVector();
	Vector rStartVector = discountDetails.getRangeStartVector();

	while (x < dValueVector.size()) 
	{%>
		rangeFromArray[<%=x%>] = eval(<%=rStartVector.elementAt(x)%>);
		dValueArray[<%=x%>]= eval(<%=dValueVector.elementAt(x)%>);
		<%x++;
	}%>

	var numRanges = eval(<%=dValueVector.size()%>);
	if(numRanges>1)
	{
		for(var i=0; i<numRanges-1;i++)
		{
				rangeToArray[i]=eval(parseFloat(rangeFromArray[i+1]) - parseFloat(increValue)); 
		}
	}

	document.write('<table class="list">');
	document.write("<tr class=\"list_roles\">");
	document.write('<th id="t1" class="list_header">' + '<%= UIUtil.toJavaScript(discountWizardNLS.get("discountRangeFrom").toString())%>' + "  " + '<%= UIUtil.toJavaScript(discountWizardNLS.get("open_bracket_symbol").toString())%>'); 

	if(eval(<%=discountDetails.getRangeType()%>) == 0)
	{
		document.write("<%=discountDetails.getCurrency()%>");
	}
	else
	{
		document.write('<%= UIUtil.toJavaScript(discountWizardNLS.get("items").toString())%>');
	}
	document.write('<%= UIUtil.toJavaScript(discountWizardNLS.get("close_bracket_symbol").toString())%>' + "</th>");
	
	document.write("<th id=\"t2\" class=\"list_header\">" + '<%= UIUtil.toJavaScript(discountWizardNLS.get("discountRangeTo").toString())%>' + "  " + '<%= UIUtil.toJavaScript(discountWizardNLS.get("open_bracket_symbol").toString())%>'); 
	if(eval(<%=discountDetails.getRangeType()%>) == 0)
	{
		document.write("<%=discountDetails.getCurrency()%>");
	}
	else
	{
		document.write('<%= UIUtil.toJavaScript(discountWizardNLS.get("items").toString())%>');
	}
	document.write('<%= UIUtil.toJavaScript(discountWizardNLS.get("close_bracket_symbol").toString())%>' + "</th>");

	if (eval(<%=discountDetails.getDiscType()%>) == 0)
	{
		if (eval(<%=discountDetails.getDiscSubType()%>) ==0)
		{
			document.write("<th id=\"t3\" class=\"list_header\">" + '<%= UIUtil.toJavaScript(discountWizardNLS.get("discPercentOffTotal").toString())%>' + "</th>");
		}
		else
		{
			document.write("<th id=\"t3\" class=\"list_header\">" + '<%= UIUtil.toJavaScript(discountWizardNLS.get("discAmountOffTotal").toString())%>' + "  " + '<%= UIUtil.toJavaScript(discountWizardNLS.get("open_bracket_symbol").toString())%>' + "<%=discountDetails.getCurrency()%>" + '<%= UIUtil.toJavaScript(discountWizardNLS.get("close_bracket_symbol").toString())%>' + "</th>");
		}
	}
	else
	{
		if (eval(<%=discountDetails.getDiscSubType()%>) ==0)
		{
			document.write("<th id=\"t3\" class=\"list_header\">" + '<%= UIUtil.toJavaScript(discountWizardNLS.get("discPercentOffPerItem").toString())%>' + "</th>");
		}
		else if (eval(<%=discountDetails.getDiscSubType()%>) ==1)
		{
			document.write("<th id=\"t3\" class=\"list_header\">" + '<%= UIUtil.toJavaScript(discountWizardNLS.get("discAmtOffQualProducts").toString())%>' + "  " + '<%= UIUtil.toJavaScript(discountWizardNLS.get("open_bracket_symbol").toString())%>' + "<%=discountDetails.getCurrency()%>" + '<%= UIUtil.toJavaScript(discountWizardNLS.get("close_bracket_symbol").toString())%>' + "</th>");
		}
		else
		{
			document.write("<th id=\"t3\" class=\"list_header\">" + '<%= UIUtil.toJavaScript(discountWizardNLS.get("discAmountOffPerItem").toString())%>' + "  " + '<%= UIUtil.toJavaScript(discountWizardNLS.get("open_bracket_symbol").toString())%>' + "<%=discountDetails.getCurrency()%>" + '<%= UIUtil.toJavaScript(discountWizardNLS.get("close_bracket_symbol").toString())%>' + "</th>");
		}
	}
	document.write("</tr>");



	i=0;
	while (i < numRanges) 
	{
			document.write('<tr class='+classId+'>');
			
			
			if(eval(<%=discountDetails.getRangeType()%>) == 0)
			{
				document.write("<td headers=\"t1\" class=\"list_info1\"><i>" + parent.numberToCurrency(rangeFromArray[i],"<%=discountDetails.getCurrency()%>","<%=fLanguageId%>") + "</i></td>");
			}
			else
			{
				document.write("<td headers=\"t1\" class=\"list_info1\"><i>" + parent.numberToStr(rangeFromArray[i],"<%=fLanguageId%>",0) + "</i></td>");
			}

			if (rangeToArray[i] != null)
			{
				if(eval(<%=discountDetails.getRangeType()%>) == 0)
				{
					document.write("<td headers=\"t2\" class=\"list_info1\"><i>" + parent.numberToCurrency(rangeToArray[i],"<%=discountDetails.getCurrency()%>","<%=fLanguageId%>") + "</i></td>");
				}
				else
				{
					document.write("<td headers=\"t2\" class=\"list_info1\"><i>" + parent.numberToStr(rangeToArray[i],"<%=fLanguageId%>",0) + "</i></td>");
				}
			}
			else
			{
				document.write("<td headers=\"t2\" class=\"list_info1\"><i><%= UIUtil.toJavaScript(discountWizardNLS.get("andUp").toString())%></i></td>");
			
			}
			
			if (eval(<%=discountDetails.getDiscSubType()%>) ==0)
			{
				document.write("<td headers=\"t3\" class=\"list_info1\"><i>" + parent.numberToStr(dValueArray[i],"<%=fLanguageId%>",0) + "</i></td>");
			}
			else
			{
				document.write("<td headers=\"t3\" class=\"list_info1\"><i>" + parent.numberToCurrency(dValueArray[i],"<%=discountDetails.getCurrency()%>","<%=fLanguageId%>") + "</i></td>");
			}
			
			document.write("</tr>");
			i++;
			if (classId == "list_row1")
			{
				classId = "list_row2";
			}
			else
			{
				classId = "list_row1";
			}

	}




	document.write("</table>");


}



</script>

</head>

<body class="content" onload="initializeState()">
<form name="detailsDialogForm" id="detailsDialogForm">

<h1><%=discountWizardNLS.get("DiscountDetailsDialog_title")%></h1>

<i><script language="JavaScript">
  writeIsImportedDiscount();

</script></i>

<p><%=discountWizardNLS.get("discountDetailsNameLabel")%>
<i><%=discountDetails.getCode()%></i></p>

<p><%=discountWizardNLS.get("discountDetailsDescLabel")%>
<i><%=discountDetails.getAdminDescription()%></i></p>

<p><%=discountWizardNLS.get("discountDetailsShopperDescLabel")%>
<i><%=discountDetails.getDescription()%></i></p>

<p><%=discountWizardNLS.get("discountDetailsCurrLabel")%>  
<i><script language="JavaScript">
  writeCurrency();

</script></i>
</p>

<p><%=discountWizardNLS.get("discountDetailsScope")%>
<i><script language="JavaScript">
  writeDiscountType();

</script></i>
</p>

<p><%=discountWizardNLS.get("discountDetailsDateRange")%>
<i><script language="JavaScript">
writeDateTime();

</script></i>
</p>

<p><%=discountWizardNLS.get("definedShopperGroups")%>
<i><script language="JavaScript">
  writeShopperGroups();

</script></i>
</p>

<p><%=discountWizardNLS.get("discountDetailsRangesLabel")%>
<script language="JavaScript">
writeRangeTable();

</script>
</p>

</form>


</body>
</html>


