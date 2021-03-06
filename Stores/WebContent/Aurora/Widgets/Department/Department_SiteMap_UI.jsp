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
	
	<!-- 
		The site map has 3 columns, the first and second column is use to display all top categories of the store.  For each top 
		categories, two level of sub-categories will also be displayed.  The object that is being use is same as the deparment menu.  
		The number of top categories to show in first column can be modified using the numOfTopCategoriesShowInFirstColumn variable.
		
		The last column displays content that is also located in footer.
	-->
	
<!-- Number of top categories to show in first column -->
<c:set var="numOfTopCategoriesShowInFirstColumn" value="0" />

<%-- Calculate the number of top categories to show in first column... --%>
<%-- First get the total count of topCategories + subCategories that we are going to display here --%>
<c:forEach var="topCategory" items="${fullCategoryList}" varStatus="status10">
	<c:set var="subCategoryList" value="${topCategory[4]}" />
	<%-- total count = totalCount + 1 for top category + count of subcategoires --%>
	<c:set var = "totalCount" value = "${totalCount + fn:length(subCategoryList) + 1}"/>
	<%-- to this count add the sub-subCategory list count --%>
	<c:forEach var="subCategory" items="${subCategoryList}" varStatus="status11">
		<c:set var = "subSubCategoryList" value="${subCategory[2]}" />
		<c:set var = "totalCount" value = "${totalCount + fn:length(subSubCategoryList)}"/>
	</c:forEach>
</c:forEach>

<%-- Lets divide the total count equally between first and second column --%>
<c:set var ="countInFirstColumn" value = "${totalCount/2}"/>

<%-- Now get the index of top category which will be displayed in first column --%>
<c:forEach var = "topCategory" items="${fullCategoryList}" varStatus="status09">
	<c:set var="subCategoryList" value="${topCategory[4]}" />
	<c:set var = "currentCount" value = "${currentCount + fn:length(subCategoryList) + 1}"/>
	<c:forEach var="subCategory" items="${subCategoryList}" varStatus="status1">
		<c:set var="subSubCategoryList" value="${subCategory[2]}" />
		<c:set var = "currentCount" value = "${currentCount + fn:length(subSubCategoryList)}"/>
	</c:forEach>
	<c:if test = "${currentCount < countInFirstColumn}">
		<%-- We still have space to display another category in first column. Update the numOfTopCategoriesShowInFirstColumn --%>
		<c:set var="numOfTopCategoriesShowInFirstColumn" value = "${numOfTopCategoriesShowInFirstColumn + 1}"/>
	</c:if>
