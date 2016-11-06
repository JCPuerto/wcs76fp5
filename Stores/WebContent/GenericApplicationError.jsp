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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>


<fmt:setBundle basename="GenericApplicationError" var="myResourceBundle"/>

<% response.setContentType("text/html;charset=UTF-8"); %>
<% response.setHeader("Pragma", "No-cache");           %>
<% response.setDateHeader("Expires", 0);               %>
<% response.setHeader("Cache-Control", "no-cache");    %>

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">

<HTML lang="en">
<head>
	<title>
		<fmt:message key="title" bundle="${myResourceBundle}" />
	</title>
</head>
<BODY>
<% 
try {
%>
<wcbase:useBean id="errorBean" classname="com.ibm.commerce.beans.ErrorDataBean" scope="page"/>
<H1>
	<fmt:message key="head1" bundle="${myResourceBundle}" />
</H1>

<BR>

<TABLE border=2 ROWS=2 COLS=4 bordercolor="#98d3ec">
	<TR bgcolor="#98d3ec">
		<TH>
			<FONT SIZE=+1><fmt:message key="table_col1" bundle="${myResourceBundle}" /></FONT>
		</TH>
		<TH>
			<FONT SIZE=+1><fmt:message key="table_col2" bundle="${myResourceBundle}" /></FONT>
		</TH>
		<TH>
			<FONT SIZE=+1><fmt:message key="table_col3" bundle="${myResourceBundle}" /></FONT>
		</TH>
		<TH>
			<FONT SIZE=+1><fmt:message key="table_col4" bundle="${myResourceBundle}" /></FONT>
		</TH>
	</TR>
	<TR>
		<TD><CENTER><c:out value="${errorBean.exceptionType}" /></CENTER></TD>
		<TD><CENTER><c:out value="${errorBean.messageKey}" /></CENTER></TD>
		<TD>
			<TABLE border="0">
				<TR>
					<TH VALIGN=TOP><fmt:message key="userHeader" bundle="${myResourceBundle}" /></TH>
					<TD><c:out value="${errorBean.message}" /></TD>
				</TR>
				<TR>
					<TH VALIGN=TOP><fmt:message key="systemHeader" bundle="${myResourceBundle}" /></TH>
					<TD><c:out value="${errorBean.systemMessage}" /></TD>
				</TR>
			</TABLE>
		</TD>
		<TD><CENTER><c:out value="${errorBean.originatingCommand}" /></CENTER></TD>
	</TR>
</TABLE>

<br>
<br>
<HR>

<c:if test="${errorBean.exceptionData != null}">
<CENTER>
<TABLE border=2 bordercolor="#98d3ec">
	<TR bgcolor="#98d3ec">
			<TH colspan="2">
				<FONT SIZE=+1><fmt:message key="exceptionDataHeader" bundle="${myResourceBundle}" /></FONT>
			</TH>
	</TR>
	<TR bgcolor="#98d3ec">
		<TH>
			<FONT SIZE=+1><fmt:message key="nameHeader" bundle="${myResourceBundle}" /></FONT>
		</TH>
		<TH>
			<FONT SIZE=+1><fmt:message key="valueHeader" bundle="${myResourceBundle}" /></FONT>
		</TH>
	</TR>
	<c:forEach var="entry" items="${errorBean.exceptionData}">
		<TR>
			<TD><CENTER><c:out value="${entry.key}" /></CENTER></TD>
			<TD><CENTER><c:out value="${entry.value}" default="\"\"" /></CENTER></TD>
		</TR>
	</c:forEach>
</TABLE>
</CENTER>
</c:if>

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

