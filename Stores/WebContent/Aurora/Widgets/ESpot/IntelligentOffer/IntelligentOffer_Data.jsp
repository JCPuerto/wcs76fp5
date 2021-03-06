<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011, 2012 All Rights Reserved.

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
		
        </wcf:getData>
    </c:otherwise>
</c:choose>

 <wcf:eMarketingSpotCache marketingSpotData="${marketingSpotDatas}" catalogEntryDependencyName="productId" />
 
<c:set var="numIntelligentOffer" value="0"/>

<%-- Optional border. By default border will be present. pass showBorder = false to avoid border --%>
<c:choose>
	<c:when test="${empty param.showBorder}">
		<c:set var="showBorder" value="true"/>
	</c:when>
	<c:otherwise>
		<c:set var="showBorder" value="${param.showBorder}"/>
	</c:otherwise>
</c:choose>

<%-- Optional header. By default header will be present. pass showHeader = false to avoid header --%>
<c:choose>
	<c:when test="${empty param.showHeader}">
		<c:set var="showHeader" value="true"/>
	</c:when>
	<c:otherwise>
		<c:set var="showHeader" value="${param.showHeader}"/>
	</c:otherwise>
</c:choose>

<%-- Optional compare box. By default compare will be present. pass showCompareBox = false to avoid compare checkbox --%>
<c:choose>
	<c:when test="${empty param.showCompareBox}">
		<c:set var="showCompareBox" value="true"/>
	</c:when>
	<c:otherwise>
		<c:set var="showCompareBox" value="${param.showCompareBox}"/>
	</c:otherwise>
</c:choose>

<%-- Optional updateSwatch flag. By default it will be false. pass updateSwatch = true to update swatch by default --%>
<c:choose>
	<c:when test="${empty param.updateSwatch}">
		<c:set var="updateSwatch" value="false"/>
	</c:when>
	<c:otherwise>
		<c:set var="updateSwatch" value="${param.updateSwatch}"/>
	</c:otherwise>
</c:choose>

<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status">
		<c:if test='${marketingSpotData.dataType eq "IntelligentOffer"}'> 
			<c:set var="numIntelligentOffer" value="${numIntelligentOffer + 1}"/>

			<c:set var="WC_zone" value="${marketingSpotData.uniqueID}"/>			
			<c:set var="WC_IntelligentOfferESpot_url_variable" value="WC_IntelligentOfferESpot_url_var_${status.count}_${WC_zone}"/>
				
			<%-- url for the refresh area --%>
			<wcf:url var="WC_IntelligentOfferESpot_url_variable" value="IntelligentOfferResultsView" type="Ajax">
				<wcf:param name="langId" value="${WCParam.langId}" /> 
				<wcf:param name="storeId" value="${WCParam.storeId}" />
				<wcf:param name="catalogId" value="${WCParam.catalogId}" />
				<wcf:param name="emsName" value="${emsName}" />
				<wcf:param name="mpe_id" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
				<wcf:param name="intv_id" value="${marketingSpotData.activityIdentifier.uniqueID}" />
				<wcf:param name="activityName" value="${marketingSpotData.activityIdentifier.externalIdentifier.name}" />
				<wcf:param name="campaignName" value="${marketingSpotData.campaignName}" />
				<wcf:param name="pageSize" value="${param.pageSize}"/>
				<wcf:param name="pagination" value="${param.pagination}"/>
				<wcf:param name="pageView" value="${param.pageView}"/>
				<wcf:param name="espotTitle" value="${param.espotTitle}"/>
				<wcf:param name="currentPage" value="${param.currentPage}"/>
				<c:forEach var="expResult" items="${marketingSpotData.experimentResult}" begin="0" end="0">
					<wcf:param name="experimentId" value="${expResult.experiment.uniqueID}" />
					<wcf:param name="testElementId" value="${expResult.testElement.uniqueID}" />
					<wcf:param name="experimentName" value="${expResult.experiment.name}" />
					<wcf:param name="testElementName" value="${expResult.testElement.name}" />
					<wcf:param name="controlElement" value="${expResult.controlElement}" />            	
				</c:forEach>
				<wcf:param name="showBorder" value="${showBorder}"/>
				<wcf:param name="showHeader" value="${showHeader}"/>
				<wcf:param name="showCompareBox" value="${showCompareBox}"/>
				<wcf:param name="mainPartNumber" value="${param.partNumber}" />
				<wcf:param name="mainProductId" value="${param.mainProductId}" />
			</wcf:url>
			
			<%-- define the refresh area --%>
			<div class="WC_IntelligentOfferESpot_container_class_${WC_zone}" dojoType="wc.widget.RefreshArea" 
	   			id="WC_IntelligentOfferESpot_container_ID_${WC_zone}" 
	   			controllerId="WC_IntelligentOfferESpot_controller_ID_${WC_zone}">
			</div>
	
			<script type="text/javascript">
				dojo.addOnLoad(function() { 
					IntelligentOfferJS.declareRefreshController("<c:out value='WC_IntelligentOfferESpot_controller_ID_${WC_zone}' />",  "<c:out value='WC_IntelligentOfferESpot_context_ID_${WC_zone}' />", "${updateSwatch}");
					wc.render.getRefreshControllerById('<c:out value="WC_IntelligentOfferESpot_controller_ID_${WC_zone}"/>').url = '<c:out value="${WC_IntelligentOfferESpot_url_variable}" />';		
					console.warn('before cmRecRequest');
					cmRecRequest ('<c:out value="${marketingSpotData.uniqueID}" />','<wcf:out value="${param.partNumber}" escapeFormat="js"/>','<wcf:out value="${param.parentCategoryId}" escapeFormat="js"/>','<wcf:out value="${param.randomize}" escapeFormat="js"/>','<wcf:out value="${param.searchTerm}" escapeFormat="js"/>');
				});
			</script>	
    </c:if>
</c:forEach>

<fmt:message key="ES_INTELLOFFER_RECOMMENDATION" var="espotTypeInfo" scope="request"/>	
