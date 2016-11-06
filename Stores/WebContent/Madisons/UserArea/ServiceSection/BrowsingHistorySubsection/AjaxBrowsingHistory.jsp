<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>
  	
<c:set var="myAccountPage" value="true" scope="request"/>
	
<wcf:url var="AjaxMyAccountCenterLinkDisplayURL" value="AjaxLogonFormCenterLinksDisplayView" type="Ajax">    
	<wcf:param name="storeId"   value="${WCParam.storeId}"  />
	<wcf:param name="catalogId" value="${WCParam.catalogId}"/>
	<wcf:param name="langId" value="${langId}" />
</wcf:url>	  	
  	
<div id="box">
	<div class="my_account" id="WC_AjaxBrowseHistory_div_1">			

		<div class="main_header" id="WC_AjaxBrowseHistory_div_2">
			<div class="left_corner" id="WC_AjaxBrowseHistory_div_3"></div>
			<div class="left" id="WC_AjaxBrowseHistory_div_4">
				<span class="main_header_text"><fmt:message key="BROWSING_HISTORY" bundle="${storeText}"/></span>
			</div>
			<div class="right_corner" id="WC_AjaxBrowseHistory_div_5"></div>
		</div>
			
		<div class="body" id="WC_AjaxBrowseHistory_div_6">	
			<div dojoType="wc.widget.RefreshArea" id="BrowsingHistoryDisplay_Widget" controllerId="BrowsingHistoryDisplay_Controller" role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
				<%out.flush();%>
					<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/BrowsingHistoryESpotDisplay.jsp">
						<c:param name="storeId" value="${WCParam.storeId}" />
						<c:param name="catalogId" value="${WCParam.catalogId}" />
						<c:param name="langId" value="${langId}" />
						<c:param name="emsName" value="BrowsingHistory" />
					</c:import>
				<%out.flush();%>	
			</div>		
			
			<script type="text/javascript">
				dojo.addOnLoad(function() { 
					parseWidget("BrowsingHistoryDisplay_Widget"); 
				});
			</script>								
	  	</div>
	  		  	
		<div class="footer" id="WC_AjaxBrowseHistory_div_7">
			<div class="left_corner" id="WC_AjaxBrowseHistory_div_8"></div>
			<div class="tile" id="WC_AjaxBrowseHistory_div_9"></div>
			<div class="right_corner" id="WC_AjaxBrowseHistory_div_10"></div>
		</div>
	</div>
</div>

