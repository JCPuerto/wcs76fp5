<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">

<%@include file="BrowserCacheControl.jsp" %> 

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<fmt:setLocale value="${WCParam.locale}"/>
<fmt:setBundle basename="com.ibm.commerce.stores.preview.properties.StorePreviewer" var="resources" />


<c:url var="previewstoreurl" value="${fn:replace(WCParam.redirectstoreurl, '~~amp~~', '&')}" />

<c:url var="headerurl" value="PreviewStoreHeader" >
	<c:if test="${!(empty WCParam.start)}">
		<c:param name="start" value="${WCParam.start}" />
	</c:if>
	<c:param name="status" value="${WCParam.status}" />
	<c:param name="invstatus" value="${WCParam.invstatus}" />
	<c:param name="locale" value="${WCParam.locale}" />
	<c:param name="timeZoneId" value="${WCParam.timeZoneId}" />	
	<c:param name="dateFormat" value="${WCParam.dateFormat}" />	
	<c:param name="timeFormat" value="${WCParam.timeFormat}" />	
	<c:param name="includedMemberGroupIds" value="${WCParam.includedMemberGroupIds}" />
	<c:param name="previewstoreurl" value="${previewstoreurl}"/>
</c:url>


<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="${pageContext.request.locale.language}" lang="${pageContext.request.locale.language}">
	<head> 
		<title><fmt:message key="storePreviewTopFrameTitle" bundle="${resources}" /></title>  
	</head> 
	<frameset rows ="137,*" id="previewFrames">
		<frame src="<c:out value="${headerurl}"/>" title="<fmt:message key="storePreviewHeaderFrameTitle" bundle="${resources}" />" frameborder="1" noresize="noresize"/>
		<frame src="<c:out value="${previewstoreurl}"/>" title="<fmt:message key="storePreviewBodyFrameTitle" bundle="${resources}" />" frameborder="0" noresize="noresize" scrolling="auto"/> 
	</frameset>	
</html>