<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2010 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP file renders the compare products page. It shows up to 4 products side-by-side showing comparisons
  * of price, brand, and all of its attributes.
  *****
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<%@ include file="../../../include/nocache.jspf"%>

<c:set var="compareProductPage" value="true" scope="request"/>
<c:set var="hasBreadCrumbTrail" value="true" scope="request"/>
<c:set var="useHomeRightSidebar" value="true" scope="request"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- BEGIN CompareProductsDisplay.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml"
xmlns:wairole="http://www.w3.org/2005/01/wai-rdf/GUIRoleTaxonomy#"
xmlns:waistate="http://www.w3.org/2005/07/aaa" lang="${shortLocale}" xml:lang="${shortLocale}">
<head>
<title><c:out value="${storeName}"/> - <fmt:message key="COMPARE_PAGE_TITLE" bundle="${storeText}"/></title>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheet}"/>" type="text/css"/>
<!--[if lte IE 6]>
<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${vfileStylesheetie}"/>" type="text/css"/>
<![endif]-->
<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
<%@ include file="../../../include/CommonJSToInclude.jspf"%>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CategoryDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/MessageHelper.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/CompareProduct.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript">
	dojo.addOnLoad(function() { 
		<fmt:message key="ERR_RESOLVING_SKU" bundle="${storeText}" var="ERR_RESOLVING_SKU" />
		<fmt:message key="QUANTITY_INPUT_ERROR" bundle="${storeText}" var="QUANTITY_INPUT_ERROR" />
		<fmt:message key="WISHLIST_ADDED" bundle="${storeText}" var="WISHLIST_ADDED" />
		<fmt:message key="SHOPCART_ADDED" bundle="${storeText}" var="SHOPCART_ADDED" />
		<fmt:message key="SHOPCART_REMOVEITEM" bundle="${storeText}" var="SHOPCART_REMOVEITEM" />
		<fmt:message key="ERROR_MESSAGE_TYPE" bundle="${storeText}" var="ERROR_MESSAGE_TYPE" />
		<fmt:message key="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" bundle="${storeText}" var="ERROR_CONTRACT_EXPIRED_GOTO_ORDER" />
		<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}" var="ERROR_RETRIEVE_PRICE">                                     
			<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
		</fmt:message>
		
		MessageHelper.setMessage("ERROR_RETRIEVE_PRICE", <wcf:json object="${ERROR_RETRIEVE_PRICE}"/>);
		MessageHelper.setMessage("ERR_RESOLVING_SKU", <wcf:json object="${ERR_RESOLVING_SKU}"/>);
		MessageHelper.setMessage("QUANTITY_INPUT_ERROR", <wcf:json object="${QUANTITY_INPUT_ERROR}"/>);
		MessageHelper.setMessage("WISHLIST_ADDED", <wcf:json object="${WISHLIST_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_ADDED", <wcf:json object="${SHOPCART_ADDED}"/>);
		MessageHelper.setMessage("SHOPCART_REMOVEITEM", <wcf:json object="${SHOPCART_REMOVEITEM}"/>);
		MessageHelper.setMessage("ERROR_MESSAGE_TYPE", <wcf:json object="${ERROR_MESSAGE_TYPE}"/>);
		MessageHelper.setMessage("ERROR_CONTRACT_EXPIRED_GOTO_ORDER", <wcf:json object="${ERROR_CONTRACT_EXPIRED_GOTO_ORDER}"/>);
		categoryDisplayJS.setCommonParameters('<c:out value="${WCParam.langId}"/>','<c:out value="${WCParam.storeId}"/>','<c:out value="${WCParam.catalogId}"/>','${userType}');
		ServicesDeclarationJS.setCommonParameters('<c:out value="${WCParam.langId}"/>','<c:out value="${WCParam.storeId}"/>','<c:out value="${WCParam.catalogId}"/>');
		compareProductJS.setCommonParameters('<c:out value="${WCParam.langId}"/>','<c:out value="${WCParam.storeId}"/>','<c:out value="${WCParam.catalogId}"/>');
	});
</script>
</head>

<body>

<%@ include file="../../../include/StoreCommonUtilities.jspf"%>

