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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>


<%-- this jspf will set the value of defaultWishListName --%>
<%@include file="DefaultWishListName.jspf" %>								

<div class="addToWishListButtonBorder" >
	<div class="tertiary_button_shadow" id="addToWishListButton">
		<div class="tertiary_button left">
			<a id="multipleWishListButton" title="<c:out value="${longDefaultWishListName}"/>" href="javascript:setCurrentId('multipleWishListButton');<c:out value="MultipleWishLists.setType('${param.type}');MultipleWishLists.addToList('${param.catEntryId}');"/>">			
			<c:out value="${defaultWishListName }"/>
			</a>
		</div>
		<%@include file="AddToWishListButtonExtension.jspf" %>
	</div>
</div>

<%-- This is the drop down panel for multiple wish list. It should be only included once --%>
<div dojoType="wc.widget.RefreshArea" id="MultipleWishListNewList" controllerId="MultipleWishListNewListController" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">	
<%out.flush();%>
	<c:import url="${jspStoreDir}Snippets/MultipleWishList/AddToWishListPanelRefreshArea.jsp">		
		<c:param name="catEntryId" value="${param.catEntryId}"/>	
		<c:param name="type" value="${param.type}"/>
	</c:import>
<%out.flush();%>	
</div>
<script type="text/javascript">dojo.addOnLoad(function() { 
	parseWidget("MultipleWishListNewList"); 
	/* After a customer has successfully created a wish list using the drop down in quick info, 
	* MultipleWishListDropDown, and MultipleWishListNewList will be refreshed. However, catEntryId and type are not
	* available in MultipleWishListNewList. So if the customer tries to add to a list using the drop down
	* in the product detail page, it'll fail. To solve this problem, we'll save the catEntryId, and type. These two 
	* variable will not be modified, unless a page is fully reloaded.    
	*/ 
	MultipleWishLists.currentProductInfo.type = '<wcf:out value="${param.type}" escapeFormat="js"/>';
	MultipleWishLists.currentProductInfo.catEntryId = '<wcf:out value="${param.catEntryId}" escapeFormat="js"/>';	
	});
</script>								


