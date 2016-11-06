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


<!-- BEGIN CachedItemDisplay.jsp -->
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

<wcbase:useBean id="item" classname="com.ibm.commerce.catalog.beans.ItemDataBean" scope="request" />
<c:set var="type" value="item" />
<c:set var="dragType" value="item"/>
<c:set var="fromPage" value="itemDisplay"/>

<c:set var="patternName" value="ProductURLWithParentCategory"/>
<c:if test="${WCParam.parent_category_rn != WCParam.top_category}">
	<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
</c:if>
<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="productId" value="${item.itemID}"/>
	<wcf:param name="langId" value="${WCParam.langId}"/>
	<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
	<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
	<wcf:param name="top_category" value="${WCParam.top_category}"/>
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<wcf:url var="CatalogAttachmentURL" value="CatalogAttachmentView" type="Ajax">
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="productId" value="${item.itemID}"/>
	<wcf:param name="catType" value="item"/>
	<wcf:param name="excludeUsageStr" value="ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40,IMAGE_SIZE_330,IMAGE_SIZE_1000"/>
	<wcf:param name="retrieveLanguageIndependentAtchAst" value="1"/>
</wcf:url>
<%-- 
***
* Start:  Pass the current product ID being displayed on this page to the discount code
***
--%>
	<%-- Flush the buffer so this fragment JSP is not cached twice --%>
	<%out.flush();%>
	<c:import url="${jspStoreDir}include/DiscountJavaScriptSetup.jsp">
		<c:param name="jsPrototypeName" value="Discount" />
		<c:param name="someProductIDs" value="${productId}"/>
		<c:param name="productIncludeChildItems" value="true"/>
		<c:param name="productIsProdPromoOnly" value="false"/>
		<c:param name="productIncludeParentProduct" value="false"/>
	</c:import>
	<%out.flush();%>
<%-- 
***
* End:  Pass the current product ID being displayed on this page to the discount code
***
--%>

<%-- remove double quote from shortdescription --%>
<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="itemShortDesc" value="${fn:replace(item.description.shortDescription, search, replaceStr)}"/>

