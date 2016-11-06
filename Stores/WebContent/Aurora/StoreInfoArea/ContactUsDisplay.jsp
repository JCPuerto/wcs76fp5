<!DOCTYPE HTML>

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

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../Common/EnvironmentSetup.jspf" %>
<%@ include file="../include/ErrorMessageSetup.jspf" %>
<%@ include file="../Common/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>

<wcf:getData type="com.ibm.commerce.infrastructure.facade.datatypes.OnlineStoreType"
			var="onlineStoreSEO" 
			expressionBuilder="findSEOPageDefintionByPageNameAndStoreID">
		<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
		<wcf:param name="storeId" value="${WCParam.storeId}"/>
		<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		<wcf:param name="pageName" value="HELP_PAGE"/>
		<wcf:param name="accessProfile" value="IBM_Store_SEOPageDefinition_Details"/>
</wcf:getData>

<!-- BEGIN Help.jsp -->
<html lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
	<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>	
	<%@ include file="../Common/CommonJSToInclude.jspf" %>
	
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}"/>" type="text/css"/>
	<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/Search.js"></script>
	<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/MiniShopCartDisplay/MiniShopCartDisplay.js"></script>
	<script type="text/javascript" src="${jsAssetsDir}javascript/Widgets/Department/Department.js"></script>		
	<script type="text/javascript" src="${jsAssetsDir}javascript/Common/ShoppingActions.js"></script>	
			
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><c:out value="${onlineStoreSEO.SEOPageDefinitions[0].title}"/></title>
	<meta name="description" content="<c:out value="${onlineStoreSEO.SEOPageDefinitions[0].metaDescription}"/>"/>
	<meta name="keyword" content="<c:out value="${onlineStoreSEO.SEOPageDefinitions[0].metaKeyword}"/>"/>
</head>

<body>

<%@ include file="../Common/CommonJSPFToInclude.jspf"%>

<div id="page">
	<!-- Import Header Widget -->
	<div class="header_wrapper_position" id="headerWidget">
		<%out.flush();%>
		<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
		<%out.flush();%>
	</div>
	<!-- Header Nav End -->

			<!--Start Page Content-->
			<div class="content_wrapper_position" role="main">
				<div class="content_wrapper">
					<!--For border customization -->
					<div class="content_top">
						<div class="left_border"></div>
						<div class="middle"></div>
						<div class="right_border"></div>
					</div>
					<!-- Main Content Area -->
					<div class="content_left_shadow">
						<div class="content_right_shadow">				
							<div class="main_content">
								<!-- Start Main Content -->
														
								<!-- Static Page Content -->
								<div class="container_static_full_width container_margin_5px"> 
									
									<div class="static_page_content">
										<div class="page_header" role="heading" aria-level="1"><fmt:message key="FOOTER_CONTACT_US" /></div>
										<div class="content_box">
											<div class="header_top"><fmt:message key="CONTACT_MAIN" /></div>
											<div class="item_spacer_5px"></div>
											<div class="item_spacer_10px"></div>
											<%out.flush();%>
												<c:import url="${env_jspStoreDir}Widgets/ESpot/ContentRecommendation/ContentRecommendation.jsp">
													<c:param name="emsName" value="ContactUsCenter_Content" />
													<c:param name="numberContentPerRow" value="1" />
													<c:param name="substitutionName1" value="[storeName]"/>
													<c:param name="substitutionValue1" value="${storeName}"/>
												</c:import>
											<%out.flush();%>
												
										</div>
									</div>
									
									<div class="clear_float"></div>
								</div>
								<!-- End Static Page Content -->
								
								<!-- End Main Content -->
							</div>
						</div>				
					</div>

					<!--For border customization -->
					<div class="content_bottom">
						<div class="left_border"></div>
						<div class="middle"></div>
						<div class="right_border"></div>
					</div>
				</div>
			</div>
			<!--End Page Content-->


	<!-- Footer Start -->
	<div class="footer_wrapper_position">
		<%out.flush();%>
			<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
		<%out.flush();%>
	</div>
	<!-- Footer End -->
</div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
<!-- END Help.jsp -->
