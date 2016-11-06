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
<!-- BEGIN WishlistCommonPage.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../../include/JSTLEnvironmentSetup.jspf" %>

<c:set var="myAccountPage" value="true" scope="request"/>
<c:set var="bHasWishList" value="true" />
<c:set var="wishListPage" value="true" />
<input type="hidden" id="featureProductAdd2WishList" value="true"/>

<flow:ifEnabled feature="wishList">
	<wcbase:useBean id="userListBean" classname="com.ibm.commerce.store.beans.UserInterestItemListDataBean" scope="page">
	<c:set target="${userListBean}" property="storeEntityId" value="${WCParam.storeId}"/>
		<%--
		*** 
		* Two stores on the same server shares user wish lists.  We have to set the storeentId
		* to make sure the items in this shoppers wish list belongs to this store.
		*** 
		--%>
		
	</wcbase:useBean>
	<c:set var="listBeans" value="${userListBean.userInterestItemListDataBeans}"/>
	<c:choose>		
		<%-- Check to see if the list is empty, if no, then wish list is empty--%>		
		<c:when test="${ empty listBeans }" >
			<c:set var="bHasWishList" value="false"/>
		</c:when>    
		<c:otherwise>
			<c:set var="listBean" value="${listBeans[0]}"/>
			<c:set var="interestItems" value="${listBean.interestItemDataBeans}" />
	    	<%-- if there are items, then there are items in the wish list --%>
		   	<c:if test="${ empty interestItems }" >
				<c:set var="bHasWishList" value="false"/>
	   		</c:if>
		</c:otherwise>
	</c:choose>
</flow:ifEnabled>

<flow:ifEnabled feature="AjaxMyAccountPage">
	<c:set var="url" value="AjaxAccountWishListDisplayView"/>
	<c:set var="errorViewName" value="AjaxAccountWishListDisplayView"/>
</flow:ifEnabled>

<flow:ifDisabled feature="AjaxMyAccountPage">
	<c:set var="url" value="NonAjaxAccountWishListDisplayView"/>
	<c:set var="errorViewName" value="NonAjaxAccountWishListDisplayView"/>
</flow:ifDisabled>
<!-- Right Nav Start -->
<c:if test="${isChinaStore}">
	<c:set var="useHomeRightSidebar" value="true" scope="request" />
	<%@ include file="../../../include/RightSidebarDisplay.jspf"%>
