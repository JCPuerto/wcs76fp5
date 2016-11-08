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
  * This ContentAreaESpot.jsp file is built for displaying an e-Marketing Spot in the main content of the
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
  *	- Content (also known as ad copy or collateral)
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
  *   - numberContentToDisplay
  *     The maximum number of content that can be displayed in the e-Marketing Spot at the same time.
  *		- useFullURL
  *			Tells the page to use full paths when retrieving images, static assets, etc. This flag must be set
  *			to true if using this JSP in an email.
  *		- clickInfoURL
  *			This is the clickInfoURL that should be used instead.
  *		- adclass
  *			If specified, this is the CSS class name that is used for the DIV that displays the "Content" advertisement.
  *				Otherwise it displays the "Content" advertisement within a P tag.
  *		- adWidth
  *			If specified, this is the width set for the "Content" advertisement image tag.
  *		- adHeight
  *			If specified, this is the height set for the "Content" advertisement image tag.
  *		- espotTitle
  *			If specified then the string will be used as the section header for the ESpot if catalog entries are being displayed.
  *				Otherwise, it will show "Featured products" as the section header.
  *		- isCategorySubsriptionDisplayURL
  *			A Boolean value that indicates if the content e-marketing spot should be rendered specifically for the category subscription link on the page.
  *		- requestURI
  *			When an area on the page that imports ContentAreaESpot.jsp is refreshed through an AJAX call, the standard requestURI parameter that is often required to set DM_ReqCmd in order to retrieve marketing data may be missing in the request.
  *			In this case, WCParam.requestURI can be used to substitute the default requestURI parameter in retrieving the data.  
  * 
  *   This code supports the following optional parameters for substituting variables in marketing content:
  *   - substitutionName1, substitutionValue1
  *     The name and value of a variable to replace in marketing content text.
  *   - substitutionName2, substitutionValue2
  *     The name and value of a variable to replace in marketing content text.
  *
  *   This code supports the following two optional parameters:
  *   - errorViewName
  *     The URL to call if there is an error or exception when clicking on a content link in the e-Marketing Spot snippet.
  *   - orderId
  *     The ID of the current order of the customer to include when calling the errorViewName URL.
  *
  *   This code supports the following two optional parameters for remote widgets support (Feature Pack 1 only):
  *   - showWidget
  *     Creates a "Get Widget" button below the E-Spot.  This button will allow business users to retrieve the E-Spot 
  *              as a widget for social networking sites.
  *   - showFeed
  *         Creates a feed button below the E-Spot.  This button will allow business users to retrieve the Atom feed for
  *              the E-Spot.
  *   - feedURL
  *			If showWidget or showFeed is true then you must send the e-spots feed URL.
  * 
  *   If showWidget is enabled then sidebarWidgetId and bannerWidgetId attributes must be defined.  Get the sidebar widget ID and banner widget ID
  *   from the Kick Apps account app studio.  Also the Kick Apps color layers and feed layer can be optionally set here as well, the default
  *   names are 'background' for color and 'feed_list' for feed (Feature Pack 1 only):
  *   - sidebarWidgetId
  *						Kick Apps id for this widget in sidebar mode.
  *   - bannerWidgetId
  *						Kick Apps id for this widget in banner mode.
  *   - sidebarColors
  *						Kick Apps layer name to apply sidebar color changes to, default is 'background'.
  *   - bannerColors
  *     			Kick Apps layer name to apply banner color changes to, default is 'background'.
  *   - feedLayer
  *     			Kick Apps layer name used for feed URL, default is 'feed_list'.
  *
  * How to use this snippet:
  *	This is an example of how this file can be included in a page:
  *		<c:import url="${jspStoreDir}include/ContentAreaESpot.jsp">
  *			<c:param name="emsName" value="ShoppingCartPage" />
  *			<c:param name="catalogId" value="${WCParam.catalogId}" />
  *		</c:import>
  *
  * This is another example including some of the optional parameters:
  *		<%out.flush();%>
  *		<c:import url="${jspStoreDir}include/ContentAreaESpot.jsp">
  *			<c:param name="emsName" value="HomePageRow1Ads" />
  *			<c:param name="catalogId" value="${WCParam.catalogId}" />
  *			<c:param name="numberContentToDisplay" value="1" />
  *			<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
  *			<c:param name="substitutionName1" value="[storeName]" />
  *		  	<c:param name="substitutionValue1" value="Madisons" />
  *			<c:param name="showWidget" value="true" />
  *			<c:param name="showFeed" value="true" />
  *			<c:param name="feedURL" value="${hostPath}/${restURI}/stores/${WCParam.storeId}/GiftList/${selectedWishListId}?responseFormat=atom&langId=${langId}" />
  *			<c:param name="sidebarWidgetId" value="325227" />
  *			<c:param name="bannerWidgetId" value="328127" />  
  *			<c:param name="sidebarColors" value="sidebar-color-layer" />  
  *			<c:param name="bannerColors" value="banner-color-layer" />  
  *			<c:param name="feedLayer" value="feed-layer" />  
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

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- BEGIN ContentAreaESpot.jsp -->
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
   String numberContentToDisplayString = request.getParameter("numberContentToDisplay");
   if (numberContentToDisplayString != null) {
   	request.setAttribute("numberContentToDisplay", numberContentToDisplayString);
   	displayContent = Integer.parseInt(numberContentToDisplayString);
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

<c:set var="contentAreaESpot" value="true" />
<c:set var="search" value=" "/>
<c:set var="replaceStr" value=""/>

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
<c:set var="numberContentToDisplay"    value="${requestScope.numberContentToDisplay}"/>
<c:set var="myAccountPage"               value="${requestScope.myAccountPage}"/>

<c:set var="numberCategoriesPerRow">
    <c:out value="${param.numberCategoriesPerRow}" default="4" />
</c:set>

<c:set var="numberProductsPerRow">
    <c:out value="${param.numberProductsPerRow}" default="4" />
</c:set>

<c:set var="numberContentPerRow">
    <c:out value="${param.numberContentPerRow}" default="1" />
</c:set>

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
            <%-- the maximum number of items to display --%>
            <c:if test="${numberCategoriesToDisplay != null}">
                <wcf:param name="DM_DisplayCategories" value="${numberCategoriesToDisplay}" />
            </c:if>
            <c:if test="${numberProductsToDisplay != null}">
                <wcf:param name="DM_DisplayProducts"   value="${numberProductsToDisplay}" />
            </c:if>
            <c:if test="${numberContentToDisplay != null}">
                <wcf:param name="DM_DisplayContent"    value="${numberContentToDisplay}" />
            </c:if>

            <%-- url command name --%>
            <c:choose>
                <c:when test="${WCParam.isCategorySubsriptionDisplayURL eq true && !empty WCParam.requestURI}"}>
                    <wcf:param name="DM_ReqCmd" value="${WCParam.requestURI}" />
                </c:when>
                <c:otherwise>
                    <wcf:param name="DM_ReqCmd" value="${requestURI}" />
                </c:otherwise>
            </c:choose>

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

            <%-- Example of including substitution variables. These variables will be replaced
                 in the Marketing Content marketing text string. For example, if the marketing
                 text is: "Marketing text [parameterName1],[parameterName2]"
                 then it will be changed to: "Marketing text parameterValue1,parameterValue2"

                <wcf:param name="DM_SubstitutionName1" value="[parameterName1]" />
                <wcf:param name="DM_SubstitutionValue1" value="parameterValue1" />
                <wcf:param name="DM_SubstitutionName2" value="[parameterName2]" />
                <wcf:param name="DM_SubstitutionValue2" value="parameterValue2" />
            --%>
            <c:if test="${!empty param.substitutionName1 && !empty param.substitutionValue1}">
                <wcf:param name="DM_SubstitutionName1" value="${param.substitutionName1}" />
                <wcf:param name="DM_SubstitutionValue1" value="${param.substitutionValue1}" />
            </c:if>
            <c:if test="${!empty param.substitutionName2 && !empty param.substitutionValue2}">
                <wcf:param name="DM_SubstitutionName2" value="${param.substitutionName2}" />
                <wcf:param name="DM_SubstitutionValue2" value="${param.substitutionValue2}" />
            </c:if>

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


