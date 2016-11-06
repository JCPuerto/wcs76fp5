<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP page displays the product details.  It shows the following information:
  *  - Full-sized image, name, and long description of the product
  *  - Discount description for the product, if available
  *  - Contract price and list price of the product
  *  - A list of defining attributes (such as size and color) if the product has variations, along with a list of values for each attribute (for example, red and blue for color or large and x-large for size)
  *  - Descriptive attributes, displayed as name:value
  *  - 'Quantity' box to enter the quantity (default is 1)
  *  - 'Add to shopping cart' button, 'Add to wish list' button for B2C stores, 'Add to Requisition List' button for B2B stores
  * This is an example of how this file could be included into a page: 
  *<c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedProductOnlyDisplay.jsp">
  *	        <c:param name="storeId" value="${storeId}"/>
  *	        <c:param name="catalogId" value="${catalogId}"/>
  *	        <c:param name="langId" value="${langId}"/>
  *	        <c:param name="productId" value="${productId}"/>
  *	        <c:param name="parent_category_rn" value="${parent_category_rn}"/>
  *	        <c:param name="shouldCachePage" value="${shouldCachePage}"/>
  *	    </c:import>
  *****
--%>

<!-- BEGIN CachedBundleDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%-- ErrorMessageSetup.jspf is used to retrieve an appropriate error message when there is an error --%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>
<%@ include file="../../../include/BrazilCommonESpots.jspf" %>

<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/CatalogArea/ProductDisplay.js"/>"></script>
<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/ServicesDeclaration.js"/>"></script>
<script type="text/javascript">
	dojo.addOnLoad(function() {
		ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
	});
</script>

<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>
<c:set var="replaceStr02" value="inches"/>
<c:set var="search" value='"'/>
<c:set var="replaceCmprStr" value=""/>

<c:set var="dragType" value="bundle"/>
<c:set var="displayPriceRange" value="true"/>

<c:set var="miniShopCartEnabled" value="false"/>
<flow:ifEnabled feature="miniShopCart">
	<c:set var="miniShopCartEnabled" value="true"/>
</flow:ifEnabled>

<c:set var="compareEnabled" value="false"/>
<flow:ifEnabled feature="ProductCompare">
	<c:set var="compareEnabled" value="true"/>
</flow:ifEnabled>

<c:set var="addProductDnD" value="false"/>
<flow:ifEnabled feature="ProductDnD">
	<c:if test="${miniShopCartEnabled || compareEnabled}">
		<c:set var="addProductDnD" value="true"/>
	</c:if>
</flow:ifEnabled>
<flow:ifEnabled feature="AjaxMyAccountPage">
	<script type="text/javascript">
		dojo.addOnLoad(function() {
			categoryDisplayJS.setAjaxMyAccount(true);
		});
	</script>
</flow:ifEnabled>
<flow:ifDisabled feature="AjaxMyAccountPage">
	<script type="text/javascript">
		dojo.addOnLoad(function() {
			categoryDisplayJS.setAjaxMyAccount(false);
		});
	</script>
</flow:ifDisabled>

<c:set var="catEntry" value="${catalogEntryDetails}" />
<c:set var="bundleId" value="${catEntry.uniqueID}" />
<c:set var="shortDescription" value="${catEntry.shortDescription}" />
<c:set var="longDescription" value="${catEntry.longDescription}" />
<c:set var="fullImage" value="${catEntry.fullImage}" />
<c:set var="thumbNail" value="${catEntry.thumbnail}" />
<c:set var="name" value="${catEntry.name}" />
<c:set var="buyable" value="${catEntry.buyable}" />
<c:set var="attachments" value="${catEntry.attachments}" />

<c:set var="patternName" value="ProductURLWithParentCategory"/>
<c:if test="${WCParam.parent_category_rn != WCParam.top_category}">
	<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
</c:if>

<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="productId" value="${bundleId}"/>
	<wcf:param name="langId" value="${WCParam.langId}"/>
	<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
	<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
	<wcf:param name="top_category" value="${WCParam.top_category}"/>
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<wcf:url var="CatalogAttachmentURL" value="CatalogAttachmentView">
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="productId" value="${productId}"/>
	<wcf:param name="catType" value="bundle"/>
	<wcf:param name="excludeUsageStr" value="ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40,IMAGE_SIZE_330,IMAGE_SIZE_1000"/>
	<wcf:param name="retrieveLanguageIndependentAtchAst" value="1"/>
	<wcf:param name="catEntryName" value="${catEntry.name}"/>
</wcf:url>

<%-- 
***
* Start:  Get all product and item IDs displayed on this page and pass them to the discount code
***
--%>
<%-- Create a comma delimited string containing all IDs to pass to the discount code.
	For an in depth explanation of why this is done, see DiscountJavaScriptSetup.jsp --%>
	<script type="text/javascript">
		var entitledItems = [];
	</script>
<c:set var="someItemIDs" value="" />

