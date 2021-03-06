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

<!-- Widget Product Image Viewer -->
<div id="widget_product_image_viewer">
	<div class="top">
		<div class="left_border"></div>
		<div class="middle"></div>
		<div class="right_border"></div>
	</div>
	<div class="left_border">
		<div class="right_border">
			<div class="content">
				<div class="image_container">
					<img id="productMainImage" src="${productImage}" alt="<c:out value="${fullImageAltDescription}" escapeXml="false"/>" title="<c:out value="${fullImageAltDescription}" escapeXml="false"/>" class="product_main_image"/>
					<div class="clear_float"></div>
					<div class="hover_text">
						<span style="display:none;"><fmt:message key="FI_HOVER_OVER_IMAGE_TO_ZOOM"/></span>
					</div>
				</div>
				<c:set var="angledImageCount" value="${fn:length(angleThumbnailAttachmentMap)}" />
				<c:choose>
					<c:when test="${angledImageCount > 0}">
						<div class="other_views" style="display:all;">
							<h1><fmt:message key="FI_OTHER_VIEW"/></h1>
							<ul>
								<c:forEach items="${angleThumbnailAttachmentMap}" varStatus="aStatus">
									<c:choose>
										<c:when test="${aStatus.first}">
											<li id="productAngleLi<c:out value='${aStatus.index}'/>" class="selected">
												<a id="WC_CachedProductOnlyDisplay_links_1_<c:out value='${aStatus.count}'/>" href="JavaScript:changeThumbNail('productAngleLi<c:out value='${aStatus.index}'/>','${staticAssetContextRoot}/${angleFullImageAttachmentMap[aStatus.current.key]}');"
													title="${angleThumbnailAttachmentShortDescMap[aStatus.current.key]}">
													<img id="WC_CachedProductOnlyDisplay_images_1_<c:out value='${aStatus.count}'/>" src="${staticAssetContextRoot}/${angleThumbnailAttachmentMap[aStatus.current.key]}" alt="${angleThumbnailAttachmentShortDescMap[aStatus.current.key]}" />
												</a>
											</li>
										</c:when>
										<c:otherwise>
											<li id="productAngleLi<c:out value='${aStatus.index}'/>">
												<a id="WC_CachedProductOnlyDisplay_links_1_<c:out value='${aStatus.count}'/>" href="JavaScript:changeThumbNail('productAngleLi<c:out value='${aStatus.index}'/>','${staticAssetContextRoot}/${angleFullImageAttachmentMap[aStatus.current.key]}');"
													title="${angleThumbnailAttachmentShortDescMap[aStatus.current.key]}">
													<img id="WC_CachedProductOnlyDisplay_images_1_<c:out value='${aStatus.count}'/>" src="${staticAssetContextRoot}/${angleThumbnailAttachmentMap[aStatus.current.key]}" alt="${angleThumbnailAttachmentShortDescMap[aStatus.current.key]}" />
												</a>
											</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ul>
						</div>
					</c:when>
					<c:otherwise>
						<div class="other_views" style="display:none;">
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div class="clear_float"></div>
	<div class="bottom">
		<div class="left_border"></div>
		<div class="middle"></div>
		<div class="right_border"></div>
	</div>
</div>
<!-- End Widget Product Image Viewer -->