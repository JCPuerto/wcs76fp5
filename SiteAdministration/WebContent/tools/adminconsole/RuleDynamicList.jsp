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

<title><%= rulelistNLS.get("RuleListHeading") %></title>
<script language="JavaScript" src="<%= UIUtil.getWebPrefix(request) %>javascript/tools/common/dynamiclist.js"></script>
<script language="JavaScript" src="<%= UIUtil.getWebPrefix(request) %>javascript/tools/common/Util.js"></script>

<jsp:useBean id="rulebean" scope="request" class="com.ibm.commerce.ruleservice.admin.beans.PersonalizationRuleServerConfigurationDataBean">
<%	com.ibm.commerce.beans.DataBeanManager.activate(rulebean, request); %>
</jsp:useBean>

<%
	numListItems = rulebean.countServices();
	PersonalizationRuleServiceConfigurationDataBean[] ruleList = rulebean.getPersonalizationRuleServiceConfigurations();
%>

<script language="JavaScript">
<!-- hide script from old browsers
var kRuleDynamicListUrl = top.getWebappPath() + "NewDynamicListView?ActionXMLFile=adminconsole.ruleList&cmd=RuleServiceListView";

// declare variables used throughout this page
ruleServiceList = new Array();
ruleServiceListString = "";
projectPathListString = "";
var numOfServices = 0;

//===================================
// Utility functions
//===================================
function parseRuleServiceListItem (item) {
	// I think this function would be better if it
	// used an object instead of an array to store the data.

	// Need to clone the item, otherwise we change it!
	var myString = item;
	result = myString.split("&", 4);
	return result;
}

function getSelectedRuleService () {
	return parent.getChecked()[0];
}

function branchToDialog (dialogTitle, urlParameters) {
	top.setContent(dialogTitle, top.getWebappPath() + "DialogView", true, urlParameters);
}

function executeUrl (title, url, urlParameters) {
	top.resetBCT();
	top.setContent(title, url, true, urlParameters);
}

function executeAdministrationUrl (url, urlParameters) {
	urlParameters.redirecturl = kRuleDynamicListUrl;
	executeUrl("<%= rulelistNLS.get("Administration") %>", url, urlParameters);
}

function performDelete () {
	if (confirmDialog("<%= rulelistNLS.get("deletecamp") %>")) {
		document.ruleForm.selected.value = parent.getChecked();
		document.ruleForm.submit();
	}
}

function onLoad () {
	parent.loadFrames();
}

function doConfirmThenDoAction (translatedConfirmationMessage, relativeAdministrationUrl) {
	if (confirmDialog(translatedConfirmationMessage)) {
		properties = parseRuleServiceListItem(getSelectedRuleService());
		var rsname = properties[0];

		var urlParameters = new Object();
		urlParameters.rsname = rsname;
		urlParameters.storeId = <%= cmdContext.getStoreId() %>;

		executeAdministrationUrl(top.getWebappPath() + relativeAdministrationUrl, urlParameters);
	}
}

//===================================
// Actions
//===================================
function addService () {
	var urlParameters = new Object();
	urlParameters.XMLFile = "adminconsole.addDialog";
	urlParameters.storeId = <%= cmdContext.getStoreId() %>;
	urlParameters.ruleListString = ruleServiceListString;
	urlParameters.projectListString = projectPathListString;
	branchToDialog("<%= rulelistNLS.get("AddServiceTitle") %>", urlParameters);
}

function editService () {
	var selectedRuleService = getSelectedRuleService();
	properties = parseRuleServiceListItem(getSelectedRuleService());

	var rsname = properties[0];
	var projectPath = properties[1];
	var numAgents = properties[2];
	var timeout = properties[3];

	projectPath = projectPath.replace(/\\/ig, "/");

	var urlParameters = new Object();
	urlParameters.XMLFile = "adminconsole.editDialog";
	urlParameters.rsname = rsname;
	urlParameters.projectPath = projectPath;
	urlParameters.timeout = timeout;
	urlParameters.numAgents = numAgents;
	urlParameters.storeId = <%= cmdContext.getStoreId() %>;
	branchToDialog("<%= rulelistNLS.get("EditServiceTitle") %>", urlParameters);
}

function removeService () {
	doConfirmThenDoAction('<%= UIUtil.toJavaScript((String) rulelistNLS.get("deleteConfirmation")) %>', "RemoveRuleService");
}

function refreshService () {
	doConfirmThenDoAction('<%= UIUtil.toJavaScript((String) rulelistNLS.get("refreshConfirmation")) %>', "RefreshRuleService");
}

function enableService () {
	doConfirmThenDoAction('<%= UIUtil.toJavaScript((String) rulelistNLS.get("startConfirmation")) %>', "EnableRuleService");
}

function disableService () {
	doConfirmThenDoAction('<%= UIUtil.toJavaScript((String) rulelistNLS.get("stopConfirmation")) %>', "DisableRuleService");
}

