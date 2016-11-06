<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c)  Copyright  IBM Corp.  2000      All Rights Reserved

US Government Users Restricted Rights - Use, duplication or 
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="promoCommon.jsp" %>
<%@page import="com.ibm.commerce.price.utils.*" %>
<%@page import="com.ibm.commerce.common.objects.*" %>

<%

   StoreAccessBean storeAB = com.ibm.commerce.server.WcsApp.storeRegistry.find(fStoreId);

	// get the supported currencies for a store
	CurrencyManager cm = CurrencyManager.getInstance();
	String[] supportedCurrencies = cm.getSupportedCurrencies( storeAB );
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=discountWizardNLS.get("discountWizardWelcome_title")%></title>
<%= fPromoHeader%>

<script src="/wcs/javascript/tools/common/DateUtil.js">
</script>
<script src="/wcs/javascript/tools/common/Util.js">
</script>

<script language="JavaScript">

var startWin;
var endWin;

function initializeState()
{
	
	// put hour values into hour selects
	loadDiscHours();

	var visitedWizWelcome = parent.get("visitedWizWelcome", false);
	if (visitedWizWelcome)  // if we've been here already ... 
	{
		// get name & desc
		document.welcomeForm.discName.value = parent.get("discName");
		document.welcomeForm.discDesc.value = parent.get("discDesc");
		document.welcomeForm.discAdminDesc.value = parent.get("discAdminDesc");
		
		// check if we have a date time range ..
		var hasDateTime=parent.get("hasDateTimeRange",false);
		if (hasDateTime) 
		{
			document.welcomeForm.discStartYear.value=parent.get("discStartYear");
			document.welcomeForm.discStartMonth.value=parent.get("discStartMonth");
			document.welcomeForm.discStartDay.value=parent.get("discStartDay");
			
			document.welcomeForm.discEndYear.value=parent.get("discEndYear");
			document.welcomeForm.discEndMonth.value=parent.get("discEndMonth");
			document.welcomeForm.discEndDay.value=parent.get("discEndDay");

			// select the hour for start & end -- the information is indexed against the 
			// select elements
			document.welcomeForm.discStartTimeSelect.selectedIndex = parent.get("discStartTimeSelectedIndex");
			document.welcomeForm.discEndTimeSelect.selectedIndex = parent.get("discEndTimeSelectedIndex");

			document.welcomeForm.hasDateTime[1].checked = true;
			showDateTimeFields();
		}
		else
		{
			document.welcomeForm.hasDateTime[0].checked = true;
		}

		// put currency options into box ... 
		loadDiscCurr();

		// select the right currency -- the information is indexed against the 
		// array of names stored in the top frame
		document.welcomeForm.discCurr.selectedIndex = parent.get("discCurrSelectedIndex");

		if ((trim(document.welcomeForm.discStartYear.value).length == 0)||(trim(document.welcomeForm.discStartMonth.value).length == 0)||(trim(document.welcomeForm.discStartDay.value).length == 0))
		{
			// default the dates/times
			document.welcomeForm.discStartYear.value=getCurrentYear();
			document.welcomeForm.discStartMonth.value=getCurrentMonth();
			document.welcomeForm.discStartDay.value=getCurrentDay();
			
			document.welcomeForm.discEndYear.value=getCurrentYear();
			document.welcomeForm.discEndMonth.value=getCurrentMonth();
			document.welcomeForm.discEndDay.value=getCurrentDay();
			
			document.welcomeForm.discStartTimeSelect.selectedIndex = 0;
			document.welcomeForm.discEndTimeSelect.selectedIndex = 23;
		}

	}
	else
	{

		// populate the currency array and the select
		currArray();
		
		// put currency options into box ... 
		loadDiscCurr();
		
		// default the dates/times
		document.welcomeForm.discStartYear.value=getCurrentYear();
		document.welcomeForm.discStartMonth.value=getCurrentMonth();
		document.welcomeForm.discStartDay.value=getCurrentDay();
		
		document.welcomeForm.discEndYear.value=getCurrentYear();
		document.welcomeForm.discEndMonth.value=getCurrentMonth();
		document.welcomeForm.discEndDay.value=getCurrentDay();
		
		document.welcomeForm.discStartTimeSelect.selectedIndex = 0;
		document.welcomeForm.discEndTimeSelect.selectedIndex = 23;
	
	}
	document.welcomeForm.discName.focus();
	parent.setContentFrameLoaded(true);

}

