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

<%--
*****
This object snippet displays a catalog entry on different places across the site. It is mainly used with eMarketingSpots
where each catalog entry snippet could be cached to improve the performance across the store. This snippet uses information
from the marketing service along with Solr search results to display the desired catalog entry.
Depending on your input parameters different information is shown.
Users may specify display parameters to limit what is shown (see optional parameters) and much more.


Parameters required:
        emsName:		This .jsp file can be reused in different store pages by including it and assigning a unique value for the 
				emsName parameter. This value should match exactly with an eMarketingSpot name that is defined in the 
				Management Center when creating a new eMarketingSpot.
	catalogId: 		The catalogId parameter needs to be passed because it is required to build the proper URLs.
	storeId: 		The storeId parameter needs to be passed because it is required to build the proper URLs.
	mpe_id: 		The identifier of the eMarketingSpot.
	intv_id: 		The identifier of the Web Activity associated with the eMarketingSpot with mpe_id passed along.
	expDataType:		The type of the data to display in the eMarketingSpot. 
	clickInfoCommand:	The click info command name.
	absoluteUrl: 		The path to the click info command.

	catEntryName		The name of the catalog entry.
	thumbnail		The link to the catalog entry thumbnail.
	shortDescription	The short description of the catalog entry.
	catalogEntryTypeCode	The type of the catalog entry (ex product/item/bundle/package/dynamic kit).
	singleSKU		Whether or not the catalog entry represents a single SKU.
	buyable			Whether or not the catalog entry is buyable.
	priceString		The price of the catalog entry.
	strikedPriceString	The striked out price of the catalog entry.
	minimumPriceString	Minimum price of the catalog entry.
	mamimumPriceString	Maximum price of the catalog entry.


Optional display parameters:
	pageView:		Shows the catalog entry information in some pattern. It mainly defines how the catalog entry is shown. 
				Possible values are 'image','detailed', 'sidebar', 'imageForCompare', 'scrollESpot' and 'imageOnly'. Defaults to 'imageOnly'.
	useClickInfoURL:	If set to true, will use the variable 'ClickInfoURL' for the thumbnail image and name link.
	ClickInfoURL:		If 'useClickInfoURL' is set to true, this will be used as the link for the image and name links.
	catEntryIdentifier:	Is a unique identifier to differentiate the current catalog entry with respect to other ones 
				that may be displayed on the same page.
	skipAttachments:	The flag states whether to load the 40x40 image attachments for the catalog entry. These images are used for displaying the catalog 
				entry in the compare zone. If this catalog entry is not used in a page that has the compare zone then it is
				more efficient to set the skipAttachment flag to true to improve the load time of the page. 
	experimentId: 		The identifier of the marketing activity result experiment.
	testElementId: 		The identifier of the marketing activity result test element.
	categoryId: 		The category identifier used for the product link.
	top_category:		The top category identifier used for the product link.
	parent_category_rn: 	The top category identifier used for the product link.
	statusCount:		The counter for the loop that imports this jsp.
	isDKPreConfigured:	If set to ture, the dynamic kit reqpresented by this thumbnail is assumes to be pre-configured. Default is false.
	isDKConfigurable:	If set to false, the configure button for dynamic kits will now display. Default is true.
*****
--%>
<!-- BEGIN CatalogEntryThumbnailDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../../include/BrazilCommonESpots.jspf" %>

<%--
This JSP is imported from search/SearchESPotSetup.jspf.
SearchESpotSetup.jspf is included in eSpot JSPs, and only used when SearchBasedNavigation is enabled. 
On the eSpot jsps,the variable catEntry is instantiated(com.ibm.commerce.catalog.beans.CatalogEntryDataBean)
and stored in the request scope. This is done so that in the case where SearchedBasedNavigation is not enabled, 
Snippets/CatalogEntry/CatalogEntryThumbnailDisplay.jsp can reuse the catEntry object for performance reasons. 
But when SearchBasedNavigation is enabled, we can remove the catEntry object, and catalog information will be
retrived via service calls.
--%>
<c:remove var="catEntry"/>

<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>
<c:set var="replaceCmprStr" value=""/>
<c:set var="showProductQuickView" value="false"/>
<c:set var="pageView" value="${param.pageView}"/>
<c:set var="storeId" value="${param.storeId}"/>
<c:set var="catalogId" value="${param.catalogId}"/>
<c:set var="emsName" value="${param.emsName}"/>	
<c:set var="useClickInfoURL" value="${param.useClickInfoURL}"/>			
<c:set var="statusCount" value="${param.statusCount}"/>
<c:set var="prefix" value="${param.prefix }"/>
<c:set var="contentAreaESpot" value="${param.contentAreaESpot}"/>
<c:set var="isDKPreConfigured" value="${param.isDKPreConfigured}"/>
<c:set var="isDKConfigurable" value="${param.isDKConfigurable}"/>

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

<c:set var="addProductDnD" value="false"/>
<flow:ifEnabled feature="ProductDnD">
	<c:if test="${miniShopCartEnabled || compareEnabled}">
		<c:set var="addProductDnD" value="true"/>
	</c:if>
</flow:ifEnabled>

<flow:ifEnabled feature="ShowProductInNewWindow">
	<c:set var="ShowProductInNewWindow" value="target=\"_blank\"" />
</flow:ifEnabled>

<%--
  ***
  * Host name of the URL that is used to point to the shared image directory.  Use this variable to reference images.
  ***
--%>
<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="hostPath" />

<c:set var="catalogEntryID" value="${param.catEntryIdentifier}"/>
<c:set var="catEntryIDToUse" value="${param.catEntryIdentifier}"/>
<c:set var="catEntryIdentifier" value="${param.catEntryIdentifier}"/>
<c:set var="catEntryName" value="${param.catEntryName}"/>
<c:set var="thumbnail" value="${param.thumbnail}"/>
<c:set var="shortDescription" value="${param.shortDescription}"/>
<c:set var="catalogEntryTypeCode" value="${param.catalogEntryTypeCode}"/>

<c:set var="singleSKU" value="${param.singleSKU}"/>
<c:set var="buyable" value="${param.buyable}"/>

<c:choose>
	<c:when test="${catalogEntryTypeCode == 'BundleBean'}">
		<c:set var="type" value="bundle" />		
	</c:when>
	<c:when test="${catalogEntryTypeCode == 'PackageBean'}">
		<c:set var="type" value="package" />
	</c:when>
	<c:when test="${catalogEntryTypeCode == 'ItemBean'}">
		<c:set var="type" value="item" />
	</c:when>
	<c:when test="${catalogEntryTypeCode == 'ProductBean'}">
		<c:set var="type" value="product" />
	</c:when>
	<c:when test="${catalogEntryTypeCode == 'DynamicKitBean'}">
		<c:set var="type" value="dynamicKit" />
	</c:when>
</c:choose>
<c:set var="dragType" value="${type}" />

<c:set var="priceString" value="${param.priceString}"/>
<c:set var="strikedPriceString" value="${param.strikedPriceString}"/>
<c:set var="minimumPriceString" value="${param.minimumPriceString}"/>
<c:set var="maximumPriceString" value="${param.maximumPriceString}"/>

<c:choose>
	<c:when test="${empty priceString}">
		<fmt:message var="priceString" key="NO_PRICE_AVAILABLE" bundle="${storeText}"/>
		<c:set var="emptyPriceString" value="true"/>
	</c:when>
	<c:otherwise>
		<c:set var="emptyPriceString" value="false"/>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${empty param.categoryId}">
		<%-- categoryId is empty..just display product URL --%>
		<c:set var="patternName" value="ProductURL"/>
		<c:set var="parent_category_rn" value="${param.parent_category_rn}" />
		<c:set var="top_category" value="${param.top_category}" />
		<c:set var="categoryId" value="${param.categoryId}" />
	</c:when>
	<c:when test="${param.parent_category_rn == param.categoryId}">
			<%-- CategoryId is present..but it is same as parent category Id --%>
			<c:set var="patternName" value="ProductURLWithCategory"/>
			<c:set var="parent_category_rn" value="${param.parent_category_rn}" />
			<c:set var="top_category" value="${param.top_category}" />
			<c:set var="categoryId" value="${param.categoryId}" />
	</c:when>
	<c:when test="${!empty param.parent_category_rn && !empty param.top_category}">
		<%-- both parent and top category are present.. display full product URL --%>
		<c:set var="parent_category_rn" value="${param.parent_category_rn}" />
		<c:set var="top_category" value="${param.top_category}" />
		<c:set var="categoryId" value="${param.categoryId}" />
		<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
		<c:if test="${top_category == parent_category_rn}">
			<%-- But both top and parent category are same..display only parent category in product URL --%>
			<c:set var="patternName" value="ProductURLWithParentCategory"/>
		</c:if>
	</c:when>
	<c:when test="${!empty param.parent_category_rn}">
		<%-- parent category is not empty..use product URL with parent category --%>
		<c:set var="parent_category_rn" value="${param.parent_category_rn}" />
		<c:set var="top_category" value="${param.top_category}" />
		<c:set var="categoryId" value="${param.categoryId}" />
		<c:set var="patternName" value="ProductURLWithParentCategory"/>
	</c:when>
	<%-- In a top category; use top category parameters --%>
	<c:when test="${param.top == 'Y'}">
		<c:set var="parent_category_rn" value="${param.categoryId}" />
		<c:set var="top_category" value="${param.categoryId}" />
		<c:set var="categoryId" value="${param.categoryId}" />
		<c:set var="patternName" value="ProductURLWithCategory"/>
	</c:when>
	<%-- Store front main page; usually eSpots, parents unknown --%>
	<c:otherwise>
		<c:set var="parent_category_rn" value="" />
		<c:set var="top_category" value="" />
		<%-- Just display productURL without any category info --%>
		<c:set var="patternName" value="ProductURL"/>
	</c:otherwise>
