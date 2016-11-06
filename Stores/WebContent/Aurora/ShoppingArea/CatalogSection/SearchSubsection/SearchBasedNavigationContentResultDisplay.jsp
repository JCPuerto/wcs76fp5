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
  * This JSP file renders the search results depending on the shopper's search criteria.
  *****
--%>
<!-- BEGIN SearchBasedNavigationContentResultDisplay.jsp -->


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:if test="${empty totalContentCount}">
	<%@ include file="../../../Snippets/Search/SearchContentSetup.jspf" %>
</c:if>

<wcf:url value="AjaxSearchContentResultView" var="SearchDisplayImageViewURL" type="Ajax">
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="pageView" value="image"/>
	<wcf:param name="beginIndex" value="${WCParam.beginIndex}"/>
	<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
	<wcf:param name="searchTerm" value="${contentSearchTerm}" />
	<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
	<wcf:param name="searchType" value="${searchType}"/>
	<wcf:param name="sType" value="${WCParam.sType}"/>						
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
	<wcf:param name="showResultsPage" value="true"/>
	<wcf:param name="orderByContent" value="${WCParam.orderByContent}"/>
	<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
</wcf:url>

<wcf:url value="AjaxSearchContentResultView" var="SearchDisplayFullViewURL" type="Ajax">
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="storeId" value="${WCParam.storeId}"/>
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="pageView" value="detailed"/>
	<wcf:param name="beginIndex" value="${WCParam.beginIndex}"/>
	<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
	<wcf:param name="searchTerm" value="${contentSearchTerm}" />
	<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
	<wcf:param name="searchType" value="${searchType}"/>
	<wcf:param name="sType" value="${WCParam.sType}"/>						
	<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
	<wcf:param name="showResultsPage" value="true"/>
	<wcf:param name="orderByContent" value="${WCParam.orderByContent}"/>
	<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
</wcf:url>


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

<fmt:formatNumber var="totalContentPages" type="number" groupingUsed="false" value="${totalContentCount / pageSize}" maxFractionDigits="0" />
<c:if test="${totalContentCount - (totalContentPages * pageSize) > 0}" >
	<c:set var="totalContentPages" value="${totalContentPages + 1}" />
</c:if>

<fmt:formatNumber var="currentPage" type="number" groupingUsed="false" value="${beginIndex / pageSize}" maxFractionDigits="0" />
<c:set var="resultCountOnPage" value="${pageSize + beginIndex}"/>
<c:choose>
	<c:when test="${resultCountOnPage > totalContentCount}">
		<c:set var="resultCountOnPage" value="${totalContentCount}"/>
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
	<c:when test="${nextPageIndex >= totalContentCount}">
		<c:set var="nextPageIndex" value="${beginIndex}"/>
		<c:set var="nextPageExists" value="false"/>
	</c:when>
	<c:otherwise>
		<c:set var="nextPageExists" value="true"/>
	</c:otherwise>
</c:choose>
<c:set var="completeIndicator" value="${!nextPageExists}"/>
<c:if test="${previousPageExists}">
	<wcf:url var="SearchDisplayViewPrevURL" value="AjaxSearchContentResultView" type="Ajax">
		<wcf:param name="langId" value="${langId}"/>
		<wcf:param name="storeId" value="${WCParam.storeId}"/>
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="pageView" value="${pageView}"/>
		<wcf:param name="beginIndex" value="${prevPageIndex}"/>
		<wcf:param name="pageSize" value="${pageSize}"/>
		<wcf:param name="searchTerm" value="${contentSearchTerm}" />
		<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
		<wcf:param name="searchType" value="${searchType}"/>
		<wcf:param name="sType" value="${WCParam.sType}"/>						
		<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
		<wcf:param name="showResultsPage" value="true"/>
		<wcf:param name="orderByContent" value="${WCParam.orderByContent}"/>
		<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
	</wcf:url>	
</c:if>

