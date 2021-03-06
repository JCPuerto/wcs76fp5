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
	CompareProductJS.setCommonParameters('<c:out value="${langId}"/>','<c:out value="${storeId}"/>','<c:out value="${catalogId}"/>','<c:out value="${param.compareReturnName}" escapeXml="true"/>','<c:out value="${param.returnUrl}" escapeXml="false"/>');
</script>
<div class="widget_product_compare">
	<div class="compare_heading">
		<fmt:message key='CPG_COMPARE_PRODUCTS'/>
	</div>

	<div class="compare_back">
		<a id="compareBackLink" href="<c:out value="${param.returnUrl}"/>">
			<fmt:message key="CPG_BACK_TO_{0}" > 
				<fmt:param><c:out value="${param.compareReturnName}"/></fmt:param>
			</fmt:message>
		</a>
	</div>

	<div class="top">
		<div class="left_border"></div>
		<div class="middle"></div>
		<div class="right_border"></div>
	</div>										

	<div class="middle">
		<div class="left_border">
			<div class="right_border">
				<div class="content">
					<div class="heading zebra"><fmt:message key='CPG_COMPARE_LIMIT_MSG'/></div>
					<c:choose>
						<c:when test="${productCount eq 0}">
							<div class="message"><fmt:message key='CPG_COMPARE_PRODUCT_EMPTY'/></div>
						</c:when>
						<c:otherwise>
							<div class="compare_main">
								<div class="compare_${productCount}"> <!-- Can change this to compare_1 or compare_2 or compare_3 or compare_4 -->
									<div class="row height_spacing_top">
										<div class="heading"><fmt:message key='CPG_PRODUCT_IMAGE'/></div>
										<c:forEach var="catEntryId" items="${catEntryIds}" varStatus="status">
											<div class="item">
												<a id="prodUrl_${status.count}" href="${catEntryUrlMap[catEntryId]}" title="${catEntryShortDescMap[catEntryId]}">
													<img src="${catEntryImagesMap[catEntryId]}" alt="${catEntryShortDescMap[catEntryId]}"/>
												</a>
											</div>
										</c:forEach>
									</div>
		
									<div class="row">
									
										<div class="heading"></div>
										
										<c:forEach var="catEntryType" items="${catEntryTypeMap}" varStatus="status">
											<c:set var="buyableKey">${status.count}</c:set>
											<div class="item">
												<c:choose>
													<c:when test="${catEntryBuyable[buyableKey]}">
														<a id="add2CartBtn_${status.count}" href="javascript:setCurrentId('add2CartBtn_${status.count}');
															<c:choose>
																<c:when test="${(catEntryType.value eq 'ItemBean') or (catEntryType.value eq 'PackageBean')}">
																	CompareProductJS.add2ShopCart(${catEntryType.key},1);"
																</c:when>
																<c:otherwise>
																	QuickInfoJS.showDetails('${catEntryType.key}');"
																</c:otherwise>
															</c:choose>
															class="button_primary" wairole="button" role="button" title="<fmt:message key="ADD_TO_CART" />">
															<div class="left_border"></div>
															<div id="comparePageAdd2Cart_${status.count}" class="button_text">
																<fmt:message key="ADD_TO_CART" />
															</div>
															<div class="right_border"></div>
														</a>
													</c:when>
													<c:otherwise>
														<p><fmt:message key="SKU_NOT_BUYABLE"/></p>
													</c:otherwise>
												</c:choose>
											</div>
										</c:forEach>
									</div>
									<div class="row row_border reduce_margins">																				
										<div class="heading"></div>
										<c:forEach var="catEntryId" items="${catEntryIds}" varStatus="status">
											<div class="item">
												<a id="remove_${status.count}" href="javascript:CompareProductJS.remove('${catEntryId}');">
												<img class="remove" src="${jspStoreImgDir}/images/colors/color1/remove.png" alt=""/>
												<fmt:message key='CPG_REMOVE'/></a>
											</div>
										</c:forEach>
									</div>
		
									<div class="row row_border zebra">
		
										<div class="heading"><fmt:message key='CPG_PRODUCT'/></div>
										
										<c:forEach var="catEntryName" items="${catEntryNames}" varStatus="status">
											<div class="item" id="compare_product_${status.count}">${catEntryName}</div>
										</c:forEach>
		
									</div>
		
									<div class="row <c:if test="${hasBrand}">row_border</c:if>">
		
										<div class="heading"><fmt:message key='CPG_PRICE'/></div>
										
										<c:forEach var="catalogEntryDetails" items="${catEntryDetails}" varStatus="status">
											<c:set var="displayPriceRange" value="true" />
											<c:set var="catEntryIdentifier" value="${catalogEntryDetails.uniqueID}" />
											<div class="item" id="compare_price_${status.count}"><%@ include file="../PriceDisplay/PriceDisplay.jsp" %></div>
										</c:forEach>
		
									</div>
									
									<c:if test="${hasBrand}">
										<div class="row <c:if test="${not empty catEntryAttributes}">row_border </c:if> zebra">
			
											<div class="heading"><fmt:message key='CPG_BRAND'/></div>
			
											<c:forEach var="brand" items="${brands}" varStatus="status">
												<div class="item" id="compare_brand_${status.count}">${brand}</div>
											</c:forEach>
			
										</div>
									</c:if>
									
									<c:forEach var="catEntryAttribute" items="${catEntryAttributes}" varStatus="status">
										<div class="row <c:if test="${!status.last}">row_border </c:if> <c:if test="${status.count % 2 eq 0}">zebra</c:if>">
										
											<div class="heading">${catEntryAttribute.key}</div>
											
											<c:set var="catEntryAttributeValue" value="${catEntryAttribute.value}"/>
											
											<c:forEach begin="1" end="${productCount}" varStatus="valueStatus">
												<c:set var="attributeValueKey">${valueStatus.count}</c:set>
												<div class="item" id="compare_feature_${status.count}_${attributeValueKey}">
													<c:choose>
														<c:when test="${catEntryAttribute.value[attributeValueKey] eq catEntryAttribute.key}">
															<img src="${jspStoreImgDir}${env_vfileColor}check.png" alt="<fmt:message key='CPG_CHECK'/>"/>
														</c:when>
														<c:otherwise>
															<c:out value="${catEntryAttribute.value[attributeValueKey]}"/>
														</c:otherwise>
													</c:choose>
													
												</div>
											</c:forEach>
											
										</div>
									</c:forEach>
									
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>

	<div class="bottom">
		<div class="left_border"></div>
		<div class="middle"></div>
		<div class="right_border"></div>
	</div>
</div>