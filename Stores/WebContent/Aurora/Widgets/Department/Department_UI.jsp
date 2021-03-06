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

<div class="middle">
<div class="left_border">
	<div class="right_border">
		<div class="departments">
		
		<c:set var="numOfTopCategory" value="${numOfTopCategoryToDisplay}"/>
		<c:set var="countTopCategory" value="0"/>
		
		 <c:forEach var="topCategory" items="${fullCategoryList}" varStatus="status" end="${numOfTopCategory-1}">
		 
		 <c:set var="countTopCategory" value="${countTopCategory + 1}"/>
		 
			<%-- Top Category Menu item--%>
			<div class="department" id="department_${status.count}" role="menuitem">
			
					<c:set var="subTopCategoryList" value="${topCategory[2]}" />
					<c:set var="subTopCategoryURLList" value="${topCategory[3]}" />	
					<c:set var="nextLevelCategoryMappingList" value="${topCategory[4]}" />										
					
					<c:set var="numSubCat" value="${fn:length(subTopCategoryList)}"/>
					
					<c:choose>
						<c:when test="${countTopCategory < numOfTopCategory}">
							<div class="name_wrapper">
								<div class="name">
									<a id="TopCategoryLink_${status.count}" href="${topCategory[1]}"><c:out value="${topCategory[0]}"/>
									<c:if test="${numSubCat > 0}"><span class="spanacce"><fmt:message key="NEXT_CATEGORY_LEVEL_ACCE" /></span> </c:if>
									</a>
								</div>
								<c:if test="${numSubCat > 0}">
									<div class="arrow"></div>
									<div class="clear_float"></div>
								</c:if>
							</div>
						</c:when>
						<c:otherwise>
							<div class="name_wrapper">
								<div class="name">
									<a id="TopCategoryLink_${status.count}" href="<c:out value='${SiteMapURL}'/>"><fmt:message key="MORE_CATEGORY" />										
									</a>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
							
					<c:set var="numNextLevelSubCat" value="0"/>									
					<c:set var="numOfItemsToDisplay" value="0"/>
					<c:set var="totalNextLevelSubCat" value="${fn:length(nextLevelCategoryMappingList)}"/>
					<c:set var="numSubCatWithNextLevel" value="0"/>
					<c:set var="subCategoryDisplay" value="false"/>
					<c:set var="displayNextLevelSubCat" value="true"/>
					<c:set var="totalNextLevlSubCatDisplayed" value="0"/>
					<c:set var="totalMiddleLevelDisplayed" value="0"/>
					<c:set var="columns" value="0"/>
					
					<c:if test="${numSubCat > 0}"> <%-- Sub Category popup menu--%>
				
						<%-- Calculate no. of Sub category with next level category --%>
						<c:forEach var="nextLevelCategory" items="${nextLevelCategoryMappingList}" >
								<c:set var="nextLevelSubCat" value="${nextLevelCategory[2]}"/>
								<c:if test="${fn:length(nextLevelSubCat) > 0}">
									<c:set var="numNextLevelSubCat" value="${fn:length(nextLevelSubCat) + numNextLevelSubCat}"/>
									<c:set var="numSubCatWithNextLevel" value="${ numSubCatWithNextLevel + 1}"/>													
								</c:if>
						</c:forEach>
						
						<c:choose>
								<%-- Sub category with next level category --%>
								<c:when test="${numNextLevelSubCat > 0}">
									<c:set var="columns" value="${(numNextLevelSubCat + numSubCat + 1) / numSubCatPerColumn}"/>	
									<c:choose>
										<c:when test="${((columns%1) * numSubCatPerColumn) >= 1}">
											<c:set var="columns" value="${columns + (1 - (columns%1))}"/>
										</c:when>
										<c:otherwise>
											<c:set var="columns" value="${columns - (columns%1)}"/>
										</c:otherwise>
									</c:choose>
									
									<c:if test="${columns > maxColumn}">
										<c:set var="columns" value="${maxColumn}"/>
									</c:if>

									<c:if test="${fn:contains(columns, '.')}">
										<c:set var="columns" value="${fn:substringBefore(columns,'.')}"/>
									</c:if>

									<c:set var="width" value="${(224 * columns) + 2}"/>
									
									<c:choose>
										<c:when test="${(numNextLevelSubCat + numSubCat) <= (columns * numSubCatPerColumn)}">
											<c:set var="numOfItemsToDisplay" value="${columns * numSubCatPerColumn}"/>
										</c:when>
										<c:otherwise>
											<c:set var="numOfItemsToDisplay"  value="${((columns * numSubCatPerColumn) - (totalNextLevelSubCat - numSubCatWithNextLevel + 2)) / numSubCatWithNextLevel}"/>
											<c:set var="numOfItemsToDisplay"  value="${numOfItemsToDisplay - 1}"/>

											<c:choose>
												<c:when test="${(numOfItemsToDisplay%1) >= 0.5}">
													<c:set var="numOfItemsToDisplay" value="${numOfItemsToDisplay + (1 - (numOfItemsToDisplay%1))}"/>
												</c:when>
												<c:otherwise>
													<c:set var="numOfItemsToDisplay" value="${numOfItemsToDisplay - (numOfItemsToDisplay%1)}"/>
												</c:otherwise>
											</c:choose>

											<c:set var="numOfItemsToDisplay" value="${fn:substringBefore(numOfItemsToDisplay,'.')}"/>	
										</c:otherwise>
									</c:choose>

									<c:set var="subCategoryDisplay" value="true"/>

									<%-- If the count of sub category with next level exceeds 10, display only sub categories --%>
									<c:if test="${numOfItemsToDisplay < 2}">
										<c:set var="displayNextLevelSubCat" value="false"/>														
									</c:if>
									
								</c:when>
								<c:otherwise>
									<c:set var="columns" value="${(numSubCat + 1) / numSubCatPerColumn}"/>	
									<c:if test="${columns > maxColumn}">
										<c:set var="columns" value="${maxColumn}"/>
									</c:if>
									<c:set var="width" value="${224 * (columns + (1 - (columns%1)) % 1) + 2}"/>
								</c:otherwise>												
						</c:choose>											
						
						<%-- 
							1. Height of individual department names is around 30px ( 29px in CSS - div#widget_departments:focus > .drop_down > .middle > .left_border > .right_border > .departments > .department ) 
							2. The height of the subcategory popup is around 200px. (203 in CSS - div#widget_departments:focus > .drop_down > .middle > .left_border > .right_border > .departments > .department > .sub_categories )
							When shopper mouse hovers the department names, the subcategory pop-up will open-up...Now decide the position of the sub-category popup based on following logic..
							1. Assume the sub-catgory popUp will start at the same level as the main department name. So set mgtop == categoryNumber * 30
							2. No check to make sure that sub-cateogry popUp will not exceed the total height of the the main department list. If it exceeds, just make sure that the 
							bottom of the sub-category popUp and main department list popUp will align and do not worry about the aligning the top of subcategory popup with the department name..
						--%>

						<c:set var="mgtop" value="${(status.count-1) * 29}" /> <%-- Best case scenario --%>
						
						
						<fmt:message key="NEXT_SUBCATEGORY_ITEMS_ACCE" var="subCategoryTitle"/>	
						<div class="sub_categories" id="sub_categories_${status.count}" role="menu" style="width: ${width}px; margin-top: ${mgtop - 3}px;" title="<c:out value='${topCategory[0]}'/> <c:out value='${subCategoryTitle}'/>">
						
						<div class="top">
							<div class="left_border"></div>
							<div class="middle_tile"></div>
							<div class="right_border"></div>
						</div>	
						<div class="middle">
							<div class="left_border"></div>
							<div class="middle_tile">	
																									
								<c:set var="filledCatPerColumn" value="${numSubCatPerColumn}"/>	
								
								<c:choose>
									<c:when test="${(numNextLevelSubCat > 0) && (displayNextLevelSubCat eq 'true')}"> 
									
									
								<%-- 1st level --%>

										<c:forEach var="nextLevelCategoryList" items="${nextLevelCategoryMappingList}" varStatus="status3">
											<c:set var="nextLevelSubCatList" value="${nextLevelCategoryList[2]}"/>
											<c:set var="nextLevelSubCatURLList" value="${nextLevelCategoryList[3]}"/>
											
											<c:choose>
													<c:when test="${fn:length(nextLevelSubCatList) > numOfItemsToDisplay }">
														<c:set var="listLength" value="${numOfItemsToDisplay}"/>																		
													</c:when>
													<c:otherwise>
														<c:set var="listLength" value="${fn:length(nextLevelSubCatList)}"/>														
													</c:otherwise>
											</c:choose>								

										
											<c:set var="subTopCategoryAdded" value="false"/>
										
											<c:set var="length" value="${listLength - 1}"/>		
											<%-- 2nd level --%>			
											<c:choose>
												<c:when test="${length >= 0}">
																													
													<c:forEach var="nextSubTopCategory" items="${nextLevelSubCatList}" end="${length}" varStatus="status4">	
													
														<c:set var="totalNextLevlSubCatDisplayed" value="${totalNextLevlSubCatDisplayed + 1}"/>
														<c:if test="${filledCatPerColumn eq '0'}">		
															<c:set var="filledCatPerColumn" value="${numSubCatPerColumn}"/>														
														</c:if>																	
														<c:if test="${filledCatPerColumn eq numSubCatPerColumn}">
															<div class="sub_category" id="department_${status.count}_next_sub_category_${status3.count}">
														</c:if>																	
														<c:if test="${subTopCategoryAdded eq 'false'}">											
															<c:set var="totalNextLevlSubCatDisplayed" value="${totalNextLevlSubCatDisplayed + 1}"/>	
															<c:set var="totalMiddleLevelDisplayed" value="${totalMiddleLevelDisplayed + 1}"/>
															<div id="sub_top_item_${status.count}_${status3.count}" class="name item" role="menuitem">
																<a id="nextSubCategoryLink_${status.count}_${status3.count}" href="${nextLevelCategoryList[1]}"><c:out value="${nextLevelCategoryList[0]}" escapeXml="false"/>
																</a>
															</div>
															<c:set var="subTopCategoryAdded" value="true"/>
															<c:set var="firstItem" value="false"/>
															<c:set var="filledCatPerColumn" value="${filledCatPerColumn - 1}"/>
															<c:if test="${ filledCatPerColumn eq '0'}">		
																</div>
																<div class="sub_category" id="department_${status.count}_next_sub_category_${status3.count}">
																<c:set var="filledCatPerColumn" value="${numSubCatPerColumn}"/>														
															</c:if>	
														</c:if>	
														<c:set var="firstItem" value="true"/>
														<c:set var="filledCatPerColumn" value="${filledCatPerColumn -1}"/> 
														<c:set var="itemClass" value="item"/>
														<c:if test="${filledCatPerColumn eq (numSubCatPerColumn - 1)}">
															<c:set var="itemClass" value="first item"/>
														</c:if>
														<c:choose>	
															<c:when test="${(status4.count - 1 == length) && (status4.count != fn:length(nextLevelSubCatList) ) }">
																<div id="next_sub_item_${status.count}_${status3.count}_${status4.count}" class="${itemClass}" role="menuitem">
																		<a id="nextSubItemLink_${status.count}_${status3.count}_${status4.count}" href="${nextLevelCategoryList[1]}"><fmt:message key="MORE_CATEGORY" />
																		</a>
																</div>
															</c:when>
															<c:otherwise>
																<div id="next_sub_item_${status.count}_${status3.count}_${status4.count}" class="${itemClass}" role="menuitem">
																		<a id="nextSubItemLink_${status.count}_${status3.count}_${status4.count}" href="${nextLevelSubCatURLList[status4.count - 1]}"><c:out value="${nextSubTopCategory}" escapeXml="false"/>
																		</a>
																</div>
																
															</c:otherwise>
														</c:choose>	
														<c:if test="${ filledCatPerColumn eq '0' && (!status3.last || status3.last && !status4.last)}">		
															</div>																		
														</c:if>	
													</c:forEach>														
														
												</c:when>
												<c:otherwise>
													<c:set var="spaceLeft" value="${((columns * numSubCatPerColumn) - totalNextLevlSubCatDisplayed) }"/> 
													
													<c:if test="${spaceLeft >= 1}">
														<c:if test="${filledCatPerColumn eq '0'}">		
															<c:set var="filledCatPerColumn" value="${numSubCatPerColumn}"/>								
														</c:if>
														<c:if test="${filledCatPerColumn eq numSubCatPerColumn}">
															<div class="sub_category" id="department_${status.count}_next_sub_category_${status3.count}">
														</c:if>
														<c:set var="totalNextLevlSubCatDisplayed" value="${totalNextLevlSubCatDisplayed + 1}"/>
														<c:set var="totalMiddleLevelDisplayed" value="${totalMiddleLevelDisplayed + 1}"/>
														<div class="name item" role="menuitem" id="sub_top_item_${status.count}_${status3.count}">
															<a href="${nextLevelCategoryList[1]}" id="nextSubCategoryLink_${status.count}_${status3.count}"><c:out value="${nextLevelCategoryList[0]}" escapeXml="false"/>
															</a>
														</div>
														<c:set var="filledCatPerColumn" value="${filledCatPerColumn - 1}"/>
														<c:if test="${ filledCatPerColumn eq '0' && !status3.last}">		
															</div>																		
														</c:if>
													</c:if>	
												</c:otherwise>	
											</c:choose>
										</c:forEach>
										
										<c:choose>
											<c:when test="${subCategoryDisplay eq 'true'}">															<%-- Display more link if all sub-categories have not been displayed--%>
												<c:choose>
													<c:when test="${(numSubCat - totalMiddleLevelDisplayed) ne 0}">							
														<div id="sub_top_item_${status.count}_0" class="name item" role="menuitem">
															<a id="nextSubCategoryLink_${status.count}_0" href="${topCategory[1]}"><c:out value="${topCategory[0]}" escapeXml="false"/>
															</a>
														</div>
														<div id="next_sub_item_${status.count}_0_1" class="item" role="menuitem">
															<a id="nextSubItemLink_${status.count}_0_1" href="${topCategory[1]}"><fmt:message key="MORE_CATEGORY" />
															</a>
														</div>
														</div>
													</c:when>
													<c:otherwise>
														</div>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<c:if test="${ filledCatPerColumn > 0}">		
													</div>													
												</c:if>	
											</c:otherwise>
										</c:choose>	

								</c:when>												
								
								<c:otherwise>
									<c:set var="topCategoryAdded" value="false"/>
									<c:set var="maxItems" value="${maxColumn * numSubCatPerColumn}"/>
									
									<c:if test="${numSubCat >= maxItems}">
										<c:set var="numSubCat" value="${maxItems - 2}"/>												
									</c:if>
									
									<%@include file="Department_SubLevel_UI.jsp" %>
									
									<c:if test="${ filledCatPerColumn > 0}">		
										</div>													
									</c:if>	
										
								</c:otherwise>
							</c:choose>	
							</div>
							<div class="right_border"></div>
						</div>		 																	
						<div class="bottom">
							<div class="left_border"></div>
							<div class="middle_tile"></div>
							<div class="right_border"></div>
						</div>
					</div></c:if>																		
				</div>
			</c:forEach>	
			</div>
		</div>
	</div>
</div>
<div class="bottom">
	<div class="left_border"></div>
	<div class="middle_tile"></div>
	<div class="right_border"></div>
</div>
			