<c:if test="${nextPageExists}">
	<wcf:url var="SearchDisplayViewNextURL" value="AjaxSearchContentResultView" type="Ajax">
		<wcf:param name="langId" value="${langId}"/>
		<wcf:param name="storeId" value="${WCParam.storeId}"/>
		<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
		<wcf:param name="pageView" value="${pageView}"/>
		<wcf:param name="beginIndex" value="${nextPageIndex}"/>
		<wcf:param name="pageSize" value="${pageSize}"/>
		<wcf:param name="searchTerm" value="${contentSearchTerm}" />
		<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
		<wcf:param name="searchType" value="${searchType}"/>
		<wcf:param name="sType" value="${WCParam.sType}"/>						
		<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
		<wcf:param name="showResultsPage" value="true"/>
		<wcf:param name="orderByContent" value="${WCParam.orderByContent}"/>
		<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
	</wcf:url>
</c:if>

<div class="contentgrad_header" id="WC_SearchContentResultDisplay_div_1">
	<div class="left_corner" id="WC_SearchContentResultDisplay_div_2"></div>
	<div class="left" id="WC_SearchContentResultDisplay_div_3"></div>
	<div class="right_corner" id="WC_SearchContentResultDisplay_div_4"></div>
	<div class="headertext"><fmt:message key="ARTICLES_AND_VIDEOS" bundle="${storeText}"/>: <c:out value="${totalContentCount}"/></div>
	<div class="text">
		<fmt:message key="CONTENT_RESULTS_DISPLAYING" bundle="${storeText}"> 
			<fmt:param><fmt:formatNumber value="${recordStart+1}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${recordEnd}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${totalContentCount}"/></fmt:param>
		</fmt:message>
		<c:if test="${totalContentPages > 1}">
			<span class="paging">
				<c:if test="${recordStart != 0}">
					<a href="javaScript:;" onclick="javaScript:setCurrentId('WC_SearchContentResultDisplay_link_23');wc.render.getContextById('contentSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${prevPageIndex}'/>';CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewPrevURL}'/>', 'contentSearchResultDisplay_Controller', 'contentSearchResultDisplay_Context');" id="WC_SearchContentResultDisplay_link_23">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${recordStart != 0}">
					</a>
				</c:if>

				<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage+1}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalContentPages}"/></fmt:param>
				</fmt:message>

				<c:if test="${!completeIndicator}">
					<a  href="javaScript:;" onclick="javaScript:setCurrentId('WC_SearchContentResultDisplay_link_24');wc.render.getContextById('contentSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${nextPageIndex}'/>';CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewNextURL}'/>', 'contentSearchResultDisplay_Controller', 'contentSearchResultDisplay_Context');" id="WC_SearchContentResultDisplay_link_24">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${!completeIndicator}">
					</a>
				</c:if>
			</span>
		</c:if>
	</div>
	<c:if test="${not empty contentreport}">
		<div class="display_text" style="max-width:420px">
			<img src="<c:out value="${jspStoreImgDir}" />images/tip_box_icon.gif" alt="<c:out value="${contentreport.indexStatus}" escapeXml="false" />"/>
			<c:out value="${contentreport.indexStatus}" escapeXml="false" />
		</div>
	</c:if>
</div>

