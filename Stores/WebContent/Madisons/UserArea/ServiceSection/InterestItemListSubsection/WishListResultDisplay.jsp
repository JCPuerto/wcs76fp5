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
<!-- BEGIN WishListResultDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<%@ page import="com.ibm.commerce.command.CommandContext" %>

<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="bHasWishList" value="true" />
<c:set var="wishListPage" value="true" />
<c:set var="emailError" value="false" />
	
<c:set var="numberProductsPerRow" value="4"/>
	
<c:set var="pageSize" value="${param.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="12" />
</c:if>

<c:choose>
	<%-- users have explicitly chosen a pageView --%>
	<c:when test="${!empty WCParam.pageView}">
		<c:set var="pageView" value="${WCParam.pageView}"/>
	</c:when>
	<c:otherwise>
		<%-- use defaultPageView, set in JSTLEnvironmentSetup --%>
		<c:set var="pageView" value="${defaultPageView}"/>
	</c:otherwise>
</c:choose>

<flow:ifEnabled feature="wishList">
	<wcbase:useBean id="userListBean" classname="com.ibm.commerce.store.beans.UserInterestItemListDataBean" scope="page">
	<c:set target="${userListBean}" property="storeEntityId" value="${WCParam.storeId}"/>
		<%--
		*** 
		* Two stores on the same server shares user wish lists.  We have to set the storeentId
		* to make sure the items in this shoppers wish list belongs to this store.
		*** 
		--%>
		
	</wcbase:useBean>
	<c:set var="listBeans" value="${userListBean.userInterestItemListDataBeans}"/>
	<c:choose>		
		<%-- Check to see if the list is empty, if no, then wish list is empty--%>		
		<c:when test="${ empty listBeans }" >
			<c:set var="bHasWishList" value="false"/>
		</c:when>    
		<c:otherwise>
			<c:set var="listBean" value="${listBeans[0]}"/>
			<c:set var="interestItems" value="${listBean.interestItemDataBeans}" />
	    	<%-- if there are items, then there are items in the wish list --%>
		   	<c:if test="${ empty interestItems }" >
				<c:set var="bHasWishList" value="false"/>
	   		</c:if>
		</c:otherwise>
	</c:choose>
	<input type="hidden" id="interestItemListId" name="interestItemListId" value="<c:out value='${listBean.listId}' />"/>

	<c:set var="numEntries" value="0"/>
	<c:forEach var="count" items="${listBean.interestItemDataBeans}" varStatus="status">
		<c:if test="${status.last}"><c:set var="numEntries" value="${status.count}"/></c:if>
	</c:forEach>
	
	<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)+1}"/>
	<c:if test="${numEntries%pageSize == 0}">
		<fmt:formatNumber var="totalPages" value="${numEntries/pageSize}"/>
		<c:if test="${totalPages == 0 && numEntries!=0}">
			<fmt:formatNumber var="totalPages" value="1"/>
		</c:if>
	</c:if>
	<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>
	
	<c:set var="currentPage" value="${param.currentPage}" />
	<c:if test="${empty currentPage}">
		<c:set var="currentPage" value="0" />
	</c:if>
	
	<c:if test="${currentPage < 0}">
		<c:set var="currentPage" value="0"/>
	</c:if>
	<c:if test="${currentPage >= (totalPages)}">
		<c:set var="currentPage" value="${totalPages-1}"/>
	</c:if>
	
	<c:set var="startIndex" value="1"/>
	<c:if test="${currentPage != 0}">
		<c:set var="startIndex" value="${(currentPage * pageSize) + 1}"/>
	</c:if>
	
	<c:set var="endIndex" value="${(currentPage + 1) * pageSize}"/>
	<c:if test="${endIndex > numEntries}">
		<c:set var="endIndex" value="${numEntries}"/>
	</c:if>
	
</flow:ifEnabled>

