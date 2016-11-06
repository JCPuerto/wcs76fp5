<%
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2008
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>
<%-- 
  *****
  * This e-mail will be sent to the person with whom the user wants to share his wishlist.
  * This email JSP page contins the link which will take him to the shared wish list page.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../include/JSTLEnvironmentSetup.jspf"%>

<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="eHostPath" />
<c:set value="${eHostPath}${jspStoreImgDir}" var="jspStoreImgDir" />


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- BEGIN InterestItemListNotify.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<title><fmt:message key="WISHLIST_TITLE" bundle="${storeText}"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

	<table width="792" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;">
		<%@ include file="EmailHeader.jspf"%> 
		<tr>
			<td width="12" style="border-left: 1px solid #c9d3de;"></td>
			<td width="770" valign="top" style="font-family: Verdana, Arial; font-size: 14px; color: #59677d;">		
				<span style="font-weight: bold;"><fmt:message key="MA_SUBSCRIPTIONS" bundle="${storeText}"/></span>
				<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="hostPath" />
				<c:set value="/webapp/wcs/stores/servlet/" var="webPath" />
					<br clear="all"/>
					<br clear="all"/>
					<c:if test="${!empty WCParam.StatusReasonCode}">
						<br/><br/>
						<c:choose>
							<c:when test="${WCParam.StatusReasonCode == 7}">
								<fmt:message key="CANCEL_SUBSCRIPTION_FAILURE_MESSAGE" bundle="${storeText}">
									<fmt:param><c:out value="${WCParam.subscriptionId}"/></fmt:param>
								</fmt:message>
							</c:when>
							<c:when test="${WCParam.StatusReasonCode == 8 || WCParam.StatusReasonCode == 9}">
								<fmt:message key="SUBSCRIPTION_FAILURE_MESSAGE" bundle="${storeText}">
									<fmt:param><c:out value="${WCParam.subscriptionId}"/></fmt:param>
								</fmt:message>
							</c:when>
							<c:otherwise>
								<fmt:message key="CANCEL_SUBSCRIPTION_MESSAGE" bundle="${storeText}">
									<fmt:param><c:out value="${WCParam.subscriptionId}"/></fmt:param>
								</fmt:message>
							</c:otherwise>
						</c:choose>
						<fmt:message key="${WCParam.subscriptionMessage}" bundle="${storeText}"/>
						<br/>
					</c:if>	
				<br/>			
			</td>
			<td width="12" style="border-right: 1px solid #c9d3de;"></td>
		</tr>
		<tr>
			<td colspan="3" style="border-left: 1px solid #c9d3de; border-right: 1px solid #c9d3de; font-size: 11px;">&nbsp;</td>
		</tr>
		<%@ include file="EmailFooter.jspf"%>
	</table>
</body>
</html>

<!-- END InterestItemListNotify.jsp -->
