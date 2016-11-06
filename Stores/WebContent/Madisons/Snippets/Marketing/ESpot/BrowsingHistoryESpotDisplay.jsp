<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009, 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%--
  * This BrowsingHistoryESpotDisplay.jsp snippet displays a paginated list of recently viewed catalog entries in an e-Marketing Spot
  * on a store page. The snippet is formatted to display in the My Account area of the store, across the full width of a store 
	* page (excluding the navigation area in the left sidebar). The snippet supports controls that customers can use to display
	* the catalog entries as:
  * 	 A grid view
  * 	 A list view
  *
  * Use this version of the sample snippet for e-Marketing Spots that use the marketing tool
  * supplied with Management Center. For e-Marketing Spots that use the marketing tool
  * supplied with WebSphere Commerce Accelerator, use the snippet called eMarketingSpotDisplay.jsp.
  *
  * The code in this e-Marketing Spot .jsp file supports the display of the following types of data:
  *	- Catalog entries (specified in Web activities and through merchandising associations)
  *
  * Prerequisites:
  * 	This code requires the following two parameters:
  *		- emsName
  *		  This .jsp file can be reused in different store pages by including it and assigning
  * 	          a unique value for the emsName parameter. This value should match exactly with an
  *               eMarketingSpot name that is defined in the Management Center when creating a new
  *               eMarketingSpot.
  *		- catalogId
  *		  The catalogId parameter needs to be passed because it is required to build the proper URLs.
  *
  *   This code supports the following optional parameters:
  *   - numberProductsToDisplay
  *     The maximum number of catalog entries that can be displayed in the e-Marketing Spot at the same time.
  *		- useFullURL
  *			Tells the page to use full paths when retrieving images, static assets, etc. This flag must be set
  *			to true if using this JSP in an email.
  *		- clickInfoURL
  *			This is the clickInfoURL that should be used instead.
	*		- requestURI
  *			When an area on the page that imports ContentAreaESpot.jsp is refreshed through an AJAX call, the standard requestURI parameter that is often required to set DM_ReqCmd in order to retrieve marketing data may be missing in the request.
  *			In this case, WCParam.requestURI can be used to substitute the default requestURI parameter in retrieving the data.  
  *	  - pageView
  *  		The view that is selected for displaying the catalog entries.
  *
  * How to use this snippet:
  *	This is an example of how this file can be included in a page:
  *		<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/BrowsingHistoryESpotDisplay.jsp">
  *			<c:param name="emsName" value="ShoppingCartPage" />
  *			<c:param name="catalogId" value="${WCParam.catalogId}" />
  *		</c:import>
  *
  * This is another example including some of the optional parameters:
  *		<%out.flush();%>
  *		<c:import url="${jspStoreDir}include/ContentAreaESpot.jsp">
  *			<c:param name="emsName" value="HomePageRow1Ads" />
  *			<c:param name="catalogId" value="${WCParam.catalogId}" />
  *			<c:param name="numberProductsToDisplay" value="10" />
  *			<c:param name="pageView" value="image" />
  *		</c:import>
  *		<%out.flush();%>
  *
  * If the e-Marketing Spot name (emsName) contains special characters, they must be encoded to pass
  * successfully to this page through the request parameter. Use the following technique:
  *
  *   1. Before setting the emsName parameter in the import statement:
  * 	 request.setAttribute("emsName", java.net.URLEncoder.encode("ShoppingCartPage"));
  *
  *   2.To retrieve the emsName parameter from the request when setting the parameter in the import statement:
  *     <c:param name="emsName" value="${requestScope.emsName}"/>
  *
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
<% 
   /* Get the e-Marketing Spot name from the request parameters, and decode it in case it has been encoded. */
   String emsName = request.getParameter("emsName");
   if (emsName != null) {
   	emsName = java.net.URLDecoder.decode(emsName, "UTF-8");
	  request.setAttribute("emsName", emsName);
   }
   
   /* Set the values for the maximum number of data to display. This is used to create the appropriate     */
   /* key to find the e-Marketing Spot data created by the campaigns filter when using e-Marketing Spot    */
   /* JSP snippet caching. The snippet caching is configured in the EMarketingSpotInvocationList.xml file. */
   int displayProducts   = 20;
   
   String numberProductsToDisplayString = request.getParameter("numberProductsToDisplay");
   if (numberProductsToDisplayString != null) {
   	request.setAttribute("numberProductsToDisplay", numberProductsToDisplayString);
   	displayProducts = Integer.parseInt(numberProductsToDisplayString);
   }
   
   java.util.Hashtable emsHash = (java.util.Hashtable)request.getAttribute(com.ibm.commerce.marketing.beans.EMarketingSpot.EMS_REQUEST_ATTRIBUTE_CONTAINER_NAME);
   if (emsHash != null) {
      request.setAttribute("emsFromFilter", 
           emsHash.get(com.ibm.commerce.tools.campaigns.CampaignRuntimeUtil.generateEMarketingSpotInvocationKey(emsName, 20, displayProducts, 0, 0)));      
   }
   
   /* Set the name of the command that has called this page. */
   String pathInfo = (String)request.getAttribute("javax.servlet.forward.path_info");
   if (pathInfo != null && pathInfo.startsWith ("/")) {
      pathInfo = pathInfo.substring (1);
   }
   request.setAttribute("requestURI", pathInfo);
   
   /* Get the marketing context information if it has been configured in the businessContext.xml file. */
   request.setAttribute("marketingContext", com.ibm.commerce.foundation.server.services.businesscontext.ContextServiceFactory.getContextService().findContext(com.ibm.commerce.marketing.dialog.context.MarketingContext.CONTEXT_NAME));
   