<div class="body588" id="WC_SearchContentResultDisplay_div_4_1">
	<div class="sorting_controls right" id="WC_SearchContentResultDisplay_div_4_2">
		 <label for="orderByContent"><fmt:message key="FF_SORT_BY" bundle="${storeText}"/></label>
		 <select id="orderByContent" name="orderByContent" class="fastFinderSortDropDown" onchange="document.location = this.value;">
		 		<wcf:url var="SearchDisplayNoSortURL" value="SearchDisplay" type="Ajax">
					<wcf:param name="langId" value="${langId}"/>
					<wcf:param name="storeId" value="${WCParam.storeId}"/>
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="pageView" value="${pageView}"/>
					<wcf:param name="beginIndex" value="0"/>
					<wcf:param name="pageSize" value="${pageSize}"/>
					<wcf:param name="searchTerm" value="${contentSearchTerm}" />
					<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
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
					<wcf:param name="pageView" value="${pageView}"/>
					<wcf:param name="beginIndex" value="0"/>
					<wcf:param name="orderByContent" value="1"/>
					<wcf:param name="pageSize" value="${pageSize}"/>
					<wcf:param name="searchTerm" value="${contentSearchTerm}" />
					<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
					<wcf:param name="searchType" value="${searchType}"/>
					<wcf:param name="sType" value="${WCParam.sType}"/>						
					<wcf:param name="metaData" value="${metaData}"/>
					<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
					<wcf:param name="showResultsPage" value="true"/>
					<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
				</wcf:url>
		 		<c:choose>
		 			<c:when test="${WCParam.orderByContent eq '1'}">
		 				<option value="${SearchDisplaySortURL1}" selected="selected"><fmt:message key="SEARCH_SORT_BY_NAME" bundle="${storeText}"/></option>
		 			</c:when>
		 			<c:otherwise>
		 				<option value="${SearchDisplaySortURL1}"><fmt:message key="SEARCH_SORT_BY_NAME" bundle="${storeText}"/></option>
		 			</c:otherwise>
		 		</c:choose>
				<wcf:url var="SearchDisplaySortURL2" value="SearchDisplay" type="Ajax">
					<wcf:param name="langId" value="${langId}"/>
					<wcf:param name="storeId" value="${WCParam.storeId}"/>
					<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
					<wcf:param name="pageView" value="${pageView}"/>
					<wcf:param name="beginIndex" value="0"/>
					<wcf:param name="orderByContent" value="2"/>
					<wcf:param name="pageSize" value="${pageSize}"/>
					<wcf:param name="searchTerm" value="${contentSearchTerm}" />
					<wcf:param name="filterTerm" value="${WCParam.filterTerm}" />
					<wcf:param name="searchType" value="${searchType}"/>
					<wcf:param name="sType" value="${WCParam.sType}"/>						
					<wcf:param name="metaData" value="${metaData}"/>
					<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
					<wcf:param name="showResultsPage" value="true"/>
					<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
				</wcf:url>
		 		<c:choose>
		 			<c:when test="${WCParam.orderByContent eq '2'}">
		 				<option value="${SearchDisplaySortURL2}" selected="selected"><fmt:message key="SEARCH_SORT_BY_MIMETYPE" bundle="${storeText}"/></option>
		 			</c:when>
		 			<c:otherwise>
		 				<option value="${SearchDisplaySortURL2}"><fmt:message key="SEARCH_SORT_BY_MIMETYPE" bundle="${storeText}"/></option>
		 			</c:otherwise>
		 		</c:choose>
		</select>
	</div>

	<div class="clear_float" id="WC_SearchContentResultDisplay_div_4_3"></div>
</div>