function savePanelData()
{
	 parent.put("discName", document.welcomeForm.discName.value);
	 if (document.welcomeForm.hasDateTime[1].checked)
    	{
    	    parent.put("hasDateTimeRange", true);
    	    
	    parent.put("discStartYear",  document.welcomeForm.discStartYear.value);
	    parent.put("discStartMonth",  document.welcomeForm.discStartMonth.value);
	    parent.put("discStartDay",  document.welcomeForm.discStartDay.value);
	    
	    parent.put("discEndYear",  document.welcomeForm.discEndYear.value);
	    parent.put("discEndMonth",  document.welcomeForm.discEndMonth.value);
	    parent.put("discEndDay",  document.welcomeForm.discEndDay.value);
	    
	    parent.put("discStartTimeSelectedIndex",  document.welcomeForm.discStartTimeSelect.selectedIndex);
	    parent.put("discEndTimeSelectedIndex",  document.welcomeForm.discEndTimeSelect.selectedIndex);	
    	}
    	else
    		parent.put("hasDateTimeRange", false);
    	
    		// put desc in top frame
    parent.put("discDesc", document.welcomeForm.discDesc.value);
    parent.put("discAdminDesc", document.welcomeForm.discAdminDesc.value);

	// put currency choice in the top frame ... 
	parent.put("discCurrSelectedIndex", document.welcomeForm.discCurr.selectedIndex);

	// put actual currency in top frame to be used by server side command
	var storeCurrs = parent.get("storeCurrArray");
	parent.put("discCurr", storeCurrs[document.welcomeForm.discCurr.selectedIndex]);

	// show that we've been here
    parent.put("visitedWizWelcome", true);
    		
}

function validatePanelData()
{
    if ( !(document.welcomeForm.discName.value) )
    {
	    reprompt(document.welcomeForm.discName, "<%= UIUtil.toJavaScript(discountWizardNLS.get("discountNameBlankMsg").toString())%>");
	    return false;
	}
	else if ( !isValidUTF8length(document.welcomeForm.discName.value, 30) )
	{
		parent.alertDialog("<%= UIUtil.toJavaScript(discountWizardNLS.get("discountFieldTooLong").toString())%>");
		document.welcomeForm.discName.focus();
		document.welcomeForm.discName.select();
		return false;
	}
	else if (!isValidUTF8length(document.welcomeForm.discAdminDesc.value, 254))
	{
	    parent.alertDialog("<%= UIUtil.toJavaScript(discountWizardNLS.get("discountFieldTooLong").toString())%>");
	    document.welcomeForm.discAdminDesc.focus();
	    document.welcomeForm.discAdminDesc.select();
	    return false;
	}
	else if (!isValidUTF8length(document.welcomeForm.discDesc.value, 254))
	{
	    parent.alertDialog("<%= UIUtil.toJavaScript(discountWizardNLS.get("discountFieldTooLong").toString())%>");
	    document.welcomeForm.discDesc.focus();
	    document.welcomeForm.discDesc.select();
	    return false;
	}
	else if (document.welcomeForm.hasDateTime[1].checked)
    {
    	var startTime=document.welcomeForm.discStartTimeSelect.selectedIndex+":00";
    	var endTime=document.welcomeForm.discEndTimeSelect.selectedIndex+":00";

		if ( !validDate(document.welcomeForm.discStartYear.value,document.welcomeForm.discStartMonth.value,document.welcomeForm.discStartDay.value))
		{
		    parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountInvalidStartDateMsg").toString())%>');
		    return false;
		}
		else if ( !validDate(document.welcomeForm.discEndYear.value,document.welcomeForm.discEndMonth.value,document.welcomeForm.discEndDay.value))
		{
		    parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountInvalidEndDateMsg").toString())%>');
		    return false;
		}

		rc = validateStartEndDateTime(document.welcomeForm.discStartYear.value,document.welcomeForm.discStartMonth.value,document.welcomeForm.discStartDay.value, document.welcomeForm.discEndYear.value,document.welcomeForm.discEndMonth.value,document.welcomeForm.discEndDay.value, startTime, endTime);

		if ((rc==false)||(eval(rc)==-1))
		{
		    parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountNotOrderedMsg").toString())%>');
		    return false;
		}
    }

    return true;
}