</c:forEach>
	
	<!--Start Page Content -->
	<div class="content_wrapper_position" role="main">
		<div class="content_wrapper">
		
			<!--For border customization -->
			<div class="content_top">
				<div class="left_border"></div>
				<div class="middle"></div>
				<div class="right_border"></div>
			</div>
			
			<!-- Main Content Area -->
			<div class="content_left_shadow">
				<div class="content_right_shadow">				
					<div class="main_content">
						<!-- Start Main Content -->
						<div class="container_static_full_width container_margin_5px"> 
							
							<div class="static_page_content" id="sitemap_content">
								<div class="page_header"><fmt:message key="FOOTER_SITE_MAP" /></div>
								<div class="info_table_1">
									<div class="column_box">
									
										<div class="column">
											<ul>
												<c:forEach var="topCategory" items="${fullCategoryList}" varStatus="status" end="${numOfTopCategoriesShowInFirstColumn}">
													
													<c:set var="subCategoryList" value="${topCategory[4]}" />
													
													<li id="SiteMap_1_${status.count}" class="h2"><a href="<c:out value="${topCategory[1]}"/>"><c:out value="${topCategory[0]}"/></a>
													
													<c:if test="${fn:length(subCategoryList) > 0}"><ul></c:if>
													<c:forEach var="subCategory" items="${subCategoryList}" varStatus="status1">
														
														<c:set var="subSubCategoryList" value="${subCategory[2]}" />
														<c:set var="subSubCategoryListURL" value="${subCategory[3]}" />
														<c:set var="categoryStyle" value="h3"/>
																
														<c:if test="${fn:length(subSubCategoryList) > 0}">
															<c:set var="categoryStyle" value="h2"/>
														</c:if>
														
														<li id="SiteMap_1_${status.count}_${status1.count}" class="${categoryStyle}"><a href="<c:out value="${subCategory[1]}"/>"><c:out value="${subCategory[0]}"/></a>
														
														<c:if test="${fn:length(subSubCategoryList) > 0}"><ul></c:if>
														<c:forEach var="subSubCategory" items="${subSubCategoryList}" varStatus="status2">
																<li id="SiteMap_1_${status.count}_${status1.count}_${status2.count}" class="h3"><a href="${subSubCategoryListURL[status2.count-1]}"><c:out value="${subSubCategory}"/></a></li>
														</c:forEach>
														<c:if test="${fn:length(subSubCategoryList) > 0}"></ul></c:if>
														</li>
														
													</c:forEach>
													<c:if test="${fn:length(subCategoryList) > 0}"></ul></c:if>
													</li>
							
												</c:forEach>
											</ul>
										</div>
										
										<div class="column">
											<ul>
												<c:forEach var="topCategory" items="${fullCategoryList}" varStatus="status" begin="${numOfTopCategoriesShowInFirstColumn + 1}">
													
													<c:set var="subCategoryList" value="${topCategory[4]}" />
													
													<li class="h2"><a id="SiteMap_2_${status.count}" href="<c:out value="${topCategory[1]}"/>"><c:out value="${topCategory[0]}"/></a>
													
													<c:if test="${fn:length(subCategoryList) > 0}"><ul></c:if>
													<c:forEach var="subCategory" items="${subCategoryList}" varStatus="status1">
														
														<c:set var="subSubCategoryList" value="${subCategory[2]}" />
														<c:set var="subSubCategoryListURL" value="${subCategory[3]}" />
														<c:set var="categoryStyle" value="h3"/>
																
														<c:if test="${fn:length(subSubCategoryList) > 0}">
															<c:set var="categoryStyle" value="h2"/>
														</c:if>
														
														<li class="${categoryStyle}"><a id="SiteMap_2_${status.count}_${status1.count}" href="<c:out value="${subCategory[1]}"/>"><c:out value="${subCategory[0]}"/></a>
														
														<c:if test="${fn:length(subSubCategoryList) > 0}"><ul></c:if>
														<c:forEach var="subSubCategory" items="${subSubCategoryList}" varStatus="status2">
																<li class="h3"><a id="SiteMap_2_${status.count}_${status1.count}_${status2.count}" href="${subSubCategoryListURL[status2.count-1]}"><c:out value="${subSubCategory}"/></a></li>
														</c:forEach>
														<c:if test="${fn:length(subSubCategoryList) > 0}"></ul></c:if>
														</li>
														
													</c:forEach>
													<c:if test="${fn:length(subCategoryList) > 0}"></ul></c:if>
													</li>
							
												</c:forEach>
											</ul>
										</div>
										
										<div class="column">
											<ul>
												<li class="h2"><fmt:message key="FOOTER_CUSTOMER_SERVICE" /></li>
												<flow:ifEnabled feature="QuickOrder">
												<li class="h3"><a id="SiteMapQuickOrderLink" href="<c:out value='${QuickOrderURL}'/>"><fmt:message key="FOOTER_QUICK_ORDER"/></a></li>
												</flow:ifEnabled>
												<li class="h3"><a id="SiteMapHelpLink" href="<c:out value='${HelpViewURL}'/>"><fmt:message key="FOOTER_HELP"/></a></li>
												<li class="h3"><a id="SiteMapContactUsLink" href="<c:out value='${ContactUsViewURL}'/>"><fmt:message key="FOOTER_CONTACT_US"/></a></li>
												<li class="h3"><a id="SiteMapReturnPolicyLink" href="<c:out value='${ReturnPolicyViewURL}'/>"><fmt:message key="FOOTER_RETURN_POLICY"/></a></li>
												<li class="h3"><a id="SiteMapPrivacyPolicyLink" href="<c:out value='${PrivacyViewURL}'/>"><fmt:message key="FOOTER_PRIVACY_POLICY"/></a></li>
											</ul>

											<ul>
												<li class="h2"><fmt:message key="FOOTER_CORPORATE_INFO" /></li>
												<li class="h3"><a id="SiteMapAboutUslink" href="<c:out value='${CorporateInfoViewURL}'/>"><fmt:message key="FOOTER_ABOUT_US"/></a></li>
												<li class="h3"><a id="SiteMapCorporateContactUslink" href="<c:out value='${CorporateContactUsViewURL}'/>"><fmt:message key="FOOTER_CONTACT_US"/></a></li>
												<flow:ifEnabled feature="StoreLocator">
												<li class="h3"><a id="SiteMapStoreLocatorlink" href="<c:out value='${StoreLocatorURL}'/>"><fmt:message key="FOOTER_STORE_LOCATOR"/></a></li>
												</flow:ifEnabled>
											</ul>
										</div>
										<div class="clear_float"></div>
									</div>
								</div>
							</div>
							
							<div class="clear_float"></div>
						</div>
						<!-- End Main Content -->
					</div>
				</div>				
			</div>
			
			<!--For border customization -->
			<div class="content_bottom">
				<div class="left_border"></div>
				<div class="middle"></div>
				<div class="right_border"></div>
			</div>
			
		</div>
	</div>
	<!--End Page Content-->
			
		
