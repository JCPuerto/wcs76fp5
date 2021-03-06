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
<flow:ifEnabled feature="Analytics">
	<%
	CommandContext commandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
	Integer storeId = commandContext.getStoreId();
	boolean hostedVar = BIConfigRegistry.getInstance().useHostedLibraries(storeId);
	%>
	<c:set var="hostedVar" value="<%=hostedVar%>"/>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Analytics.js"/>"></script>
	<script type="text/javascript">
	dojo.addOnLoad(function() {
		analyticsJS.storeId=<c:out value="${storeId}"/>;
		analyticsJS.catalogId=<c:out value="${catalogId}"/>;
		analyticsJS.loadShopCartHandler();
		analyticsJS.loadPagingHandler();
		analyticsJS.loadProductQuickInfoHandler('productIdQuickInfo');
		analyticsJS.loadStoreLocatorPageViews();
		analyticsJS.loadWishlistHandler();
		dojo.require("wc.analytics.CoremetricsEventListener");		
			(new wc.analytics.CoremetricsEventListener()).load(<c:out value="${hostedVar}"/>);
			});
	</script>
	
</flow:ifEnabled>
<script>
	var isGuest = ${userType == 'G'};
</script>
<div class="header_wrapper" role="banner">
	<!--For border customization -->
	<div class="header_top">
		<div class="left_border"></div>
		<div class="middle"></div>
		<div class="right_border"></div>
	</div>
	<!-- Main Header Area -->
	<div class="header_left_shadow">
		<div class="header_right_shadow">				
			<div class="header">
				<!-- Start Header Content -->
				
				<!-- Start Masthead -->
				<div id="masthead">
					<div class="top"></div>
					<div class="content">
						<!-- Masthead Logo Widget -->
						<div class="widget_masthead_logo_position">
							<div id="widget_masthead_logo1">
								<%out.flush();%>
									<c:import url="${env_jspStoreDir}Widgets/ESpot/ContentRecommendation/ContentRecommendation.jsp">
										<c:param name="storeId" value="${storeId}" />
										<c:param name="catalogId" value="${catalogId}" />
										<c:param name="marketingSpotBehavior" value="0" /> <%-- Cache this espot always..It just display the store logo --%>
										<c:param name="emsName" value="HeaderStoreLogo_Content" />
										<c:param name="contentClickUrl" value="${env_TopCategoriesDisplayURL}"/>
									</c:import>
								<%out.flush();%>
							</div>
						</div>
						<!-- End Masthead Logo Widget -->
						
						<!-- Masthead Links Widget -->
						<div class="widget_masthead_links_position" role="navigation">
							<div id="widget_masthead_links">
								<div class="left">
									<div id="masthead_espot">
										<%out.flush();%>
											<c:import url="${env_jspStoreDir}Widgets/ESpot/ContentRecommendation/ContentRecommendation.jsp">
												<c:param name="storeId" value="${storeId}" />
												<c:param name="catalogId" value="${catalogId}" />
												<c:param name="emsName" value="HeaderCenter_Content" />
											</c:import>
										<%out.flush();%>									
									</div>																		
									<div class="masthead_links">
										<div class="content">
											<span class="masthead_links_container">
												<c:if test="${userType ne 'G'}">
													<span class="masthead_links_item"><a id="MyAccountLink" href="${MyAccountURL}"><fmt:message key="HEADER_MY_ACCOUNT"/></a></span> <fmt:message key="DIVIDING_BAR"/>
												</c:if>
												<flow:ifEnabled feature="SOAWishlist">
													<span class="masthead_links_item"><a id="ShoppingListDisplayLink" href="${WishListDisplayURL}"><fmt:message key="HEADER_SHOPPING_LIST"/></a></span> <fmt:message key="DIVIDING_BAR"/>
												</flow:ifEnabled>
												<%out.flush();%>
													<c:import url="${env_jspStoreDir}Widgets/LanguageCurrency/LanguageCurrency.jsp"/>
												<%out.flush();%>
												<span class="masthead_links_item"><a id="${SIGN_IN_OUT_ID}" href="${Logon_LogoutURL}">${SIGN_IN_OUT}</a></span>
											</span>
										</div>
									</div>
									<div class="masthead_social">
										<div class="content">
											<span class="masthead_links_container">
												<%--Display Facebook Connect Links  --%>
										        <flow:ifEnabled feature="FacebookIntegration">
													<span class="masthead_links_item">		
														<%out.flush();%>
														<c:import url="${env_jspStoreDir}Widgets/FacebookConnect/FacebookConnect.jsp"/>
														<%out.flush();%>
													</span><fmt:message key="DIVIDING_BAR"/>
	                                	        </flow:ifEnabled>
												<span class="masthead_links_item"><c:out value='${storeInfoContactTelephone}'/></span>
												<flow:ifEnabled feature="StoreLocator">
													<fmt:message key="DIVIDING_BAR"/>
													<span class="masthead_links_item"><a id="StoreLocatorLink" href="${StoreLocatorView}"><fmt:message key="HEADER_STORE_LOCATOR"/></a></span>
												</flow:ifEnabled>
											</span>
										</div>
									</div>												
								</div>
								<div class="right" style="display:none;">
									<div class="social_avatar">
									</div>
								</div>
								<div class="clear_float"></div>
							</div>
						</div>
						<!-- End Masthead Links Widget -->

						<!-- MiniShopCart Widget -->
						<div class="widget_minishopcart_position">
							
								<%out.flush();%>
									<c:import url = "${env_jspStoreDir}Widgets/MiniShopCartDisplay/MiniShopCartDisplayRefresh.jsp" />
								<%out.flush();%>
							
						</div>
						<!-- End MiniShopCart Widget -->

					</div>
					<div class="navigation">
						<!-- Department Selection Widget -->
						<div class="widget_departments_position" role="navigation" aria-label="<fmt:message key="DEPARTMENTS"/>">
							<%out.flush();%>
								<c:import url = "${env_jspStoreDir}Widgets/Department/DepartmentRefresh.jsp" />
							<%out.flush();%>
						</div>
						<!-- End Department Selection Widget -->

						<!-- Search Widget -->
						<div id="searchComponent">
							<%-- Search component is cached separately. So import this component instead of including it inline --%>
							<%out.flush();%>
								<c:import url = "${env_jspStoreDir}Widgets/Search/Search.jsp" />
							<%out.flush();%>
						</div>
						<!-- End Search Widget -->
					</div>			
					<div class="header_espot_container">		
						<%out.flush();%>
						<c:import url="${env_jspStoreDir}Widgets/ESpot/ContentRecommendation/ContentRecommendation.jsp">
							<c:param name="emsName" value="HeaderBanner_Content" />
							<c:param name="numberContentPerRow" value="2" />
							<c:param name="catalogId" value="${catalogId}" />
						</c:import>
						<%out.flush();%>
					</div>					
				</div>
				<!-- End Masthead -->
				
				<!-- End Header Content -->
			</div>
		</div>				
	</div>
	<!--For border customization -->
	<div class="header_bottom">
		<div class="left_border"></div>
		<div class="middle"></div>
		<div class="right_border"></div>
	</div>
</div>
<div id="productIdQuickInfo" style="display:none"></div>
