<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2010 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!--  
//********************************************************************
//*-------------------------------------------------------------------
//* The sample contained herein is provided to you "AS IS".
//*
//* It is furnished by IBM as a simple example and has not been thoroughly tested
//* under all conditions.  IBM, therefore, cannot guarantee its reliability, 
//* serviceability or functionality.  
//*
//* This sample may include the names of individuals, companies, brands and products 
//* in order to illustrate concepts as completely as possible.  All of these names
//* are fictitious and any similarity to the names and addresses used by actual persons 
//* or business enterprises is entirely coincidental.
//*--------------------------------------------------------------------------------------
//*
-->

<%@ page language="java" %>
<%@ page import="com.ibm.commerce.server.JSPResourceBundle"%>
<%@ page import="com.ibm.commerce.beans.ErrorDataBean"%>
<%@ page import="com.ibm.commerce.datatype.TypedProperty"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="com.ibm.commerce.ras.ECTrace"%>
<%@ page import="com.ibm.commerce.ras.ECTraceIdentifiers"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
JSPResourceBundle myResourceBundle = null;
try {
	myResourceBundle = new JSPResourceBundle(java.util.ResourceBundle.getBundle("GenericApplicationError"));
} catch (java.util.MissingResourceException mre) {
	myResourceBundle = new JSPResourceBundle();
}
%>

<% response.setContentType("text/html;charset=UTF-8"); %>
<% response.setHeader("Pragma", "No-cache");           %>
<% response.setDateHeader("Expires", 0);               %>
<% response.setHeader("Cache-Control", "no-cache");    %>

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">

<HTML lang="en">
<head>
	<title>
		<%= myResourceBundle.getString("title") %>
	</title>
</head>
<BODY>
<% 
try {
	ErrorDataBean errorBean = new ErrorDataBean ();
	com.ibm.commerce.beans.DataBeanManager.activate (errorBean, request);
%>
<H1>
	<%= myResourceBundle.getString("head1") %>
</H1>

<BR>

<TABLE border=2 ROWS=2 COLS=4 bordercolor="#98d3ec">
	<TR bgcolor="#98d3ec">
		<TH>
			<FONT SIZE=+1><%= myResourceBundle.getString("table_col1") %></FONT>
		</TH>
		<TH>
			<FONT SIZE=+1><%= myResourceBundle.getString("table_col2") %></FONT>
		</TH>
		<TH>
			<FONT SIZE=+1><%= myResourceBundle.getString("table_col3") %></FONT>
		</TH>
		<TH>
			<FONT SIZE=+1><%= myResourceBundle.getString("table_col4") %></FONT>
		</TH>
	</TR>
	<TR>
		<TD><CENTER><c:out value="<%= errorBean.getExceptionType()%>" /></CENTER></TD>
		<TD><CENTER><c:out value="<%= errorBean.getMessageKey() %>" /></CENTER></TD>
		<TD>
			<TABLE border="0">
				<TR>
					<TH VALIGN=TOP><%= myResourceBundle.getString("userHeader") %></TH>
					<TD><c:out value="<%= errorBean.getMessage() %>" /></TD>
				</TR>
				<TR>
					<TH VALIGN=TOP><%= myResourceBundle.getString("systemHeader") %></TH>
					<TD><c:out value="<%= errorBean.getSystemMessage() %>" /></TD>
				</TR>
			</TABLE>
		</TD>
		<TD><CENTER><c:out value="<%= errorBean.getOriginatingCommand() %>" /></CENTER></TD>
	</TR>
</TABLE>

<br>
<br>
<HR>

<%
TypedProperty nvps = errorBean.getExceptionData();
if (nvps != null) {
	Enumeration en = nvps.keys();
%>
<CENTER>
<TABLE border=2 bordercolor="#98d3ec">
	<TR bgcolor="#98d3ec">
			<TH colspan="2">
				<FONT SIZE=+1><%= myResourceBundle.getString("exceptionDataHeader") %></FONT>
			</TH>
	</TR>
	<TR bgcolor="#98d3ec">
		<TH>
			<FONT SIZE=+1><%= myResourceBundle.getString("nameHeader") %></FONT>
		</TH>
		<TH>
			<FONT SIZE=+1><%= myResourceBundle.getString("valueHeader") %></FONT>
		</TH>
	</TR>
<%
while(en.hasMoreElements()) {
	String name = (String)en.nextElement();
%>
	<TR>
		<TD><CENTER><%= name %></CENTER></TD>
		<TD><CENTER><c:out value="<%= nvps.getString(name, \"\") %>" /></CENTER></TD>
	</TR>
<% } %>
</TABLE>
</CENTER>
<% } %>

<%
} catch (Exception e) {
	System.out.println ("An exception occurred.  Enable the COMPONENT_SERVER trace to see the exception details.");
	if(ECTrace.traceEnabled(ECTraceIdentifiers.COMPONENT_SERVER)){
			e.printStackTrace();
	}
}

%>

</BODY>
</HTML>

