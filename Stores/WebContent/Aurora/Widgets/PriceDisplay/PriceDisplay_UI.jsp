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

<c:if test="${empty catalogEntryID && !empty catEntryIdentifier}">
	<c:set var="catalogEntryID" value="${catEntryIdentifier}" />
</c:if>
<c:if test="${empty catalogEntryID && !empty WCParam.productId}">
	<c:set var="catalogEntryID" value="${WCParam.productId}" />
</c:if>

<c:choose>
	<%-- If the price is unavailable, print out the corresponding message --%>
	<c:when test="${!empty emptyPriceString}">
		<span id="offerPrice_${catalogEntryID}" class="price" itemprop="price"> 
			<c:out value="${emptyPriceString}"  escapeXml="false"/>
		</span>
	</c:when>
	
	<%-- If the price string has been set, then we simply print it out. --%>
	<c:when test="${!empty priceString}">
		<%-- Price as configured should be displayed only on dynamic kit page and not in category list or grid view --%>
		<c:if test="${type eq 'dynamickit' and pageView eq 'DynamicDisplayView'}">
			<span class="configured"><fmt:message key="DK_PRICE_AS_CONFIGURED"/>&nbsp;</span>
		</c:if>
		<span id="offerPrice_${catalogEntryID}" class="price" itemprop="price">
			<c:out value="${priceString}" escapeXml="false"/>
		</span>
	</c:when>
	
	<%-- If the list price does not exist or is smaller than the offer price, print out both the offer price only. --%>
	<c:when test="${dataBean && (!listPriced || (empty displayPrice || displayPrice <= offerPrice))}">
		<span id="offerPrice_${catalogEntryID}" class="price" itemprop="price">
			<c:out value="${offerPriceString}"  escapeXml="false"/>
		</span>
	</c:when>
	
	<c:otherwise>
		<span id="listPrice_${catalogEntryID}" class="old_price">
			<c:out value="${displayPriceString}" escapeXml="false"/>
		</span>
		<span id="offerPrice_${catalogEntryID}" class="price" itemprop="price">
			&nbsp;<c:out value="${offerPriceString}"  escapeXml="false"/>
		</span>
	</c:otherwise>
</c:choose>
