<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<c:if test="${!empty discounts.calculationCodeDataBeans}" >
	<p>
		<c:forEach var="discount" items="${discountsMap}" varStatus="status">
			<br/><a id="WC_Discounts_Link_${status.count}" href="${discount.value}"><c:out value="${discount.key}" escapeXml="false" /></a>
		</c:forEach>
	</p>
</c:if>