<c:set var="numCategories" value="0"/>
<c:set var="numCatalogEntries" value="0"/>
<c:set var="numContent" value="0"/>
<c:set var="WC_ContentAreaESpot_div_1_ID" value="WC_ContentAreaESpot_div_1_${marketingSpotDatas.marketingSpotIdentifier.uniqueID}"/>
<c:set var="WC_ContentAreaESpot_div_2_ID" value="WC_ContentAreaESpot_div_2_${marketingSpotDatas.marketingSpotIdentifier.uniqueID}"/>
<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}">
    <c:choose>
        <c:when test='${marketingSpotData.dataType eq "CatalogGroup"}'>
            <c:set var="numCategories" value="${numCategories + 1}"/>
        </c:when>
	<c:when test='${marketingSpotData.dataType eq "CatalogEntryId"}'>
            <c:set var="numCatalogEntries" value="${numCatalogEntries + 1}"/>
        </c:when>
        <c:when test='${marketingSpotData.dataType eq "MarketingContent"}'>
            <c:set var="numContent" value="${numContent + 1}"/>
        </c:when>
    </c:choose>
</c:forEach>


<%-- Example of the marketing content being the name of a JSP to include - this is useful in JSP experiments
  <c:choose>
    <c:when test="${!empty marketingSpotDatas.baseMarketingSpotActivityData}">
      <c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}">
        <c:if test='${marketingSpotData.dataType eq "MarketingContent"}'>
          <c:import url="${marketingSpotData.marketingContent.url}" />
        </c:if>
      </c:forEach>
    </c:when>
    <c:otherwise>
      <c:import url="DefaultPageName.jsp" />
    </c:otherwise>
  </c:choose>
--%>


<%@ include file="../../../Snippets/Marketing/ESpot/ESpotInfoPopupDisplay.jspf"%>

<div class="genericESpot" id="${fn:replace(WC_ContentAreaESpot_div_1_ID, search, replaceStr)}">
    <div class="caption" style="display:none" id="${fn:replace(WC_ContentAreaESpot_div_2_ID, search, replaceStr)}">[<c:out value="${emsName}"/>]</div>
    <div class="ESpotInfo" id="WC_ContentAreaESpotInfo_<c:out value='${marketingSpotDatas.marketingSpotIdentifier.uniqueID}'/>"><a href="#" onclick="showESpotInfoPopup('ESpotInfo_popup_<c:out value="${emsName}"/>'); return false;"><div class="ESpotInfoIcon"></div></a></div>
<%--
  *
  * Start: Categories
  * The following block is used to display the categories associated with this e-Marketing Spot.
  * The category display page that shows the selected category will be referenced
  * through the submission of the HTML form in the calling .jsp file.
  *
