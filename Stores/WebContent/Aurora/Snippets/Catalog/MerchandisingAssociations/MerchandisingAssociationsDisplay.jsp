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
  * This JSP code snippet displays will show the cross-sell, up-sell, or accessory catalog entries if they are set up.
  * You can set up merchandising associations in the accelerator. This JSP is included by the catalog entry display pages
  * (e.g. CachedProductOnlyDisplay.jsp).
  *    
  *
  * Prerequisites:
  * 1. This snippet requires a parameter "catalogEntryType". 
  *	
  *    This value is used to determine what bean to instantiate on this page.  For example, if this
  *    page is imported to display a merchandising association for a product, the catalogEntryType
  *	   would be ProductBean.
  *	   Possible values are:
  *		- ProductBean
  *		- ItemBean
  *		- PackageBean
  *		- BundleBean
  *		- DynamicKitBean
  *
  *    This snippet requires a file "JSTLEnvironmentSetup.jspf" to set up property bundles and other JSTL variables.
  *    Example JSTLEnvironmentSetup.jspf files are included in these starter stores:
  *     - ConsumerDirect
  *     - AdvancedB2BDirect
  *
  * How to use this snippet? 
  * 1. To use this snippet, dynamically include this JSP from pages which display products, items, packages or bundles.
  *    Ensure that you pass the parameter "catalogEntryType" to this JSP to specify which type of catalog information you
  *    are displaying.
  *
  *    If your store is based on the ConsumerDirect starter store, the JSP pages that use this snippet include:
  *     - CachedProductItemDisplay.jsp
  *     - CachedProductOnlyDisplay.jsp            
  *     - CachedItemDisplay.jsp   
  *     - CachedPackageDisplay.jsp
  *     - CachedBundleDisplay.jsp
  *		- CachedDynamicKitDisplay.jsp
  *
  *    If your store is based on the AdvancedB2BDirect starter store, the JSP pages that use this snippet include:
  *     - CachedProductDisplay.jsp
  *     - CachedItemDisplay.jsp
  *     - CachedPackageDisplay.jsp
  *     - CachedBundleDisplay.jsp
  *		- CachedDynamicKitDisplay.jsp
  *           
  *****          
--%>

<!-- BEGIN MerchandisingAssociationsDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
      
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<!-- Start - JSP File Name:  MerchandisingAssociationsDisplay.jsp -->


<%-- 
  ***
  * Create a bean based on the catalogEntryType passed into this JSP.  In most cases the bean will be alive in the request scope
  * so it will not have to be reactivated. 
  ***
--%>
<c:set var="search" value='"'/>
<c:set var="replaceCmprStr" value=""/>
<c:set var="search01" value="'"/>
<c:set var="replace02" value="inches"/>

<c:set var="showProductQuickView" value="false"/>
<flow:ifEnabled feature="ProductQuickView">   
	<c:set var="showProductQuickView" value="true"/>
</flow:ifEnabled>

<c:set var="miniShopCartEnabled" value="false"/>
<flow:ifEnabled feature="miniShopCart">
	<c:set var="miniShopCartEnabled" value="true"/>
</flow:ifEnabled>

<c:set var="compareEnabled" value="false"/>
<flow:ifEnabled feature="ProductCompare">
	<c:set var="compareEnabled" value="true"/>
</flow:ifEnabled>

<c:set var="productDragAndDrop" value="false"/>
<flow:ifEnabled feature="ProductDnD">
	<c:if test="${miniShopCartEnabled || compareEnabled}">
		<c:set var="productDragAndDrop" value="true"/>
	</c:if>
</flow:ifEnabled>

<c:set var="catEntry" value="${requestScope.catalogEntryDetails}" />

<jsp:useBean id="catEntryAssociationMap" class="java.util.HashMap" scope="request"/>
<jsp:useBean id="catEntryTypeAssociation" class ="java.util.HashMap" scope="request"/>
<c:set var="totalAssociationCount" value="0"/>

