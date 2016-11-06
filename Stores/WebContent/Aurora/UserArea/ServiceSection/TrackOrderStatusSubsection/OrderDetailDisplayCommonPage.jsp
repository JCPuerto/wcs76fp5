<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN OrderDetailDisplayCommonPage.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>    
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="myAccountPage" value="true" scope="request"/>

<wcf:url var="trackOrderStatusURL" value="AjaxTrackOrderStatus" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />   
</wcf:url>
<!--MAIN CONTENT STARTS HERE-->
<flow:ifEnabled feature="SideBySideIntegration">
		<c:choose>
			<c:when test="${!empty WCParam.externalOrderId}">
				<% out.flush(); %>
					<c:import url="../../../Snippets/Order/SterlingIntegration/SBSOrderDetails.jsp" >
					</c:import>
				<% out.flush(); %>
			</c:when>
			<c:otherwise>
				<% out.flush(); %>
					<c:import url="../../../Snippets/Order/Ship/OrderShipmentDetails.jsp" >
						<c:param name= "showCurrentCharges" value= "true"/>
						<c:param name= "showFutureCharges"  value= "true"/>
					</c:import>
				<% out.flush();%>
			</c:otherwise>
		</c:choose>
	</flow:ifEnabled>
	<flow:ifDisabled feature="SideBySideIntegration">
		<% out.flush(); %>
			<c:import url="../../../Snippets/Order/Ship/OrderShipmentDetails.jsp" >
				<c:param name= "showCurrentCharges" value= "true"/>
				<c:param name= "showFutureCharges"  value= "true"/>
			</c:import>
		<% out.flush();%>
	</flow:ifDisabled>	
		
<!-- END OrderDetailDisplayCommonPage.jsp -->
