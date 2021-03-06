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

<flow:ifEnabled feature="Analytics">
<c:if test="${fn:contains(catEntryDisplayUrl, '?')}">
   <c:set var="cmcrurl" value="${fn:replace(cmcrurl, '?', '&')}" />
</c:if>
</flow:ifEnabled>

<c:set var="showCompareBox" value="true" />
<c:if test="${type eq 'package' || type eq 'bundle' || type eq 'dynamickit'}">
	<c:set var="showCompareBox" value="false" />
</c:if>

<div id="CatalogEntryProdImg_${catEntryIdentifier}" class="product_image" onmouseout="javascript:hideSection('catalogEntry_img_div${catEntryIdentifier}');
	<c:if test="${showCompareBox eq 'true'}">
		if(!dojo.byId('comparebox_${catalogEntryID}').checked){
			hideSection('compare_${catalogEntryID}');
		}
	</c:if>">
	<a ${ShowProductInNewWindow} href="<c:out value='${catEntryDisplayUrl}${cmcrurl}' escapeXml='false'/>" id="catalogEntry_img${catEntryIdentifier}"
		onkeydown="shiftTabHideSection('catalogEntry_img_div${catEntryIdentifier}',event);
		<c:if test="${showCompareBox eq 'true'}">
			if(!dojo.byId('comparebox_${catalogEntryID}').checked){
				shiftTabHideSection('compare_${catalogEntryID}',event);
			}
		</c:if>" onfocus="showSection('catalogEntry_img_div${catEntryIdentifier}');
		<c:if test="${showCompareBox eq 'true'}">
			showSection('compare_${catalogEntryID}');
		</c:if>"  title="${altImgText}">
		<img alt="${altImgText}"  src="${imgSource}"/>
		
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
							<img src="<c:out value='${ribbonadImage1}'/>"  id="ribbonad_grid_${catEntryIdentifier}_${attrValue.value}" alt="${attrValue.value}" border="0"/>
						</div>						
					</c:if>		
				</c:forEach>								
			</c:if>
		</c:forEach>		

	</a>
	<c:if test="${showCompareBox eq 'true'}">
		<div id="compare_<c:out value='${catalogEntryID}'/>" class="compare_target">
			<input id="comparebox_<c:out value='${catalogEntryID}'/>" type="checkbox" name="comparebox_<c:out value='${catalogEntryID}'/>" 
				onclick="javascript: shoppingActionsJS.addOrRemoveFromCompare('<c:out value='${catalogEntryID}'/>',this.checked)">
			<a id="CompareLink_${catEntryIdentifier}" href="javascript:shoppingActionsJS.changeCompareBox('comparebox_<c:out value='${catalogEntryID}'/>','<c:out value='${catalogEntryID}'/>');"><label for="comparebox_<c:out value='${catalogEntryID}'/>"><fmt:message key="COMPARE"/></label></a>
		</div>
	</c:if>
	<div id="catalogEntry_img_div${catEntryIdentifier}" class="quick_info_toggle">
		<a id="QuickViewLink_${catEntryIdentifier}" title="<fmt:message key='QUICK_VIEW_BUTTON_ACCE'/>" role="button" wairole="button" href="javascript:setCurrentId('QuickViewLink_${catEntryIdentifier}');QuickInfoJS.showDetails('${catEntryIdentifier}');"
		onblur="javascript: hideSection('catalogEntry_img_div${catEntryIdentifier}');
	<c:if test="${showCompareBox eq 'true'}">
		if(!dojo.byId('comparebox_${catalogEntryID}').checked){
			hideSection('compare_${catalogEntryID}');
		}
	</c:if>"
			onkeydown="
			<c:if test="${showCompareBox eq 'true'}">
				if(!dojo.byId('comparebox_${catalogEntryID}').checked){tabHideSection('compare_${catalogEntryID}',event);}
			</c:if>
				tabHideSection('catalogEntry_img_div${catEntryIdentifier}',event,'WC_CatalogEntryDBThumbnailDisplayJSPF_${catEntryIdentifier}_link_9b');
			"><fmt:message key="QUICK_VIEW"/></a>
	</div>
	<c:if test="${showCompareBox eq 'true' and param.fromPage ne 'compare'}">
		<script>
			if(dojo.byId("comparebox_<c:out value='${catalogEntryID}'/>").checked){
				dojo.addOnLoad(function(){
					dojo.byId("comparebox_<c:out value='${catalogEntryID}'/>").checked = '';
				});
			}
		</script>
	</c:if>
</div>
<div class="product_info">

	<div class="product_name">
		<c:if test="${not empty searchScore}">
			<div class="caption" style="display:none">
				<div class="searchResultSpot">[<fmt:message key='SEARCH_SCORE'/> <c:out value="${searchScore}"/>]</div>
			</div>
		</c:if>
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
