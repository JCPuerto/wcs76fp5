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
  * This JSP file renders the search results depending on the shopper's search criteria.
  *****
--%>
<!-- BEGIN SearchBasedNavigationResultDisplay.jsp -->


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<%@ include file="../../../Snippets/Search/SearchSetup.jspf" %>

<script type="text/javascript" language="JavaScript">
function ToggleTraceDisplay(fieldName) {
	if (fieldName.length < 1) { return; }
	if (document.getElementById(fieldName).style.display == "none") { 
		document.getElementById(fieldName).style.display = "block";
	} else {
		document.getElementById(fieldName).style.display = "none";
	}
}
</script>

<wcf:url value="AjaxCatalogSearchResultView" var="SearchDisplayImageViewURL" type="Ajax">
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="categoryId" value="${WCParam.categoryId}"/>			
	<wcf:param name="pageView" value="image"/>
	<wcf:param name="beginIndex" value="${WCParam.beginIndex}"/>
	<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
	<wcf:param name="searchTerm" value="${searchTerm}" />
	<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
	<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
	<wcf:param name="minPrice" value="${WCParam.minPrice}" />
	<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
	<wcf:param name="searchType" value="${searchType}"/>
	<wcf:param name="sType" value="${WCParam.sType}"/>						
	<wcf:param name="metaData" value="${metaData}"/>
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
	<wcf:param name="showResultsPage" value="true"/>
	<wcf:param name="orderBy" value="${WCParam.orderBy}"/>
	<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
</wcf:url>

<wcf:url value="AjaxCatalogSearchResultView" var="SearchDisplayFullViewURL" type="Ajax">
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="categoryId" value="${WCParam.categoryId}"/>			
	<wcf:param name="pageView" value="detailed"/>
	<wcf:param name="beginIndex" value="${WCParam.beginIndex}"/>
	<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
	<wcf:param name="searchTerm" value="${searchTerm}" />
	<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
	<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
	<wcf:param name="minPrice" value="${WCParam.minPrice}" />
	<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
	<wcf:param name="searchType" value="${searchType}"/>
	<wcf:param name="sType" value="${WCParam.sType}"/>						
	<wcf:param name="metaData" value="${metaData}"/>
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
	<wcf:param name="showResultsPage" value="true"/>
	<wcf:param name="orderBy" value="${WCParam.orderBy}"/>
	<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
</wcf:url>

<%-- 
  ***
  * Start - use catEntSearchListBean1 to check for minPriceError or maxPriceError
  ***