<flow:ifEnabled feature="SOAWishlist">
	<c:set var="startIndex" value="${WCParam.startIndex}" />
	<c:if test="${empty startIndex}">
		<c:set var="startIndex" value="0" />
	</c:if>
	
	<%@ include file="../../../Snippets/MultipleWishList/GetDefaultWishList.jspf" %>	

	<c:choose>
		<c:when test="${!empty WCParam.wishListEMail && WCParam.wishListEMail != null && WCParam.wishListEMail == 'true'}">
			<%-- from shared wish list page - user can be a guest user or a registered user who is not the owner of the wish list --%>
			<c:set var="sharedWishList" value="true" scope="request"/>
			<c:choose>
				
				<c:when test="${empty WCParam.externalId}">
					<c:set var="emailError" value="true" />
				</c:when>
				
				<c:otherwise>
					<c:set var="selectedWishListExternalId" value="${WCParam.externalId}"/>
					<%@ include file="../../../Snippets/MultipleWishList/GetWishListItemsByExternalId.jspf" %>
					
					<c:if test="${ShowVerbWishList.recordSetTotal == 0 && startIndex != 0}">
						<%-- when nothing is returned - it can be that last item from the page is removed, go back one page --%>
						<c:set var="startIndex" value="${startIndex - pageSize}" />
						<c:if test="${startIndex < 0}">
							<c:set var="startIndex" value="0" />
						</c:if>
						<%@ include file="../../../Snippets/MultipleWishList/GetWishListItemsByExternalId.jspf" %>
					</c:if>
					
					<c:if test="${selectedSoaWishList == null}">
						<c:set var="emailError" value="true" />
					</c:if>
					
					<c:if test="${empty selectedSoaWishList.item}">
						<c:set var="bHasWishList" value="false"/>
					</c:if>
				</c:otherwise>
			</c:choose>
			
		</c:when>
		
		<c:when test="${empty defaultWishList}">
			<%-- from my account wish list page - if user has no wish list defined, set bHasWishList to false --%>
			<c:set var="bHasWishList" value="false"/>
		</c:when>
		
		<c:otherwise>
			<%-- from my account wish list page - user has wish list defined, get the detail of user's default wish list --%>
			<c:set var="selectedWishListExternalId" value="${defaultWishList.giftListIdentifier.giftListExternalIdentifier.externalIdentifier}"/>
			<c:set var="selectedWishListId" value="${defaultWishList.giftListIdentifier.uniqueID}"/>
			<%@ include file="../../../Snippets/MultipleWishList/GetWishListItemsByExternalId.jspf" %>
			
			<c:if test="${ShowVerbWishList.recordSetTotal == 0 && startIndex != 0}">
				<%-- when nothing is returned - it can be that last item from the page is removed, go back one page --%>
				<c:set var="startIndex" value="${startIndex - pageSize}" />
				<c:if test="${startIndex < 0}">
					<c:set var="startIndex" value="0" />
				</c:if>
				<%@ include file="../../../Snippets/MultipleWishList/GetWishListItemsByExternalId.jspf" %>
			</c:if>
			
			<c:if test="${empty selectedSoaWishList.item}">
				<c:set var="bHasWishList" value="false"/>
			</c:if>
		</c:otherwise>
	</c:choose>
	
	<c:set var="numEntries" value="${ShowVerbWishList.recordSetTotal}"/>					
		
	<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)}"/>		
	<c:if test="${numEntries%pageSize < (pageSize/2)}">
		<fmt:parseNumber var="totalPages" value="${(numEntries+(pageSize/2)-1)/pageSize}"/>
	</c:if>
	<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>

	<c:set var="currentPage" value="${param.currentPage}" />
	<c:if test="${empty currentPage}">
		<c:set var="currentPage" value="0" />
	</c:if>
	
	<c:if test="${currentPage < 0}">
		<c:set var="currentPage" value="0"/>
	</c:if>
	<c:if test="${currentPage >= (totalPages)}">
		<c:set var="currentPage" value="${totalPages-1}"/>
	</c:if>
		
	<c:set var="endIndex" value="${(currentPage + 1) * pageSize}"/>
	<c:if test="${endIndex > numEntries}">
		<c:set var="endIndex" value="${numEntries}"/>
	</c:if>
</flow:ifEnabled>

<c:if test="${currentPage != 0}">
	<wcf:url var="WishListResultDisplayViewPrevURL" value="WishListResultDisplayView" type="Ajax">
	  <wcf:param name="langId" value="${langId}" />						
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="currentPage" value="${currentPage - 1}" />
	  <wcf:param name="startIndex" value="${startIndex - pageSize}" />
	  <wcf:param name="pageView" value="${pageView}" />
	  <c:if test="${!empty WCParam.wishListEMail && WCParam.wishListEMail != null && WCParam.wishListEMail == 'true'}">
	  	<wcf:param name="wishListEMail" value="true" />
	  	<wcf:param name="externalId" value="${WCParam.externalId}" />
	  </c:if>
	</wcf:url>
</c:if>

<c:if test="${currentPage < totalPages-1}">
	<wcf:url var="WishListResultDisplayViewNextURL" value="WishListResultDisplayView" type="Ajax">
	  <wcf:param name="langId" value="${langId}" />						
	  <wcf:param name="storeId" value="${WCParam.storeId}" />
	  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
	  <wcf:param name="currentPage" value="${currentPage + 1}" />
	  <wcf:param name="startIndex" value="${startIndex + pageSize}" />
	  <wcf:param name="pageView" value="${pageView}" />
	  <c:if test="${!empty WCParam.wishListEMail && WCParam.wishListEMail != null && WCParam.wishListEMail == 'true'}">
	  	<wcf:param name="wishListEMail" value="true" />
	  	<wcf:param name="externalId" value="${WCParam.externalId}" />
	  </c:if>
	</wcf:url>
