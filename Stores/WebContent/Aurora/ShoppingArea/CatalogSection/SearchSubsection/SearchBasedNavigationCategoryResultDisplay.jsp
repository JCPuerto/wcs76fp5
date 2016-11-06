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
  * This JSP file renders the search results for a given category ID.
  *****
--%>
<!-- BEGIN SearchBasedNavigationCategoryResultsDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="categoryId" value="${WCParam.categoryId}"/>
<c:if test="${empty categoryId}">
	<c:set var="categoryId" value="${param.categoryId}"/>
</c:if>

<c:set var="pageSize" value="${param.pageSize}"/>
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="12"/>
</c:if>

<c:set var="pageView" value="${param.pageView}"/>
<c:if test="${empty pageView}">
	<c:set var="pageView" value="${defaultPageView}"/>
</c:if>

<%-- Counts the page number we are drawing in.  --%>
<c:set var="currentPage" value="${WCParam.currentPage}" />
<c:if test="${empty currentPage}">
	<c:set var="currentPage" value="0" />
</c:if>

<c:set var="beginIndex" value="${WCParam.beginIndex}" />
<c:if test="${empty beginIndex}">
	<c:set var="beginIndex" value="0" />
</c:if>

<c:set var="numberProductsPerRow">
	<c:out value="${WCParam.numberProductsPerRow}" default="4" />
</c:set>


<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
	expressionBuilder="getCatalogNavigationViewByCategory" scope="request" varShowVerb="showCatalogNavigationView" 
	maxItems="${pageSize}" recordSetStartNumber="${beginIndex}"  scope="request">
	<wcf:param name="categoryId" value="${categoryId}" />
	<wcf:param name="orderBy" value="${WCParam.orderBy}" />
	<wcf:contextData name="storeId" data="${WCParam.storeId}" />
	<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
</wcf:getData>

<c:set var="productResults" value="${catalogNavigationView.catalogEntryView}"/>
<c:set var="totalCount" value="${showCatalogNavigationView.recordSetTotal}" scope="request"/>
<c:set var="globalpricemode" value="${catalogNavigationView.metaData.price}" scope="request"/>

