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

<form name="CatalogSearchForm" action="${searchView}" method="get" id="CatalogSearchForm">
	
	<!-- Search Widget -->
	<div class="widget_search_position" role="search">
		<div id="widget_search">
			<div class="left_border"></div>
			<div class="content">
	
				<label for="SimpleSearchForm_SearchTerm" class="nodisplay"><fmt:message key="SEARCH_CATALOG" /></label>
				<input type="text" class="search_input gray_color" placeholder="<fmt:message key="SEARCH_CATALOG" />" name="searchTerm" id="SimpleSearchForm_SearchTerm" autocomplete="off" maxlength="65" tabindex="0" title="<fmt:message key='SEARCH_SUGGESTION'/>" onkeypress="return SearchJS._onKeyPress(event);" value='<fmt:message key="SEARCH_CATALOG"/>'></input>

				<div role="button" aria-labelledby="searchDepartmentList_ACCE_Label" onclick="$('searchDepartmentList').style.display='block'" onfocus="$('searchDepartmentList').style.display='block'; dojo.byId('searchDepartmentList_0').focus();" tabindex="0" class="all_departments">
					<span id="searchDepartmentLabel"><fmt:message key="SEARCH_ALL_DEPARTMENTS" /></span>
				</div>
				<input id="search_categoryId" type="hidden" name="categoryId" value=""/>
				<span class="spanacce" id="searchDepartmentList_ACCE_Label"><fmt:message key="SEARCH_IN" /></span>
				<div class="widget_search_departments_dropdown_position" role="menu" aria-labelledby="searchDepartmentList_ACCE_Label" onblur="clearTimeout(SearchJS.searchDepartmentHoverTimeout);SearchJS.searchDepartmentHoverTimeout=setTimeout('SearchJS.hideSearchDepartmentList()',300)" onmouseout="clearTimeout(SearchJS.searchDepartmentHoverTimeout);SearchJS.searchDepartmentHoverTimeout=setTimeout('SearchJS.hideSearchDepartmentList()',300)" onmouseover="clearTimeout(SearchJS.searchDepartmentHoverTimeout);" id="searchDepartmentList">
					<div class="widget_search_departments_dropdown">
						<div class="top">
							<div class="left_border"></div>
							<div class="middle"></div>
							<div class="right_border"></div>
						</div>

						<div class="clear_float"></div>
						<div class="content_left_border">
							<div class="content_right_border">
								<ul id="searchDepartmentList_root">
									<li><a href="#" id="searchDepartmentList_0" role="menuitem" onkeypress="SearchJS.searchDepartmentKeyPressed(event, 0, ${fn:length(searchDropdownCategoryList)}, '', this);" onmousedown="SearchJS.searchDepartmentSelect('', this)" onmouseover="this.className='enabled'" onfocus="this.className='enabled'" onblur="this.className='disabled'" onmouseout="this.className='disabled'"><fmt:message key="SEARCH_ALL_DEPARTMENTS" /></a></li>
									<c:forEach var="topCategory" items="${searchDropdownCategoryList}" varStatus="status">
										<li><a href="#" id="searchDepartmentList_${status.count}" role="menuitem" onkeypress="SearchJS.searchDepartmentKeyPressed(event, ${status.count}, ${fn:length(searchDropdownCategoryList)}, '${topCategory[1]}', this);" onmousedown="SearchJS.searchDepartmentSelect('${topCategory[1]}', this)" onfocus="this.className='enabled'" onblur="this.className='disabled'" onmouseover="this.className='enabled'" onmouseout="this.className='disabled'"><c:out value="${topCategory[0]}"/></a></li>
									</c:forEach>
								</ul>
							</div>
						</div>
						<div class="clear_float"></div>

						<div class="bottom">																
							<div class="left_border"></div>
							<div class="middle"></div>
							<div class="right_border"></div>
						</div>

						<div class="clear_float"></div>	
					</div>
				</div>
				
				<input id="search_submit" class="search_submit" type="image" onmouseout="javascript: this.src='${jspStoreImgDir}${env_vfileColor}widget_search/search_submit.png'" onmouseover="javascript: this.src='${jspStoreImgDir}${env_vfileColor}widget_search/search_submit_hover.png'" onblur="javascript: this.src='${jspStoreImgDir}${env_vfileColor}widget_search/search_submit.png'" onfocus="javascript: this.src='${jspStoreImgDir}${env_vfileColor}widget_search/search_submit_hover.png'" alt="<fmt:message key='SEARCH_CATALOG'/>" src="<c:out value='${jspStoreImgDir}${env_vfileColor}'/>widget_search/search_submit.png"  value="<fmt:message key='SEARCH_CATALOG' />" />

			</div> <!-- content -->
			<div class="right_border"></div>
			<div class="clear_float"></div>
		</div> <!-- widget_search -->
	</div> <!-- widget_search_position -->

	<!-- Start SearchDropdownWidget -->
	<div id="autoSuggest_Result_div" style="display:none;">

		<div id="widget_search_dropdown" class="widget_search_dropdown_position">
			<div class="widget_search_dropdown">
		
				<!-- Top Border Styling -->
				<div class="top">
					<div class="left_border"></div>
					<div class="middle"></div>
					<div class="right_border"></div>
				</div>
				<div class="clear_float"></div>
				
				<!-- Main Content Area -->
				<div class="content_left_border">
					<div class="content_right_border">
		
						<div id="AutoSuggestDiv" class="content" role="region" aria-required="true" aria-labelledby="AutoSuggestDiv" onmouseover="SearchJS.autoSuggestHover = true;" onmouseout="SearchJS.autoSuggestHover = false; document.getElementById('SimpleSearchForm_SearchTerm').focus();">
							
								<span id="autoSuggestDynamic_Result_div_ACCE_Label" class="spanacce"><fmt:message key="SEARCH_AUTO_SUGGEST_ACCE_REGION" /></span>  
								<div dojoType="wc.widget.RefreshArea" widgetId="autoSuggestDisplay_Widget" controllerId="AutoSuggestDisplayController" id="autoSuggestDynamic_Result_div" role="region" aria-live="polite" aria-atomic="true" aria-relevant="all" aria-labelledby="autoSuggestDynamic_Result_div_ACCE_Label" >
									<%-- Div to show the suggested keywords --%>
								</div>
		
								<div id="autoSuggestStatic_1"></div>
								<div id="autoSuggestStatic_2"></div>
								<div id="autoSuggestStatic_3"></div>
								<div id="autoSuggestHistory"></div>
								<div class="heading"> <a href="#" id="viewAllResults" ><div><fmt:message key="VIEW_ALL_RESULTS"/></div></a> </div>
		
						<!-- End content Section -->
						</div>
		
					<!-- End content_right_border -->
					</div>
				<!-- End content_left_border -->
				</div>
				
				<!-- Bottom Border Styling -->
				<div class="bottom">
					<div class="left_border"></div>
					<div class="middle"></div>
					<div class="right_border"></div>
				</div>
				
			</div>
		</div>
	<!-- End SearchDropdownWidget -->
	</div>
	
	<!-- Refresh area to retrieve cached suggestions -->
	<span id="autoSuggestCachedSuggestions_div_ACCE_Label" class="spanacce"><fmt:message key="SEARCH_AUTO_SUGGEST_CACHED_ACCE_REGION" /></span>
	<div dojoType="wc.widget.RefreshArea" widgetId="AutoSuggestCachedSuggestions" controllerId="AutoSuggestCachedSuggestionsController" id="autoSuggestCachedSuggestions_div" role="region" aria-live="polite" aria-atomic="true" aria-relevant="all" style="display:none;" aria-labelledby="autoSuggestCachedSuggestions_div_ACCE_Label">
	</div>

	<%-- Added by development team	--%>
	<input type="hidden" name="storeId" value='<c:out value="${storeId}" />' />
	<input type="hidden" name="catalogId" value='<c:out value="${catalogId}"/>' />
	<input type="hidden" name="langId" value='<c:out value="${langId}"/>' />
	<input type="hidden" name="pageSize" value="12" />
	<input type="hidden" name="beginIndex" value="0" />
	<input type="hidden" name="sType" value="SimpleSearch" />
	<input type="hidden" name="resultCatEntryType" value="2" />
	<input type="hidden" name="showResultsPage" value="true" />
	<input type="hidden" name="searchSource" value="Q" />
	<input type="hidden" name="pageView" value="<c:out value='${env.defaultPageView}'/>" />
	<span id="searchTextHolder" class="nodisplay"><fmt:message key="SEARCH_CATALOG" /></span>

</form>