</c:if>

<wcf:url var="WishListResultDisplayViewFullURL" value="WishListResultDisplayView" type="Ajax">
  <wcf:param name="langId" value="${langId}" />						
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="currentPage" value="${currentPage}" />
  <wcf:param name="startIndex" value="${startIndex}" />
  <wcf:param name="pageView" value="detailed" />
  <c:if test="${!empty WCParam.wishListEMail && WCParam.wishListEMail != null && WCParam.wishListEMail == 'true'}">
  	<wcf:param name="wishListEMail" value="true" />
  	<wcf:param name="externalId" value="${WCParam.externalId}" />
  </c:if>
</wcf:url>

<wcf:url var="WishListResultDisplayViewURL" value="WishListResultDisplayView" type="Ajax">
  <wcf:param name="langId" value="${langId}" />						
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="currentPage" value="${currentPage}" />
  <wcf:param name="startIndex" value="${startIndex}" />
  <wcf:param name="pageView" value="image" />
  <c:if test="${!empty WCParam.wishListEMail && WCParam.wishListEMail != null && WCParam.wishListEMail == 'true'}">
  	<wcf:param name="wishListEMail" value="true" />
  	<wcf:param name="externalId" value="${WCParam.externalId}" />
  </c:if>
</wcf:url>

<wcf:url var="WishListResultDisplay" value="WishListResultDisplayView" type="Ajax">
  <wcf:param name="langId" value="${langId}" />						
  <wcf:param name="storeId" value="${WCParam.storeId}" />
  <wcf:param name="catalogId" value="${WCParam.catalogId}" />
  <wcf:param name="currentPage" value="${currentPage}" />
  <wcf:param name="startIndex" value="${startIndex}" />
  <wcf:param name="pageView" value="${pageView}" />
	<c:if test="${!empty WCParam.wishListEMail && WCParam.wishListEMail != null && WCParam.wishListEMail == 'true'}">
		<wcf:param name="wishListEMail" value="true" />
		<wcf:param name="externalId" value="${WCParam.externalId}" />
	</c:if>
</wcf:url>

<div class="contentgrad_header bopis_contentgrad_header" id="WC_WishListResultDisplay_div_1">
	<div class="left_corner_short" id="WC_WishListResultDisplay_div_2"></div>
	<div class="right_corner_short" id="WC_WishListResultDisplay_div_3"></div>
</div>

<div class="left body588" id="WC_WishListResultDisplay_div_3l">
	<flow:ifEnabled feature="wishList">
		<span class="main_header_text wishList_header_content" ><fmt:message key="MA_PERSONAL_WL" bundle="${storeText}"/></span>					
	</flow:ifEnabled>
	<flow:ifEnabled feature="SOAWishlist">		
		<c:choose>
			<c:when test="${!empty WCParam.wishListEMail && WCParam.wishListEMail != null && WCParam.wishListEMail == 'true'}">
				<span class="main_header_text wishList_header_content" ><c:out value="${selectedSoaWishList.description.name}"/></span>
			</c:when>
			<c:when test="${empty defaultWishList}">		
				<span class="main_header_text wishList_header_content" ><fmt:message key="MA_PERSONAL_WL" bundle="${storeText}"/></span>
			</c:when>
			<c:otherwise>
				<span class="main_header_text wishList_header_content" ><c:out value="${defaultWishList.description.name}"/></span>
			</c:otherwise>
		</c:choose>
	</flow:ifEnabled>
	<c:if test="${isChinaStore }">	
		<span class="main_header_text wishlist_sharing"><a href="javascript:;" onclick="dojo.byId('wishlist').style.display='block';return false;"><fmt:message key="WISHLIST_SHARE_WISHLIST" bundle="${storeText}"/></a></span>			
	</c:if>
	
	<c:if test="${!sharedWishList}">
			<flow:ifEnabled feature="RemoteWidgetWishlist">
				<c:if test="${!empty defaultWishList}">		
					<div class="right" id="getWidgetButton">
						<c:url var="feedURL" value="${restURLScheme}://${pageContext.request.serverName}:${restURLPort}${restURI}/stores/${WCParam.storeId}/GiftLists/${selectedWishListId}?guestAccessKey=${defaultWishList.accessSpecifier.guestAccessKey}">
							<c:param name="responseFormat" value="atom" />
							<c:param name="langId" value="${langId}" />
							<c:param name="currency" value="${CommandContext.currency}" />
						</c:url>
						<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/RemoteWidgetButtons.jsp">
				  			<c:param name="showWidget" value="true" />
				  			<c:param name="showFeed" value="false" />
				  			<c:param name="sidebarWidgetId" value="" />
								<c:param name="bannerWidgetId" value="" />  
				  			<c:param name="feedURL" value="${feedURL}" />
				  			<c:param name="widgetIconStyle" value="top" />
				  		</c:import>
					</div>	
				</c:if>
			</flow:ifEnabled>
	</c:if>
