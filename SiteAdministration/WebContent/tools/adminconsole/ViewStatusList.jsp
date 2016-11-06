<!--
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2004
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
-->

<%@ page language="java"
	import="com.ibm.commerce.beans.DataBeanManager,
	com.ibm.commerce.command.*,
	com.ibm.commerce.ruleservice.admin.beans.*,
	com.ibm.commerce.rules.RuleServiceStatusCloneReport,
	com.ibm.commerce.server.ECConstants,
	com.ibm.commerce.tools.common.ui.taglibs.*,
	com.ibm.commerce.tools.util.*" %>

<%@ include file="../common/common.jsp" %>

<%
	// obtain the resource bundle for display
	CommandContext cmdContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
	Locale locale = cmdContext.getLocale();
	Hashtable rulelistNLS = (Hashtable) ResourceDirectory.lookup("adminconsole.rulesNLS", locale);
	int numListItems = 0;
%>

<html>

<head>
<%= fHeader %>
<link rel="stylesheet" href="<%= UIUtil.getCSSFile(locale) %>" type="text/css">

<title><%= rulelistNLS.get("ViewStatusTitle") %></title>
<script language="JavaScript" src="<%= UIUtil.getWebPrefix(request) %>javascript/tools/common/dynamiclist.js"></script>
<script language="JavaScript" src="<%= UIUtil.getWebPrefix(request) %>javascript/tools/common/Util.js"></script>

<jsp:useBean id="statusbean" scope="request" class="com.ibm.commerce.ruleservice.admin.beans.PersonalizationRuleServiceStatusDataBean">
<jsp:setProperty name="statusbean" property="serviceName" value='<%= request.getParameter("rsname") %>' />
<%	com.ibm.commerce.beans.DataBeanManager.activate(statusbean, request); %>
</jsp:useBean>

<%
	RuleServiceStatusCloneReport[] statusList = statusbean.getCloneReports();
	if (statusList != null) {
		numListItems = statusList.length;
	}
%>

<script language="JavaScript">
<!-- hide script from old browsers
function close () {
	top.goBack();
}

function onLoad () {
	parent.loadFrames();
}

function getResultsSize () {
	return <%= numListItems %>;
}
//-->
</script>
</head>

<body onLoad="onLoad()" class="content_list">

<%
	int startIndex = Integer.parseInt(request.getParameter("startindex"));
	int listSize = Integer.parseInt(request.getParameter("listsize"));
	int endIndex = startIndex + listSize;
	int rowselect = 1;
	int totalsize = numListItems;
	int totalpage = totalsize/listSize;
%>

<%= comm.addControlPanel("adminconsole.statusList", totalpage, totalsize, locale) %>
<form name="statusForm">
<%= comm.startDlistTable((String)rulelistNLS.get("StatusListSummary")) %>
<%= comm.startDlistRowHeading() %>
<%= comm.addDlistColumnHeading((String)rulelistNLS.get("nameRuleS"), null, false) %>
<%= comm.addDlistColumnHeading((String)rulelistNLS.get("clone"), null, false) %>
<%= comm.addDlistColumnHeading((String)rulelistNLS.get("ruleServiceStatus"), null, false) %>
<%= comm.endDlistRow() %>

<%
	if (endIndex > numListItems) {
		endIndex = numListItems;
	}

	RuleServiceStatusCloneReport cloneReport;
	int indexFrom = startIndex;
	for (int i=indexFrom; i<endIndex; i++) {
		cloneReport = statusList[i];
%>
<%= comm.startDlistRow(rowselect) %>
<%= comm.addDlistColumn(UIUtil.toHTML(request.getParameter("rsname")), "none") %>
<%= comm.addDlistColumn(UIUtil.toHTML(cloneReport.getCloneName()), "none") %>
<%= comm.addDlistColumn(UIUtil.toHTML((String)rulelistNLS.get(cloneReport.getStatusCode().toString())), "none") %>
<%= comm.endDlistRow() %>
<%
		if (rowselect == 1) {
			rowselect = 2;
		}
		else {
			rowselect = 1;
		}
	}
%>
<%= comm.endDlistTable() %>

<%	if (numListItems == 0) { %>
<p><p>
<%= rulelistNLS.get("noCloneReportsMessage") %>
<%	} %>

</form>

<script language="JavaScript">
<!-- hide script from old browsers
parent.afterLoads();
parent.setResultssize(getResultsSize());
//-->
</script>

</body>

</html>