--%>
<c:if test="${param.widgetIconStyle == 'top' && (param.showWidget == 'true' || param.showFeed == 'true') && numCategories != 0}">
    <%out.flush();%>
    <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/RemoteWidgetButtons.jsp">
        <c:param name="showWidget" value="${param.showWidget}" />
        <c:param name="showFeed" value="${param.showFeed}" />
        <c:param name="widgetIconStyle" value="${param.widgetIconStyle}" />
        <c:param name="sidebarWidgetId" value="${param.sidebarWidgetId}" />
        <c:param name="sidebarColors" value="${param.sidebarColors}" />
        <c:param name="bannerWidgetId" value="${param.bannerWidgetId}" />        
        <c:param name="bannerColors" value="${param.bannerColors}" />
        <c:param name="feedURL" value="${param.feedURL}" />
        <c:param name="feedLayer" value="${param.feedLayer}" />
        <c:param name="emsId" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
    </c:import>
    <%out.flush();%>    
</c:if>

<c:set var="currentRowCount" value="0" />

<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status2">
    <c:if test='${marketingSpotData.dataType eq "CatalogGroup"}'>
        <%--
           *
           * Set up the URL to call when clicking on the image.
           *
        --%>
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

        <c:forEach var="attribute" items="${marketingSpotData.catalogGroup.attributes}">
            <c:if test='${attribute.key eq "rootDirectory"}'>
                <c:set var="imageFilePath" value="${staticAssetContextRoot}/${attribute.value}/" />
            </c:if>
        </c:forEach>

        <c:set value="${marketingSpotData.catalogGroup.description[0].thumbnail}" var="marketing_catalogGroupThumbNail" />
        <c:set value="${marketingSpotData.catalogGroup.description[0].fullImage}" var="marketing_catalogGroupFullImage" />
        <c:set value="${marketingSpotData.catalogGroup.description[0].shortDescription}" var="marketing_catalogGroupShortDescription" />
        <c:set value="${marketingSpotData.catalogGroup.description[0].name}" var="marketing_CategoryName" />

        <c:choose>
            <c:when test="${!empty marketing_catalogGroupThumbNail}">
                <c:set value="${marketing_catalogGroupThumbNail}" var="marketing_catalogGroupImage" />
            </c:when>
            <c:otherwise>
                <c:set value="${marketing_catalogGroupFullImage}" var="marketing_catalogGroupImage" />
            </c:otherwise>
        </c:choose>

        <c:set var="currentRowCount" value="${currentRowCount+1}" />

        <c:choose>
            <c:when test="${numberCategoriesPerRow == 4}">
                <c:set value="title" var="categoryname_class" />
            </c:when>
            <c:otherwise>
                <c:set value="" var="categoryname_class" />
            </c:otherwise>
        </c:choose>

        <c:if test="${currentRowCount % numberCategoriesPerRow == 1}">
            <div class="ad" id="ad_CategoriesAssociated">
        </c:if>

        <c:choose>
            <c:when test="${currentRowCount % numberCategoriesPerRow == 1 && numberCategoriesPerRow == 4}">
                <div class="ad_space_1" id="WC_ContentAreaESpot_div_3_<c:out value='${status2.count}'/>"><img src="<c:out value="${hostPath}${jspStoreImgDir}" />images/trasparent.gif" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/></div>
            </c:when>
            <c:when test="${currentRowCount % numberCategoriesPerRow == 1 && numberCategoriesPerRow == 3}">
            </c:when>
            <c:otherwise>
                <div class="ad_space_3" id="WC_ContentAreaESpot_div_4_<c:out value='${status2.count}'/>"><img src="<c:out value="${hostPath}${jspStoreImgDir}" />images/trasparent.gif" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/></div>
            </c:otherwise>
        </c:choose>

        <div class="ad_product" id="WC_ContentAreaESpot_div_5_<c:out value='${status2.count}'/>">
            <div id="WC_ContentAreaESpot_div_6_<c:out value='${status2.count}'/>">
            
        <c:choose>
            <c:when test="${!empty marketing_catalogGroupImage}">
                <div class="img_align" id="WC_ContentAreaESpot_div_6_<c:out value='${status2.count}'/>_1">
                    <a id="WC_ContentAreaESpot_links_1_<c:out value='${status2.count}'/>" href="<c:out value="${absoluteUrl}${ClickInfoURL}"/>">
                         <img src="<c:out value="${hostPath}${imageFilePath}${marketing_catalogGroupImage}"/>" alt="<c:out value="${marketing_catalogGroupShortDescription}" />" border="0" />
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <a id="WC_ContentAreaESpot_links_2_<c:out value='${status2.count}'/>" href="<c:out value="${absoluteUrl}${ClickInfoURL}"/>">
                    <img src="<c:out value="${hostPath}${jspStoreImgDir}" />images/NoImageIcon.jpg" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/>
                </a>
            </c:otherwise>
        </c:choose>

            </div>
        <c:set value="ad_content" var="contentClass" />
        <c:if test="${numCategories == 2}">
        	<c:set value="ad_content2" var="contentClass" />
        </c:if>
        <div class="<c:out value="${contentClass}"/><c:out value="${categoryname_class}"/>" id="WC_ContentAreaESpot_div_7_<c:out value='${status2.count}'/>">

        <c:choose>
            <c:when test="${!empty categoryname_class}">
                <p class="<c:out value="${categoryname_class}"/>"><c:out value="${marketing_CategoryName}"/></p>
            </c:when>
            <c:otherwise>
                <p><c:out value="${marketing_CategoryName}"/></p>
            </c:otherwise>
        </c:choose>

        </div>

        <c:choose>
            <c:when test="${numberCategoriesPerRow == 4}">
                <div id="WC_ContentAreaESpot_div_8_<c:out value='${status2.count}'/>"><img src="<c:out value="${hostPath}${jspStoreImgDir}${vfileColor}" />ad_box_footer_small.png" alt="" /></div>
            </c:when>
            <c:otherwise>
            		<c:set value="ad_box_footer" var="footerImageName" />
				        <c:if test="${numCategories == 2}">
				        	<c:set value="ad_box_footer_big" var="footerImageName" />
				        </c:if>
                <div id="WC_ContentAreaESpot_div_9_<c:out value='${status2.count}'/>"><img src="<c:out value="${hostPath}${jspStoreImgDir}${vfileColor}" /><c:out value="${footerImageName}"/>.png" alt=""/></div>
            </c:otherwise>
        </c:choose>

        </div>

        <c:if test="${currentRowCount%numberCategoriesPerRow == 0}">
            <c:set var="currentRowCount" value="0" />
                <br clear="left" />
            </div>
        </c:if>
        
    </c:if>