<fmt:formatNumber var="totalPages" type="number" groupingUsed="false" value="${totalCount / pageSize}" maxFractionDigits="0" />
	<c:if test="${totalCount - (totalPages * pageSize) > 0}" >
		<c:set var="totalPages" value="${totalPages + 1}" />
	</c:if>

	<fmt:formatNumber var="currentPage" type="number" groupingUsed="false" value="${beginIndex / pageSize}" maxFractionDigits="0" />
	<c:set var="resultCountOnPage" value="${pageSize + beginIndex}"/>
	<c:choose>
		<c:when test="${resultCountOnPage > totalCount}">
			<c:set var="resultCountOnPage" value="${totalCount}"/>
		</c:when>
	</c:choose>
	<c:set var="recordEnd" value="${resultCountOnPage}"/>
	<c:set var="recordStart" value="${beginIndex}"/>
	<c:set var="prevPageIndex" value="${beginIndex - pageSize}"/>
	<c:choose>
		<c:when test="${prevPageIndex < 0}">
			<c:set var="prevPageIndex" value="0"/>
			<c:set var="previousPageExists" value="false"/>
		</c:when>
		<c:otherwise>
			<c:set var="previousPageExists" value="true"/>
		</c:otherwise>
	</c:choose>
	<c:set var="nextPageIndex" value="${beginIndex + pageSize}"/>
	<c:choose>
		<c:when test="${nextPageIndex >= totalCount}">
			<c:set var="nextPageIndex" value="${beginIndex}"/>
			<c:set var="nextPageExists" value="false"/>
		</c:when>
		<c:otherwise>
			<c:set var="nextPageExists" value="true"/>
		</c:otherwise>
	</c:choose>
	<c:set var="completeIndicator" value="${!nextPageExists}"/>
	<c:if test="${previousPageExists}">
		<wcf:url var="CategoryDisplayViewPrevURL" value="SearchBasedNavigationCategoryResultDisplayView" type="Ajax">
		  <wcf:param name="langId" value="${langId}" />						
		  <wcf:param name="storeId" value="${WCParam.storeId}" />
		  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
		  <wcf:param name="categoryId" value="${param.categoryId}" />
		  <wcf:param name="beginIndex" value="${beginIndex - pageSize}" />
		  <wcf:param name="pageView" value="${param.pageView}" />
		  <wcf:param name="categoryId" value="${categoryId}" />
			<c:choose>
				<%-- Use the context parameters if they are available; usually in a subcategory --%>			
				<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
					<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
					<wcf:param name="top_category" value="${WCParam.top_category}" />
				</c:when>
				<%-- In a top category; use top category parameters --%>
				<c:when test="${WCParam.top == 'Y'}">
					<wcf:param name="parent_category_rn" value="${categoryId}" />
					<wcf:param name="top_category" value="${categoryId}" />
				</c:when>
				<%-- Store front main page; usually eSpots, parents unknown --%>
				<c:otherwise>
					<wcf:param name="parent_category_rn" value="" />
					<wcf:param name="top_category" value="" />
				</c:otherwise>
			</c:choose>
		</wcf:url>
	</c:if>

	<c:if test="${nextPageExists}">
		<wcf:url var="CategoryDisplayViewNextURL" value="SearchBasedNavigationCategoryResultDisplayView" type="Ajax">
		  <wcf:param name="langId" value="${langId}" />						
		  <wcf:param name="storeId" value="${WCParam.storeId}" />
		  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
		  <wcf:param name="categoryId" value="${param.categoryId}" />
		  <wcf:param name="beginIndex" value="${beginIndex + pageSize}" />
		  <wcf:param name="pageView" value="${param.pageView}" />
		  <wcf:param name="categoryId" value="${categoryId}" />
			<c:choose>
				<%-- Use the context parameters if they are available; usually in a subcategory --%>			
				<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
					<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
					<wcf:param name="top_category" value="${WCParam.top_category}" />
				</c:when>
				<%-- In a top category; use top category parameters --%>
				<c:when test="${WCParam.top == 'Y'}">
					<wcf:param name="parent_category_rn" value="${categoryId}" />
					<wcf:param name="top_category" value="${categoryId}" />
				</c:when>
				<%-- Store front main page; usually eSpots, parents unknown --%>
				<c:otherwise>
					<wcf:param name="parent_category_rn" value="" />
					<wcf:param name="top_category" value="" />
				</c:otherwise>
			</c:choose>
		</wcf:url>
	</c:if>

