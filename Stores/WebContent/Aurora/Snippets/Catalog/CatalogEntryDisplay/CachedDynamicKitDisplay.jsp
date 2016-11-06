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
  * This JSP page displays the dynamic kit details.  It shows the following information:
  *  - Full-sized image, name, and long description of the dynamic kit
  *  - Discount description for the dynamic kit, if available
  *  - Pre-Configured price of the dynamic kit
  *  - Descriptive attributes, displayed as name:value
  *  - 'Quantity' box to enter the quantity (default is 1)
  *  - 'Add to shopping cart' button, 'Add to wish list' button for B2C stores, 'Add to Requisition List' button for B2B stores
  * This is an example of how this file could be included into a page: 
  *<c:import url="../../../Snippets/Catalog/CatalogEntryDisplay/CachedDynamicKitDisplay.jsp">
  *	        <c:param name="storeId" value="${storeId}"/>
  *	        <c:param name="catalogId" value="${catalogId}"/>
  *	        <c:param name="langId" value="${langId}"/>
  *	        <c:param name="productId" value="${productId}"/>
  *	        <c:param name="parent_category_rn" value="${parent_category_rn}"/>
  *	        <c:param name="shouldCachePage" value="${shouldCachePage}"/>
  *	    </c:import>
  *****
--%>

<!-- BEGIN CachedDynamicKitDisplay.jsp -->
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
<c:set var="search" value='"'/>
<c:set var="replaceCmprStr" value=""/>
<c:set var="search01" value="'"/>

<c:set var="buyable" value="true"/>
<c:set var="fromPage" value="dynamicKitDisplay"/>

<c:set var="miniShopCartEnabled" value="false"/>
<flow:ifEnabled feature="miniShopCart">
	<c:set var="miniShopCartEnabled" value="true"/>
</flow:ifEnabled>

<c:set var="compareEnabled" value="false"/>

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

<c:set var="dragType" value="dynamicKit"/>

<c:set var="patternName" value="ProductURLWithParentCategory"/>
<c:if test="${WCParam.parent_category_rn != WCParam.top_category}">
	<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
</c:if>
<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="productId" value="${catalogEntryView.uniqueID}"/>
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
	<wcf:param name="productId" value="${catalogEntryView.uniqueID}"/>
	<wcf:param name="catType" value="dynamicKit"/>
	<wcf:param name="excludeUsageStr" value="ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40,IMAGE_SIZE_330,IMAGE_SIZE_1000"/>
	<wcf:param name="retrieveLanguageIndependentAtchAst" value="1"/>
	<wcf:param name="catEntryName" value="${catalogEntryView.name}"/>
</wcf:url>

<c:set var="showAddToCart" value="${alwaysShowAddToCart || (catalogEntryView.buyable && !empty catalogEntryView.components  && !empty catalogEntryView.price)}"/>
<c:set var="showConfigure" value="${catalogEntryView.buyable && !empty catalogEntryView.dynamicKitModelReference}"/>
<c:set var="noModelReference" value="${catalogEntryView.buyable && empty catalogEntryView.dynamicKitModelReference}"/>

<%-- catalogEntry is used in the CatalogEntryPriceDisplay.jspf snippet --%>
<c:set var="catalogEntry" value="${catalogEntryView}"/>

<%-- Show 'price pending' if this kit is not pre-configured --%>
<c:set var="showPricePending" value="${empty catalogEntryView.components}"/>

<c:set var="showMA" value="${showAddToCart }"/>
<%-- 
***
* Start:  Get all dynamic kit and item IDs displayed on this page and pass them to the discount code
***
--%>
	<%-- Create a comma delimited string containing all IDs to pass to the discount code.
		For an in depth explanation of why this is done, see DiscountJavaScriptSetup.jsp --%>
	<c:set var="someItemIDs" value="" />
	<c:forEach var="componentsInDK" items="${catalogEntryView.components}" varStatus="status">
		<c:choose>
			<c:when test="${empty someItemIDs}">
				<c:set var="someItemIDs" value="${componentsInDK.catalogEntryView.uniqueID}" />
			</c:when>	
			<c:otherwise>
				<c:set var="someItemIDs" value="${someItemIDs},${componentsInDK.catalogEntryView.uniqueID}" />
			</c:otherwise>	
		</c:choose>
	</c:forEach>
	
	<%-- Pass the IDs to the discount JavaScript --%>
	<%-- Flush the buffer so this fragment JSP is not cached twice --%>
	<%out.flush();%>
	<c:import url="${jspStoreDir}include/DiscountJavaScriptSetup.jsp">
		<c:param name="jsPrototypeName" value="Discount" />
		<c:param name="someProductIDs" value="${productId}"/>
		<c:param name="productIncludeChildItems" value="true"/>
		<c:param name="productIsProdPromoOnly" value="false"/>
		<c:param name="productIncludeParentProduct" value="false"/>
		
		<c:param name="someItemIDs" value="${someItemIDs}"/>
		<c:param name="itemIncludeChildItems" value="true"/>
		<c:param name="itemIsProdPromoOnly" value="false"/>
		<c:param name="itemIncludeParentProduct" value="false"/>
	</c:import>
	<%out.flush();%>
