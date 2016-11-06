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
<div id="widget_breadcrumb">
	<ul>
		<%-- Iterate through the bread crumb map --%>
		<c:forEach var="breadCrumb" items="${breadCrumbItemsMap}" varStatus="status">
			<li><a id="WC_BreadCrumb_Link_${status.count}" href="${breadCrumb.value}"><c:out value="${breadCrumb.key}"/></a></li>
			<span class="divider">\</span>
		</c:forEach>
		<%-- Display the last item as plain text and not as link --%>
		<li class="current">${lastBreadCrumbItem}</li>
	</ul>
</div>