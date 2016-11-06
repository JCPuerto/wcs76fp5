<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2012 All Rights Reserved.

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

<!-- BEGIN CachedProductOnlyDisplay.jsp -->
<%@ page import="java.util.HashMap" %>
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
	ServicesDeclarationJS.setCommonParameters('<c:out value='${WCParam.langId}'/>','<c:out value='${WCParam.storeId}'/>','<c:out value='${WCParam.catalogId}'/>');
</script>

<c:set var="search" value='"'/>
<c:set var="replaceCmprStr" value=""/>
<c:set var="search01" value="'"/>
<c:set var="replaceStr01" value="\\'"/>
<c:set var="replaceStr02" value="inches"/>
<c:set var="fromPage" value="productDisplay"/>
	
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
<wcbase:useBean id="product" classname="com.ibm.commerce.catalog.beans.ProductDataBean" scope="request" />
<c:set var="type" value="product" />
<c:set var="catalogEntryID" value="${product.productID}" />

<c:set var="patternName" value="ProductURLWithParentCategory"/>
<c:if test="${WCParam.categoryId != WCParam.top_category}">
	<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
</c:if>
<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="productId" value="${catalogEntryID}"/>
	<wcf:param name="langId" value="${WCParam.langId}"/>
	<wcf:param name="parent_category_rn" value="${WCParam.categoryId}"/>
	<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
	<wcf:param name="top_category" value="${WCParam.top_category}"/>
	<wcf:param name="urlLangId" value="${urlLangId}" />
</wcf:url>

<wcf:url var="CatalogAttachmentURL" value="CatalogAttachmentView" type="Ajax">
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="productId" value="${catalogEntryID}"/>
	<wcf:param name="catType" value="product"/>
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
			 
<div id="entitledItem_<c:out value='${catalogEntryID}'/>" style="display:none;">
								[
								<c:if test="${type == 'product'}">
									
									<c:set var="numberOfSKUs" value="${fn:length(product.entitledItems)}"/>
									<c:set var="numberOfLoops" value="1"/>
									<c:if test="${numberOfSKUs != 0}">
										<fmt:parseNumber var="numberOfLoops" value="${(numberOfSKUs/maxSKUs)+1}" integerOnly="true"/>
										<c:if test="${numberOfSKUs%maxSKUs == 0}">
											<fmt:parseNumber var="numberOfLoops" value="${numberOfSKUs/maxSKUs}" integerOnly="true"/>
										</c:if>
									</c:if>
									
									<c:forEach var="x" begin="0" end="${numberOfLoops-1}" step="1">
										<c:set var="beginIndex" value="${x*maxSKUs}"/>
										<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="catalogEntriesForAttributes" expressionBuilder="getCatalogEntryByParentCatalogEntryId"
													varShowVerb="attributesShowVerb" maxItems="${maxSKUs}" recordSetStartNumber="${beginIndex}" recordSetReferenceId="${attributesShowVerb.recordSetReferenceId}">
											<wcf:contextData name="storeId" data="${param.storeId}"/>
											<wcf:param name="catEntryId" value="${product.productID}"/>
											<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
											<wcf:param name="accessProfile" value="IBM_Store_CatalogEntryAttributes"/>
										</wcf:getData>
										
										<c:forEach var="sku" items="${catalogEntriesForAttributes}" varStatus="outerStatus">
											{
											"catentry_id" : "<c:out value='${sku.catalogEntryIdentifier.uniqueID}' />",
											"Attributes" :	{
												<c:set var="hasAttributes" value="false"/>
												<c:forEach var="definingAttrValue2" items="${sku.catalogEntryAttributes.attributes}" varStatus="innerStatus">
													<c:if test="${definingAttrValue2.usage == 'Defining'}">
														<c:if test='${hasAttributes eq "true"}'>,</c:if>
														"<c:out value="${fn:replace(definingAttrValue2.name, search01, replaceStr01)}_${fn:replace(fn:replace(definingAttrValue2.value.value, search01, replaceStr01), search, replaceStr02)}" />":"<c:out value='${innerStatus.count}' />"
														<c:set var="hasAttributes" value="true"/>
													</c:if>	
												</c:forEach>
												}
											}<c:if test='${!outerStatus.last}'>,</c:if><c:if test='${outerStatus.last && x != numberOfLoops-1}'>,</c:if>
										</c:forEach>
									</c:forEach>
									
								</c:if>
								<c:if test="${type == 'package' || type == 'bundle' || type == 'item'}">
									{
									"catentry_id" : "<c:out value='${catalogEntryID}'/>",
									"Attributes" :	{ }
									}
								</c:if>
								]
