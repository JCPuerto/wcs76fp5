<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2002, 2003
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
 %>

<%@page import="com.ibm.commerce.tools.xml.*" %>
<%@page import="com.ibm.commerce.tools.util.*" %>
<%@page import="com.ibm.commerce.tools.common.*" %>
<%@page import="com.ibm.commerce.command.*" %>
<%@page import="com.ibm.commerce.server.*" %>
<%@page import="java.util.*" %>

<%@include file="../common/common.jsp" %>
<SCRIPT>
	function getHelp()
	{
		return "MC.reporting.OperationalReviewIndividualReportsHomeRHSView.Help";
	}
</SCRIPT>

<%
 		CommandContext commandContext = (CommandContext)request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
 		Locale locale = commandContext.getLocale();
		Hashtable resourceBundle = (Hashtable) ResourceDirectory.lookup("reporting.reportStrings", locale);
%>

<html>
<head>
<title><%=resourceBundle.get("ReviewIndividualCustomerActivityTitle")%></title>
<link rel=stylesheet href="<%= UIUtil.getCSSFile(locale) %>" type="text/css">
<META name="GENERATOR" content="IBM WebSphere Studio">
</head>
<body class="entry" BGCOLOR="FFFFFF">
<table CELLPADDING="0" CELLSPACING="0" BORDER="0" HEIGHT="100%" WIDTH="100%">
    <tr>
        <td>
        <table CELLPADDING="0" CELLSPACING="0" BORDER="0" WIDTH="100%" HEIGHT="1%">
            <tr>
                <td CLASS="entry_space">&nbsp;&nbsp;&nbsp;</td>
                <td class="entry_text"><B><%=resourceBundle.get("ReviewIndividualCustomerActivityTitle")%></B>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td CLASS="entry_space" COLSPAN=4>&nbsp;&nbsp;&nbsp;</td>
            </tr>
            <tr>
                <td CLASS="entry_space">&nbsp;&nbsp;&nbsp;</td>
                <td CLASS="entry_text" COLSPAN=3><%=resourceBundle.get("ReviewIndividualCustomerActivityDescription")%></td>
            </tr>
            <tr>
                <td CLASS="entry_space" COLSPAN=4>&nbsp;&nbsp;&nbsp;</td>
            </tr>
            <tr>
                <td CLASS="entry_space" COLSPAN=4>&nbsp;&nbsp;&nbsp;</td>
            </tr>
			<!--  New Company Registration Report -->
			<tr>
                <td CLASS="entry_space" COLSPAN=4>&nbsp;&nbsp;&nbsp;</td>
            </tr>
			<tr>
                <td CLASS="entry_space">&nbsp;&nbsp;&nbsp;</td>

                <td NOWRAP class="entry_text"><a href="javascript:top.setContent('<%=resourceBundle.get("OpReportsNewCompanyRegistrationReportTitle")%>', '/webapp/wcs/tools/servlet/DialogView?XMLFile=reporting.NewCompanyRegistrationReportDialog', true, null)"><%=resourceBundle.get("OpReportsNewCompanyRegistrationReportTitle")%></a></td>
                <td>&nbsp;&nbsp;&nbsp;</td>
                <td class="entry_text"><%=resourceBundle.get("OpReportsNewCompanyRegistrationReportDescription")%></td>
            </tr>
            <!--  New Representative Registration -->
			<tr>
                <td CLASS="entry_space" COLSPAN=4>&nbsp;&nbsp;&nbsp;</td>
            </tr>
			<tr>
                <td CLASS="entry_space">&nbsp;&nbsp;&nbsp;</td>
                <td NOWRAP class="entry_text"><a href="javascript:top.setContent('<%=resourceBundle.get("OpReportsNewRepresentativeRegistrationReportTitle")%>', '/webapp/wcs/tools/servlet/DialogView?XMLFile=reporting.NewRepresentativeRegistrationReportDialog', true, null)"><%=resourceBundle.get("OpReportsNewRepresentativeRegistrationReportTitle")%></a></td>
                <td>&nbsp;&nbsp;&nbsp;</td>
                <td class="entry_text"><%=resourceBundle.get("OpReportsNewRepresentativeRegistrationReportDescription")%></td>
            </tr>
			<!--  New Individuals Registration -->
			<tr>
                <td CLASS="entry_space" COLSPAN=4>&nbsp;&nbsp;&nbsp;</td>
            </tr>
			<tr>
                <td CLASS="entry_space">&nbsp;&nbsp;&nbsp;</td>
                <td NOWRAP class="entry_text"><a href="javascript:top.setContent('<%=resourceBundle.get("OpReportsNewIndividualsRegistrationReportTitle")%>', '/webapp/wcs/tools/servlet/DialogView?XMLFile=reporting.NewIndividualsRegistrationReportDialog', true, null)"><%=resourceBundle.get("OpReportsNewIndividualsRegistrationReportTitle")%></a></td>
                <td>&nbsp;&nbsp;&nbsp;</td>
                <td class="entry_text"><%=resourceBundle.get("OpReportsNewIndividualsRegistrationReportDescription")%></td>
            </tr>
        </table>
        </td>
    </tr>
    <tr>
        <td valign="bottom"><br>
        <table CELLPADDING="0" CELLSPACING="0" BORDER="0" WIDTH="100%" HEIGHT="14" BGCOLOR="32428A">
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
        </td>
    </tr>
</table>
</body>
</html>