<c:forEach var="bundleComponent" items="${catEntry.components}" varStatus="status">
	<c:set var="bundleComponentDetails" value="${bundleComponent.catalogEntryView}" />
	<c:choose>
		<c:when test="${empty someItemIDs}">
			<c:set var="someItemIDs" value="${bundleComponentDetails.uniqueID}" />
		</c:when>	
		<c:otherwise>
			<c:set var="someItemIDs" value="${someItemIDs},${bundleComponentDetails.uniqueID}" />
		</c:otherwise>	
	</c:choose>	
	
	<c:if test="${bundleComponentDetails.catalogEntryTypeCode == 'ProductBean'}">
		<%-- retrieve SKU with defining attibutes for this product --%>
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="componentCatalogNavigationView"
			expressionBuilder="getCatalogEntryViewDetailsByID" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0">
			<wcf:param name="UniqueID" value="${bundleComponentDetails.uniqueID}"/>
			<wcf:contextData name="storeId" data="${WCParam.storeId}" />
			<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
		</wcf:getData>
		<c:set var="componentCatEntry" value="${componentCatalogNavigationView.catalogEntryView[0]}" />
	
		<script type="text/javascript">
			<c:choose>
				<c:when test="${componentCatEntry.numberOfSKUs == 1}">
					var item = new Object();
					item["catentry_id"] = "<c:out value='${componentCatEntry.SKUs[0].uniqueID}' />";
					item["Attributes"] = new Object();
					
					<c:forEach var="definingAttrValue2" items="${componentCatEntry.SKUs[0].attributes}" varStatus="innerStatus">
						<c:if test="${definingAttrValue2.usage == 'Defining'}">
							item["Attributes"]["<c:out value="${fn:replace(definingAttrValue2.name, search01, replaceStr01)}_${fn:replace(fn:replace(definingAttrValue2.values[0].value, search, replaceStr02), search01, replaceStr01)}" />"] = "<c:out value='${status.count}' />";
						</c:if>	
					</c:forEach>
					
					entitledItems.push(item);
					categoryDisplayJS.setDefaultItem('<c:out value='${componentCatEntry.uniqueID}'/>', '${componentCatEntry.SKUs[0].uniqueID}');		
				
				</c:when>
				<c:otherwise>
					<c:forEach var="entitledItem" items="${componentCatEntry.SKUs}" varStatus="status">
						var item = new Object();
						item["catentry_id"] = "<c:out value='${entitledItem.uniqueID}' />";
						item["Attributes"] = new Object();
						
						<c:forEach var="definingAttrValue2" items="${entitledItem.attributes}" varStatus="innerStatus">
							<c:if test="${definingAttrValue2.usage == 'Defining'}">
								item["Attributes"]["<c:out value="${fn:replace(definingAttrValue2.name, search01, replaceStr01)}_${fn:replace(fn:replace(definingAttrValue2.values[0].value, search, replaceStr02), search01, replaceStr01)}" />"] = "<c:out value='${status.count}' />";
							</c:if>	
						</c:forEach>
						entitledItems.push(item);
					</c:forEach>
					
					categoryDisplayJS.setDefaultItem('<c:out value='${componentCatEntry.uniqueID}'/>', '${componentCatEntry.SKUs[0].uniqueID}');
				</c:otherwise>
			</c:choose>
			categoryDisplayJS.setEntitledItems(entitledItems);
		</script>
	</c:if>
</c:forEach>

	
<%-- Pass the IDs to the discount JavaScript --%>
<%-- Flush the buffer so this fragment JSP is not cached twice --%>
<%out.flush();%>
<c:import url="${jspStoreDir}include/DiscountJavaScriptSetup.jsp">
	<c:param name="jsPrototypeName" value="Discount" />
	<c:param name="someProductIDs" value="${someProductIDs}"/>
	<c:param name="productIncludeChildItems" value="true"/>
	<c:param name="productIsProdPromoOnly" value="true"/>
	<c:param name="productIncludeParentProduct" value="false"/>
	
	<c:param name="someItemIDs" value="${someItemIDs}"/>
	<c:param name="itemIncludeChildItems" value="true"/>
	<c:param name="itemIsProdPromoOnly" value="false"/>
	<c:param name="itemIncludeParentProduct" value="false"/>
</c:import>
<%out.flush();%>