</c:forEach>

<c:if test="${currentRowCount != 0}">
        <br clear="left" />
    </div>
</c:if>

<c:if test="${param.widgetIconStyle != 'top' && (param.showWidget == 'true' || param.showFeed == 'true') && numCategories != 0 && numCatalogEntries == 0 && numContent == 0}">
    <%out.flush();%>
    <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/RemoteWidgetButtons.jsp">
        <c:param name="showWidget" value="${param.showWidget}" />
        <c:param name="showFeed" value="${param.showFeed}" />
        <c:param name="widgetIconStyle" value="${param.widgetIconStyle}" />
        <c:param name="sidebarWidgetId" value="${param.sidebarWidgetId}" />
        <c:param name="sidebarColors" value="${param.sidebarColors}" />
        <c:param name="bannerWidgetId" value="${param.bannerWidgetId}" />
        <c:param name="bannerColors" value="${param.bannerColors}" />
        <c:param name="feedURL" value="${param.feedURL}" />
        <c:param name="feedLayer" value="${param.feedLayer}" />
        <c:param name="emsId" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
    </c:import>
    <%out.flush();%>    
</c:if>

<%--
  *
  * End: Categories
  *
--%>




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

<c:set var="currentRowCount" value="0" />
<c:set var="headerDisplayed" value="false" />
<c:set var="rowBeginIndex" value="0"/>
<c:set var="catEntryCount" value="0"/>

<c:set var="clickInfoURLForAnalytics" value="${clickInfoCommand}" />
<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status">
		<c:if test='${marketingSpotData.dataType eq "CatalogEntryId"}'>
    
        <c:set var="catEntryCount" value="${catEntryCount + 1}"/>
        
        <c:if test="${currentRowCount == 0 && !headerDisplayed}">
        
            <c:set var="rowBeginIndex" value="${status.index}"/>

            <div class="contentgrad_header" id="WC_ContentAreaESpot_div_10_<c:out value='${status.count}'/>">
                 <div class="left_corner" id="WC_ContentAreaESpot_div_11_<c:out value='${status.count}'/>"></div>

						<c:set var="keyString" value="${param.espotTitle}"/>
            <c:choose>
                <c:when test = "${!empty requestScope[keyString]}">
                    <div class="left" id="WC_ContentAreaESpot_div_12_<c:out value='${status.count}'/>"><span class="contentgrad_text" role="heading" aria-level="1"><c:out value="${requestScope[keyString]}"/></span></div>
                </c:when>
                <c:otherwise>
                    <div class="left" id="WC_ContentAreaESpot_div_13_<c:out value='${status.count}'/>"><span class="contentgrad_text" role="heading" aria-level="1"><fmt:message key="FEATURED_PRODUCTS" bundle="${storeText}" /></span></div>
                </c:otherwise>
            </c:choose>

                <div class="right_corner" id="WC_ContentAreaESpot_div_14_<c:out value='${status.count}'/>"></div>
                
                <c:if test="${param.widgetIconStyle == 'top' && (param.showWidget == 'true' || param.showFeed == 'true') && numCategories == 0 && numCatalogEntries != 0}">
                    <%out.flush();%>
                    <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/RemoteWidgetButtons.jsp">
                        <c:param name="showWidget" value="${param.showWidget}" />
                        <c:param name="showFeed" value="${param.showFeed}" />
                        <c:param name="widgetIconStyle" value="${param.widgetIconStyle}" />
                        <c:param name="sidebarWidgetId" value="${param.sidebarWidgetId}" />
                        <c:param name="sidebarColors" value="${param.sidebarColors}" />
                        <c:param name="bannerWidgetId" value="${param.bannerWidgetId}" />
                        <c:param name="bannerColors" value="${param.bannerColors}" />
                        <c:param name="feedURL" value="${param.feedURL}" />
                        <c:param name="feedLayer" value="${param.feedLayer}" />
                        <c:param name="emsId" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
                    </c:import>
                    <%out.flush();%>
                </c:if>
                
            </div>
            
            <div class="body588" id="WC_ContentAreaESpot_div_15_<c:out value='${status.count}'/>">
                <table id="four-grid-espot" cellpadding="0" cellspacing="0" border="0">
            
            <c:set var="headerDisplayed" value="true" />
        </c:if>

		<c:set var="prefix" value="featuredProduct"/>
		<c:set var="pageView" value="image"/>
		<c:set var="catEntryIdentifier" value="${marketingSpotData.uniqueID}"/>
		<c:set var="marketingSpotData2" value="${marketingSpotData}"/>
		<c:set var="useClickInfoURL" value="true"/>
		
		
		<c:remove var="catEntry" />
		<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
			<c:set property="catalogEntryID" value="${catEntryIdentifier}" target="${catEntry}" />
		</wcbase:useBean>	
		<%-- putting the catEntry in the request scope so that CatalogEntryThumbnailDisplay.jsp can use it --%>
		<c:set var="catEntry" value="${catEntry}" scope="request"/>

		<c:if test="${(catEntry.dynamicKit && showDynamicKit) || !catEntry.dynamicKit}">
        <c:if test="${currentRowCount == 0}">
            <tr>
                <td class="divider_line" colspan="4" id="WC_ContentAreaESpot_td_1_<c:out value='${status.count}'/>"></td>
            </tr>
            <tr>
        </c:if>
	        <c:set var="currentRowCount" value="${currentRowCount+1}" />

        <td class="item" id="WC_ContentAreaESpot_td_2_<c:out value='${status.count}'/>">
            <div id="WC_ContentAreaESpot_div_16_<c:out value='${status.count}'/>" <c:if test="${currentRowCount!= 0}"> class="container" </c:if>>
		               

				    <%-- Coremetrics tag --%>
					<flow:ifEnabled feature="Analytics">
						<cm:campurl espotData="${marketingSpotDatas}" id="clickInfoCommand" url="${clickInfoURLForAnalytics}" 
					 		initiative="${marketingSpotData.activityIdentifier.uniqueID}" 
					 		name="${catEntry.description.name}" />
					</flow:ifEnabled>
				    <%-- Coremetrics tag --%>					



		<%out.flush();%>
		<flow:ifDisabled feature="SearchBasedNavigation">
			<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryThumbnailDisplay.jsp">
					<c:param name="contentAreaESpot" value="${contentAreaESpot}"/>
					<c:param name="langId" value="${langId}" />						
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:param name="emsName" value="${emsName}" />
					<c:param name="skipAttachments" value="${param.skipAttachments}"/>
					<c:param name="pageView" value="${pageView}"/>
					<c:param name="prefix" value="${prefix}"/>
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
		</flow:ifDisabled>
		<flow:ifEnabled feature="SearchBasedNavigation">
			<%@ include file="../../Search/SearchESpotSetup.jspf"%>
		</flow:ifEnabled>
		<%out.flush();%>
                <c:remove var="useClickInfoURL"/>
		<c:remove var="catEntryDescription"/>
		<c:remove var="ClickInfoURL"/>
            </div>
        </td>

        <c:if test="${currentRowCount%numberProductsPerRow == 0}">
            </tr>
            <c:set var="currentRowCount" value="0"/>
            <c:set var="rowBeginIndex" value="${status.count}"/>
        </c:if>
  		</c:if>      
    </c:if>
