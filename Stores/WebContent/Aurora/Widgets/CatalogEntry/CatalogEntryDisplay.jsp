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

<!-- BEGIN CatalogEntryDisplay.jsp -->

<%@ include file= "../../Common/EnvironmentSetup.jspf" %>

<%-- If param catEntryIdentifier is passed, then give preference to it, else it should be set in request scope somewhere else --%>
<c:if test = "${!empty param.catEntryIdentifier}">
	<c:set var="catEntryIdentifier" value="${param.catEntryIdentifier}"/>
</c:if>
<c:set var="cmcrurl" value="${param.cmcrurl}"/>


<%@ include file="ext/CatalogEntryDisplay_Data.jsp" %>

<c:if test = "${param.custom_data ne 'true'}">
	<c:choose>
		<c:when test = "${param.pageView == 'list' or param.pageView == 'miniList' }">
			<c:set var="productId" value="${catEntryIdentifier}"/> <%-- ProductDescription_Data expects us to pass productId --%>
			<%@ include file="../ProductDescription/ProductDescription_Data.jsp" %>
		</c:when>
		<c:otherwise>
			<%@ include file="CatalogEntryDisplay_Data.jsp" %>
		</c:otherwise>
	</c:choose>
</c:if>

<%@ include file="ext/CatalogEntryDisplay_UI.jsp" %>
<c:if test = "${param.custom_view ne 'true'}">
	<c:choose>
		<c:when test = "${param.pageView == 'sidebar'}">
			<%@ include file="CatalogEntryDisplay_SideBarView_UI.jsp" %>
		</c:when>
		<c:when test="${param.pageView == 'grid'}">
			<%@ include file="CatalogEntryDisplay_GridView_UI.jsp" %>
		</c:when>
		<c:when test="${param.pageView == 'list'}">
			<%@ include file="CatalogEntryDisplay_ListView_UI.jsp" %>
		</c:when>
		<c:when test="${param.pageView == 'miniList'}">
			<%@ include file="CatalogEntryDisplay_MiniListView_UI.jsp" %>
		</c:when>
		<c:when test="${param.pageView == 'miniGrid'}">
			<%@ include file="CatalogEntryDisplay_MiniGridView_UI.jsp" %>
		</c:when>
		<c:otherwise>
			<%-- Default to mini grid view... --%>
			<%@ include file="CatalogEntryDisplay_MiniGridView_UI.jsp" %>
		</c:otherwise>
	</c:choose>
</c:if>

<c:remove var="emptyPriceString"/>
<c:remove var="priceString"/>
<c:remove var="indexedPrice"/>
<c:remove var="listPrice"/>
<c:remove var="calculatedPrice"/>
<c:remove var="strikedPriceString"/>
<c:remove var="minimumPriceString"/>
<c:remove var="maximumPriceString"/>
<c:remove var="isDKPreConfigured"/>		
<c:remove var="isDKConfigurable"/>

<jsp:useBean id="CatalogEntry_TimeStamp" class="java.util.Date" scope="request"/>

<!-- END CatalogEntryDisplay.jsp -->