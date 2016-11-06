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

<%--
  * This CachedContentAreaESpot.jsp file is built for displaying an e-Marketing Spot in the main content of the
  * store page. It uses Web services to call the Dialog Marketing runtime to get the data to display
  * in the e-Marketing Spot.
  *
  * Use this version of the sample snippet for e-Marketing Spots that use the marketing tool
  * supplied with Management Center. For e-Marketing Spots that use the marketing tool
  * supplied with WebSphere Commerce Accelerator, use the snippet called eMarketingSpotDisplay.jsp.
  *
  * The code in this e-Marketing Spot .jsp file supports the display of the following types of data:
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
  *   - numberContentToDisplay
  *     The maximum number of content that can be displayed in the e-Marketing Spot at the same time.
  *		- useFullURL
  *			Tells the page to use full paths when retrieving images, static assets, etc. This flag must be set
  *			to true if using this JSP in an email.
  *		- clickInfoURL
  *			This is the clickInfoURL that should be used instead.
  *		- requestURI
  *			When an area on the page that imports CachedContentAreaESpot.jsp is refreshed through an AJAX call, the standard requestURI parameter that is often required to set DM_ReqCmd in order to retrieve marketing data may be missing in the request.
  *			In this case, WCParam.requestURI can be used to substitute the default requestURI parameter in retrieving the data.  
  *
  *   This code supports the following two optional parameters:
  *   - errorViewName
  *     The URL to call if there is an error or exception when clicking on a content link in the e-Marketing Spot snippet.
  *   - orderId
  *     The ID of the current order of the customer to include when calling the errorViewName URL.
  *
  * How to use this snippet:
  *	This is an example of how this file can be included in a page:
  *		<c:import url="${jspStoreDir}include/CachedContentAreaESpot.jsp">
  *			<c:param name="emsName" value="ShoppingCartPage" />
  *			<c:param name="catalogId" value="${WCParam.catalogId}" />
  *		</c:import>
  *
  * This is another example including some of the optional parameters:
  *		<%out.flush();%>
  *		<c:import url="${jspStoreDir}include/CachedContentAreaESpot.jsp">
  *			<c:param name="emsName" value="HomePageRow1Ads" />
  *			<c:param name="catalogId" value="${WCParam.catalogId}" />
  *			<c:param name="numberContentToDisplay" value="1" />
  *			<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
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

<!-- BEGIN CachedContentAreaESpot.jsp -->
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
   int displayContent    = 20;

   String numberContentToDisplayString = request.getParameter("numberContentToDisplay");
   if (numberContentToDisplayString != null) {
   	request.setAttribute("numberContentToDisplay", numberContentToDisplayString);
   	displayContent = Integer.parseInt(numberContentToDisplayString);
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
<c:set var="numberContentToDisplay"    value="${requestScope.numberContentToDisplay}"/>
<c:set var="myAccountPage"               value="${requestScope.myAccountPage}"/>

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

            <c:if test="${!empty param.previewReport}">
                <wcf:param name="DM_PreviewReport" value="${param.previewReport}"/>
            </c:if>

        </wcf:getData>

    </c:otherwise>
</c:choose>

<c:set var="numContent" value="0"/>
<c:set var="WC_ContentAreaESpot_div_1_ID" value="WC_ContentAreaESpot_div_1_${marketingSpotDatas.marketingSpotIdentifier.uniqueID}"/>
<c:set var="WC_ContentAreaESpot_div_2_ID" value="WC_ContentAreaESpot_div_2_${marketingSpotDatas.marketingSpotIdentifier.uniqueID}"/>

<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}">
	<c:set var="numContent" value="${numContent + 1}"/>
</c:forEach>

<div class="genericESpot" id="${fn:replace(WC_ContentAreaESpot_div_1_ID, search, replaceStr)}">
<%--
  *
  * Start: Content
  * The following block is used to display the content associated with this e-Marketing
  * Spot. The URL link defined with the content can be referenced through the submission of
  * the HTML form in the calling .jsp file.
  *
--%>

<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status3">
    <c:if test='${marketingSpotData.dataType eq "MarketingContent"}'>
    			
				<c:set value="ad_space_3" var="advertisement_class" />
        
        <c:choose>
        	<c:when test="${marketingSpotData.name == 'StoreLogoContent'}">
        		<c:if test="${!empty catalogId }">
				<wcf:url var="contentClickUrl" patternName="HomePageURLWithLang" value="TopCategories1">
					<wcf:param name="langId" value="${langId}" />
					<wcf:param name="storeId" value="${WCParam.storeId}" />
					<wcf:param name="catalogId" value="${param.catalogId}" />
					<wcf:param name="urlLangId" value="${urlLangId}" />
				</wcf:url>
			</c:if>
        	</c:when>
        	<c:otherwise>
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
									<c:if test="${!empty marketingSpotData.marketingContent.url && empty param.hideLink}">
									<a id="<c:out value='${param.linkId}'/>" href="${absoluteUrl}${ClickInfoURL}" ${clickOpenBrowser} >
									</c:if>
										<img
										   src='<c:out value="${hostPath}${staticAssetContextRoot}/${attachment.attachmentAsset[assetIndex].rootDirectory}/${attachment.attachmentAsset[assetIndex].attachmentAssetPath}"/>'
										   alt='<c:out value="${attachment.attachmentDescription[descriptionIndex].shortDescription}"/>'
										   border="0"
										/>
									<c:if test="${!empty marketingSpotData.marketingContent.url && empty param.hideLink}">
										</a>
									</c:if>
							</c:otherwise>
						</c:choose>
			          </c:when>

                </c:choose>
            </c:when>
        </c:choose>
    </c:if>
</c:forEach>


<%--
  *
  * End: Content
  *
--%>


</div>

<!-- END CachedContentAreaESpot.jsp -->
