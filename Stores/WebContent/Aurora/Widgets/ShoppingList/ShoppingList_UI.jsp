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
<script>
	shoppingListJS<c:out value="${param.parentPage}"/> = new ShoppingListJS(${storeParams}, ${catEntryParams}, {${shoppingListNames}}, "shoppingListJS<c:out value="${param.parentPage}"/>");
</script>
<%-- Use this section to evaluate the script if this component is added to a refresh area where script will not run directly --%>
<div id="shoppingListScript_<c:out value="${param.parentPage}"/>" style="display:none;">
	if(typeof(shoppingListJS<c:out value="${param.parentPage}"/>) == "undefined" || shoppingListJS<c:out value="${param.parentPage}"/> == null || !shoppingListJS<c:out value="${param.parentPage}"/>) {
		shoppingListJS<c:out value="${param.parentPage}"/> = new ShoppingListJS(${storeParams}, ${catEntryParams}, {${shoppingListNames}}, "shoppingListJS<c:out value="${param.parentPage}"/>");
	}
</div>
<%-- Pre-load the image and keep it ready --%>
<img style="display:none;" src="${shoppingListImage}"/>
<div style="position:relative;">
	<div id="<c:out value="${param.parentPage}"/>addToShoppingListBtn" class="dropdown_primary">
	
		<a id="<c:out value="${param.parentPage}"/>addToShoppingList" href="
			<c:choose>
				<c:when test="${userType eq 'G'}">
					javascript:shoppingListJS<c:out value="${param.parentPage}"/>.showDropDown();
				</c:when>
				<c:otherwise>
					javascript:shoppingListJS<c:out value="${param.parentPage}"/>.createDefaultListAndAddItem('${defaultShoppingListId}', '<c:out value="${param.orderItemId}"/>');
				</c:otherwise>
			</c:choose>
			" class="button" role="button">
			<div class="left_border"></div>
			<div class="content">
				<c:choose>
					<c:when test="${empty param.orderItemId}">
						<fmt:message key="SL_ADD_TO_SHOPPING_LIST" />
					</c:when>
					<c:otherwise>
						<fmt:message key="MOVE_TO_WISH_LIST" />
					</c:otherwise>
				</c:choose>
			</div>
			<div class="right_border"></div>
		</a>
			<div class="drop">
			<div class="white_line"></div>
				<a id="<c:out value="${param.parentPage}"/>addToShoppingListDropdown" onmouseover="javascript: shoppingListJS<c:out value="${param.parentPage}"/>.mouseOnArrow = true;" onmouseout="javascript: shoppingListJS<c:out value="${param.parentPage}"/>.mouseOnArrow = false;" href="javascript:shoppingListJS<c:out value="${param.parentPage}"/>.showDropDown();" class="dropdown_arrow" title="<fmt:message key="SL_MULTIPLE_SHOPPING_LIST_DD" />" role="button">
						<img src="${jspStoreImgDir}${env_vfileColor}widget_quick_info_popup/dropdown_arrow.png" alt="<fmt:message key="SL_MULTIPLE_SHOPPING_LIST_DD" />"/>
					</a>
				<div class="right_border"></div>
			</div>
	</div>
	
			<div id="<c:out value="${param.parentPage}"/>shoppingListDropDown" style="display: none" class="dropdown_list" onmousedown="javascript:shoppingListJS<c:out value="${param.parentPage}"/>.hasFocus(event);"
				onkeydown="javascript:shoppingListJS<c:out value="${param.parentPage}"/>.navigateDropDown(event);"
				onblur="javascript: document.getElementById('<c:out value="${param.parentPage}"/>addToShoppingListDropdown').focus();" role="menu">
				<ul class="wish_order_list">
					<c:choose>
						<c:when test="${userType eq 'G'}">
							<li role="menuitem" class="message"><fmt:message key="SL_SIGN_IN_OR_REGISTER_TO_ACCESS_LIST" /></li>
							<div class="divider"></div>
							<li role="menuitem" id="<c:out value="${param.parentPage}"/>ShoppingList_0" class="created_list" 
							onfocus="javascript:shoppingListJS<c:out value="${param.parentPage}"/>.focusList(0);"
							onblur="javascript: this.className = 'created_list';"
							onclick="shoppingListJS<c:out value="${param.parentPage}"/>.redirectToSignOn();">
									<a id="<c:out value="${param.parentPage}"/>ShoppingListLink_0" href="javascript:shoppingListJS<c:out value="${param.parentPage}"/>.redirectToSignOn();"
										onfocus="javascript:shoppingListJS<c:out value="${param.parentPage}"/>.focusListLink(0);"
										role="menuitem" title="<fmt:message key='SL_SIGN_IN_OR_REGISTER_TO_ACCESS_LIST' />"><fmt:message key="SL_SIGN_IN_OR_REGISTER" /></a>
							</li>
						</c:when>
						<c:otherwise>
							<c:if test="${fn:length(shoppingListMap) == 0}">
								<li role="menuitem" class="message"><fmt:message key="SL_SELECT_LIST" /></li>
							</c:if>
							<ol role="menuitem" id="<c:out value='${param.parentPage}'/>listOfShoppingLists" class="created_list_wrapper" tabindex="-1" onblur="javascript: if(!shoppingListJS<c:out value='${param.parentPage}'/>.exceptionFlag){shoppingListJS<c:out value='${param.parentPage}'/>.dropDownInFocus = false; shoppingListJS<c:out value='${param.parentPage}'/>.hideIfNoFocus();}">														
							<c:forEach var="shoppingList" items="${shoppingListMap}">
								<li role="menuitem" id="<c:out value="${param.parentPage}"/>ShoppingList_${shoppingList.key}" class="created_list" role="link" onfocus="javascript:shoppingListJS<c:out value="${param.parentPage}"/>.focusList(${shoppingList.key});"
								onblur="javascript: this.className = 'created_list';"
								onclick="
										<c:choose>
											<c:when test="${empty param.orderItemId}">
												shoppingListJS<c:out value="${param.parentPage}"/>.addToList('${shoppingList.key}');
											</c:when>
											<c:otherwise>
												shoppingListJS<c:out value="${param.parentPage}"/>.addToListAndDelete('${shoppingList.key}', '<c:out value="${param.orderItemId}"/>');
											</c:otherwise>
										</c:choose>
								">
									<a id="<c:out value="${param.parentPage}"/>ShoppingListLink_${shoppingList.key}" href="
										<c:choose>
											<c:when test="${empty param.orderItemId}">
												javascript:shoppingListJS<c:out value="${param.parentPage}"/>.addToList('${shoppingList.key}');
											</c:when>
											<c:otherwise>
												javascript:shoppingListJS<c:out value="${param.parentPage}"/>.addToListAndDelete('${shoppingList.key}', '<c:out value="${param.orderItemId}"/>');
											</c:otherwise>
										</c:choose>
										" onfocus="javascript:shoppingListJS<c:out value="${param.parentPage}"/>.focusListLink(${shoppingList.key});" role="menuitem">
										${shoppingList.value}
									</a>
								</li>
							</c:forEach>
							<li style="display:none;" id="${param.parentPage}ShoppingListDivider"></li>
							</ol>
							<div class="divider"></div>
							<li role="menuitem" id="<c:out value="${param.parentPage}"/>ShoppingList_0" class="created_list" role="link" onfocus="javascript:shoppingListJS<c:out value="${param.parentPage}"/>.focusList(0);"
							onmouseover="javascript: shoppingListJS<c:out value='${param.parentPage}'/>.exceptionFlag = true; document.getElementById('<c:out value="${param.parentPage}"/>ShoppingListLink_0').focus();"
							onmouseout="javascript: this.className = 'created_list'; shoppingListJS<c:out value='${param.parentPage}'/>.exceptionFlag = false; if(document.getElementById('<c:out value="${param.parentPage}"/>shoppingListDropDown').style.display != 'none'){document.getElementById('<c:out value="${param.parentPage}"/>listOfShoppingLists').focus();}"
							onblur="javascript: this.className = 'created_list';"
							onclick="shoppingListJS<c:out value="${param.parentPage}"/>.showPopup('create');">
									<a id="<c:out value="${param.parentPage}"/>ShoppingListLink_0" href="javascript:shoppingListJS<c:out value="${param.parentPage}"/>.showPopup('create');"
										onfocus="javascript:shoppingListJS<c:out value="${param.parentPage}"/>.focusListLink(0);"
										role="menuitem"><fmt:message key="SL_CREATE_NEW_SHOPPING_LIST" /></a>
							</li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		
</div>
<!-- Hidden Fields -->
<input id="<c:out value="${param.parentPage}"/>storeParams" type="hidden" value="${storeParams}"/>
<input id="<c:out value="${param.parentPage}"/>catEntryParams" type="hidden" value="${catEntryParams}"/>
<input id="<c:out value="${param.parentPage}"/>shoppingListNames" type="hidden" value="{${shoppingListNames}}"/>

<%@ include file="CreateShoppingListPopup.jspf" %>
<%@ include file="ShoppingListCreateSuccessPopup.jspf" %>
