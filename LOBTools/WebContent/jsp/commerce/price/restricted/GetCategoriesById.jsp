<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>
<wcf:getData
	type="com.ibm.commerce.catalog.facade.datatypes.CatalogGroupType[]"
	var="categories" expressionBuilder="getCatalogGroupDetailsByIDs" varShowVerb="showVerb">
	<wcf:contextData name="storeId" data="${param.storeId}" />
	<wcf:contextData name="catalogId" data="${param.masterCatalogId}" />
	<wcf:param name="dataLanguageIds" value="${param.dataLanguageIds}"/>
	<c:forTokens var="value" items="${uniqueIDs}" delims=",">
		<wcf:param name="UniqueID" value="${value}" />
	</c:forTokens>
</wcf:getData>
<c:forEach var="catalogGroup" items="${categories}">
	<c:set var="showVerb" value="${showVerb}" scope="request"/>
	<c:set var="businessObject" value="${catalogGroup}" scope="request"/>
	<c:choose>
		<c:when test="${catalogGroup.catalogGroupIdentifier.externalIdentifier.storeIdentifier.uniqueID != param.storeId}">
			<c:set var="referenceObjectType" value="ChildInheritedCatalogGroup" />
			<c:set var="objectType" value="InheritedCatalogGroup" />
			<c:if test="${empty catalogGroup.parentCatalogGroupIdentifier}">
				<c:set var="objectType" value="InheritedSalesCatalogGroup" />
			</c:if>
		</c:when>
		<c:otherwise>
			<c:set var="referenceObjectType" value="ChildCatalogGroup" />
			<c:set var="objectType" value="CatalogGroup" />
			<c:if test="${empty catalogGroup.parentCatalogGroupIdentifier}">
				<c:set var="objectType" value="SalesCatalogGroup" />
			</c:if>
		</c:otherwise>
	</c:choose>
	<object objectType="${referenceObjectType}">
		<childCatalogGroupId>${catalogGroup.catalogGroupIdentifier.uniqueID}</childCatalogGroupId>
		<jsp:directive.include file="../../catalog/restricted/serialize/SerializeCatalogGroup.jspf" />
	</object>
</c:forEach>
