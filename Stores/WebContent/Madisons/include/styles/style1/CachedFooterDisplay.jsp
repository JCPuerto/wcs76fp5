<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2005, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP page displays the Footer in all content pages that include the Layout Container JSP fragments.
  *****
--%>

<!-- BEGIN CachedFooterDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../JSTLEnvironmentSetup.jspf"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>  

<%@page import="com.ibm.commerce.bi.BIConfigRegistry"%>

<flow:ifDisabled feature="AjaxMyAccountPage">
	<wcf:url var="TrackOrderStatusURL" value="NonAjaxTrackOrderStatus">
		<wcf:param name="storeId"   value="${param.storeId}"  />
		<wcf:param name="catalogId" value="${param.catalogId}"/>
		<wcf:param name="langId" value="${param.langId}" />
	</wcf:url>
</flow:ifDisabled>
<flow:ifEnabled feature="AjaxMyAccountPage">
	<wcf:url var="OrderStatusURL" value="AjaxLogonForm">
	  <wcf:param name="langId" value="${param.langId}" />
	  <wcf:param name="storeId" value="${param.storeId}" />
	  <wcf:param name="catalogId" value="${param.catalogId}" />
	  <wcf:param name="page" value="orderstatus" />
	</wcf:url>							
</flow:ifEnabled>
<wcf:url var="MyAccountURL" value="AjaxLogonForm">
  <wcf:param name="langId" value="${param.langId}" />
  <wcf:param name="storeId" value="${param.storeId}" />
  <wcf:param name="catalogId" value="${param.catalogId}" />
  <wcf:param name="myAcctMain" value="1" />
</wcf:url>
<flow:ifEnabled feature="AjaxMyAccountPage">
	<wcf:url var="WishListDisplayURL" value="AjaxLogonForm">
		<wcf:param name="storeId"   value="${param.storeId}"  />
		<wcf:param name="catalogId" value="${param.catalogId}"/>
		<wcf:param name="langId" value="${param.langId}" />
		<wcf:param name="listId" value="." />    
		<wcf:param name="page" value="customerlinkwishlist"/>
	</wcf:url>
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxMyAccountPage">
	<wcf:url var="WishListDisplayURL" value="NonAjaxAccountWishListDisplayView">
		<wcf:param name="storeId"   value="${param.storeId}"  />
		<wcf:param name="catalogId" value="${param.catalogId}"/>
		<wcf:param name="langId" value="${param.langId}" />
		<wcf:param name="listId" value="." />           
	</wcf:url>
</flow:ifDisabled>
<wcf:url var="HelpContactViewURL" patternName="HelpContactUsURL" value="Help">
	<wcf:param name="langId" value="${param.langId}" />
	<wcf:param name="storeId" value="${param.storeId}" />
	<wcf:param name="catalogId" value="${param.catalogId}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<wcf:url var="PrivacyViewURL" patternName="PrivacyURL" value="PrivacyPolicy">
	<wcf:param name="langId" value="${param.langId}" />
	<wcf:param name="storeId" value="${param.storeId}" />
	<wcf:param name="catalogId" value="${param.catalogId}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>
<wcf:url var="SiteMapURL" patternName="SitemapURL" value="SiteMap">
	<wcf:param name="langId" value="${param.langId}" />
	<wcf:param name="storeId" value="${param.storeId}" />
	<wcf:param name="catalogId" value="${param.catalogId}" />
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<c:set var="interestItemDisplayURL" value="${WishListDisplayURL}"/>

 <div id="footer" class="footer-box">
	  <div class="left" id="WC_CachedFooterDisplay_div_1">
			<p class="sidebar_header strong"><fmt:message key="FOOTER_CUSTOMER_SERVICE" bundle="${storeText}" /></p>
			<p>
			<flow:ifEnabled feature="TrackingStatus">
				<flow:ifEnabled feature="AjaxMyAccountPage">
					<a href="<c:out value="${OrderStatusURL}"/>" class="h_tnav_but" id="WC_CachedFooterDisplay_Link_1"><fmt:message key="FOOTER_ORDER_STATUS" bundle="${storeText}" /></a>
				</flow:ifEnabled>
				<flow:ifDisabled feature="AjaxMyAccountPage">
					<a href="<c:out value="${TrackOrderStatusURL}"/>" class="h_tnav_but" id="WC_CachedFooterDisplay_Link_1"><fmt:message key="FOOTER_ORDER_STATUS" bundle="${storeText}" /></a>
				</flow:ifDisabled>
			</flow:ifEnabled>
			</p>
			<p>
				<flow:ifEnabled feature="wishList">
					<a href="${interestItemDisplayURL}" id="WC_CachedFooterDisplay_link_3"><fmt:message key="FOOTER_WISH_LIST" bundle="${storeText}" />
					</a>
				</flow:ifEnabled>
				<flow:ifEnabled feature="SOAWishlist">
					<a href="${interestItemDisplayURL}" id="WC_CachedFooterDisplay_link_3"><fmt:message key="FOOTER_WISH_LIST" bundle="${storeText}" />
					</a>
				</flow:ifEnabled>	
			</p>
			
			<p><a href="${MyAccountURL}" id="WC_CachedFooterDisplay_link_4"><fmt:message key="FOOTER_MY_ACCOUNT" bundle="${storeText}" /></a></p>
			
	  </div>
	  <div id="WC_CachedFooterDisplay_div_2" class="left">
		   <p class="sidebar_header strong"><fmt:message key="FOOTER_CUSTOMER_SUPPORT" bundle="${storeText}" /></p>
		   <p><a href="${PrivacyViewURL}" id="WC_CachedFooterDisplay_link_5"><fmt:message key="FOOTER_PRIVACY_POLICY" bundle="${storeText}" /></a></p>
		   <p><a href="${HelpContactViewURL}" id="WC_CachedFooterDisplay_link_6"><fmt:message key="FOOTER_HELP" bundle="${storeText}" /></a></p>
		   <p><a href="${SiteMapURL}" id="WC_CachedFooterDisplay_link_7"><fmt:message key="FOOTER_SITE_MAP" bundle="${storeText}" /></a></p>
		   <!--
		   <p><a href="#" tabindex="-1" id="WC_CachedFooterDisplay_links_8"></a></p>
		   -->
	  </div>
	  
	  <!-- Brazil - Display form of payments-->
	  <%@ include file="CachedFooterDisplayPaymentExt.jspf" %> 
 </div>
 
 <%-- 
 Display the Coremetrics tags at the bottom of the store page for debugging purpose.
 The tags are displayed only if the 'debug' attribute is set to true in the config file.
 --%>
 <flow:ifEnabled feature="Analytics">
	<%
	CommandContext commandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
	Integer storeId = commandContext.getStoreId();
	%>
 	<c:set var="debug">
		<%= BIConfigRegistry.getInstance().isDebug(storeId) %>
	</c:set>	
	<c:if test="${debug == 'true'}">
		<div id="cm-tag-output">
		 	<div id="cm-pageview"></div>
		 	<div id="cm-productview"></div>
			<div id="cm-shopAction"></div>
		 	<div id="cm-order"></div>
		 	<div id="cm-registration"></div>
		 	<div id="cm-element"></div>
	 	</div>
	</c:if>	
 </flow:ifEnabled>

<!-- END CachedFooterDisplay.jsp -->