<%--
  ***
  * Loop through all the merchandising association types.  We loop through each type, one at a time and display 
  * the associations in AssociateCatentriesDisplay.jspf.  
  ***   
--%>  

<c:if test="${fn:length(catEntry.merchandisingAssociations) != 0}">
	<c:forEach var="merchandisingAssociation" items="${catEntry.merchandisingAssociations}" varStatus="counter">

		<c:set var="merchandisingAssociationEntry" value="${merchandisingAssociation.catalogEntryView}" />
		<%-- 
		  ***
		  * Get the entitled items for the product bean and for the associated product bean.
		  ***
		--%>  
		<c:if test="${merchandisingAssociationEntry.catalogEntryTypeCode eq 'ProductBean' && merchandisingAssociation.associationType ne 'replacement'}">		
			<div id="entitledItem_<c:out value='${merchandisingAssociationEntry.uniqueID}'/>" style="display:none;">
				[
				<c:forEach var='entitledItem' items='${merchandisingAssociationEntry.SKUs}' varStatus='outerStatus'>
					{
						"catentry_id" : "<c:out value='${entitledItem.uniqueID}' />",
						"Attributes" :	{
							<c:set var="hasAttributes" value="false"/>
							<c:forEach var="definingAttrValue2" items="${entitledItem.attributes}" varStatus="innerStatus">
								<c:if test="${definingAttrValue2.usage == 'Defining'}">
									<c:if test='${hasAttributes eq "true"}'>,</c:if>
									"<c:out value="${definingAttrValue2.name}_${fn:replace(definingAttrValue2.values[0].value, search, replace02)}" />":"<c:out value='${innerStatus.count}' />"
									<c:set var="hasAttributes" value="true"/>
								</c:if>	
							</c:forEach>
						}
					}<c:if test='${!outerStatus.last}'>,</c:if>	
				</c:forEach>
				]
			</div>        
		</c:if>
		
		<%--
		  ***
		  * Start: Display Bundle    
		  ***		
		 --%> 
		<c:if test="${merchandisingAssociationEntry.catalogEntryTypeCode eq 'BundleBean' && merchandisingAssociation.associationType ne 'replacement'}">	
			<%-- 
			***
			* Start:  Get all product and item IDs displayed on this page and pass them to the discount code
			***
			--%>
			<form name="OrderAssociateItemAddForm_<c:out value='${merchandisingAssociationEntry.uniqueID}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderAssociateItemAddForm_<c:out value='${merchandisingAssociationEntry.uniqueID}'/>">
				<input type="hidden" name="langId" value="<c:out value="${WCParam.langId}" />" id="WC_AssociationDisplay_FormInput_langId_In_OrderAssociationItemAddForm_1"/>
				<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_AssociationDisplay_FormInput_storeId_In_OrderAssociationItemAddForm_1"/>
				<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_AssociationDisplay_FormInput_catalogId_In_OrderAssociationItemAddForm_1"/>
				<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="WC_AssociationDisplay_FormInput_URL_In_OrderAssociationItemAddForm_1"/>
				<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="WC_AssociationDisplay_FormInput_errorViewName_In_OrderAssociationItemAddForm_1"/>
				<%-- shouldCachePage is used to tell the server not to cache this page.  So if an error happens, this page is redrawn with an error message --%>
				<input type="hidden" name="shouldCachePage" value="false" id="WC_AssociationDisplay_FormInput_shouldCachePage_In_OrderAssociationItemAddForm_1"/>
				<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="WC_AssociationDisplay_FormInput_calcUsage_In_OrderAssociationItemAddForm_1"/>
			
				<%-- Create a comma delimited string containing all IDs to pass to the discount code.
				For an in depth explanation of why this is done, see DiscountJavaScriptSetup.jsp --%>
				<script type="text/javascript">
					if(!entitledItems)
						var entitledItems = [];
				</script>

				<c:set var="someAssociateItemIDs" value="" />
				<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="targetCatalogNavigationView"
					expressionBuilder="getCatalogEntryViewDetailsWithComponentsAndAttachmentsByID" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0">
					<wcf:param name="UniqueID" value="${merchandisingAssociationEntry.uniqueID}"/>
					<wcf:contextData name="storeId" data="${WCParam.storeId}" />
					<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
				</wcf:getData>
				<c:set var="targetCatEntry" value="${targetCatalogNavigationView.catalogEntryView[0]}" />
				<c:forEach var="bundleComponent" items="${targetCatEntry.components}" varStatus="status">
					<c:set var="bundleComponentDetails" value="${bundleComponent.catalogEntryView}" />
					<c:choose>
						<c:when test="${empty someAssociateItemIDs}">
							<c:set var="someAssociateItemIDs" value="${bundleComponentDetails.uniqueID}" />
							<input type="hidden" name="quantity_<c:out value='${bundleComponentDetails.uniqueID}'/>" value="1" id="quantity_<c:out value='${bundleComponentDetails.uniqueID}'/>"/>
						</c:when>	
						<c:otherwise>
							<c:set var="someAssociateItemIDs" value="${someAssociateItemIDs},${bundleComponentDetails.uniqueID}" />
							<input type="hidden" name="quantity_<c:out value='${bundleComponentDetails.uniqueID}'/>" value="1" id="quantity_<c:out value='${bundleComponentDetails.uniqueID}'/>"/>
						</c:otherwise>	
					</c:choose>	

					<c:if test="${bundleComponentDetails.catalogEntryTypeCode eq 'ProductBean'}">
						<script type="text/javascript">
							<c:forEach var="entitledItem" items="${bundleComponentDetails.SKUs}" varStatus="status">
								var item = new Object();
								item["catentry_id"] = "<c:out value='${entitledItem.uniqueID}' />";
								item["Attributes"] = new Object();
								
								<c:forEach var="definingAttrValue2" items="${entitledItem.attributes}" varStatus="innerStatus">
									<c:if test="${definingAttrValue2.usage == 'Defining'}">
										item["Attributes"]["<c:out value="${definingAttrValue2.name}_${fn:replace(definingAttrValue2.values[0].value, search, replace02)}" />"] = "<c:out value='${status.count}' />";
									</c:if>	
								</c:forEach>
							
								entitledItems.push(item);
							</c:forEach>
							categoryDisplayJS.setDefaultItem('<c:out value='${bundleComponentDetails.uniqueID}'/>','${bundleComponentDetails.SKUs[0].uniqueID}');					
						</script>
					</c:if>
				</c:forEach>

				<script type="text/javascript">
					categoryDisplayJS.setEntitledItems(entitledItems);
				</script>

								
				<%-- 
				***
				* End:  Get all product and item IDs displayed on this page and pass them to the discount code
				***
				--%>
				<input type="hidden" name="catEntryIDS" value="<c:out value='${someAssociateItemIDs}'/>"/>
				<input type="hidden" name="productId" value="<c:out value="${merchandisingAssociationEntry.uniqueID}" />" id="WC_AssociationDisplay_FormInput_productId_In_OrderItemAddForm_1"/>
			</form>
		</c:if>  
	
		<%-- 
		***
		* Handle the case where a catalog entry may not have a price.
		* If there is no price, mark it as not buyable and set price to 0 so total can be calculated.
		***
		--%>
		<c:set var="buyable" value="${merchandisingAssociationEntry.buyable}" />
		<c:catch var ="noPriceException">
			<c:forEach var="associatedPrice" items="${merchandisingAssociationEntry.price}" >
				<c:if test="${associatedPrice.priceUsage == 'Offer'}">
					<c:set var="price" value="${associatedPrice.value.value}" />
				</c:if>
			</c:forEach>
		</c:catch>

		<c:if test = "${noPriceException!=null}">
			<c:set var="price" value="0"/>
			<c:set var="buyable" value="false" />
		</c:if>

		<c:set var="compareImageDescription" value="${fn:replace(merchandisingAssociationEntry.shortDescription, search, replaceCmprStr)}"/>
		<c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>
		
		<%-- 
		  ***
		  *Create a JSON object with all the details like catentryidentifier, name etc of the associated product to be used in the javascript.
		  ***
		--%>
		<c:set var="catEntryIDToUse" value="${merchandisingAssociationEntry.uniqueID}"/>
		<c:set var="catEntryTypeToUse" value="${merchandisingAssociationEntry.catalogEntryTypeCode}"/>
		<c:if test="${merchandisingAssociationEntry.catalogEntryTypeCode == 'ProductBean' && merchandisingAssociationEntry.hasSingleSKU == 'true'}">
			<c:set var="catEntryIDToUse" value="${merchandisingAssociationEntry.singleSKUCatalogEntryID}"/>
			<c:set var="catEntryTypeToUse" value="ItemBean"/>
		</c:if>

		<c:choose>
			<c:when test = "${catEntryTypeToUse == 'ProductBean'}">
				<c:set var="patternName" value="ProductURL"/>
			</c:when>
			<c:otherwise>
				<c:set var="patternName" value="CanonicalItemURL"/>
			</c:otherwise>
		</c:choose>

		<wcf:url var="associatedProductDisplayURL" patternName="${patternName}" value="Product2">
		  <wcf:param name="langId" value="${WCParam.langId}" />
		  <wcf:param name="storeId" value="${WCParam.storeId}" />
		  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
		  <wcf:param name="productId" value="${catEntryIDToUse}" />
		  <wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>

		<div id="associatedCatEntries_<c:out value='${counter.count}'/>" style="display:none;">
			[
				{
					'catEntry_Identifier' : '<c:out value='${catEntryIDToUse}'/>',
					'catEntry_Type' : '<c:out value='${catEntryTypeToUse}'/>',
					'catEntry_BundleFormId' : 
						<c:choose>
							<c:when test="${merchandisingAssociationEntry.catalogEntryTypeCode == 'BundleBean'}">
								'<c:out value='OrderAssociateItemAddForm_${merchandisingAssociationEntry.uniqueID}'/>',
							</c:when>
							<c:otherwise>
								'<c:out value=" "/>',
							</c:otherwise>
						</c:choose>							
					'catEntry_Name' : <wcf:json object="${merchandisingAssociationEntry.name}"/>,
					'catEntry_Thumbnail' :
						<c:choose>
							<c:when test="${!empty merchandisingAssociationEntry.thumbnail}">
								'<c:out value='${merchandisingAssociationEntry.thumbnail}'/>',
							</c:when>
							<c:otherwise>
								'<c:out value='${hostPath}${jspStoreImgDir}'/>images/NoImageIcon_sm.jpg',
							</c:otherwise>
						</c:choose>			
					'catEntry_ShortDescription' : "<c:out value='${compareImageDescription}'/>",		
					'catEntry_Price' : "<c:out value='${price}'/>", 
					'catEntry_ProductLink' : '<c:out value='${associatedProductDisplayURL}'/>',
					'showProductQuickView' : '<c:out value='${showProductQuickView}'/>',
					'showProductQuickViewLable' : "<fmt:message key='QUICKINFO' bundle='${storeText}'/>",
					'productDragAndDrop' : '<c:out value='${productDragAndDrop}'/>',
					'associationProductBuyable' : "<c:out value='${buyable}'/>",
					'catEntry_Thumbnail_compare' : 
													<c:set var="image40Attachment" value="" />
													<c:forEach var="attachment" items="${merchandisingAssociationEntry.attachments}">
														<c:if test="${attachment.usage == 'IMAGE_SIZE_40'}">
															<c:set var="image40Attachment" value="${attachment}" />
														</c:if>
													</c:forEach>
													<c:choose>
														<c:when test="${!empty image40Attachment}">
															'<c:out value='${staticAssetContextRoot}/${image40Attachment.attachmentAssetPath}'/>'
														</c:when>
														<c:when test="${!empty merchandisingAssociationEntry.thumbnail}">
															'<c:out value='${merchandisingAssociationEntry.thumbnail}'/>'
														</c:when>
														<c:otherwise>
															'<c:out value='${hostPath}${jspStoreImgDir}'/>images/NoImageIcon_sm45.jpg'
														</c:otherwise>
													</c:choose>												
				}
			]
		</div>
	</c:forEach>	

	<%-- 
	  ***
	  *Create a JSON object with all the details of the parent product to be used in the javascript.
	  ***
	--%> 
	<c:forEach var="parentProductPrice" items="${catEntry.price}" >		
		<c:if test="${parentProductPrice.priceUsage == 'Offer'}">
			<c:set var="calculatedPrice" value="${parentProductPrice.value.value}" />
		</c:if>
	</c:forEach>

	<c:catch var ="noPriceException">		
		<c:set var="merprice" value="${calculatedPrice}" />
	</c:catch>
	<c:if test = "${noPriceException!=null}">
		<c:set var="merprice" value="0"/>
	</c:if>

	<div id="baseCatEntryDetails" style="display:none;">
		[
			{
				'baseCatEntry_Name' : <wcf:json object="${catEntry.name}"/>,
				'storeImage_Path' : '<c:out value='${hostPath}${jspStoreImgDir}${vfileColor}'/>',
				'baseCatEntry_Price' : '<c:out value='${merprice}'/>',
				'totalAssociations' : '<c:out value='${fn:length(catEntry.merchandisingAssociations)}'/>',
				'associatedProductsName':"<fmt:message key='MERCHANDISING_ASSOCIATION_PRODUCT_NAME' bundle='${storeText}'><fmt:param value='%0'/><fmt:param value='%1'/></fmt:message>",
				'currency' : '<c:out value='${CommandContext.currency}'/>'
			}
		]	
	</div>

	<%-- 
	  ***
	  *Display the parent product together with the associated product in the product display page.
	  ***
	--%> 
	<div class="combo_area" id="WC_MerchandisingAssociationsDisplay_div_1">

		<c:choose>
			<c:when test="${!empty catEntry.thumbnail}">
				<div class="product_image" id="WC_MerchandisingAssociationsDisplay_div_2"><img src="<c:out value="${catEntry.thumbnail}"/>" alt="<c:out value="${catEntry.shortDescription}" />" class="img" width="70" height="70"/></div>
			</c:when>
			<c:otherwise>
				<div class="product_image" id="WC_MerchandisingAssociationsDisplay_div_3"><img src="<c:out value="${hostPath}${jspStoreImgDir}" />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" class="img" width="70" height="70"/></div>
			</c:otherwise>
		</c:choose>
		
		<div class="plus_image" id="WC_MerchandisingAssociationsDisplay_div_4">
			<img src="<c:out value="${hostPath}${jspStoreImgDir}${vfileColor}" />i_plus.png" alt="<fmt:message key="No_Image" bundle="${storeText}"/>"/>
		</div>		

		<div id="marchandisingAssociationDisplay">
		</div>

		<fmt:message var="totalPriceMsgValue"  key='MA_TOTALPRICE' bundle='${storeText}'/>
		<input type="hidden" name="totalPriceMsg" value="<c:out value='${totalPriceMsgValue}'/>" id="totalPriceMsg"/>
		<div class="combo_button" id="WC_MerchandisingAssociationsDisplay_div_5">
			<c:choose>
				<c:when test="${catEntry.buyable}" >
					<%-- 
					  ***
					  *Product: Ajax Add to cart 
					  ***
					--%> 
					<flow:ifEnabled feature="AjaxAddToCart"> 
						 <span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<c:if test="${param.catalogEntryType=='ProductBean'}">
												<a href="javascript:setCurrentId('WC_MerchandisingAssociationsDisplay_links_1'); categoryDisplayJS.AddAssociation2ShopCartAjax('entitledItem_<c:out value='${catEntry.uniqueID}'/>',document.getElementById('quantity_<c:out value='${catEntry.uniqueID}'/>').value)" id="WC_MerchandisingAssociationsDisplay_links_1"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a><br />
											</c:if>
											<c:if test="${param.catalogEntryType=='ItemBean'}">
												<a href="javascript:setCurrentId('WC_MerchandisingAssociationsDisplay_links_4'); categoryDisplayJS.AddAssociationItem2ShopCartAjax('<c:out value='${catEntry.uniqueID}'/>',document.getElementById('quantity_<c:out value='${catEntry.uniqueID}'/>').value)" id="WC_MerchandisingAssociationsDisplay_links_4"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</c:if>
											<c:if test="${param.catalogEntryType=='PackageBean'}">
												<a href="javascript:setCurrentId('WC_MerchandisingAssociationsDisplay_links_6'); categoryDisplayJS.AddAssociationItem2ShopCartAjax('<c:out value='${catEntry.uniqueID}'/>',document.getElementById('quantity_<c:out value='${catEntry.uniqueID}'/>').value)" id="WC_MerchandisingAssociationsDisplay_links_6"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</c:if>
											<c:if test="${param.catalogEntryType=='BundleBean'}">
												<a href="javascript:setCurrentId('WC_MerchandisingAssociationsDisplay_links_8'); categoryDisplayJS.AddAssociationBundle2ShopCartAjax(document.getElementById('OrderItemAddForm_<c:out value='${catEntry.uniqueID}'/>'))"  id="WC_MerchandisingAssociationsDisplay_links_8"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</c:if>
										</span>
									</span>	
								</span>
							</span>
						</span>	
					</flow:ifEnabled>
					
					<%-- 
					  ***
					  *Product: NON-Ajax Add to cart 
					  ***
					--%> 
					<flow:ifDisabled feature="AjaxAddToCart">
						<form name="OrderAssociationItemAddForm_<c:out value='${catEntry.uniqueID}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderAssociationItemAddForm_<c:out value='${catEntry.uniqueID}'/>">
							<input type="hidden" name="storeId" value="<c:out value='${WCParam.storeId}'/>" id="OrderAssociationItemAddForm_storeId_<c:out value='${catEntry.uniqueID}'/>"/>
							<input type="hidden" name="langId" value="<c:out value='${WCParam.langId}'/>" id="OrderAssociationItemAddForm_langId_<c:out value='${catEntry.uniqueID}'/>"/>
							<input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="OrderAssociationItemAddForm_catalogId_<c:out value='${catEntry.uniqueID}'/>"/>
							<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="OrderAssociationItemAddForm_url_<c:out value='${catEntry.uniqueID}'/>"/>
							<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="OrderAssociationItemAddForm_errorViewName_<c:out value='${catEntry.uniqueID}'/>"/>
							<input type="hidden" name="catEntryId_1" value="<c:out value='${catEntry.uniqueID}'/>" id="OrderAssociationItemAddForm_catEntryId_1_<c:out value='${catEntry.uniqueID}'/>"/>
							<input type="hidden" name="productId_1" value="<c:out value='${catEntry.uniqueID}'/>" id="OrderAssociationItemAddForm_productId_1_<c:out value='${catEntry.uniqueID}'/>"/>
							<input type="hidden" name="catEntryId_2" value="" id="OrderAssociationItemAddForm_catEntryId_2_<c:out value='${catEntry.uniqueID}'/>"/>
							<input type="hidden" name="productId_2" value="" id="OrderAssociationItemAddForm_productId_2_<c:out value='${catEntry.uniqueID}'/>"/>
							<input type="hidden" name="quantity_1" value="1" id="OrderAssociationItemAddForm_quantity_1_<c:out value='${catEntry.uniqueID}'/>"/>
							<input type="hidden" name="quantity_2" value="1" id="OrderAssociationItemAddForm_quantity_2_<c:out value='${catEntry.uniqueID}'/>"/>
							<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="OrderAssociationItemAddForm_calcUsage_<c:out value='${catEntry.uniqueID}'/>"/>
						</form>
						<span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">  
											<c:if test="${param.catalogEntryType=='ProductBean'}">
												<a href="#" onclick="javascript:setCurrentId('WC_MerchandisingAssociationsDisplay_links_2'); categoryDisplayJS.AddMarchandisingAssociation2ShopCart('entitledItem_<c:out value='${catEntry.uniqueID}'/>',document.getElementById('OrderAssociationItemAddForm_<c:out value='${catEntry.uniqueID}'/>'),document.getElementById('quantity_<c:out value='${catEntry.uniqueID}'/>').value);return false;" id="WC_MerchandisingAssociationsDisplay_links_2"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</c:if>
											<c:if test="${param.catalogEntryType=='ItemBean'}">
												<a href="javascript:categoryDisplayJS.AddAssociationItem2ShopCart(document.getElementById('OrderAssociationItemAddForm_<c:out value='${catEntry.uniqueID}'/>'),document.getElementById('quantity_<c:out value='${catEntry.uniqueID}'/>').value)" id="WC_MerchandisingAssociationsDisplay_links_5"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</c:if>
											<c:if test="${param.catalogEntryType=='PackageBean'}">
												<a href="javascript:categoryDisplayJS.AddAssociationItem2ShopCart(document.getElementById('OrderAssociationItemAddForm_<c:out value='${catEntry.uniqueID}'/>'),document.getElementById('quantity_<c:out value='${catEntry.uniqueID}'/>').value)" id="WC_MerchandisingAssociationsDisplay_links_7"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</c:if>
											<c:if test="${param.catalogEntryType=='BundleBean'}">
												<a href="javascript:categoryDisplayJS.AddAssociationBundle2ShopCart(document.getElementById('OrderItemAddForm_<c:out value='${catEntry.uniqueID}'/>'))" id="WC_MerchandisingAssociationsDisplay_links_9"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
											</c:if>
										</span>
									</span>	
								</span>
							</span>
						</span>	
						<br />
					</flow:ifDisabled>   
				</c:when>
				<c:otherwise>
					<p>
						<fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" />
					</p>
					<wcf:url var="TopCategoriesDisplayURL" value="TopCategories1">
					  <wcf:param name="langId" value="${langId}" />
					  <wcf:param name="storeId" value="${WCParam.storeId}" />
					  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
					</wcf:url>
					<p>
						<span class="primary_button button_fit" >
							<span class="button_container">
								<span class="button_bg">
									<span class="button_top">
										<span class="button_bottom">   
											<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_MerchandisingAssociationsDisplay_links_3"><fmt:message key="RETURN_SHOPPING" bundle="${storeText}" /></a>
										</span>
									</span>	
								</span>
							</span>
						</span>	
					</p>
				</c:otherwise>
			</c:choose>
		</div>
		
		<%-- 
		  ***
		  *Initialize the association start index to scroll the associated products in the display. 
		  ***
		--%> 
		<script type="text/javascript">
			dojo.addOnLoad(function() { 
				var startIndex="1";
				categoryDisplayJS.displayNextAssociation = "<fmt:message key="SHOW_NEXT_ASSOCIATION" bundle="${storeText}" />";
				categoryDisplayJS.displayPrevAssociation = "<fmt:message key="SHOW_PREV_ASSOCIATION" bundle="${storeText}" />";
				categoryDisplayJS.initializeMerchandisingAssociation(startIndex);
			
				<flow:ifEnabled feature="CoShopping">
					if (dojo.isIE) {//only have to do this for IE. 
					 try {
						if (window.top._ceaCollabDialog != undefined){	
							window.top._ceaCollabDialog.disableQuickInfoButtons();	
						}	
					 }catch(err){}
					}
				</flow:ifEnabled>
			});
		</script>
	</div>  
</c:if>
<!-- END MerchandisingAssociationsDisplay.jsp -->
                            
