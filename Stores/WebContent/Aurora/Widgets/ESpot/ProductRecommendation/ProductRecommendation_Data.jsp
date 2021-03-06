
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

<%
   /* Get the e-Marketing Spot name from the request parameters, and decode it in case it has been encoded. */
   String emsName = request.getParameter("emsName");
   if (emsName != null) {
   	emsName = java.net.URLDecoder.decode(emsName, "UTF-8");
	  request.setAttribute("emsName", emsName);
   }

   Object DM_marketingSpotBehavior = request.getAttribute("DM_emsBehavior-" + emsName);
    if (DM_marketingSpotBehavior != null) {
   	request.setAttribute("DM_marketingSpotBehavior", DM_marketingSpotBehavior.toString());
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
    <c:set value="${pageContext.request.scheme}://${pageContext.request.serverName}${portUsed}" var="hostPath" />
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

			<wcf:param name="DM_marketingSpotBehavior" value="${requestScope.DM_marketingSpotBehavior}"/>

	    <%-- do not retrieve the catalog entry SDO but obtain the catalog entry Id only --%>
	    <wcf:param name="DM_ReturnCatalogEntryId" value="true" />

			<%-- pass along product ID for the promotion --%>
			<%-- Give preference to the requestparamter first and then to request attribute --%>
			<c:if test="${!empty param.productId}">
				<c:set var="productId" value="${param.productId}"/>
			</c:if>
             <c:if test="${!empty productId}">
				<wcf:param name="productId" value="${productId}" />
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

 <wcf:eMarketingSpotCache marketingSpotData="${marketingSpotDatas}" catalogEntryDependencyName="productId" />


<%--
  *
  * Start: Catalog Entries
  * The following block is used to display the catalog entries associated with this e-Marketing Spot. The
  * product display page that shows the selected catalog entry will be referenced
  * through the submission of the HTML form in the calling .jsp file.
  *
--%>  

<c:set var="currentProductCount" value="0" />
							
	<c:set var="catentryIdList" value=""/>
	<c:set var="nondisplayableDKList" value=""/>
	
	<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}">
		<c:if test='${marketingSpotData.dataType eq "CatalogEntryId" && !empty marketingSpotData.uniqueID}'>
			<c:remove var="catEntry" />
			<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
				<c:set property="catalogEntryID" value="${marketingSpotData.uniqueID}" target="${catEntry}" />
			</wcbase:useBean>
			<c:choose>
				<c:when test="${(catEntry.dynamicKit && showDynamicKit) || !catEntry.dynamicKit}">        
			        <c:set var="currentProductCount" value="${currentProductCount+1}" />
			        <c:choose>
			        	<c:when test="${empty catentryIdList}">
			        		<c:set var="catentryIdList" value="${marketingSpotData.uniqueID}"/>
			        	</c:when>
			        	<c:otherwise>
			        		<c:set var="catentryIdList" value="${catentryIdList},${marketingSpotData.uniqueID}"/>
			        	</c:otherwise>							</c:choose> 									      																										        
			    </c:when>
			  	<c:otherwise>
			  			<c:choose>
				        	<c:when test="${empty nondisplayableDKList}">
				        		<c:set var="nondisplayableDKList" value="${marketingSpotData.uniqueID}"/>
				        	</c:when>
				        	<c:otherwise>
				        		<c:set var="nondisplayableDKList" value="${nondisplayableDKList},${marketingSpotData.uniqueID}"/>
				        	</c:otherwise>
			        	</c:choose> 
			  	</c:otherwise>
			  </c:choose>
		</c:if>
	</c:forEach>
	
	<c:if test="${!empty catentryIdList || !empty nondisplayableDKList}">
		<c:set var="pageView" value="${param.pageView}"/>
		
		<c:set var="exprBuilder" value="getCatalogEntryViewPriceWithAttributesByID"/>
		<c:set var="searchProfile" value="IBM_findCatalogEntryPriceWithAttributes_PriceMode"/>
		<c:if test="${pageView eq 'list' || pageView eq 'miniList'}">
			<c:set var="exprBuilder" value="getCatalogEntryViewDetailsByID"/>
			<c:set var="searchProfile" value="IBM_findCatalogEntryDetails_PriceMode"/>
		</c:if>

		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogNavigationViewType" var="catalogNavigationView" 
			expressionBuilder="${exprBuilder}" scope="request" varShowVerb="showCatalogNavigationView" 
			maxItems="100" recordSetStartNumber="0" scope="request">
			<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}">
				<c:if test='${marketingSpotData.dataType eq "CatalogEntryId"}'>
					<wcf:param name="UniqueID" value="${marketingSpotData.uniqueID}"/>
				</c:if>
			</c:forEach>
			<wcf:contextData name="storeId" data="${storeId}" />
			<wcf:contextData name="catalogId" data="${catalogId}" />
			<wcf:param name="searchProfile" value="${searchProfile}"/>
		</wcf:getData>
		<c:set var="eSpotCatalogIdResults" value="${catalogNavigationView.catalogEntryView}"/>
	</c:if>
<c:set var="prefix" value="eSpot"/>            
<c:set var="useClickInfoURL" value="true"/>

<c:set var="numEntries" value="${currentProductCount}"/>

<c:set var="pageSize" value="${param.pageSize}" />
<c:if test="${empty pageSize}">
	<c:set var="pageSize" value="2" />
</c:if>

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

<fmt:formatNumber var="totalPages" value="${(numEntries/pageSize)+1}"/>
<c:if test="${numEntries%pageSize == 0}">
	<fmt:formatNumber var="totalPages" value="${numEntries/pageSize}"/>
	<c:if test="${totalPages == 0 && numEntries!=0}">
		<fmt:formatNumber var="totalPages" value="1"/>
	</c:if>
</c:if>
<fmt:parseNumber var="totalPages" value="${totalPages}" integerOnly="true"/>


<fmt:message key="ES_PRODUCT_RECOMMENDATION" var="espotTypeInfo"/>	

<%--
  *
  * End: CatalogEntries
  *
--%>   

