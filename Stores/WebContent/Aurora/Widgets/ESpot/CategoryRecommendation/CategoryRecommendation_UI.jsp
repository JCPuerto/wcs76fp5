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



<fmt:message var="espotTitle" key="ES_SHOP_FOR" />

<c:if test="${!empty param.espotTitle}">
	<c:set var="espotTitle" value="${param.espotTitle}"/>
</c:if>


		<div class="widget_product_listing container_margin_5px">
			<div class="top">
				<div class="left_border"></div>
				<div class="middle_tile"></div>
				<div class="right_border"></div>
			</div>
			<div class="middle">
				<div class="left_border">
					<div class="right_border">
						<div class="content texture_background">
							<div class="header_bar simple_bar">
								<div class="title"><c:out value="${espotTitle}"/></div>
							</div>
							<div class="product_listing_container">
								<fieldset>
								<legend><span class="spanacce"><fmt:message key='ES_PRODUCT_LISTING'/></span></legend>
								<div class="grid_mode">
									<div class="${rowClass} first_row">
										<c:forEach items="${categoryImageMap}" varStatus="aStatus">
											<div class="product">
												<div class="product_image">
													<c:if test="${!empty categoryURLMap[aStatus.current.key]}">
														<a id="CategoriesESpotImgLink_${uniqueID}_${aStatus.count}" 
															href="${categoryURLMap[aStatus.current.key]}">
													</c:if>
													<img src="${categoryImageMap[aStatus.current.key]}" alt="${categoryDescriptionMap[aStatus.current.key]}"/>
													<c:if test="${!empty categoryURLMap[aStatus.current.key]}">
														</a>
													</c:if>
												</div>
												<div class="product_info">
													<div class="item_spacer_10px"></div>
													<div class="item_spacer_10px"></div>
													<a class="product_group_name" href="${categoryURLMap[aStatus.current.key]}">${categoryIdentifierMap[aStatus.current.key]}</a>
												</div>
											</div>											
										</c:forEach>
									</div>
								</div>
								</fieldset>
							</div>
						</div>
					</div>				
				</div>

			</div>
			<div class="bottom">
				<div class="left_border"></div>
				<div class="middle_tile"></div>
				<div class="right_border"></div>
			</div>
		</div>
