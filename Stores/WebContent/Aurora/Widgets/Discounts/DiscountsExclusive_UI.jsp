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
	<c:forEach var="discount" items="${discountsMap}" varStatus="discountCounter">
		<c:if test="${!discountCounter.first}">
			<div class="clear_float"></div>
			<div class="item_spacer_2px"></div>
		</c:if>

		<a class="promotion" href="${discount.value}"><c:out value="${discount.key}" escapeXml="false" /></a>

<%--	<div class="madisons_exclusive left">
			<a id="WC_DiscountsExclusive_Link_${discountCounter.count}" href="${discount.value}"><c:out value="${discount.key}" escapeXml="false" /></a>
		</div> --%>

	</c:forEach>
</c:if>