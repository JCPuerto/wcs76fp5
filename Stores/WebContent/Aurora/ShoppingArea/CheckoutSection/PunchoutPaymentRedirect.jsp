<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- 
  *****
  * This JSP file is used to redirect the browser to a punchout payment portal web page.
  * It is mapped to PunchoutPaymentRedirectView.
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>  
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>

<wcf:getData type="com.ibm.commerce.order.facade.datatypes.OrderType" var="order" expressionBuilder="findPunchoutPaymentInformation">
	<wcf:param name="orderId" value="${param.orderId}" />
	<wcf:param name="piId" value="${param.piId}" />
</wcf:getData>
<c:set var="url" value="${order.orderPaymentInfo.paymentInstruction[0].userData.userDataField['punchoutPopupURL']}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
	<head>
		<title><fmt:message key="PUNCHOUT_PAYMENT_REDIRECT" bundle="${storeText}"/></title>
		<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
		<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
		<%@ include file="../../Common/CommonJSToInclude.jspf"%>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CheckoutArea/CheckoutHelper.js"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
		<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
		<script type="text/javascript" src="<c:out value='${jsAssetsDir}javascript/CheckoutArea/Punchout.js'/>"></script>
	</head>
	<body id="punchout_payment_redirect_page">
		<c:set var="escapeXml" value="false"/>
		<c:if test="${fn:indexOf(url, '<form') != 0}">
			<c:set var="escapeXml" value="true"/>
		</c:if>
		<div id="punchout_payment_redirect" style="display:none;"><c:out value="${url}" escapeXml="${escapeXml}" /></div>
		
		<script type="text/javascript">
			dojo.addOnLoad(function(){
				cursor_clear();
				PunchoutJS.pay(<wcf:out value="${param.orderId}" escapeFormat="js"/>, <wcf:out value="${param.piId}" escapeFormat="js"/>, "punchout_payment_redirect", true);
			});
		</script>
	</body>
</html>
