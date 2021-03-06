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

<%@ include file="JSTLEnvironmentSetupExtForSearch.jspf" %>

<wcf:url var="searchView" value="SearchDisplay" type="Ajax"/>

<c:url var="SearchAutoSuggestServletURL" value="SearchComponentAutoSuggestView">
  <c:param name="coreName" value="${coreName}" />
  <c:param name="serverURL" value="${serverURL}" />
  <c:param name="langId" value="${param.langId}" />
  <c:param name="storeId" value="${param.storeId}" />
  <c:param name="catalogId" value="${param.catalogId}" />
</c:url>

<c:url var="CachedSuggestionsURL" value="SearchComponentCachedSuggestionsView">
  <c:param name="langId" value="${param.langId}" />
  <c:param name="storeId" value="${param.storeId}" />
  <c:param name="catalogId" value="${param.catalogId}" />
</c:url>

<wcbase:useBean id="newcatalog" classname="com.ibm.commerce.catalog.beans.CategoryHierarchyDataBean">
	<c:set value="${param.catalogId}" target="${newcatalog}" property="catalogId"/>	
	<c:set value="1" target="${newcatalog}" property="catalogLevelNumber"/>	
</wcbase:useBean>

<wcf:useBean var="searchDropdownCategoryList" classname="java.util.ArrayList"/>

<c:forEach var="topCategory" items="${newcatalog.categoryHierarchy}" varStatus="status">
	<wcf:useBean var="categoryMappingList" classname="java.util.ArrayList"/>

	<wcf:set target="${categoryMappingList}" value="${topCategory.description.name}" />
	<wcf:set target="${categoryMappingList}" value="${topCategory.categoryId}" />
	<wcf:set target="${searchDropdownCategoryList}" value="${categoryMappingList}" />

	<c:remove var="categoryMappingList"/>
</c:forEach>
