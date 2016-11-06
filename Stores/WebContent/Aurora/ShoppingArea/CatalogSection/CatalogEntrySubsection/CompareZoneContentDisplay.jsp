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
  * This JSP file is used to render the content of the products compare zone.
  * At most 4 products are allowed in the zone.
  * Each product is rendered with the following information:
  *		- a product image
  *		- when the image is clicked on, the browser is re-directed to the associated product details page
  *		- an alt/title attribute showing the product description when the image is hovered over 
  * 
  *	An example on how this page is imported:
  *		<c:import url="${jspStoreDir}ShoppingArea/CatalogSection/CatalogEntrySubsection/CompareZoneContentDisplay.jsp">
  *			<c:param name="compareDisplayKey" value="${compareDisplayKey}"/>
  *		</c:import>
  *
  *	The "compareDisplayKey" parameter is used in displaying a message in the compare zone when it is empty.
  *
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="compareDisplayKey" value="${param.compareDisplayKey}"/>
<c:if test="${empty compareDisplayKey}">
	<c:set var="compareDisplayKey" value="${WCParam.compareDisplayKey}"/>
</c:if>
<c:set var="cookieKey" value="CompareItems_${WCParam.storeId}"/>
<c:set var="categoryEntryIDs" value="${cookie[cookieKey].value}"/>

	<div id="compareDropZoneImg" class="items ${(!empty categoryEntryIDs)?"nodisplay":""}">
		<div id="WC_CompareZoneDisplayf_div_2" class="empty_compare_zone"><fmt:message key='${compareDisplayKey}' bundle='${storeText}'/></div>
	</div>
	<c:if test="${!empty categoryEntryIDs}">
		<div id="compareDropZoneImgDiv"  style="width:100%">
		<c:set var="categoryEntryIDs" value="${fn:replace(categoryEntryIDs, '%3B', ';')}"/>
		<table>
			<tbody id="compareItemsTable">
				<tr id="compareRow">
					<c:forTokens items="${categoryEntryIDs}" delims=";" var="categoryEntryId" varStatus="counter">
						<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
								expressionBuilder="getCatalogEntryViewAttachmentsByID" varShowVerb="showCatalogNavigationView" maxItems="1" recordSetStartNumber="0" scope="request">
							<wcf:param name="UniqueID" value="${categoryEntryId}" />
							<wcf:contextData name="storeId" data="${WCParam.storeId}" />
							<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
						</wcf:getData>
						
						<c:set var="catEntry" value="${catalogNavigationView.catalogEntryView[0]}" />
						
						<c:forEach items="${catEntry.attachments}" var="attachment">
								<c:if test="${'IMAGE_SIZE_40' == attachment.usage}">
									<c:set var="image40Attachment" value="${attachment}" />
								</c:if>
						</c:forEach>	
						
						<c:choose>
								<c:when test="${!empty image40Attachment}">
									<c:set var="productCompareImagePath" value="${staticAssetContextRoot}/${image40Attachment.attachmentAssetPath}" />
								</c:when>
								<c:when test="${!empty catEntry.thumbnail}">
									<c:set var="productCompareImagePath" value="${catEntry.thumbnail}" />
								</c:when>
								<c:otherwise>
									<c:set var="productCompareImagePath" value="${jspStoreImgDir}images/NoImageIcon_sm45.jpg" />
								</c:otherwise>
						 </c:choose>
						
						<c:set var="patternName" value="ProductURLWithParentCategory"/>
						<c:if test="${WCParam.parent_category_rn != WCParam.top_category}">
							<c:set var="patternName" value="ProductURLWithParentAndTopCategory"/>
						</c:if>
						<wcf:url var="catEntryDisplayUrl" patternName="${patternName}" value="Product2">
							<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
							<wcf:param name="storeId" value="${WCParam.storeId}"/>
							<wcf:param name="productId" value="${categoryEntryId}"/>
							<wcf:param name="langId" value="${WCParam.langId}"/>
							<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
							<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
							<wcf:param name="top_category" value="${WCParam.top_category}"/>
							<wcf:param name="urlLangId" value="${urlLangId}" />
						</wcf:url>
						
						<td id="compareCatentry${categoryEntryId}">
							<div id="compareCatentryContainer${categoryEntryId}">
								<div id="compare_img_${categoryEntryId}" class="compare_img">
									<a id="imgcatBrowseCompare_Item_${categoryEntryId}" href="${catEntryDisplayUrl}">
										<img height="40" width="40" border="0" alt="${catEntry.shortDescription}" title="${catEntry.shortDescription}" src="${productCompareImagePath}"></img>
									</a>
								</div>
								<div id="compare_info_${categoryEntryId}" class="compare_info">
									<div id="compare_product_desc_${categoryEntryId}" class="compare_product_desc">
										<c:out value="${catEntry.shortDescription}"/>
									</div>
								</div>
							</div>
						</td>
						<c:remove var="catEntry"/>
					</c:forTokens>
				</tr>
			</tbody>
		</table>
		</div>
	</c:if>