%>   

  <%--
    *
    * Set up the variables required by the snippet.
    *
  --%>
<c:set var="requestURI"                value="${requestScope.requestURI}"/>
<c:set var="marketingContext"          value="${requestScope.marketingContext}"/>
<c:set var="emsFromFilter"             value="${requestScope.emsFromFilter}"/>
<c:set var="emsName"                   value="${requestScope.emsName}"/>
<c:set var="numberProductsToDisplay"   value="${requestScope.numberProductsToDisplay}"/>

 <%--
   *
   * Specify if a fully qualified URL or relative paths should be used for
   * image tags. A fully qualified URL is required for e-mail activity functionality.
   *
 --%>
<c:set var="prependFullURL">
	<c:out value="${param.useFullURL}" default="false" />
</c:set>

 <%--
   *
   * Set the ClickInfo command URL if the optional clickInfoURL parameter is provided; otherwise, use the
   * default value of the URL.
   *
 --%>
<c:set value="ClickInfo" var="clickInfoCommand" />
<c:set value="" var="clickOpenBrowser" />
<c:if test="${!empty param.clickInfoURL}">
	<c:set value="${param.clickInfoURL}" var="clickInfoCommand" />
	<c:set value='target="_blank"' var="clickOpenBrowser" />
</c:if>

 <%--
   *
   * Specify the host name of the URL that is used to point to the shared image directory.  
   * Use this variable to reference images.
   *
 --%>
<c:set var="hostPath" value="" />
<c:if test="${prependFullURL}">
	<c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}" var="hostPath" />
</c:if>

 <%--
   *
   * Create the e-Marketing Spot.
   *
 --%>
<c:choose>
	<%-- Check if we already have the data - it could have been populated in the campaigns filter when JSP snippet caching is configured --%>
	<c:when test="${emsFromFilter != null && emsFromFilter.name eq emsName}">
		<c:set var="marketingSpotDatas" value="${emsFromFilter.marketingSpotData}"/>
	</c:when>

   <%-- Call the web service to get the data to display in the e-Marketing Spot --%>
	<c:otherwise>
		<%-- Set up the information required for the web service call --%>
		<wcf:getData type="com.ibm.commerce.marketing.facade.datatypes.MarketingSpotDataType" var="marketingSpotDatas" expressionBuilder="findByMarketingSpotName">
		
			<%-- the name of the e-Marketing Spot --%>
			<wcf:param name="DM_EmsName" value="${emsName}" />
				
			<%-- do not retrieve the catalog entry SDO but obtain the catalog entry Id only --%>
			<wcf:param name="DM_ReturnCatalogEntryId" value="true" />				
							
			<c:if test="${numberProductsToDisplay != null}">
				<wcf:param name="DM_DisplayProducts"   value="${numberProductsToDisplay}" />
			</c:if>							
	
			<%-- url command name --%>
			<wcf:param name="DM_ReqCmd" value="${requestURI}" />
				
       		<%-- url name value pair parameters --%>					
			<c:forEach var="aParam" items="${WCParamValues}">
				<c:forEach var="aValue" items="${aParam.value}">
					<wcf:param name="${aParam.key}" value="${aValue}" />
				</c:forEach>
			</c:forEach>
		</wcf:getData>
	</c:otherwise>
</c:choose>
	
<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="numberProductsPerRow" value="5"/>

<c:set var="numEntries" value="0"/>
<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status">
	<c:if test='${marketingSpotData.dataType eq "CatalogEntryId"}'>
		<c:set var="numEntries" value="${status.count}"/>
	</c:if>
</c:forEach>

<c:set var="pageSize" value="${param.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="10" />
</c:if>

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

