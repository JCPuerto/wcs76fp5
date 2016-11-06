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

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>


<div id="browsingHistoryWidget" dojoType="wc.widget.ScrollablePane" autoScroll='false' loopItems="false" scrollByPage="true" hideArrows='true' skipIECorrection='true' adjustPaneSize='true' buttonSize="25" itemSize="125" totalDisplayNodes="2" isHorizontal="false" altPrev = '<fmt:message key="SCROLL_UP" bundle="${storeText}" />' altNext = '<fmt:message key="SCROLL_DOWN" bundle="${storeText}" />'>
	<%out.flush();%>
	<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ScrollingProductsESpot.jsp">
		<c:param name="langId" value="${langId}" />						
		<c:param name="storeId" value="${WCParam.storeId}" />
		<c:param name="catalogId" value="${WCParam.catalogId}" />
		<c:param name="emsName" value="BrowsingHistory" />
		<c:param name="scrollable" value="true" />
		<c:param name="skipAttachments" value="true"/>
		<c:param name="pageView" value="scrollSideBarESpot"/>
		<c:param name="numberProductsToDisplay" value="10"/>
		<c:param name="skipCategories" value="true"/>
	</c:import>
	<%out.flush();%>		
</div>

<script type="text/javascript">
	dojo.addOnLoad(function() { 
		parseWidget("browsingHistoryWidget"); 
	});
</script>