<!-- Page Start -->
<div id="page">
	<%@ include file="../../../include/LayoutContainerTop.jspf"%>
	<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryQuickInfoDetails.jspf" %>
	
  	<!-- Main Content Start -->
  	<div id="content_wrapper_box">
    	<!-- Content Start -->
    	<div id="content588">
			<%@ include file="../../../include/MessageDisplay.jspf"%>
			<h1><fmt:message key="COMPARE_PAGE_TITLE" bundle="${storeText}"/></h1>
		    <div id="box">
		    	<div class="contentgrad_header" id="WC_CompareProductsDisplay_div_1">
		        	<div class="left_corner" id="WC_CompareProductsDisplay_div_2"></div>
		          	<div class="left" id="WC_CompareProductsDisplay_div_3"><span class="text"><fmt:message key="COMPARE_PRODUCT_TITLE" bundle="${storeText}"/></span></div>
		         	<div class="right_corner" id="WC_CompareProductsDisplay_div_4"></div>
		          	<br clear="all" />
		        </div>
		        <div class="body588" id="WC_CompareProductsDisplay_div_5">
			        <div class="static_pages_line" id="WC_CompareProductsDisplay_div_6"></div>
			        <div id="compare_body">
			        	<c:forEach var="parameter" items="${WCParamValues}" >
							<c:if test="${parameter.key == 'catentryId'}">
									<c:set var="catEntryIDs" value="${parameter.value}"/>
							</c:if>
						</c:forEach>
						<c:if test="${!empty catEntryIDs}">
							<table id ="compare_details" border="0" cellspacing="0" cellpadding="0" style="border-collapse: collapse">
								
								   	<jsp:useBean id="catEntryMap" class="java.util.HashMap" scope="request"/>
									<jsp:useBean id="catalogEntryDB2Map" class="java.util.HashMap" scope="request"/>
									<jsp:useBean id="brandMap" class="java.util.HashMap" scope="request"/>
									<jsp:useBean id="descriptionMap" class="java.util.HashMap" scope="request"/>
									<jsp:useBean id="typeMap" class="java.util.HashMap" scope="request"/>
									<c:set var="featureList" value="" />
									<c:set var="definingAttributeList" value="" />

									<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
											expressionBuilder="getCatalogEntryViewPriceWithAttributesByID" varShowVerb="showCatalogNavigationView" maxItems="${fn:length(catEntryIDs)}" recordSetStartNumber="0" scope="request">
										<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="counter">
											<wcf:param name="UniqueID" value="${catEntryID}" />
										</c:forEach>
										<wcf:contextData name="storeId" data="${WCParam.storeId}" />
										<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
									</wcf:getData>
									<c:forEach var="catEntry" items="${catalogNavigationView.catalogEntryView}" varStatus="counter">
											<c:set var="catEntryID" value="${catEntry.uniqueID}" />
											<c:set var="manufacturer" value="${catEntry.manufacturer}" />
											<c:set var="name" value="${catEntry.name}" />
											<c:choose>
												<c:when test="${catEntry.catalogEntryTypeCode eq 'ProductBean'}">
													<c:set var="typeName" value="product"/>
												</c:when>
												<c:when test="${catEntry.catalogEntryTypeCode eq 'ItemBean'}">
													<c:set var="typeName" value="item"/>
												</c:when>
												<c:when test="${catEntry.catalogEntryTypeCode eq 'BundleBean'}">
													<c:set var="typeName" value="bundle"/>
												</c:when>
												<c:when test="${catEntry.catalogEntryTypeCode eq 'PackageBean'}">
													<c:set var="typeName" value="package"/>
												</c:when>
												<c:otherwise>
												</c:otherwise>
											</c:choose>
											<c:set target="${catEntryMap}" property="${catEntryID}" value="${catEntry}"/>
											<c:set target="${brandMap}" property="${catEntryID}" value="${catEntry.manufacturer}"/>
											<c:set target="${descriptionMap}" property="${catEntryID}" value="${catEntry.name}"/>
											<c:set target="${typeMap}" property="${catEntryID}" value="${typeName}"/>

											<c:forEach var="attribute" items="${catEntry.attributes}" varStatus="status">	
												<c:if test="${ attribute.comparable=='true' }" >
													<c:choose>
														<c:when test="${empty featureList}">
															<c:set var="featureList" value="${attribute.name}" />
														</c:when>
														<c:when test="${!empty featureList && !fn:contains(featureList,attribute.name)}">
															<c:set var="featureList" value="${featureList},${attribute.name}" />
														</c:when>
													</c:choose>		
												</c:if>	
												<c:if test="${ attribute.usage=='Defining' }" >
													<c:choose>
														<c:when test="${empty definingAttributeList}">
															<c:set var="definingAttributeList" value="${attribute.name}" />
														</c:when>
														<c:when test="${!empty definingAttributeList && !fn:contains(definingAttributeList,attribute.name)}">
															<c:set var="definingAttributeList" value="${definingAttributeList},${attribute.name}" />
														</c:when>
													</c:choose>		
												</c:if>	
											</c:forEach>
										

										<c:remove var="catEntry"/>
									</c:forEach>
									
									<tr>
										<td class="feature" id="WC_CompareProductsDisplay_td_1">&nbsp;</td>
										<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="counter">
											<c:forEach var="catEntrys" items="${catEntryMap}">
													<c:if test="${catEntrys.key == catEntryID}">
														<c:set var="catEntry" value="${catEntrys.value}"/>													
													</c:if>
											</c:forEach>
											<td id="WC_CompareProductsDisplay_td_2_${counter.count}">
												<a href="javaScript: compareProductJS.remove('${catEntryID}');" id="WC_CompareProductsDisplay_link_1_${counter.count}">
													
													
													<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />table_x_delete.png" alt="<c:out value="${catEntry.name}" />" />
													
													<fmt:message key='COMPARE_REMOVE' bundle='${storeText}'/>
												</a>
											</td>		
										</c:forEach>
									</tr>
									
									<tr>
										<td class="feature" id="WC_CompareProductsDisplay_td_3"><fmt:message key='COMPARE_PRODUCT_IMAGE' bundle='${storeText}'/></td>										
											
											
										
										<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="counter">
											<c:remove var="attributes"/>
											<c:forEach var="catEntrys" items="${catEntryMap}">
													<c:if test="${catEntrys.key == catEntryID}">
														<c:set var="catEntry" value="${catEntrys.value}"/>
														<c:set var="catEntryIdentifier" value="${catEntry.uniqueID}"/>
														<c:set var="attributes" value="${catEntry.attributes}"/>
													</c:if>
											</c:forEach>
											<c:set var="pageView" value="imageForCompare"/>
											<c:set var="prefix" value="compare"/>

											<%@ include file="../../../Snippets/ReusableObjects/CatalogEntrySearchThumbnailDisplay.jspf" %>
										</c:forEach>
									</tr>									
									
									<tr>
										<td class="feature" id="WC_CompareProductsDisplay_td_4"><fmt:message key='PRODUCT_TITLE' bundle='${storeText}'/></td>
										<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="status">
											<td id="WC_CompareProductsDisplay_td_5_${status.count}">
												<c:forEach var="desc" items="${descriptionMap}">
													<c:if test="${desc.key == catEntryID}">
														<%-- The URL that links to the display page --%>
														<wcf:url var="catEntryDisplayUrl" patternName="ProductURLWithCategory" value="Product2">
															<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
															<wcf:param name="storeId" value="${WCParam.storeId}"/>
															<wcf:param name="productId" value="${catEntryID}"/>
															<wcf:param name="langId" value="${langId}"/>
															<wcf:param name="errorViewName" value="ProductDisplayErrorView"/>
															<wcf:param name="categoryId" value="${WCParam.categoryId}" />
															<wcf:param name="urlLangId" value="${urlLangId}" />
														</wcf:url>
														<span><a id="product_${catEntryID}_compareZoneLink" href="<c:out value="${catEntryDisplayUrl}"/>"><c:out value="${desc.value}"/></a></span>
													</c:if>
												</c:forEach>
											</td>
										</c:forEach>
									</tr>
								
									<tr>
										<td class="feature" id="WC_CompareProductsDisplay_td_6"><fmt:message key="COMPARE_PRODUCT_PRICE" bundle="${storeText}"/></td>
										<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="status">
											<td class="price" id="WC_CompareProductsDisplay_td_7_${status.count}">
												<c:set var="executeExtensionFragment" value="false"/>
												<%@ include file="CompareProductsDisplayExt.jspf"%>
												<c:if test="${!executeExtensionFragment}">
													
													
													<c:set var="catEntryMapToUse" value="${catEntryMap}" />
													
													<c:forEach var="catalogEntryDB2" items="${catEntryMapToUse}">
														<c:if test="${catalogEntryDB2.key == catEntryID}">
															<c:set var="catalogEntry" value="${catalogEntryDB2.value}" />										
															<c:set var="displayPriceRange" value="true"/>
															<c:forEach var="catalogEntryType" items="${typeMap}">
																<c:if test="${catalogEntryType.key == catEntryID}">
																	<c:set var="type" value="${catalogEntryType.value}"/>
																</c:if>
															</c:forEach>																	
														</c:if>
													</c:forEach>
													<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf" %>	
												</c:if>
											</td>
										</c:forEach>
									</tr>				
						
									<tr>
										<td class="feature" id="WC_CompareProductsDisplay_td_8"><fmt:message key="COMPARE_PRODUCT_BRAND" bundle="${storeText}"/></td>
										<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="status">
											<td id="WC_CompareProductsDisplay_td_9_${status.count}">
												<c:forEach var="brandEntry" items="${brandMap}">
													<c:if test="${brandEntry.key == catEntryID}">
														<c:out value="${brandEntry.value}" escapeXml="false"/>
													</c:if>
												</c:forEach>
											</td>
										</c:forEach>
									</tr>

									<c:set var="delim" value="," />
									<c:set var="featureArray" value="${fn:split(featureList, delim)}" />

									<c:forEach var="token" items="${featureArray}" varStatus="count">
										<c:if test="${!empty token}" >	
											<tr>
												<td class="feature" id="WC_CompareProductsDisplay_td_10_${count.count}"><c:out value="${token}" escapeXml="false" /></td>
												<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="counter">	
													<c:set var="flag" value="false" />
													<c:forEach var="catEntrys" items="${catEntryMap}">
															<c:if test="${catEntrys.key == catEntryID}">
																<c:set var="catalogEntry" value="${catEntrys.value}"/>													
															</c:if>
													</c:forEach>
													<c:forEach var="attribute" items="${catalogEntry.attributes}" varStatus="status">
														<c:if test="${ attribute.comparable=='true' && attribute.name == token && !empty attribute.values[0].value}" >		
															<td id="WC_CompareProductsDisplay_td_11_${count.count}_${status.count}"><img src="<c:out value="${jspStoreImgDir}${vfileColor}" />i_checkmark.png" alt="<fmt:message key="COMPARE_CHECKMARK_IMAGE" bundle="${storeText}"/>" border="0"/></td>
															<c:set var="flag" value="true" />
														</c:if>													
													</c:forEach>
													<c:if test="${flag == 'false'}">
														<td id="WC_CompareProductsDisplay_td_12_${count.count}_${status.count}">&nbsp;</td>	
													</c:if>
												</c:forEach>
											</tr>
										</c:if>	
									</c:forEach>

									<c:set var="definingAttributeArray" value="${fn:split(definingAttributeList, delim)}" />
									<c:forEach var="token1" items="${definingAttributeArray}" varStatus="count">
										<c:if test="${!empty token1}" >
											<tr>
												<td class="feature" id="WC_CompareProductsDisplay_td_10a_${count.count}"><c:out value="${token1}" escapeXml="false" /></td>
												<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="counter">
													<c:set var="flag1" value="false" />
													<c:forEach var="catEntrys" items="${catEntryMap}">
															<c:if test="${catEntrys.key == catEntryID}">
																<c:set var="catalogEntry1" value="${catEntrys.value}"/>													
															</c:if>
													</c:forEach>
													<c:forEach var="attribute" items="${catalogEntry1.attributes}" varStatus="status">
														<c:if test="${attribute.usage=='Defining' && attribute.name == token1 && !empty attribute.values[0].value}" >
															<td id="WC_CompareProductsDisplay_td_11a_${count.count}_${status.count}">
																<c:forEach var="attributeValue" items="${attribute.values}" varStatus="status2">
																	<c:out value="${attributeValue.value}" /><c:if test='${!status2.last}'><c:out value="," /></c:if>
																</c:forEach>
															</td>
															<c:set var="flag1" value="true" />																			
														</c:if>											
													</c:forEach>
													<c:if test="${flag1 == 'false'}">
														<td id="WC_CompareProductsDisplay_td_12a_${count.count}_${status.count}">&nbsp;</td>	
													</c:if>
												</c:forEach>
											</tr>
										</c:if>
									</c:forEach>
								
									
								
								<tr>
									<td class="last_row" id="WC_CompareProductsDisplay_td_19">&nbsp;</td>
									<c:forEach var="catEntryID" items="${catEntryIDs}" varStatus="counter">
										<td class="last_row" id="WC_CompareProductsDisplay_td_20_${counter.count}">&nbsp;</td>
									</c:forEach>
								</tr>
							</table>
						</c:if>
						<c:if test="${empty catEntryIDs}">  
		        			<div id="WC_CompareProductsDisplay_div_7">&nbsp;</div>
		        		 		<fmt:message key='COMPARE_PRODUCT_EMPTY' bundle='${storeText}'/>
		        		 	<div id="WC_CompareProductsDisplay_div_8">&nbsp;</div>
		        		</c:if>
		          	</div>   
		        </div>
        		<div class="footer" id="WC_CompareProductsDisplay_div_9">
          		<div class="left_corner" id="WC_CompareProductsDisplay_div_10"></div>
          		<div class="left" id="WC_CompareProductsDisplay_div_11"></div>
          		<div class="right_corner" id="WC_CompareProductsDisplay_div_12"></div>
        	</div>
          	<input id="compareProductPage" name="compareProductPage" type="hidden" value="<c:out value='${compareProductPage}'/>" />
      	</div>
      	<!-- Content End -->
    </div>
    <!-- Main Content End -->
      
</div>
<!-- Page End -->
	<%@ include file="../../../include/LayoutContainerBottom.jspf"%>
</div>
<div id="page_shadow" class="shadow"></div>
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>
<!-- END CompareProductsDisplay.jsp -->
