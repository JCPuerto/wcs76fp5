<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009, 2010 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%-- 
  *****
  * ProductRankingsDisplay.jsp is used to display an e-Marketing spot in the store. The e-Marketing spot consists of 2 ranking lists, best selling products and most browsed products.
  * It should be displayed in the right side bar on the store home page, category pages and sub-category pages.
  * The items displayed in each list should be context dependent.
  * 
  * How to use this snippet?
  *	This is an example of how this file could be imported to a page:
  *		<c:import url="${jspStoreDir}Snipets/Catalog/ProductRankingsDisplay.jsp">
  *			<c:param name="storeId" value="${WCParam.storeId}" />
  *			<c:param name="catalogId" value="${catalogId}" />
  *			<c:param name="langId" value="${langId}" />
  *			<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
  *		</c:import>  
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>

<script type="text/javascript" id="rankingJSLib"></script>

<div id="WC_Ranking_ESpot_div" class="accordion ranking_list_container" style="display:none;">
	<div id="WC_Ranking_ESpot_Desc" class="nodisplay"><fmt:message key="RANKING_LIST_DESCRIPTION" bundle="${storeText}" /></div>
	<div id="WC_RankContainer" dojoType="dijit.layout.AccordionContainer" selectedChild="WC_RankTab1">
		<div id="WC_RankTab1" dojoType="dijit.layout.ContentPane" title="<fmt:message key='BEST_SELLERS' bundle='${storeText}' />" selected="true">
			<div id="BestSellersDisplayScrollPane" class="scroll_pane_container" dojoType="wc.widget.ScrollablePane" autoScroll='false' loopItems="false" scrollByPage="true" itemSize="80" totalDisplayNodes="5" isHorizontal="false" altPrev='<fmt:message key="SCROLL_UP_BEST_SELLERS" bundle="${storeText}" />' altNext='<fmt:message key="SCROLL_DOWN_BEST_SELLERS" bundle="${storeText}" />' tempImgPath = "<c:out value='${jspStoreImgDir}'/>images/empty.gif">
				<%out.flush();%>
				<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ScrollingProductsESpot.jsp">
					<c:param name="langId" value="${langId}" />						
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:param name="emsName" value="BestSellingProducts" />
					<c:param name="scrollable" value="true" />
					<c:param name="skipAttachments" value="true"/>
					<c:param name="pageView" value="rankingList"/>
					<c:param name="numberProductsToDisplay" value="10"/>
					<c:param name="rankingList" value="true"/>
				</c:import>
				<%out.flush();%>
			</div>
		</div>
		<div id="WC_RankTab2" dojoType="dijit.layout.ContentPane" title="<fmt:message key='TOP_BROWSED' bundle='${storeText}' />">
			<div id="TopBrowsedDisplayScrollPane" class="scroll_pane_container" dojoType="wc.widget.ScrollablePane" autoScroll='false' loopItems="false" scrollByPage="true" itemSize="80" totalDisplayNodes="5" isHorizontal="false" altPrev='<fmt:message key="SCROLL_UP_TOP_BROWSED" bundle="${storeText}" />' altNext='<fmt:message key="SCROLL_DOWN_TOP_BROWSED" bundle="${storeText}" />' tempImgPath="<c:out value='${jspStoreImgDir}'/>images/empty.gif">
				<%out.flush();%>
				<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ScrollingProductsESpot.jsp">
					<c:param name="langId" value="${langId}" />						
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${WCParam.catalogId}" />
					<c:param name="emsName" value="TopBrowsedProducts" />
					<c:param name="scrollable" value="true" />
					<c:param name="skipAttachments" value="true"/>
					<c:param name="pageView" value="rankingList"/>
					<c:param name="numberProductsToDisplay" value="10"/>
					<c:param name="rankingList" value="true"/>
				</c:import>
				<%out.flush();%>
			</div>
		</div>
	</div>
</div>
	
<script type="text/javascript">
		dojo.addOnLoad(function() {
		
			if(dojo.query("#WC_RankContainer .imgContainer").length==0) return;
			
			dojo.byId('rankingJSLib').src="<c:out value='${jsAssetsDir}javascript/CatalogArea/ProductRankingsDisplay.js'/>";
			dojo.require("dijit.layout.AccordionContainer");
			showElementById('WC_Ranking_ESpot_div');
			parseWidget("BestSellersDisplayScrollPane");
			parseWidget("WC_RankTab1");
			parseWidget("TopBrowsedDisplayScrollPane");
			parseWidget("WC_RankTab2");
			parseWidget("WC_RankContainer");

			if(dojo.byId('WC_RankTab1_button') != null && dojo.byId('WC_RankTab2_button') != null){
				ProductRankingsDisplayJS.initializeArrowOnPageLoad();
				dojo.connect(dojo.byId('WC_RankTab1_button'), 'onclick', function(){ProductRankingsDisplayJS.toggleArrow("WC_RankTab1_button");});
				dojo.connect(dojo.byId('WC_RankTab1_button'), 'onkeypress', function(){ProductRankingsDisplayJS.toggleArrow("WC_RankTab2_button");});
				dojo.connect(dojo.byId('WC_RankTab2_button'), 'onclick', function(){ProductRankingsDisplayJS.toggleArrow("WC_RankTab2_button");});
				dojo.connect(dojo.byId('WC_RankTab2_button'), 'onkeypress', function(){ProductRankingsDisplayJS.toggleArrow("WC_RankTab1_button");});
				dojo.connect(dojo.byId('WC_RankTab1_button'), 'onmouseover', function(){ProductRankingsDisplayJS.hoverHeader("WC_RankTab1_button");});
				dojo.connect(dojo.byId('WC_RankTab2_button'), 'onmouseover', function(){ProductRankingsDisplayJS.hoverHeader("WC_RankTab2_button");});
				dojo.connect(dojo.byId('WC_RankTab1_button'), 'onmouseout', function(){ProductRankingsDisplayJS.hoverOffHeader("WC_RankTab1_button");});
				dojo.connect(dojo.byId('WC_RankTab2_button'), 'onmouseout', function(){ProductRankingsDisplayJS.hoverOffHeader("WC_RankTab2_button");});				
			}

			if(dojo.byId('WC_RankTab1').style.visibility == 'hidden' && dojo.byId('WC_RankTab2').style.visibility == 'hidden'){
				dojo.byId('WC_Ranking_ESpot_div').style.display = 'none';
			}else{
				if(dojo.byId('WC_RankTab1').style.visibility == 'hidden'){
					dojo.byId('WC_RankTab1').style.display = 'none';
					if(dojo.byId('WC_RankTab1_button') != null) dojo.byId('WC_RankTab1_button').style.display = 'none';
				}
	
				if(dojo.byId('WC_RankTab2').style.visibility == 'hidden'){
					dojo.byId('WC_RankTab2').style.display = 'none';
					if(dojo.byId('WC_RankTab2_button') != null) dojo.byId('WC_RankTab2_button').style.display = 'none';
				}
	
				if(dojo.byId('WC_RankTab1').style.display == 'none' && dojo.byId('WC_RankTab2').style.display != 'none'){
					dijit.byId('WC_RankContainer').selectChild('WC_RankTab2');
					ProductRankingsDisplayJS.toggleArrow("WC_RankTab2_button");
				}
			}
		});
</script>