<c:if test="${pageView eq 'detailed'}">
	<c:set var="pageView" value="detailedMyAccount"/>
</c:if>

<wcf:url var="BrowsingHistoryDisplayView" value="AjaxBrowsingHistoryDisplay" type="Ajax">
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
	<wcf:param name="emsName" value="BrowsingHistory" />
</wcf:url>	

<c:if test="${numEntries > 0}">
	<div class="display_results" id="WC_BrowseHistoryDisplay_div_1">
		<span class="text">
			<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<fmt:param><fmt:formatNumber value="${startIndex}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
			</fmt:message>
			<c:if test="${totalPages > 1}">
				<span class="paging">
					<c:if test="${currentPage != 0}">
						<a href="javaScript:setCurrentId('WC_BrowsingHistoryDisplay_links_1'); MyAccountDisplay.showBrowsingHistoryView('<c:out value="${BrowsingHistoryDisplayView}"/>','<c:out value='${currentPage-1}'/>','<c:out value='${pageView}'/>');" id="WC_BrowsingHistoryDisplay_links_1">
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
						<a href="javaScript:setCurrentId('WC_BrowsingHistoryDisplay_links_2');  MyAccountDisplay.showBrowsingHistoryView('<c:out value="${BrowsingHistoryDisplayView}"/>','<c:out value='${currentPage+1}'/>','<c:out value='${pageView}'/>');" id="WC_BrowsingHistoryDisplay_links_2">
					</c:if>
						<img src="<c:out value="${jspStoreImgDir}${vfileColorBIDI}" />paging_next.png" alt="<fmt:message key="CATEGORY_PAGING_RIGHT_IMAGE" bundle="${storeText}"/>" />
					<c:if test="${currentPage < totalPages-1}">
						</a>
					</c:if>
				</span>
			</c:if>
		</span>
	</div>
	
	<div class="right" id="WC_BrowseHistoryDisplay_div_2">              
		<span class="views_icon">  
			<c:if test="${pageView !='image'}">		
				<a href="javaScript:setCurrentId('WC_BrowseHistoryDisplay_link_3'); MyAccountDisplay.showBrowsingHistoryView('<c:out value="${BrowsingHistoryDisplayView}"/>','<c:out value='${currentPage}'/>','image');" id="WC_BrowseHistoryDisplay_link_3">
					<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />grid_normal.png" alt="<fmt:message key="CATEGORY_IMAGE_VIEW" bundle="${storeText}"/>" />
				</a>
				 <img id="detailedTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}list_selected.png"/>" alt="<fmt:message key="FF_VIEWDETAILS" bundle="${storeText}"/>"/>	
			</c:if>
			<c:if test="${pageView !='detailedMyAccount'}">	
				<img id="imageTypeImageSelected" src="<c:out value="${jspStoreImgDir}${vfileColor}grid_selected.png"/>" alt="<fmt:message key="FF_VIEWICONS" bundle="${storeText}"/>"/>
				<a href="javaScript:setCurrentId('WC_BrowseHistoryDisplay_link_4'); MyAccountDisplay.showBrowsingHistoryView('<c:out value="${BrowsingHistoryDisplayView}"/>','<c:out value='${currentPage}'/>','detailedMyAccount');" id="WC_BrowseHistoryDisplay_link_4">
					<img src="<c:out value="${jspStoreImgDir}${vfileColor}" />list_normal.png" alt="<fmt:message key="CATEGORY_DETAILED_VIEW" bundle="${storeText}"/>" />
				</a>
			</c:if>
		</span>
	</div>
	
	<%--
	  *
	  * Start: Catalog Entries
	  * The following block is used to display the catalog entries associated with this e-Marketing Spot. The
	  * product display page that shows the selected catalog entry will be referenced
	  * through the submission of the HTML form in the calling .jsp file.
	  *
	--%>	
	<c:set var="currentProductCount" value="0" />
	<c:set var="headerDisplayed" value="false" />
	<c:set var="rowItemCount" value="0"/>
	<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status">
	
		<c:remove var="catEntry" />
		<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
		   <c:set property="catalogEntryID" value="${marketingSpotData.uniqueID}" target="${catEntry}" />
		</wcbase:useBean>		
		<%-- putting the catEntry in the request scope so that CatalogEntryThumbnailDisplay.jsp can use it --%>
		<c:set var="catEntry" value="${catEntry}" scope="request"/>
			
		<c:if test='${marketingSpotData.dataType eq "CatalogEntryId" && !catEntry.dynamicKit}'>
			<c:if test='${rowItemCount >= (startIndex-1) && rowItemCount < endIndex}'>
				<c:set var="prefix" value="BrowsingHistory"/>			
				<c:set var="catEntryIdentifier" value="${marketingSpotData.uniqueID}"/>
				<c:set var="useClickInfoURL" value="true"/>	

				<c:if test="${pageView == 'image'}">
					<c:choose>
						<c:when test="${rowItemCount%numberProductsPerRow == 0}">
							<div class="clear_both"></div>
							<c:if test="${rowItemCount != 0 }">
								<div class="divider"></div>
							</c:if>
							<div class="divider_line"></div>
							<div class="item_wrapper_grid_begin" id="WC_BrowseHistoryDisplay_div_3_<c:out value='${status.count}'/>">
						</c:when>		
						<c:otherwise>
							<div class="item_wrapper_grid" id="WC_BrowseHistoryDisplay_div_3_<c:out value='${status.count}'/>">
						</c:otherwise>	
					</c:choose>	
					<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryThumbnailDisplay.jsp">
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
								<c:param name="top_category" value="${top_category}"/>
								<c:param name="parent_category_rn" value="${parent_category_rn}"/>
					    			<c:param name="mpe_id" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
					    			<c:param name="intv_id" value="${marketingSpotData.activityIdentifier.uniqueID}" />
							    	<c:param name="experimentId" value="${marketingSpotData.experimentResult[0].experiment.uniqueID}" />
							    	<c:param name="testElementId" value="${marketingSpotData.experimentResult[0].testElement.uniqueID}" />
							    	<c:param name="expDataType" value="${marketingSpotData.dataType}" />
							   	<c:param name="absoluteUrl" value="${absoluteUrl}"/>
							   	<c:param name="clickInfoCommand" value="${clickInfoCommand}"/>									
						</c:import>
					<%out.flush();%>
					</div>	
				</c:if>
				<c:if test="${pageView == 'detailedMyAccount'}">	
					<div class="clear_both"></div>
					<div class="divider_line"></div>
					<div class="item_wrapper_list"  id="WC_BrowseHistoryDisplay_div_4_<c:out value='${status.count}'/>">
					<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryThumbnailDisplay.jsp">
								<c:param name="prefix" value="${prefix}"/>
								<c:param name="langId" value="${langId}" />						
								<c:param name="storeId" value="${WCParam.storeId}" />
								<c:param name="catalogId" value="${WCParam.catalogId}" />
								<c:param name="emsName" value="${emsName}" />
								<c:param name="skipAttachments" value="${param.skipAttachments}"/>
								<c:param name="pageView" value="${pageView}"/>
								<c:param name="catEntryIdentifier" value="${catEntryIdentifier}"/>
								<c:param name="useClickInfoURL" value="${useClickInfoURL}"/>
								<c:param name="categoryId" value="${WCParam.categoryId}"/>
								<c:param name="top_category" value="${WCParam.top_category}"/>
								<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
					    			<c:param name="mpe_id" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
					    			<c:param name="intv_id" value="${marketingSpotData.activityIdentifier.uniqueID}" />
								<c:param name="experimentId" value="${marketingSpotData.experimentResult[0].experiment.uniqueID}" />
							    	<c:param name="testElementId" value="${marketingSpotData.experimentResult[0].testElement.uniqueID}" />
							    	<c:param name="expDataType" value="${marketingSpotData.dataType}" />
							   	<c:param name="absoluteUrl" value="${absoluteUrl}"/>
							   	<c:param name="clickInfoCommand" value="${clickInfoCommand}"/>									
						</c:import>
					<%out.flush();%>
					</div>			
				</c:if>
				<c:remove var="useClickInfoURL"/>
				<c:remove var="catEntryDescription"/>
				<c:remove var="ClickInfoURL"/>
			</c:if>
			<c:set var="rowItemCount" value="${rowItemCount+1}"/>
		</c:if>
	</c:forEach>
	
	<div class="clear_both"></div>
	<div class="divider"></div>
	<div class="divider_line"></div>
	
	<div class="display_results" id="WC_BrowseHistoryDisplay_div_5">
		<span class="text">
			<fmt:message key="CATEGORY_RESULTS_DISPLAYING" bundle="${storeText}"> 
				<fmt:param><fmt:formatNumber value="${startIndex}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${endIndex}"/></fmt:param>
				<fmt:param><fmt:formatNumber value="${numEntries}"/></fmt:param>
			</fmt:message>
		</span>
	</div>
	
	<div class="clear_both"></div>
</c:if>

<c:if test="${numEntries == 0}">
	<div class="browsing_history_empty" id="WC_BrowseHistoryDisplay_div_6">
		<fmt:message key="BROWSING_HISTORY_EMPTY" bundle="${storeText}" />
	</div>
</c:if>