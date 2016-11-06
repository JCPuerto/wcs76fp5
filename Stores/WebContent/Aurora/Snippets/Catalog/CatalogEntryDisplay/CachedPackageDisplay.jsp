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

<!-- BEGIN CachedPackageDisplay.jsp -->
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
<c:set var="fromPage" value="packageDisplay"/>

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

<c:set var="dragType" value="package"/>

<!-- If SearchBasedNavigation is enabled, make the getData call and set common variables -->

<c:set var="catEntry" value="${catalogEntryDetails}" />
<c:set var="packageId" value="${catEntry.uniqueID}" />
<c:set var="shortDescription" value="${catEntry.shortDescription}" />
<c:set var="longDescription" value="${catEntry.longDescription}" />
<c:set var="fullImage" value="${catEntry.fullImage}" />
<c:set var="thumbNail" value="${catEntry.thumbnail}" />
<c:set var="name" value="${catEntry.name}" />
<c:set var="buyable" value="${catEntry.buyable}" />
<c:set var="attachments" value="${catEntry.attachments}" />

<c:set var="maximumItemPrice" value="" />
<c:forEach var="prices" items="${catEntry.price}">
	<c:if test="${prices.priceUsage == 'Offer'}">
		<c:set var="maximumItemPrice" value="${prices.maximumValue.value}"/>
		<c:if test="${empty maximumItemPrice}">						
			<c:set var="maximumItemPrice" value="${prices.value.value}"/>
		</c:if>
	</c:if>
</c:forEach>
<c:if test="${empty maximumItemPrice || buyable eq 'false'}" >
	<c:set var="buyable" value="false"/>
</c:if>

<c:set var="patternName" value="ProductURLWithParentCategory"/>
<c:if test="${WCParam.parent_category_rn != WCParam.top_category}">
	<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
</c:if>

<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="productId" value="${packageId}"/>
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
	<wcf:param name="catType" value="package"/>
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
	<c:set var="someItemIDs" value="" />
	
	<c:forEach var="packageComponent" items="${catEntry.components}" varStatus="status">
		<c:choose>
			<c:when test="${empty someItemIDs}">
				<c:set var="someItemIDs" value="${packageComponent.catalogEntryView.uniqueID}" />
			</c:when>	
			<c:otherwise>
				<c:set var="someItemIDs" value="${someItemIDs},${packageComponent.catalogEntryView.uniqueID}" />
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
* End:  Get all product and item IDs displayed on this page and pass them to the discount code
***
--%>
<%-- remove double quote from shortdescription --%>
<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="packageShortDesc" value="${fn:replace(shortDescription, search, replaceStr)}"/>

