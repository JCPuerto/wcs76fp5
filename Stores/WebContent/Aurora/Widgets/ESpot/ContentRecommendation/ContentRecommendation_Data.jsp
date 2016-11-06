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
   
   int displayContent    = 20;
   
   String numberContentToDisplayString = request.getParameter("numberContentToDisplay");
   if (numberContentToDisplayString != null) {
   	request.setAttribute("numberContentToDisplay", numberContentToDisplayString);
   	displayContent = Integer.parseInt(numberContentToDisplayString);
   }
   

   java.util.Hashtable emsHash = (java.util.Hashtable)request.getAttribute(com.ibm.commerce.marketing.beans.EMarketingSpot.EMS_REQUEST_ATTRIBUTE_CONTAINER_NAME);
   if (emsHash != null) {
      request.setAttribute("emsFromFilter",
           emsHash.get(com.ibm.commerce.tools.campaigns.CampaignRuntimeUtil.generateEMarketingSpotInvocationKey(emsName, 20, 0, 0, displayContent)));
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
<c:set var="numberContentToDisplay"    value="${requestScope.numberContentToDisplay}"/>


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

<c:set var="numberContentPerRow">
    <c:out value="${param.numberContentPerRow}" default="1" />
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

            <c:if test="${numberContentToDisplay != null}">
                <wcf:param name="DM_DisplayContent"    value="${numberContentToDisplay}" />
            </c:if>
                                            
            <%-- url command name --%>
            <wcf:param name="DM_ReqCmd" value="${requestURI}" />
            <%-- url name value pair parameters --%>    
			<c:catch>
				<c:forEach var="aParam" items="${WCParamValues}">
					<c:forEach var="aValue" items="${aParam.value}">
						<wcf:param name="${aParam.key}" value="${aValue}" />
					</c:forEach>
				</c:forEach>
            </c:catch>
            <c:if test="${!empty param.substitutionName1 && !empty param.substitutionValue1}">
                <wcf:param name="DM_SubstitutionName1" value="${param.substitutionName1}" />
                <wcf:param name="DM_SubstitutionValue1" value="${param.substitutionValue1}" />
            </c:if>
            <c:if test="${!empty param.substitutionName2 && !empty param.substitutionValue2}">
                <wcf:param name="DM_SubstitutionName2" value="${param.substitutionName2}" />
                <wcf:param name="DM_SubstitutionValue2" value="${param.substitutionValue2}" />
            </c:if>                
			<c:if test="${!empty param.substitutionName3 && !empty param.substitutionValue3}">
                <wcf:param name="DM_SubstitutionName3" value="${param.substitutionName3}" />
                <wcf:param name="DM_SubstitutionValue3" value="${param.substitutionValue3}" />
            </c:if>
			<c:if test="${!empty param.substitutionName4 && !empty param.substitutionValue4}">
                <wcf:param name="DM_SubstitutionName4" value="${param.substitutionName4}" />
                <wcf:param name="DM_SubstitutionValue4" value="${param.substitutionValue4}" />
            </c:if>
			<c:if test="${!empty param.substitutionName5 && !empty param.substitutionValue5}">
                <wcf:param name="DM_SubstitutionName5" value="${param.substitutionName5}" />
                <wcf:param name="DM_SubstitutionValue5" value="${param.substitutionValue5}" />
            </c:if>
            <c:if test="${!empty param.previewReport}">
                <wcf:param name="DM_PreviewReport" value="${param.previewReport}"/>
            </c:if>

        </wcf:getData>
    </c:otherwise>
</c:choose>

 <wcf:eMarketingSpotCache marketingSpotData="${marketingSpotDatas}" contentDependencyName="contentId" />

<%--
  *
  * Start: Content
  * The following block is used to display the content associated with this e-Marketing
  * Spot. The URL link defined with the content can be referenced through the submission of
  * the HTML form in the calling .jsp file.
  *
--%>

<c:set var="currentRowCount" value="0" />

<jsp:useBean id="contentUrlMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="contentImageMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="contentDescriptionMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="contentTextMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="contentAssetPathMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="contentFlashMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="contentTypeMap" class="java.util.HashMap" type="java.util.Map"/>
<jsp:useBean id="contentFormatMap" class="java.util.HashMap" type="java.util.Map"/>

<c:set var="emptyFooterContent" value="true"/>
<c:if test="${!empty marketingSpotDatas.baseMarketingSpotActivityData && param.fromPage == 'footer'}">
	<c:set var="emptyFooterContent" value="false"/>
</c:if>

<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status3">
    <c:if test='${marketingSpotData.dataType eq "MarketingContent"}'>
    
        <c:set var="currentRowCount" value="${currentRowCount+1}" />

        <%--
          *
          * Set up the URL to call when the image or text is clicked.
          *
        --%>
		<c:set var="contentClickUrl" value="${param.contentClickUrl}"/>
		<c:if test = "${empty contentClickUrl}">
			<c:url value="${marketingSpotData.marketingContent.url}" var="contentClickUrl">
				<c:if test="${!empty param.errorViewName}" >
					<c:param name="errorViewName" value="${param.errorViewName}" />
					<c:if test="${!empty param.orderId}">
						<c:param name="orderId" value="${param.orderId}"/>
					</c:if>
				</c:if>
			</c:url>
		</c:if>

        <c:url value="${clickInfoCommand}" var="ClickInfoURL">
            <c:param name="evtype" value="CpgnClick" />
            <c:param name="mpe_id" value="${marketingSpotDatas.marketingSpotIdentifier.uniqueID}" />
            <c:param name="intv_id" value="${marketingSpotData.activityIdentifier.uniqueID}" />
            <c:param name="storeId" value="${storeId}" />
            <c:param name="catalogId" value="${catalogId}" />
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
				<c:set target="${contentFormatMap}" property="${currentRowCount}" value="File" />
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
                
                <c:set var="contentMimeType" value="${marketingSpotData.marketingContent.mimeType}"/>
                <c:set var="assetMimeType" value="${attachment.attachmentAsset[assetIndex].mimeType}"/>
                <c:if test="${(empty contentMimeType) && 
                	(fn:endsWith(attachment.attachmentAsset[assetIndex].attachmentAssetPath, '.gif') ||
                	 fn:endsWith(attachment.attachmentAsset[assetIndex].attachmentAssetPath, '.jpg') ||
                	 fn:endsWith(attachment.attachmentAsset[assetIndex].attachmentAssetPath, '.jpeg') ||
                	 fn:endsWith(attachment.attachmentAsset[assetIndex].attachmentAssetPath, '.png')	)}">
                	 <c:set var="contentMimeType" value="image"/>
                </c:if>
                <c:if test="${(empty contentMimeType) && (fn:endsWith(attachment.attachmentAsset[assetIndex].attachmentAssetPath, '.swf') )}">
                	<c:set var="contentMimeType" value="application"/>
                	<c:set var="assetMimeType" value="application/x-shockwave-flash"/>
                </c:if>
                
                <c:set var="contentPath" value=""/>
                <c:choose>
                	<c:when test="${(fn:startsWith(attachment.attachmentAsset[assetIndex].attachmentAssetPath, 'http://') ||
                		fn:startsWith(attachment.attachmentAsset[assetIndex].attachmentAssetPath, 'https://')	)}">
                		<c:set var="contentPath" value="${attachment.attachmentAsset[assetIndex].attachmentAssetPath}"/>
                	</c:when>
                	<c:when test="${empty attachment.attachmentAsset[assetIndex].rootDirectory}">
                		<c:set var="contentPath" value="${hostPath}${storeImgDir}${attachment.attachmentAsset[assetIndex].attachmentAssetPath}"/>
                	</c:when>
                	<c:otherwise>
                		<c:set var="contentPath" value="${hostPath}${env_imageContextPath}/${attachment.attachmentAsset[assetIndex].rootDirectory}/${attachment.attachmentAsset[assetIndex].attachmentAssetPath}"/>
                	</c:otherwise>
                </c:choose>		
            	
				  	 <c:choose>
	              		<c:when test="${(contentMimeType eq 'image') || (contentMimeType eq 'images')}">
						<c:set target="${contentTypeMap}" property="${currentRowCount}" value="image" />
						<c:choose>
							<c:when test="${param.isCategorySubsriptionDisplayURL eq true or WCParam.isCategorySubsriptionDisplayURL eq true}">
								<img id="divider" alt="" src="${jspStoreImgDir}${env_vfileColor}left_nav_divider.gif" />
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
										<img id="CategorySubscriptionImage" src='${contentPath}'
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
									<c:set target="${contentUrlMap}" property="${currentRowCount}" value="${env_absoluteUrl}${ClickInfoURL}" />
								</c:if>
									<c:set target="${contentImageMap}" property="${currentRowCount}" value="${contentPath}" />
									<c:set target="${contentDescriptionMap}" property="${currentRowCount}" value="${attachment.attachmentDescription[descriptionIndex].shortDescription}" />
									
							</c:otherwise>
						</c:choose>
			          </c:when>

                    <c:when test="${(contentMimeType eq 'application') ||
                                    (contentMimeType eq 'applications') ||
                                    (contentMimeType eq 'text') ||
                                    (contentMimeType eq 'textyv') ||
                                    (contentMimeType eq 'video') ||
                                    (contentMimeType eq 'audio') ||
                                    (contentMimeType eq 'model')
                                    }">
						<c:set target="${contentTypeMap}" property="${currentRowCount}" value="application" />
                        <%--
                          *
                          * Display the content: flash, audio, or other.
                          *
                        --%>
                        <c:choose>
                            <c:when test="${(assetMimeType eq 'application/x-shockwave-flash')}" >
								<c:set target="${contentFlashMap}" property="${currentRowCount}" value="true" />
								
								<c:set target="${contentDescriptionMap}" property="${currentRowCount}" value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}" />
								
								<c:set target="${contentUrlMap}" property="${currentRowCount}" value="${contentPath}" />                          
                            </c:when>
							
                            <c:otherwise>
								<c:set target="${contentFlashMap}" property="${currentRowCount}" value="false" />
								
								<c:set target="${contentAssetPathMap}" property="${currentRowCount}" value="${contentPath}" /> 
                <c:set target="${contentImageMap}" property="${currentRowCount}" value="${hostPath}${env_imageContextPath}/${attachment.attachmentAsset[assetIndex].rootDirectory}/${attachment.attachmentUsage.image}"/>
								
								<c:set target="${contentDescriptionMap}" property="${currentRowCount}" value="${attachment.attachmentDescription[descriptionIndex].shortDescription}"/>
								
								
								 <c:if test="${!empty marketingSpotData.marketingContent.url}">
									<c:set target="${contentUrlMap}" property="${currentRowCount}" value="${env_absoluteUrl}${ClickInfoURL}" />								
									
									<c:set target="${contentTextMap}" property="${currentRowCount}" value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}"/>
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
						
						<c:set target="${contentAssetPathMap}" property="${currentRowCount}" value="${marketingSpotData.marketingContent.attachment.attachmentAsset[0].attachmentAssetPath}" />
						                        					
                        <c:if test="${!empty marketingSpotData.marketingContent.url}">
                            <c:set target="${contentUrlMap}" property="${currentRowCount}" value="${env_absoluteUrl}${ClickInfoURL}" />
                        </c:if>
                        
                        <c:if test="${!empty marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}">
                           	<c:set target="${contentTextMap}" property="${currentRowCount}" value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}"/>
                        </c:if>
                        												
                    </c:otherwise>
                </c:choose>
            </c:when>
            
            <c:when test="${marketingSpotData.marketingContent.marketingContentFormat.name == 'Text'}">
				<c:set target="${contentFormatMap}" property="${currentRowCount}" value="Text" />
                <c:choose>
                    <c:when test="${param.isCategorySubsriptionDisplayURL eq true or WCParam.isCategorySubsriptionDisplayURL eq true}">
                        <img id="divider" alt="" src="${jspStoreImgDir}${env_vfileColor}left_nav_divider.gif" />
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
							<c:set target="${contentUrlMap}" property="${currentRowCount}" value="${env_absoluteUrl}${ClickInfoURL}" />
                        </c:if>
						
							<c:set target="${contentTextMap}" property="${currentRowCount}" value="${marketingSpotData.marketingContent.marketingContentDescription[0].marketingText}"/>
							         
                    </c:otherwise>
                </c:choose>
                
            </c:when>
            
        </c:choose>        

    </c:if>
</c:forEach>

<fmt:message key="ES_CONTENT_RECOMMENDATION" var="espotTypeInfo"/>	

<%--
  *
  * End: Content
  *
--%>
