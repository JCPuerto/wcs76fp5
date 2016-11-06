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

<%-- BEGIN MiniShopCartDisplayRefresh.jsp --%>

<%@ include file= "../../Common/EnvironmentSetup.jspf" %>

<span id="MiniShoppingCart_Label" class="spanacce"><fmt:message key="ACCE_Region_Shopping_Cart_Content"/></span>
<div dojoType="wc.widget.RefreshArea" id="MiniShoppingCart" widgetId="MiniShoppingCart" 
	controllerId="MiniShoppingCartController" 
	ariaMessage="<fmt:message key="ACCE_Status_Shopping_Cart_Content_Updated"/>" ariaLiveId="${ariaMessageNode}" 
	role="region" aria-labelledby="MiniShoppingCart_Label">
	<%out.flush();%>
		<c:import url = "${env_jspStoreDir}Widgets/MiniShopCartDisplay/MiniShopCartDisplay.jsp" />
	<%out.flush();%>
</div>

<%-- END MiniShopCartDisplayRefresh.jsp --%>