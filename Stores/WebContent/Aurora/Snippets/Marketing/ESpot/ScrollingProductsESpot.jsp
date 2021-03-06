<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%><%--
  * This ScrollingProductESpot.jsp file is built for displaying a scrolling e-Marketing Spot in the
  * store page. It uses Web services to call the Dialog Marketing runtime to get the data to display
  * in the e-Marketing Spot. 
  * 
  * Use this version of the sample snippet for e-Marketing Spots that use the marketing tool 
  * supplied with Management Center. For e-Marketing Spots that use the marketing tool 
  * supplied with WebSphere Commerce Accelerator, use the snippet called eMarketingSpotDisplay.jsp.
  * 
  * The code in this e-Marketing Spot .jsp file supports the display of the following types of data:
  *	- Catalog entries (specified in Web activities and through merchandising associations)
  * - Categories
  *
  * If you intend to display only one type of data in the e-Marketing Spot,
  * then you can remove the applicable sections of the code that will not be used.
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
  *   - numberCategoriesToDisplay
  *     The maximum number of categories that can be displayed in the e-Marketing Spot at the same time.
  *   - numberProductsToDisplay
  *     The maximum number of catalog entries that can be displayed in the e-Marketing Spot at the same time.
  *		- useFullURL
  *			Tells the page to use full paths when retrieving images, static assets, etc. This flag must be set
  *			to true if using this JSP in an email.
  *		- clickInfoURL
  *			This is the clickInfoURL that should be used instead.
  *		- scrollable
  *			This flag states whether to use a scrolling widget to show this ESpot or not. Defaults to false.
  *     - skipAttachments
  * 		The flag states whether to load the 40x40 image attachments for the catalog entries shown in this eMarketing Spot. These images are used
  * 		 for displaying the catalog entries in the compare zone. If this eMarketing Spot is not used in a page that has the compare zone then it is
  * 		 more efficient to set the skipAttachment flag to true to improve the load time of the page. 
  *	- skipCategories
  *		This flag states whether to display categories for this eMarketing Spot. Set this flag to true if categories should not
  * 		not be displayed. 
  *  
  * How to use this snippet:
  *	This is an example of how this file can be included in a page:
  *		<c:import url="${jspStoreDir}include/ScrollingProductESpot.jsp">
  *			<c:param name="emsName" value="ShoppingCartPage" />
  *			<c:param name="catalogId" value="${WCParam.catalogId}" />
  *		</c:import>
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
--%><%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- BEGIN ScrollingProductsESpot.jsp -->
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
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
   int displayCategories = 20;
   int displayProducts   = 20;
   int displayContent    = 20;
   
   String numberCategoriesToDisplayString = request.getParameter("numberCategoriesToDisplay");
   if (numberCategoriesToDisplayString != null) {
   	request.setAttribute("numberCategoriesToDisplay", numberCategoriesToDisplayString);
   	displayCategories = Integer.parseInt(numberCategoriesToDisplayString);
   }
   String numberProductsToDisplayString = request.getParameter("numberProductsToDisplay");
   if (numberProductsToDisplayString != null) {
   	request.setAttribute("numberProductsToDisplay", numberProductsToDisplayString);
   	displayProducts = Integer.parseInt(numberProductsToDisplayString);
   }
   
   java.util.Hashtable emsHash = (java.util.Hashtable)request.getAttribute(com.ibm.commerce.marketing.beans.EMarketingSpot.EMS_REQUEST_ATTRIBUTE_CONTAINER_NAME);
   if (emsHash != null) {
      request.setAttribute("emsFromFilter", 
           emsHash.get(com.ibm.commerce.tools.campaigns.CampaignRuntimeUtil.generateEMarketingSpotInvocationKey(emsName, 20, displayProducts, displayCategories, displayContent)));      
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
	<c:set var="numberCategoriesToDisplay" value="${requestScope.numberCategoriesToDisplay}"/>
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

  <c:set var="showProductCompareInQuickInfo">
	<c:out value="${param.showProductCompareInQuickInfo}" default='false' />
  </c:set>
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
								
				<%-- the maximum number of items to display --%>
				<c:if test="${numberCategoriesToDisplay != null}">
					<wcf:param name="DM_DisplayCategories" value="${numberCategoriesToDisplay}" />
				</c:if>
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
				
				<%-- Example of specifying the customer is viewing a particular product.
				     The marketing activity could then display merchandising associations
				     of this product.
				     
				<wcf:param name="productId" value="12345" />
				--%>
				<%-- Example of specifying the customer is viewing a set of product.
				     The marketing activity could then display merchandising associations
				     of these products.
				     
				<wcf:param name="productId" value="12345,67890,54321" />
				--%>
												
				<%-- Example of including a value from a specific cookie
				<wcf:param name="MYCOOKIE" value="${cookie.MYCOOKIE.value}" />
				--%>
				
				<%-- Example of including all cookies 
				<c:forEach var="cookieEntry" items="${cookie}">
					<wcf:param name="${cookieEntry.key}" value="${cookieEntry.value.value}" />					
				</c:forEach>
				--%>
	 	
				<%-- marketing context name value pair parameters, currently not used
				<c:forEach var="aPair" items="${marketingContext.nameValuePairs}">
					<wcf:param name="${aPair.key}" value="${aPair.value}" />
				</c:forEach>
				--%>

				<c:if test="${!empty param.previewReport}">
					<wcf:param name="DM_PreviewReport" value="${param.previewReport}"/>
				</c:if>	
				
			</wcf:getData>
		</c:otherwise>
	</c:choose>

<%@ include file="ESpotInfoPopupDisplay.jspf"%>

<c:set var="ShowHompageScrollableEspot" value='true'/>
<c:if test="${emsName eq 'HomePageFeaturedProducts' && (empty marketingSpotDatas.baseMarketingSpotActivityData || marketingSpotDatas.baseMarketingSpotActivityData eq null)}">
	<c:set var="ShowHompageScrollableEspot" value='false'/>
</c:if>

<c:set var="ShowBestSellersESpot" value='true'/>
<c:if test="${emsName eq 'BestSellingProducts' && (empty marketingSpotDatas.baseMarketingSpotActivityData)}">
	<c:set var="ShowBestSellersESpot" value='false'/>
</c:if>

<c:set var="ShowTopBrowsedESpot" value='true'/>
<c:if test="${emsName eq 'TopBrowsedProducts' && (empty marketingSpotDatas.baseMarketingSpotActivityData)}">
	<c:set var="ShowTopBrowsedESpot" value='false'/>
</c:if>

<div id="WC_ScrollingProductsESpot_<c:out value='${marketingSpotDatas.marketingSpotIdentifier.uniqueID}'/>_div_1">
<c:set var="checkCount" value='0'/>

<%--
  *
  * Start: Categories
  * The following block is used to display the categories associated with this e-Marketing Spot.
  * The category display page that shows the selected category will be referenced
  * through the submission of the HTML form in the calling .jsp file.
  *
--%>
<script type="text/javascript">
	dojo.addOnLoad(function() {
		if('${ShowHompageScrollableEspot}'=='false')
		{
			document.getElementById('HompageScrollableEspot').style.display = 'none';
		}
		if('${ShowBestSellersESpot}'=='false')
		{
			if(dojo.byId('WC_RankTab1') != null) dojo.byId('WC_RankTab1').style.visibility = 'hidden';
		}
		if('${ShowTopBrowsedESpot}'=='false')
		{
			if(dojo.byId('WC_RankTab2') != null) dojo.byId('WC_RankTab2').style.visibility = 'hidden';
		}
	});
</script>
<c:set var="isEmpty" value="true"/>
<div id="WC_ScrollingProductsESpot_<c:out value='${marketingSpotDatas.marketingSpotIdentifier.uniqueID}'/>_div_3">

	<c:if test="${param.skipCategories != 'true'}">
		<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status">
			<c:if test='${marketingSpotData.dataType eq "CatalogGroup"}'>
				<c:set var="checkCount" value='${checkCount+1}'/>
				<c:if test="${checkCount > 4}">
					<c:set var="checkCount" value='0'/>
					</div>
					<div id="WC_ScrollingProductsESpot_<c:out value='${marketingSpotDatas.marketingSpotIdentifier.uniqueID}'/>_div_4_<c:out value='${status.count}'/>">
				</c:if>
				<c:set value="${marketingSpotData.catalogGroup.description[0].name}" var="marketing_CategoryName" />
				<c:set value="${marketingSpotData.catalogGroup.description[0].thumbnail}" var="marketing_catalogGroupThumbNail" />
				<c:set value="${marketingSpotData.catalogGroup.description[0].shortDescription}" var="marketing_catalogGroupShortDescription" />
				
				<c:choose>	  
					<c:when test="${marketingSpotData.catalogGroup.topCatalogGroup}">
						<flow:ifDisabled feature="SearchBasedNavigation">
						<wcf:url value="Category5" var="TargetURL" patternName="CanonicalCategoryURL">
								<wcf:param name="catalogId" value="${param.catalogId}" />
								<wcf:param name="categoryId" value="${marketingSpotData.catalogGroup.catalogGroupIdentifier.uniqueID}" />
								<wcf:param name="storeId" value="${WCParam.storeId}" />
								<wcf:param name="langId" value="${langId}" />
								<wcf:param name="top" value="Y"/>
								<wcf:param name="top_category" value="${marketingSpotData.catalogGroup.catalogGroupIdentifier.uniqueID}"/>
								<wcf:param name="pageView" value="${defaultPageView}" />
								<wcf:param name="beginIndex" value="0" />
								<wcf:param name="urlLangId" value="${urlLangId}" />
							</wcf:url>
						</flow:ifDisabled>
						<flow:ifEnabled feature="SearchBasedNavigation">
							<wcf:url var="TargetURL" value="Category3" patternName="CanonicalCategoryURL">
							<wcf:param name="langId" value="${langId}" />
							<wcf:param name="storeId" value="${WCParam.storeId}" />
							<wcf:param name="catalogId" value="${param.catalogId}" />
							<wcf:param name="top" value="Y" />
							<wcf:param name="categoryId" value="${marketingSpotData.catalogGroup.catalogGroupIdentifier.uniqueID}" />
							<wcf:param name="pageView" value="${defaultPageView}" />
							<wcf:param name="beginIndex" value="0" />
							<wcf:param name="urlLangId" value="${urlLangId}" />
							</wcf:url>
						</flow:ifEnabled>
					</c:when>
					<c:otherwise>
						<flow:ifDisabled feature="SearchBasedNavigation">
							<wcf:url value="Category6" var="TargetURL" patternName="CanonicalCategoryURL">
								<wcf:param name="catalogId" value="${param.catalogId}" />
								<wcf:param name="categoryId" value="${marketingSpotData.catalogGroup.catalogGroupIdentifier.uniqueID}" />
								<wcf:param name="storeId" value="${WCParam.storeId}" />
								<wcf:param name="langId" value="${langId}" />
								<wcf:param name="pageView" value="${defaultPageView}" />
								<wcf:param name="beginIndex" value="0" />
								<wcf:param name="urlLangId" value="${urlLangId}" />
							</wcf:url>
						</flow:ifDisabled>
						<flow:ifEnabled feature="SearchBasedNavigation">
							<wcf:url var="TargetURL" patternName="SearchCategoryURL" value="SearchDisplay">
								<wcf:param name="langId" value="${langId}"/>
								<wcf:param name="storeId" value="${WCParam.storeId}"/>
								<wcf:param name="catalogId" value="${param.catalogId}"/>
								<wcf:param name="pageView" value="${defaultPageView}"/>
								<wcf:param name="beginIndex" value="0"/>
								<wcf:param name="sType" value="SimpleSearch"/>
								<wcf:param name="showResultsPage" value="true"/>
								<wcf:param name="categoryId" value="${marketingSpotData.catalogGroup.catalogGroupIdentifier.uniqueID}" />
								<wcf:param name="urlLangId" value="${urlLangId}" />
							</wcf:url> 
						</flow:ifEnabled>
					</c:otherwise>
				</c:choose>
				<c:url value="${clickInfoCommand}" var="ClickInfoURL">
					<c:param name="evtype" value="CpgnClick" />
					<c:param name="mpe_id" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
					<c:param name="intv_id" value="${marketingSpotData.activityIdentifier.uniqueID}" />
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${param.catalogId}" />
					<c:param name="langId" value="${langId}" />
				  <c:forEach var="expResult" items="${marketingSpotData.experimentResult}" begin="0" end="0">					    
						<c:param name="experimentId" value="${expResult.experiment.uniqueID}" />
						<c:param name="testElementId" value="${expResult.testElement.uniqueID}" />
						<c:param name="expDataType" value="${marketingSpotData.dataType}" />
						<c:param name="expDataUniqueID" value="${marketingSpotData.uniqueID}" />
					</c:forEach>
					<c:param name="URL" value="${TargetURL}" />
				</c:url>
				<%-- Coremetrics tag --%>
				<flow:ifEnabled feature="Analytics">
	
				       <cm:campurl espotData="${marketingSpotDatas}" id="ClickInfoURL" url="${ClickInfoURL}" 
						 initiative="${marketingSpotData.activityIdentifier.uniqueID}" 
						 name="${marketingSpotData.catalogGroup.description[0].name}"/>
	
				    </flow:ifEnabled>
				    <%-- Coremetrics tag --%>
				<c:forEach var="attribute" items="${marketingSpotData.catalogGroup.attributes}">	
					<c:if test='${attribute.key eq "rootDirectory"}'>				    
						<c:set var="imageFilePath" value="${staticAssetContextRoot}/${attribute.value}/" />
					</c:if>		
				</c:forEach>
				
				<c:choose>
					<c:when test="${param.scrollable == true}">
						<div dojoType="dijit.layout.ContentPane" style="float:left;" id="WC_ScrollingProductsESpot_<c:out value='${marketingSpotDatas.marketingSpotIdentifier.uniqueID}'/>_div_5_<c:out value='${status.count}'/>">
							<c:choose>				   
								<c:when test="${!empty marketing_catalogGroupThumbNail}">
									<a href="<c:out value="${absoluteUrl}${ClickInfoURL}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>">
										<img src="<c:out value="${hostPath}${imageFilePath}${marketing_catalogGroupThumbNail}"/>" alt="<c:out value="${marketing_catalogGroupShortDescription}" />" border="0"/>
									</a>
								</c:when>
								<c:otherwise>
									<a href="<c:out value="${absoluteUrl}${ClickInfoURL}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>">
										<img src="<c:out value="${hostPath}"/><c:out value="${jspStoreImgDir}" />images/NoImageIcon.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/>
									</a>
								</c:otherwise>
							</c:choose>
						</div>
						<script type="text/javascript">
						dojo.addOnLoad(function() { 
							var widgetText = "WC_ScrollingProductsESpot_<c:out value='${marketingSpotDatas.marketingSpotIdentifier.uniqueID}'/>_div_5_" + "<c:out value="${status.count}"/>";
							parseWidget(widgetText);
						});
						</script>
					</c:when>
					<c:otherwise>
						<div class="link" id="WC_ScrollingProductsESpot_<c:out value='${marketingSpotDatas.marketingSpotIdentifier.uniqueID}'/>_div_6_<c:out value='${status.count}'/>"><img src="${jspStoreImgDir}${vfileColor}/bullet_arrow.png" alt="<fmt:message key="No_Image" bundle="${storeText}"/>"/>
							<a href="<c:out value="${absoluteUrl}${ClickInfoURL}" escapeXml="false"/>" id="img<c:out value="${catEntryIdentifier}"/>">
								<c:out value="${marketing_CategoryName}" />
							</a>
						</div>
					</c:otherwise>
				</c:choose>
				<c:set var="isEmpty" value="false"/>
			</c:if>
		</c:forEach>
		<%--
		  *
		  * End: Categories
		  *
		--%> 
	</c:if>
	

<%--
  *
  * Start: Catalog Entries
  * The following block is used to display the catalog entries associated with this e-Marketing Spot. The
  * product display page that shows the selected catalog entry will be referenced
  * through the submission of the HTML form in the calling .jsp file.
  *
--%>
	<flow:ifEnabled feature="SearchBasedNavigation">
	
		<c:set var="catentryIdList" value=""/>
		<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}">
			<c:if test='${marketingSpotData.dataType eq "CatalogEntryId"}'>
				<c:if test="${!empty marketingSpotData.uniqueID}">
					<c:set var="catentryIdList" value="${catentryIdList}, ${marketingSpotData.uniqueID}"/>
				</c:if>
			</c:if>
		</c:forEach>
	
		<c:if test="${!empty catentryIdList}">
			<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
				expressionBuilder="getCatalogEntrySearchResultsByIDView" scope="request" varShowVerb="showCatalogNavigationView" 
				maxItems="100" recordSetStartNumber="0" scope="request">
				<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}">
					<c:if test='${marketingSpotData.dataType eq "CatalogEntryId"}'>
						<wcf:param name="UniqueID" value="${marketingSpotData.uniqueID}"/>
					</c:if>
				</c:forEach>
				<wcf:contextData name="storeId" data="${WCParam.storeId}" />
				<wcf:contextData name="catalogId" data="${WCParam.catalogId}" />
			</wcf:getData>
			<c:set var="eSpotCatalogIdResults" value="${catalogNavigationView.catalogEntryView}"/>
		</c:if>
		
	</flow:ifEnabled>
	
	
	<c:set var="clickInfoURLForAnalytics" value="${clickInfoCommand}" />
	<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status" >
		<c:if test='${marketingSpotData.dataType eq "CatalogEntryId"}'>
			
			<c:set var="checkCount" value='${checkCount+1}'/>
			<c:if test="${checkCount > 4}">
				<c:set var="checkCount" value='0'/>
				</div>
				<div id="WC_ScrollingProductsESpot_<c:out value='${marketingSpotDatas.marketingSpotIdentifier.uniqueID}'/>_div_7_<c:out value='${status.count}'/>">
			</c:if>

		  <c:set var="catEntryIdentifier" value="${marketingSpotData.uniqueID}"/>
			<c:remove var="catEntry" />
			<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
			    <c:set property="catalogEntryID" value="${catEntryIdentifier}" target="${catEntry}" />
			</wcbase:useBean>	
			<%-- putting the catEntry in the request scope so that CatalogEntryThumbnailDisplay.jsp can use it --%>
			<c:set var="catEntry" value="${catEntry}" scope="request"/>

				<c:if test="${param.scrollable == true}">
					<c:set var="skipAttachments" value="${param.skipAttachments}"/> <%-- do not load attachments --%>
					<c:set var="prefix" value="scrollESpot"/>			
					<c:choose>
						<c:when test="${!empty param.pageView}">
							<c:set var="pageView" value="${param.pageView}"/>
						</c:when>
						<c:otherwise>
							<c:set var="pageView" value="scrollESpot"/>
						</c:otherwise>
					</c:choose>				
					<c:set var="useClickInfoURL" value="true"/>
					
				    <%-- Coremetrics tag --%>
					<flow:ifEnabled feature="Analytics">
						<cm:campurl espotData="${marketingSpotDatas}" id="clickInfoCommand" url="${clickInfoURLForAnalytics}" 
					 		initiative="${marketingSpotData.activityIdentifier.uniqueID}" 
					 		name="${catEntry.description.name}" />
					</flow:ifEnabled>
				    <%-- Coremetrics tag --%>					

					<c:if test="${(catEntry.dynamicKit && showDynamicKit) || !catEntry.dynamicKit}">
					<div dojoType="dijit.layout.ContentPane" class="imgContainer" id="WC_ScrollingProductsESpot_<c:out value='${marketingSpotDatas.marketingSpotIdentifier.uniqueID}'/>_div_8_<c:out value='${status.count}'/>">
					<flow:ifDisabled feature="SearchBasedNavigation">
						<%out.flush();%>
						<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryThumbnailDisplay.jsp">
								<c:param name="langId" value="${langId}" />	
								<c:param name="prefix" value="${prefix}"/>  					
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
						   		<c:param name="statusCount" value="${status.count}"/>
								<c:param name="showProductCompareInQuickInfo" value="${showProductCompareInQuickInfo}"/>
						</c:import>
						<%out.flush();%>
					</flow:ifDisabled>
					<flow:ifEnabled feature="SearchBasedNavigation">
						<%@ include file="../../Search/SearchESpotSetup.jspf"%>
					</flow:ifEnabled>
					</div>
					</c:if>
				    	
					<c:remove var="catEntryDescription"/>
					<c:remove var="ClickInfoURL"/>					
					<c:remove var="useClickInfoURL"/>
					<c:remove var="skipAttachments"/>
					<script type="text/javascript">
					dojo.addOnLoad(function() { 
						var widgetText = "WC_ScrollingProductsESpot_<c:out value='${marketingSpotDatas.marketingSpotIdentifier.uniqueID}'/>_div_8_" + "<c:out value="${status.count}"/>";
						parseWidget(widgetText);
					});
					</script>
			</c:if>
			<c:set var="isEmpty" value="false"/>
		</c:if>
	</c:forEach>
	
<%--
  *
  * End: CatalogEntries
  *
--%>	
</div>

</div>
<c:if test="${param.pageView eq 'scrollSideBarESpot' && isEmpty eq 'true'}">
	<div id="WC_ScrollingProductsESpot_EmptyImgContainer_<c:out value="${emsName}"/>" class="imgContainer" dojotype="dijit.layout.ContentPane"></div>
</c:if>
<!-- END ScrollingProductsESpot.jsp -->
