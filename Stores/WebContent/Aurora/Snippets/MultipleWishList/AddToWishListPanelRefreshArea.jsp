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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/nocache.jspf" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %> 
<%@ include file="../../include/JSTLEnvironmentSetup.jspf" %>

<c:if test="${userType != 'G'}">
<!-- start AddToWishListPanelRefreshArea.jsp -->

	<wcf:getData type="com.ibm.commerce.giftcenter.facade.datatypes.GiftListType[]" var="wishLists" expressionBuilder="findWishListsForUser">	
		<wcf:contextData name="storeId" data="${storeId}"/>
	</wcf:getData>

	<div id="addToWishListPanel" <c:if test="${param.showOnDefault != 'true'}">style="display:none"</c:if> >
		<div class="addToWishListPanel_main">
			<div class="addToWishListPanel_header"><h3><fmt:message key="ADD_TO" bundle="${remoteWidgetText}"/></h3></div>
			<div class="addToWishListPanel_bodycontent">
	
					<div class="existingList scrollableWishListPanel">
						<c:forEach var="wishList" items="${wishLists}">
							
							<c:set var="name" value="${wishList.description.name}"/>
							<c:if test="${fn:length(wishList.description.name)>maxCharsToDisplayInDropDownMenu}">			
								<c:set var="name" value="${fn:substring(wishList.description.name, 0, maxCharsToDisplayInDropDownMenu)} ..."/>
							</c:if>
				
							<a title="<c:out value="${wishList.description.name}"/>" href="javascript:MultipleWishLists.setType('<c:out value="${param.type}"/>');MultipleWishLists.setDefaultListId('<c:out value="${wishList.giftListIdentifier.uniqueID}"/>');MultipleWishLists.addToList('<c:out value="${param.catEntryId}"/>')" class="bopis_link"><c:out value="${name}"/></a><br/>
						</c:forEach>					
					</div>
					<div class="addToWishListPanel_divider"> </div>
				<div class="newList">
					<img src="<c:out value='${jspStoreImgDir}${vfileColor}/table_plus_add.png'/>" alt="<fmt:message key="WISHLIST" bundle="${storeText}" />" />
					
							<a href="javascript:document.createForm.name.value='';MultipleWishLists.setType('<c:out value='${param.type}'/>');
								MultipleWishLists.setCatEntryId('<c:out value='${param.catEntryId}'/>');
								MultipleWishLists.setCreateFromMyAccount(false);
								MultipleWishLists.showPopup('create');" class="bopis_link">
							<fmt:message key="MULTIPLE_WISHLIST_create" bundle="${remoteWidgetText}" /></a>						
											
				</div>
			</div>
		</div>
	</div>
<!-- end AddToWishListPanelRefreshArea.jsp -->	
</c:if>	