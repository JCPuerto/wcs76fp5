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
<script>
	addToWidgetsList("tabContainer");
	dojo.subscribe('AttachmentPagination_Context',ProductTabJS,'showAttachmentPage');
	wc.render.getRefreshControllerById("AttachmentPagination_Controller").url='${AttachmentPaginationURL}';
</script>
<div id="tabContainer" class="widget_tab_container" role="tablist">
	<div class="header">
		<ul>
			<c:set var="numberOfTabs" value="1" />
			<c:set var="currentTab" value="1" />
			<flow:ifEnabled feature="RatingReviewIntegration">
				<c:set var="numberOfTabs" value="${numberOfTabs+1}" />
			</flow:ifEnabled>
			<flow:ifEnabled feature="IntelligentOffer">
				<c:set var="numberOfTabs" value="${numberOfTabs+1}" />
			</flow:ifEnabled>
			<li id="tab1" class="first_tab selected">
				<a role="tab" aria-setsize="${numberOfTabs}" aria-posinset="${currentTab}" aria-selected="true" id="tab1_link" onclick="ProductTabJS.selectTab('tab1');" onkeydown="ProductTabJS.selectTabWithKeyboard('tab1', event);" href="javascript:void(0);" 
					onfocus="javascript:ProductTabJS.focusTab('tab1');"
					onblur="javascript:ProductTabJS.blurTab('tab1');"><fmt:message key="PT_TECHNICAL_SPECIFICATIONS"/></a>
			</li>
			<c:set var="currentTab" value="${currentTab+1}" />
		    <flow:ifEnabled feature="RatingReviewIntegration">
			<li id="tab2">
				<a role="tab" aria-setsize="${numberOfTabs}" aria-posinset="${currentTab}" id="tab2_link" onclick="ProductTabJS.selectTab('tab2');" onkeydown="ProductTabJS.selectTabWithKeyboard('tab2', event);" href="javascript:void(0);" 
					onfocus="javascript:ProductTabJS.focusTab('tab2');"
					onblur="javascript:ProductTabJS.blurTab('tab2');"><fmt:message key="PT_CUSTOMER_REVIEWS"/></a>
			</li>
			<c:set var="currentTab" value="${currentTab+1}" />
		    </flow:ifEnabled>
			<flow:ifEnabled feature="IntelligentOffer">
			<li id="tab3">
				<a role="tab" aria-setsize="${numberOfTabs}" aria-posinset="${currentTab}" id="tab3_link" onclick="ProductTabJS.selectTab('tab3');" onkeydown="ProductTabJS.selectTabWithKeyboard('tab3', event);" href="javascript:void(0);" 
					onfocus="javascript:ProductTabJS.focusTab('tab3');"
					onblur="javascript:ProductTabJS.blurTab('tab3');"><fmt:message key="PT_OTHER_CUSTOMERS_ALSO_PURCHASED"/></a>
			</li>
			</flow:ifEnabled>
		</ul>
	</div>
	<div id="productTabContainer" class="content padding_sides" dojoType="dijit.layout.TabContainer" doLayout="false" tabPosition="left-h" class="content">
	    <div id="tab1_content" dojoType="dijit.layout.ContentPane">
			<%out.flush();%>
				<c:import url="${env_jspStoreDir}Widgets/TechnicalSpecification/TechnicalSpecification.jsp">
					<c:param name="excludeUsageStr" value="${excludeUsageStr}"/>
				</c:import>
			<%out.flush();%>
	    </div>
	    <div id="tab2_content" dojoType="dijit.layout.ContentPane">
		<flow:ifEnabled feature="RatingReviewIntegration">
			<c:set target="${reviewParameters}" property="display" value="details" />
			<%@ include file="../Reviews/ReviewDisplay.jspf"%>
		</flow:ifEnabled>
	    </div>
	    <div id="tab3_content" dojoType="dijit.layout.ContentPane">
	    	<!-- Intelligent offer product recommendations -->
			<flow:ifEnabled feature="IntelligentOffer">
				<div class="widget_product_listing_position">
					<c:choose>
						<c:when test="${env_fetchMarketingDetailsOnLoad}">
							<div dojoType="wc.widget.RefreshArea" widgetId="IntelligentOffer_widget" id ="IntelligentOffer_widget" controllerId="IntelligentOffer_Controller">
							</div>
						</c:when>	
						<c:otherwise>
							<%out.flush();%>
							<c:import url="${env_jspStoreDir}Widgets/ESpot/IntelligentOffer/IntelligentOffer.jsp">
								<c:param name="emsName" value="Product_IntellOffer" />
								<c:param name="catalogId" value="${WCParam.catalogId}" />
								<c:param name="partNumber" value="${param.partNumber}" />
								<c:param name="parentCategoryId" value="${param.categoryId}" />
								<c:param name="mainProductId" value="${param.productId}" />
								<c:param name="pagination" value="false" />
								<c:param name="pageView" value="list" />
								<c:param name="showBorder" value="false" /><%-- No need to show the border when inside the tab. --%>
								<c:param name="showHeader" value="false" /><%-- No need to show the header when inside the tab. --%>
								<c:param name="showCompareBox" value="false" /><%-- No need to show the compare box when inside the tab. --%>
								<c:param name="updateSwatch" value="true" /><%-- Since it is list view, swatch needs to be selected by default. --%>
							</c:import>
							<%out.flush();%>
						</c:otherwise>
					</c:choose>
				</div>	
			</flow:ifEnabled>
	    </div>
	</div>
</div>