<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ include file="FacetFilter.jspf" %>
<c:set var="f" value="0" />
<c:set var="price_facet_index" value="-1"/>
<c:set var="sType" value="${WCParam.sType}"/>
<c:if test="${empty sType}">
	<c:set var="sType" value="SimpleSearch"/>
</c:if>

<c:set var="pageView" value="${WCParam.pageView}" scope="request"/>
<c:if test="${empty pageView}" >
	<c:set var="pageView" value="${env_defaultPageView}" scope="request"/>
</c:if>

<c:forEach var="facetField" items="${globalcategories}">
	<c:if test="${facetField.value eq 'parentCatgroup_id_search'}">
		<c:if test="${fn:length(facetField.entry) > 0}">
			<%@ include file="CategoryFacetDisplay.jspf" %>
		</c:if>
	</c:if>
</c:forEach>

<wcf:useBean var="brandFacetArray" classname="java.util.ArrayList"/>	
<wcf:useBean var="priceFacetArray" classname="java.util.ArrayList"/>	
<wcf:useBean var="facetArray" classname="java.util.ArrayList"/>	
<c:forEach var="facetField" items="${globalfacets}">
	<c:if test="${fn:length(facetField.entry) > 1}">
		<c:choose>				
			<c:when test="${facetField.value eq 'parentCatgroup_id_search'}">
			</c:when>
			<c:when test="${fn:startsWith(facetField.value, 'price_')}">
				<c:if test="${globalpricemode != 0}">
					<c:set var="facetsGreaterThanZero" value="0"/>
					<c:forEach var="item" items="${facetField.entry}">
						<c:if test="${item.count > 0}">
							<c:set var="facetsGreaterThanZero" value="${facetsGreaterThanZero + 1}"/>
						</c:if>
					</c:forEach>
					<c:if test="${facetsGreaterThanZero > 0}">
						<%@ include file="PriceFacetDisplay.jspf" %>
						<c:set var="price_facet_index" value="${f}"/>
						<c:set var="f" value="${f + 1}" />					
					</c:if>
				</c:if>
			</c:when>
			<c:otherwise>
				<%@ include file="FacetDisplay.jspf" %>
				<c:set var="f" value="${f + 1}" />
			</c:otherwise>
		</c:choose>
	</c:if>
</c:forEach>