// bring up a window to bring up the status of a rule service
function statusRequest () {
	properties = parseRuleServiceListItem(getSelectedRuleService());
	var rsname = properties[0];

	var param = "rsname=" + rsname + "&storeId=" + <%= cmdContext.getStoreId() %>;

	var redirectPage = top.getWebappPath() + "NewDynamicListView?ActionXMLFile=adminconsole.ruleList&cmd=RuleServiceListView";
	alertDialog('<%= UIUtil.toJavaScript((String) rulelistNLS.get("statusConfirmation")) %>' + " " + rsname + ".  " + '<%= UIUtil.toJavaScript((String) rulelistNLS.get("viewMessage")) %>');

	var urlParameters = new Object();
	urlParameters.pathInfo = "UpdateRuleServiceStatus";
	urlParameters.queryString = param;
	urlParameters.URL = redirectPage;

	top.resetBCT();
	top.setContent("<%= rulelistNLS.get("Administration") %>", top.getWebappPath() + "BroadcastUpdateRuleServiceStatus", true, urlParameters);
}

function viewLastRequest () {
	properties = parseRuleServiceListItem(getSelectedRuleService());
	var rsname = properties[0];

	// setting the parameters in a hashtable
	var urlParameters = new Object();
	urlParameters.ActionXMLFile = "adminconsole.statusList";
	urlParameters.cmd = "StatusListView";
	urlParameters.rsname = rsname;

	top.setContent("<%= rulelistNLS.get("ViewStatusTitle") %>", top.getWebappPath() + "NewDynamicListView", true, urlParameters);
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

<%= comm.addControlPanel("adminconsole.ruleList", totalpage, totalsize, locale) %>
<form name="ruleForm">

<%= comm.startDlistTable((String)rulelistNLS.get("RuleListSummary")) %>
<%= comm.startDlistRowHeading() %>
<%= comm.addDlistCheckHeading() %>
<%= comm.addDlistColumnHeading((String)rulelistNLS.get("name"), null, false) %>
<%= comm.addDlistColumnHeading((String)rulelistNLS.get("projectFile"), null, false) %>
<%= comm.addDlistColumnHeading((String)rulelistNLS.get("numAgents"), null, false) %>
<%= comm.addDlistColumnHeading((String)rulelistNLS.get("sessionTimeout"), null, false) %>
<%= comm.endDlistRow() %>

<%
	if (endIndex > numListItems) {
		endIndex = numListItems;
	}

	int indexFrom = startIndex;
	for (int i=indexFrom; i<endIndex; i++) {
		PersonalizationRuleServiceConfigurationDataBean ruleServiceConfiguration = ruleList[i];

		String ruleProperties = ruleServiceConfiguration.getServiceName() + "&" + ruleServiceConfiguration.getProjectPath() + "&" + ruleServiceConfiguration.getNumberOfAgents() + "&" + ruleServiceConfiguration.getSessionTimeout();
		String projectPath = ruleServiceConfiguration.getProjectPath();
		StringBuffer displayProjectPath = new StringBuffer();
		String numberOfAgents = "";
		String sessionTimeout = "";

		int len = (projectPath != null) ? projectPath.length() : 0;
		for (int j=0; j<len; j++) {
			char c = projectPath.charAt(j);
			switch (c) {
				case '\\': {
					displayProjectPath.append("\\<WBR>");
					break;
				}
				case '/': {
					displayProjectPath.append("/<WBR>");
					break;
				}
				default: {
					displayProjectPath.append(c);
					break;
				}
			}
		}

		if (ruleServiceConfiguration.getNumberOfAgents() != null) {
			numberOfAgents = ruleServiceConfiguration.getNumberOfAgents().toString();
		}
		if (ruleServiceConfiguration.getSessionTimeout() != null) {
			sessionTimeout = ruleServiceConfiguration.getSessionTimeout().toString();
		}
%>

<script language="JavaScript">
<!-- hide script from old browsers
if (numOfServices == 0) {
	ruleServiceListString = "<%= ruleServiceConfiguration.getServiceName() %>";
	projectPathListString = "<%= displayProjectPath %>";
}
else if (numOfServices > 0) {
	ruleServiceListString += "&" + "<%= ruleServiceConfiguration.getServiceName() %>";
	projectPathListString += "&" + "<%= displayProjectPath %>";
}
numOfServices++;
//-->
</script>

<%= comm.startDlistRow(rowselect) %>
<%= comm.addDlistCheck(UIUtil.toJavaScript(ruleProperties), "none") %>
<%= comm.addDlistColumn(UIUtil.toHTML(ruleServiceConfiguration.getServiceName()), "none") %>
<%= comm.addDlistColumn(UIUtil.toHTML(displayProjectPath.toString()), "none") %>
<%= comm.addDlistColumn(UIUtil.toHTML(numberOfAgents), "none") %>
<%= comm.addDlistColumn(UIUtil.toHTML(sessionTimeout), "none") %>
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
<%= rulelistNLS.get("emptyListMessage") %>
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