</c:forEach>

<c:if test="${currentRowCount != 0}">
    </tr>
</c:if>

<c:if test="${catEntryCount != 0}">
        </table>
        <br />
    </div>
    <div class="footer" id="WC_ContentAreaESpot_div_17">
        <div class="left_corner" id="WC_ContentAreaESpot_div_18"></div>
        <div class="left" id="WC_ContentAreaESpot_div_19"></div>
        <div class="right_corner" id="WC_ContentAreaESpot_div_20"></div>
    </div>
    <div class="space"> </div>
</c:if>

<c:if test="${param.widgetIconStyle != 'top' && (param.showWidget == 'true' || param.showFeed == 'true') && numCatalogEntries != 0 && numContent == 0}">
    <%out.flush();%>
    <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/RemoteWidgetButtons.jsp">
        <c:param name="showWidget" value="${param.showWidget}" />
        <c:param name="showFeed" value="${param.showFeed}" />
        <c:param name="widgetIconStyle" value="${param.widgetIconStyle}" />
        <c:param name="sidebarWidgetId" value="${param.sidebarWidgetId}" />
        <c:param name="sidebarColors" value="${param.sidebarColors}" />
        <c:param name="bannerWidgetId" value="${param.bannerWidgetId}" />
        <c:param name="bannerColors" value="${param.bannerColors}" />
        <c:param name="feedURL" value="${param.feedURL}" />
        <c:param name="feedLayer" value="${param.feedLayer}" />
        <c:param name="emsId" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
    </c:import>
    <%out.flush();%>
</c:if>

<%--
  *
  * End: CatalogEntries
  *
--%>




<%--
  *
  * Start: Content
  * The following block is used to display the content associated with this e-Marketing
  * Spot. The URL link defined with the content can be referenced through the submission of
  * the HTML form in the calling .jsp file.
  *
--%>
<c:if test="${param.widgetIconStyle == 'top' && (param.showWidget == 'true' || param.showFeed == 'true') && numCategories == 0 && numCatalogEntries == 0 && numContent != 0}">
    <%out.flush();%>
    <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/RemoteWidgetButtons.jsp">
        <c:param name="showWidget" value="${param.showWidget}" />
        <c:param name="showFeed" value="${param.showFeed}" />
        <c:param name="widgetIconStyle" value="${param.widgetIconStyle}" />
        <c:param name="sidebarWidgetId" value="${param.sidebarWidgetId}" />
        <c:param name="sidebarColors" value="${param.sidebarColors}" />
        <c:param name="bannerWidgetId" value="${param.bannerWidgetId}" />
        <c:param name="bannerColors" value="${param.bannerColors}" />
        <c:param name="feedURL" value="${param.feedURL}" />
        <c:param name="feedLayer" value="${param.feedLayer}" />
        <c:param name="emsId" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
    </c:import>
    <%out.flush();%>
</c:if>

<c:set var="currentRowCount" value="0" />