</div>

<c:if test="${!empty catalogEntryID}">
	<c:set var="items1" value="${product.entitledItems}"/>
	<c:set var="numberOfSKUs" value="${fn:length(items1)}"/>
	<c:choose>
		<c:when test="${numberOfSKUs > 1}">
			<c:set var="dragType" value="product"/>
			<c:set var="dnd_catalogEntryID" value="${catalogEntryID}"/>
		</c:when>
		<c:otherwise>
			<c:set var="dragType" value="item"/>
			<c:set var="dnd_catalogEntryID" value="${product.entitledItems[0].itemID}"/>
		</c:otherwise>
	</c:choose>
</c:if>

<%-- remove double quote from shortdescription --%>
<c:set var="search" value='"'/>
<c:set var="replaceStr" value="'"/>
<c:set var="prodShortDesc" value="${fn:replace(product.description.shortDescription, search, replaceStr)}"/>

<div id="body588">
	 <div itemscope="itemscope" itemtype="http://data-vocabulary.org/Product">
   <div id="product">
		<div class="product_images" id="WC_CachedProductOnlyDisplay_div_1">
			<c:if test="${addProductDnD eq 'true'}">
				<div dojoType="dojo.dnd.Source" jsId="dndSource" id="DndItem_<c:out value='${dnd_catalogEntryID}'/>" copyOnly="true" dndType="<c:out value='${dragType}'/>">
					<div class="dojoDndItem" dndType="<c:out value='${dragType}'/>" id="WC_CachedProductOnlyDisplay_div_2">
			</c:if>

			<span class="product">
				<c:choose>
					<c:when test="${!empty product.description.fullImage}">
						<c:if test="${addProductDnD eq 'true'}">
							<!--[if lte IE 6.5]><iframe class="productPageDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
						</c:if>
						<img id="productMainImage" src="<c:out value="${product.objectPath}${product.description.fullImage}"/>" alt="<c:out value="${prodShortDesc}" escapeXml="false"/>" title="<c:out value="${prodShortDesc}" escapeXml="false"/>" width="160" height="160"/>
					</c:when>
					<c:otherwise>
						<c:if test="${addProductDnD eq 'true'}">
							<!--[if lte IE 6.5]><iframe class="productPageDnDIFrame" scrolling="no" frameborder="0" src="<c:out value="${jspStoreImgDir}" />images/empty.gif"></iframe><![endif]-->
						</c:if>
						<img id="productMainImage" src="<c:out value="${hostPath}${jspStoreImgDir}" />images/NoImageIcon.jpg" alt="<c:out value="${prodShortDesc}" escapeXml="false"/>" title="<c:out value="${prodShortDesc}" escapeXml="false"/>" width="160" height="160"/>
					</c:otherwise>
				</c:choose>
			</span>
			<c:if test="${addProductDnD eq 'true'}">
					</div>
				</div>
				<script type="text/javascript">
				dojo.addOnLoad(function() { 
					var widgetText = "DndItem_"+"<c:out value="${dnd_catalogEntryID}"/>";
					parseWidget(widgetText);
				});
				</script>
			</c:if>
			
			<c:set property="attachmentUsage" value="IMAGE_SIZE_40" target="${product}" />
			<c:set var="image40AttachmentDataBeans" value="${product.attachmentsByUsage}" />
			<c:choose>
			 		<c:when test="${!empty image40AttachmentDataBeans[0]}">
						<c:set var="productCompareImagePath" value="${image40AttachmentDataBeans[0].objectPath}${image40AttachmentDataBeans[0].path}" />
			 		</c:when>
					<c:when test="${!empty product.description.thumbNail}">
						<c:set var="productCompareImagePath" value="${product.objectPath}${product.description.thumbNail}" />
					</c:when>
					<c:otherwise>
						<c:set var="productCompareImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
					</c:otherwise>
			 </c:choose>
			<c:set var="compareImageDescription" value="${fn:replace(product.description.shortDescription, search, replaceCmprStr)}"/>
			<c:set var="compareImageDescription" value="${fn:replace(compareImageDescription, search01, replaceCmprStr)}"/>
                        <input type="hidden" id="compareImgPath_<c:out value='${dnd_catalogEntryID}'/>" value="<c:out value='${productCompareImagePath}'/>"/>
			<input type="hidden" id="compareImgDescription_<c:out value='${dnd_catalogEntryID}'/>" value="<c:out value='${compareImageDescription}'/>"/> 
			<input type="hidden" id="compareProductDetailsPath_<c:out value='${dnd_catalogEntryID}'/>" value="<c:out value='${catEntryDisplayUrl}'/>"/>
			<c:if test="${numberOfSKUs==1}" >
				<input type="hidden" id="compareProductParentId_<c:out value='${dnd_catalogEntryID}'/>" value="<c:out value='${catalogEntryID}'/>"/>
			</c:if>
			<br />
		
			<%-- 
			  ***
				*	Start: Product angle images
				* Product angle images are loaded as attachments. Expected to have 2 sets loaded as 'ANGLEIMAGES_THUMBNAIL' and 'ANGLEIMAGES_FULLIMAGE'
				* attachment usages.
				***
			--%>
			<c:set property="attachmentUsage" value="ANGLEIMAGES_THUMBNAIL" target="${product}" />
			<c:set var="angleThumbAttachmentDataBeans" value="${product.attachmentsByUsage}" />
			<c:if test="${!empty angleThumbAttachmentDataBeans}">
				<c:set property="attachmentUsage" value="ANGLEIMAGES_FULLIMAGE" target="${product}" />
				<c:set var="angleFImageAttachmentDataBeans" value="${product.attachmentsByUsage}" />
				<span class="angles">
				<c:forEach var="attachmentDB" items="${angleThumbAttachmentDataBeans}" varStatus="aStatus">
					<c:choose>
						<c:when test="${aStatus.first}">
							<a id="WC_CachedProductOnlyDisplay_links_1_<c:out value='${aStatus.count}'/>" href="JavaScript:changeThumbNail('productAngleImg<c:out value='${aStatus.index}'/>','<c:out value="${angleFImageAttachmentDataBeans[aStatus.index].objectPath}${angleFImageAttachmentDataBeans[aStatus.index].path}"/>');"><img id="productAngleImg<c:out value='${aStatus.index}'/>" src="<c:out value="${attachmentDB.objectPath}${attachmentDB.path}"/>" alt="<c:out value="${attachmentDB.shortDescription}"/>" class="on" /></a>
						</c:when>
						<c:otherwise>
							<a id="WC_CachedProductOnlyDisplay_links_2_<c:out value='${aStatus.count}'/>" href="JavaScript:changeThumbNail('productAngleImg<c:out value='${aStatus.index}'/>','<c:out value="${angleFImageAttachmentDataBeans[aStatus.index].objectPath}${angleFImageAttachmentDataBeans[aStatus.index].path}"/>');"><img id="productAngleImg<c:out value='${aStatus.index}'/>" src="<c:out value="${attachmentDB.objectPath}${attachmentDB.path}"/>" alt="<c:out value="${attachmentDB.shortDescription}"/>" class="off" /></a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</span><br />
			</c:if>
			<%-- 
			  ***
				*	End: Product angle images
				***
			--%>

			<%@ include file="CachedProductOnlyImageExt.jspf"%>
		</div>
		
		<span itemprop="offerDetails" itemscope itemtype="http://data-vocabulary.org/Offer">
		<div class="product_options" id="WC_CachedProductOnlyDisplay_div_3">
			 <h1 id="catalog_link"  class="catalog_link"><span itemprop="name"><c:out value="${product.description.name}" escapeXml="false"/></span></h1>
			 
			 <%-- in Elite, we do not want to show the price because the price may be different depending on the 
			 contract that is selected --%>
			 <c:if test="${displayListPriceInProductPage == 'true'}">			 
				 <div id="WC_CachedProductOnlyDisplay_div_4">
					<span class="price bold"><fmt:message key="PRICE" bundle="${storeText}"/></span>
					<c:set var="catalogEntryDB" value="${product}" />
					<c:set var="displayPriceRange" value="true"/>
					<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryPriceDisplay.jspf"%>
				 </div>
			 </c:if>
			 
			<c:if test="${isBrazilStore}">
				<%-- Show Payment Discount promotion --%>
				<c:choose> 
					<%-- Brazil store promotions does not handle Multiple SKU's at this time, that is,
					     promotions at the parent level. Therefore, we'll default to the first item(1st child) of the multiple sku list to 
					     see the promotions  --%>
					<c:when test="${!empty numberOfSKUs && numberOfSKUs > 1}">
						<c:set var="currentProductId" value="${product.entitledItems[0].itemID}" />
					</c:when>
					<c:otherwise>
					<%-- Normal single SKU product  --%>
						<c:set var="currentProductId" value="${catalogEntryID}" />
					</c:otherwise>
				</c:choose>
				<%-- Flush the buffer so this fragment JSP is not cached twice --%>
				<div id="WC_CachedProductOnlyDisplay_eSpot_div_1" class="promo_price">
					<% out.flush(); %>
			            <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
			                 <c:param name="storeId" value="${WCParam.storeId}" />
			                 <c:param name="catalogId" value="${WCParam.catalogId}" />
			                 <c:param name="langId" value="${WCParam.langId}" />
			                 <c:param name="emsName" value="${eSpotPaymentPromotion}" />
			                 <c:param name="currentProductId" value="${currentProductId}" />
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
					<div id="WC_CachedProductOnlyDisplay_eSpot_div_2">
						<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ESpotNavDisplay.jsp">
	                         <c:param name="storeId" value="${WCParam.storeId}" />
	                         <c:param name="catalogId" value="${WCParam.catalogId}" />
	                         <c:param name="langId" value="${WCParam.langId}" />
	                         <c:param name="emsName" value="${eSpotFreeShipping}" />
	                         <c:param name="currentProductId" value="${currentProductId}" />
	                         <c:param name="adclass" value="no_ad" />
						</c:import> 
						<br />
					</div>
				<% out.flush(); %>
				<c:remove var="currentProductId" /> <%--remove, no longer needed --%>
			</c:if>
			<c:if test="${!isBrazilStore}"> <%-- Brazil store will display promotions near bottom of page --%>
				 <%-- We output the discounts using simple JavaScript to support older browsers such as Netscape 4  --%>
				<script type="text/javascript">
						document.write(Discount.getProductDiscountText(<c:out value="${productId}"/>));
				</script>
			</c:if>
			
			<%-- 
			  ***
				*	Start: Product Defining Attributes
				* The drop down box will only display defining attributes.
				* Defining attributes are properties of SKUs.  They are used for SKU resolution.
				***
			--%>
			<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catentry" expressionBuilder="getStoreCatalogEntryAttributesByID">
				<wcf:contextData name="storeId" data="${param.storeId}"/>
				<wcf:param name="catEntryId" value="${WCParam.productId}"/>
				<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
			</wcf:getData>
			<c:choose>
				<c:when test="${numberOfSKUs == 1}">
					<%-- 
					If there is only one SKU then let's just display the attributes of the one item as text without selection.
					Also, initialize the JavaScript code to simulate attribute selections made already.
					--%>
				 <wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catentryItem" expressionBuilder="getStoreCatalogEntryAttributesByID">
						<wcf:contextData name="storeId" data="${param.storeId}"/>
						<wcf:param name="catEntryId" value="${product.entitledItems[0].itemID}"/>
						<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
				 </wcf:getData>
	
				 <c:forEach var="attribute" items="${catentryItem.catalogEntryAttributes.attributes}" varStatus="aStatus">
						<c:if test="${attribute.usage == 'Defining'}">
							<p>
								<c:out value="${fn:replace(attribute.name, search01, replaceStr01)}"/>: <c:out value="${fn:replace(attribute.value.value, search01, replaceStr01)}"/>
							  <script type="text/javascript">
									dojo.addOnLoad(function() { 
										categoryDisplayJS.setSelectedAttribute("<c:out value='${fn:replace(attribute.name, search01, replaceStr01)}'/>","<c:out value="${fn:replace(fn:replace(attribute.value.value, search01, replaceStr01), search, replaceStr02)}"/>");
									});
								</script>
							</p>
						</c:if>
				 </c:forEach>
				</c:when>
				<c:otherwise>
					<c:choose>
					<c:when test="${!empty product.entitledItems}">
						<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="entitledItemsAttributes" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
							<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
							<c:forEach var='entitledItem' items='${product.entitledItems}'>
								<wcf:param name="UniqueID" value="${entitledItem.itemID}"/>
							</c:forEach>
							<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
						</wcf:getData>
						<jsp:useBean id="validAttributeValuesMap" class="java.util.HashMap" scope="page" />
						<c:forEach var="attribute" items="${entitledItemsAttributes[0].catalogEntryAttributes.attributes}" varStatus="attributeStatus">				
								<c:if test="${attribute.usage == 'Defining'}">
									<div class="attribute_list">
									<span class="required-field"> *</span><span class="attr_text"><c:out value="${fn:replace(attribute.name, search01, replaceStr01)}"/>:</span>
									<p>
									<label for="attrValue_<c:out value='${attributeStatus.count}'/>" class="nodisplay"><c:out value='${attribute.name}'/><fmt:message key='Checkout_ACCE_required' bundle='${storeText}'/></label>
									<select name="attrValue" id="attrValue_<c:out value='${attributeStatus.count}'/>" class="drop_down"  onChange='JavaScript:categoryDisplayJS.setSelectedAttribute("<c:out value='${fn:replace(attribute.name, search01, replaceStr01)}'/>",this.options[this.selectedIndex].value);'>
									<option value="">
										<fmt:message key="QuickInfo_Select" bundle="${storeText}"/>
									</option>
									<script type="text/javascript">
											dojo.addOnLoad(function() { 
											categoryDisplayJS.setSelectedAttribute("<c:out value='${fn:replace(attribute.name, search01, replaceStr01)}'/>",'<wcf:out value="${WCParam[attribute.name]}" escapeFormat="js"/>');
									});
									</script>
									<c:forEach var='catentryAttributeList' items='${entitledItemsAttributes}' varStatus='catEntryStatus'>
										<c:set var="definingAttrValue" value="${catentryAttributeList.catalogEntryAttributes.attributes[attributeStatus.index]}"/>
										<c:set var="definingAttrValue1" value="${definingAttrValue.value.value}"/>
											<c:if test="${empty validAttributeValuesMap[definingAttrValue1]}">		
											<%-- Build a map to track values already added to select tag--%>
												<c:set property="${definingAttrValue1}" value="${definingAttrValue1}" target="${validAttributeValuesMap}"/>
												<option value='<c:out value="${fn:replace(fn:replace(definingAttrValue1, search01, replaceStr01), search, replaceStr02)}"/>' 
												<c:if test="${fn:replace(definingAttrValue1, search01, replaceStr01) == WCParam[definingAttrValue.name]}">selected="selected"</c:if>>
													<c:out value="${fn:replace(definingAttrValue1, search01, replaceStr01)}"/>
												</option>
											</c:if>
											<c:if test='${catEntryStatus.last}'>
												<c:remove var="validAttributeValuesMap" scope="request"> </c:remove>
											</c:if>
										</c:forEach>
									  </select>
									</p>
									</div>
								</c:if>
							 </c:forEach>
					</c:when>
					<c:otherwise>
							<c:forEach var="attribute" items="${catentry.catalogEntryAttributes.attributes}" varStatus="aStatus">
								<c:if test="${attribute.usage == 'Defining'}">
									<div class="attribute_list">
									<span class="required-field"> *</span><span class="attr_text"><c:out value="${fn:replace(attribute.name, search01, replaceStr01)}"/>:</span>
									<p>
									  <label for="attrValue_<c:out value='${aStatus.count}'/>" class="nodisplay"><c:out value='${attribute.name}'/><fmt:message key='Checkout_ACCE_required' bundle='${storeText}'/></label>
									  <select name="attrValue" id="attrValue_<c:out value='${aStatus.count}'/>" class="drop_down"  onChange='JavaScript:categoryDisplayJS.setSelectedAttribute("<c:out value='${fn:replace(attribute.name, search01, replaceStr01)}'/>",this.options[this.selectedIndex].value);'>
										<option value="">
											<fmt:message key="QuickInfo_Select" bundle="${storeText}"/>
										</option>
									   <script type="text/javascript">
											dojo.addOnLoad(function() { 
											categoryDisplayJS.setSelectedAttribute("<c:out value='${fn:replace(attribute.name, search01, replaceStr01)}'/>",'<wcf:out value="${WCParam[attribute.name]}" escapeFormat="js"/>');
										});
										</script>
										<c:forEach var="allowedValue" items="${attribute.allowedValue}">
											<option value='<c:out value="${fn:replace(fn:replace(allowedValue.value, search01, replaceStr01), search, replaceStr02)}"/>' <c:if test="${fn:replace(allowedValue.value, search01, replaceStr01) == WCParam[attribute.name]}">selected="selected"</c:if>>
												<c:out value="${fn:replace(allowedValue.value, search01, replaceStr01)}"/>
											</option>
										</c:forEach>
									  </select>
									</p>
									</div>
								</c:if>
						  </c:forEach>
					</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			<%-- 
			  ***
				*	End: Product Defining Attributes
				***
			--%>
			 
 			 
			 <div>
				  <label for="quantity_<c:out value='${catalogEntryID}'/>"><fmt:message key="CurrentOrder_QTY" bundle="${storeText}"/></label>
				  <input name="quantity_<c:out value='${catalogEntryID}'/>" id="quantity_<c:out value='${catalogEntryID}'/>" type="text" size="3" value="1"/>
			 </div>

			 <br />		
			 <%@ include file="B2BCatentryContractSelectExt.jspf"%>			 
						 
			<%-- 
			  ***
				*	Start: Page action buttons
				***
			--%>
			 <c:choose>
				<c:when test="${(!empty product.maximumItemPrice && !(empty product.entitledItems[1] && product.entitledItems[0].buyable eq '0')) || alwaysShowAddToCart}" >
				 	<flow:ifEnabled feature="AjaxAddToCart">
				 		<div>
							<span class="primary_button" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="javascript:setCurrentId('productPageAdd2Cart'); categoryDisplayJS.Add2ShopCartAjax('entitledItem_<c:out value='${catalogEntryID}'/>',document.getElementById('quantity_<c:out value='${catalogEntryID}'/>').value, false)"   id="productPageAdd2Cart" ><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a><br />
							 				</span>
										</span>
									</span>	
								</span>
							</span>	
						</div>
						 <div class="features" id="WC_CachedProductOnlyDisplay_div_9">
							<flow:ifEnabled feature="ProductCompare">
								<div class="tertiary_button_shadow">
									<div class="tertiary_button">
										<a id="productPageAdd2Compare1" href="JavaScript:compareProductJS.Add2CompareAjax('<c:out value='${catalogEntryID}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');"><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a>
									</div>
								</div>
							</flow:ifEnabled>

							<flow:ifEnabled feature="wishList">
								<div class="addToWishListButtonBorder" >
									<div class="tertiary_button_shadow" id="addToWishListButton_1">
										<div class="tertiary_button left">
											<a id="productPageAdd2Wishlist" href="javascript: setCurrentId('productPageAdd2Wishlist'); categoryDisplayJS.Add2WishListAjax('entitledItem_<c:out value='${catalogEntryID}'/>')"><fmt:message key="WISHLIST" bundle="${storeText}" /> </a>
										</div>
									</div>
								</div>
							</flow:ifEnabled>
							<flow:ifEnabled feature="SOAWishlist">
								<%out.flush();%>
									<c:import url="${jspStoreDir}Snippets/MultipleWishList/MultipleWishListButton.jsp">
										<c:param name="catEntryId" value="${catalogEntryID}"/>	
										<c:param name="type" value="product"/>	
									</c:import>	
								<%out.flush();%>								
							</flow:ifEnabled>
							<flow:ifEnabled feature="RequisitionList">
								<c:set var="type" value="product" />
								<%@include file="../../../ShoppingArea/OrderCreationSection/RequisitionListSubsection/RequisitionListLinks.jspf" %>
							</flow:ifEnabled>					
						 </div>
					</flow:ifEnabled>
					
					<flow:ifDisabled feature="AjaxAddToCart">
						 <form name="OrderItemAddForm_<c:out value='${catalogEntryID}'/>" action="OrderChangeServiceItemAdd" method="post" id="OrderItemAddForm_<c:out value='${catalogEntryID}'/>">
							<input type="hidden" name="storeId" value="<c:out value='${WCParam.storeId}'/>" id="OrderItemAddForm_storeId_<c:out value='${catalogEntryID}'/>"/>
							<input type="hidden" name="langId" value="<c:out value='${WCParam.langId}'/>" id="OrderItemAddForm_langId_<c:out value='${catalogEntryID}'/>"/>
							<input type="hidden" name="catalogId" value="<c:out value='${WCParam.catalogId}'/>" id="OrderItemAddForm_catalogId_<c:out value='${catalogEntryID}'/>"/>
							<input type="hidden" name="URL" value="AjaxOrderItemDisplayView" id="OrderItemAddForm_url_<c:out value='${catalogEntryID}'/>"/>
							<input type="hidden" name="errorViewName" value="InvalidInputErrorView" id="OrderItemAddForm_errorViewName_<c:out value='${catalogEntryID}'/>"/>
							<input type="hidden" name="catEntryId" value="<c:out value='${catalogEntryID}'/>" id="OrderItemAddForm_catEntryId_<c:out value='${catalogEntryID}'/>"/>
							<input type="hidden" name="productId" value="<c:out value='${catalogEntryID}'/>" id="OrderItemAddForm_productId_<c:out value='${catalogEntryID}'/>"/>
							<input type="hidden" name="quantity" value="" id="OrderItemAddForm_quantity_<c:out value='${catalogEntryID}'/>"/>
							<input type="hidden" name="page" value="" id="OrderItemAddForm_page_${catalogEntryID}"/>
							<input type="hidden" name="contractId" value="" id="OrderItemAddForm_contractId_${catalogEntryID}"/>
							<input type="hidden" name="calculationUsage" value="-1,-2,-3,-4,-5,-6,-7" id="OrderItemAddForm_calcUsage_${catalogEntryID}"/>
							<input type="hidden" name="updateable" value="0" id="OrderItemAddForm_updateable_${catalogEntryID}"/>
							<flow:ifEnabled feature="SOAWishlist">
							<input type="hidden" name="giftListId" value="<c:out value='${giftListId}'/>" id="<c:out value='OrderItemAddForm_${catalogEntryID}_giftListId_${giftListId}'/>"/>
							</flow:ifEnabled>
						</form>
						<div>
							<span class="primary_button" >
								<span class="button_container">
									<span class="button_bg">
										<span class="button_top">
											<span class="button_bottom">   
												<a href="#" onclick="javascript:categoryDisplayJS.Add2ShopCart('entitledItem_<c:out value='${catalogEntryID}'/>',document.getElementById('OrderItemAddForm_<c:out value='${catalogEntryID}'/>'),document.getElementById('quantity_<c:out value='${catalogEntryID}'/>').value, false);return false;" id="WC_CachedProductOnlyDisplay_links_3"><fmt:message key="PRODUCT_ADD_TO_CART" bundle="${storeText}" /></a>
								 			</span>
										</span>	
									</span>
								</span>
							</span>	
						</div>
						 <div class="features" id="WC_CachedProductOnlyDisplay_div_12">
							<flow:ifEnabled feature="ProductCompare">								
								<div class="tertiary_button_shadow">
									<div class="tertiary_button">
										<a id="productPageAdd2Compare2" href="JavaScript:compareProductJS.Add2CompareAjax('<c:out value='${catalogEntryID}'/>','<c:out value='${productCompareImagePath}'/>', '<c:out value='${catEntryDisplayUrl}'/>','<c:out value='${compareImageDescription}'/>');"><fmt:message key="ADDTOCOMPARE" bundle="${storeText}" /></a>
									</div>
								</div>
							</flow:ifEnabled>
							<flow:ifEnabled  feature="wishList">
								<div class="addToWishListButtonBorder" >
									<div class="tertiary_button_shadow" id="addToWishListButton_1">
										<div class="tertiary_button left">
											<a id="WC_CachedProductOnlyDisplay_links_4" href="#" onclick="javascript: categoryDisplayJS.Add2WishList('entitledItem_<c:out value='${catalogEntryID}'/>',document.getElementById('OrderItemAddForm_<c:out value='${catalogEntryID}'/>'));return false;"><fmt:message key="WISHLIST" bundle="${storeText}" /> </a>
										</div>
									</div>
								</div>
							</flow:ifEnabled>
							<flow:ifEnabled  feature="SOAWishlist">
								<%out.flush();%>
									<c:import url="${jspStoreDir}Snippets/MultipleWishList/MultipleWishListButton.jsp">
										<c:param name="catEntryId" value="${catalogEntryID}"/>	
										<c:param name="type" value="product"/>	
									</c:import>		
								<%out.flush();%>									
							</flow:ifEnabled>
							<flow:ifEnabled feature="RequisitionList">
								<c:set var="type" value="product" />
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
											<a href="<c:out value="${TopCategoriesDisplayURL}" />" id="WC_CachedProductOnlyDisplay_links_5"><fmt:message key="RETURN_SHOPPING" bundle="${storeText}" /></a>
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

			<%@ include file="CachedProductOnlyButtonExt.jspf"%>
			<%@ include file="GiftRegistryCachedProductOnlyButtonExt.jspf"%>
			<br />
			<%-- 
			  ***
				*	End: Page action buttons
				***
			--%>
			
			<c:if test="${numberOfSKUs == 1}">
				<c:set var="forInventoryCatentryId" value="${product.entitledItems[0].itemID}"/>
			</c:if>
			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryInventoryStatus.jsp">
				<c:param name="fromPage" value="${fromPage}"/>
				<c:param name="catalogEntryID" value="${catalogEntryID}"/>
				<c:param name="catentryId" value="${forInventoryCatentryId}"/>
				<c:param name="numberOfSKUs" value="${numberOfSKUs}"/>
			</c:import>
			<%out.flush();%>
			<%@ include file="CatalogEntryInventoryStatusEIExt.jspf"%>
			
		</div>
		</span>
		<br />
		<%-- 
							  ***
							  *	Start: Cross-Sell, Up-Sell, Accessory, Replacement
							  * Include MerchandisingAssociationsDisplay.jsp if Cross-Sell, Up-Sell, Accessory, Replacement are set up
							  ***
							--%>
							<%-- Flush the buffer so this fragment JSP is not cached twice --%>
							<%out.flush();%>
						        <c:import url="${jspStoreDir}Snippets/Catalog/MerchandisingAssociations/MerchandisingAssociationsDisplay.jsp">
				            			<c:param name="catalogEntryType" value="ProductBean"/>
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
		<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("WC_CachedProductOnlyDisplay_div_15"); });</script>
			<c:set var="productDescHeaderListView" value="nodisplay"/>			
		</flow:ifDisabled>
		<flow:ifEnabled feature="ProductDetailDescListView">
			<c:set var="productDescHeaderListView" value="productDescHeaderList"/>
			<c:set var="HideTabsForListview" value="nodisplay" />
		</flow:ifEnabled>
		<div class="specs" id="WC_CachedProductOnlyDisplay_div_15">
			 <div class="tabs ${HideTabsForListview}" id="WC_CachedProductOnlyDisplay_div_16">
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
			 	 <%@ include file="CachedProductOnlyTabsExt.jspf"%>
			 </div>
			 <br/>
			 <div id="mainTabContainer" class="info" dojoType="dijit.layout.TabContainer" selectedTab="Attachments" doLayout="false" tabPosition="left-h">
				  <div id="Description" dojoType="dijit.layout.ContentPane">
					<div class="${productDescHeaderListView}"><fmt:message key="DESCRIPTION" bundle="${storeText}" /></div>
				  	<p>
						<fmt:message key="SKU" bundle="${storeText}" />: <c:out value="${product.partNumber}" escapeXml="false"/>
			 			</p>
				  	<p>
				  	<c:out value="${product.description.shortDescription}" escapeXml="false"/>
				  	</p>
						<br />
						<p>
							<span itemprop="description">
								<c:out value="${product.description.longDescription}" escapeXml="false"/>
							</span>
						</p>
						<br />
						<p>
							<c:set var="descAttrCount" value="0"/>
							<c:forEach var="attribute" items="${catentry.catalogEntryAttributes.attributes}">
								<c:if test="${ attribute.usage=='Descriptive' }" >
									<c:set var="descAttrCount" value="${descAttrCount + 1}"/>
									<span class="product" id="descAttributeName_${descAttrCount}"><c:out value="${attribute.name}" escapeXml="false" />:</span>											
									<c:choose>
										<c:when test="${ !empty attribute.extendedValue['Image1']  }" >
											<span id="descAttributeValue_${descAttrCount}"><c:out value="${attribute.value.value}" escapeXml="false" />&nbsp;<img src="<c:out value="${product.objectPath}${attribute.extendedValue['Image1']}" />" alt="<c:out value="${attribute.value.value}" />" border="0"/></span><br/>												
										</c:when>
										<c:otherwise >
											<span id="descAttributeValue_${descAttrCount}"><c:out value="${attribute.value.value}" escapeXml="false" /></span>
										</c:otherwise>
									</c:choose>
									<br/>
								</c:if>
							</c:forEach>
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
							   <c:param name="productId" value="${catalogEntryID}"/>  
							   <c:param name="catType" value="product"/>  
							   <c:param name="excludeUsageStr" value="ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,ANGLEIMAGES_HDIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40,IMAGE_SIZE_330,IMAGE_SIZE_1000"/>  
							   <c:param name="retrieveLanguageIndependentAtchAst" value="1"/>  
						</c:import>  
						<%out.flush();%> 
					</flow:ifEnabled>				  
				  </div>
				  <%@ include file="CachedProductOnlyTabPanesExt.jspf"%>
			 </div>
			 <div id="WC_CachedProductOnlyDisplay_div_16_9" class="clear_float"></div>
			 <div class="tabfooter" id="WC_CachedProductOnlyDisplay_div_17"></div>
		</div>
		
   </div>
  </div>
</div>
<!-- END CachedProductOnlyDisplay.jsp -->
