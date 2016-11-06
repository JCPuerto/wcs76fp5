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
  * This JSP file is used to display the category subscription e-marketing spot in the store.
  * The e-marketing spot allows online shoppers to subscribe to or unsubscribe from a category in the store.
  * The store marketing team can send out information update regarding the particular category of products, such as promotions, to this customer segment.
  * The e-marketing spot should created with name FurnitureSubscriptionESpot in Management Center.
  * 
  * How to use this snippet?
  *	This is an example of how this file could be imported to a page:
  *		<c:import url="${jspStoreDir}/Snippets/Catalog/CategoryDisplay/CategorySubscriptionDisplay.jsp">
  *			<c:param name="storeId" value="${WCParam.storeId}" />
  *			<c:param name="catalogId" value="${catalogId}" />
  *			<c:param name="langId" value="${langId}" />
  *		</c:import> 
  *****
--%>

<!-- BEGIN CategorySubscriptionDisplay.jsp -->

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>

<script type="text/javascript">
       dojo.addOnLoad(function() {
              <fmt:message key="SUBSCRIPTION_UPDATED" bundle="${storeText}" var="SUBSCRIPTION_UPDATED"/>
              MessageHelper.setMessage("SUBSCRIPTION_UPDATED", <wcf:json object="${SUBSCRIPTION_UPDATED}"/>);
       });
</script>

<% out.flush(); %>
<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
	<c:param name="storeId" value="${WCParam.storeId}" />
	<c:param name="catalogId" value="${param.catalogId}" />
	<c:param name="langId" value="${param.langId}" />
	<c:param name="emsName" value="CategorySubscriptions" />
	<c:param name="isCategorySubsriptionDisplayURL" value="true" />
</c:import>
<% out.flush(); %>

<!-- END CategorySubscriptionDisplay.jsp -->
