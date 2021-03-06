<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@page import="com.ibm.commerce.bi.BIConfigRegistry"%>
<%@page import="com.ibm.commerce.command.CommandContext" %>
<%@page import="com.ibm.commerce.server.ECConstants" %>


<div class="footer_wrapper" role="contentinfo">
	<!--For border customization -->
	<div class="footer_top">
		<div class="left_border"></div>
		<div class="middle"></div>
		<div class="right_border"></div>
	</div>
	<!--Main footer Area -->
	<div class="footer_left_shadow">
		<div class="footer_right_shadow">				
			<div class="footer_content" id="footer_content">
				
				<!--Start Footer Content -->
				<div id="footer">
					<div class="footer_element_container right_border large">
						<h2><fmt:message key="FOOTER_CUSTOMER_SERVICE" /></h2>
						<ul>
							<flow:ifEnabled feature="QuickOrder">
								<li><a id="FooterQuickOrder" href="<c:out value='${QuickOrderURL}'/>"><fmt:message key="FOOTER_QUICK_ORDER"/></a></li>
							</flow:ifEnabled>
							<li><a id="FooterHelpLink" href="<c:out value='${HelpViewURL}'/>"><fmt:message key="FOOTER_HELP"/></a></li>
							<li><a id="FooterContactUsLink" href="<c:out value='${ContactUsViewURL}'/>"><fmt:message key="FOOTER_CONTACT_US"/></a></li>
							<li><a id="FooterReturnPolicyLink" href="<c:out value='${ReturnPolicyViewURL}'/>"><fmt:message key="FOOTER_RETURN_POLICY"/></a></li>
							<li><a id="FooterPrivacyPolicyLink" href="<c:out value='${PrivacyViewURL}'/>"><fmt:message key="FOOTER_PRIVACY_POLICY"/></a></li>
						</ul>
							
					</div>
					<div class="footer_element_container right_border large">
						<h2><fmt:message key="FOOTER_CORPORATE_INFO" /></h2>
						<ul>
							<li><a id="FooterAboutUsLink" href="<c:out value='${CorporateInfoViewURL}'/>"><fmt:message key="FOOTER_ABOUT_US"/></a></li>
							<li><a id="FooterCorporateContactUsLink" href="<c:out value='${CorporateContactUsViewURL}'/>"><fmt:message key="FOOTER_CONTACT_US"/></a></li>
							<flow:ifEnabled feature="StoreLocator">
								<li><a id="FooterStoreLocatorLink" href="<c:out value='${StoreLocatorURL}'/>"><fmt:message key="FOOTER_STORE_LOCATOR"/></a></li>
							</flow:ifEnabled>
						</ul>							
					</div>
					
					<div class="footer_element_container right_border large" id="WC_Footer_UI_Links_3">
						<h2><fmt:message key="FOOTER_EXPLORE" /></h2>
						<ul>
							<li><a id="FooterSiteMapLink" href="<c:out value='${SiteMapURL}'/>"><fmt:message key="FOOTER_SITE_MAP"/></a></li>
							<c:if test="${env_mobileStoreSupport == true}">
								<li><a id="FooterVisitMobileStoreLink" href="${mobileHome}"><fmt:message key="FOOTER_VISIT_MOBILE_STORE"/></a></li>
							</c:if>
							<flow:ifEnabled feature="CoShopping">
								<li><a id="FooterCoShoppingLink" href="javascript:void(0);"><fmt:message key="FOOTER_CO_SHOPPING"/></a></li>
							</flow:ifEnabled>
						</ul>
					</div>
					
					<flow:ifEnabled feature="FacebookIntegration">
						<div class="footer_element_container large" id="FooterSocialLinks">
							<h2><fmt:message key="FOOTER_FOLLOW_US" /></h2>
							<ul>
								<li><a id="FacebookLink" href="<c:out value='${facebookURL}'/>"><fmt:message key="FOOTER_FACEBOOK"/></a></li>
							</ul>
						</div>
					</flow:ifEnabled>
					
					<div class="footer_element_container large" id="FooterRightContentESpot">					
						<%out.flush();%>
							<c:import url = "${env_jspStoreDir}Widgets/ESpot/ContentRecommendation/ContentRecommendation.jsp">
								<c:param name="storeId" value="${storeId}" />
								<c:param name="catalogId" value="${catalogId}" />
								<c:param name="emsName" value="FooterRight_Content" />
								<c:param name="fromPage" value="footer" />
							</c:import>
						<%out.flush();%>	
					</div>					
												
				</div>
				<!--End Footer Content -->
				
			</div>
		</div>				
	</div>
	<!--For border customization -->
	<div class="footer_bottom">
		<div class="left_border"></div>
		<div class="middle">
		</div>
		<div class="right_border"></div>
	</div>
	<%@ include file="../../Common/PageExt.jspf" %>
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
			<div id="cm-conversionevent"></div>
	 	</div>
	</c:if>	
 </flow:ifEnabled>