--%>
<c:if test="${!empty WCParam.sType}">	
	<wcbase:useBean id="catEntSearchListBean1" classname="com.ibm.commerce.search.beans.CatEntrySearchListDataBean"/>
	<jsp:setProperty property="*" name="catEntSearchListBean1" />
	<%-- Pass the minimum price entered by the user to catEntSearchListBean as a search criteria --%>
	<c:set property="minPrice" value="${WCParam.minPrice}" target="${catEntSearchListBean1}"/>
	<%-- Make sure any error triggered by the minimum price is flagged --%>
	<c:if test="${catEntSearchListBean1.minPriceError}">
		<c:set var="errorMinPriceFlag" value="true"/>
	</c:if>
	<%-- Pass the maximum price entered by the user to catEntSearchListBean as a search criteria --%>
	<c:set property="maxPrice" value="${WCParam.maxPrice}" target="${catEntSearchListBean1}"/>
	<%-- Make sure any error triggered by the maximum price is flagged --%>
	<c:if test="${catEntSearchListBean1.maxPriceError}">
		<c:set var="errorMaxPriceFlag" value="true"/>
	</c:if>
	<%-- 
	  ***
	  * End - use catEntSearchListBean1 to check for minPriceError or maxPriceError
	  ***
	--%>

	<%-- Examine if the maximum/minimum price input by a customer is valid --%>
	
	<%-- Activate bean only if there is no error in the min and max prices entered --%>
	<c:if test="${errorMinPriceFlag || errorMaxPriceFlag}">
		<div class="text" id="Search_Result_Summary_div" style="display:none">

		<%-- Show error messages since maximum/minimum price input by a customer is invalid --%>
		<span class="strong">
			<br/><fmt:message key="SEARCH_NO_RESULTS" bundle="${storeText}"/>
		</span>
		
		<span class="strong"><br/><fmt:message key="SEARCH_ERRORS" bundle="${storeText}"/></span>
		<ul>
			<c:if test="${errorMinPriceFlag == true}">
				<li><span class="error"><c:out value="${WCParam.minPrice}"/></span>&nbsp;<fmt:message key="SEARCH_INVALID_LOW_PRICE" bundle="${storeText}"/></li>
			</c:if>
	
			<c:if test="${errorMaxPriceFlag==true}">
				<li><span class="error"><c:out value="${WCParam.maxPrice}"/></span>&nbsp;<fmt:message key="SEARCH_INVALID_HIGH_PRICE" bundle="${storeText}"/></li>
			</c:if>
		</ul>
		<br/>
			<fmt:message key="SEARCH_REFINE_SEARCH" bundle="${storeText}">
				<fmt:param><span class="strong"><a href="javascript:CatalogSearchDisplayJS.showHideSearchMode(true)" id="WC_CatalogSearchResultDisplay_link_2"><fmt:message key="SEARCH_LINK" bundle="${storeText}"/></a></span></fmt:param>
			</fmt:message>
		</div>
	</c:if>		

	<c:if test="${!errorMinPriceFlag && !errorMaxPriceFlag}">

		<c:if test="${totalCount!=0}">
				<c:set var="advancedSearchResult" value="true"/>
		</c:if>
		<c:choose>
			<%-- Check if a user specifies where the page should start displaying the result. 
			     For example, if the index is 5, then the first item displayed will be the 
			     6th element(The index starts from 0). The beginIndex will be set when a 
			     user chooses a different search result page.
			--%>				     
			<c:when test="${!empty WCParam.beginIndex}">
				<c:set var="beginIndex" value="${WCParam.beginIndex}"/>
			</c:when>

			<%-- The default begin index is 0. When the search result page is returned for
			     the first time, the page will display the items from the very beginning.
			--%>
			<c:otherwise>
				<c:set var="beginIndex" value="0"/>
			</c:otherwise>
		</c:choose>

		<%-- Now choose how many items should be displayed in a page --%>
		<c:choose>
		    <%-- Use the user-specified number of items per page, if any --%> 
			<c:when test="${!empty WCParam.pageSize}">
				<c:set var="pageSize" value="${WCParam.pageSize}"/>
			</c:when>
			
			<%-- If the user doesn't specify the number of items per page, use 
			     the default on. 
			--%>
			<c:otherwise>
				<c:set var="pageSize" value="12"/>
			</c:otherwise>
		</c:choose>
	</c:if>
</c:if>

                            
<c:if test="${!empty WCParam.sType && advancedSearchResult==true}">

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
		<wcf:url var="SearchDisplayViewPrevURL" value="AjaxCatalogSearchResultView" type="Ajax">
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="storeId" value="${WCParam.storeId}"/>
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="categoryId" value="${WCParam.categoryId}"/>		
			<wcf:param name="pageView" value="${pageView}"/>
			<wcf:param name="beginIndex" value="${prevPageIndex}"/>
			<wcf:param name="pageSize" value="${pageSize}"/>
			<wcf:param name="searchTerm" value="${searchTerm}" />
			<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
			<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
			<wcf:param name="minPrice" value="${WCParam.minPrice}" />
			<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
			<wcf:param name="searchType" value="${searchType}"/>
			<wcf:param name="sType" value="${WCParam.sType}"/>						
			<wcf:param name="metaData" value="${metaData}"/>
			<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
			<wcf:param name="showResultsPage" value="true"/>
			<wcf:param name="orderBy" value="${WCParam.orderBy}"/>
			<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
		</wcf:url>	
	</c:if>

	<c:if test="${nextPageExists}">
		<wcf:url var="SearchDisplayViewNextURL" value="AjaxCatalogSearchResultView" type="Ajax">
			<wcf:param name="langId" value="${langId}"/>
			<wcf:param name="storeId" value="${WCParam.storeId}"/>
			<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
			<wcf:param name="categoryId" value="${WCParam.categoryId}"/>			
			<wcf:param name="pageView" value="${pageView}"/>
			<wcf:param name="beginIndex" value="${nextPageIndex}"/>
			<wcf:param name="pageSize" value="${pageSize}"/>
			<wcf:param name="searchTerm" value="${searchTerm}" />
			<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
			<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
			<wcf:param name="minPrice" value="${WCParam.minPrice}" />
			<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
			<wcf:param name="searchType" value="${searchType}"/>
			<wcf:param name="sType" value="${WCParam.sType}"/>						
			<wcf:param name="metaData" value="${metaData}"/>
			<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
			<wcf:param name="showResultsPage" value="true"/>
			<wcf:param name="orderBy" value="${WCParam.orderBy}"/>
			<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
		</wcf:url>
	</c:if>