</div>
<div class="body588 divider_line divider_line_style" id="WC_WishListResultDisplay_div_line"></div>

<div class="body588" id="WC_WishListResultDisplay_div_5">
	<c:choose> 
		<c:when test="${emailError}">
			<%-- 
			  ***
			  * Error condition - when externalID specified is incorrect, or guestAccessKey is incorrect 
			  ***
			--%>
			<div class="my_account_wishlist_container" id="WC_WishListResultDisplay_div_6">
				<fmt:message key="GENERICERR_MAINTEXT" bundle="${storeText}">
					<fmt:param><fmt:message key="GENERICERR_CONTACT_US" bundle="${storeText}" /></fmt:param>
				</fmt:message>
				<br/><br/>
			</div>
		</c:when>
		
		<c:when test="${ !bHasWishList }">
			<%--
				***
				* Start: Empty Wish List 
				* If the wish list is empty, display the empty wish list message
				***
			--%>
			<div class="my_account_wishlist_container" id="WC_WishListResultDisplay_div_6"><br/><fmt:message key="EMPTYWISHLIST" bundle="${storeText}" /><br/><br/></div>
			<div class="center" id="WC_WishListResultDisplay_div_7"><img src="<c:out value="${jspStoreImgDir}${vfileColor}/wish_list.jpg"/>" alt="<fmt:message key="EMPTYWISHLIST" bundle="${storeText}" />" /></div>
			 <%--
				***
				* End: Empty Wish List 
				***
			--%>	
		</c:when>
		
		<c:otherwise>
			<%-- 
			  ***
			  * Wish list is not empty - display content of wish list 
			  ***
			--%>
						
			<%-- calculate total number of pages --%>
			<div class="left_wishlist" id="WC_WishListResultDisplay_div_8">
				<span class="subheader_text">
					<%-- for classic wish list, startIndex begins with 1, but for SOA wish list, startIndex begins with 0 --%>
					<flow:ifEnabled feature="wishList">
						<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
							<fmt:param><fmt:formatNumber value="${startIndex}"/></fmt:param>
							<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
							<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
						</fmt:message>
					</flow:ifEnabled>
					<flow:ifEnabled feature="SOAWishlist">
						<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
							<fmt:param><fmt:formatNumber value="${startIndex + 1}"/></fmt:param>
							<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
							<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
						</fmt:message>
					</flow:ifEnabled>
					<c:if test="${totalPages > 1}">
						<span class="paging">
							<c:if test="${currentPage != 0}">
								<c:choose>
									<c:when test="${!empty WCParam.wishListEMail && WCParam.wishListEMail != null && WCParam.wishListEMail == 'true'}">
										<a href="javaScript:refreshContentURL('<c:out value='${WishListResultDisplayViewPrevURL}'/>');" id="WC_WishListResultDisplay_links_1">
									</c:when>
									<c:otherwise>
										<a href="javaScript:setCurrentId('WC_WishListResultDisplay_links_1');AccountWishListDisplay.loadContentURL('<c:out value='${WishListResultDisplayViewPrevURL}'/>');" id="WC_WishListResultDisplay_links_1">
									</c:otherwise>
								</c:choose>
							</c:if>
							<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
							<c:if test="${currentPage != 0}">
								</a>
							</c:if>
							<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
								<fmt:param><fmt:formatNumber value="${currentPage + 1}"/></fmt:param>
								<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
							</fmt:message>
							<c:if test="${currentPage < totalPages-1}">
								<c:choose>
									<c:when test="${!empty WCParam.wishListEMail && WCParam.wishListEMail != null && WCParam.wishListEMail == 'true'}">
										<a href="javaScript:refreshContentURL('<c:out value='${WishListResultDisplayViewNextURL}'/>');" id="WC_WishListResultDisplay_links_2">
									</c:when>
									<c:otherwise>
										<a href="javaScript:setCurrentId('WC_WishListResultDisplay_links_2');AccountWishListDisplay.loadContentURL('<c:out value='${WishListResultDisplayViewNextURL}'/>');" id="WC_WishListResultDisplay_links_2">
									</c:otherwise>	
								</c:choose>
							</c:if>
								<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
							<c:if test="${currentPage < totalPages-1}">
								</a>
							</c:if>
						</span>
					</c:if>
				</span>
			</div>
			<div class="right" id="WC_WishListResultDisplay_div_9">              
				<span class="views_icon">  
					<c:if test="${pageView !='image'}">
						<c:set var="gridView" value="horizontal_grid"/>
						<a href="javaScript:setCurrentId('WC_WishListResultDisplay_links_3'); AccountWishListDisplay.loadContentURL('<c:out value='${WishListResultDisplayViewURL}'/>');" id="WC_WishListResultDisplay_links_3">
							<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />grid_normal.png" alt="<fmt:message key="CATEGORY_IMAGE_VIEW" bundle="${storeText}"/>" />
						</a>
						 <img id="detailedTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}list_selected.png"/>" alt="<fmt:message key="FF_VIEWDETAILS" bundle="${storeText}"/>"/>	
					</c:if>
					<c:if test="${pageView !='detailed'}">
						<c:set var="gridView" value="four-grid-wishlist"/>
						<img id="imageTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}grid_selected.png"/>" alt="<fmt:message key="FF_VIEWICONS" bundle="${storeText}"/>"/>
						<a href="javaScript:setCurrentId('WC_WishListResultDisplay_links_4'); AccountWishListDisplay.loadContentURL('<c:out value='${WishListResultDisplayViewFullURL}'/>');" id="WC_WishListResultDisplay_links_4">
							<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />list_normal.png" alt="<fmt:message key="CATEGORY_DETAILED_VIEW" bundle="${storeText}"/>" />
						</a>
					</c:if>
				</span>
			</div>
			<br/>
			<br clear="all" />
			<table id="${gridView}" cellpadding="0" cellspacing="0" border="0">
			<c:set var="rowItemCount" value="0"/>
			<c:set var="rowBeginIndex" value="0"/>

			<%-- 
			  ***
			  * displays items in the wish list - classic wish list 
			  ***
			--%>
			<flow:ifEnabled feature="wishList">	
				<c:forEach var="interestItem" items="${listBean.interestItemDataBeans}" varStatus="status" begin="${startIndex-1}" end="${endIndex-1}">
					<c:set var="catEntry" value="${interestItem.catalogEntryDataBean}"/>
					<c:set var="prefix" value="wishList"/>
					<c:set var="catEntryIdentifier" value="${catEntry.catalogEntryID}"/>
					<c:set var="includeRemoveFromWishList" value="true"/>
					<c:if test="${pageView == 'detailed'}">
						<wcf:url var="interestItemDeleteURL" value="InterestItemDelete" type="Ajax">
							<wcf:param name="catEntryId" value="${catEntry.catalogEntryID}" />
							<wcf:param name="storeId" value="${WCParam.storeId}" />
							<wcf:param name="catalogId" value="${WCParam.catalogId}" />
							<wcf:param name="langId" value="${langId}"/>
							<wcf:param name="listId" value="." />
							<wcf:param name="pageView" value="detailed"/>
							<wcf:param name="URL" value="NonAjaxAccountWishListDisplayView"/>
							<wcf:param name="errorViewName" value="NonAjaxAccountWishListDisplayView"/>
						</wcf:url>
					</c:if>
					<c:if test="${rowItemCount == 0}">
						<tr class="item_container">
							<td class="divider_line" colspan="4" id="WC_WishListResultDisplay_td_1_<c:out value='${status.count}'/>"></td>
						</tr>
						<tr class="item_container">	
					</c:if>
					<c:if test="${pageView == 'image'}">
							<td class="item" id="WC_WishListResultDisplay_td_2_<c:out value='${status.count}'/>">
								<div id="WC_WishListResultDisplay_div_10_<c:out value='${status.count}'/>" <c:if test="${rowItemCount!=0}"> class="container" </c:if>>
									<c:set var="rowItemCount" value="${rowItemCount+1}"/>
									<c:set var="interestItem2" value="${interestItem}"/>
					</c:if>
					<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %> 
					<c:if test="${pageView == 'image'}">
								</div>
							</td>
							
							<c:if test="${rowItemCount%numberProductsPerRow == 0}">
								</tr>
								
								<c:set var="rowItemCount" value="0"/>
								<c:set var="rowBeginIndex" value="${status.index+1}"/>
							</c:if>
					</c:if>
				</c:forEach>
			</flow:ifEnabled>	

			<%-- 
			  ***
			  * displays items in the wish list - SOA wish list 
			  ***
			--%>	
			<flow:ifEnabled feature="SOAWishlist">	
			  <c:set var="prefix" value="soaWishList"/> <%-- used by CatalogEntryDBThumbnailDisplay.jspf to form unique ID for divs/quickInfo buttons --%>
				<c:forEach var="soaWishlistItem" items="${selectedSoaWishList.item}" varStatus="status">
					
					<%-- try to instantiate an instance of CatalogEntryDataBean and pass to thumbnail display --%>
					<c:set var="itemError" value="false" scope="request"/>
					<c:choose>
						<c:when test="${empty soaWishlistItem.catalogEntryIdentifier.uniqueID}">
							<%@ page import="java.util.Enumeration" %>
							<%@ page import="com.ibm.commerce.catalog.objects.CatalogEntryAccessBean" %>
							<%@ page import="com.ibm.commerce.catalog.objsrc.CatalogEntryCache" %>
							<c:set var="itemPartNumber" value="${soaWishlistItem.catalogEntryIdentifier.externalIdentifier.partNumber}" scope="request"/>
							<%
								try {
									CatalogEntryAccessBean abCatalogEntry = null;
									String[] strStoreId = (String[])request.getAttribute("storeId");
						
									Enumeration e = CatalogEntryCache.findBySKUNumberAndStore((String)request.getAttribute("itemPartNumber"),new Integer(strStoreId[0]));
									abCatalogEntry = (CatalogEntryAccessBean) e.nextElement();
									request.setAttribute("itemCatentryId", abCatalogEntry.getCatalogEntryReferenceNumber());
								} catch (Exception e) {
									request.setAttribute("itemError", true);
								}
							%>
							<c:if test="${!requestScope.itemError}">
								<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
									<c:set property="catalogEntryID" value="${requestScope.itemCatentryId}" target="${catEntry}" />
								</wcbase:useBean>
							</c:if>
							<c:remove var="requestScope.itemPartNumber"/>
							<c:remove var="requestScope.itemCatentryId"/>
							</c:when>
						<c:otherwise>
							<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
								<c:set property="catalogEntryID" value="${soaWishlistItem.catalogEntryIdentifier.uniqueID}" target="${catEntry}" />
							</wcbase:useBean>
						</c:otherwise>
					</c:choose>			
					
					<c:choose>
						<c:when test="${!requestScope.itemError}">		
							<%--
							  *** 
							  * item exists in catalog - calls thumbnail display to display item details 
							  ***
							--%>
							<c:set var="includeRemoveFromWishList" value="true"/>
							<c:set var="wishListIdentifier" value="${selectedSoaWishList.giftListIdentifier.uniqueID}"/>
							<c:if test="${rowItemCount == 0}">
								<tr class="item_container">
									<td class="divider_line" colspan="4" id="WC_WishListResultDisplay_td_1_<c:out value='${status.count}'/>"></td>
								</tr>
								<tr class="item_container">	
							</c:if>
							<c:if test="${pageView == 'image'}">
								<td class="item" id="WC_WishListResultDisplay_td_2_<c:out value='${status.count}'/>">
									<div id="WC_WishListResultDisplay_div_11_<c:out value='${status.count}'/>" <c:if test="${rowItemCount!=0}"> class="container" </c:if>>
										<c:set var="rowItemCount" value="${rowItemCount+1}"/>
							</c:if>

							<c:set var="soaListItem" value="${soaWishlistItem}"/>
							<c:set var="catEntryIdentifier" value="${soaWishlistItem.catalogEntryIdentifier.uniqueID}" scope="request"/> <%-- used by CatalogEntryDBThumbnailDisplay.jspf to form unique ID for divs/quickInfo buttons --%>
							<%@ include file="../../../Snippets/ReusableObjects/CatalogEntryDBThumbnailDisplay.jspf" %> 
							<c:if test="${pageView == 'image'}">
									</div>
								</td>
								
								<c:if test="${rowItemCount%numberProductsPerRow == 0}">
									</tr>
									
									<c:set var="rowItemCount" value="0"/>
									<c:set var="rowBeginIndex" value="${status.index+1}"/>
								</c:if>
							</c:if>
						</c:when> 
					
						<c:otherwise>
							<%-- 
							  *** 
							  * item does not exist in catalog - display empty image and remove link to allow shopper to remove the item 
							  ***
							--%>
							<wcf:url var="wishListDeleteURL" value="GiftListServiceUpdateItem" type="Ajax">
								<wcf:param name="giftListItemId" value="${soaWishlistItem.giftListItemID}" />
								<wcf:param name="storeId" value="${WCParam.storeId}" />
								<wcf:param name="catalogId" value="${WCParam.catalogId}" />
								<wcf:param name="langId" value="${langId}" />
								<wcf:param name="quantity" value="0" />
								<wcf:param name="giftListId" value="${selectedSoaWishList.giftListIdentifier.uniqueID}" />
								<wcf:param name="pageView" value="${pageView}" />
								<flow:ifEnabled feature="AjaxMyAccountPage">
									<wcf:param name="URL" value="AjaxAccountWishListDisplayView" />
									<wcf:param name="errorViewName" value="AjaxAccountWishListDisplayView"/>
								</flow:ifEnabled>
								<flow:ifDisabled feature="AjaxMyAccountPage">
									<wcf:param name="URL" value="NonAjaxAccountWishListDisplayView" />
									<wcf:param name="errorViewName" value="NonAjaxAccountWishListDisplayView"/>
								</flow:ifDisabled>
							</wcf:url>
							
							<c:if test="${rowItemCount == 0}">
								<tr class="item_container">
									<td class="divider_line" colspan="4" id="WishListResultDisplay_noCatentry_td_1_<c:out value='${status.count}'/>"></td>
								</tr>
								<tr class="item_container">	
							</c:if>
							
							<c:choose>
								<c:when test="${pageView == 'image'}">	
									<td class="item" id="WishListResultDisplay_noCatentry_td_2_<c:out value='${status.count}'/>">
										<div id="WishListResultDisplay_noCatentry_div_1_<c:out value='${status.count}'/>" <c:if test="${rowItemCount!=0}"> class="container" </c:if>>
											<c:set var="rowItemCount" value="${rowItemCount+1}"/>
											<div id="WishListResultDisplay_noCatentry_div_2_<c:out value='${status.count}'/>">
												<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}" />" border="0" width="70" height="70"/>
											</div>
											<div class="description" id="WishListResultDisplay_noCatentry_div_3_<c:out value='${status.count}'/>">
												<c:out value="${soaWishlistItem.catalogEntryIdentifier.externalIdentifier.partNumber}"/>
												<p><fmt:message key="_ERR_CATENTRY_NOT_EXISTING_IN_STORE" bundle="${storeText}"/></p>
											</div>
											<div class="price" id="WishListResultDisplay_noCatentry_div_4_<c:out value='${status.count}'/>">
											</div>
											<div class="button" id="WishListResultDisplay_noCatentry_div_5_<c:out value='${status.count}'/>">
												<div class="multiple_buttons" id="WishListResultDisplay_noCatentry_div_6_<c:out value='${status.count}'/>"> &nbsp;</div>
												<div class="multiple_buttons" id="WishListResultDisplay_noCatentry_div_7_<c:out value='${status.count}'/>">
													<c:if test="${!sharedWishList}">
														<flow:ifEnabled feature="AjaxMyAccountPage">
															<div class="deleteLink"><a class="bopis_link" href="javaScript:MultipleWishLists.removeItem('<c:out value='${soaWishlistItem.giftListItemID}'/>')" id="WishListResultDisplay_noCatentry_div_8_<c:out value='${status.count}'/>"><fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" /></a></div>
														</flow:ifEnabled>
														<flow:ifDisabled feature="AjaxMyAccountPage">
															<div class="deleteLink"><a class="bopis_link" href="#" onclick="Javascript:setPageLocation('<c:out value='${wishListDeleteURL}'/>');return false;"  id="WishListResultDisplay_noCatentry_div_8_<c:out value='${status.count}'/>"><fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" /></a></div>
														</flow:ifDisabled>
													</c:if>
												</div>
											</div>
										</div>
									</td>
								</c:when>
								<c:when test="${pageView == 'detailed'}">
									<td class="image" id="WishListResultDisplay_noCatentry_td_3_<c:out value='${status.count}'/>">
										<div id="WishListResultDisplay_noCatentry_div_9_<c:out value='${status.count}'/>" class="itemhoverdetailed">
											<img src="<c:out value='${jspStoreImgDir}' />images/NoImageIcon_sm.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}" />" border="0" width="70" height="70"/>
										</div>
									</td>
									<td class="information" id="WishListResultDisplay_noCatentry_td_4_<c:out value='${status.count}'/>">
										<h3><c:out value="${soaWishlistItem.catalogEntryIdentifier.externalIdentifier.partNumber}"/></h3>
										<p><fmt:message key="_ERR_CATENTRY_NOT_EXISTING_IN_STORE" bundle="${storeText}"/></p>
									</td>
									<td class="price" id="WishListResultDisplay_noCatentry_td_5_<c:out value='${status.count}'/>">
									</td>
									<td class="add_to_cart" id="WishListResultDisplay_noCatentry_td_6_<c:out value='${status.count}'/>">
										<c:if test="${!sharedWishList}">
											<flow:ifEnabled feature="AjaxMyAccountPage">
												<div class="deleteLink"><a class="bopis_link" href="javaScript:MultipleWishLists.removeItem('<c:out value='${soaWishlistItem.giftListItemID}'/>')" id="WishListResultDisplay_noCatentry_div_10_<c:out value='${status.count}'/>"><fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" /></a></div>
											</flow:ifEnabled>
											<flow:ifDisabled feature="AjaxMyAccountPage">
												<div class="deleteLink"><a class="bopis_link" href="#" onclick="Javascript:setPageLocation('<c:out value='${wishListDeleteURL}'/>');return false;"  id="WishListResultDisplay_noCatentry_div_10_<c:out value='${status.count}'/>"><fmt:message key="WISHLIST_REMOVE" bundle="${storeText}" /></a></div>
											</flow:ifDisabled>
										</c:if>
									</td>
								</c:when>
							</c:choose>
							<c:if test="${rowItemCount%numberProductsPerRow == 0}">
								</tr>
								
								<c:set var="rowItemCount" value="0"/>
								<c:set var="rowBeginIndex" value="${status.index+1}"/>
							</c:if>
						</c:otherwise>
					</c:choose>
					<c:remove var="catEntry"/>
					<c:remove var="requestScope.itemError"/>
				</c:forEach>
			</flow:ifEnabled>
			
			<c:if test="${rowItemCount != 0 && pageView !='detailed'}">
				</tr>
			</c:if>
			<tr class="item_container">
				<td class="divider_line" colspan="4" id="WC_WishListResultDisplay_td_1a"></td>
			</tr>
		</table>
		
		<%-- display total number of pages --%>
		<div class="top_pagination">
			<span class="subheader_text left">
				<%-- for classic wish list, startIndex begins with 1, but for SOA wish list, startIndex begins with 0 --%>
				<flow:ifEnabled feature="wishList">
					<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
						<fmt:param><fmt:formatNumber value="${startIndex}"/></fmt:param>
						<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
						<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
					</fmt:message>
				</flow:ifEnabled>
				<flow:ifEnabled feature="SOAWishlist">
					<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
						<fmt:param><fmt:formatNumber value="${startIndex + 1}"/></fmt:param>
						<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
						<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
					</fmt:message>
				</flow:ifEnabled>
				
				<c:if test="${totalPages > 1}">
					<span class="paging">
						<c:if test="${currentPage != 0}">
							<c:choose>
								<c:when test="${!empty WCParam.wishListEMail && WCParam.wishListEMail != null && WCParam.wishListEMail == 'true'}">
									<a href="javaScript:refreshContentURL('<c:out value='${WishListResultDisplayViewPrevURL}'/>');" id="WC_WishListResultDisplay_links_5">
								</c:when>
								<c:otherwise>
									<a href="javaScript:setCurrentId('WC_WishListResultDisplay_links_5'); AccountWishListDisplay.loadContentURL('<c:out value='${WishListResultDisplayViewPrevURL}'/>');" id="WC_WishListResultDisplay_links_5">
								</c:otherwise>
							</c:choose>
						</c:if>
						<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_back.png" alt="<fmt:message key="CATEGORY_PAGING_LEFT_IMAGE" bundle="${storeText}"/>" />
						<c:if test="${currentPage != 0}">
							</a>
						</c:if>
						<fmt:message key="CATEGORY_RESULTS_PAGES_DISPLAYING" bundle="${storeText}"> 
							<fmt:param><fmt:formatNumber value="${currentPage + 1}"/></fmt:param>
							<fmt:param><fmt:formatNumber value="${totalPages}"/></fmt:param>
						</fmt:message>
						<c:if test="${currentPage < totalPages-1}">
							<c:choose>
								<c:when test="${!empty WCParam.wishListEMail && WCParam.wishListEMail != null && WCParam.wishListEMail == 'true'}">
									<a href="javaScript:refreshContentURL('<c:out value='${WishListResultDisplayViewNextURL}'/>');" id="WC_WishListResultDisplay_links_6">
								</c:when>
								<c:otherwise>
									<a href="javaScript:setCurrentId('WC_WishListResultDisplay_links_6');AccountWishListDisplay.loadContentURL('<c:out value='${WishListResultDisplayViewNextURL}'/>');" id="WC_WishListResultDisplay_links_6">
								</c:otherwise>
							</c:choose>
						</c:if>
							<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
						<c:if test="${currentPage < totalPages-1}">
							</a>
						</c:if>
					</span>
				</c:if>
			</span>
		</div>			
		<div class="clear_both"></div>
		</c:otherwise>
	</c:choose>
</div>		
<input type="hidden" name="controllerURLWishlist" value ="${WishListResultDisplay}" id="controllerURLWishlist"/>
<div class="footer" id="WC_WishListResultDisplay_div_12">
	<div class="left_corner" id="WC_WishListResultDisplay_div_13"></div>
	<div class="left" id="WC_WishListResultDisplay_div_14"></div>
	<div class="right_corner" id="WC_WishListResultDisplay_div_15"></div>
</div>
<!-- END WishListResultDisplay.jsp -->
