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
  * This JSP page wrappers ScrollingProductsESpot.jsp. 
  * It was created so that the page segment is not cached at ScrollingProductsESpot.jsp but rather at this file level. 
  * 
  * This is an example of how this file could be included into a page: 
  *<c:import url="${jspStoreDir}Snippets/Catalog/CategoryDisplay/ProductRecommendationsDisplay.jsp">
  *          <c:param name="storeId" value="${storeId}"/>
  *          <c:param name="catalogId" value="${catalogId}"/>
  *          <c:param name="langId" value="${langId}"/>
  *</c:import>
  *****
--%>

<!-- BEGIN ProductRecommendationsDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<% out.flush(); %>
<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ScrollingProductsESpot.jsp">
	<c:param name="emsName" value="HomePageFeaturedProducts" />
	<c:param name="scrollable" value="true" />
	<c:param name="catalogId" value="${WCParam.catalogId}" />
	<c:param name="skipAttachments" value="true"/> <%-- do not load attachments --%>
</c:import>
<% out.flush(); %>

<!-- END ProductRecommendationsDisplay.jsp -->