</c:if>

<c:if test="${advancedSearchResult==true}">
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
						<a href="javaScript:;" onclick="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_3');wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${prevPageIndex}'/>';CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewPrevURL}'/>', 'catalogSearchResultDisplay_Controller', 'catalogSearchResultDisplay_Context');" id="WC_CatalogSearchResultDisplay_link_3">
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
						<a  href="javaScript:;" onclick="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_4');wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${nextPageIndex}'/>';CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewNextURL}'/>', 'catalogSearchResultDisplay_Controller', 'catalogSearchResultDisplay_Context');" id="WC_CatalogSearchResultDisplay_link_4">
					</c:if>
					<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
					<c:if test="${!completeIndicator}">
						</a>
					</c:if>
				</span>
			</c:if>
		</div>	
	</div>

	<div class="body588" id="WC_CatalogSearchResultDisplay_div_4_1">
		<div class="sorting_controls right" id="WC_CatalogSearchResultDisplay_div_4_2">
			 <label for="orderBy"><fmt:message key="FF_SORT_BY" bundle="${storeText}"/></label>
			 <select id="orderBy" name="orderBy" class="fastFinderSortDropDown" onchange="document.location = this.value;">
		 		<wcf:url var="SearchDisplayNoSortURL" value="SearchDisplay" type="Ajax">
					<wcf:param name="langId" value="${langId}"/>
					<wcf:param name="storeId" value="${WCParam.storeId}"/>
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="categoryId" value="${WCParam.categoryId}"/>			
					<wcf:param name="pageView" value="${pageView}"/>
					<wcf:param name="beginIndex" value="0"/>
					<wcf:param name="pageSize" value="${pageSize}"/>
					<wcf:param name="searchTerm" value="${searchTerm}" />
					<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
					<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
					<wcf:param name="minPrice" value="${WCParam.minPrice}" />
					<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
					<wcf:param name="searchType" value="${searchType}"/>
					<wcf:param name="sType" value="${WCParam.sType}"/>						
					<wcf:param name="metaData" value="${metaData}"/>
					<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
					<wcf:param name="showResultsPage" value="true"/>
					<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
				</wcf:url>
		 		<option value="${SearchDisplayNoSortURL}"><fmt:message key="SEARCH_NO_SORT" bundle="${storeText}"/></option>
				<wcf:url var="SearchDisplaySortURL1" value="SearchDisplay" type="Ajax">
					<wcf:param name="langId" value="${langId}"/>
					<wcf:param name="storeId" value="${WCParam.storeId}"/>
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="categoryId" value="${WCParam.categoryId}"/>			
					<wcf:param name="pageView" value="${pageView}"/>
					<wcf:param name="beginIndex" value="0"/>
					<wcf:param name="orderBy" value="1"/>
					<wcf:param name="pageSize" value="${pageSize}"/>
					<wcf:param name="searchTerm" value="${searchTerm}" />
					<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
					<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
					<wcf:param name="minPrice" value="${WCParam.minPrice}" />
					<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
					<wcf:param name="searchType" value="${searchType}"/>
					<wcf:param name="sType" value="${WCParam.sType}"/>						
					<wcf:param name="metaData" value="${metaData}"/>
					<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
					<wcf:param name="showResultsPage" value="true"/>
					<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
				</wcf:url>
		 		<c:choose>
		 			<c:when test="${WCParam.orderBy eq '1'}">
		 				<option value="${SearchDisplaySortURL1}" selected="selected"><fmt:message key="FF_SORT_BY_BRANDS" bundle="${storeText}"/></option>
		 			</c:when>
		 			<c:otherwise>
		 				<option value="${SearchDisplaySortURL1}"><fmt:message key="FF_SORT_BY_BRANDS" bundle="${storeText}"/></option>
		 			</c:otherwise>
		 		</c:choose>
				<wcf:url var="SearchDisplaySortURL2" value="SearchDisplay" type="Ajax">
					<wcf:param name="langId" value="${langId}"/>
					<wcf:param name="storeId" value="${WCParam.storeId}"/>
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="categoryId" value="${WCParam.categoryId}"/>			
					<wcf:param name="pageView" value="${pageView}"/>
					<wcf:param name="beginIndex" value="0"/>
					<wcf:param name="orderBy" value="2"/>
					<wcf:param name="pageSize" value="${pageSize}"/>
					<wcf:param name="searchTerm" value="${searchTerm}" />
					<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
					<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
					<wcf:param name="minPrice" value="${WCParam.minPrice}" />
					<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
					<wcf:param name="searchType" value="${searchType}"/>
					<wcf:param name="sType" value="${WCParam.sType}"/>						
					<wcf:param name="metaData" value="${metaData}"/>
					<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
					<wcf:param name="showResultsPage" value="true"/>
					<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
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
					<wcf:url var="SearchDisplaySortURL3" value="SearchDisplay" type="Ajax">
						<wcf:param name="langId" value="${langId}"/>
						<wcf:param name="storeId" value="${WCParam.storeId}"/>
						<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
						<wcf:param name="categoryId" value="${WCParam.categoryId}"/>
						<wcf:param name="pageView" value="${pageView}"/>
						<wcf:param name="beginIndex" value="0"/>
						<wcf:param name="orderBy" value="3"/>
						<wcf:param name="pageSize" value="${pageSize}"/>
						<wcf:param name="searchTerm" value="${searchTerm}" />
						<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
						<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
						<wcf:param name="minPrice" value="${WCParam.minPrice}" />
						<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
						<wcf:param name="searchType" value="${searchType}"/>
						<wcf:param name="sType" value="${WCParam.sType}"/>						
						<wcf:param name="metaData" value="${metaData}"/>
						<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
						<wcf:param name="showResultsPage" value="true"/>
						<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
					</wcf:url>
			 		<c:choose>
			 			<c:when test="${WCParam.orderBy eq '3'}">
			 				<option value="${SearchDisplaySortURL3}" selected="selected"><fmt:message key="SEARCH_SORT_LOW_TO_HIGH" bundle="${storeText}"/></option>
		 				</c:when>
		 				<c:otherwise>
							<option value="${SearchDisplaySortURL3}"><fmt:message key="SEARCH_SORT_LOW_TO_HIGH" bundle="${storeText}"/></option>
		 				</c:otherwise>
		 			</c:choose>
					<wcf:url var="SearchDisplaySortURL4" value="SearchDisplay" type="Ajax">
						<wcf:param name="langId" value="${langId}"/>
						<wcf:param name="storeId" value="${WCParam.storeId}"/>
						<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
						<wcf:param name="categoryId" value="${WCParam.categoryId}"/>			
						<wcf:param name="pageView" value="${pageView}"/>
						<wcf:param name="beginIndex" value="0"/>
						<wcf:param name="orderBy" value="4"/>
						<wcf:param name="pageSize" value="${pageSize}"/>
						<wcf:param name="searchTerm" value="${searchTerm}" />
						<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
						<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
						<wcf:param name="minPrice" value="${WCParam.minPrice}" />
						<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
						<wcf:param name="searchType" value="${searchType}"/>
						<wcf:param name="sType" value="${WCParam.sType}"/>						
						<wcf:param name="metaData" value="${metaData}"/>
						<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
						<wcf:param name="showResultsPage" value="true"/>
						<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
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
							<a href="javaScript:;" onclick="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_6');wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsView']='detailed';CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayFullViewURL}'/>', 'catalogSearchResultDisplay_Controller', 'catalogSearchResultDisplay_Context');" id="WC_CatalogSearchResultDisplay_link_6">
								<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />list_normal.png" alt="<fmt:message key="CATEGORY_DETAILED_VIEW" bundle="${storeText}"/>" />
							</a>
						</c:when>
						<c:otherwise>
							<c:set var="gridView" value="horizontal_grid"/>
							<a href="javaScript:;" onclick="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_5'); wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsView']='image';CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayImageViewURL}'/>', 'catalogSearchResultDisplay_Controller', 'catalogSearchResultDisplay_Context');" id="WC_CatalogSearchResultDisplay_link_5">
								<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />grid_normal.png" alt="<fmt:message key="CATEGORY_IMAGE_VIEW" bundle="${storeText}"/>" />
							</a>
							<img id="detailedTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}list_selected.png"/>" alt="<fmt:message key="FF_VIEWDETAILS" bundle="${storeText}"/>"/>
						</c:otherwise>	
					</c:choose>
				</span>
			</span> 
		</div>

		<c:if test="${not empty globalreport}">
			<div class="display_text" style="max-width:420px">
				<img src="<c:out value="${jspStoreImgDir}" />images/tip_box_icon.gif" alt="<c:out value="${globalreport.indexStatus}" escapeXml="false" />"/>
				<c:out value="${globalreport.indexStatus}" escapeXml="false" />
			</div>
		</c:if>
	</div>

	<div class="body588" id="WC_CatalogSearchResultDisplay_div_5">
		<table id="${gridView}" cellpadding="0" cellspacing="0" border="0">
			<c:set var="searchParentCategoryId" value="" scope="request"/>
			<c:set var="searchTopCategoryId" value="" scope="request" />

			<c:forEach var="breadcrumb" items="${globalbreadcrumbs.breadCrumbTrailEntryView}">
				<c:if test="${breadcrumb.type_ == 'FACET_ENTRY_CATEGORY'}">
					<c:if test="${empty searchTopCategoryId}">
						<c:set var="searchTopCategoryId" value="${breadcrumb.value}" scope="request"/>
					</c:if>
					<c:set var="searchParentCategoryId" value="${breadcrumb.value}" scope="request"/>
				</c:if>
			</c:forEach>
			
			<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType[]" var="skus" expressionBuilder="getStoreCatalogEntryAttributesByIDs">
				<wcf:contextData name="storeId" data="${param.storeId}"/>
				<c:forEach var="catEntry" items="${globalresults}" varStatus="status">
					<wcf:param name="UniqueID" value="${catEntry.uniqueID}"/>
				</c:forEach>
				<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
			</wcf:getData>						
			
			<c:set var="currentItemCount" value="${recordStart}" />
			<c:set var="rowItemCount" value="0"/>
			<c:set var="rowBeginIndex" value="0"/>
			<c:forEach var="catEntry" items="${globalresults}" varStatus="status">				
				<c:set var="currentItemCount" value="${currentItemCount + 1}" />
				<c:if test="${(recordStart <= currentItemCount) && (recordEnd >= currentItemCount)}">
					<c:if test="${rowItemCount == 0}">
						<tr class="item_container">
							<td class="divider_line" colspan="4" id="WC_CatalogSearchResultDisplay_td_1_<c:out value='${status.count}'/>"></td>
						</tr>
						<tr class="item_container">
					</c:if>
					<c:set var="catEntryIdentifier" value="${catEntry.uniqueID}"/>
					
					<c:forEach var="sku" items="${skus}" varStatus="status1">
						<c:if test="${sku.catalogEntryIdentifier.uniqueID eq catEntryIdentifier}">
							<c:set var="attributes" value="${sku.catalogEntryAttributes.attributes}"/>
						</c:if>
					</c:forEach>
					
					<c:choose>
						<c:when test="${pageView == 'image'}">
							<td class="item" id="WC_CatalogSearchResultDisplay_td_2_${status.count}">
								<div <c:if test="${rowItemCount==0}">class="catEntryThumbnail"</c:if> id="WC_CatalogSearchResultDisplay_div_6_<c:out value='${status.count}'/>" <c:if test="${rowItemCount!=0}"> class="container" </c:if>>
									<c:set var="rowItemCount" value="${rowItemCount+1}"/>
									<c:set var="prefix" value="search"/>
									<c:if test="${!empty WCParam.categoryId}">
										<c:set var="prefix" value="category"/>
									</c:if>
									<%@ include file="../../../Snippets/ReusableObjects/CatalogEntrySearchThumbnailDisplay.jspf" %>
								</div>
							</td>
							<c:if test="${rowItemCount%numberProductsPerRow==0}">
								</tr>
								<c:set var="rowItemCount" value="0"/>
								<c:set var="rowBeginIndex" value="${status.index+1}"/>
							</c:if> 
						</c:when>
						<c:otherwise>
							<%@ include file="../../../Snippets/ReusableObjects/CatalogEntrySearchThumbnailDisplay.jspf" %>
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forEach>
			<c:if test="${rowItemCount != 0 && pageView !='detailed'}">
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
						<a href="javaScript:;" onclick="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_7'); wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${prevPageIndex}'/>';CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewPrevURL}'/>', 'catalogSearchResultDisplay_Controller', 'catalogSearchResultDisplay_Context');" id="WC_CatalogSearchResultDisplay_link_7">
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
						<a href="javaScript:;" onclick="javaScript:setCurrentId('WC_CatalogSearchResultDisplay_link_8');wc.render.getContextById('catalogSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${nextPageIndex}'/>';CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewNextURL}'/>', 'catalogSearchResultDisplay_Controller', 'catalogSearchResultDisplay_Context');" id="WC_CatalogSearchResultDisplay_link_8">
					</c:if>
					<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
					<c:if test="${!completeIndicator}">
						</a>
					</c:if>
				</span>
			</c:if>
		</span>
	</div>
	<div class="footer" id="WC_CatalogSearchResultDisplay_div_7">
		 <div class="left_corner" id="WC_CatalogSearchResultDisplay_div_8"></div>
		 <div class="right" id="WC_CatalogSearchResultDisplay_div_9"></div>
		 <div class="right_corner" id="WC_CatalogSearchResultDisplay_div_10"></div>
	</div>

	<%@ include file="../../../Snippets/Catalog/CategoryDisplay/CategoryDisplayExt.jspf"%>
	<br clear="all" />
	
	<flow:ifEnabled feature="Analytics">
		<c:set var="singleQuote" value="'"/>
		<c:set var="escapedSingleQuote" value="\\\\'"/>
		<c:set var="doubleQuote" value="\""/>
		<c:set var="escapedDoubleQuote" value="\\\\\""/>

		<c:remove var="analyticsEscapedFacetAttributes"/>
		<c:set var="analyticsEscapedFacetAttributes" value="${fn:replace(analyticsFacetAttributes, singleQuote, escapedSingleQuote)}"/>
		<c:set var="analyticsEscapedFacetAttributes" value="${fn:replace(analyticsEscapedFacetAttributes, doubleQuote, escapedDoubleQuote)}"/>

		<c:remove var="analyticsEscapedSearchTerm"/>
		<c:set var="analyticsEscapedSearchTerm" value="${fn:replace(searchTerm, singleQuote, escapedSingleQuote)}"/>
		<c:set var="analyticsEscapedSearchTerm" value="${fn:replace(analyticsEscapedSearchTerm, doubleQuote, escapedDoubleQuote)}"/>

		<div id="catalog_search_result_information" style="visibility:hidden">
			{	searchResult: {
				pageSize: <c:out value="${pageSize}"/>, 
				searchTerms: '<c:out value="${analyticsEscapedSearchTerm}"/>', 
			 	totalPageNumber: <c:out value="${totalPages}"/>, 
			  	totalResultCount: <c:out value="${totalCount}" />, 
			  	currentPageNumber: <c:out value="${currentPage}" />,
				attributes: "<c:out value="${analyticsEscapedFacetAttributes}"/>"
				}
			}
	</div>
	</flow:ifEnabled>
</c:if>

<!-- END SearchBasedNavigationResultDisplay.jsp -->