<c:if test="${totalCount > 0}">
	<wcf:url var="CategoryDisplayViewFullURL" value="SearchBasedNavigationCategoryResultDisplayView" type="Ajax">
	  <wcf:param name="langId" value="${langId}" />						
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="categoryId" value="${param.categoryId}" />
	  <wcf:param name="beginIndex" value="${beginIndex}" />
	  <wcf:param name="pageView" value="detailed" />
	  <wcf:param name="categoryId" value="${categoryId}" />
			<c:choose>
				<%-- Use the context parameters if they are available; usually in a subcategory --%>			
				<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
					<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
					<wcf:param name="top_category" value="${WCParam.top_category}" />
				</c:when>
				<%-- In a top category; use top category parameters --%>
				<c:when test="${WCParam.top == 'Y'}">
					<wcf:param name="parent_category_rn" value="${categoryId}" />
					<wcf:param name="top_category" value="${categoryId}" />
				</c:when>
				<%-- Store front main page; usually eSpots, parents unknown --%>
				<c:otherwise>
					<wcf:param name="parent_category_rn" value="" />
					<wcf:param name="top_category" value="" />
				</c:otherwise>
			</c:choose>
	</wcf:url>

	<wcf:url var="CategoryDisplayViewURL" value="SearchBasedNavigationCategoryResultDisplayView" type="Ajax">
	  <wcf:param name="langId" value="${langId}" />						
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="categoryId" value="${param.categoryId}" />
	  <wcf:param name="beginIndex" value="${beginIndex}" />
	  <wcf:param name="pageView" value="image" />
	  <wcf:param name="categoryId" value="${categoryId}" />
			<c:choose>
				<%-- Use the context parameters if they are available; usually in a subcategory --%>			
				<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
					<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
					<wcf:param name="top_category" value="${WCParam.top_category}" />
				</c:when>
				<%-- In a top category; use top category parameters --%>
				<c:when test="${WCParam.top == 'Y'}">
					<wcf:param name="parent_category_rn" value="${categoryId}" />
					<wcf:param name="top_category" value="${categoryId}" />
				</c:when>
				<%-- Store front main page; usually eSpots, parents unknown --%>
				<c:otherwise>
					<wcf:param name="parent_category_rn" value="" />
					<wcf:param name="top_category" value="" />
				</c:otherwise>
			</c:choose>
	</wcf:url>


	<div class="contentgrad_header" id="WC_CatalogSearchResultDisplay_div_1">
		<div class="left_corner" id="WC_CatalogSearchResultDisplay_div_2"></div>
		<div class="left" id="WC_CatalogSearchResultDisplay_div_3"></div>
		<div class="right_corner" id="WC_CatalogSearchResultDisplay_div_4"></div>
		
		<div class="headertext"><fmt:message key="PRODUCTS" bundle="${storeText}"/>: <c:out value="${totalCount}"/></div>
		<div class="text">
			<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<fmt:param><fmt:formatNumber value="${recordStart+1}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${recordEnd}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${totalCount}"/></fmt:param>
			</fmt:message>
			<c:if test="${totalPages > 1}">
				<span class="paging">
					<c:if test="${recordStart != 0}">
						<a id="WC_CategoryOnlyResultsDisplay_links_1" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_1'); wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex'] = '<c:out value='${beginIndex - pageSize}'/>'; categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewPrevURL}'/>');">
					</c:if>
					<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
					<c:if test="${recordStart != 0}">
						</a>
					</c:if>

					<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
						<fmt:param><fmt:formatNumber value="${currentPage+1}"/></fmt:param>
						<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
					</fmt:message>

					<c:if test="${!completeIndicator}">
						<a id="WC_CategoryOnlyResultsDisplay_links_2" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_2'); wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex'] = '<c:out value='${beginIndex + pageSize}'/>'; categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewNextURL}'/>');">
					</c:if>
					<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
					<c:if test="${!completeIndicator}">
						</a>
					</c:if>
				</span>
			</c:if>
		</div>
		<c:if test="${not empty globalreport}">
			<div class="display_text" style="max-width:420px">
				<img src="<c:out value="${jspStoreImgDir}" />images/tip_box_icon.gif" alt="<c:out value="${globalreport.indexStatus}" escapeXml="false" />"/>
				<c:out value="${globalreport.indexStatus}" escapeXml="false" />
			</div>
		</c:if>	
	</div>

	<div class="body588" id="WC_CatalogSearchResultDisplay_div_4_1">
		<div class="sorting_controls right" id="WC_CatalogSearchResultDisplay_div_4_2">
			 <label for="orderBy"><fmt:message key="FF_SORT_BY" bundle="${storeText}"/></label>
			 <select id="orderBy" name="orderBy" class="fastFinderSortDropDown" onchange="setCurrentId('orderBy'); wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex'] = '0'; categoryDisplayJS.loadContentURL(this.value);">

			 	<wcf:url var="SearchDisplayNoSortURL" value="SearchBasedNavigationCategoryResultDisplayView" type="Ajax">
					<wcf:param name="langId" value="${langId}" />						
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="categoryId" value="${param.categoryId}" />
					<wcf:param name="beginIndex" value="0" />
					<wcf:param name="pageView" value="${pageView}" />
					<wcf:param name="pageSize" value="${pageSize}"/>
					<wcf:param name="categoryId" value="${categoryId}" />
					<c:choose>
						<%-- Use the context parameters if they are available; usually in a subcategory --%>			
						<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
							<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
							<wcf:param name="top_category" value="${WCParam.top_category}" />
						</c:when>
						<%-- In a top category; use top category parameters --%>
						<c:when test="${WCParam.top == 'Y'}">
							<wcf:param name="parent_category_rn" value="${categoryId}" />
							<wcf:param name="top_category" value="${categoryId}" />
						</c:when>
						<%-- Store front main page; usually eSpots, parents unknown --%>
						<c:otherwise>
							<wcf:param name="parent_category_rn" value="" />
							<wcf:param name="top_category" value="" />
						</c:otherwise>
					</c:choose>
				</wcf:url>
		 		<option value="${SearchDisplayNoSortURL}"><fmt:message key="SEARCH_NO_SORT" bundle="${storeText}"/></option>
		 		<wcf:url var="SearchDisplaySortURL1" value="SearchBasedNavigationCategoryResultDisplayView" type="Ajax">
					<wcf:param name="langId" value="${langId}" />						
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="categoryId" value="${param.categoryId}" />
					<wcf:param name="beginIndex" value="0" />
					<wcf:param name="pageView" value="${pageView}" />
					<wcf:param name="pageSize" value="${pageSize}"/>
					<wcf:param name="categoryId" value="${categoryId}" />
					<wcf:param name="orderBy" value="1"/>
					<c:choose>
						<%-- Use the context parameters if they are available; usually in a subcategory --%>			
						<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
							<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
							<wcf:param name="top_category" value="${WCParam.top_category}" />
						</c:when>
						<%-- In a top category; use top category parameters --%>
						<c:when test="${WCParam.top == 'Y'}">
							<wcf:param name="parent_category_rn" value="${categoryId}" />
							<wcf:param name="top_category" value="${categoryId}" />
						</c:when>
						<%-- Store front main page; usually eSpots, parents unknown --%>
						<c:otherwise>
							<wcf:param name="parent_category_rn" value="" />
							<wcf:param name="top_category" value="" />
						</c:otherwise>
					</c:choose>
				</wcf:url>
		 		<c:choose>
		 			<c:when test="${WCParam.orderBy eq '1'}">
		 				<option value="${SearchDisplaySortURL1}" selected="selected"><fmt:message key="FF_SORT_BY_BRANDS" bundle="${storeText}"/></option>
		 			</c:when>
		 			<c:otherwise>
		 				<option value="${SearchDisplaySortURL1}"><fmt:message key="FF_SORT_BY_BRANDS" bundle="${storeText}"/></option>
		 			</c:otherwise>
		 		</c:choose>
		 		<wcf:url var="SearchDisplaySortURL2" value="SearchBasedNavigationCategoryResultDisplayView" type="Ajax">
					<wcf:param name="langId" value="${langId}" />						
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${WCParam.catalogId}" />
					<wcf:param name="categoryId" value="${param.categoryId}" />
					<wcf:param name="beginIndex" value="0" />
					<wcf:param name="pageView" value="${pageView}" />
					<wcf:param name="pageSize" value="${pageSize}"/>
					<wcf:param name="categoryId" value="${categoryId}" />
					<wcf:param name="orderBy" value="2"/>
					<c:choose>
						<%-- Use the context parameters if they are available; usually in a subcategory --%>			
						<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
							<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
							<wcf:param name="top_category" value="${WCParam.top_category}" />
						</c:when>
						<%-- In a top category; use top category parameters --%>
						<c:when test="${WCParam.top == 'Y'}">
							<wcf:param name="parent_category_rn" value="${categoryId}" />
							<wcf:param name="top_category" value="${categoryId}" />
						</c:when>
						<%-- Store front main page; usually eSpots, parents unknown --%>
						<c:otherwise>
							<wcf:param name="parent_category_rn" value="" />
							<wcf:param name="top_category" value="" />
						</c:otherwise>
					</c:choose>
				</wcf:url>
		 		<c:choose>
		 			<c:when test="${WCParam.orderBy eq '2'}">
		 				<option value="${SearchDisplaySortURL2}" selected="selected"><fmt:message key="SEARCH_SORT_BY_NAME" bundle="${storeText}"/></option>
		 			</c:when>
		 			<c:otherwise>
		 				<option value="${SearchDisplaySortURL2}"><fmt:message key="SEARCH_SORT_BY_NAME" bundle="${storeText}"/></option>
		 			</c:otherwise>
		 		</c:choose>
				<c:if test="${globalpricemode == 1}">
					<wcf:url var="SearchDisplaySortURL3" value="SearchBasedNavigationCategoryResultDisplayView" type="Ajax">
						<wcf:param name="langId" value="${langId}" />						
						<wcf:param name="storeId" value="${WCParam.storeId}" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />
						<wcf:param name="categoryId" value="${param.categoryId}" />
						<wcf:param name="beginIndex" value="0" />
						<wcf:param name="pageView" value="${pageView}" />
						<wcf:param name="pageSize" value="${pageSize}"/>
						<wcf:param name="categoryId" value="${categoryId}" />
						<wcf:param name="orderBy" value="3"/>
						<c:choose>
							<%-- Use the context parameters if they are available; usually in a subcategory --%>			
							<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
								<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
								<wcf:param name="top_category" value="${WCParam.top_category}" />
							</c:when>
							<%-- In a top category; use top category parameters --%>
							<c:when test="${WCParam.top == 'Y'}">
								<wcf:param name="parent_category_rn" value="${categoryId}" />
								<wcf:param name="top_category" value="${categoryId}" />
							</c:when>
							<%-- Store front main page; usually eSpots, parents unknown --%>
							<c:otherwise>
								<wcf:param name="parent_category_rn" value="" />
								<wcf:param name="top_category" value="" />
							</c:otherwise>
						</c:choose>
					</wcf:url>
			 		<c:choose>
			 			<c:when test="${WCParam.orderBy eq '3'}">
			 				<option value="${SearchDisplaySortURL3}" selected="selected"><fmt:message key="SEARCH_SORT_LOW_TO_HIGH" bundle="${storeText}"/></option>
		 				</c:when>
		 				<c:otherwise>
							<option value="${SearchDisplaySortURL3}"><fmt:message key="SEARCH_SORT_LOW_TO_HIGH" bundle="${storeText}"/></option>
		 				</c:otherwise>
		 			</c:choose>
		 			<wcf:url var="SearchDisplaySortURL4" value="SearchBasedNavigationCategoryResultDisplayView" type="Ajax">
						<wcf:param name="langId" value="${langId}" />						
						<wcf:param name="storeId" value="${WCParam.storeId}" />
						<wcf:param name="catalogId" value="${WCParam.catalogId}" />
						<wcf:param name="categoryId" value="${param.categoryId}" />
						<wcf:param name="beginIndex" value="0" />
						<wcf:param name="pageView" value="${pageView}" />
						<wcf:param name="pageSize" value="${pageSize}"/>
						<wcf:param name="categoryId" value="${categoryId}" />
						<wcf:param name="orderBy" value="4"/>
						<c:choose>
							<%-- Use the context parameters if they are available; usually in a subcategory --%>			
							<c:when test="${!empty WCParam.parent_category_rn && !empty WCParam.top_category}">
								<wcf:param name="parent_category_rn" value="${WCParam.parent_category_rn}" />
								<wcf:param name="top_category" value="${WCParam.top_category}" />
							</c:when>
							<%-- In a top category; use top category parameters --%>
							<c:when test="${WCParam.top == 'Y'}">
								<wcf:param name="parent_category_rn" value="${categoryId}" />
								<wcf:param name="top_category" value="${categoryId}" />
							</c:when>
							<%-- Store front main page; usually eSpots, parents unknown --%>
							<c:otherwise>
								<wcf:param name="parent_category_rn" value="" />
								<wcf:param name="top_category" value="" />
							</c:otherwise>
						</c:choose>
					</wcf:url>
					<c:choose>
						<c:when test="${WCParam.orderBy eq '4'}">
							<option value="${SearchDisplaySortURL4}" selected="selected"><fmt:message key="SEARCH_SORT_HIGH_TO_LOW" bundle="${storeText}"/></option>
						</c:when>
						<c:otherwise>
							<option value="${SearchDisplaySortURL4}"><fmt:message key="SEARCH_SORT_HIGH_TO_LOW" bundle="${storeText}"/></option>
						</c:otherwise>
					</c:choose>
				</c:if>
			</select>
		</div>

		<div class="clear_float" id="WC_CatalogSearchResultDisplay_div_4_3"></div>
		<div class="views1" id="WC_CatalogSearchResultDisplay_div_4_4">
			<span class="views">
				<span class="views_icon">
					<c:choose>
						<c:when test="${pageView !='detailed'}">
							<c:set var="gridView" value="four-grid"/>
							<img id="imageTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}grid_selected.png"/>" alt="<fmt:message key="FF_VIEWICONS" bundle="${storeText}"/>"/>
							<a id="WC_CategoryOnlyResultsDisplay_links_4" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_4'); wc.render.getContextById('CategoryDisplay_Context').properties['pageView'] = 'detailed'; categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewFullURL}'/>');">
								<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />list_normal.png" alt="<fmt:message key="CATEGORY_DETAILED_VIEW" bundle="${storeText}"/>" />
							</a>
						</c:when>
						<c:otherwise>
							<c:set var="gridView" value="horizontal_grid"/>
							<a id="WC_CategoryOnlyResultsDisplay_links_3" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_3'); wc.render.getContextById('CategoryDisplay_Context').properties['pageView'] = 'image'; categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewURL}'/>');">
								<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />grid_normal.png" alt="<fmt:message key="CATEGORY_IMAGE_VIEW" bundle="${storeText}"/>" />
							</a>
							<img id="detailedTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}list_selected.png"/>" alt="<fmt:message key="FF_VIEWDETAILS" bundle="${storeText}"/>"/>
						</c:otherwise>	
					</c:choose>
				</span>
			</span> 
		</div>
		
		<table id="<c:out value='${gridView}'/>" cellpadding="0" cellspacing="0" border="0">
			<c:set var="currentItemCount" value="${recordStart}" />
			<c:set var="rowItemCount" value="0"/>
			<c:set var="rowBeginIndex" value="0"/>
				
			<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="skus" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
				<wcf:contextData name="storeId" data="${param.storeId}"/>
				<c:forEach var="catEntry" items="${productResults}" varStatus="status">
					<wcf:param name="UniqueID" value="${catEntry.uniqueID}"/>
				</c:forEach>
				<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
			</wcf:getData>				

			<c:forEach var="catalogIdEntry" items="${productResults}">
				<c:set var="catEntryIdentifier" value="${catalogIdEntry.uniqueID}"/>
				<c:set var="singleSKU" value="${catalogIdEntry.hasSingleSKU}"/>
				<c:if test="${singleSKU == 'true'}">
					<c:set var="catEntryIdentifier" value="${catalogIdEntry.singleSKUCatalogEntryID}"/>
				</c:if>			
				
				<c:set var="attributes" value="" scope="request"/>
				<c:forEach var="sku" items="${skus}" varStatus="status1">
					<c:if test="${sku.catalogEntryIdentifier.uniqueID eq catEntryIdentifier}">
						<c:set var="attributes" value="${sku.catalogEntryAttributes.attributes}" scope="request"/>
					</c:if>
				</c:forEach>		
				
				<%@ include file="../../../Snippets/Search/CatalogEntrySetPriceDisplay.jspf" %>

				<c:set var="currentItemCount" value="${currentItemCount + 1}" />
				<c:if test="${(recordStart <= currentItemCount) && (recordEnd >= currentItemCount)}">
					<c:if test="${rowItemCount == 0}">
						<tr class="item_container">
							<td class="divider_line" colspan="4" id="WC_CategoryOnlyResultsDisplay_td_1_<c:out value='${status.count}'/>"></td>
						</tr>
						<tr class="item_container">
					</c:if>
					<c:choose>
						<c:when test="${pageView == 'image'}">
							<td class="item" id="WC_CategoryOnlyResultsDisplay_td_2_<c:out value='${status.count}'/>">
								<div id="WC_CategoryOnlyResultsDisplay_div_6_<c:out value='${status.count}'/>" <c:if test="${rowItemCount!=0}"> class="container" </c:if>>
									<c:set var="rowItemCount" value="${rowItemCount+1}"/>

									<%out.flush();%>
									<c:import url="${jspStoreDir}Snippets/Search/CatalogEntryThumbnailDisplay.jsp">
						  	 			<c:param name="catEntryName" value="${catalogIdEntry.name}"/>
						  	 			<c:param name="thumbnail" value="${catalogIdEntry.thumbnail}"/>
						  	 			<c:param name="shortDescription" value="${catalogIdEntry.shortDescription}"/>
						  	 			<c:param name="catalogEntryTypeCode" value="${catalogIdEntry.catalogEntryTypeCode}"/>
						  	 			<c:param name="singleSKU" value="${singleSKU}"/>
						  	 			<c:param name="buyable" value="${catalogIdEntry.buyable}"/>
						  	 			<c:param name="priceString" value="${priceString}"/>
						  	 			<c:param name="strikedPriceString" value="${strikedPriceString}"/>
						  	 			<c:param name="minimumPriceString" value="${minimumPriceString}"/>
						  	 			<c:param name="maximumPriceString" value="${maximumPriceString}"/>
						  	 			<c:param name="contentAreaESpot" value="${contentAreaESpot}"/>
										<c:param name="prefix" value="${prefix}"/>  
										<c:param name="langId" value="${langId}" />						
										<c:param name="storeId" value="${WCParam.storeId}" />
										<c:param name="catalogId" value="${WCParam.catalogId}" />
										<c:param name="emsName" value="${emsName}" />
										<c:param name="skipAttachments" value="${param.skipAttachments}"/>
										<c:param name="pageView" value="${pageView}"/>
										<c:param name="catEntryIdentifier" value="${catEntryIdentifier}"/>
										<c:param name="useClickInfoURL" value="${useClickInfoURL}"/>
										<c:param name="categoryId" value="${categoryId}"/>
										<c:param name="top_category" value="${WCParam.top_category}"/>
										<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
									   	<c:param name="absoluteUrl" value="${absoluteUrl}"/>
									   	<c:param name="clickInfoCommand" value="${clickInfoCommand}"/>
									   	<c:param name="isDKPreConfigured" value="${catalogIdEntry.dynamicKitDefaultConfigurationComplete}"/>
									   	<c:param name="isDKConfigurable" value="${!empty catalogIdEntry.dynamicKitModelReference}"/>
									</c:import>
									<%out.flush();%>
								</div>
							</td>
						
							<c:if test="${rowItemCount%numberProductsPerRow==0}">
								</tr>
								<c:set var="rowItemCount" value="0"/>
								<c:set var="rowBeginIndex" value="${status.index+1}"/>
							</c:if> 
						</c:when>
						<c:otherwise>
							<%out.flush();%>
							<c:import url="${jspStoreDir}Snippets/Search/CatalogEntryThumbnailDisplay.jsp">
				  	 			<c:param name="catEntryName" value="${catalogIdEntry.name}"/>
				  	 			<c:param name="thumbnail" value="${catalogIdEntry.thumbnail}"/>
				  	 			<c:param name="shortDescription" value="${catalogIdEntry.shortDescription}"/>
				  	 			<c:param name="catalogEntryTypeCode" value="${catalogIdEntry.catalogEntryTypeCode}"/>
				  	 			<c:param name="singleSKU" value="${singleSKU}"/>
				  	 			<c:param name="buyable" value="${catalogIdEntry.buyable}"/>
				  	 			<c:param name="priceString" value="${priceString}"/>
				  	 			<c:param name="strikedPriceString" value="${strikedPriceString}"/>
				  	 			<c:param name="minimumPriceString" value="${minimumPriceString}"/>
				  	 			<c:param name="maximumPriceString" value="${maximumPriceString}"/>
				  	 			<c:param name="contentAreaESpot" value="${contentAreaESpot}"/>
								<c:param name="prefix" value="${prefix}"/>  
								<c:param name="langId" value="${langId}" />						
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${WCParam.catalogId}" />
								<c:param name="emsName" value="${emsName}" />
								<c:param name="skipAttachments" value="${param.skipAttachments}"/>
								<c:param name="pageView" value="detailedMyAccount"/>
								<c:param name="catEntryIdentifier" value="${catEntryIdentifier}"/>
								<c:param name="useClickInfoURL" value="${useClickInfoURL}"/>
								<c:param name="categoryId" value="${categoryId}"/>
								<c:param name="top_category" value="${WCParam.top_category}"/>
								<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
							   	<c:param name="absoluteUrl" value="${absoluteUrl}"/>
							   	<c:param name="clickInfoCommand" value="${clickInfoCommand}"/>
							   	<c:param name="isDKPreConfigured" value="${catalogIdEntry.dynamicKitDefaultConfigurationComplete}"/>
							   	<c:param name="isDKConfigurable" value="${!empty catalogIdEntry.dynamicKitModelReference}"/>
							</c:import>
							<%out.flush();%>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>
			
			<c:if test="${rowItemCount != 0}">
				</tr>
			</c:if>
			<tr class="item_container">
				<td class="divider_line" colspan="4" id="WC_CategoryOnlyResultsDisplay_td_1a"></td>
			</tr>
		</table>
		<br />
		<br />
		 
		<span class="display_text">
			<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<fmt:param><fmt:formatNumber value="${recordStart+ 1}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${recordEnd}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${totalCount}"/></fmt:param>
			</fmt:message>
			<c:if test="${totalPages > 1}">
				<span class="paging">
					<c:if test="${recordStart != 0}">
						<a id="WC_CategoryOnlyResultsDisplay_links_5" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_5'); 
						wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex'] = '<c:out value='${beginIndex - pageSize}'/>';
						categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewPrevURL}'/>');">
					</c:if>
						<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
					<c:if test="${recordStart != 0}">
						</a>
					</c:if>
					<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
						<fmt:param><fmt:formatNumber value="${currentPage+1}"/></fmt:param>
						<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
					</fmt:message>
					<c:if test="${!completeIndicator}">					
						<a id="WC_CategoryOnlyResultsDisplay_links_6" href="javaScript:setCurrentId('WC_CategoryOnlyResultsDisplay_links_6'); 
						wc.render.getContextById('CategoryDisplay_Context').properties['beginIndex'] = '<c:out value='${beginIndex + pageSize}'/>';
						categoryDisplayJS.loadContentURL('<c:out value='${CategoryDisplayViewNextURL}'/>');">
					</c:if>
						<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
					<c:if test="${!completeIndicator}">
						</a>
					</c:if>
				</span>
			</c:if>
		 </span>
	</div>
	<div class="footer" id="WC_CategoryOnlyResultsDisplay_div_7">
		 <div class="left_corner" id="WC_CategoryOnlyResultsDisplay_div_8"></div>
		 <div class="right" id="WC_CategoryOnlyResultsDisplay_div_9"></div>
		 <div class="right_corner" id="WC_CategoryOnlyResultsDisplay_div_10"></div>
	</div>
</c:if>

<!-- END SearchBasedNavigationCategoryResultsDisplay.jsp -->