<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status3">
    <c:if test='${marketingSpotData.dataType eq "MarketingContent"}'>
    
        <c:set var="currentRowCount" value="${currentRowCount+1}" />

        <c:if test="${currentRowCount % numberContentPerRow == 1 || numberContentPerRow == 1}">
            <div class="ad" id="ad_<c:out value='${marketingSpotDatas.marketingSpotIdentifier.uniqueID}'/>">
        </c:if>

        <c:choose>
            <c:when test="${currentRowCount % numberContentPerRow == 1 && numberContentPerRow == 2}">
                <c:set value="ad_space_1" var="advertisement_class" />
            </c:when>
            <c:when test="${currentRowCount % numberContentPerRow == 0 && numberContentPerRow == 2}">
                <c:set value="ad_space_3" var="advertisement_class" />
            </c:when>
        </c:choose>

        <c:if test="${numberContentPerRow != 1}">
            <div id="WC_ContentAreaESpot_div_21_<c:out value='${status3.count}'/>" class="<c:out value="${advertisement_class}" />"><img src="<c:out value="${hostPath}${jspStoreImgDir}" />images/trasparent.gif" alt="<fmt:message key="No_Image" bundle="${storeText}"/>" border="0"/></div>
            <div class="ad_product" id="WC_ContentAreaESpot_div_22_<c:out value='${status3.count}'/>">
        </c:if>

        <%--
          *
          * Set up the URL to call when the image or text is clicked.
          *
        --%>
        <c:url value="${marketingSpotData.marketingContent.url}" var="contentClickUrl">
            <c:if test="${!empty param.errorViewName}" >
                <c:param name="errorViewName" value="${param.errorViewName}" />
                <c:if test="${!empty param.orderId}">
                    <c:param name="orderId" value="${param.orderId}"/>
                </c:if>
            </c:if>
        </c:url>

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
            <c:param name="URL" value="${contentClickUrl}" />
        </c:url>
        
        <%-- Coremetrics tag --%>
        <flow:ifEnabled feature="Analytics">
            <cm:campurl espotData="${marketingSpotDatas}" id="ClickInfoURL" url="${ClickInfoURL}"
                        initiative="${marketingSpotData.activityIdentifier.uniqueID}"
                        name="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}" />
        </flow:ifEnabled>


        <c:choose>
        
            <c:when test="${marketingSpotData.marketingContent.marketingContentFormat.name == 'File'}">
                <%--
                  *
                  * For handling language specific assets and descriptions
                  *
                --%>
                <c:set var="attachment" value="${marketingSpotData.marketingContent.attachment}"/>
                <c:set var="foundLanguage" value="false"/>
                
                <%-- Store the index of the asset for the current language in the array --%>
                <c:set var="assetIndex" value="0"/>
                
                <%-- Check if there are any attachment assets --%>
                <c:if test="${fn:length(attachment.attachmentAsset) > 0}">
                    <%-- Go through each asset and scan the list of languages specified --%>
                    <%-- Take the first asset found with the current selected language --%>
                    <%-- If no language specific asset is found, use the first asset as the default --%>
                    <c:forEach var="i" begin="0" end="${fn:length(attachment.attachmentAsset)-1}">
                        <c:forEach var="language" items="${attachment.attachmentAsset[i].language}">
                            <c:if test="${(language == langId) && (!foundLanguage)}">
                                <c:set var="foundLanguage" value="true"/>
                                <c:set var="assetIndex" value="${i}"/>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </c:if>

                <c:set var="foundLanguage" value="false"/>
                <%-- Store the index of the attachment description for the current language in the array --%>
                <c:set var="descriptionIndex" value="0"/>

                <%-- Check if there are any attachment descriptions --%>
                <c:if test="${fn:length(attachment.attachmentDescription) > 0}">
                    <%-- Go through each description and find the description associated with the current language --%>
                    <%-- If no language specific description is found, use the default English description --%>
                    <c:forEach var="i" begin="0" end="${fn:length(attachment.attachmentDescription)-1}">
                        <c:forEach var="language" items="${attachment.attachmentDescription[i].language}">
                            <c:if test="${(language == langId) && (!foundLanguage)}">
                                <c:set var="foundLanguage" value="true"/>
                                <c:set var="descriptionIndex" value="${i}"/>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </c:if>

				  	 <c:choose>
	              		<c:when test="${(marketingSpotData.marketingContent.mimeType eq 'image') || (marketingSpotData.marketingContent.mimeType eq 'images')}">
						<c:choose>
							<c:when test="${param.isCategorySubsriptionDisplayURL eq true or WCParam.isCategorySubsriptionDisplayURL eq true}">
								<img id="divider" alt="" src="<c:out value="${jspStoreImgDir}${vfileColor}left_nav_divider.gif"/>" />
								<div id="CategorySubscriptionOption" class="CategorySubscriptionOption">
									<form id="CategorySubscriptionForm" name="CategorySubscriptionForm" method="post" action="MarketingTriggerProcessServiceEvaluate">
										<input type="hidden" name="DM_ReqCmd" value="<c:out value='${marketingSpotData.marketingContent.url}'/>" id="CategorySubscriptionForm_DM_ReqCmd"/>
										<input type="hidden" name="storeId" value='<c:out value="${param.storeId}" />' id="CategorySubscriptionForm_storeId"/>
										<input type="hidden" name="catalogId" value='<c:out value="${param.catalogId}"/>' id="CategorySubscriptionForm_catalogId"/>
										<input type="hidden" name="langId" value='<c:out value="${param.langId}"/>' id="CategorySubscriptionForm_langId"/>
										<input type="hidden" name="categoryId" value="${WCParam.categoryId}" id="CategorySubscriptionForm_categoryId"/>
										<input type="hidden" name="errorViewName" value="AjaxOrderItemDisplayView" id="CategorySubscriptionForm_errorViewName"/>
										<input type="hidden" name="URL" value="" id="CategorySubscriptionForm_URL"/>
									</form>
									<c:set var="ajaxEnabled" value="false"/>
									<flow:ifEnabled feature="AjaxAddToCart">
										<c:set var="ajaxEnabled" value="true"/>
									</flow:ifEnabled>
									<a id="CategorySubscriptionLink" href="#" onclick="JavaScript:setCurrentId('CategorySubscriptionLink');categoryDisplayJS.handleCategorySubscription('CategorySubscriptionForm','${ajaxEnabled}');return false;">
										<img id="CategorySubscriptionImage" src='<c:out value="${hostPath}${staticAssetContextRoot}/${attachment.attachmentAsset[assetIndex].rootDirectory}/${attachment.attachmentAsset[assetIndex].attachmentAssetPath}"/>'
										   alt='<c:out value="${attachment.attachmentDescription[descriptionIndex].shortDescription}"/>' title='<c:out value="${attachment.attachmentDescription[descriptionIndex].shortDescription}"/>'
										   border="0"
										/>
									</a>
								</div>
							</c:when>
							<c:otherwise>
					              	 <%--
				                    *
				                    * Display the content image, with optional click information.
				                    *
				                   --%>
				                   <c:if test="${!empty marketingSpotData.marketingContent.url}">
									<a id="WC_ContentAreaESpot_links_3_<c:out value='${status3.count}'/>" href="${absoluteUrl}${ClickInfoURL}" ${clickOpenBrowser} >
									</c:if>
										<img
										   src='<c:out value="${hostPath}${staticAssetContextRoot}/${attachment.attachmentAsset[assetIndex].rootDirectory}/${attachment.attachmentAsset[assetIndex].attachmentAssetPath}"/>'
										   alt='<c:out value="${attachment.attachmentDescription[descriptionIndex].shortDescription}"/>'
										   border="0"
										/>
									<c:if test="${!empty marketingSpotData.marketingContent.url}">
										</a>
									</c:if>
							</c:otherwise>
						</c:choose>
			          </c:when>

                    <c:when test="${(marketingSpotData.marketingContent.mimeType eq 'application') ||
                                    (marketingSpotData.marketingContent.mimeType eq 'applications') ||
                                    (marketingSpotData.marketingContent.mimeType eq 'text') ||
                                    (marketingSpotData.marketingContent.mimeType eq 'textyv') ||
                                    (marketingSpotData.marketingContent.mimeType eq 'video') ||
                                    (marketingSpotData.marketingContent.mimeType eq 'audio') ||
                                    (marketingSpotData.marketingContent.mimeType eq 'model')
                                    }">
                        <%--
                          *
                          * Display the content: flash, audio, or other.
                          *
                        --%>
                        <c:choose>
                            <c:when test="${(attachment.attachmentAsset[assetIndex].mimeType eq 'application/x-shockwave-flash')}" >
                                <c:if test="${!empty marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}">
                                    <div class="hidden_summary">
                                        <c:out value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}"/>
                                    </div>
                                </c:if>                            
                                <object data="<c:out value="${hostPath}${staticAssetContextRoot}/${attachment.attachmentAsset[assetIndex].rootDirectory}/${attachment.attachmentAsset[assetIndex].attachmentAssetPath}"/>"
                                         <c:if test="${!empty param.adWidth}">
                                             width="${param.adWidth}"
                                         </c:if>
                                         <c:if test="${!empty param.adHeight}">
                                             height="${param.adHeight}"
                                         </c:if>
                                         tabindex="-1"
                                         type="application/x-shockwave-flash">
                                     <param name="movie" value="<c:out value="${hostPath}${staticAssetContextRoot}/${attachment.attachmentAsset[assetIndex].rootDirectory}/${attachment.attachmentAsset[assetIndex].attachmentAssetPath}"/>" />
                                     <param name="quality" value="high"/>
                                     <param name="bgcolor" value="#FFFFFF"/>
                                     <param name="pluginurl" value="http://www.macromedia.com/go/getflashplayer"/>
                                     <param name="wmode" value="opaque"/>
                                     <c:if test="${!empty baseObjectPath}">
                                     	<param name="base" value="${baseObjectPath}" />
                                     </c:if>
                                </object>
                            </c:when>
                            <c:otherwise>
                                <a id="WC_ContentAreaESpot_links_4_<c:out value='${status3.count}'/>" href="<c:out value="${hostPath}${staticAssetContextRoot}/${attachment.attachmentAsset[assetIndex].rootDirectory}/${attachment.attachmentAsset[assetIndex].attachmentAssetPath}"/>" target="_blank">
                                     <img src='<c:out value="${hostPath}${staticAssetContextRoot}/${attachment.attachmentAsset[assetIndex].rootDirectory}/${attachment.attachmentUsage.image}"/>'
                                          alt='<c:out value="${attachment.attachmentDescription[descriptionIndex].shortDescription}"/>'
                                          border="0"  />
                                </a>
                                <%--
                                  *
                                  * Display the content text, with optional click information.
                                  *
                                --%>
                                <c:if test="${!empty marketingSpotData.marketingContent.url}">
                                    <a id="WC_ContentAreaESpot_links_5_<c:out value='${status3.count}'/>" href="${absoluteUrl}${ClickInfoURL}" ${clickOpenBrowser} >
                                </c:if>

                                <c:out value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}" escapeXml="false" />

                                <c:if test="${!empty marketingSpotData.marketingContent.url}">
                                    </a>
                                </c:if>                                
                            </c:otherwise>
                        </c:choose>


                    </c:when>

                    <c:otherwise>
                        <%--
                          * Content type is File, but no image or known mime type is associated, so display a link to the URL.
                          * Display the content text, with optional click information.
                          *
                        --%>
                        <a href="<c:out value='${marketingSpotData.marketingContent.attachment.attachmentAsset[0].attachmentAssetPath}' />" target="_new">
                            <c:out value="${marketingSpotData.marketingContent.attachment.attachmentAsset[0].attachmentAssetPath}"/>
                        </a>
                        
                        <c:if test="${!empty marketingSpotData.marketingContent.url}">
                            <a href="${ClickInfoURL}" ${clickOpenBrowser} >
                        </c:if>
                        
                        <c:if test="${!empty marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}">
                            <br/>
                            <c:out value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}" escapeXml="false" />
                        </c:if>
                        
                        <c:if test="${!empty marketingSpotData.marketingContent.url}">
                           </a>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </c:when>
            
            <c:when test="${marketingSpotData.marketingContent.marketingContentFormat.name == 'Text'}">
                <c:choose>
                    <c:when test="${param.isCategorySubsriptionDisplayURL eq true or WCParam.isCategorySubsriptionDisplayURL eq true}">
                        <img id="divider" alt="" src="<c:out value="${jspStoreImgDir}${vfileColor}left_nav_divider.gif"/>" />
                        <div id="CategorySubscriptionOption" class="CategorySubscriptionOption">
                            <form id="CategorySubscriptionForm" name="CategorySubscriptionForm" method="post" action="MarketingTriggerProcessServiceEvaluate">
                                <input type="hidden" name="DM_ReqCmd" value="<c:out value='${marketingSpotData.marketingContent.url}'/>" id="CategorySubscriptionForm_DM_ReqCmd"/>
                                <input type="hidden" name="storeId" value='<c:out value="${param.storeId}" />' id="CategorySubscriptionForm_storeId"/>
                                <input type="hidden" name="catalogId" value='<c:out value="${param.catalogId}"/>' id="CategorySubscriptionForm_catalogId"/>
                                <input type="hidden" name="langId" value='<c:out value="${param.langId}"/>' id="CategorySubscriptionForm_langId"/>
                                <input type="hidden" name="categoryId" value="${WCParam.categoryId}" id="CategorySubscriptionForm_categoryId"/>
                                <input type="hidden" name="errorViewName" value="AjaxOrderItemDisplayView" id="CategorySubscriptionForm_errorViewName"/>
                                <input type="hidden" name="URL" value="" id="CategorySubscriptionForm_URL"/>
                            </form>
                            <c:set var="ajaxEnabled" value="false"/>
                            <flow:ifEnabled feature="AjaxAddToCart">
                                <c:set var="ajaxEnabled" value="true"/>
                            </flow:ifEnabled>
                            <a id="CategorySubscriptionLink" href="#" onclick="JavaScript:setCurrentId('CategorySubscriptionLink');categoryDisplayJS.handleCategorySubscription('CategorySubscriptionForm','${ajaxEnabled}');return false;">
                                <c:out value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}" escapeXml="false" />
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <%--
                          *
                          * Display the content text, with optional click information.
                          *
                        --%>                          
                        <c:if test="${!empty marketingSpotData.marketingContent.url}">
                            <a id="WC_ContentAreaESpot_links_7_<c:out value='${status3.count}'/>" href="${absoluteUrl}${ClickInfoURL}" ${clickOpenBrowser} >
                        </c:if>
                        <c:out value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}" escapeXml="false" />
                        <c:if test="${!empty marketingSpotData.marketingContent.url}">               
                            </a>
                        </c:if>            
                    </c:otherwise>
                </c:choose>
                
            </c:when>
            
        </c:choose>

        <c:if test="${numberContentPerRow != 1}">
            </div>
        </c:if>

        <c:if test="${currentRowCount % numberContentPerRow == 0 && numberContentPerRow == 2}">
            <br clear="left" />
        </c:if>

        <c:if test="${currentRowCount % numberContentPerRow == 0}">
            <c:set var="currentRowCount" value="0" />
            </div>
        </c:if>

    </c:if>
</c:forEach>


<c:if test="${currentRowCount != 0}">
    </div>
</c:if>


<c:if test="${param.widgetIconStyle != 'top' && (param.showWidget == 'true' || param.showFeed == 'true') && numContent != 0}">
    <%out.flush();%>
    <c:import url="${jspStoreDir}Snippets/Marketing/ESpot/RemoteWidgetButtons.jsp">
        <c:param name="showWidget" value="${param.showWidget}" />
        <c:param name="showFeed" value="${param.showFeed}" />
        <c:param name="widgetIconStyle" value="${param.widgetIconStyle}" />
        <c:param name="sidebarWidgetId" value="${param.sidebarWidgetId}" />
        <c:param name="sidebarColors" value="${param.sidebarColors}" />
        <c:param name="bannerWidgetId" value="${param.bannerWidgetId}" />
        <c:param name="bannerColors" value="${param.bannerColors}" />
        <c:param name="feedURL" value="${param.feedURL}" />
        <c:param name="feedLayer" value="${param.feedLayer}" />
        <c:param name="emsId" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
    </c:import>
    <%out.flush();%>
</c:if>


<%--
  *
  * End: Content
  *
--%>


</div>

<!-- END ContentAreaESpot.jsp -->