<%-- 
***
* End:  Get all dynamic kit and item IDs displayed on this page and pass them to the discount code
***
--%>
<%-- remove double quote from shortdescription --%>
<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="dynamicKitShortDesc" value="${fn:replace(catalogEntryView.shortDescription, search, replaceStr)}"/>

<div id="body588">
   <div id="product">
		<div class="product_images" id="WC_CachedDynamicKitDisplay_div_1">
			<c:if test="${addProductDnD eq 'true'}">
				<div dojoType="dojo.dnd.Source" jsId="dndSource" id="<c:out value='${catalogEntryView.uniqueID}'/>" copyOnly="true" dndType="<c:out value='${dragType}'/>">
					<div class="dojoDndItem" dndType="<c:out value='${dragType}'/>" id="WC_CachedDynamicKitDisplay_div_2">
			</c:if>
			<span class="product">
				<c:choose>
					<c:when test="${!empty catalogEntryView.fullImage}">
						<c:if test="${addProductDnD eq 'true'}">
							<!--[if lte IE 6.5]><iframe class="productPageDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
						</c:if>
						<img id="productMainImage"
							src="<c:out value="${catalogEntryView.fullImage}" />"
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
					var widgetText = "<c:out value="${catalogEntryView.uniqueID}"/>";
					parseWidget(widgetText);
				});
				</script>
			</c:if>
			
			<c:set var="thumbNail" value="${catalogEntryView.thumbnail}" />
			<c:set var="attachments" value="${catalogEntryView.attachments}" />
			<%@ include file="AttachmentImagesDisplay.jspf"%>

			<c:set var="compareImageDescription" value="${fn:replace(catalogEntryView.shortDescription, search, replaceCmprStr)}"/>
			<c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>
			 <input type="hidden" id="compareImgPath_<c:out value='${catalogEntryView.uniqueID}'/>" value="<c:out value='${productCompareImagePath}'/>"/>
			 <input type="hidden" id="compareImgDescription_<c:out value='${catalogEntryView.uniqueID}'/>" value="<c:out value='${compareImageDescription}'/>"/>
			 <input type="hidden" id="compareProductDetailsPath_<c:out value='${catalogEntryView.uniqueID}'/>" value="<c:out value='${catEntryDisplayUrl}'/>"/>
			<br />
		
			<%@ include file="CachedDynamicKitImageExt.jspf"%>
		</div>
		<div class="product_options" id="WC_CachedDynamicKitDisplay_div_3">
			<h1 class="catalog_link"><c:out value="${catalogEntryView.name}" escapeXml="false"/></h1>
				 
			<%-- in Elite, we do not want to show the price because the price may be different depending on the 
			contract that is selected --%>
			<c:if test="${displayListPriceInProductPage == 'true'}">			
				<div id="WC_CachedDynamicKitDisplay_div_4">
					<c:choose>
						<c:when test="${!showPricePending}">
							<span class="price bold"><fmt:message key="PRICE_DK" bundle="${storeText}"/></span>
							<c:set var="type" value="dynamicKit"/>
							<c:set var="dynamicKitprice" value="${catalogEntryView.price[0]}"/>
							<c:set var="displayPriceRange" value="false"/>
							<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
						</c:when>
						<c:otherwise>
							<span class="price bold"><fmt:message key="PRICE_PENDING" bundle="${storeText}"/></span>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>
			 
			<c:if test="${isBrazilStore}">
				<%-- Flush the buffer so this fragment JSP is not cached twice --%>
				<%-- Show Payment Discount promotion --%>
				<div id="WC_CachedDynamicKitDisplay_eSpot_div_1" class="promo_price">
					<% out.flush(); %>
					    <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
			                 <c:param name="storeId" value="${WCParam.storeId}" />
			                 <c:param name="catalogId" value="${WCParam.catalogId}" />
			                 <c:param name="langId" value="${WCParam.langId}" />
			                 <c:param name="emsName" value="${eSpotPaymentPromotion}" />
			                 <c:param name="currentProductId" value="${catalogEntryView.uniqueID}" />
			                 <c:param name="adclass" value="no_ad" />
			                 <c:param name="showPaymentDiscountPromotion" value="true" />
						</c:import> 
					<% out.flush(); %>
				</div>
			</c:if>
			 
			 <%-- We output the discounts using simple JavaScript to support older browsers such as Netscape 4  --%>
			<script type="text/javascript">
					document.write(Discount.getProductDiscountText(<c:out value="${productId}"/>));
			</script>
			
			<%@ include file="InstallmentOptions.jspf"%>
			<c:if test="${isBrazilStore}">
				<%-- Show Qualified Free Shipping Promotion --%> 
				<% out.flush(); %>
					<div id="WC_CachedDynamicKitDisplay_eSpot_div_2">
						<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
	                         <c:param name="storeId" value="${WCParam.storeId}" />
	                         <c:param name="catalogId" value="${WCParam.catalogId}" />
	                         <c:param name="langId" value="${WCParam.langId}" />
	                         <c:param name="emsName" value="${eSpotFreeShipping}" />
	                         <c:param name="currentProductId" value="${catalogEntryView.uniqueID}" />
	                         <c:param name="adclass" value="no_ad" />
						</c:import> 
					</div>
				<% out.flush(); %>
			</c:if>
			
			<br/>
			 
			 <div>
				  <label for="quantity_<c:out value='${catalogEntryView.uniqueID}'/>"><fmt:message key="QuickInfo_Qty" bundle="${storeText}"/>:</label>
				  <input name="quantity_<c:out value='${catalogEntryView.uniqueID}'/>" id="quantity_<c:out value='${catalogEntryView.uniqueID}'/>" type="text" size="3" value="1"/>
			 </div>
			<br />
			<%@ include file="B2BCatentryContractSelectExt.jspf"%>		
			 <%-- 
			  ***
				*	Start: Page action buttons
				***
			--%>
			<c:choose>
				<c:when test="${showAddToCart || showConfigure}" >
					<flow:ifEnabled feature="AjaxAddToCart">
						<c:if test="${showAddToCart }">
				 		<div>
							<span class="primary_button" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="javascript:setCurrentId('WC_CachedDynamicKitDisplay_links_3');categoryDisplayJS.AddItem2ShopCartAjax('<c:out value='${catalogEntryView.uniqueID}'/>',document.getElementById('quantity_<c:out value='${catalogEntryView.uniqueID}'/>').value, {catalogEntryType: 'dynamicKit'})" id="WC_CachedDynamicKitDisplay_links_3"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>
						</div>
						</c:if>
						<c:if test="${showConfigure }">
				 		<div>
							<span class="primary_button" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="javascript:setCurrentId('WC_CachedDynamicKitDisplay_links_10');categoryDisplayJS.ConfigureDynamicKit('<c:out value='${catalogEntryView.uniqueID}'/>',document.getElementById('quantity_<c:out value='${catalogEntryView.uniqueID}'/>').value)" id="WC_CachedDynamicKitDisplay_links_10"><fmt:message key="PRODUCT_CONFIGURE" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>
						</div>
						</c:if>
						<c:if test="${showAddToCart }">
						 <div class="features" id="WC_CachedDynamicKitDisplay_div_9">
							<flow:ifEnabled feature="ProductCompare">
								<c:if test="${compareEnabled}">
									<div class="tertiary_button_shadow">
										<div class="tertiary_button">
											<a href="JavaScript:compareProductJS.Add2CompareAjax('<c:out value='${catalogEntryView.uniqueID}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');" id="WC_CachedDynamicKitDisplay_links_4"><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a>
										</div>
									</div>
								</c:if>
							</flow:ifEnabled>

							<flow:ifEnabled  feature="wishList">
								<div class="addToWishListButtonBorder">
									<div class="tertiary_button_shadow" id="addToWishListButton_1">
										<div class="tertiary_button left">
											<a href="javascript: setCurrentId('WC_CachedDynamicKitDisplay_links_5'); categoryDisplayJS.Add2WishListAjaxByID('<c:out value='${catalogEntryView.uniqueID}'/>')" id="WC_CachedDynamicKitDisplay_links_5"><fmt:message key="WISHLIST" bundle="${storeText}" /> </a>
										</div>
									</div>
								</div>								
							</flow:ifEnabled>
							<flow:ifEnabled  feature="SOAWishlist">
								<%out.flush();%>
									<c:import url="${jspStoreDir}Snippets/MultipleWishList/MultipleWishListButton.jsp">
										<c:param name="catEntryId" value="${catalogEntryView.uniqueID}"/>	
										<c:param name="type" value="dynamicKit"/>	
									</c:import>				
								<%out.flush();%>																					
							</flow:ifEnabled>
							<flow:ifEnabled feature="RequisitionList">
								<c:set var="type" value="dynamicKit" />
								<%@include file="../../../ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListLinks.jspf" %>
							</flow:ifEnabled>							
						 </div>
						 </c:if>
					</flow:ifEnabled>
					
					<flow:ifDisabled feature="AjaxAddToCart">				
						<c:if test="${showAddToCart }">
						 <form name="OrderItemAddForm_<c:out value='${catalogEntryView.uniqueID}'/>" action="OrderChangeServiceAddPreConfigurationToCart" method="post" id="OrderItemAddForm_<c:out value='${catalogEntryView.uniqueID}'/>">
							<input type="hidden" name="storeId" value="<c:out value='${WCParam.storeId}'/>" id="OrderItemAddForm_storeId_<c:out value='${catalogEntryView.uniqueID}'/>"/>
							<input type="hidden" name="langId" value="<c:out value='${WCParam.langId}'/>" id="OrderItemAddForm_langId_<c:out value='${catalogEntryView.uniqueID}'/>"/>
							<input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="OrderItemAddForm_catalogId_<c:out value='${catalogEntryView.uniqueID}'/>"/>
							<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="OrderItemAddForm_url_<c:out value='${catalogEntryView.uniqueID}'/>"/>
							<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="OrderItemAddForm_errorViewName_<c:out value='${catalogEntryView.uniqueID}'/>"/>
							<input type="hidden" name="catEntryId" value="<c:out value='${catalogEntryView.uniqueID}'/>" id="OrderItemAddForm_catEntryId_<c:out value='${catalogEntryView.uniqueID}'/>"/>
							<input type="hidden" name="productId" value="<c:out value='${catalogEntryView.uniqueID}'/>" id="OrderItemAddForm_productId_<c:out value='${catalogEntryView.uniqueID}'/>"/>
							<input type="hidden" name="quantity" value="" id="OrderItemAddForm_quantity_<c:out value='${catalogEntryView.uniqueID}'/>"/>
							<input type="hidden" name="page" value="" id="OrderItemAddForm_page_${catalogEntryView.uniqueID}"/>
							<input type="hidden" name="contractId" value="" id="OrderItemAddForm_contractId_${catalogEntryView.uniqueID}"/>
							<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="OrderItemAddForm_calcUsage_${catalogEntryView.uniqueID}"/>
							<input type="hidden" name="updateable" value="0" id="OrderItemAddForm_updateable_${catalogEntryView.uniqueID}"/>
							<flow:ifEnabled feature="SOAWishlist">
							<input type="hidden" name="giftListId" value="<c:out value='${giftListId}'/>" id="<c:out value='OrderItemAddForm_${catalogEntryView.uniqueID}_giftListId_${giftListId}'/>"/>
							</flow:ifEnabled>							
						</form>
						<div>
							<span class="primary_button" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="javascript:categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_<c:out value='${catalogEntryView.uniqueID}'/>'),document.getElementById('quantity_<c:out value='${catalogEntryView.uniqueID}'/>').value);return false;" id="WC_CachedDynamicKitDisplay_links_12"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>	
						</div>
						</c:if>
						<c:if test="${showConfigure }">
						<div>
							<span class="primary_button" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="javascript:setCurrentId('WC_CachedDynamicKitDisplay_links_11');categoryDisplayJS.ConfigureDynamicKit('<c:out value='${catalogEntryView.uniqueID}'/>',document.getElementById('quantity_<c:out value='${catalogEntryView.uniqueID}'/>').value)" id="WC_CachedDynamicKitDisplay_links_11"><fmt:message key="PRODUCT_CONFIGURE" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>	
						</div>
						</c:if>
						<c:if test="${showAddToCart }">
						 <div class="features" id="WC_CachedDynamicKitDisplay_div_12">
							 <flow:ifEnabled feature="ProductCompare"> 
							 	<c:if test="${compareEnabled}">
									<div class="tertiary_button_shadow">
										<div class="tertiary_button">
											<a href="JavaScript:compareProductJS.Add2CompareAjax('<c:out value='${catalogEntryView.uniqueID}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');" id="WC_CachedDynamicKitDisplay_links_13"><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a>
										</div>
									</div>
								</c:if>
							</flow:ifEnabled>
							<flow:ifEnabled  feature="wishList">
								<div class="addToWishListButtonBorder">
									<div class="tertiary_button_shadow" id="addToWishListButton_1">
										<div class="tertiary_button left">
											<a id="WC_CachedDynamicKitDisplay_links_8" href="javascript: categoryDisplayJS.Add2WishListByID('<c:out value='${catalogEntryView.uniqueID}'/>',document.getElementById('OrderItemAddForm_<c:out value='${catalogEntryView.uniqueID}'/>'));return false;"><fmt:message key="WISHLIST" bundle="${storeText}" /> </a>
										</div>
									</div>
								</div>								
							</flow:ifEnabled>
							<flow:ifEnabled  feature="SOAWishlist">
								<%out.flush();%>
									<c:import url="${jspStoreDir}Snippets/MultipleWishList/MultipleWishListButton.jsp">
										<c:param name="catEntryId" value="${catalogEntryView.uniqueID}"/>	
										<c:param name="type" value="dynamicKit"/>	
									</c:import>				
								<%out.flush();%>																						
							</flow:ifEnabled>
							<flow:ifEnabled feature="RequisitionList">
								<c:set var="type" value="dynamicKit" />
								<%@include file="../../../ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListLinks.jspf" %>
							</flow:ifEnabled>							
						 </div>
						 </c:if>
					</flow:ifDisabled>
				</c:when>
				<c:otherwise>
					<p><fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" /></p>
					<c:if test="${noModelReference && !showAddToCart}">
						<p><fmt:message key="SKU_NOT_CONFIGURABLE" bundle="${storeText}" /></p>
					</c:if>
					<div>
						<span class="primary_button" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_CachedDynamicKitDisplay_links_9"><fmt:message key="RETURN_SHOPPING" bundle="${storeText}" /></a>
										</span>
									</span>	
								</span>
							</span>
						</span>	
					</div>
				</c:otherwise>
			</c:choose>
			<%@ include file="CachedDynamicKitButtonExt.jspf"%>
			
			<br />
			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryInventoryStatus.jsp">
				<c:param name="fromPage" value="${fromPage}"/>
				<c:param name="catentryId" value="${catalogEntryView.uniqueID}"/>
			</c:import>
			<%out.flush();%>
			<%@ include file="CatalogEntryInventoryStatusEIExt.jspf"%>
		</div>
		<br />
		<br clear="all" />
		<%-- 
			***
			*	End: Page action buttons
			***
		--%>

		<c:if test="${showMA}">
		<%-- 
		  ***
		  *	Start: Cross-Sell, Up-Sell, Accessory, Replacement
		  * Include MerchandisingAssociationsDisplay.jsp if Cross-Sell, Up-Sell, Accessory, Replacement are set up
		  ***
		--%>
		<%-- Flush the buffer so this fragment JSP is not cached twice --%>
		<%out.flush();%>
	        <c:import url="${jspStoreDir}Snippets/Catalog/MerchandisingAssociations/MerchandisingAssociationsDisplay.jsp">
           			<c:param name="catalogEntryType" value="DynamicKitBean"/>
           			<c:param name="pageView" value="image"/>
           			<c:param name="catalogEntryView" value="${catalogEntryView }"/>
       		</c:import>
		<%out.flush();%>
		<%-- 
		  ***										  
		  *	End: Cross-Sell, Up-Sell, Accessory, Replacement
		  ***
		--%>	
		</c:if>	

		<br clear="all" />
		<flow:ifDisabled feature="ProductDetailDescListView">
			<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("WC_CachedDynamicKitDisplay_div_34"); });</script>
			<c:set var="productDescHeaderListView" value="nodisplay"/>			
		</flow:ifDisabled>
		<flow:ifEnabled feature="ProductDetailDescListView">
			<c:set var="productDescHeaderListView" value="productDescHeaderList"/>
			<c:set var="HideTabsForListview" value="nodisplay" />
		</flow:ifEnabled>		
		<div class="specs" id="WC_CachedDynamicKitDisplay_div_34">
			 <div class="tabs ${HideTabsForListview}"  id="WC_CachedDynamicKitDisplay_div_35">
				 <span class="on" id="Description_On" style="display:inline">
					<span class="left_corner">&nbsp;</span>
					<span class="text"><fmt:message key="DESCRIPTION" bundle="${storeText}" /></span>
					<span class="right_corner">&nbsp;</span>
				 </span>
				 <span class="off" id="Description_Off" style="display:none">
					<span class="left_corner">&nbsp;</span>
					<a href="javascript:selectTab('Description');" class="catalog_link" id="WC_CachedDynamicKitDisplay_links_6">
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
					<a href="javascript:selectTab('Attachments');" class="catalog_link" id="WC_CachedDynamicKitDisplay_links_7">
						<span class="text"><fmt:message key="ATTACHMENTS" bundle="${storeText}"/></span>
					</a>
					<span class="right_corner">&nbsp;</span>
				 </span>
				 <span class="end"></span>
			 	 <%@ include file="CachedDynamicKitTabsExt.jspf"%>
			 </div>
			 <br/>
			 <div id="mainTabContainer" class="info" dojoType="dijit.layout.TabContainer" selectedTab="Description" doLayout="false" tabPosition="left-h">
				  <div id="Description" dojoType="dijit.layout.ContentPane" >
					<div class="${productDescHeaderListView}"><fmt:message key="DESCRIPTION" bundle="${storeText}" /></div>
				  	<p>
						<fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${catalogEntryView.partNumber}" escapeXml="false"/>
			 			</p>
				  	<p>
				  	<c:out value="${catalogEntryView.shortDescription}" escapeXml="false"/>
				  	</p>
						<br />
						<p>
							<c:out value="${catalogEntryView.longDescription}" escapeXml="false"/>
						</p>
						<br />
						<%-- 
						  ***
						  *	Start: Descriptive Attributes
						  * Descriptive attributes are simply displayed as 'name:value'. They are not used for SKU resolution.
						  ***
						--%>
						<%-- The descriptive attributes of the dynamicKit itself --%>
	 					<p>
						<c:set var="descAttrCount" value="0"/>
						<c:forEach var="attribute" items="${catEntry.attributes}">
							<c:if test="${ attribute.usage=='Descriptive' }" >
								<c:set var="descAttrCount" value="${descAttrCount + 1}"/>
								<span class="productName" id="descAttributeName_${descAttrCount}"><c:out value="${attribute.name}" escapeXml="false" />:</span>											
								<c:choose>
									<c:when test="${ !empty attribute.extendedValue['Image1']  }" >
										<span id="descAttributeValue_${descAttrCount}"><c:out value="${attribute.value[0]}" escapeXml="false" />&nbsp;<img src="<c:out value="${attribute.extendedValue['Image1']}" />" alt="<c:out value="${attribute.value[0]}" />" border="0"/></span><br/>												
									</c:when>
									<c:otherwise >
										<span id="descAttributeValue_${descAttrCount}"><c:out value="${attribute.value[0]}" escapeXml="false" /></span>
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
						<%-- 
						  ***
						  *	Start: Component Names
						  ***
						--%>
						<c:if test="${!empty catalogEntryView.components}">
						<br/>
						<p>
							<fmt:message key="CONFIGURATION" bundle="${storeText}" />:
							<ul class="product_specs">
							<c:forEach items="${catalogEntryView.components}" var="component">
								<li>${component.catalogEntryView.name }</li>
							</c:forEach>
							</ul>
						</p>
						</c:if>
						<%-- 
						  ***
						  *	End: Component Names
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
							   <c:param name="productId" value="${catalogEntryView.uniqueID}"/>  
							   <c:param name="catType" value="dynamicKit"/>  
							   <c:param name="excludeUsageStr" value="ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,ANGLEIMAGES_HDIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40,IMAGE_SIZE_330,IMAGE_SIZE_1000"/>  
							   <c:param name="retrieveLanguageIndependentAtchAst" value="1"/>  
						</c:import>  
						<%out.flush();%> 
					</flow:ifEnabled>
				  </div>
				  <%@ include file="CachedDynamicKitTabPanesExt.jspf"%>
			 </div>
			 <div class="tabfooter" id="WC_CachedDynamicKitDisplay_div_36"></div>
		</div>
   </div>
</div>
<!-- END CachedDynamicKitDisplay.jsp -->