<div class="body588" id="WC_SearchContentResultDisplay_div_5">

	<table id="horizontal_grid" border="0" cellpadding="0" cellspacing="0">
		<tbody>
			<tr class="item_container">
				<td class="divider_line" colspan="4" id="WC_SearchContentResultDisplay_td_1_2"></td>
			</tr>	
			<c:forEach var="content" items="${contentresults}" varStatus="status">

				<c:set var="contentName" value="${content.name}"  />
				<c:set var="contentShortDescription" value="${content.metaData.shortdesc}"  />

				<c:set var="contentHLName" value="${content.metaData.hl_name}" />
				<c:if test="${empty contentHLName}">
					<c:set var="contentHLName" value="${contentName}" />
				</c:if>

				<c:set var="contentHLShortDescription" value="${content.metaData.hl_shortdesc}" />
				<c:if test="${empty contentHLShortDescription}">
					<c:set var="contentHLShortDescription" value="${contentShortDescription}" />
				</c:if>

				<c:set var="urlValue" value="${content.URL}"/>
				<c:if test="${fn:startsWith(urlValue, 'StaticContent/')}">
					<wcf:url var="urlValue" patternName="StaticContentURL" value="StaticContent">
						<wcf:param name="url" value="${fn:substringAfter(urlValue, 'StaticContent/')}" />
						<wcf:param name="langId" value="${param.langId}" />
						<wcf:param name="storeId" value="${param.storeId}" />
						<wcf:param name="catalogId" value="${param.catalogId}" />
						<wcf:param name="urlLangId" value="${urlLangId}" />
					</wcf:url>
				</c:if>
				<c:if test="${!(fn:startsWith(urlValue, '/') || fn:contains(urlValue, '://'))}">
					<c:url var="urlValue" value="/servlet/${urlValue}" />
				</c:if>

				<tr class="item_container">
					<td class="image24" id="WC_CatalogEntryDBThumbnailDisplayJSPF_10293_td_4">

						<a style="background-image: none;" href="${urlValue}" class="itemhoverdetailed">			
							<img src="<c:out value='${jspStoreImgDir}' />images/${content.metaData.mimetype}.gif" alt="${content.metaData.mimetype}" border="0" width="24" height="24">
						</a>
					</td>
					<td class="av_information" id="WC_CatalogEntryDBThumbnailDisplayJSPF_10293_td_5">
						<h3 class="description"><a href="${urlValue}"><c:out value="${contentHLName}"  escapeXml="false"/></a></h3>
						<div class="subheading"><c:out value="${content.metaData.mimetype}"/></div>
						<p><c:out value="${contentHLShortDescription}"  escapeXml="false"/></p>

					</td>
				</tr>
				<tr class="item_container">
					<td class="divider_line" colspan="4"></td>
				</tr>
			</c:forEach>
	</table>
	

	<span class="display_text">
		<fmt:message key="CONTENT_RESULTS_DISPLAYING" bundle="${storeText}"> 
			<fmt:param><fmt:formatNumber value="${recordStart+ 1}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${recordEnd}"/></fmt:param>
			<fmt:param><fmt:formatNumber value="${totalContentCount}"/></fmt:param>
		</fmt:message>

		<c:if test="${totalContentPages > 1}">
			<span class="paging">
				<c:if test="${recordStart != 0}">
					<a href="javaScript:;" onclick="javaScript:setCurrentId('WC_SearchContentResultDisplay_link_27'); wc.render.getContextById('contentSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${prevPageIndex}'/>';CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewPrevURL}'/>', 'contentSearchResultDisplay_Controller', 'contentSearchResultDisplay_Context');" id="WC_SearchContentResultDisplay_link_27">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${recordStart != 0}">
					</a>
				</c:if>
			
				<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
					<fmt:param><fmt:formatNumber value="${currentPage+1}"/></fmt:param>
					<fmt:param><fmt:formatNumber value="${totalContentPages}"/></fmt:param>
				</fmt:message>
			
				<c:if test="${!completeIndicator}">
					<a href="javaScript:;" onclick="javaScript:setCurrentId('WC_SearchContentResultDisplay_link_28');wc.render.getContextById('contentSearchResultDisplay_Context').properties['searchResultsPageNum']='<c:out value='${nextPageIndex}'/>';CatalogSearchDisplayJS.goToResultPage('<c:out value='${SearchDisplayViewNextURL}'/>', 'contentSearchResultDisplay_Controller', 'contentSearchResultDisplay_Context');" id="WC_SearchContentResultDisplay_link_28">
				</c:if>
				<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
				<c:if test="${!completeIndicator}">
					</a>
				</c:if>
			</span>
		</c:if>
	</span>
</div>
<div class="footer" id="WC_SearchContentResultDisplay_div_7">
	 <div class="left_corner" id="WC_SearchContentResultDisplay_div_8"></div>
	 <div class="right" id="WC_SearchContentResultDisplay_div_9"></div>
	 <div class="right_corner" id="WC_SearchContentResultDisplay_div_10"></div>
</div>

<%@ include file="../../../Snippets/Catalog/CategoryDisplay/CategoryDisplayExt.jspf"%>
<br clear="all" />

<flow:ifEnabled feature="Analytics">
	<div id="catalog_search_result_information" style="visibility:hidden">
		{	searchResult: {
			pageSize: <c:out value="${pageSize}"/>, 
			searchTerms: '<c:out value="${contentSearchTerm}"/>', 
		 	totalPageNumber: <c:out value="${totalContentPages}"/>, 
		  	totalResultCount: <c:out value="${totalContentCount}" />, 
		  	currentPageNumber: <c:out value="${currentPage}" />
			}
		}
	</div>
</flow:ifEnabled>

<!-- END SearchBasedNavigationContentResultDisplay.jsp -->
