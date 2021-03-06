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

<div class="item" id="item_${catEntryIdentifier}" onblur="hideSection('item_quickview_${param.emsName}_div${catEntryIdentifier}');">
	<div class="left_column">
		<span id="item_${catEntryIdentifier}_acce_label" class="spanacce">${altImgText}</span>
		<a ${ShowProductInNewWindow} href="<c:out value='${catEntryDisplayUrl}${cmcrurl}' escapeXml='false'/>" id="catalogEntry_img<c:out value='${catEntryIdentifier}'/>"
				onkeydown="shiftTabHideSection('item_quickview_${param.emsName}_div${catEntryIdentifier}',event);"
				onfocus="showSection('item_quickview_${param.emsName}_div${catEntryIdentifier}');" title="${altImgText}">
			<img alt="${altImgText}" src="${imgSource_sideBar}" />
		</a> 
		<div id="item_quickview_${param.emsName}_div${catEntryIdentifier}" class="quick_info_toggle">
			<a id="SideBarQuickViewLink_${catEntryIdentifier}" title="<fmt:message key='QUICK_VIEW_BUTTON_ACCE'/>" role="button" wairole="button" href="javascript:setCurrentId('SideBarQuickViewLink_${catEntryIdentifier}');
					QuickInfoJS.showDetails('${catEntryIdentifier}');" 
					onblur="hideSection('item_quickview_${param.emsName}_div${catEntryIdentifier}');"><fmt:message key="QUICK_VIEW"/></a>
		</div>
	</div>

	<div class="right_column">
		<div class="item_name">
			<a id="WC_CatalogEntryDBThumbnailDisplayJSPF_${catEntryIdentifier}"
				${ShowProductInNewWindow} href="<c:out value="${catEntryDisplayUrl}${cmcrurl}" escapeXml="false"/>" >
				<c:out value="${highlightedName}" escapeXml="false"/>
			</a>
		</div>
	
		<div class="item_price"id="item_price_${catEntryIdentifier}">

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
	<div class="clear_float"></div>
</div>		

