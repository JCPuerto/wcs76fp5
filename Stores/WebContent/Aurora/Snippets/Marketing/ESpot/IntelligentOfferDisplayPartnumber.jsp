<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2010 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  *****
  * This JSP file renders an individual catalog entry in a scrolling
  * e-Marketing Spot. 
  * This JSP requires the following parameters:
  *   partNumber - the part number of the catalog entry to display. The
  *                catalog entry ID is looked up based on the partnumber,
  *                and the JSP snippet CatalogEntryThumbnailDisplay.jsp
  *                is used to display the catalog entry
  *   catalogEntryIdentifier - the catalog entry identifier of the catalog entry to display
  *                and the JSP snippet CatalogEntryThumbnailDisplay.jsp
  *                is used to display the catalog entry
  *   count - The number of the catalog entry within the scrollable pane.
  *   zoneId - The ID of the Intelligent Offer zone. Any whitespace in the zone
  *            name should be removed.
  *   langId - the current language ID
  *   storeId - the current store ID
  *   catalogId - the current catalog ID  
  *   emsName - the name of the e-Marketing in which the recommendations are displayed
  *   mpe_id - the ID of the e-Marketing in which the recommendations are displayed. 
  *            This is used for the ClickInfo url.
  *   intv_id - the ID of the web activity which specified that Intelligent Offer
  *             recommendations should be displayed. This is used for the ClickInfo url.
  *   experimentId - the ID of the experiment which specified that Intelligent Offer
  *             recommendations should be displayed. This is used for the ClickInfo url.
  *   testElementId - the ID of the test element which specified that Intelligent Offer
  *             recommendations should be displayed. This is used for the ClickInfo url.    
  *   activityName - the name of the activity which provided the recommendation. 
  *            This is used for Analytics reporting.
  *   campaignName - the name of the campaign to which the activity belongs.
  *             This is used for Analytics reporting.
  *   experimentName - the name of the experiment which provided the recommendation. 
  *            This is used for Analytics reporting.
  *   testElementName - the name of the test element which provided the recommendation. 
  *            This is used for Analytics reporting.
  *   controlElement - is the test element which provided the recommendation a control element. 
  *            This is used for Analytics reporting.
  * 
  * How to use this snippet?
	*	<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/IntelligentOfferDisplayPartnumber.jsp">
	*		<c:param name="partNumber" value="${currentPartnumber}"/>
	*		<c:param name="count" value="${status.count}"/>
	*	</c:import>
  *****
--%>

<!-- BEGIN IntelligentOfferDisplayPartnumber.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics" prefix="cm" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="partNumber" value="${param.partNumber}"/>
<c:set var="catalogEntryIdentifier" value="${param.catEntryIdentifier}"/>

<c:choose>
	<c:when test="${!empty partNumber}">
		<wcf:getData type="com.ibm.commerce.catalog.facade.datatypes.CatalogEntryType" var="catentry" expressionBuilder="getPublishedCatalogEntrySummaryByPartNumber">
			<wcf:contextData name="storeId" data="${WCParam.storeId}"/>
			<wcf:param name="partNumber" value="${param.partNumber}"/>
			<wcf:param name="dataLanguageIds" value="${WCParam.langId}"/>
		</wcf:getData>
		<c:set var="catalogEntryIdentifier" value="${catentry.catalogEntryIdentifier.uniqueID}"/>
		<c:remove var="catEntry" />
		<c:forEach var="catEntry" items="${catentry.description}">
			<c:set var="catalogEntryName" value="${catEntry.name}" />
		</c:forEach>
	</c:when>
	<c:otherwise>
		<c:remove var="catEntry" />
		<wcbase:useBean id="catEntry" classname="com.ibm.commerce.catalog.beans.CatalogEntryDataBean">
			  <c:set property="catalogEntryID" value="${catalogEntryIdentifier}" target="${catEntry}" />
		</wcbase:useBean>
		<c:set var="catalogEntryName" value="${catEntry.description.name}" />
	</c:otherwise>
</c:choose>
		
		<c:if test="${!empty catalogEntryIdentifier}">

			<c:set var="uniqueId" value="IntelligentOfferDisplayPartnumber_div_item_${param.count}_${param.zoneId}"/>
				
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
				
			<c:set var="clickInfoURLForAnalytics" value="${clickInfoCommand}" />
				
			<%-- Coremetrics tag --%>
			<flow:ifEnabled feature="Analytics">
						<cm:campurl id="clickInfoCommand" url="${clickInfoURLForAnalytics}" 
							name="${catalogEntryName}" initiative="${param.intv_id}"
							activityName="${param.activityName}" campaignName="${param.campaignName}" marketingSpotName="${param.emsName}" 
							experimentName="${param.experimentName}" testElementName="${param.testElementName}" controlElement="${param.controlElement}"/>
			</flow:ifEnabled>
			<%-- Coremetrics tag --%>		
				    
			<div dojoType="dijit.layout.ContentPane" class="imgContainer" id="<c:out value='${uniqueId}'/>">
		  <%out.flush();%>
			<c:import url="${jspStoreDir}Snippets/Catalog/CatalogEntryDisplay/CatalogEntryThumbnailDisplay.jsp">
				<c:param name="contentAreaESpot" value="false"/>
				<c:param name="langId" value="${langId}" />						
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${WCParam.catalogId}" />
				<c:param name="emsName" value="${param.emsName}" />
				<c:param name="skipAttachments" value="true"/>
				<c:param name="pageView" value="scrollESpot"/>
				<c:param name="prefix" value="intelligentOffer"/>
				<c:param name="catEntryIdentifier" value="${catalogEntryIdentifier}"/>
				<c:param name="useClickInfoURL" value="true"/>
				<c:param name="categoryId" value="${WCParam.categoryId}"/>
				<c:param name="top_category" value="${WCParam.top_category}"/>
				<c:param name="parent_category_rn" value="${WCParam.parent_category_rn}"/>
				<c:param name="mpe_id" value="${param.mpe_id}" />
				<c:param name="intv_id" value="${param.intv_id}" />
				<c:param name="experimentId" value="${param.experimentId}" />
				<c:param name="testElementId" value="${param.testElementId}" />
				<c:param name="expDataType" value="CatalogEntry" />		
				<c:param name="clickInfoCommand" value="${clickInfoCommand}"/>				
			</c:import>
		  <%out.flush();%>
		  </div>
		  
		  <script type="text/javascript">
				dojo.addOnLoad(function() { 
					parseWidget("<c:out value="${uniqueId}"/>");
				});
			</script>
							
		</c:if>

<!-- END IntelligentOfferDisplayPartnumber.jsp -->
