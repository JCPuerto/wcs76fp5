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

<%-- Create the popup to display the language and currency selection boxes --%>
<div id="widget_language_and_currency" style="display:none;">
	<div id="widget_language_and_currency_popup" dojoType="wc.widget.WCDialog" closeOnTimeOut="false" title="<fmt:message key='DIALOG_TITLE_LANGUAGE_AND_CURRENCY' />">
		<div class="widget_language_and_currency_popup widget_site_popup">										
			<!-- Top Border Styling -->
			<div class="top">
				<div class="left_border"></div>
				<div class="middle"></div>
				<div class="right_border"></div>
			</div>
			<div class="clear_float"></div>
			<!-- Main Content Area -->
			<div class="middle">
				<div class="content_left_border">
					<div class="content_right_border">
						<div class="content">
							<div class="header">
								<span><fmt:message key="LC_LANGUAGE_CURRENCY_SELECTION"/></span>
								<a id="close" class="close_acce" title="<fmt:message key='LC_CLOSE'/>" href="javascript:dijit.byId('widget_language_and_currency_popup').hide();"><img role="button" onmouseover="this.src='<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_hover.png'" onmouseout="this.src='<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_normal.png'" src="<c:out value='${jspStoreImgDir}'/>images/colors/color1/close_normal.png" class="closeImg" alt="<fmt:message key='LC_CLOSE'/>"/></a>
								<div class="clear_float"></div>
							</div>
							<div class="selectors">
								<div class="selector">
									<span class="option_name"><fmt:message key="LC_LANGUAGE"/>&nbsp;</span>
									<label for="languageSelection" class="nodisplay"><fmt:message key="LC_LANGUAGE"/></label>
									<select class="left" id="languageSelection" name="langId" onchange="javascript:document.getElementById('languageSelectionHidden').value=this.value">
										<c:forEach var="supportedLanguage" items="${supportedLanguages}">
											<c:forEach var="additionalValue" items="${supportedLanguage.additionalValue}">
												<c:if test="${additionalValue.name == 'languageId'}">
													<c:set var="currentLanguageId" value="${additionalValue.value}"/>
												</c:if>
											</c:forEach>
											<c:forEach var="dbLanguage" items="${sdb.languageDataBeans}">
												<c:if test="${currentLanguageId == dbLanguage.languageId}">
													<c:set var="currentLanguageString" value="${dbLanguage.nativeDescriptionString}"/>
												</c:if>
											</c:forEach>
											<c:choose>
												<c:when test="${currentLanguageId == CommandContext.languageId}">
													<option value='<c:out value="${currentLanguageId}" escapeXml="false"/>' selected="selected"><c:out value="${currentLanguageString}" escapeXml="false"/></option>
												</c:when>
												<c:otherwise>
													<option value='<c:out value="${currentLanguageId}" escapeXml="false"/>'><c:out value="${currentLanguageString}" escapeXml="false"/></option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
									<div class="clear_float"></div>
								</div>
								<div class="selector">
									<span class="option_name"><fmt:message key="LC_CURRENCY"/>&nbsp;</span>
									<label for="currencySelection" class="nodisplay"><fmt:message key="LC_CURRENCY"/></label>
									<select class="left" id="currencySelection" name="currency" onchange="javascript:document.getElementById('currencySelectionHidden').value=this.value">
										<c:forEach var="supportedCurrency" items="${supportedCurrencies}">
											<c:forEach var="additionalValue" items="${supportedCurrency.additionalValue}">
												<c:if test="${additionalValue.name == 'currencyCode'}">
													<c:set var="currentCurrencyCode" value="${additionalValue.value}"/>
												</c:if>
											</c:forEach>
											<c:choose>
												<c:when test="${currentCurrencyCode == CommandContext.currency}">
													<option value='<c:out value="${currentCurrencyCode}" escapeXml="false"/>' selected="selected"><c:out value="${supportedCurrency.primaryValue.value}" escapeXml="false"/></option>
												</c:when>
												<c:otherwise>
													<option value='<c:out value="${currentCurrencyCode}" escapeXml="false"/>'><c:out value="${supportedCurrency.primaryValue.value}"  escapeXml="false"/></option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</select>
									<div class="clear_float"></div>
								</div>
								<form id="SetLanguageCurrencyPreferenceForm"action="${env_contextAndServletPath}/SetCurrencyPreference" method="post">
									<input type="hidden" name="storeId" value="<c:out value="${storeId}"/>"/>
									<input type="hidden" name="catalogId" value="<c:out value="${catalogId}"/>"/>
									<input type="hidden" id="languageSelectionHidden" name="langId" value="<c:out value="${langId}"/>"/>
									<input type="hidden" id="currencySelectionHidden" name="currency" value="${env_currencyCode}"/>									
									<c:set var="reLaunchURL" value="${env_contextAndServletPath}${requestScope['javax.servlet.forward.path_info']}"/>
									<c:choose>
										<c:when test="${WCParam.URL != null && WCParam.URL!=''}" >
											<input type="hidden" name="URL" value="<c:out value="${reLaunchURL}" />?URL=<c:out value="${WCParam.URL}"/>?currency*=" id="WC_SidebarDisplay_FormInput_URL_1"/>
										</c:when>
										<c:otherwise>
											<input type="hidden" name="URL" value="<c:out value="${reLaunchURL}" />?currency*=" id="WC_SidebarDisplay_FormInput_URL_2"/>
										</c:otherwise>
									</c:choose>
									<c:forEach var="aParam" items="${WCParamValues}" varStatus="paramStatus">
										<c:forEach var="aValue" items="${aParam.value}"  varStatus="paramNumStatus">
											<c:if test="${aParam.key !='langId' && aParam.key !='logonPassword' && aParam.key !='URL' && aParam.key !='currency' && aParam.key !='storeId' && aParam.key !='catalogId'}">
												<input type="hidden" name="<c:out value="${aParam.key}" />" value="<c:out value="${aValue}" />" id="WC_SidebarDisplay_FormInput_parm_<c:out value="${paramStatus.count}" />_<c:out value="${paramNumStatus.count}" />"/>
											</c:if>
										</c:forEach>
									</c:forEach>
									
								</form>
							</div>
							<div class="footer">
								<div class="button_container ">
									<a id="LangCurrencyApplyBtn" class="button_primary" tabindex="0" href="javascript:dijit.byId('widget_language_and_currency_popup').hide();document.getElementById('SetLanguageCurrencyPreferenceForm').submit();">
										<div class="left_border"></div>
										<div id="LangCurrencyApplyBtnText" class="button_text"><fmt:message key="LC_APPLY"/></div>
										<div class="right_border"></div>
									</a>
									<div class="clear_float"></div>
								</div>
								
							</div>
							<div class="clear_float"></div>
						<!-- End content Section -->
						</div>
					<!-- End content_right_border -->
					</div>
				<!-- End content_left_border -->
				</div>
			</div>
			<div class="clear_float"></div>
			<!-- Bottom Border Styling -->
			<div class="bottom">
				<div class="left_border"></div>
				<div class="middle"></div>
				<div class="right_border"></div>
			</div>
			<div class="clear_float"></div>
		</div>
	</div>
</div>

<%-- Display the lang/currency link --%>
<span class="masthead_links_item"><a id="LanguageCurrencyChangeLink" href="javaScript: shoppingActionsJS.showWCDialogPopup('widget_language_and_currency_popup');"><fmt:message key="LC_LANGUAGE_CURRENCY"/></a></span> &#124;
