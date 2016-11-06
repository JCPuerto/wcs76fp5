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

<div class="product">
<flow:ifEnabled feature="Analytics">
<c:if test="${fn:contains(catEntryDisplayUrl, '?')}">
   <c:set var="cmcrurl" value="${fn:replace(cmcrurl, '?', '&')}" />
</c:if>
</flow:ifEnabled>

<div id="MiniGridViewProdImg_${catEntryIdentifier}" class="product_image" onblur="javascript:hideSection('catalogEntry_img_div${catEntryIdentifier}');">
	<a ${ShowProductInNewWindow} href="<c:out value='${catEntryDisplayUrl}${cmcrurl}' escapeXml='false'/>" id="catalogEntry_img_<c:out value='${catEntryIdentifier}'/>"
		onkeydown="shiftTabHideSection('catalogEntry_img_div${catEntryIdentifier}',event);"
		onfocus="showSection('catalogEntry_img_div${catEntryIdentifier}');" title="${altImgText}">
		<img alt="${altImgText}" src="${imgSource}"/>
		<c:forEach var="attribute" items="${attributes}" varStatus="status2">
			<c:if test="${attribute.usage == 'Descriptive' && fn:startsWith(attribute.identifier,'ribbonad')}">
				<c:forEach var="attrValue" items="${attribute.values}">
					<c:remove var="ribbonadImage1"/>
					<c:forEach var="extVal" items="${attrValue.extendedValue}">
						<c:if test="${extVal.key == 'Image1Path'}">
							<c:set var="ribbonadImage1" value="${env_imageContextPath}/${extVal.value}"/>																								
						</c:if>									
					</c:forEach>
					<c:if test="${!empty ribbonadImage1}">
						<div class="ribbonad_<c:out value='${attrValue.value}'/>">
							<img src="<c:out value='${ribbonadImage1}'/>" id="ribbonad_${emsName}_${catEntryIdentifier}_${attrValue.value}" alt="${attrValue.value}" border="0"/>
						</div>
					</c:if>		
				</c:forEach>								
			</c:if>
		</c:forEach>		
	</a>
	<div id="catalogEntry_img_div_${catEntryIdentifier}" class="quick_info_toggle">
		<a id="MiniGridQuickView_${catEntryIdentifier}" title="<fmt:message key='QUICK_VIEW_BUTTON_ACCE'/>" role="button" wairole="button" href="javascript:setCurrentId('MiniGridQuickView_${catEntryIdentifier}');QuickInfoJS.showDetails('${catEntryIdentifier}');"
			onblur="javascript:hideSection('catalogEntry_img_div${catEntryIdentifier}');"><fmt:message key="QUICK_VIEW"/></a>
	</div>
</div>
<div class="product_info">
	<div class="product_name">
		<a id="WC_CatalogEntryDBThumbnailDisplayJSPF_${catEntryIdentifier}_link_9b"
					${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}${cmcrurl}" escapeXml="false"/>" >
			<c:out value="${highlightedName}" escapeXml="false"/>
		</a>
	</div>
	<div class="product_price" id="product_price_${catEntryIdentifier}">

			<%@include file = "../../Widgets/PriceDisplay/PriceDisplay.jsp" %> 
			
			<%-- 
				* Uncomment below code to use c:import for priceDisplay. Import price display if this fragment is cached independently.
				* Pass catEntryIdentifier while importing, so that priceDisplay fragment can be cached based on catEntryIdentifier request parameter. 
			--%>

			<%-- out.flush(); %>
			<c:import url="${env_jspStoreDir}Widgets/PriceDisplay/PriceDisplay.jsp" >
				<c:param name="catEntryIdentifier" value="${catEntryIdentifier}"/> 
			</c:import>
			<% out.flush(); --%>

	</div>

</div>		
</div>
