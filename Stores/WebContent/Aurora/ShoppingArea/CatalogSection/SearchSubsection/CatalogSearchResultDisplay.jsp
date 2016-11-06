<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%-- 
  *****
  * This JSP file renders the search results depending on the shopper's search criteria.
  *****
--%>
<!-- BEGIN CatalogSearchResultDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="flow.tld" prefix="flow" %>

<flow:ifEnabled feature="SearchBasedNavigation">
	<%@ include file="SearchBasedNavigationResultDisplay.jsp"%>
</flow:ifEnabled>
<flow:ifDisabled feature="SearchBasedNavigation">
	<%@ include file="CatalogSearchResultDisplayBody.jsp"%>
</flow:ifDisabled>

<!-- END CatalogSearchResultDisplay.jsp -->
