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

<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>


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
   
   int displayCategories    = 20;
   
   String numberCategoriesToDisplayString = request.getParameter("numberCategoriesToDisplay");
   if (numberCategoriesToDisplayString != null) {
   	request.setAttribute("numberCategoriesToDisplay", numberCategoriesToDisplayString);
   	displayCategories = Integer.parseInt(numberCategoriesToDisplayString);
   }
   

   java.util.Hashtable emsHash = (java.util.Hashtable)request.getAttribute(com.ibm.commerce.marketing.beans.EMarketingSpot.EMS_REQUEST_ATTRIBUTE_CONTAINER_NAME);
   if (emsHash != null) {
      request.setAttribute("emsFromFilter",
           emsHash.get(com.ibm.commerce.tools.campaigns.CampaignRuntimeUtil.generateEMarketingSpotInvocationKey(emsName, 20, 0, displayCategories, 0)));
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

<c:set var="numberCategoriesPerRow">
    <c:out value="${param.numberCategoriesPerRow}" default="1" />
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

			<wcf:param name="DM_marketingSpotBehavior" value="${requestScope.DM_marketingSpotBehavior}"/>

	    <%-- do not retrieve the catalog entry SDO but obtain the catalog entry Id only --%>
	    <wcf:param name="DM_ReturnCatalogEntryId" value="true" />

            <c:if test="${numberCategoriesToDisplay != null}">
                <wcf:param name="DM_DisplayCategories" value="${numberCategoriesToDisplay}" />
            </c:if>                      
            <%-- url command name --%>
            <wcf:param name="DM_ReqCmd" value="${requestURI}" />
            <%-- url name value pair parameters --%>                    
            <c:forEach var="aParam" items="${WCParamValues}">
                <c:forEach var="aValue" items="${aParam.value}">
                    <wcf:param name="${aParam.key}" value="${aValue}" />
                </c:forEach>
            </c:forEach>
                        
            <c:if test="${!empty param.substitutionName1 && !empty param.substitutionValue1}">
                <wcf:param name="DM_SubstitutionName1" value="${param.substitutionName1}" />
                <wcf:param name="DM_SubstitutionValue1" value="${param.substitutionValue1}" />
            </c:if>
            <c:if test="${!empty param.substitutionName2 && !empty param.substitutionValue2}">
                <wcf:param name="DM_SubstitutionName2" value="${param.substitutionName2}" />
                <wcf:param name="DM_SubstitutionValue2" value="${param.substitutionValue2}" />
            </c:if>                
         
            <c:if test="${!empty param.previewReport}">
                <wcf:param name="DM_PreviewReport" value="${param.previewReport}"/>
            </c:if>

        </wcf:getData>
    </c:otherwise>
</c:choose>

<wcf:eMarketingSpotCache marketingSpotData="${marketingSpotDatas}" categoryDependencyName="categoryId" />

<c:set var="currentRowCount" value="0" />

<jsp:useBean id="categoryImageMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="categoryURLMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="categoryDescriptionMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="categoryIdentifierMap" class="java.util.HashMap" type="java.util.Map"/>

<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status2">
    <c:if test='${marketingSpotData.dataType eq "CatalogGroup"}'>

	  <c:set var="currentRowCount" value="${currentRowCount+1}" />

        <%--
           *
           * Set up the URL to call when clicking on the image.
           *
        --%>
        <c:choose>
            <c:when test="${marketingSpotData.catalogGroup.topCatalogGroup}">
                <wcf:url var="TargetURL" value="Category3" patternName="CanonicalCategoryURL">
                    <wcf:param name="langId" value="${langId}" />
                    <wcf:param name="storeId" value="${WCParam.storeId}" />
                    <wcf:param name="catalogId" value="${param.catalogId}" />
                    <wcf:param name="categoryId" value="${marketingSpotData.catalogGroup.catalogGroupIdentifier.uniqueID}" />
                    <wcf:param name="pageView" value="${defaultPageView}" />
                    <wcf:param name="beginIndex" value="0" />
                    <wcf:param name="urlLangId" value="${urlLangId}" />
                </wcf:url>
            </c:when>
            <c:otherwise>
                <wcf:url var="TargetURL" patternName="CanonicalCategoryURL" value="Category3">
                    <wcf:param name="langId" value="${langId}"/>
                    <wcf:param name="storeId" value="${WCParam.storeId}"/>
                    <wcf:param name="catalogId" value="${param.catalogId}"/>
                    <wcf:param name="pageView" value="${defaultPageView}"/>
                    <wcf:param name="beginIndex" value="0"/>
                    <wcf:param name="showResultsPage" value="true"/>
                    <wcf:param name="categoryId" value="${marketingSpotData.catalogGroup.catalogGroupIdentifier.uniqueID}" />
                    <wcf:param name="urlLangId" value="${urlLangId}" />
                </wcf:url> 
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
                <c:set var="imageFilePath" value="${env_imageContextPath}/${attribute.value}/" />
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

       	 <c:choose>
            <c:when test="${!empty marketing_catalogGroupImage}">
                	<c:set target="${categoryImageMap}" property="${currentRowCount}" value="${hostPath}${imageFilePath}${marketing_catalogGroupImage}"/>
					<c:set target="${categoryDescriptionMap}" property="${currentRowCount}" value="${marketing_catalogGroupShortDescription}"/>
            </c:when>
            <c:otherwise>
					<c:set target="${categoryImageMap}" property="${currentRowCount}" value="${hostPath}${jspStoreImgDir}" />images/NoImageIcon.jpg"/>
					<c:set target="${categoryDescriptionMap}" property="${currentRowCount}" value="<fmt:message key='No_Image'"/>
            </c:otherwise>
        </c:choose>
			<c:set target="${categoryURLMap}" property="${currentRowCount}" value="${env_absoluteUrl}${ClickInfoURL}"/>
			<c:set target="${categoryIdentifierMap}" property="${currentRowCount}" value="${marketing_CategoryName}"/>
		</c:if>
</c:forEach>

<%-- Decide the row class based on the number of categories in the espot --%>
<c:choose>
	<c:when test="${currentRowCount eq 4}">
		<c:set var="rowClass" value="row"/>
	</c:when>
	<c:when test="${currentRowCount eq 3}">
		<c:set var="rowClass" value="row_3col"/>
	</c:when>
	<c:otherwise>
		<c:set var="rowClass" value="row_2col"/>
	</c:otherwise>
</c:choose>

<fmt:message key="ES_CATEGORY_RECOMMENDATION" var="espotTypeInfo"/>	