function setupStartDate()
{
	window.yearField = document.welcomeForm.discStartYear;
	window.monthField = document.welcomeForm.discStartMonth;
	window.dayField = document.welcomeForm.discStartDay;
}

function openStartDateWin()
{
	startWin=window.open('/webapp/commerce/tools/servlet/Calendar','cal','WIDTH=200,HEIGHT=250,left=630,top=310');
}

function openEndDateWin()
{
	endWin=window.open('/webapp/commerce/tools/servlet/Calendar','cal','WIDTH=200,HEIGHT=250,left=630,top=310');
}

function closeCalWindow()
{
	if (startWin != undefined)
	{
		if (!startWin.closed)
		{
			startWin.close();
		}
	}
	
	if (endWin != undefined)
	{
		if (!endWin.closed)
		{
			endWin.close();
		}
	}
}

function setupEndDate()
{
	window.yearField = document.welcomeForm.discEndYear;
	window.monthField = document.welcomeForm.discEndMonth;
	window.dayField = document.welcomeForm.discEndDay;
}

function hideDateTimeFields()
{
	document.all["dateTimeArea"].style.display = "none";
}

function showDateTimeFields()
{
	document.all["dateTimeArea"].style.display = "block";
}


function currArray()
{

	var currArray = new Array();
	<% int i=0;
	while (i < supportedCurrencies.length) 
	{%>
		currArray[<%=i%>] = "<%=supportedCurrencies[i]%>";
		<%i++;
	}%>


	parent.put("storeCurrArray", currArray);
}

function loadDiscCurr()
{
	var storeCurrs = parent.get("storeCurrArray");

	for(var i=0; i<storeCurrs.length; i++)
	{
		document.welcomeForm.discCurr.options[i] = new Option(storeCurrs[i], storeCurrs[i], false, false);
	}
}

function loadDiscHours()
{

	for(var i=0; i<24; i++)
	{
		document.welcomeForm.discStartTimeSelect.options[i] = new Option(i + "<%=discountWizardNLS.get("colonZeroZero")%>", i + "<%=discountWizardNLS.get("colonZeroZero")%>", false, false);
		document.welcomeForm.discEndTimeSelect.options[i] = new Option(i + "<%=discountWizardNLS.get("colonZeroZero")%>", i + "<%=discountWizardNLS.get("colonZeroZero")%>", false, false);
	}

}



</script>
</head>

<body class="content" onload="initializeState();" onunload="closeCalWindow();">
<script for="document" event="onclick()">
document.all.CalFrame.style.display="none";

</script>
<iframe style="display:none;position:absolute;width:198;height:230" id="CalFrame" marginheight="0" marginwidth="0" noresize ="NORESIZE"frameborder="0" scrolling="no" src="/webapp/wcs/tools/servlet/Calendar">
</iframe>
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

<form name="welcomeForm" id="welcomeForm">

<h1><%=discountWizardNLS.get("welcome")%></h1>

<p><%=discountWizardNLS.get("discountNameLabel")%><br />
<input name="discName" type="text" size="15" maxlength="30" id="WC_DiscountWizardWelcome_FormInput_discName_In_welcomeForm_1" /></p>

<p><%=discountWizardNLS.get("discountDescLabel")%><br />
<textarea name="discAdminDesc" rows="5" cols="50"></textarea></p>

<p><%=discountWizardNLS.get("discountShopperDescLabel")%><br />
<textarea name="discDesc" rows="5" cols="50"></textarea></p>

<p><%=discountWizardNLS.get("discountCurrLabel")%><br />
<select name="discCurr"></select></p>


<p><input name="hasDateTime" type="radio" value="no" onclick="javascript:hideDateTimeFields();" checked ="checked" id="WC_DiscountWizardWelcome_FormInput_hasDateTime_In_welcomeForm_1" /> <%=discountWizardNLS.get("discountAlways")%> <br />
<input name="hasDateTime" type="radio" value="yes" onclick="javascript:showDateTimeFields();" id="WC_DiscountWizardWelcome_FormInput_hasDateTime_In_welcomeForm_2" /> <%=discountWizardNLS.get("discountHasDateTime")%></p>

