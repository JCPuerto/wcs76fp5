<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<div class="widget_left_nav" id="widget_left_nav">
	<div class="top">
		<div class="left_border">
			
		</div>
		<div class="middle">
			
		</div>
		<div class="right_border">
			
		</div>
	</div>
	
	<div class="clear_float"></div>
	
	<c:set var="facetSection" value="0"/>
	<div class="content_left_border">
		<div class="content_right_border">
			<div class="content">
				<c:if test="${!empty categoryFacetList}">
						<div class="content_section bottom_border_5px">
						<div class="header bottom_border">
							<span class="header_title left"><fmt:message key="LN_SEARCH_FACET_CATEGORY" /></span>
						</div>
						<div class="section_list bottom_border" id="search_facet_category">
							<ul>
								<c:forEach var="categoryFacetValues" items="${categoryFacetList}" varStatus="aStatus" >
									<li><a id="SBN_<c:out value="${categoryFacetValues[0]}"/>" href="<c:out value="${categoryFacetValues[2]}" escapeXml="false"/>"><c:out value="${categoryFacetValues[0]}"/> (<c:out value="${categoryFacetValues[1]}"/>)</a></li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</c:if>

				<c:if test="${empty categoryFacetList || f != 0}">
					<div class="content_section">
						<div class="header bottom_border">
							<span class="filter_by_title left"><fmt:message key="LN_SEARCH_FACET_FILTER_BY"/></span>
							<div id="clear_all_filter" class="clearall" style="display: none">
								<a id="LeftNavigationSearchClearAllLink" href="#" onclick="SearchBasedNavigationDisplayJS.clearAllFacets(); return false;" title="<fmt:message key="LN_SEARCH_FACET_CLEAR_ALL"/>">
									<div class="clear_all_text">
										<div class="filter_sprite"><img src="${jspStoreImgDir}images/colors/color1/close_circle_sprite.png" alt=""></div>
										<span><fmt:message key="LN_SEARCH_FACET_CLEAR_ALL"/></span>
									</div>
								</a>
								<div class="clear_float"></div>
							</div>
							<div class="clear_float"></div>
						</div>
						<div class="filter_list section_list bottom_border">
							<ul id="facetFilterList"></ul>
						</div>
					</div>
					<form id="productsFacets">
						<c:if test="${!empty facetArray}">
							<c:forEach var="facetList" items="${facetArray}" varStatus="facetCounter">
								<c:set var="facetClass" value="${facetList[2] == true ? '' : 'singleFacet'}"/>
								<c:set var="facetSectionElement" value="${facetList[2] == true ? '' : facetSection}"/>
								<c:set var="showMore" value="false"/>
								<fieldset>
								<legend class="spanacce"><c:out value="${facetList[0]}"/></legend>
								<div class="content_section" id="section_${facetSection}">
									<a href="#" onclick='SearchBasedNavigationDisplayJS.toggleExpand(<c:out value="${facetSection}"/>); return false;'>
										<div class="header bottom_border">
											<span id="expand_icon_${facetSection}" class="expand_icon_open"></span>
											<span class="header_title left"><c:out value="${facetList[0]}"/></span>
										</div>
									</a>
									<div id="section_list_${facetSection}" class="section_list bottom_border">
										<ul>
											<c:set var="facetFilterSpriteImgPath" value="${jspStoreImgDir}images/colors/color1/widget_left_nav/filter_sprite.png"/>
											<c:forEach var="facetValues" items="${facetList[1]}" varStatus="aStatus" >
												<c:set var="facetId" value="${facetValues[3]}"/>
												<script>SearchBasedNavigationDisplayJS.facetIdsArray.push("${facetId}")</script>
												<c:if test="${aStatus.index == facetList[3]}">
													<c:set var="showMore" value="true"/>
													<a href="#" id="morelink_${facetSection}" onclick="SearchBasedNavigationDisplayJS.toggleShowMore(${facetSection}, true)"><fmt:message key="LN_SEARCH_FACET_SHOW_ALL" /></a>
													</ul>
													<ul id="more_${facetSection}" class="nodisplay">
												</c:if>

												<c:if test="${!empty facetValues[4]}">
													<c:set var="facetClass" value="singleFacet left"/>
												</c:if>
												
												<li id="facet_${facetId}" class="${facetClass}">
													<input type="checkbox" aria-labelledby="facet_checkbox${facetId}_ACCE_Label" id="facet_checkbox${facetId}" name="facetlist_facet_${aStatus.count}" value="<c:out value='${facetValues[2]}' escapeXml='false'/>" onclick="javascript: SearchBasedNavigationDisplayJS.toggleSearchFilter(this, '${facetId}', '${facetSectionElement}', '${facetFilterSpriteImgPath}', '<fmt:message key="LN_SEARCH_FACET_REMOVE" />')" <c:if test="${facetValues[1] == 0}">disabled</c:if>/>
													<label for="facet_checkbox${facetId}">
														<c:choose>
															<c:when test="${!empty facetValues[4]}">
																<span class="swatch">
																	<span class="outline">
																		<span id="facetLabel_${facetId}"><img src="${env_imageContextPath}/${facetValues[4]}" title="${facetValues[0]}" alt="${facetValues[0]}"/></span> (<span id="facet_count${facetId}"><c:out value="${facetValues[1]}"/></span>)
																	</span>
																</span>
															</c:when>
															<c:otherwise>
																<span class="outline">
																	<span id="facetLabel_${facetId}"><c:out value="${facetValues[0]}" escapeXml="false"/></span> (<span id="facet_count${facetId}"><c:out value="${facetValues[1]}"/></span>)
																</span>
															</c:otherwise>
														</c:choose>
														<span class="spanacce" id="facet_checkbox${facetId}_ACCE_Label">${facetValues[0]} (<c:out value="${facetValues[1]}"/>)</span>
													</label>
												</li>
											</c:forEach>

											<c:if test="${showMore}">
												<a href="#" id="lesslink_${facetSection}" onclick="SearchBasedNavigationDisplayJS.toggleShowMore(${facetSection}, false)"><fmt:message key="LN_SEARCH_FACET_SHOW_LESS" /></a>
											</c:if>

											<c:if test="${price_facet_index == facetCounter.index}">
												<li>
													<span class="spanacce"><label for="low_price_input"><fmt:message key="LN_SEARCH_FACET_LOWER_BOUND" /></label></span>
													<span class="spanacce"><label for="high_price_input"><fmt:message key="LN_SEARCH_FACET_UPPER_BOUND" /></label></span>
													<c:out value="${env_CurrencySymbolToFormat}" escapeXml="false"/> <input id="low_price_input" onkeyup="SearchBasedNavigationDisplayJS.checkPriceInput(event, '${env_CurrencySymbolToFormat}', '${facetFilterSpriteImgPath}', '${facetSectionElement}', '<fmt:message key="LN_SEARCH_FACET_REMOVE" />');" class="range_input" type="text"/> - <c:out value="${env_CurrencySymbolToFormat}" escapeXml="false"/> <input id="high_price_input" onkeyup="SearchBasedNavigationDisplayJS.checkPriceInput(event, '${env_CurrencySymbolToFormat}', '${facetFilterSpriteImgPath}', '${facetSectionElement}', '<fmt:message key="LN_SEARCH_FACET_REMOVE" />');" class="range_input" type="text"/> <input id="price_range_go" class="go_button_disabled" type="button" value="<fmt:message key="GO_BUTTON_LABEL" />" onclick="SearchBasedNavigationDisplayJS.appendFilterPriceRange('${env_CurrencySymbolToFormat}', '${facetFilterSpriteImgPath}', '${facetSectionElement}', '<fmt:message key="LN_SEARCH_FACET_REMOVE" />');" disabled/>
												</li>
												<input type="hidden" id="low_price_value" name="low_price_value" value=""/>
												<input type="hidden" id="high_price_value" name="high_price_value" value=""/>
											</c:if>
										</ul>
									</div>
								</div>
								</fieldset>
								<c:set var="facetSection" value="${facetSection + 1}"/>
							</c:forEach>
						</c:if>
					</form>

					<c:if test="${f == 0}">
						<div class="content_section">
							<div class="section_list">
								<ul>
									<li><fmt:message key="LN_SEARCH_NO_FURTHER_REFINEMENT"/></li>
								</ul>
							</div>
						</div>
					</c:if>
				</c:if>
			</div>
		</div>
	</div>
	
	<div class="bottom">
		<div class="left_border">
			
		</div>
		<div class="middle">
			
		</div>
		<div class="right_border">
			
		</div>
	</div>
	
</div>