</c:if>
<!--  Send Wishlist Start -->
<div id="right_nav">
	<div id="wishlist">
		
		<flow:ifEnabled feature="wishList">
			<form name="SendMsgForm" method="post" action="InterestItemListMessage" id="SendMsgForm">
				<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_WishListDisplay_FormInput_storeId_In_SendMsgForm_1"/>
				<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_WishListDisplay_FormInput_catalogId_In_SendMsgForm_1"/>
				<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_WishListDisplay_FormInput_langId_In_SendMsgForm_1"/>
				<input type="hidden" name="URL" value="${url}" id="WC_WishListDisplay_FormInput_URL_In_SendMsgForm_1"/>
				<input type="hidden" name="errorViewName" value="${errorViewName}" id="WC_WishListDisplay_FormInput_errorViewName_In_SendMsgForm_1"/>
				<input type="hidden" name="sender" value="<c:out value="${strSender}" />" id="WC_WishListDisplay_FormInput_sender_In_SendMsgForm_1"/>
				<input type="hidden" name="wishListHasItem" value="${bHasWishList}" id="WC_WishListDisplay_FormInput_wishListItem_In_SendMsgForm_1"/>
				<input type="hidden" name="listId" value="<c:out value="${listBean.listId}" />" id="WC_WishListDisplay_FormInput_listId_In_SendMsgForm_1"/>
		</flow:ifEnabled>
		<flow:ifEnabled feature="SOAWishlist">
			<fmt:message var="wishListSubject" key="EMAIL_WISHLIST_EMAIL_SUBJECT" bundle="${remoteWidgetText}"/>
			<form name="SendMsgForm" method="post" action="GiftListServiceAnnounceGiftList" id="SendMsgForm">
				<input type="hidden" name="storeId" value="<c:out value="${WCParam.storeId}" />" id="WC_WishListDisplay_FormInput_storeId_In_SendMsgForm_1"/>
				<input type="hidden" name="catalogId" value="<c:out value="${WCParam.catalogId}" />" id="WC_WishListDisplay_FormInput_catalogId_In_SendMsgForm_1"/>
				<input type="hidden" name="langId" value="<c:out value="${langId}" />" id="WC_WishListDisplay_FormInput_langId_In_SendMsgForm_1"/>
				<input type="hidden" name="URL" value="${url}" id="WC_WishListDisplay_FormInput_URL_In_SendMsgForm_1"/>
				<input type="hidden" name="errorViewName" value="${errorViewName}" id="WC_WishListDisplay_FormInput_errorViewName_In_SendMsgForm_1"/>
				<input type="hidden" name="sender" value="<c:out value="${strSender}" />" id="WC_WishListDisplay_FormInput_sender_In_SendMsgForm_1"/>
				<input type="hidden" name="wishListHasItem" value="${bHasWishList}" id="WC_WishListDisplay_FormInput_wishListItem_In_SendMsgForm_1"/>
				<input type="hidden" name="giftListId" value="" id="WC_WishListDisplay_FormInput_listId_In_SendMsgForm_1"/>
				<input type="hidden" name="template" value="SOA_WISHLIST_EMAIL_TEMPLATE" id="WC_WishListDisplay_FormInput_Template_In_SendMsgForm_1"/>
				<input type="hidden" name="addressingMethod" value="DirectlyAddressed" id="WC_WishListDisplay_FormInput_AddMethod_In_SendMsgForm_1"/>
				<input type="hidden" name="subject" value="<c:out value='${wishListSubject}'/>" id="WC_WishListDisplay_FormInput_Subject_In_SendMsgForm_1"/>
				<input type="hidden" name="recipientEmail" value="" id="WC_WishListDisplay_FormInput_recipientEmail_In_SendMsgForm_1"/>
				<input type="hidden" name="senderName" value="" id="WC_WishListDisplay_FormInput_senderName_In_SendMsgForm_1"/>
				<input type="hidden" name="senderEmail" value="SOAWishListEmail@SOAWishListEmail.com" id="WC_WishListDisplay_FormInput_senderEmail_In_SendMsgForm_1"/>
				<input type="hidden" name="message" value="SOAWishListEmail" id="WC_WishListDisplay_FormInput_message_In_SendMsgForm_1"/>
		</flow:ifEnabled>
		
			<div class="header" id="WC_WishlistCommonPage_div_1">
				<h2><fmt:message key="EMAIL_WISHLIST" bundle="${storeText}"/></h2>
				<c:if test="${isChinaStore}">
					<img onclick="dojo.byId('wishlist').style.display='none';" src="${jspStoreImgDir}images/colors/color1/popup_close.png" alt="<fmt:message key="CLOSE" bundle="${storeText}"/>" />							
				</c:if>
			</div>
			<div class="contents" id="WC_WishlistCommonPage_div_2">
					<p class="header_text"><fmt:message key="SENDEMAIL" bundle="${storeText}"/></p>
					<p class="header_text"><fmt:message key="SENDEMAIL1" bundle="${storeText}"/></p>
					<br/>
					<div id="WC_WishlistCommonPage_div_3" class="wishlist_label"><label for="SendWishListForm_Recipient_Email"><span class="required-field_wishlist">*</span><fmt:message key="WISHLIST_TO" bundle="${storeText}" /></label> <fmt:message key="WISHLIST_EMAIL_ADDRESS" bundle="${storeText}" /> </div>
					<div class="wishlist_side_space" id="WC_WishlistCommonPage_div_4"><input type="text" size="21" name="recipient" value="<c:out value="${WCParam.recipient}"/>" id="SendWishListForm_Recipient_Email" tabindex="1"/></div>
					<div id="WC_WishlistCommonPage_div_5"class="wishlist_label"><label for="SendWishListForm_Sender_Name"><span class="required-field_wishlist">*</span><fmt:message key="WISHLIST_FROM" bundle="${storeText}" /></label> <fmt:message key="WISHLIST_NAME" bundle="${storeText}" /></div>
					<div class="wishlist_side_space" id="WC_WishlistCommonPage_div_6"><input type="text" size="21" maxlength="110" name="sender_name" value="<c:out value="${strSenderName}"/>" id="SendWishListForm_Sender_Name" tabindex="1"/></div>
					<div class="wishlist_side_space sendemail_address" id="WC_WishlistCommonPage_div_7"><label for="SendWishListForm_Sender_Email"><fmt:message key="WISHLIST_EMAIL" bundle="${storeText}" /></label></div>
					<div class="wishlist_side_space" id="WC_WishlistCommonPage_div_8"><input type="text" size="21" maxlength="50" name="sender_email" value="<c:out value="${strSenderEmail}"/>" id="SendWishListForm_Sender_Email" tabindex="1"/></div>
					<div class="wishlist_side_space other_info" id="WC_WishlistCommonPage_div_9"><label for="wishlist_message"><fmt:message key="WISHLIST_MESSAGE" bundle="${storeText}" /></label></div>
					<div  class="wishlist_side_space" id="WC_WishlistCommonPage_div_10"><textarea tabindex="1" rows="6" cols="21" name="wishlist_message" id="wishlist_message"><c:out value="${WCParam.wishlist_message}"/></textarea></div>
				   <br />
			 	  <div class="wishlist_side_space" id="WC_WishlistCommonPage_div_11">
					<div class="tertiary_button_shadow">
						<div class="tertiary_button">  
							<flow:ifEnabled feature="wishList">
								<a href="#" tabindex="1" onclick="JavaScript:setCurrentId('WC_WishlistCommonPage_links_1'); AccountWishListDisplay.checkEmailForm('SendMsgForm','refreshArea');return false;"  id="WC_WishlistCommonPage_links_1"><fmt:message key="SENDWISHLIST" bundle="${storeText}"/></a>
							</flow:ifEnabled>
							<flow:ifEnabled feature="SOAWishlist">
								<a href="#" tabindex="1" onclick="JavaScript:setCurrentId('WC_WishlistCommonPage_links_1'); MultipleWishLists.getWishListIdForEmail('SendMsgForm'); MultipleWishLists.checkSOAEmailForm('SendMsgForm','refreshArea');return false;"  id="WC_WishlistCommonPage_links_1"><fmt:message key="SENDWISHLIST" bundle="${storeText}"/></a>
							</flow:ifEnabled>
						</div>
					</div>
				   </div>
				   
				   <div class="clear_float"></div>		   
			   </div>
					<div class="side_footer" id="WC_WishListDisplay_div_17"></div>
				</form>
			</div>
	 <div id="WishListEmailSucMsg_Div" class="text" tabindex="-1">
	<c:if test="${empty storeError.key}" >
		<c:if test="${!empty WCParam.recipient}">
			<%--This is the variable that controls how many characters the To: email address can be displayed --%>
			<c:set var="maxCharsToDisplay" value="25"/>
			<c:set var="toEmailAddress" value="${WCParam.recipient}"/>
			<c:if test="${fn:length(toEmailAddress) > maxCharsToDisplay}">
				<c:set var="toEmailAddress" value="${fn:substring(toEmailAddress, 0, maxCharsToDisplay)}..."/>
			</c:if>
			<fmt:message key="WISHLIST_SENDTO" bundle="${storeText}" var="WishListSentMsg"><fmt:param><c:out value="${toEmailAddress}"/></fmt:param></fmt:message>

			<script type="text/javascript">
				dojo.addOnLoad(function() { 
					dojo.byId('WishListEmailSucMsg_Div').focus();
				});
			</script>
		</c:if>
	</c:if>
	</div>