</c:choose>

<c:choose>
	<c:when test="${empty useClickInfoURL || useClickInfoURL == false}">
		<%-- The URL that links to the display page --%>
		<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
		    <wcf:param name="catalogId" value="${catalogId}"/>
		    <wcf:param name="storeId" value="${storeId}"/>
		    <wcf:param name="productId" value="${catalogEntryID}"/>
		    <wcf:param name="langId" value="${langId}"/>
				<wcf:param name="categoryId" value="${categoryId}" />
				<wcf:param name="top_category" value="${top_category}" />
				<wcf:param name="parent_category_rn" value="${parent_category_rn}" />
				<wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>
	</c:when>
	<c:otherwise>
		<%--
		 * Set up the URL to call when clicking on the image
		--%>
		<wcf:url value="Product2" patternName="${patternName}" var="TargetURL">
		  <wcf:param name="catalogId" value="${catalogId}" />
		  <wcf:param name="productId" value="${catEntryIdentifier}" />
		  <wcf:param name="storeId" value="${storeId}" />
		  <wcf:param name="langId" value="${langId}" />
		  <wcf:param name="categoryId" value="${categoryId}" />
			<wcf:param name="top_category" value="${top_category}" />
			<wcf:param name="parent_category_rn" value="${parent_category_rn}" />
			<wcf:param name="urlLangId" value="${urlLangId}" />
		</wcf:url>
		<c:url value="${param.absoluteUrl}${param.clickInfoCommand}" var="ClickInfoURL" scope="request">
		  <c:param name="evtype" value="CpgnClick" />
		  <c:param name="mpe_id" value="${param.mpe_id}" />
		  <c:param name="intv_id" value="${param.intv_id}" />
		  <c:param name="storeId" value="${storeId}" />
		  <c:if test="${!empty param.experimentId && !empty param.testElementId}">
			<c:param name="experimentId" value="${param.experimentId}" />
			<c:param name="testElementId" value="${param.testElementId}" />
		  </c:if>
		  <c:param name="expDataType" value="${param.expDataType}" />
		  <c:param name="expDataUniqueID" value="${catEntryIdentifier}" />							    	
		  <c:param name="URL" value="${TargetURL}" />
		</c:url>			
		<c:set var="catEntryDisplayUrl" value="${ClickInfoURL}"/>
	</c:otherwise>
</c:choose>

<flow:ifDisabled feature="AjaxAddToCart">
	<c:if test="${add2CartForm != 'false'}">
		<form name="OrderItemAddForm_${catEntryIDToUse}" action="OrderChangeServiceItemAdd" method="post" id="OrderItemAddForm_${catEntryIDToUse}">
			<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}"/>" id="OrderItemAddForm_storeId_${catalogEntryID}"/>
			<input type="hidden" name="orderId" value="." id="OrderItemAddForm_orderId_${catalogEntryID}"/>
			<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}"/>" id="OrderItemAddForm_catalogId_${catalogEntryID}"/>
			<input type="hidden" name="URL" value="AjaxOrderItemDisplayView?storeId=<c:out value="${WCParam.storeId}"/>&catalogId=<c:out value="${WCParam.catalogId}"/>&langId=<c:out value="${WCParam.langId}"/>" id="OrderItemAddForm_url_${catalogEntryID}"/>
			<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="OrderItemAddForm_errorViewName_${catalogEntryID}"/>
			<input type="hidden" name="catEntryId" value="${catEntryIDToUse}" id="OrderItemAddForm_catEntryId_${catalogEntryID}"/>
			<input type="hidden" name="productId" value="${catEntryIDToUse}" id="OrderItemAddForm_productId_${catalogEntryID}"/>
			<input type="hidden" value="" name="quantity" id="OrderItemAddForm_quantity_${catalogEntryID}"/>
			<input type="hidden" value="" name="page" id="OrderItemAddForm_page_${catalogEntryID}"/>
			<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="OrderItemAddForm_calcUsage_${catalogEntryID}"/>
			<input type="hidden" name="updateable" value="0" id="OrderItemAddForm_updateable_${catalogEntryID}"/>
			<input type="hidden" name="listId" value="." id="OrderItemAddForm_wishlistId_${catalogEntryID}"/>
			<flow:ifEnabled feature="SOAWishlist">
			<input type="hidden" name="giftListId" value="<c:out value='${giftListId}'/>" id="<c:out value='OrderItemAddForm_${catEntryIDToUse}_giftListId_${giftListId}'/>"/>
			</flow:ifEnabled>
		</form>
	</c:if>
