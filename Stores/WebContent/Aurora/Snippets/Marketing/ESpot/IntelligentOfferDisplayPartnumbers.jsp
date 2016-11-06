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
  * This JSP file renders the dynamic recommendations from Coremetrics Intelligent
  * Offer. The callback function io_rec_zp in wczpf.js will update the context
  * WC_IntelligentOfferESpot_context_ID_<<zoneId>>. This will call the URL
  * AjaxIntelligentOfferDisplayView to update the refresh area on the page.
  * The AjaxIntelligentOfferDisplayView URL is associated with this JSP page. 
  * This JSP requires the following parameters to be included on the URL:
  *   partNumbers - a comma separated list of catalog entry partnumbers 
  *                 that have been returned as recommendations from Intelligent
  *                 Offer
  *   zoneId - The ID of the Intelligent Offer zone. Any whitespace in the zone
  *            name should be removed.
  *   espotTitle - The title to display above the catalog entry recommendations.
  *                This is set up in the Intelligent Offer tool.
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
  * This snippet is not intended to be directly included on a store page. It
  * is associated with a refresh area that will display when recommendations
  * are returned from Intelligent Offer.
  *****
--%>

<!-- BEGIN IntelligentOfferDisplayPartnumbers.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<c:set var="espotTitle" value="${param.espotTitle}"/>

<c:if test="${empty param.partNumbers}">
	<wcf:getData type="com.ibm.commerce.marketing.facade.datatypes.MarketingSpotDataType" var="marketingSpotDatas" expressionBuilder="findByMarketingSpotName">

		<%-- the name of the e-Marketing Spot --%>
		<wcf:param name="DM_EmsName" value="${param.emsName}" />

		<%-- do not retrieve the catalog entry SDO but obtain the catalog entry Id only --%>
		<wcf:param name="DM_ReturnCatalogEntryId" value="true" />
		 <%-- retrieve the default content only --%>
		<wcf:param name="DM_ReturnDefaultContentOnly" value="true" />
		<fmt:message key="RECOMMENDATIONS" bundle="${storeText}" var="espotTitle"/>
	</wcf:getData>
</c:if>

<c:set var="WC_zone" value="${param.zoneId}"/>

<c:set var="totalDisplayNodes" value="${param.totalDisplayNodes}"/>
<c:if test='${empty totalDisplayNodes}'>
	<c:set var="totalDisplayNodes" value="4"/>
</c:if>

<c:set var="itemSize" value="135"/>
<c:if test='${totalDisplayNodes eq 5}'>
	<c:set var="itemSize" value="139"/>
</c:if>
	
 <c:if test='${totalDisplayNodes eq 4}'><div id="content588"></c:if>
 <c:if test='${totalDisplayNodes eq 5}'><div id="content759"></c:if>
   <div id="box" class="small_box"> 
				<div class="contentgrad_header" id="IntelligentOfferDisplayPartnumbers_div_1_<c:out value='${WC_zone}'/>">
					 <div class="left_corner" id="IntelligentOfferDisplayPartnumbers_div_2_<c:out value='${WC_zone}'/>"></div>
					 <div class="left" id="IntelligentOfferDisplayPartnumbers_div_3_<c:out value='${WC_zone}'/>"><span class="contentgrad_text"><c:out value="${espotTitle}"/></span></div>
					 <div class="right_corner" id="IntelligentOfferDisplayPartnumbers_div_4_<c:out value='${WC_zone}'/>"></div>
				</div>
				<c:if test='${totalDisplayNodes eq 4}'><div class="body588" id="IntelligentOfferDisplayPartnumbers_div_5_a_<c:out value='${WC_zone}'/>"></c:if>
				<c:if test='${totalDisplayNodes eq 5}'><div class="body759" id="IntelligentOfferDisplayPartnumbers_div_5_b_<c:out value='${WC_zone}'/>"></c:if>
					<div id="IntelligentOfferDisplayPartnumbers_div_scroll_<c:out value='${WC_zone}'/>" dojoType="wc.widget.ScrollablePane" autoScroll='false' scrollByPage="true" totalDisplayNodes="${totalDisplayNodes}" itemSize="${itemSize}" altPrev = '<fmt:message key="SCROLL_LEFT" bundle="${storeText}" />' altNext = '<fmt:message key="SCROLL_RIGHT" bundle="${storeText}" />' tempImgPath = "<c:out value='${jspStoreImgDir}'/>images/empty.gif">

						<c:set var="checkCount" value='0'/>
						<div id="IntelligentOfferDisplayPartnumbers_div_6_<c:out value='${WC_zone}'/>">
							<c:choose>
								<c:when test="${!empty param.partNumbers}">
									<c:forTokens items="${param.partNumbers}" delims="," var="currentPartnumber" varStatus="status">
						 
										<c:set var="checkCount" value='${checkCount+1}'/>
										<c:if test="${checkCount > 4}">
											<c:set var="checkCount" value='0'/>
											</div>
											<div id="IntelligentOfferDisplayPartnumbers_div_7_<c:out value='${status.count}'/>_<c:out value='${WC_zone}'/>">
										</c:if>

										<%out.flush();%>
											<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/IntelligentOfferDisplayPartnumber.jsp">
												<c:param name="partNumber" value="${currentPartnumber}"/>
												<c:param name="count" value="${status.count}"/>
											</c:import>
										<%out.flush();%>

									</c:forTokens>
								</c:when>
								<c:otherwise>
									<c:forEach var="marketingSpotData" items="${marketingSpotDatas.baseMarketingSpotActivityData}" varStatus="status">
										<c:if test='${marketingSpotData.dataType eq "CatalogEntryId"}'>
											<c:set var="checkCount" value='${checkCount+1}'/>
											<c:if test="${checkCount > 4}">
												<c:set var="checkCount" value='0'/>
												</div>
												<div id="IntelligentOfferDisplayPartnumbers_div_7_<c:out value='${status.count}'/>_<c:out value='${WC_zone}'/>">
											</c:if>

											<%out.flush();%>
												<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/IntelligentOfferDisplayPartnumber.jsp">
													<c:param name="catEntryIdentifier" value="${marketingSpotData.uniqueID}"/>
													<c:param name="count" value="${status.count}"/>
												</c:import>
											<%out.flush();%>
											
										</c:if>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
					
					</div>
					<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("IntelligentOfferDisplayPartnumbers_div_scroll_<c:out value='${WC_zone}'/>"); });</script>
					<br/>
				</div>
				
				<div class="footer" id="IntelligentOfferDisplayPartnumbers_div_8_<c:out value='${WC_zone}'/>">
					 <div class="left_corner" id="IntelligentOfferDisplayPartnumbers_div_9_<c:out value='${WC_zone}'/>"></div>
					 <div class="left" id="IntelligentOfferDisplayPartnumbers_div_10_<c:out value='${WC_zone}'/>"></div>
					 <div class="right_corner" id="IntelligentOfferDisplayPartnumbers_div_11_<c:out value='${WC_zone}'/>"></div>
				</div>
   </div>
 </div>		
			
<!-- END IntelligentOfferDisplayPartnumbers.jsp -->