<div id="dateTimeArea" style="display:none">
<blockquote>

        <table border="0" cellspacing="3" cellpadding="0" id="WC_DiscountWizardWelcome_Table_1">
          <tr align="left" valign="middle">
            <td id="t01">&nbsp;</td>
            <td id="t02"><%=discountWizardNLS.get("discountYear")%></td>
            <td id="t03">&nbsp;</td>
            <td id="t04"><%=discountWizardNLS.get("discountMonth")%></td>
            <td id="t05">&nbsp;</td>
            <td id="t06"><%=discountWizardNLS.get("discountDay")%></td>
            <td id="t07">&nbsp;</td>
            <td id="t08">&nbsp;</td>
            <td id="t09">&nbsp;</td>
            <td id="t10">&nbsp;</td>
          </tr>

          <tr>
            <td headers="t01" id="startDate"><%=discountWizardNLS.get("startDateLabel")%></td>
            <td headers="startDate t02" id="WC_DiscountWizardWelcome_TableCell_12"><input type="text" value="" name="discStartYear" size="4" maxlength="4" id="WC_DiscountWizardWelcome_FormInput_discStartYear_In_welcomeForm_1" /></td>
            <td headers="t03" id="WC_DiscountWizardWelcome_TableCell_13">&nbsp;</td>
            <td headers="startDate t04" id="WC_DiscountWizardWelcome_TableCell_14"><input type="text" value="" name="discStartMonth" size="2" maxlength="2" id="WC_DiscountWizardWelcome_FormInput_discStartMonth_In_welcomeForm_1" /></td>
            <td headers="t05" id="WC_DiscountWizardWelcome_TableCell_15">&nbsp;</td>
            <td headers="startDate t06" id="WC_DiscountWizardWelcome_TableCell_16"><input type="text" value="" name="discStartDay" size="2" maxlength="2" id="WC_DiscountWizardWelcome_FormInput_discStartDay_In_welcomeForm_1" /></td>
            <td headers="t07" id="WC_DiscountWizardWelcome_TableCell_17">&nbsp;</td>
            <td headers="t08" id="WC_DiscountWizardWelcome_TableCell_18"><a href="javascript:setupStartDate();showCalendar(document.welcomeForm.calImg1)" id="WC_DiscountWizardWelcome_Link_1">
		 	<img src="/wcs/images/tools/calendar/calendar.gif" border="0" alt='<%=discountWizardNLS.get("discountOpenCalendar")%>' id="calImg1" /></a></td>
            <td headers="t09" id="startTime">  <%=discountWizardNLS.get("startTimeLabel")%></td>
            <td headers="startTime t10" id="WC_DiscountWizardWelcome_TableCell_20"><select name="discStartTimeSelect"></select></td>
          </tr>

          <tr>
            <td headers="t01" id="endDate"><%=discountWizardNLS.get("endDateLabel")%></td>
            <td headers="endDate t02" id="WC_DiscountWizardWelcome_TableCell_22"><input type="text" value="" name="discEndYear" size="4" maxlength="4" id="WC_DiscountWizardWelcome_FormInput_discEndYear_In_welcomeForm_1" /></td>
            <td headers="t03" id="WC_DiscountWizardWelcome_TableCell_23"></td>
            <td headers="endDate t04" id="WC_DiscountWizardWelcome_TableCell_24"><input type="text" value="" name="discEndMonth" size="2" maxlength="2" id="WC_DiscountWizardWelcome_FormInput_discEndMonth_In_welcomeForm_1" /></td>
            <td headers="t05" id="WC_DiscountWizardWelcome_TableCell_25"></td>
            <td headers="endDate t06" id="WC_DiscountWizardWelcome_TableCell_26"><input type="text" value="" name="discEndDay" size="2" maxlength="2" id="WC_DiscountWizardWelcome_FormInput_discEndDay_In_welcomeForm_1" /></td>
            <td headers="t07" id="WC_DiscountWizardWelcome_TableCell_27">&nbsp;</td>
            <td headers="t08" id="WC_DiscountWizardWelcome_TableCell_28"><a href="javascript:setupEndDate(); showCalendar(document.welcomeForm.calImg2)" id="WC_DiscountWizardWelcome_Link_2">
		 	<img src="/wcs/images/tools/calendar/calendar.gif" border="0" alt='<%=discountWizardNLS.get("discountOpenCalendar")%>' id="calImg2" /></a></td>
            <td headers="t09" id="endTime">  <%=discountWizardNLS.get("endTimeLabel")%> </td>
            <td headers="endTime t10" id="WC_DiscountWizardWelcome_TableCell_30"><select name="discEndTimeSelect"></select></td>
          </tr>
        </table>

</blockquote>
</div>
</form>
</body>
</html>