</flow:ifDisabled>
<c:set var="attributes" value="${requestScope.attributes}"/>
<c:choose>
	<c:when test="${pageView == 'image'}">
		
			<div id="baseContent_${prefix}_<c:out value='${catEntryIdentifier}'/>" 
				<c:if test="${showProductQuickView eq 'true'}">
					onmouseover="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');" onmouseout="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
				</c:if>
				>
				<div class="img" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_1">
				<c:if test="${addProductDnD eq 'true'}">
				
				<c:set var="dragTypeToUse" value="${dragType}"/>
				<c:if test="${singleSKU == true && dragType == 'product'}">
					<c:set var="dragTypeToUse" value="item"/>
				</c:if>
				
					<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}_${catEntryIDToUse}" copyOnly="true" dndType="${dragTypeToUse}">
						<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_2">
				</c:if>
							<c:choose>
								<c:when test="${!empty thumbnail}">
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover" 
									<c:if test="${showProductQuickView eq 'true'}">
										onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
										onkeydown="shiftTabHidePopupButton('${prefix}${emsName}_${catEntryIdentifier}',event);"
									</c:if>
									onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
									>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${thumbnail}'/>" 
												alt="<c:out value='${fn:replace(catEntryName, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
												border="0" width="70" height="70"/>
										<c:forEach var="attribute" items="${attributes}" varStatus="status2">
											<c:if test="${attribute.usage == 'Descriptive' && fn:startsWith(attribute.attributeIdentifier.externalIdentifier.identifier,'adbug')}">
												<c:remove var="adbugImage1"/>
												<c:set var="adbugLocation" value="top_right"/>										
												<c:forEach var="extVal" items="${attribute.extendedValue}">
													<c:if test="${extVal.key == 'Image1'}">
														<c:set var="adbugImage1" value="${storeImgDir}${extVal.value}"/>																								
													</c:if>
													<c:if test="${extVal.key == 'Field2'}">
														<c:set var="adbugLocation" value="${extVal.value}"/>
													</c:if>										
												</c:forEach>
												<c:if test="${!empty adbugImage1}">
													<div style="background-image: url(<c:out value='${adbugImage1}'/>)" class="adbug_${adbugLocation}" id="adbug_${emsName}_${catEntryIdentifier}_${attribute.value.value}" title="${attribute.value.value}"></div>
												</c:if>										
											</c:if>
										</c:forEach>													
									</a>
								</c:when>
								<c:otherwise>
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover" 
									<c:if test="${showProductQuickView eq 'true'}">
										onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
										onkeydown="shiftTabHidePopupButton('${prefix}${emsName}_${catEntryIdentifier}',event);"
									</c:if>
									onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
									>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" 
												alt="<c:out value='${fn:replace(catEntryName, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
												border="0" width="70" height="70"/>
									</a>
								</c:otherwise>
							</c:choose>
				<c:if test="${addProductDnD eq 'true'}">
						</div>
					</div>
					<script type="text/javascript">
					dojo.addOnLoad(function() { 
						var widgetText = "<c:out value='${prefix}_${catEntryIDToUse}'/>";
						parseWidget(widgetText);
					});
					</script>
				</c:if>
				</div>
				<c:if test="${showProductQuickView eq 'true'}">
					<c:choose>
						<c:when test="${myAccountPage}">
							<c:choose>
								<c:when test="${contentAreaESpot}">
									<div id="popupButton_${prefix}${emsName}_${catEntryIdentifier}" class="main_quickinfo_button">
									
										<c:set var="buttonStyle" value="secondary"/>
										<c:set var="buttonAttributes">
											id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_3"
										</c:set>
										<c:set var="buttonLink">
											<a class="strong" id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
													onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
													onclick="javaScript:var actionListImageAcct = new popupActionProperties(); actionListImageAcct.showProductCompare=false; actionListImageAcct.showWishList=${buyable}; actionListImageAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListImageAcct); return false;"  
													onkeypress="javaScript:var actionListImageAcct = new popupActionProperties(); actionListImageAcct.showProductCompare=false; actionListImageAcct.showWishList=${buyable}; actionListImageAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListImageAcct);" onblur="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																				
										</c:set>
										<%@ include file="../ReusableObjects/StoreButton.jspf" %>		
		
											

									</div>
								</c:when>
								<c:otherwise>
									<div id="popupButton_${prefix}${emsName}_${catEntryIdentifier}" class="main_quickinfo_button">
									
										<c:set var="buttonStyle" value="secondary"/>
										<c:set var="buttonAttributes">
											id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_5"
										</c:set>
										<c:set var="buttonLink">
											<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
													onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
													onclick="javaScript:var actionListImageAcct = new popupActionProperties(); actionListImageAcct.showProductCompare=false; actionListImageAcct.showWishList=false; actionListImageAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListImageAcct); return false;"  
													onkeypress="javaScript:var actionListImageAcct = new popupActionProperties(); actionListImageAcct.showProductCompare=false; actionListImageAcct.showWishList=false; actionListImageAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListImageAcct);" onblur="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																									
										</c:set>
										<%@ include file="../ReusableObjects/StoreButton.jspf" %>		
		
											
										
									</div>
								</c:otherwise>
							</c:choose>								
						</c:when>					
						<c:otherwise>
							<div id="popupButton_${prefix}${emsName}_${catEntryIdentifier}" class="main_quickinfo_button">
							
							
								<c:set var="buttonStyle" value="secondary"/>
								<c:set var="buttonAttributes">
									 id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_7"
								</c:set>
								<c:set var="buttonLink">
									<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
										onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
										onclick="javaScript:var actionListImageAcct = new popupActionProperties(); 
										<c:if test="${type=='dynamicKit'}">actionListImageAcct.showProductCompare = false;</c:if>
										actionListImageAcct.showWishList=${buyable}; actionListImageAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListImageAcct); return false;" 
										onkeypress="javaScript:var actionListImageAcct = new popupActionProperties(); 
										<c:if test="${type=='dynamicKit'}">actionListImageAcct.showProductCompare = false;</c:if>
										actionListImageAcct.showWishList=${buyable}; actionListImageAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListImageAcct);" onblur="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																																	
								</c:set>
								<%@ include file="../ReusableObjects/StoreButton.jspf" %>	
		

							</div>
						</c:otherwise>	
					</c:choose>		
				</c:if>
			</div>
							
			<div class="description_fixedwidth" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_9">
				<a id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_link_9"
					<c:out value="${ShowProductInNewWindow}"/> href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" >
					<c:out value="${catEntryName}" escapeXml="false"/>
				</a>
				
			</div>
			<c:choose>
				<c:when test="${isBrazilStore}">
					<%-- begin: use the brazil store price/espot container div --%>
					<c:set var="currentProductId" value="${catEntryIdentifier}" />
					<div class="brazil_price_espot_container">
						<div class="price brazil_price_container" id="WC_CatalogEntryThumbnailDisplayJSPF_<c:out value='${catEntryIdentifier}'/>_div_10">
							<%@ include file="CatalogEntryPriceDisplay.jspf" %>
							<%--
							***
							*     Display the promotions of Brazil Store
							***
							--%>
			 				<%-- Show installment promotion if nonInstallment promotion not showing --%>
				        	<c:if test="${empty nonInstallmentDiscountMap}">
								<div class="promo_price" id="WC_CatalogEntryThumbnailDisplayJSPF_<c:out value='${catEntryIdentifier}'/>_eSpot_div_1">
									<% out.flush(); %>
			    	                <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
			        	                       <c:param name="storeId" value="${WCParam.storeId}" />
			            	                   <c:param name="catalogId" value="${catalogId}" />
			                	               <c:param name="langId" value="${langId}" />
			                    	           <c:param name="emsName" value="${eSpotPaymentPromotion}" />
			                    	           <c:param name="currentProductId" value="${currentProductId}" />
			                        	       <c:param name="adclass" value="no_ad" />
			                            	   <c:param name="showPaymentDiscountPromotion" value="true" />
									</c:import> 
									<% out.flush(); %> 
								</div>
			        		</c:if>
						    <%--clean up, no longer need nonInstallmentDiscountMap, prepare for next featured item --%>
						    <c:if test='${!empty nonInstallmentDiscountMap}'>
						    	<c:remove var="nonInstallmentDiscountMap" /> 
						    </c:if>
						<%-- end: use the brazil store price container div --%>
						</div>
						<%-- 
						***
						* Pass the current product ID being displayed on this page to check for an eSpot activity
						***
						--%>
						<%-- Show Free Shipping Promotion --%> 
						<div id="WC_CatalogEntryThumbnailDisplayJSPF_<c:out value='${catEntryIdentifier}'/>_eSpot_div_2">
							<%-- Flush the buffer so this fragment JSP is not cached twice --%>
							<%out.flush();%>
							
			                <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
			                        <c:param name="storeId" value="${WCParam.storeId}" />
			                        <c:param name="catalogId" value="${catalogId}" />
			                        <c:param name="langId" value="${langId}" />
			                        <c:param name="emsName" value="${eSpotFreeShipping}" />
			                        <c:param name="currentProductId" value="${currentProductId}" />
			                        <c:param name="adclass" value="no_ad" />
							</c:import> 
							<%out.flush();%>
						</div>
					</div>
					<c:remove var="currentProductId" /> <%--remove, no longer needed --%>
				<%--
				***
				* End: Display the promotions if BrazilStore feature is enable!
				***
				--%>

				</c:when>
				<c:otherwise>
					<div class="price" id="WC_CatalogEntryThumbnailDisplayJSPF_<c:out value='${catEntryIdentifier}'/>_div_10">
						<%@ include file="CatalogEntryPriceDisplay.jspf" %>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="button" id="WC_CatalogEntryThumbnailDisplayJSPF_<c:out value='${catEntryIdentifier}'/>_div_11">
					<c:choose>
						<c:when test="${buyable}" >
							<flow:ifDisabled feature="HidePurchaseButton"> 
								<flow:ifEnabled feature="AjaxAddToCart"> 
									<div id="add2CartPopupButton_${catalogEntryID}">
										<c:choose>
											<c:when test="${dragType == 'dynamicKit'}">
												<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
											</c:when>											
											<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
											
													<c:set var="buttonStyle" value="primary"/>
													<c:set var="buttonAttributes">
														id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_12"		
													</c:set>
													<c:set var="buttonLink">
														<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_1'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_1" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
													</c:set>
													<%@ include file="../ReusableObjects/StoreButton.jspf" %>		
													
																				
											</c:when>
											<c:otherwise>
											
												<c:set var="buttonStyle" value="primary"/>
												<c:set var="buttonAttributes">
													id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_14"
												</c:set>
												<c:set var="buttonLink">
													<a href="javascript:;" onkeypress="javascript: showPopup('${catalogEntryID}',event, null, 'add2CartPopupButton_${catalogEntryID}')" onclick="javascript: showPopup('${catalogEntryID}',event, null, 'add2CartPopupButton_${catalogEntryID}')" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_2" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
												</c:set>
												<%@ include file="../ReusableObjects/StoreButton.jspf" %>		
		
													

											</c:otherwise>
										</c:choose>
									</div>
								</flow:ifEnabled>

								<flow:ifDisabled feature="AjaxAddToCart">
								<div id="add2CartPopupButton_${catalogEntryID}">
									<c:choose>
										<c:when test="${dragType == 'dynamicKit'}">
											<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
										</c:when>													
										<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
										
											<c:set var="buttonStyle" value="primary"/>
											<c:set var="buttonAttributes">
												id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_16"
											</c:set>
											<c:set var="buttonLink">
												<a  href="#" onclick="javascript: categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_3" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
											</c:set>
											<%@ include file="../ReusableObjects/StoreButton.jspf" %>	
		
												
											
										</c:when>
										<c:otherwise>
										
												<c:set var="buttonStyle" value="primary"/>
												<c:set var="buttonAttributes">
													id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_18"
												</c:set>
												<c:set var="buttonLink">
																<a  href="javascript:;" onkeypress="javascript: showPopup('${catalogEntryID}',event, null, 'add2CartPopupButton_${catalogEntryID}')" onclick="javascript: showPopup('${catalogEntryID}',event, null, 'add2CartPopupButton_${catalogEntryID}')" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_4" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
												</c:set>
												<%@ include file="../ReusableObjects/StoreButton.jspf" %>	
												
										</c:otherwise>
									</c:choose>
								</div>
							</flow:ifDisabled>
							</flow:ifDisabled>
						</c:when>
						<c:otherwise>
							<fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" />
						</c:otherwise>
					</c:choose>
			</div>
		
		<c:if test="${addProductDnD eq 'true'}">
			<script type="text/javaScript">
				dojo.addOnLoad(function() {
					var src= new dojo.dnd.Source("${prefix}_${catEntryIDToUse}");
					src.copyOnly=true;
					src.setItem('imgPath','${thumbnail}');
					src.setItem('productDisplayPath','${catEntryDisplayUrl}');
				});
				
			</script>
		</c:if>
	</c:when>
	<c:when test="${pageView == 'detailed' || pageView == 'detailedMyAccount'}">
				<tr class="item_container">
				<td class="image" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_1">
					<div id="baseContent_${prefix}_<c:out value='${catEntryIdentifier}'/>" 
						<c:if test="${showProductQuickView eq 'true'}">
							onmouseover="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');" onmouseout="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
						</c:if>
						<c:if test="${pageView == 'detailedMyAccount'}">
							class="image_wrapper"
						</c:if>
						>
						<c:if test="${addProductDnD eq 'true'}">
						
							<c:set var="dragTypeToUse" value="${dragType}"/>
							<c:if test="${singleSKU == true && dragType == 'product'}">
								<c:set var="dragTypeToUse" value="item"/>
							</c:if>
						
							<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}_${catEntryIDToUse}" copyOnly="true" dndType="${dragTypeToUse}">
								<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_20">
						</c:if>
								<c:choose>
									<c:when test="${!empty thumbnail}">
										<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhoverdetailed"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}${emsName}_${catEntryIdentifier}',event);"
										</c:if>
										onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
										>
											<c:if test="${addProductDnD eq 'true'}">
												<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
											</c:if>
											<img src="<c:out value='${thumbnail}'/>" 
													alt="<c:out value='${fn:replace(catEntryName, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
													border="0" width="70" height="70"/>
											<c:forEach var="attribute" items="${attributes}" varStatus="status2">
												<c:if test="${attribute.usage == 'Descriptive' && fn:startsWith(attribute.attributeIdentifier.externalIdentifier.identifier,'adbug')}">
													<c:remove var="adbugImage1"/>
													<c:set var="adbugLocation" value="top_right"/>										
													<c:forEach var="extVal" items="${attribute.extendedValue}">
														<c:if test="${extVal.key == 'Image1'}">
															<c:set var="adbugImage1" value="${storeImgDir}${extVal.value}"/>																								
														</c:if>
														<c:if test="${extVal.key == 'Field2'}">
															<c:set var="adbugLocation" value="${extVal.value}"/>
														</c:if>										
													</c:forEach>
													<c:if test="${!empty adbugImage1}">
														<div style="background-image: url(<c:out value='${adbugImage1}'/>)" class="adbug_detailed_${adbugLocation}" id="adbug_${emsName}_${catEntryIdentifier}_${attribute.value.value}" title="${attribute.value.value}"></div>
													</c:if>										
												</c:if>
											</c:forEach>																								
										</a>
									</c:when>
									<c:otherwise>
										<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhoverdetailed"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}${emsName}_${catEntryIdentifier}',event);"
										</c:if>
										onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
										>
											<c:if test="${addProductDnD eq 'true'}">
												<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
											</c:if>
											<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" 
													alt="<c:out value='${fn:replace(catEntryName, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
													border="0" width="70" height="70"/>
										</a>
									</c:otherwise>
								</c:choose>
						<c:if test="${addProductDnD eq 'true'}">
								</div>
							</div>
							<script type="text/javascript">
							dojo.addOnLoad(function() { 
								var widgetText = "<c:out value='${prefix}_${catEntryIDToUse}'/>";
								parseWidget(widgetText);
							});
							</script>
						</c:if>
						<c:if test="${showProductQuickView eq 'true'}">
							<c:choose>
								<c:when test="${myAccountPage}">
									<c:choose>
										<c:when test="${contentAreaESpot}">
											<div id="popupButton_${prefix}${emsName}_${catEntryIdentifier}" class="main_quickinfo_button">
											
													<c:set var="buttonStyle" value="secondary"/>
													<c:set var="buttonAttributes">
														id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_21"
													</c:set>
													<c:set var="buttonLink">
														<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
																onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
																onclick="javaScript:var actionListDetailedAcct = new popupActionProperties(); actionListDetailedAcct.showProductCompare=false; actionListDetailedAcct.showWishList=${buyable}; actionListDetailedAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListDetailedAcct); return false;" 
																onkeypress="javaScript:var actionListDetailedAcct = new popupActionProperties(); actionListDetailedAcct.showProductCompare=false; actionListDetailedAcct.showWishList=${buyable}; actionListDetailedAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListDetailedAcct);" onblur="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																																																				
													</c:set>
													<%@ include file="../ReusableObjects/StoreButton.jspf" %>	
													
																								
												
											</div>
										</c:when>
										<c:otherwise>
											<div id="popupButton_${prefix}${emsName}_${catEntryIdentifier}" class="main_quickinfo_button">
											
												<c:set var="buttonStyle" value="secondary"/>
												<c:set var="buttonAttributes">
													id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_23"
												</c:set>
												<c:set var="buttonLink">
													<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
														onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
														onclick="javaScript:var actionListDetailedAcct = new popupActionProperties(); actionListDetailedAcct.showProductCompare=false; actionListDetailedAcct.showWishList=false; actionListDetailedAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListDetailedAcct); return false;" 
														onkeypress="javaScript:var actionListDetailedAcct = new popupActionProperties(); actionListDetailedAcct.showProductCompare=false; actionListDetailedAcct.showWishList=false; actionListDetailedAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListDetailedAcct);" onblur="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																																																																
												</c:set>
												<%@ include file="../ReusableObjects/StoreButton.jspf" %>	
		

											</div>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<div id="popupButton_${prefix}${emsName}_${catEntryIdentifier}" class="main_quickinfo_button">	
									
											<c:set var="buttonStyle" value="secondary"/>
											<c:set var="buttonAttributes">
												id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_25"
											</c:set>
											<c:set var="buttonLink">
												<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
													onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
													onclick="javaScript:var actionListDetailedAcct = new popupActionProperties(); <c:if test="${type=='dynamicKit'}">actionListDetailedAcct.showProductCompare = false;</c:if> actionListDetailedAcct.showWishList=${buyable}; actionListDetailedAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListDetailedAcct); return false;" 
													onkeypress="javaScript:var actionListDetailedAcct = new popupActionProperties(); <c:if test="${type=='dynamicKit'}">actionListDetailedAcct.showProductCompare = false;</c:if> actionListDetailedAcct.showWishList=${buyable}; actionListDetailedAcct.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListDetailedAcct);" onblur="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																																																																												
											</c:set>
											<%@ include file="../ReusableObjects/StoreButton.jspf" %>
		
			

									</div>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
				</td>
				<td class="information" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_2">
					<c:if test="${pageView == 'detailedMyAccount'}">
						<div class="information">
							<h3><c:out value="${catEntryName}" escapeXml="false"/></h3>
							<p class="brand"><c:out value="${shortDescription}" escapeXml="false"/></p>
						</div>
					</c:if>
					<c:if test="${pageView == 'detailed'}">
						<p class="brand"><c:out value="${catEntryName}" escapeXml="false"/></p>
						<p class="brand"><c:out value="${shortDescription}" escapeXml="false"/></p>
					</c:if>					
				</td>
				<td class="price" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_3">
					<p <c:if test="${pageView == 'detailedMyAccount'}">class="price"</c:if> >
						<%@ include file="CatalogEntryPriceDisplay.jspf" %>
					</p>
				</td>
				<td class="add_to_cart" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_4">
					<c:choose>
					<c:when test="${buyable && pageView == 'detailed'}" >
						<flow:ifEnabled feature="AjaxAddToCart"> 
							<c:choose>
								<c:when test="${dragType == 'dynamicKit'}">
									<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
								</c:when>								
								<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
									<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_5'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_5" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
								</c:when>
								<c:otherwise>
									<a href="javascript:;" onclick="javascript: showPopup('${catalogEntryID}',event)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_6" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>						
								</c:otherwise>
							</c:choose>
						</flow:ifEnabled>
						
						<flow:ifDisabled feature="AjaxAddToCart">
							<c:choose>
								<c:when test="${dragType == 'dynamicKit'}">
									<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
								</c:when>								
								<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
									<a href="#" onclick="javascript: categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_7" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
								</c:when>
								<c:otherwise>
									<a href="javascript:;" onclick="javascript: showPopup('${catalogEntryID}', event)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_8" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
								</c:otherwise>
							</c:choose>
						</flow:ifDisabled>
						<c:if test="${wishListPage}">
							<flow:ifDisabled feature="AjaxMyAccountPage">
								<a href="<c:out value="${interestItemDeleteURL}"/>" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_9"><fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" /></a>
							</flow:ifDisabled>
							<flow:ifEnabled feature="AjaxMyAccountPage">
								<a href="javaScript:AccountWishListDisplay.deleteInterestItem({catEntryId:'${catalogEntryID}',storeId:'<c:out value="${WCParam.storeId}"/>', catalogId:'<c:out value="${WCParam.catalogId}"/>', langId:'${langId}'},'${WishListResultDisplay}')" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_10"><fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" /></a>
							</flow:ifEnabled>
						</c:if>
					</c:when>
					<c:when test="${buyable && pageView == 'detailedMyAccount'}" >
						<flow:ifEnabled feature="AjaxAddToCart"> 
								<div id="add2CartPopupButton_${catEntryIdentifier}" class="button_wrapper">
									<c:choose>
										<c:when test="${dragType == 'dynamicKit'}">
											<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
										</c:when>										
										<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
										
												<c:set var="buttonStyle" value="primary"/>
												<c:set var="buttonAttributes">
													id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_12"
												</c:set>
												<c:set var="buttonLink">
															<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_1'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_1" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
												</c:set>
												<%@ include file="../ReusableObjects/StoreButton.jspf" %>	
		
												
										
										</c:when>
										<c:otherwise>

													<c:set var="buttonStyle" value="primary"/>
													<c:set var="buttonAttributes">
														id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_14"
													</c:set>
													<c:set var="buttonLink">
																<a href="javascript:;" onkeypress="javascript: showPopup('${catalogEntryID}', event, null, 'add2CartPopupButton_${catalogEntryID}')" onclick="javascript: showPopup('${catalogEntryID}', event, null, 'add2CartPopupButton_${catalogEntryID}')" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_2" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
													</c:set>
													<%@ include file="../ReusableObjects/StoreButton.jspf" %>	


											
										</c:otherwise>
									</c:choose>
								</div>
							</flow:ifEnabled>

							<flow:ifDisabled feature="AjaxAddToCart">
								<div id="add2CartPopupButton_${catEntryIdentifier}" class="button_wrapper">
									<c:choose>
										<c:when test="${dragType == 'dynamicKit'}">
											<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
										</c:when>										
										<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
										
												<c:set var="buttonStyle" value="primary"/>
												<c:set var="buttonAttributes">
													 id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_16"
												</c:set>
												<c:set var="buttonLink">
															<a  href="#" onclick="javascript: categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_3" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
												</c:set>
												<%@ include file="../ReusableObjects/StoreButton.jspf" %>	
		

										</c:when>
										<c:otherwise>

												<c:set var="buttonStyle" value="primary"/>
												<c:set var="buttonAttributes">
													 id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_18"
												</c:set>
												<c:set var="buttonLink">
																<a  href="javascript:;" onkeypress="javascript: showPopup('${catalogEntryID}', event, null, 'add2CartPopupButton_${catalogEntryID}')" onclick="javascript: showPopup('${catalogEntryID}', event, null, 'add2CartPopupButton_${catalogEntryID}')" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_4" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
										
												</c:set>
												<%@ include file="../ReusableObjects/StoreButton.jspf" %>	

	
										</c:otherwise>
									</c:choose>
								</div>
							</flow:ifDisabled>					
					</c:when>
					<c:otherwise>
						<c:if test="${pageView eq 'detailedMyAccount'}">
							<div class="button_wrapper">
						</c:if>
						<fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" />
						<c:if test="${pageView eq 'detailedMyAccount'}">
							</div>
						</c:if>						
					</c:otherwise>
					</c:choose>
				</td>
		</tr>
		<c:if test="${addProductDnD eq 'true'}">
			<script type="text/javaScript">
				dojo.addOnLoad(function() { 
					var src= new dojo.dnd.Source("${prefix}_${catEntryIDToUse}");
					src.copyOnly=true;
					src.setItem('imgPath','${thumbnail}');
					src.setItem('productDisplayPath','${catEntryDisplayUrl}');
				});
				
			</script>
		</c:if>
	</c:when>
	<c:when test="${pageView == 'scrollESpot' || pageView == 'scrollSideBarESpot'}">
		<div id="item_8_<c:out value='${emsName}'/>_<c:out value='${catEntryIdentifier}'/>">
			<div id="baseContent_${prefix}<c:out value='${emsName}'/>_<c:out value='${catEntryIdentifier}'/>" 
				<c:if test="${showProductQuickView eq 'true'}">
					onmouseover="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');" onmouseout="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
				</c:if>
				>
				<div class="img" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_27">
				<c:if test="${addProductDnD eq 'true'}">
					<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}${emsName}_${catEntryIDToUse}" copyOnly="true" dndType="${dragType}">
						<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_28">
				</c:if>
							<c:choose>
								<c:when test="${pageView == 'scrollSideBarESpot'}">
								    <c:choose>
								        <c:when test="${!empty thumbnail}">
								            <c:set var="catEntryImagePath" value="${thunbnail}" />
								        </c:when>
								        <c:otherwise>
								            <c:set var="catEntryImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
								        </c:otherwise>
								    </c:choose>								
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value='${emsName}'/><c:out value="${catEntryIdentifier}"/>">
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${catEntryImagePath}'/>" 
												alt="<c:out value='${fn:replace(catEntryName, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
												border="0" width="55" height="55"/>
										<c:forEach var="attribute" items="${attributes}" varStatus="status2">
											<c:if test="${attribute.usage == 'Descriptive' && fn:startsWith(attribute.attributeIdentifier.externalIdentifier.identifier,'adbug')}">
												<c:remove var="adbugImage1"/>
												<c:set var="adbugLocation" value="top_right"/>										
												<c:forEach var="extVal" items="${attribute.extendedValue}">
													<c:if test="${extVal.key == 'Image1'}">
														<c:set var="adbugImage1" value="${storeImgDir}${extVal.value}"/>																								
													</c:if>
													<c:if test="${extVal.key == 'Field2'}">
														<c:set var="adbugLocation" value="${extVal.value}"/>
													</c:if>										
												</c:forEach>
												<c:if test="${!empty adbugImage1}">
													<div style="background-image: url(<c:out value='${adbugImage1}'/>)" class="adbug_sidebar_${adbugLocation}" id="adbug_${emsName}_${catEntryIdentifier}_${attribute.value.value}" title="${attribute.value.value}"></div>
												</c:if>										
											</c:if>
										</c:forEach>
									</a>
								</c:when>							
								<c:when test="${!empty thumbnail}">
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value='${emsName}'/><c:out value="${catEntryIdentifier}"/>"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}${emsName}_${catEntryIdentifier}',event);"
										</c:if>
										>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${thumbnail}'/>" 
												alt="<c:out value='${fn:replace(catEntryName, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
												border="0" width="70" height="70"/>
										<c:forEach var="attribute" items="${attributes}" varStatus="status2">
											<c:if test="${attribute.usage == 'Descriptive' && fn:startsWith(attribute.attributeIdentifier.externalIdentifier.identifier,'adbug')}">
												<c:remove var="adbugImage1"/>
												<c:set var="adbugLocation" value="top_right"/>										
												<c:forEach var="extVal" items="${attribute.extendedValue}">
													<c:if test="${extVal.key == 'Image1'}">
														<c:set var="adbugImage1" value="${storeImgDir}${extVal.value}"/>																								
													</c:if>
													<c:if test="${extVal.key == 'Field2'}">
														<c:set var="adbugLocation" value="${extVal.value}"/>
													</c:if>										
												</c:forEach>
												<c:if test="${!empty adbugImage1}">
													<div style="background-image: url(<c:out value='${adbugImage1}'/>)" class="adbug_scroll_${adbugLocation}" id="adbug_${emsName}_${catEntryIdentifier}_${attribute.value.value}" title="${attribute.value.value}"></div>
												</c:if>										
											</c:if>
										</c:forEach>												
									</a>
								</c:when>
								<c:otherwise>
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value='${emsName}'/><c:out value="${catEntryIdentifier}"/>"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}${emsName}_${catEntryIdentifier}',event);"
										</c:if>
										>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" 
											alt="<c:out value='${fn:replace(catEntryName, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
											border="0" width="70" height="70"/>											
									</a>
								</c:otherwise>
							</c:choose>
				<c:if test="${addProductDnD eq 'true'}">
						</div>
					</div>
				</c:if>
				</div>
				<c:if test="${showProductQuickView eq 'true'}">
					<div class="button_fit_padder">
						<div id="popupButton_${prefix}${emsName}_${catEntryIdentifier}" class="main_quickinfo_button">
						
							<c:set var="buttonStyle" value="secondary"/>
							<c:set var="buttonAttributes">
								id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_29"
							</c:set>
							<c:set var="buttonLink">
								<a class="strong"  id="QuickInfoButton_${prefix}${emsName}_${catEntryIdentifier}" href="#"
									onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
									onclick="javaScript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListScroll); return false;"  
									onkeypress="javaScript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListScroll);" onblur="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																																																																																
							</c:set>
							<%@ include file="../ReusableObjects/StoreButton.jspf" %>
		
		
		

						</div>
					</div>
				</c:if>
			</div>
				
			<div class="scrollPaneDescription" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_31">
				<c:set var="itemDescription" value="${catEntryName}"/>
				<c:if test="${pageView == 'scrollSideBarESpot'}">
						<%--This is the variable that controls how many characters from the wish list name are displayed before dots are added as suffix --%>
						<c:set var="maxCharsToDisplay" value="30"/>
						<%-- for double byte, we need to lower the maximum number of characters to be displayed --%>
						<c:if test="${CommandContext.locale == 'zh_TW' || CommandContext.locale == 'ja_JP' || CommandContext.locale == 'zh_CN' || CommandContext.locale == 'ko_KR'}" >
							<c:set var="maxCharsToDisplay" value="${maxCharsToDisplay/2}"/>
						</c:if>
						
						<c:if test="${fn:length(itemDescription) > maxCharsToDisplay}">
							<c:set var="itemDescription" value="${fn:substring(catEntryName, 0, maxCharsToDisplay)}..."/>
						</c:if>
				</c:if>
				<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" title="<c:out value='${catEntryName}' escapeXml='false'/>" >
					<c:out value="${itemDescription}" escapeXml="false"/>
				</a>
			</div>
			<div class="scrollPanePrice" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_32">
				<%@ include file="CatalogEntryPriceDisplay.jspf" %>
			</div>
		</div>
		<c:if test="${pageView == 'scrollESpot'}">
			<c:choose>
				<c:when test="${buyable}" >
					<flow:ifDisabled feature="HidePurchaseButton"> 
						<flow:ifEnabled feature="AjaxAddToCart"> 
							<c:choose>
								<c:when test="${dragType == 'dynamicKit'}">
									<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
								</c:when>								
								<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
									<div class="button_fit_padder">
									
										<c:set var="buttonStyle" value="primary"/>
										<c:set var="buttonAttributes">
											id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_33"
										</c:set>
										<c:set var="buttonLink">
												<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_links_11'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
								
										</c:set>
										<%@ include file="../ReusableObjects/StoreButton.jspf" %>
		
											
									
									</div>
								</c:when>
								<c:otherwise>
									<div class="button_fit_padder">
									
										<c:set var="buttonStyle" value="primary"/>
										<c:set var="buttonAttributes">
											id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_35"
										</c:set>
										<c:set var="buttonLink">
															<a id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_links_11" href="javascript:;"  onclick="javascript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}', event, null, null, actionListScroll);" onkeypress="javascript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}', event, null, null, actionListScroll)" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
								
										</c:set>
										<%@ include file="../ReusableObjects/StoreButton.jspf" %>
		
											

									</div>
								</c:otherwise>
							</c:choose>
						</flow:ifEnabled>
							
						<flow:ifDisabled feature="AjaxAddToCart">
					<c:choose>
						<c:when test="${dragType == 'dynamicKit'}">
							<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
						</c:when>						
						<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
							<div class="button_fit_padder">
							

									<c:set var="buttonStyle" value="primary"/>
									<c:set var="buttonAttributes">
										id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_37"
									</c:set>
									<c:set var="buttonLink">
												<a href="#" onclick="javascript:categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
																						
							
									</c:set>
									<%@ include file="../ReusableObjects/StoreButton.jspf" %>
		
									
								
							</div>
						</c:when>
						<c:otherwise>
							<div class="button_fit_padder">


									<c:set var="buttonStyle" value="primary"/>
									<c:set var="buttonAttributes">
										id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_37"
									</c:set>
									<c:set var="buttonLink">
										<a id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_links_11" href="javascript:;" onclick="javascript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}', event, null, null, actionListScroll);" onkeypress="javascript:var actionListScroll = new popupActionProperties(); actionListScroll.showProductCompare=<c:out value='${param.showProductCompareInQuickInfo}' default='false'/>; actionListScroll.showWishList=${buyable}; actionListScroll.showAddToCart=${buyable}; showPopup('${catalogEntryID}', event, null, null, actionListScroll)" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
							
									</c:set>
									<%@ include file="../ReusableObjects/StoreButton.jspf" %>
		
									
								
							</div>
						</c:otherwise>
					</c:choose>
				</flow:ifDisabled>
					</flow:ifDisabled>
				</c:when>
			<c:otherwise>
				<fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" />
			</c:otherwise>
		</c:choose>
		</c:if>
		<c:if test="${addProductDnD eq 'true'}">
			<script type="text/javaScript">
				dojo.addOnLoad(function() { 
					var src= new dojo.dnd.Source("${prefix}${emsName}_${catEntryIDToUse}");
					src.copyOnly=true;
					src.setItem('imgPath','${thumbnail}');
					src.setItem('productDisplayPath','${catEntryDisplayUrl}');
				});
			</script>
		</c:if>
	</c:when>
	<c:when test="${pageView eq 'rankingList'}">
		<c:set var="maxNumberCharactersAllowedToDisplay" value="24"/>
		<%-- for double byte, we need to lower the maximum number of characters to be displayed --%>
		<c:if test="${CommandContext.locale == 'zh_TW' || CommandContext.locale == 'ja_JP' || CommandContext.locale == 'zh_CN' || CommandContext.locale == 'ko_KR'}" >
			<c:set var="maxNumberCharactersAllowedToDisplay" value="${maxNumberCharactersAllowedToDisplay/2}"/>
		</c:if>			
		<div id="ranking_list_table" class="ranking_list_table" role="grid"" aria-describedby="">
			<div id="ranking_list_table_row_${statusCount}" class="ul" role="row">
				<div id="baseContent_${prefix}<c:out value='${emsName}'/>_<c:out value='${catEntryIdentifier}'/>" class="li" role="gridcell">
					<div class="img" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_27">
						<c:if test="${addProductDnD eq 'true'}">
							<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}${emsName}_${catEntryIDToUse}" copyOnly="true" dndType="${dragType}">
								<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_28">
						</c:if>
						<c:choose>
							<c:when test="${!empty thumbnail}">
								<c:set var="catEntryImagePath" value="${thumbnail}" />
							</c:when>
							<c:otherwise>
								<c:set var="catEntryImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
							</c:otherwise>
						</c:choose>								
						<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value='${emsName}'/><c:out value="${catEntryIdentifier}"/>">
							<c:if test="${addProductDnD eq 'true'}">
								<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
							</c:if>
							<img src="<c:out value='${catEntryImagePath}'/>" 
								alt="<c:out value='${fn:replace(catEntryName, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
								border="0" width="40" height="40"/>
						</a>
						<c:if test="${addProductDnD eq 'true'}">
								</div>
							</div>
						</c:if>
					</div>
					<c:if test="${addProductDnD eq 'true'}">
						<script type="text/javaScript">
							dojo.addOnLoad(function() { 
								var src= new dojo.dnd.Source("${prefix}${emsName}_${catEntryIDToUse}");
								src.copyOnly=true;
								src.setItem('imgPath','${thumbnail}');
								src.setItem('productDisplayPath','${catEntryDisplayUrl}');
							});
						</script>
					</c:if>
				</div>
				<div id="rank_${statusCount}_icon" class="li rank_icon_spacing" role="gridcell">
					<c:out value="${statusCount}"/>.
				</div>
				<div id="rank_${statusCount}_catEntry" class="li rank_catEntry_description" role="gridcell">
					<div class="scrollPaneDescription" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_31">
						<c:set var="itemDescription" value="${catEntryName}"/>
						<c:if test="${fn:length(itemDescription) > maxNumberCharactersAllowedToDisplay}">
							<c:set var="itemDescription" value="${fn:substring(catEntryName, 0, maxNumberCharactersAllowedToDisplay)}..."/>
						</c:if>
						<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" >
							<c:out value="${itemDescription}" escapeXml="false"/>
						</a>
					</div>
					<div class="scrollPanePrice" id="WC_CatalogEntryThumbnailDisplayJSPF_${emsName}_${catEntryIdentifier}_div_32">
						<%@ include file="../ReusableObjects/CatalogEntryPriceDisplay.jspf" %>
					</div>
				</div>
			</div>
		</div>
	</c:when>
	<c:when test="${pageView == 'sidebar'}">
		<table id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_table_1">
			<tr>
				<td id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_5">
					<div id="baseContent_${prefix}_<c:out value='${catEntryIdentifier}'/>" class="itemcontainer"
						<c:if test="${showProductQuickView eq 'true'}">
							onmouseover="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');" onmouseout="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
						</c:if>
						>
						
						<c:if test="${addProductDnD eq 'true'}">
							<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}_${catEntryIDToUse}" copyOnly="true" dndType="${dragType}">
								<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_41">
						</c:if>
						<c:choose>
								<c:when test="${!empty thumbnail}">
									<c:set var="sidebarImagePath" value="${thumbnail}" />
								</c:when>
								<c:otherwise>
									<c:set var="sidebarImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm55.jpg" />
								</c:otherwise>
						</c:choose>
						<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover"
						<c:if test="${showProductQuickView eq 'true'}">
							onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
							onkeydown="shiftTabHidePopupButton('${prefix}${emsName}_${catEntryIdentifier}',event);"
						</c:if>
						 onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:this.style.backgroundImage='url(\'<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}${vfileColor}" />recommend_hover_background.png\')';" 
						 >
							<c:if test="${addProductDnD eq 'true'}">
								<!--[if lte IE 6.5]><iframe class="productSidebarDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
							</c:if>
							<img src="<c:out value='${sidebarImagePath}'/>" 
									alt="<c:out value='${fn:replace(catEntryName, search, replaceStr)} ${displayPriceString}' escapeXml='false'/>" 
									border="0" width="55" height="55"/>
							<c:forEach var="attribute" items="${attributes}" varStatus="status2">
								<c:if test="${attribute.usage == 'Descriptive' && fn:startsWith(attribute.attributeIdentifier.externalIdentifier.identifier,'adbug')}">
									<c:remove var="adbugImage1"/>
									<c:set var="adbugLocation" value="top_right"/>										
									<c:forEach var="extVal" items="${attribute.extendedValue}">
										<c:if test="${extVal.key == 'Image1'}">
											<c:set var="adbugImage1" value="${storeImgDir}${extVal.value}"/>																								
										</c:if>
										<c:if test="${extVal.key == 'Field2'}">
											<c:set var="adbugLocation" value="${extVal.value}"/>
										</c:if>										
									</c:forEach>
									<c:if test="${!empty adbugImage1}">
										<div style="background-image: url(<c:out value='${adbugImage1}'/>)" class="adbug_sidebar_${adbugLocation}" id="adbug_${emsName}_${catEntryIdentifier}_${attribute.value.value}" title="${attribute.value.value}"></div>
									</c:if>										
								</c:if>
							</c:forEach>								
						</a>
						<c:if test="${addProductDnD eq 'true'}">
								</div>
							</div>
						</c:if>
						<c:if test="${showProductQuickView eq 'true'}">
							<c:choose>
								<c:when test="${shoppingCartPage}">						
									<div id="popupButton_${prefix}${emsName}_${catEntryIdentifier}" class="rightside_quickinfo_button">
									
											<c:set var="buttonStyle" value="secondary"/>
											<c:set var="buttonAttributes">
												id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_42"
											</c:set>
											<c:set var="buttonLink">
												<a class="strong" id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
													alt="<fmt:message key="QUICKINFO" bundle="${storeText}"/>"
													onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
													onclick="javaScript:var actionListForSidebar = new popupActionProperties(); actionListForSidebar.showProductCompare=false; actionListForSidebar.showWishList=${buyable}; actionListForSidebar.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListForSidebar); return false;" 
													onkeypress="javaScript:var actionListForSidebar = new popupActionProperties(); actionListForSidebar.showProductCompare=false; actionListForSidebar.showWishList=${buyable}; actionListForSidebar.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListForSidebar);" onblur="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																
											</c:set>
											<%@ include file="../ReusableObjects/StoreButton.jspf" %>		
		
		
											

									</div>
								</c:when>
								<c:otherwise>
									<div id="popupButton_${prefix}${emsName}_${catEntryIdentifier}" class="rightside_quickinfo_button">
									
											<c:set var="buttonStyle" value="secondary"/>
											<c:set var="buttonAttributes">
												id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_44"
											</c:set>
											<c:set var="buttonLink">
												<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
															alt="<fmt:message key="QUICKINFO" bundle="${storeText}"/>"
															onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
															onclick="javaScript:var actionListForSidebar = new popupActionProperties(); <c:if test="${type=='dynamicKit'}">actionListForSidebar.showProductCompare = false;</c:if> actionListForSidebar.showWishList=${buyable}; actionListForSidebar.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListForSidebar); return false;" 
															onkeypress="javaScript:var actionListForSidebar = new popupActionProperties(); <c:if test="${type=='dynamicKit'}">actionListForSidebar.showProductCompare = false;</c:if> actionListForSidebar.showWishList=${buyable}; actionListForSidebar.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListForSidebar);" onblur="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																									
											</c:set>
											<%@ include file="../ReusableObjects/StoreButton.jspf" %>										
									
										
									</div>
								</c:otherwise>
							</c:choose>								
						</c:if>
					</div>
				</td>
				<td id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_6">
					<div class="text_fixedwidth" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_46">
						<p class="brand">
							<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" >
								<c:out value="${catEntryName}" escapeXml="false"/>
							</a>
						</p>
						<p class="price">
							<%@ include file="CatalogEntryPriceDisplay.jspf" %>
						</p>
						<p>
							<c:choose>
							<c:when test="${buyable}" >								
								<flow:ifEnabled feature="AjaxAddToCart"> 
									<c:choose>
										<c:when test="${dragType == 'dynamicKit'}">
											<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
										</c:when>										
										<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
											<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_11'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
										</c:when>
										<c:otherwise>
											<a href="javascript:;" onclick="javascript: showPopup('${catalogEntryID}', event)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
										</c:otherwise>
									</c:choose>
								</flow:ifEnabled>
								
								<flow:ifDisabled feature="AjaxAddToCart">
									<c:choose>
										<c:when test="${dragType == 'dynamicKit'}">
											<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
										</c:when>										
										<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
											<a href="#" onclick="javascript:categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
										</c:when>
										<c:otherwise>
											<a href="javascript:;" onclick="javascript: showPopup('${catalogEntryID}', event)" class="wishlist_detailed_link" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_11" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
										</c:otherwise>
									</c:choose>
								</flow:ifDisabled>
							</c:when>
							<c:otherwise>
								<fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" />
							</c:otherwise>
							</c:choose>
						</p>
					</div>
				</td>
			</tr>
		</table>
					
					<br clear="all" />
					<br />
					<c:if test="${addProductDnD eq 'true'}">
						<script type="text/javaScript">
							dojo.addOnLoad(function() { 
								var src= new dojo.dnd.Source("${prefix}_${catEntryIDToUse}");
								src.copyOnly=true;
								src.setItem('imgPath','${thumbnail}');
								src.setItem('productDisplayPath','${catEntryDisplayUrl}');
							});
						</script>
					</c:if>
	</c:when>
		
	<c:when test="${pageView == 'imageForCompare'}">
		<td class="product_image" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_td_7">
			<div id="baseContent_${prefix}_<c:out value='${catEntryIdentifier}'/>" 
				<c:if test="${showProductQuickView eq 'true'}">
					onmouseover="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');" onmouseout="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
				</c:if>
				>
				<c:if test="${addProductDnD eq 'true'}">
					<div dojoType="dojo.dnd.Source" jsId="dndSource" id="${prefix}_${catEntryIDToUse}" copyOnly="true" dndType="${dragType}">
						<div class="dojoDndItem" dndType="${dragType}" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_47">
				</c:if>
							<c:choose>
								<c:when test="${!empty thumbnail}">
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}${emsName}_${catEntryIdentifier}',event);"
										</c:if>
										onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
										>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${thumbnail}'/>" alt="<c:out value='${shortDescription}' />" border="0" width="70" height="70"/>
									</a>
								</c:when>
								<c:otherwise>
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>" class="itemhover"
										<c:if test="${showProductQuickView eq 'true'}">
											onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
											onkeydown="shiftTabHidePopupButton('${prefix}${emsName}_${catEntryIdentifier}',event);"
										</c:if>
										onmouseout="javascript:hideBackgroundImage(this);" onmouseover="javascript:showBackgroundImage(this);"
										>
										<c:if test="${addProductDnD eq 'true'}">
											<!--[if lte IE 6.5]><iframe class="productDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
										</c:if>
										<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" alt="<fmt:message key='No_Image' bundle='${storeText}'/>" border="0" width="70" height="70"/>
									</a>
								</c:otherwise>
							</c:choose>
				<c:if test="${addProductDnD eq 'true'}">
						</div>
					</div>
				</c:if>
				<c:if test="${showProductQuickView eq 'true'}">
					<div id="popupButton_${prefix}${emsName}_${catEntryIdentifier}" class="compare_quickinfo_button">
					
							<c:set var="buttonStyle" value="secondary"/>
							<c:set var="buttonAttributes">
								id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_48"
							</c:set>
							<c:set var="buttonLink">
								<a class="strong"  id="QuickInfoButton_${prefix}_${catEntryIdentifier}" href="#"
										onfocus="showPopupButton('${prefix}${emsName}_${catEntryIdentifier}');"
										onclick="javaScript:var actionListCompare = new popupActionProperties(); actionListCompare.showProductCompare=false; actionListCompare.showWishList=${buyable}; actionListCompare.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListCompare); return false;" 
										onkeypress="javaScript:var actionListCompare = new popupActionProperties(); actionListCompare.showProductCompare=false; actionListCompare.showWishList=${buyable}; actionListCompare.showAddToCart=${buyable}; showPopup('${catalogEntryID}',event,null,'popupButton_${prefix}${emsName}_${catEntryIdentifier}',actionListCompare);" onblur="hidePopupButton('${prefix}${emsName}_${catEntryIdentifier}');" role="wairole:button" waistate:haspopup="true"><fmt:message key="QUICKINFO" bundle="${storeText}"/></a>
																																																												
							</c:set>
							<%@ include file="../ReusableObjects/StoreButton.jspf" %>
		
							

					</div>
				</c:if>
			</div>
			<c:choose>
			<c:when test="${buyable}" >
				<flow:ifEnabled feature="AjaxAddToCart"> 
					<c:choose>
						<c:when test="${dragType == 'dynamicKit'}">
							<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
						</c:when>						
						<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
						
							<c:set var="buttonStyle" value="primary"/>
							<c:set var="buttonAttributes">
								id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_50"
							</c:set>
							<c:set var="buttonLink">
									<a href="javascript: setCurrentId('WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_19'); categoryDisplayJS.AddItem2ShopCartAjax('${catEntryIDToUse}',1)" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_19" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
					
							</c:set>
							<%@ include file="../ReusableObjects/StoreButton.jspf" %>
		

						</c:when>
						<c:otherwise>
						
								<c:set var="buttonStyle" value="primary"/>
								<c:set var="buttonAttributes">
									id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_52"
								</c:set>
								<c:set var="buttonLink">
										<a href="javascript:;" onclick="javascript:var actionListCompare = new popupActionProperties(); actionListCompare.showProductCompare=false; showPopup('${catalogEntryID}', event,null,'',actionListCompare)" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_20" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
									
								</c:set>
								<%@ include file="../ReusableObjects/StoreButton.jspf" %>
		

						</c:otherwise>
					</c:choose>
				</flow:ifEnabled>
				
				<flow:ifDisabled feature="AjaxAddToCart">
					<c:choose>
						<c:when test="${dragType == 'dynamicKit'}">
							<%@ include file="../../ShoppingArea/Configurator/CatalogEntryThumbnailDisplayForDynamicKits.jspf" %>
						</c:when>						
						<c:when test="${dragType == 'item' || dragType == 'package' || (singleSKU == true && dragType == 'product')}">
						
							<c:set var="buttonStyle" value="primary"/>
							<c:set var="buttonAttributes">
								id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_54"
							</c:set>
							<c:set var="buttonLink">
										<a href="#" onclick="javascript: categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_${catEntryIDToUse}'),1);return false;" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_21" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>				
							</c:set>
							<%@ include file="../ReusableObjects/StoreButton.jspf" %>
		
		
		
							
						</c:when>
						<c:otherwise>
						
							<c:set var="buttonStyle" value="primary"/>
							<c:set var="buttonAttributes">
								id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_div_56"
							</c:set>
							<c:set var="buttonLink">
								<a href="javascript:;" onclick="javascript:var actionListCompare = new popupActionProperties(); actionListCompare.showProductCompare=false; showPopup('${catalogEntryID}', event,null,'',actionListCompare)" id="WC_CatalogEntryThumbnailDisplayJSPF_${catEntryIdentifier}_links_22" waistate:controls="MiniShoppingCart"><fmt:message key="ADDTOCART" bundle="${storeText}"/></a>
							</c:set>
							<%@ include file="../ReusableObjects/StoreButton.jspf" %>
		
								

						</c:otherwise>
					</c:choose>
					</flow:ifDisabled>
			</c:when>
			<c:otherwise>
				<fmt:message key="SKU_NOT_BUYABLE" bundle="${storeText}" />
			</c:otherwise>
			</c:choose>
		</td>
	</c:when>
		
	<c:otherwise>
						<c:set var="CatalogEntryThumbnailDisplayExtExcuted" value="false" />
						<%@ include file="../ReusableObjects/CatalogEntryThumbnailDisplayExt.jspf"%>
						<c:if test="${CatalogEntryThumbnailDisplayExtExcuted==false}">
							<c:choose>
								<c:when test="${!empty thumbnail}">
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>">
										<img src="<c:out value='${thumbnail}'/>" alt="<c:out value='${fn:replace(catEntryName, search, replaceStr)}' />" width="70" height="70" border="0"/>
									</a>
								</c:when>
								<c:otherwise>
									<a ${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>">
										<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" alt="<c:out value='${fn:replace(catEntryName, search, replaceStr)}' />" width="70" height="70" border="0"/>
									</a>
								</c:otherwise>
							</c:choose>
						</c:if>
	</c:otherwise>
</c:choose>
<c:if test="${empty param.skipAttachments || param.skipAttachments != 'true'}">
    <c:choose>
        <c:when test="${!empty thumbnail}">
            <c:set var="productCompareImagePath" value="${thumbnail}" />
        </c:when>
        <c:otherwise>
            <c:set var="productCompareImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
        </c:otherwise>
    </c:choose>
    <c:set var="compareImageDescription" value="${fn:replace(shortDescription, search, replaceCmprStr)}"/>
    <c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>
    <input type="hidden" id="compareImgPath_${catEntryIDToUse}" value="${productCompareImagePath}"/>
    <input type="hidden" id="compareProductDetailsPath_${catEntryIDToUse}" value="${catEntryDisplayUrl}"/>
    <input type="hidden" id="compareImgDescription_${catEntryIDToUse}" value="<c:out value='${compareImageDescription}'/>"/>
	<c:if test="${singleSKU}" >
		<input type="hidden" id="compareProductParentId_<c:out value='${catEntryIDToUse}'/>" value="<c:out value='${catalogEntryID}'/>"/>
	</c:if>
</c:if>

<!-- END CatalogEntryThumbnailDisplay.jsp -->