<%-- 
***
* End:  Get all product and item IDs displayed on this page and pass them to the discount code
***
--%>
<%-- remove double quote from shortdescription --%>
<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="bundleShortDesc" value="${fn:replace(shortDescription, search, replaceStr)}"/>
<div id="body588">
	<div id="product">
		<form name="OrderItemAddForm_<c:out value='${bundleId}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderItemAddForm_<c:out value='${bundleId}'/>">
			<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}" />" id="WC_CachedBundleDisplay_FormInput_langId_In_OrderItemAddForm_1"/>
			<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_CachedBundleDisplay_FormInput_storeId_In_OrderItemAddForm_1"/>
			<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_CachedBundleDisplay_FormInput_catalogId_In_OrderItemAddForm_1"/>
			<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="WC_CachedBundleDisplay_FormInput_URL_In_OrderItemAddForm_1"/>
			<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="WC_CachedBundleDisplay_FormInput_errorViewName_In_OrderItemAddForm_1"/>
			<%-- shouldCachePage is used to tell the server not to cache this page.  So if an error happens, this page is redrawn with an error message --%>
			<input type="hidden" name="shouldCachePage" value="false" id="WC_CachedBundleDisplay_FormInput_shouldCachePage_In_OrderItemAddForm_1"/>
			<input type="hidden" name="catEntryIDS" value="<c:out value='${someItemIDs}'/>" id="WC_CachedBundleDisplay_inputs_1"/>
			<input type="hidden" name="productId" value="<c:out value="${bundleId}" />" id="WC_CachedBundleDisplay_FormInput_productId_In_OrderItemAddForm_1"/>
			<input type="hidden" name="page" value="" id="WC_CachedBundleDisplay_FormInput_page_In_OrderItemAddForm_1"/>
			<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_CachedBundleDisplay_FormInput_calcUsage_In_OrderItemAddForm_1"/>
			<input type="hidden" name="updateable" value="0" id="WC_CachedBundleDisplay_FormInput_updateable_In_OrderItemAddForm_1"/>
			<flow:ifEnabled feature="SOAWishlist">
				<input type="hidden" name="giftListId" value="<c:out value='${giftListId}'/>" id="<c:out value='OrderItemAddForm_${bundleId}_giftListId_${giftListId}'/>"/>
			</flow:ifEnabled>	
			<div class="product_images" id="WC_CachedBundleDisplay_div_1">
				<c:if test="${addProductDnD eq 'true'}">
					<div dojoType="dojo.dnd.Source" jsId="dndSource" id="<c:out value='${bundleId}'/>" copyOnly="true" dndType="<c:out value='${dragType}'/>">
						<div class="dojoDndItem" dndType="<c:out value='${dragType}'/>" id="WC_CachedBundleDisplay_div_2">
				</c:if>
				<span class="product">
					<c:choose>
						<c:when test="${!empty fullImage}">
							<c:if test="${addProductDnD eq 'true'}">
								<!--[if lte IE 6.5]><iframe class="productPageDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
							</c:if>
							<img id="productMainImage"
								src="<c:out value="${fullImage}" />"
								alt="<c:out value="${requestScope.fullImageAltDescription}" escapeXml="false" />"
								title="<c:out value="${requestScope.fullImageAltDescription}" escapeXml="false"/>"
								border="0" width="160" height="160"/>
						</c:when>
						<c:otherwise>
							<c:if test="${addProductDnD eq 'true'}">
								<!--[if lte IE 6.5]><iframe class="productPageDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
							</c:if>
							<img id="productMainImage"
								src="<c:out value="${jspStoreImgDir}" />images/NoImageIcon.jpg"
								alt="<c:out value="${requestScope.fullImageAltDescription}" escapeXml="false" />"
								title="<c:out value="${requestScope.fullImageAltDescription}" escapeXml="false"/>"
								border="0" width="160" height="160"/>
						</c:otherwise>
					</c:choose>
				</span>

				<c:if test="${addProductDnD eq 'true'}">
						</div>
					</div>
					<script type="text/javascript">
						dojo.addOnLoad(function() { 
							var widgetText = "<c:out value="${bundleId}"/>";
							parseWidget(widgetText);
						});
					</script>
				</c:if>

					
				<%@ include file="AttachmentImagesDisplay.jspf"%>			
			
				<c:set var="compareImageDescription" value="${fn:replace(shortDescription, search, replaceCmprStr)}"/>
				<c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>

				<input type="hidden" id="compareImgPath_<c:out value='${bundleId}'/>" value="<c:out value='${productCompareImagePath}'/>"/>
				<input type="hidden" id="compareImgDescription_<c:out value='${bundleId}'/>" value="<c:out value='${compareImageDescription}'/>"/>
				<input type="hidden" id="compareProductDetailsPath_<c:out value='${bundleId}'/>" value="<c:out value='${catEntryDisplayUrl}'/>"/>		
				
				<br />
		
				<%-- 
				  ***
					* Start: Product angle images
					* Product angle images are loaded as attachments. Expected to have 2 sets loaded as 'ANGLEIMAGES_THUMBNAIL' and 'ANGLEIMAGES_FULLIMAGE'
					* attachment usages.
					***
				--%>
				
				<%-- 
				  ***
					*	End: Product angle images
					***
				--%>
				
				<%@ include file="CachedBundleImageExt.jspf"%>
			</div>
			<div class="product_options" id="WC_CachedBundleDisplay_div_3">
				 <h1 id="catalog_link" class="catalog_link"><c:out value="${name}" escapeXml="false"/></h1>
				 
				<%-- 
				  ***
				  *	Start: Discount details
				  ***
				--%>
				
				<div id="WC_CachedBundleDisplay_div_4">
					<wcbase:useBean id="discounts" classname="com.ibm.commerce.fulfillment.beans.CalculationCodeListDataBean" scope="page">
						<c:set property="catalogEntryId" value="${productId}" target="${discounts}" />
						<c:set property="includeParentProduct" value="true" target="${discounts}" />
						<c:set property="includeChildItems" value="true" target="${discounts}"/>
						
						<%-- UsageId for discount is -1 --%>
						<c:set property="calculationUsageId" value="-1" target="${discounts}" />
					</wcbase:useBean>
					<c:if test="${ !empty discounts.calculationCodeDataBeans }" >
						<c:forEach var="discountEntry" items="${discounts.calculationCodeDataBeans}" varStatus="discountCounter">
							<c:set var="hasDiscount" value="true"/>
							<c:url var="DiscountDetailsDisplayViewURL" value="DiscountDetailsDisplayView">
								<c:param name="code" value="${discountEntry.code}" />
								<c:param name="langId" value="${langId}" />
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${WCParam.catalogId}" />
							</c:url>
							<a class="discount" href="<c:out value='${DiscountDetailsDisplayViewURL}' />" id="WC_CachedBundleDiscount_Link_1_<c:out value="${discountCounter.count}"/>_<c:out value="${catEntryIdentifier}"/>"><c:out value="${discountEntry.descriptionString}" escapeXml="false" /></a>									
						</c:forEach>
					</c:if>
				</div>
				
				<%-- 
				  ***
				  *	End: Descount details
				  ***
				--%>
				
				<%-- 
				  ***
				  *	Start: Page action buttons
				  ***
				--%>
				<br />
				<c:choose>
					<c:when test="${buyable != 'false' || alwaysShowAddToCart}" >
						<flow:ifEnabled feature="AjaxAddToCart"> 
							<p>
								<span class="primary_button" >
									<span class="button_container">
										<span class="button_bg">
											<span class="button_top">
												<span class="button_bottom">   
													<a class="ajaxAddToCart" href="javascript:setCurrentId('bundlePageAdd2CartAjax'); categoryDisplayJS.AddBundle2ShopCartAjax(document.getElementById('OrderItemAddForm_<c:out value='${bundleId}'/>'))" id="bundlePageAdd2CartAjax"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
												</span>
											</span>	
										</span>
									</span>
								</span>	
						    </p>
							<br />
							<div class="features" id="WC_CachedBundleDisplay_div_7">
								<flow:ifEnabled feature="ProductCompare">
									<div class="tertiary_button_shadow">
										<div class="tertiary_button">
											<a id="WC_CachedBundleDisplay_links_4" href="JavaScript:compareProductJS.Add2CompareAjax('<c:out value='${bundleId}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');"><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a>
										</div>
									</div>
								</flow:ifEnabled>
								<flow:ifEnabled  feature="wishList">
									<div class="addToWishListButtonBorder">
										<div class="tertiary_button_shadow" id="addToWishListButton_1">
											<div class="tertiary_button left">
												<a id="WC_CachedBundleDisplay_links_5" href="javascript: setCurrentId('WC_CachedBundleDisplay_links_5'); categoryDisplayJS.AddBundle2WishListAjax(document.getElementById('OrderItemAddForm_<c:out value='${bundleId}'/>'))"><fmt:message key="WISHLIST" bundle="${storeText}" /> </a>
											</div>
										</div>
									</div>
								</flow:ifEnabled>
								<flow:ifEnabled  feature="SOAWishlist">
									<%out.flush();%>
										<c:import url="${jspStoreDir}Snippets/MultipleWishList/MultipleWishListButton.jsp">
											<c:param name="catEntryId" value="${bundleId}"/>	
											<c:param name="type" value="bundle"/>	
										</c:import>				
									<%out.flush();%>															
								</flow:ifEnabled>
								<flow:ifEnabled feature="RequisitionList">
									<c:set var="type" value="bundle" />
									<%@include file="../../../ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListLinks.jspf" %>
								</flow:ifEnabled>								
							 </div>		
						</flow:ifEnabled>
						
						<flow:ifDisabled feature="AjaxAddToCart">
							<p>
								<span class="primary_button" >
									<span class="button_container">
										<span class="button_bg">
											<span class="button_top">
												<span class="button_bottom">   
													<a href="#" onclick="javascript:setCurrentId('bundlePageAdd2Cart'); categoryDisplayJS.AddBundle2ShopCart(document.getElementById('OrderItemAddForm_<c:out value='${bundleId}'/>'));return false;" id="bundlePageAdd2Cart"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
												</span>
											</span>	
										</span>
									</span>
								</span>
							</p>
							<div class="features" id="WC_CachedBundleDisplay_div_10">
								<flow:ifEnabled feature="ProductCompare">
									<div class="tertiary_button_shadow">
										<div class="tertiary_button">
											<a id="WC_CachedBundleDisplay_links_7" href="JavaScript:compareProductJS.Add2CompareAjax('<c:out value='${bundleId}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');"><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a>
										</div>
									</div>	
								</flow:ifEnabled>
								<flow:ifEnabled  feature="wishList">
									<div class="addToWishListButtonBorder">
										<div class="tertiary_button_shadow" id="addToWishListButton_1">
											<div class="tertiary_button left">
												<a id="WC_CachedBundleDisplay_links_8" href="#" onclick="javascript: setCurrentId('WC_CachedBundleDisplay_links_8'); categoryDisplayJS.AddBundle2WishList(document.getElementById('OrderItemAddForm_<c:out value='${bundleId}'/>'));return false;"><fmt:message key="WISHLIST" bundle="${storeText}" /> </a>
											</div>
										</div>
									</div>
								</flow:ifEnabled>
								<flow:ifEnabled  feature="SOAWishlist">	
									<%out.flush();%>
										<c:import url="${jspStoreDir}Snippets/MultipleWishList/MultipleWishListButton.jsp">
											<c:param name="catEntryId" value="${bundleId}"/>	
											<c:param name="type" value="bundle"/>	
										</c:import>				
									<%out.flush();%>																									
								</flow:ifEnabled>
								<flow:ifEnabled feature="RequisitionList">
									<c:set var="type" value="bundle" />
										<%@include file="../../../ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListLinks.jspf" %>
								</flow:ifEnabled>										
							</div>
						</flow:ifDisabled>
					</c:when>
					<c:otherwise>
						<p><fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" /></p>
					
						<div>
							<span class="primary_button" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_CachedBundleDisplay_links_9"><fmt:message key="RETURN_SHOPPING" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>
						</div>
					</c:otherwise>
				</c:choose>
				<%@ include file="CachedBundleButtonExt.jspf"%>
				<%-- 
				  ***
				  *	End: Page action buttons
				  ***
				--%>
			</div>
			<br />
			<br clear="all" />
						
			<%@ include file="InstallmentOptionsBundle.jspf"%>

				
				<div id="WC_CachedPackageDisplay_div_15">
					<c:forEach var="bundleComponent" items="${catEntry.components}" varStatus="iStatus">
						<c:set var="bundleComponentDetails" value="${bundleComponent.catalogEntryView}"/>
						<c:set var="bundleComponentType" value="${fn:trim(bundleComponentDetails.catalogEntryTypeCode)}"/>

						<c:url var="ComponentDisplayURL" value="ProductDisplay">
							<c:param name="productId" value="${bundleComponentDetails.uniqueID}" />
							<c:param name="langId" value="${langId}" />
							<c:param name="storeId" value="${WCParam.storeId}" />
							<c:param name="catalogId" value="${WCParam.catalogId}" />
							<c:if test="${ !empty WCParam.parent_category_rn }" >
								<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
							</c:if>
						</c:url>
						
						<c:if test="${bundleComponentType == 'ProductBean'}">
							<c:set var="numberOfSKUs" value="${bundleComponentDetails.numberOfSKUs}"/>
							<h1><fmt:message key="PRODUCT_TITLE1" bundle="${storeText}"/> <c:out value="${bundleComponentDetails.name}" escapeXml="false"/></h1>
						</c:if>
						<c:if test="${bundleComponentType == 'ItemBean'}">
							<h1><fmt:message key="ITEM_TITLE1" bundle="${storeText}"/> <c:out value="${bundleComponentDetails.name}" escapeXml="false"/></h1>
						</c:if>
						<c:if test="${bundleComponentType == 'PackageBean'}">
							<h1><fmt:message key="PACKAGE_TITLE1" bundle="${storeText}"/> <c:out value="${bundleComponentDetails.name}" escapeXml="false"/></h1>
						</c:if>
						<div class="left package_img" id="WC_CachedBundleDisplay_div_16_<c:out value='${iStatus.count}'/>">
							<c:choose>
								<c:when test="${!empty bundleComponentDetails.thumbnail}">
									<a id="WC_CachedBundleDisplay_links_10_<c:out value='${iStatus.count}'/>" href="<c:out value="${ComponentDisplayURL}" escapeXml="false"/>">
										<img src="<c:out value="${hostPath}"/><c:out value="${bundleComponentDetails.thumbnail}"/>" alt="<c:out value="${bundleComponentDetails.shortDescription}" />" border="0" width="70" height="70"/>
									</a>
								</c:when>
								<c:otherwise>
									<a id="WC_CachedBundleDisplay_links_11_<c:out value='${iStatus.count}'/>" href="<c:out value="${ComponentDisplayURL}" escapeXml="false"/>" >
										<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0" width="70" height="70"/>
									</a>
								</c:otherwise>
							</c:choose>
						</div>

						<div class="left package_desc" id="WC_CachedBundleDisplay_div_17_<c:out value='${iStatus.count}'/>">
						<c:out value="${bundleComponentDetails.longDescription}" escapeXml="false" />
						
						<c:if test="${bundleComponentType == 'ItemBean'}">
							<br />	
							<span><fmt:message key="SKU" bundle="${storeText}" />:</span><span><c:out value="${bundleComponentDetails.partNumber}" /></span>
							<br />
							<script type="text/javascript">
								document.write(Discount.getItemDiscountText(<c:out value="${bundleComponentDetails.uniqueID}"/>));
							</script>
						</c:if>

						<br />
						<fmt:message key="PRODUCT_ATTRIBUTES" bundle="${storeText}" />:
						
						<c:if test="${bundleComponentType == 'ItemBean'}">
							<%--
							  ***
							  * Start: Display Defining and Descriptive attributes
							  * First, loop through the attribute values and display the defining attributes
							  * Then, display the item descriptive attributes and show the corresponding images if available
							  * If the item does not have descriptive attributes, get the attributes from the parent item.
							  ***
							--%>
							<c:set var="anyAttributes" value="false" />

							<c:forEach var="attributeItem" items="${bundleComponentDetails.attributes}">
								<c:if test="${ attributeItem.usage=='Descriptive' }" >
									<span><c:out value="${attributeItem.name}"  escapeXml="false" /> : </span>
									<span>
									<c:out value="${attributeItem.values[0].value}"  escapeXml="false" />
									</span>
									<br />
									<c:set var="anyAttributes" value="true" />											
								</c:if>
							</c:forEach>
							<c:forEach var="attributeItem" items="${bundleComponentDetails.attributes}">
								<c:if test="${ attributeItem.usage=='Defining' }" >
									<span><c:out value="${attributeItem.name}"  escapeXml="false" />:</span>
									<span>
									<c:choose>
										<c:when test="${ !empty attributeItem.extendedValue['Image1']  }" >
											<c:out value="${attributeItem.values[0].value}" escapeXml="false"  />&nbsp;<img src="<c:out value="${attributeItem.extendedValue['Image1']}" />" alt="<c:out value="${attributeItem.values[0].value}" />" border="0"/>
										</c:when>
										<c:otherwise >
											<c:out value="${attributeItem.values[0].value}"  escapeXml="false"  />
										</c:otherwise>
									</c:choose>
									</span>
									<br />
									<c:set var="anyAttributes" value="true" />
								</c:if>
							</c:forEach>		

							<c:if test="${!anyAttributes}">
								<span>
									<fmt:message key="ITEM_NO_ATTRIBUTES" bundle="${storeText}" />
								</span>
							</c:if>
						</c:if>
						<c:if test="${bundleComponentType == 'PackageBean'}">
							<c:set var="anyAttributes" value="false" />						
							<c:forEach var="attribute2" items="${bundleComponentDetails.attributes}">
								<c:if test="${ attribute2.usage=='Descriptive' }" >										
									<span class="productName"><c:out value="${attribute2.name}" escapeXml="false" />:</span>
									<span>											
									<c:choose>
										<c:when test="${ !empty attribute2.extendedValue['Image1']  }" >
											<c:out value="${attribute2.values[0].value}" escapeXml="false" />&nbsp;<img src="<c:out value="${attribute2.extendedValue['Image1']}" />" alt="<c:out value="${attribute2.values[0].value}" />" border="0"/><br/>												
										</c:when>
										<c:otherwise >
											<c:out value="${attribute2.values[0].value}" escapeXml="false" />
										</c:otherwise>
									</c:choose>
									</span>
									<br/>
									<c:set var="anyAttributes" value="true" />
								</c:if>
							</c:forEach>
							<c:if test="${!anyAttributes}">
								<span>
									<fmt:message key="PACKAGE_NO_ATTRIBUTES" bundle="${storeText}" />
								</span>
							</c:if>
						</c:if>
						<c:if test="${bundleComponentType == 'ProductBean'}">
							<c:choose>
								<c:when test="${bundleComponentDetails.numberOfSKUs == 1}">
									<c:forEach var="attribute" items="${bundleComponentDetails.SKUs[0].attributes}" varStatus="aStatus">
										<c:if test="${attribute.usage == 'Defining'}">
											<p>
												<c:out value="${fn:replace(attribute.name, search01, replaceStr01)}"/>: <c:out value="${fn:replace(attribute.values[0].value, search01, replaceStr01)}" />
												<!-- Register the attribute with categoryDisplayJS !-->
												<script type="text/javascript">
													categoryDisplayJS.setSelectedAttributeOfProduct("<c:out value='${bundleComponentDetails.uniqueID}'/>","<c:out value='${fn:replace(attribute.name, search01, replaceStr01)}'/>","<c:out value='${fn:replace(attribute.values[0].value, search01, replaceStr01)}' />");
												</script>
											</p>
										</c:if>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<%-- the drop down box will only display defining attributes --%>
									<c:forEach var="attribute" items="${bundleComponentDetails.attributes}" varStatus="aStatus">
										<c:if test="${attribute.usage == 'Defining'}">
											<div class="attribute_list">
												<span class="required">*</span><c:out value="${fn:replace(attribute.name, search01, replaceStr01)}"/>:
												<p>
												<label for="attrValue_<c:out value='${aStatus.count}'/>" class="nodisplay"><c:out value='${attribute.name}'/><fmt:message key='Checkout_ACCE_required' bundle='${storeText}'/></label>
												<select class="drop_down" id="attrValue_<c:out value='${aStatus.count}'/>" name="attrValue" 
														onChange='JavaScript:categoryDisplayJS.setSelectedAttributeOfProduct("<c:out value='${bundleComponentDetails.uniqueID}'/>","<c:out value='${fn:replace(attribute.name, search01, replaceStr01)}'/>",this.options[this.selectedIndex].value);'>
													<%-- Display the first option in the drop down as: Select Attribute.Name --%>
													<option value="">
														<fmt:message key="QuickInfo_Select" bundle="${storeText}"/>
													</option>
													<!-- Display product attribute values !-->
													<c:forEach var="allowedValue" items="${attribute.values}">
														<c:set var="displayValue" value="${allowedValue.value}" />
														<c:forEach var="extendedValue" items="${allowedValue.extendedValue}">
															<c:if test="${extendedValue.name == 'Field2'}">
																<c:set var="displayValue" value="${extendedValue.value}" />
															</c:if>
														</c:forEach>
														<%-- Reselect the attribute values the user selected, or select nothing if not selected. 
															 We rely on HTTP to preserve the order of the attributes submitted.  --%>
														<c:choose>
															<c:when test="${WCParamValues.attrValue[aStatus.count-1] == allowedValue.value}">
																<option selected="selected"><c:out value="${fn:replace(displayValue, search01, replaceStr01)}" /></option>
															</c:when>
															<c:otherwise>
																<option value="<c:out value="${fn:replace(fn:replace(allowedValue.value, search, replaceStr02), search01, replaceStr01)}" />">
																	<c:out value="${fn:replace(displayValue, search01, replaceStr01)}" />
																</option>
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
												<!-- Register the attribute with categoryDisplayJS !-->
												<script type="text/javascript">
													var selectBoxNode = dojo.byId("attrValue_<c:out value='${aStatus.count}'/>");
													categoryDisplayJS.setSelectedAttributeOfProduct("<c:out value='${bundleComponentDetails.uniqueID}'/>","<c:out value='${fn:replace(attribute.name, search01, replaceStr01)}'/>",selectBoxNode.options[selectBoxNode.selectedIndex].value);
												</script>
												</p>
											</div>
										</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							<%-- 
							  ***
							  *	End: Defining Attributes
							  ***
							--%>
							<%-- 
							  ***
							  * Start: Descriptive Attributes
							  * The code below is used to display the descriptive attributes and show the corresponding images if available
							  * Descriptive attributes are simply displayed as 'name:value'. They are not used for SKU resolution.					  
							  ***
							--%>
							<c:forEach var="attribute" items="${bundleComponentDetails.attributes}" varStatus="aStatus">
								<c:if test="${ attribute.usage=='Descriptive' }" >										
									<span class="productName" title="<c:out value="${attribute.description}" escapeXml="false" />"><c:out value="${attribute.name}" escapeXml="false" />:</span>											
									<c:choose>
										<c:when test="${ !empty attribute.extendedValue['Image1']  }" >
											<c:out value="${attribute.values[0].value}" escapeXml="false" />&nbsp;<img src="<c:out value="${attribute.extendedValue['Image1']}" />" alt="<c:out value="${attribute.values[0].value}" />" border="0"/><br/>												
										</c:when>
										<c:otherwise >
											<c:out value="${attribute.values[0].value}" escapeXml="false" />
										</c:otherwise>
									</c:choose>
									<br/>
								</c:if>
							</c:forEach>
							<br/>
							<%-- 
							  ***
							  *	End: Descriptive Attributes
							  ***
							--%>
						</c:if>
					</div>
					<br clear="all" />		
					
					<c:if test="${bundleComponentType == 'ItemBean'}">
						<c:set var="type" value="item"/>
						<c:set var="fromPage" value="bundleDisplayItem"/>
					</c:if>
					<c:if test="${bundleComponentType == 'ProductBean'}">
						<c:set var="type" value="product"/>
						<c:set var="fromPage" value="bundleDisplayProduct"/>
					</c:if>
					<c:if test="${bundleComponentType == 'PackageBean'}">
						<c:set var="type" value="item"/>
						<c:set var="fromPage" value="bundleDisplayItem"/>
					</c:if>			
											
					<c:if test="${displayListPriceInProductPage == 'true'}">
						<div class="left price bold" id="WC_CachedBundleDisplay_div_18_<c:out value='${iStatus.count}'/>">
							<fmt:message key="PRICE" bundle="${storeText}"/>
						</div>
						<div class="left" id="WC_CachedBundleDisplay_div_19_<c:out value='${iStatus.count}'/>">
							&nbsp;
						</div>
						<div class="left" id="WC_CachedBundleDisplay_div_20_<c:out value='${iStatus.count}'/>">
							<c:set var="priceHighlightable" value="true"/>
							<c:set var="catalogEntry" value="${bundleComponentDetails}"/>
							<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
						</div>
					<br clear="all" />
					</c:if>
					
					<div class="package_qty" id="WC_CachedBundleDisplay_div_21_<c:out value='${iStatus.count}'/>">
						<label for="quantity_<c:out value='${bundleComponentDetails.uniqueID}'/>"><fmt:message key="QuickInfo_Qty" bundle="${storeText}"/></label>:
						<c:if test="${bundleComponentType == 'ItemBean'}">
							<input type="hidden" name="partNumber_<c:out value="${iStatus.count}"/>" value="<c:out value="${bundleComponentDetails.partNumber}" />" id="WC_CachedBundleDisplay_FormInput_partNumber_<c:out value='${iStatus.count}'/>_In_OrderItemAddForm_1"/>
						</c:if>
						<fmt:parseNumber var="bundleComponentQuantity" integerOnly="true" value="${bundleComponent.quantity}"/>
						<input type="text" name="quantity_<c:out value='${iStatus.count}'/>" id="quantity_<c:out value='${bundleComponentDetails.uniqueID}'/>" size="1" value="<c:out value='${bundleComponentQuantity}'/>" style="height:15px; text-align: center; border: 1px solid #908D94"/>
						<input type="hidden" name="catEntryId_<c:out value='${iStatus.count}'/>" value="<c:out value='${bundleComponentDetails.uniqueID}'/>" id="catEntryId_<c:out value='${bundleComponentDetails.uniqueID}'/>"/>
						<input type="hidden" name="contractId_<c:out value='${iStatus.count}'/>" value="" id="contractId_<c:out value='${bundleComponentDetails.uniqueID}'/>"/>
					</div>
					
					<br />
					<br />
					<c:if test="${isBrazilStore}">
						<%-- Flush the buffer so this fragment JSP is not cached twice --%>
						<%-- Show Payment Discount promotion --%>
						<div id="WC_CachedBundleDisplay_eSpot_div_1" class="promo_price">
							<% out.flush(); %>
								<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
									 <c:param name="storeId" value="${WCParam.storeId}" />
									 <c:param name="catalogId" value="${WCParam.catalogId}" />
									 <c:param name="langId" value="${WCParam.langId}" />
									 <c:param name="emsName" value="${eSpotPaymentPromotion}" />
									 <c:param name="currentProductId" value="${bundleComponentDetails.uniqueID}" />
									 <c:param name="adclass" value="no_ad" />
									 <c:param name="showPaymentDiscountPromotion" value="true" />
								</c:import> 
							<% out.flush(); %>
						</div>
					</c:if>
					<c:if test="${bundleComponentType == 'ProductBean'}">
						<br />
						<script type="text/javascript">
							document.write(Discount.getProductDiscountText(<c:out value="${bundleComponentDetails.uniqueID}"/>));
						</script>
						<br />
					</c:if>
					<%@ include file="InstallmentOptions.jspf"%> 
					<c:if test="${isBrazilStore}">
						<%-- Show Qualified Free Shipping Promotion --%> 
						<% out.flush(); %>
							<div id="WC_CachedBundleDisplay_eSpot_FreeShipping_div_1">
								<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
									 <c:param name="storeId" value="${WCParam.storeId}" />
									 <c:param name="catalogId" value="${WCParam.catalogId}" />
									 <c:param name="langId" value="${WCParam.langId}" />
									 <c:param name="emsName" value="${eSpotFreeShipping}" />
									 <c:param name="currentProductId" value="${bundleComponentDetails.uniqueID}" />
									 <c:param name="adclass" value="no_ad" />
								</c:import> 
								<br />
							</div>
						<% out.flush(); %>
					</c:if>
					<c:if test="${bundleComponentType == 'ProductBean'}">
						<c:if test="${bundleComponentDetails.numberOfSKUs == 1}">
							<c:set var="forInventoryCatentryId" value="${bundleComponentDetails.SKUs[0].uniqueID}"/>
						</c:if>
					</c:if>

					<c:set var="catalogEntry" value="${bundleComponentDetails}"/>
					<%@ include file="B2BCatentryContractSelectExt.jspf"%>

					<c:choose>
						<c:when test="${bundleComponentType == 'ProductBean'}">					
							<%out.flush();%>
							<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryInventoryStatus.jsp">
								<c:param name="fromPage" value="${fromPage}"/>
								<c:param name="catentryId" value="${bundleComponentDetails.uniqueID}"/>
								<c:param name="catentryId" value="${forInventoryCatentryId}"/>
								<c:param name="numberOfSKUs" value="${numberOfSKUs}"/>					
							</c:import>
							<%out.flush();%>
						</c:when>
						<c:otherwise>
							<%out.flush();%>
							<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryInventoryStatus.jsp">
								<c:param name="fromPage" value="${fromPage}"/>
								<c:param name="catentryId" value="${bundleComponentDetails.uniqueID}"/>
							</c:import>
							<%out.flush();%>
						</c:otherwise>
					</c:choose>
					<c:if test="${bundleComponentType == 'ItemBean'}">
						<%@ include file="CatalogEntryInventoryStatusEIExt.jspf"%>
						<br />
						<script type="text/javascript">
							document.write(Discount.getItemDiscountText(<c:out value="${bundleComponentDetails.uniqueID}"/>));
						</script>
						<br />
					</c:if>
					
					<c:set var="runningCountInLoop" value="${iStatus.count}" />
					</c:forEach>
				</div>
				<br clear="all" />
						
			<input type="hidden" name="numberOfProduct" id="numberOfProduct" value='<c:out value="${runningCountInLoop}"/>'/>
		</form>
			<%-- 
			  ***
			  *	Start: Cross-Sell, Up-Sell, Accessory, Replacement
			  * Include MerchandisingAssociationsDisplay.jsp if Cross-Sell, Up-Sell, Accessory, Replacement are set up
			  ***
			--%>
			
			<%-- Flush the buffer so this fragment JSP is not cached twice --%>
			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Catalog/MerchandisingAssociations/MerchandisingAssociationsDisplay.jsp">
					<c:param name="catalogEntryType" value="BundleBean"/>
					<c:param name="pageView" value="image"/>
			</c:import>
			<%out.flush();%>
			
			<%-- 
			  ***										  
			  *	End: Cross-Sell, Up-Sell, Accessory, Replacement
			  ***
			--%>		
			<br clear="all" />
			<flow:ifDisabled feature="ProductDetailDescListView">
				<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("WC_CachedBundleDisplay_div_14"); });</script>
				<c:set var="productDescHeaderListView" value="nodisplay"/>			
			</flow:ifDisabled>
			<flow:ifEnabled feature="ProductDetailDescListView">
				<c:set var="productDescHeaderListView" value="productDescHeaderList"/>
				<c:set var="HideTabsForListview" value="nodisplay" />
			</flow:ifEnabled>			
			<div class="specs" id="WC_CachedBundleDisplay_div_14">
				 <div class="tabs ${HideTabsForListview}"  id="WC_CachedBundleDisplay_div_15">
					<span class="on" id="Description_On" style="display:inline">
						<span class="left_corner">&nbsp;</span>
						<span class="text"><fmt:message key="DESCRIPTION" bundle="${storeText}" /></span>
						<span class="right_corner">&nbsp;</span>
					 </span>
					 <span class="off" id="Description_Off" style="display:none">
						<span class="left_corner">&nbsp;</span>
						<a href="javascript:selectTab('Description');" class="catalog_link" id="WC_CachedProductOnlyDisplay_links_6">
							<span class="text"><fmt:message key="DESCRIPTION" bundle="${storeText}"/></span>
						</a>
						<span class="right_corner">&nbsp;</span>
					 </span>
					 <span class="on" id="Attachments_On" style="display:none">
						<span class="left_corner">&nbsp;</span>
						<span class="text"><fmt:message key="ATTACHMENTS" bundle="${storeText}" /></span>
						<span class="right_corner">&nbsp;</span>
					 </span>
					 <span class="off" id="Attachments_Off" style="display:inline">
						<span class="left_corner">&nbsp;</span>
						<a href="javascript:selectTab('Attachments');" class="catalog_link" id="WC_CachedProductOnlyDisplay_links_7">
							<span class="text"><fmt:message key="ATTACHMENTS" bundle="${storeText}"/></span>
						</a>
						<span class="right_corner">&nbsp;</span>
					 </span>
					 <span class="end"></span>
					<%@ include file="CachedBundleTabsExt.jspf"%>
				 </div>
				 <br/>
				 <div id="mainTabContainer" class="info" dojoType="dijit.layout.TabContainer" selectedTab="Description" doLayout="false">
					  <div id="Description" dojoType="dijit.layout.ContentPane" >
						<div class="${productDescHeaderListView}"><fmt:message key="DESCRIPTION" bundle="${storeText}" /></div>
					  	<p><c:out value="${shortDescription}" escapeXml="false"/></p><br />
							<p>
								<c:out value="${longDescription}" escapeXml="false"/>
							</p>
							<br />
							<%-- 
							  ***
							  *	Start: Descriptive Attributes
							  * Descriptive attributes are simply displayed as 'name:value'. They are not used for SKU resolution.
							  ***
							--%>
							<%-- The descriptive attributes of the bundle itself --%>
							
							
							<p>
							<c:set var="descAttrCount" value="0"/>
							<c:forEach var="attribute2" items="${catEntry.attributes}">
								<c:if test="${ attribute2.usage=='Descriptive' }" >	
									<c:set var="descAttrCount" value="${descAttrCount + 1}"/>
									<span class="productName" id="descAttributeName_${descAttrCount}"><c:out value="${attribute2.name}" escapeXml="false" />:</span>											
									<c:choose>
										<c:when test="${ !empty attribute2.extendedValue['Image1']  }" >
											<span id="descAttributeValue_${descAttrCount}"><c:out value="${attribute2.values[0].value}" escapeXml="false" />&nbsp;<img src="<c:out value="${attribute2.extendedValue['Image1']}" />" alt="<c:out value="${attribute2.values[0].value}" />" border="0"/></span><br/>												
										</c:when>
										<c:otherwise >
											<span id="descAttributeValue_${descAttrCount}"><c:out value="${attribute2.values[0].value}" escapeXml="false" /></span>
										</c:otherwise>
									</c:choose>
									<br/>
								</c:if>
							</c:forEach>
							</p>
							
							<%-- 
							  ***
							  *	End: Descriptive Attributes
							  ***
							--%>
					  </div>
					 <div id="Attachments" href="<c:out value='${CatalogAttachmentURL}'/>" parseOnLoad="false" dojoType="dijit.layout.ContentPane" >
						<div class="${productDescHeaderListView}"><fmt:message key="ATTACHMENTS" bundle="${storeText}" /></div>
						<flow:ifEnabled  feature="ProductDetailDescListView"> 
							<%out.flush();%> 
							<c:import url="${jspStoreDir}Snippets/Catalog/Attachments/CatalogAttachmentAssetsDisplay.jsp">  
								   <c:param name="storeId" value="${WCParam.storeId}"/>  
								   <c:param name="catalogId" value="${WCParam.catalogId}"/>  
								   <c:param name="langId" value="${langId}"/>  
								   <c:param name="productId" value="${bundleId}"/>  
								   <c:param name="catType" value="bundle"/>  
								   <c:param name="excludeUsageStr" value="ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,ANGLEIMAGES_HDIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40,IMAGE_SIZE_330,IMAGE_SIZE_1000"/>  
								   <c:param name="retrieveLanguageIndependentAtchAst" value="1"/>  
							</c:import>  
							<%out.flush();%> 
						</flow:ifEnabled>				  	
				  	 </div>
					  <%@ include file="CachedBundleTabPanesExt.jspf"%>
				 </div>
				 <div class="tabfooter" id="WC_CachedBundleDisplay_div_16"></div>
			</div>
	   </div>
	</div>
<!-- END CachedBundleDisplay.jsp -->