<div id="body588">
   <div itemscope="itemscope" itemtype="http://data-vocabulary.org/Product">
   <div id="product">
		<div class="product_images" id="WC_CachedItemDisplay_div_1">
			<c:if test="${addProductDnD eq 'true'}">
				<div dojoType="dojo.dnd.Source" jsId="dndSource" id="<c:out value='${item.itemID}'/>" copyOnly="true" dndType="<c:out value='${dragType}'/>">
					<div class="dojoDndItem" dndType="<c:out value='${dragType}'/>" id="WC_CachedItemDisplay_div_2">
			</c:if>
			<span class="product">
				<c:choose>
					<c:when test="${!empty item.description.fullImage}">
						<c:if test="${addProductDnD eq 'true'}">
							<!--[if lte IE 6.5]><iframe class="productPageDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
						</c:if>
						<img id="productMainImage" src="<c:out value="${item.objectPath}${item.description.fullImage}"/>" alt="<c:out value="${itemShortDesc}" escapeXml="false"/>" title="<c:out value="${itemShortDesc}" escapeXml="false"/>" width="160" height="160"/>
					</c:when>
					<c:otherwise>
						<c:if test="${addProductDnD eq 'true'}">
							<!--[if lte IE 6.5]><iframe class="productPageDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
						</c:if>
						<img id="productMainImage" src="<c:out value="${hostPath}${jspStoreImgDir}" />images/NoImageIcon.jpg" alt="<c:out value="${itemShortDesc}" escapeXml="false"/>" title="<c:out value="${itemShortDesc}" escapeXml="false"/>" width="160" height="160"/>
					</c:otherwise>
				</c:choose>

			</span>
			<c:if test="${addProductDnD eq 'true'}">
					</div>
				</div>
				<script type="text/javascript">
				dojo.addOnLoad(function() { 
					var widgetText = "<c:out value="${item.itemID}"/>";
					parseWidget(widgetText);
				});
				</script>
			</c:if>
			
			<c:set property="attachmentUsage" value="IMAGE_SIZE_40" target="${item}" />
			<c:set var="image40AttachmentDataBeans" value="${item.attachmentsByUsage}" />
			<c:choose>
			 		<c:when test="${!empty image40AttachmentDataBeans[0]}">
						<c:set var="productCompareImagePath" value="${image40AttachmentDataBeans[0].objectPath}${image40AttachmentDataBeans[0].path}" />
			 		</c:when>
					<c:when test="${!empty item.description.thumbNail}">
						<c:set var="productCompareImagePath" value="${item.objectPath}${item.description.thumbNail}" />
					</c:when>
					<c:otherwise>
						<c:set var="productCompareImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
					</c:otherwise>
			 </c:choose>
			<c:set var="compareImageDescription" value="${fn:replace(item.description.shortDescription, search, replaceCmprStr)}"/>
			<c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>
			 <input type="hidden" id="compareImgPath_<c:out value='${item.itemID}'/>" value="<c:out value='${productCompareImagePath}'/>"/>
			 <input type="hidden" id="compareImgDescription_<c:out value='${item.itemID}'/>" value="<c:out value='${compareImageDescription}'/>"/>
			 <input type="hidden" id="compareProductDetailsPath_<c:out value='${item.itemID}'/>" value="<c:out value='${catEntryDisplayUrl}'/>"/>
			<br />
			
			<%-- 
			  ***
				*	Start: Item angle images
				* Item angle images are loaded as attachments. Expected to have 2 sets loaded as 'ANGLEIMAGES_THUMBNAIL' and 'ANGLEIMAGES_FULLIMAGE'
				* attachment usages.
				***
			--%>
			<c:set property="attachmentUsage" value="ANGLEIMAGES_THUMBNAIL" target="${item}" />
			<c:set var="angleThumbAttachmentDataBeans" value="${item.attachmentsByUsage}" />
			<c:if test="${!empty angleThumbAttachmentDataBeans}">
				<c:set property="attachmentUsage" value="ANGLEIMAGES_FULLIMAGE" target="${item}" />
				<c:set var="angleFImageAttachmentDataBeans" value="${item.attachmentsByUsage}" />
				<span class="angles">
				<c:forEach var="attachmentDB" items="${angleThumbAttachmentDataBeans}" varStatus="aStatus">
					<c:choose>
						<c:when test="${aStatus.first}">
							<a id="WC_CachedItemDisplay_links_1_<c:out value='${sStatus.count}'/>" href="JavaScript:changeThumbNail('productAngleImg<c:out value='${aStatus.index}'/>','<c:out value="${angleFImageAttachmentDataBeans[aStatus.index].objectPath}${angleFImageAttachmentDataBeans[aStatus.index].path}"/>');"><img id="productAngleImg<c:out value='${aStatus.index}'/>" src="<c:out value="${attachmentDB.objectPath}${attachmentDB.path}"/>" alt="<c:out value="${attachmentDB.shortDescription}"/>" class="on" /></a>
						</c:when>
						<c:otherwise>
							<a id="WC_CachedItemDisplay_links_2_<c:out value='${aStatus.count}'/>" href="JavaScript:changeThumbNail('productAngleImg<c:out value='${aStatus.index}'/>','<c:out value="${angleFImageAttachmentDataBeans[aStatus.index].objectPath}${angleFImageAttachmentDataBeans[aStatus.index].path}"/>');"><img id="productAngleImg<c:out value='${aStatus.index}'/>" src="<c:out value="${attachmentDB.objectPath}${attachmentDB.path}"/>" alt="<c:out value="${attachmentDB.shortDescription}"/>" class="off" /></a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</span><br />
			</c:if>
			<%-- 
			  ***
				*	End: Item angle images
				***
			--%>
			
			 <%@ include file="CachedItemImageExt.jspf"%>
		</div>
		<span itemprop="offerDetails" itemscope itemtype="http://data-vocabulary.org/Offer">
		<div class="product_options" id="WC_CachedItemDisplay_div_3">
			 <h1  id="catalog_link"  class="catalog_link"><span itemprop="name"><c:out value="${item.description.name}" escapeXml="false"/></span></h1>
	
			 <%-- in Elite, we do not want to show the price because the price may be different depending on the 
			 contract that is selected --%>
			 <c:if test="${displayListPriceInProductPage == 'true'}">
			 <div class="price" id="WC_CachedItemDisplay_div_4">
				<span class="price bold"><fmt:message key="PRICE" bundle="${storeText}"/></span>
				<c:set var="catalogEntryDB" value="${item}" />
				<c:set var="displayPriceRange" value="true"/>
				<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
			 </div>
			 </c:if>
			
			 <c:if test="${isBrazilStore}">
				<%-- Flush the buffer so this fragment JSP is not cached twice --%>
				<%-- Show Payment Discount promotion --%>
				<div id="WC_CachedItemDisplay_eSpot_div_1" class="promo_price">
					<% out.flush(); %>
						<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
			                 <c:param name="storeId" value="${WCParam.storeId}" />
			                 <c:param name="catalogId" value="${WCParam.catalogId}" />
			                 <c:param name="langId" value="${WCParam.langId}" />
			                 <c:param name="emsName" value="${eSpotPaymentPromotion}" />
			                 <c:param name="currentProductId" value="${WCParam.productId}" />
			                 <c:param name="adclass" value="no_ad" />
			                 <c:param name="showPaymentDiscountPromotion" value="true" />
						</c:import> 
					<% out.flush(); %>
				</div>
			 </c:if>
			 <%-- view forms of payment link and popup --%>
			 <%@ include file="InstallmentOptions.jspf"%>

			 <c:if test="${isBrazilStore}">
				<%-- Show Qualified Free Shipping Promotion --%> 
				<% out.flush(); %>
					<div id="WC_CachedItemDisplay_eSpot_div_2">
						<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
	                         <c:param name="storeId" value="${WCParam.storeId}" />
	                         <c:param name="catalogId" value="${WCParam.catalogId}" />
	                         <c:param name="langId" value="${WCParam.langId}" />
	                         <c:param name="emsName" value="${eSpotFreeShipping}" />
	                         <c:param name="currentProductId" value="${WCParam.productId}" />
	                         <c:param name="adclass" value="no_ad" />
						</c:import> 
						<br />
					</div>
				<% out.flush(); %>
			 </c:if> 
			 <c:if test="${!isBrazilStore}"> <%-- Brazil store will display promotions near bottom of page --%>
				 <%-- We output the discounts using simple JavaScript to support older browsers such as Netscape 4  --%>
				<script type="text/javascript">
						document.write(Discount.getProductDiscountText(<c:out value="${productId}"/>));
				</script>
			 </c:if>
			
			 <div>
				  <label for="quantity_<c:out value='${item.itemID}'/>"><fmt:message key="CurrentOrder_QTY" bundle="${storeText}"/></label>
				  <input name="quantity" id="quantity_<c:out value='${item.itemID}'/>" type="text" size="3" value="1"/>
			 </div>
			 <br />
			 <%@ include file="B2BCatentryContractSelectExt.jspf"%>		
			 <%-- 
			  ***
				*	Start: Page action buttons
				***
			--%>
				<c:choose>
					<c:when test="${item.buyable != 0 || alwaysShowAddToCart}" >
						<flow:ifEnabled feature="AjaxAddToCart"> 			
				 		<div>
							 <span class="primary_button" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												 <a href="javascript:setCurrentId('WC_CachedItemDisplay_links_3'); categoryDisplayJS.AddItem2ShopCartAjax('<c:out value='${item.itemID}'/>',document.getElementById('quantity_<c:out value='${item.itemID}'/>').value)" id="WC_CachedItemDisplay_links_3"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
								 			</span>
										</span>	
									</span>
								</span>
							</span>	
						</div>
							 
							 <div class="features" id="WC_CachedItemDisplay_div_9">
							 <flow:ifEnabled feature="ProductCompare">
							 	<div class="addToCompareButtonContainer">
									<div class="tertiary_button_shadow">
										<div class="tertiary_button">
											<a id="WC_CachedItemDisplay_links_4" href="JavaScript:compareProductJS.Add2CompareAjax('<c:out value='${item.itemID}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');"><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a>
										</div>
									</div>
								</div>
							 </flow:ifEnabled>
								<flow:ifEnabled  feature="wishList">									
									<div class="addToWishListButtonBorder">
										<div class="tertiary_button_shadow" id="addToWishListButton_1">
											<div class="tertiary_button left">
												<a id="WC_CachedItemDisplay_links_5" href="javascript: categoryDisplayJS.AddItem2WishListAjax('<c:out value='${item.itemID}'/>')"><fmt:message key="WISHLIST" bundle="${storeText}" /> </a>
											</div>
										</div>						
									</div>
								</flow:ifEnabled>
								<flow:ifEnabled  feature="SOAWishlist">		
									<%out.flush();%>
										<c:import url="${jspStoreDir}Snippets/MultipleWishList/MultipleWishListButton.jsp">
											<c:param name="catEntryId" value="${item.itemID}"/>	
											<c:param name="type" value="item"/>	
										</c:import>				
									<%out.flush();%>																				
								</flow:ifEnabled>
								<flow:ifEnabled feature="RequisitionList">
									<c:set var="type" value="item" />
									<%@include file="../../../ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListLinks.jspf" %>
								</flow:ifEnabled>									
							 </div>
						</flow:ifEnabled>
						
						<flow:ifDisabled feature="AjaxAddToCart">
							<form name="OrderItemAddForm_<c:out value='${item.itemID}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderItemAddForm_<c:out value='${item.itemID}'/>">
								<input type="hidden" name="storeId" value="<c:out value='${WCParam.storeId}'/>" id="OrderItemAddForm_storeId_<c:out value='${item.itemID}'/>"/>
								<input type="hidden" name="langId" value="<c:out value='${WCParam.langId}'/>" id="OrderItemAddForm_langId_<c:out value='${item.itemID}'/>"/>
								<input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="OrderItemAddForm_catalogId_<c:out value='${item.itemID}'/>"/>
								<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="OrderItemAddForm_URL_<c:out value='${item.itemID}'/>"/>
								<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="WC_CachedItemDisplay_inputs_1"/>
								<input type="hidden" name="catEntryId" value="<c:out value='${item.itemID}'/>" id="WC_CachedItemDisplay_inputs_2"/>
								<input type="hidden" name="productId" value="<c:out value='${item.itemID}'/>" id="WC_CachedItemDisplay_inputs_3"/>
								<input type="hidden" name="quantity" value="1" id="WC_CachedItemDisplay_inputs_5"/>
								<input type="hidden" name="page" value="" id="WC_CachedItemDisplay_inputs_6"/>
								<input type="hidden" name="contractId" value="" id="WC_CachedItemDisplay_inputs_7"/>
								<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_CachedItemDisplay_inputs_8"/>
								<input type="hidden" name="updateable" value="0" id="WC_CachedItemDisplay_inputs_9"/>
								<flow:ifEnabled feature="SOAWishlist">
								<input type="hidden" name="giftListId" value="<c:out value='${giftListId}'/>" id="<c:out value='OrderItemAddForm_${item.itemID}_giftListId_${giftListId}'/>"/>
								</flow:ifEnabled>								
							</form>
						<div>
							 <span class="primary_button" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												 <a href="#" onclick="javascript:categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_<c:out value='${item.itemID}'/>'),document.getElementById('quantity_<c:out value='${item.itemID}'/>').value);return false;" id="WC_CachedItemDisplay_links_6"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
								 			</span>
										</span>	
									</span>
								</span>
							</span>	
						</div>
							 <div class="features" id="WC_CachedItemDisplay_div_12">
								 <flow:ifEnabled feature="ProductCompare">
								 	<div>
										<div class="tertiary_button_shadow">
											<div class="tertiary_button">
											<a id="WC_CachedItemDisplay_links_7" href="JavaScript:compareProductJS.Add2CompareAjax('<c:out value='${item.itemID}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');"><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a>
											</div>
										</div>
									</div>
								 </flow:ifEnabled>
								 <flow:ifEnabled  feature="wishList">
									<div class="addToWishListButtonBorder">
										<div class="tertiary_button_shadow" id="addToWishListButton_1">
											<div class="tertiary_button left">
											<a id="WC_CachedItemDisplay_links_8" href="javascript: categoryDisplayJS.AddItem2WishList(document.getElementById('OrderItemAddForm_<c:out value='${item.itemID}'/>'))"><fmt:message key="WISHLIST" bundle="${storeText}" /> </a>
											</div>
										</div>						
									</div>
								 </flow:ifEnabled>
								 <flow:ifEnabled  feature="SOAWishlist">
									<%out.flush();%>
										<c:import url="${jspStoreDir}Snippets/MultipleWishList/MultipleWishListButton.jsp">
											<c:param name="catEntryId" value="${item.itemID}"/>	
											<c:param name="type" value="item"/>	
										</c:import>				
									<%out.flush();%>																												
								 </flow:ifEnabled>
								 <flow:ifEnabled feature="RequisitionList">
									<c:set var="type" value="item" />
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
												<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_CachedItemDisplay_links_9"><fmt:message key="RETURN_SHOPPING" bundle="${storeText}" /></a>
											</span>
										</span>	
									</span>
								</span>
							</span>
						</div>
					
					</c:otherwise>
				</c:choose>
				<c:if test="${isBrazilStore}">
	           	<%-- 
	   			  ***
	   				*	Start: Show the related Discounts in a group box
	   			  ***
	   			--%>
	   			  <div id="WC_RelatedDiscountDisplay_div_1" >
	   			    <br />
	                  <fieldset class="related_discounts">
	   			      <legend><fmt:message key="RELATED_DISCOUNTS" bundle="${brazilStoreText}" /></legend>
	   			      <%-- We output the discounts, already formatted with HTML tags --%>
	   			      <script type="text/javascript">
						document.write(Discount.getProductDiscountText(<c:out value="${productId}"/>));
					  </script>
	                 </fieldset>                 
	   			  </div>
	   			</c:if>
				<%@ include file="CachedItemButtonExt.jspf"%>
				<%@ include file="GiftRegistryCachedItemButtonExt.jspf"%>
				<br />
			 	<%out.flush();%>
				<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryInventoryStatus.jsp">
					<c:param name="fromPage" value="${fromPage}"/>
					<c:param name="catentryId" value="${item.itemID}"/>
				</c:import>
				<%out.flush();%>
				<%@ include file="CatalogEntryInventoryStatusEIExt.jspf"%>
				<%-- 
			  ***
				*	End: Page action buttons
				***
			--%>	
		</div>
		</span>
		<br/>
		<%-- 
							  ***
							  *	Start: Cross-Sell, Up-Sell, Accessory, Replacement
							  * Include MerchandisingAssociationsDisplay.jsp if Cross-Sell, Up-Sell, Accessory, Replacement are set up
							  ***
							--%>
							<%-- Flush the buffer so this fragment JSP is not cached twice --%>
							<%out.flush();%>
						        <c:import url="${jspStoreDir}Snippets/Catalog/MerchandisingAssociations/MerchandisingAssociationsDisplay.jsp">
				            			<c:param name="catalogEntryType" value="ItemBean"/>
				            			<c:param name="pageView" value="image"/>
				        		</c:import>
							<%out.flush();%>
							<%-- 
							  ***										  
							  *	End: Cross-Sell, Up-Sell, Accessory, Replacement
							  ***
							--%>		
		<br clear="all" />
		<br />
		<flow:ifDisabled feature="ProductDetailDescListView">
			<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("WC_CachedItemDisplay_div_15"); });</script>
			<c:set var="productDescHeaderListView" value="nodisplay"/>			
		</flow:ifDisabled>
		<flow:ifEnabled feature="ProductDetailDescListView">
			<c:set var="productDescHeaderListView" value="productDescHeaderList"/>
			<c:set var="HideTabsForListview" value="nodisplay" />
		</flow:ifEnabled>
		<div class="specs" id="WC_CachedItemDisplay_div_15">
			 <div class="tabs ${HideTabsForListview}"  id="WC_CachedItemDisplay_div_16">
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
			 	 <%@ include file="CachedItemTabsExt.jspf"%>
			 </div>
			 <br/>
			 <div id="mainTabContainer" class="info" dojoType="dijit.layout.TabContainer" selectedTab="Description" doLayout="false" tabPosition="left-h">
				  <div id="Description" dojoType="dijit.layout.ContentPane" >
				  	<div class="${productDescHeaderListView}"><fmt:message key="DESCRIPTION" bundle="${storeText}" /></div>
				  	<p>
							<fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${item.partNumber}" escapeXml="false"/>
			 			</p>
				  	<p>
				  		<c:out value="${item.description.shortDescription}" escapeXml="false"/>
				  	</p>
						<br />
						<p>
							<span itemprop="description">
								<c:out value="${item.description.longDescription}" escapeXml="false"/>
							</span>
						</p>
						<p>
										<%--
										  ***
										  * Start: Display Defining and Descriptive attributes
										  * First, loop through the attribute values and display the defining attributes
										  * Then, display the item descriptive attributes and show the corresponding images if available
										  * If the item does not have descriptive attributes, get the attributes from the parent item.
										  ***
										--%>
										<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="catalogEntryAttributes" expressionBuilder="getStoreCatalogEntryAttributesParentByID">
											<wcf:contextData name="storeId" data="${param.storeId}"/>
											<wcf:param name="catEntryId" value="${item.itemID}"/>
											<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
										</wcf:getData>
										
										<c:forEach var='catalogEntryWithAtt' items='${catalogEntryAttributes}'>
											<c:choose>
												<c:when test="${ catalogEntryWithAtt.catalogEntryIdentifier.uniqueID == productId }">
													<c:set var="itemWithAttr" value="${catalogEntryWithAtt}"/>												
												</c:when>
												<c:otherwise>
													<c:set var="parentWithAttr" value="${catalogEntryWithAtt}"/>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<br/>
										<c:set var="defnAttrCount" value="0"/>
										<c:forEach var="attribute" items="${itemWithAttr.catalogEntryAttributes.attributes}">
											<c:if test="${ attribute.usage=='Defining' }" >	
												<c:set var="defnAttrCount" value="${defnAttrCount + 1}"/>
												<span class="strongtext" id="definingAttributeName_${defnAttrCount}"><c:out value="${attribute.name}"  escapeXml="false" />: </span><span id="definingAttributeValue_${defnAttrCount}"><c:out value="${attribute.value.value}"  escapeXml="false" /></span>																				
												<br/>
											</c:if>
										</c:forEach>
											
										<c:set var="descAttrCount" value="0"/>
										<c:forEach var="attribute" items="${itemWithAttr.catalogEntryAttributes.attributes}">
											<c:if test="${ attribute.usage=='Descriptive' }" >	
												<c:set var="descAttrCount" value="${descAttrCount + 1}"/>
												<span class="strongtext" id="descAttributeName_${descAttrCount}"><c:out value="${attribute.name}"  escapeXml="false" />:</span>
												<c:choose>
													<c:when test="${ !empty attribute.extendedValue['Image1']  }" >
														<span id="descAttributeValue_${descAttrCount}"><c:out value="${attribute.value.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${item.objectPath}${attribute.extendedValue['Image1']}" />" alt="<c:out value="${attribute.value.value}" />" border="0"/></span><br/>												
													</c:when>
													<c:otherwise >
														<span id="descAttributeValue_${descAttrCount}"><c:out value="${attribute.value.value}"  escapeXml="false"  /></span>
													</c:otherwise>
												</c:choose>
												<br/>												
											</c:if>
										</c:forEach>
										
										<c:if test="${descAttrCount == 0}">
											<c:forEach var="attribute" items="${parentWithAttr.catalogEntryAttributes.attributes}">
												<c:if test="${ attribute.usage=='Descriptive' }" >
													<c:set var="descAttrCount" value="${descAttrCount + 1}"/>
													<span class="strongtext" id="descAttributeName_${descAttrCount}"><c:out value="${attribute.name}"  escapeXml="false" />:</span>
													<c:choose>
														<c:when test="${ !empty attribute.extendedValue['Image1']  }" >
															<span id="descAttributeValue_${descAttrCount}"><c:out value="${attribute.value.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${item.parentProductDataBean.objectPath}${attribute.extendedValue['Image1']}" />" alt="<c:out value="${attribute.value.value}" />" border="0"/></span><br/>												
														</c:when>
														<c:otherwise >
															<span id="descAttributeValue_${descAttrCount}"><c:out value="${attribute.value.value}"  escapeXml="false"  /></span>
														</c:otherwise>
													</c:choose>
													<br/>
												</c:if>
											</c:forEach>
										</c:if>
										
										<%--
										  ***
										  * End: Display Defining and Descriptive attributes
										  ***
										--%>
						</p>
				  </div>
				 <div id="Attachments" href="<c:out value='${CatalogAttachmentURL}'/>" parseOnLoad="false" dojoType="dijit.layout.ContentPane" >
					<div class="${productDescHeaderListView}"><fmt:message key="ATTACHMENTS" bundle="${storeText}" /></div>
					<flow:ifEnabled  feature="ProductDetailDescListView"> 
						<%out.flush();%> 
						<c:import url="${jspStoreDir}Snippets/Catalog/Attachments/CatalogAttachmentAssetsDisplay.jsp">  
							   <c:param name="storeId" value="${WCParam.storeId}"/>  
							   <c:param name="catalogId" value="${WCParam.catalogId}"/>  
							   <c:param name="langId" value="${langId}"/>  
							   <c:param name="productId" value="${item.itemID}"/>  
							   <c:param name="catType" value="item"/>  
							   <c:param name="excludeUsageStr" value="ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,ANGLEIMAGES_HDIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40,IMAGE_SIZE_330,IMAGE_SIZE_1000"/>  
							   <c:param name="retrieveLanguageIndependentAtchAst" value="1"/>  
						</c:import>  
						<%out.flush();%> 
					</flow:ifEnabled>				  
				  </div>
				  <%@ include file="CachedItemTabPanesExt.jspf"%>
			 </div>
			 <div class="tabfooter" id="WC_CachedItemDisplay_div_17"></div>
		</div>
   </div>
  </div>
 </div>
<!-- END CachedItemDisplay.jsp -->
