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


<c:set var="from" value="QuickInfo" scope="request"/>
<%@ include file="../MultipleWishList/DefaultWishListName.jspf" %>

<div id="addToMultipleWishListLinkContainer">
	<div class="tertiary_button_shadow" id="addToWishListButton<c:out value="${from}"/>">
		<div class="tertiary_button left">
			<a id="addToMultipleWishListLink" title="<c:out value="${longDefaultWishListName}"/>" href="javascript:MultipleWishLists.addToList();">
			<c:out value="${defaultWishListName}"/>
			</a>
		</div>
		<%@include file="../MultipleWishList/AddToWishListButtonExtension.jspf" %>
	</div>
</div>           
<c:remove var="from"/>   

<script type="text/javascript">
	dojo.addOnLoad(function() {
		MultipleWishLists.setDefaultListId('<c:out value="${defaultWishlist.giftListIdentifier.uniqueID}"/>');
	});
</script>	