<div id="body588">
   <div id="product">
		<div class="product_images" id="WC_CachedPackageDisplay_div_1">
			<c:if test="${addProductDnD eq 'true'}">
				<div dojoType="dojo.dnd.Source" jsId="dndSource" id="<c:out value='${packageId}'/>" copyOnly="true" dndType="<c:out value='${dragType}'/>">
					<div class="dojoDndItem" dndType="<c:out value='${dragType}'/>" id="WC_CachedPackageDisplay_div_2">
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
					var widgetText = "<c:out value="${packageId}"/>";
					parseWidget(widgetText);
				});
				</script>
			</c:if>
			
				
				<%@ include file="AttachmentImagesDisplay.jspf"%>
			
			
				<c:set var="compareImageDescription" value="${fn:replace(shortDescription, search, replaceCmprStr)}"/>
				<c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>
				 <input type="hidden" id="compareImgPath_<c:out value='${packageId}'/>" value="<c:out value='${productCompareImagePath}'/>"/>
				 <input type="hidden" id="compareImgDescription_<c:out value='${packageId}'/>" value="<c:out value='${compareImageDescription}'/>"/>
				 <input type="hidden" id="compareProductDetailsPath_<c:out value='${packageId}'/>" value="<c:out value='${catEntryDisplayUrl}'/>"/>			
			<br />
		
			<%-- 
			  ***
				*	Start: Product angle images
				* Product angle images are loaded as attachments. Expected to have 2 sets loaded as 'ANGLEIMAGES_THUMBNAIL' and 'ANGLEIMAGES_FULLIMAGE'
				* attachment usages.
				***
			--%>
			
			
			<%-- 
			  ***
				*	End: Product angle images
				***
			--%>
			<%@ include file="CachedPackageImageExt.jspf"%>
		</div>
		<div class="product_options" id="WC_CachedPackageDisplay_div_3">
			<h1 id="catalog_link"  class="catalog_link"><c:out value="${name}" escapeXml="false"/></h1>
				 
			<%-- in Elite, we do not want to show the price because the price may be different depending on the 
			contract that is selected --%>
			<c:if test="${displayListPriceInProductPage == 'true'}">			
				<div id="WC_CachedPackageDisplay_div_4">
					<span class="price bold"><fmt:message key="PRICE" bundle="${storeText}"/></span>
					<c:set var="type" value="package"/>
					<c:set var="catalogEntry" value="${catEntry}"/>
					<c:set var="displayPriceRange" value="true"/>
					<c:set var="priceHighlightable" value="true"/>
					<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
				</div>
			</c:if>
			 
			<c:if test="${isBrazilStore}">
				<%-- Flush the buffer so this fragment JSP is not cached twice --%>
				<%-- Show Payment Discount promotion --%>
				<div id="WC_CachedPackageDisplay_eSpot_div_1" class="promo_price">
					<% out.flush(); %>
					    <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
			                 <c:param name="storeId" value="${WCParam.storeId}" />
			                 <c:param name="catalogId" value="${WCParam.catalogId}" />
			                 <c:param name="langId" value="${WCParam.langId}" />
			                 <c:param name="emsName" value="${eSpotPaymentPromotion}" />
			                 <c:param name="currentProductId" value="${packageId}" />
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
					<div id="WC_CachedPackageDisplay_eSpot_div_2">
						<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
	                         <c:param name="storeId" value="${WCParam.storeId}" />
	                         <c:param name="catalogId" value="${WCParam.catalogId}" />
	                         <c:param name="langId" value="${WCParam.langId}" />
	                         <c:param name="emsName" value="${eSpotFreeShipping}" />
	                         <c:param name="currentProductId" value="${packageId}" />
	                         <c:param name="adclass" value="no_ad" />
						</c:import> 
					</div>
				<% out.flush(); %>
			</c:if>
			
			<br/>
			 
			 <div>
				  <label for="quantity_<c:out value='${packageId}'/>"><fmt:message key="QuickInfo_Qty" bundle="${storeText}"/>:</label>
				  <input name="quantity_<c:out value='${packageId}'/>" id="quantity_<c:out value='${packageId}'/>" type="text" size="3" value="1"/>
			 </div>
			<br />

			<c:set var="catalogEntry" value="${catEntry}"/>
			<%@ include file="B2BCatentryContractSelectExt.jspf"%>		

			 <%-- 
			  ***
				*	Start: Page action buttons
				***
			--%>
			<c:choose>
				<c:when test="${buyable || alwaysShowAddToCart}" >
					<flow:ifEnabled feature="AjaxAddToCart">
				 		<div>
							<span class="primary_button" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a class="ajaxAddToCart" href="javascript:setCurrentId('WC_CachedPackageDisplay_links_3');categoryDisplayJS.AddItem2ShopCartAjax('<c:out value='${packageId}'/>',document.getElementById('quantity_<c:out value='${packageId}'/>').value)" id="WC_CachedPackageDisplay_links_3"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>
						</div>
						 <div class="features" id="WC_CachedPackageDisplay_div_9">
							<flow:ifEnabled feature="ProductCompare">
								<div class="tertiary_button_shadow">
									<div class="tertiary_button">
										<a href="JavaScript:compareProductJS.Add2CompareAjax('<c:out value='${packageId}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');" id="WC_CachedPackageDisplay_links_4"><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a>
									</div>
								</div>
							</flow:ifEnabled>

							<flow:ifEnabled  feature="wishList">
								<div class="addToWishListButtonBorder">
									<div class="tertiary_button_shadow" id="addToWishListButton_1">
										<div class="tertiary_button left">
											<a href="javascript: setCurrentId('WC_CachedPackageDisplay_links_5'); categoryDisplayJS.Add2WishListAjaxByID('<c:out value='${packageId}'/>')" id="WC_CachedPackageDisplay_links_5"><fmt:message key="WISHLIST" bundle="${storeText}" /> </a>
										</div>
									</div>
								</div>								
							</flow:ifEnabled>
							<flow:ifEnabled  feature="SOAWishlist">
								<%out.flush();%>
									<c:import url="${jspStoreDir}Snippets/MultipleWishList/MultipleWishListButton.jsp">
										<c:param name="catEntryId" value="${packageId}"/>	
										<c:param name="type" value="package"/>	
									</c:import>				
								<%out.flush();%>																					
							</flow:ifEnabled>
							<flow:ifEnabled feature="RequisitionList">
								<c:set var="type" value="package" />
								<%@include file="../../../ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListLinks.jspf" %>
							</flow:ifEnabled>							
						 </div>
					</flow:ifEnabled>
					
					<flow:ifDisabled feature="AjaxAddToCart">				
						 <form name="OrderItemAddForm_<c:out value='${packageId}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderItemAddForm_<c:out value='${packageId}'/>">
							<input type="hidden" name="storeId" value="<c:out value='${WCParam.storeId}'/>" id="OrderItemAddForm_storeId_<c:out value='${packageId}'/>"/>
							<input type="hidden" name="langId" value="<c:out value='${WCParam.langId}'/>" id="OrderItemAddForm_langId_<c:out value='${packageId}'/>"/>
							<input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="OrderItemAddForm_catalogId_<c:out value='${packageId}'/>"/>
							<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="OrderItemAddForm_url_<c:out value='${packageId}'/>"/>
							<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="OrderItemAddForm_errorViewName_<c:out value='${packageId}'/>"/>
							<input type="hidden" name="catEntryId" value="<c:out value='${packageId}'/>" id="OrderItemAddForm_catEntryId_<c:out value='${packageId}'/>"/>
							<input type="hidden" name="productId" value="<c:out value='${packageId}'/>" id="OrderItemAddForm_productId_<c:out value='${packageId}'/>"/>
							<input type="hidden" name="quantity" value="" id="OrderItemAddForm_quantity_<c:out value='${packageId}'/>"/>
							<input type="hidden" name="page" value="" id="OrderItemAddForm_page_${packageId}"/>
							<input type="hidden" name="contractId" value="" id="OrderItemAddForm_contractId_${packageId}"/>
							<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="OrderItemAddForm_calcUsage_${packageId}"/>
							<input type="hidden" name="updateable" value="0" id="OrderItemAddForm_updateable_${packageId}"/>
							<flow:ifEnabled feature="SOAWishlist">
							<input type="hidden" name="giftListId" value="<c:out value='${giftListId}'/>" id="<c:out value='OrderItemAddForm_${packageId}_giftListId_${giftListId}'/>"/>
							</flow:ifEnabled>							
						</form>
						<div>
							<span class="primary_button" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="#" onclick="javascript:categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_<c:out value='${packageId}'/>'),document.getElementById('quantity_<c:out value='${packageId}'/>').value);return false;" id="WC_CachedPackageDisplay_links_6"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>	
						</div>
						 <div class="features" id="WC_CachedPackageDisplay_div_12">
							 <flow:ifEnabled feature="ProductCompare"> 
								<div class="tertiary_button_shadow">
									<div class="tertiary_button">
										<a href="JavaScript:compareProductJS.Add2CompareAjax('<c:out value='${packageId}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');" id="WC_CachedPackageDisplay_links_7"><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a>
									</div>
								</div>
							</flow:ifEnabled>
							<flow:ifEnabled  feature="wishList">
								<div class="addToWishListButtonBorder">
									<div class="tertiary_button_shadow" id="addToWishListButton_1">
										<div class="tertiary_button left">
											<a id="WC_CachedPackageDisplay_links_8" href="#" onclick="javascript: categoryDisplayJS.Add2WishListByID('<c:out value='${packageId}'/>',document.getElementById('OrderItemAddForm_<c:out value='${packageId}'/>'));return false;"><fmt:message key="WISHLIST" bundle="${storeText}" /> </a>
										</div>
									</div>
								</div>								
							</flow:ifEnabled>
							<flow:ifEnabled  feature="SOAWishlist">
								<%out.flush();%>
									<c:import url="${jspStoreDir}Snippets/MultipleWishList/MultipleWishListButton.jsp">
										<c:param name="catEntryId" value="${packageId}"/>	
										<c:param name="type" value="package"/>	
									</c:import>				
								<%out.flush();%>																						
							</flow:ifEnabled>
							<flow:ifEnabled feature="RequisitionList">
								<c:set var="type" value="package" />
								<%@include file="../../../ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListLinks.jspf" %>
							</flow:ifEnabled>							
						 </div>
					</flow:ifDisabled>
				</c:when>
				<c:otherwise>
					<p><fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" /></p>
					
					<div>
						<span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_CachedPackageDisplay_links_9"><fmt:message key="RETURN_SHOPPING" bundle="${storeText}" /></a>
										</span>
									</span>	
								</span>
							</span>
						</span>	
					</div>
				</c:otherwise>
			</c:choose>
			<%@ include file="CachedPackageButtonExt.jspf"%>
			
			<br />
			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryInventoryStatus.jsp">
				<c:param name="fromPage" value="${fromPage}"/>
				<c:param name="catentryId" value="${packageId}"/>
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

				
		
			<%-- 
			  ***
			  *	Start: List the information of package components
			  ***
			--%>
			<div id="WC_CachedPackageDisplay_div_15">
				<c:forEach var="packageComponent" items="${catEntry.components}" varStatus="iStatus">
					<c:set var="packageComponentDetails" value="${packageComponent.catalogEntryView}"/>
					<c:set var="packageComponentType" value="${fn:trim(packageComponentDetails.catalogEntryTypeCode)}"/>
					
					<c:choose>
						<c:when test="${packageComponentType == 'ItemBean'}">
							<c:set var="patternName" value="CanonicalItemURLWithCategory"/>
						</c:when>
						<c:otherwise>
							<c:set var="patternName" value="ProductURLWithParentCategory"/>
							<c:if test="${WCParam.parent_category_rn != WCParam.top_category}">
								<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
							</c:if>
						</c:otherwise>
					</c:choose>


					<wcf:url var="ItemDisplayURL" patternName="${patternName}" value="Product2">
						<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
						<wcf:param name="storeId" value="${WCParam.storeId}"/>
						<wcf:param name="productId" value="${packageComponentDetails.uniqueID}"/>
						<wcf:param name="langId" value="${WCParam.langId}"/>
						<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
						<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
						<wcf:param name="top_category" value="${WCParam.top_category}"/>
						<wcf:param name="urlLangId" value="${urlLangId}" />
					</wcf:url>

					<c:if test="${packageComponentType == 'ItemBean'}">
						<h1><fmt:message key="ITEM_TITLE1" bundle="${storeText}"/> <c:out value="${packageComponentDetails.name}" escapeXml="false"/></h1>
					</c:if>
					<c:if test="${packageComponentType == 'ProductBean'}">
						<h1><fmt:message key="PRODUCT_TITLE1" bundle="${storeText}"/> <c:out value="${packageComponentDetails.name}" escapeXml="false"/></h1>
					</c:if>
					<c:if test="${packageComponentType == 'PackageBean'}">
						<h1><fmt:message key="PACKAGE_TITLE1" bundle="${storeText}"/> <c:out value="${packageComponentDetails.name}" escapeXml="false"/></h1>
					</c:if>
						
					<div class="left package_img" id="WC_CachedPackageDisplay_div_16_<c:out value='${iStatus.count}'/>">
						<c:choose>
							<c:when test="${!empty packageComponentDetails.thumbnail}">
								<a id="WC_CachedPackageDisplay_links_10_<c:out value='${iStatus.count}'/>" href="<c:out value="${ItemDisplayURL}" escapeXml="false"/>">
									<img src="<c:out value="${hostPath}"/><c:out value="${packageComponentDetails.thumbnail}"/>" alt="<c:out value="${packageComponentDetails.shortDescription}" />" border="0" width="70" height="70"/>
								</a>
							</c:when>
							<c:otherwise>
								<a id="WC_CachedPackageDisplay_links_11_<c:out value='${iStatus.count}'/>" href="<c:out value="${ItemDisplayURL}" escapeXml="false"/>" >
								<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0" width="70" height="70"/>
								</a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="left package_desc" id="WC_CachedPackageDisplay_div_17_<c:out value='${iStatus.count}'/>">
						<c:out value="${packageComponentDetails.longDescription}" escapeXml="false" />
						
						<c:if test="${packageComponentType == 'ItemBean'}">
							<br />	
							<span><fmt:message key="SKU" bundle="${storeText}" />:</span><span><c:out value="${packageComponentDetails.partNumber}" /></span>
							<br />		
							<script type="text/javascript">
								document.write(Discount.getItemDiscountText(<c:out value="${packageComponentDetails.uniqueID}"/>));
							</script>
						</c:if>
						<c:if test="${packageComponentType == 'ProductBean'}">		
							<script type="text/javascript">
								document.write(Discount.getProductDiscountText(<c:out value="${packageComponentDetails.uniqueID}"/>));
							</script>			
						</c:if>
						<br />

						<fmt:message key="PRODUCT_ATTRIBUTES" bundle="${storeText}" />:
						
						<c:set var="anyAttributes" value="false" />	

						<c:if test="${packageComponentType == 'ItemBean'}">
							<c:forEach var="attributeItem" items="${packageComponentDetails.attributes}">
								<c:if test="${ attributeItem.usage=='Descriptive' }" >
									<span><c:out value="${attributeItem.name}"  escapeXml="false" /> : </span>
									<span>
									<c:out value="${attributeItem.values[0].value}"  escapeXml="false" />
									</span>
									<br />
									<c:set var="anyAttributes" value="true" />											
								</c:if>
							</c:forEach>
							<c:forEach var="attributeItem" items="${packageComponentDetails.attributes}">
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

						<c:if test="${packageComponentType == 'ProductBean'}">
							<c:forEach var="attribute" items="${packageComponentDetails.attributes}" varStatus="aStatus">
								<c:if test="${attribute.usage == 'Defining'}">
									<span><label for="attributes"><c:out value="${attribute.name}" escapeXml="false" />:</label></span><br/>
									<select class="drop_down" id="attributes" name="attrValue">
										<!-- Display product attribute values !-->
										<c:forEach var="allowedValue" items="${attribute.values}">
											<c:set var="displayValue" value="${allowedValue}" />
											<c:forEach var="extendedValue" items="${attribute.extendedValue}">
												<c:if test="${extendedValue.name == 'Field2'}">
													<c:set var="displayValue" value="${extendedValue.value}" />
												</c:if>
											</c:forEach>
											<option><c:out value="${displayValue}" escapeXml="false"/></option>
										</c:forEach>
									</select>
									<br />
									<c:set var="anyAttributes" value="true" />
								</c:if>
							</c:forEach>

							<c:forEach var="attributeItem" items="${packageComponentDetails.attributes}">
								<c:if test="${ attributeItem.usage=='Descriptive' }" >
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
									<fmt:message key="PRODUCT_NO_ATTRIBUTES" bundle="${storeText}" />
								</span>
							</c:if>
						</c:if>

						<c:if test="${packageComponentType == 'PackageBean'}">
							<c:forEach var="attribute2" items="${packageComponentDetails.attributes}">
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

					</div>
					<br clear="all" />
					
					<c:if test="${displayListPriceInProductPage == 'true'}">				
					<div class="left price bold" id="WC_CachedPackageDisplay_div_18_<c:out value='${iStatus.count}'/>">
						<fmt:message key="PRICE" bundle="${storeText}"/>
					</div>
					<div class="left" id="WC_CachedPackageDisplay_div_19_<c:out value='${iStatus.count}'/>">
						&nbsp;
					</div>
						<div class="left" id="WC_CachedPackageDisplay_div_20_<c:out value='${iStatus.count}'/>">
							<c:set var="type" value="item"/>
							<c:set var="catalogEntry" value="${packageComponentDetails}"/>
							<c:set var="priceHighlightable" value="true"/>
							<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
						</div>
						<br clear="all" />					
					</c:if>
					<div class="package_qty" id="WC_CachedPackageDisplay_div_21_<c:out value='${iStatus.count}'/>">
						<fmt:parseNumber var="packageComponentQuantity" integerOnly="true" value="${packageComponent.quantity}"/>
						<fmt:message key="QuickInfo_Qty" bundle="${storeText}"/>:<c:out value="${packageComponentQuantity}" />
					</div>
					<br />
					<br />
				</c:forEach>
			</div>
			<br clear="all" />
			<%-- 
			  ***
			  *	End: List the information of package components
			  ***
			--%>
		

							<%-- 
							  ***
							  *	Start: Cross-Sell, Up-Sell, Accessory, Replacement
							  * Include MerchandisingAssociationsDisplay.jsp if Cross-Sell, Up-Sell, Accessory, Replacement are set up
							  ***
							--%>
							
							<%out.flush();%>
							<c:import url="${jspStoreDir}Snippets/Catalog/MerchandisingAssociations/MerchandisingAssociationsDisplay.jsp">
									<c:param name="catalogEntryType" value="PackageBean"/>
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
			<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("WC_CachedPackageDisplay_div_34"); });</script>
			<c:set var="productDescHeaderListView" value="nodisplay"/>			
		</flow:ifDisabled>
		<flow:ifEnabled feature="ProductDetailDescListView">
			<c:set var="productDescHeaderListView" value="productDescHeaderList"/>
			<c:set var="HideTabsForListview" value="nodisplay" />
		</flow:ifEnabled>		
		<div class="specs" id="WC_CachedPackageDisplay_div_34">
			 <div class="tabs ${HideTabsForListview}"  id="WC_CachedPackageDisplay_div_35">
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
			 	 <%@ include file="CachedPackageTabsExt.jspf"%>
			 </div>
			 <br/>
			 <div id="mainTabContainer" class="info" dojoType="dijit.layout.TabContainer" selectedTab="Description" doLayout="false" tabPosition="left-h">
				  <div id="Description" dojoType="dijit.layout.ContentPane" >
					<div class="${productDescHeaderListView}"><fmt:message key="DESCRIPTION" bundle="${storeText}" /></div>
						<%-- The descriptive attributes of the package itself --%>

						<%-- Find out all the subscription related attributes if any --%>
						<c:set var="isRecurrable" value="true"/>
						
						<c:if test="${catEntry.disallowRecurringOrder}">
							<c:set var="isRecurrable" value="false"/>
						</c:if>
						
						<c:if test="${isRecurrable}">
							<flow:ifEnabled feature="RecurringOrders">
							<div id="tip_box">
								<div id="tip_box_icon1" class="image">
									<div id="tip_box_display_image" class="display_image"></div>
								</div>
								<div id="tip_box_icon2" class="text">
									<div id="tip_box_header" class="bold extra_bottom_margin"><fmt:message key="PRODUCT_PAGE_RECORDER" bundle="${storeText}" /></div>
									<div id="tip_box_description"><fmt:message key="PRODUCT_PAGE_RECORDER_DESC" bundle="${storeText}" /></div>
								</div>
							</div>
							<br />
							</flow:ifEnabled>
						</c:if>
						
				  	<p>
						<fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${packageDataBean.partNumber}" escapeXml="false"/>
			 			</p>
				  	<p>
				  	<c:out value="${shortDescription}" escapeXml="false"/>
				  	</p>
						<br />
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
							   <c:param name="productId" value="${packageId}"/>  
							   <c:param name="catType" value="package"/>  
							   <c:param name="excludeUsageStr" value="ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,ANGLEIMAGES_HDIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40,IMAGE_SIZE_330,IMAGE_SIZE_1000"/>  
							   <c:param name="retrieveLanguageIndependentAtchAst" value="1"/>  
						</c:import>  
						<%out.flush();%> 
					</flow:ifEnabled>
				  </div>
				  <%@ include file="CachedPackageTabPanesExt.jspf"%>
			 </div>
			 <div class="tabfooter" id="WC_CachedPackageDisplay_div_36"></div>
		</div>
   </div>
</div>
<!-- END CachedPackageDisplay.jsp -->