</div>
<!-- Right Nav End -->
<div id="box">
	<!-- Content Start -->
	<flow:ifEnabled feature="SOAWishlist">		
		<%@ include file="../../../Snippets/MultipleWishList/GetDefaultWishList.jspf" %>	
		<div dojoType="wc.widget.RefreshArea" id="WishlistSelect_Widget" controllerId="WishlistSelect_Controller"  role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
			<% out.flush(); %>
				<c:import url="${jspStoreDir}UserArea/ServiceSection/InterestItemListSubsection/MultipleWishListController.jsp">
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="langId" value="${langId}" />
				</c:import>
			<% out.flush(); %>
		</div>
		<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("WishlistSelect_Widget"); });</script>						
	</flow:ifEnabled>
				
	<div class="my_account_wishlist" id="WC_WishlistCommonPage_div_15">

		<div dojoType="wc.widget.RefreshArea" id="WishlistDisplay_Widget" controllerId="WishlistDisplay_Controller"  role="wairole:region" waistate:live="polite" waistate:atomic="false" waistate:relevant="all">
			<% out.flush(); %>
				<c:import url="${jspStoreDir}UserArea/ServiceSection/InterestItemListSubsection/WishListResultDisplay.jsp">
					<c:param name="storeId" value="${WCParam.storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="langId" value="${langId}" />
				</c:import>
			<% out.flush(); %>
		</div>
		<script type="text/javascript">dojo.addOnLoad(function() { parseWidget("WishlistDisplay_Widget"); });</script>						

		 <p class="space"></p>
		<fmt:message var="titleString" key="WISHLIST_ESPOT_TITLE" bundle="${storeText}" scope="request"/>	
		<% out.flush(); %>
			<c:import url="${jspStoreDir}Snippets/Marketing/ESpot/ContentAreaESpot.jsp">
				<c:param name="storeId" value="${WCParam.storeId}" />
				<c:param name="catalogId" value="${catalogId}" />
				<c:param name="langId" value="${langId}" />
				<c:param name="numberProductsPerRow" value="4" />
				<c:param name="emsName" value="WishListFeaturedProducts"/>
				<c:param name="espotTitle" value="titleString" />
				<c:param name="errorViewName" value="AjaxOrderItemDisplayView" />
			</c:import>
		<% out.flush(); %>
	</div>

	<!-- Content End -->
</div>
<!-- END WishlistCommonPage.jsp -->
