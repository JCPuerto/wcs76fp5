<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<!-- BEGIN CategoryOnlyDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<wcbase:useBean id="category" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page" />

	<c:choose>
		<c:when test ="${!empty WCParam.categoryId}">
			<c:set var="currentCategoryId" value="${WCParam.categoryId}"/>
		</c:when>
		<c:otherwise>
			<c:set var="currentCategoryId" value="${category.categoryId}"/>
		</c:otherwise>
	</c:choose>

<div id="content588">
	 <h1><c:out value="${category.description.name}" /></h1>
   <div id="box">

        <c:if test="${!empty category.description.fullIImage}">
		<div class="ad" id="ad_Category"> <img src="<c:out value="${category.objectPath}${category.description.fullIImage}"/>" alt="<c:out value="${requestScope.fullImageAltDescription}" />" border="0"/> </div>
	</c:if>

		<% out.flush(); %>
		<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
			<c:param name="storeId" value="${WCParam.storeId}" />
			<c:param name="catalogId" value="${catalogId}" />
			<c:param name="langId" value="${langId}" />
			<c:param name="numberProductsPerRow" value="4" />
			<c:param name="emsName" value="CategoryPageFeaturedProducts" />
			<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
		</c:import>
		<% out.flush(); %>
			  
		<p class="space"></p>			
		<c:set var="numSubCat" value="${fn:length(category.subCategories)}"/>		
		
		
		
		<c:if test="${numSubCat > maxSubCategoriesPerCategoryInSidebar}">
		<div dojoType="wc.widget.RefreshArea" id="SubCategoryDisplay_Widget" controllerId="SubCategoryDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="additions">
			<% out.flush(); %>
			<c:import url="${jspStoreDir}Snippets/Catalog/CategoryDisplay/SubCategoriesListDisplay.jsp">
				<c:param name="langId" value="${langId}" />
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="categoryId" value="${currentCategoryId}" />
			</c:import>	
			<% out.flush(); %>
		</div>	
		<script type="text/javascript">dojo.addOnLoad(function() { 
			parseWidget("SubCategoryDisplay_Widget");
		});</script>	
		</c:if>	  
			  
		<p class="space"></p>
		<div dojoType="wc.widget.RefreshArea" id="CategoryDisplay_Widget" controllerId="CategoryDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="additions">
			<% out.flush(); %>
			<flow:ifDisabled feature="SearchBasedNavigation">
				<c:import url="${jspStoreDir}Snippets/Catalog/CategoryDisplay/CategoryOnlyResultsDisplay.jsp">
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:param name="categoryId" value="${currentCategoryId}" />
				</c:import>
			</flow:ifDisabled>
			<flow:ifEnabled feature="SearchBasedNavigation">
				<c:import url="${jspStoreDir}ShoppingArea/CatalogSection/SearchSubsection/SearchBasedNavigationCategoryResultDisplay.jsp">
					<c:param name="langId" value="${langId}" />
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:param name="categoryId" value="${currentCategoryId}" />
				</c:import>
			</flow:ifEnabled>
			<% out.flush(); %>
		</div>
		<script type="text/javascript">dojo.addOnLoad(function() { 
		parseWidget("CategoryDisplay_Widget");
		categoryDisplayJS.processCategoryURL();
		});</script>	
		<%@ include file="CategoryDisplayExt.jspf"%>
		<flow:ifEnabled feature="IntelligentOffer">
			<%-- Begin - Added for Coremetrics Intelligent Offer to Display top seller dynamic recommendations for the currently viewed category--%>
			<%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/IntelligentOfferESpot.jsp">
				<c:param name="emsName" value="CategoryPageIntelligentOffer" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="parentCategoryId" value="${currentCategoryId}" />
			</c:import>
			<%out.flush();%>
			<%-- End - Added for Coremetrics Intelligent Offer --%>
		</flow:ifEnabled>
   </div>
</div>
	
  
			         						
<!-- END CategoryOnlyDisplay.jsp -->
