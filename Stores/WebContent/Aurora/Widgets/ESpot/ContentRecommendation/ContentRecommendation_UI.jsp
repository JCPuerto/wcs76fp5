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


	<div class="widget_height" tabindex="0">
		<c:forEach items="${contentFormatMap}" varStatus="aStatus">
			<c:choose>
				<c:when test="${contentFormatMap[aStatus.current.key] eq 'File'}">
					<c:choose>
						<c:when test="${contentTypeMap[aStatus.current.key] eq 'image'}">
							<c:choose>
								<c:when test="${numberContentPerRow > 1 && (aStatus.count % numberContentPerRow) == 0}">
									<c:set var="espotClass" value="right_espot espot_spacer"/>
								</c:when>
								<c:otherwise>
									<c:set var="espotClass" value="left_espot"/>
								</c:otherwise>
							</c:choose>
							<div class="${espotClass}">
								<c:if test="${!empty contentUrlMap[aStatus.current.key]}">
									<a id="ContentAreaESpotInfoImgLink_${uniqueID}_${aStatus.count}" 
										href="${contentUrlMap[aStatus.current.key]}" title="${contentDescriptionMap[aStatus.current.key]}">
								</c:if>
										<img id="ContentAreaESpotImg_${espotName}_${aStatus.count}" src="${contentImageMap[aStatus.current.key]}" alt="${contentDescriptionMap[aStatus.current.key]}"/>
								<c:if test="${!empty contentUrlMap[aStatus.current.key]}">
									</a>
								</c:if>
							</div>
						</c:when>
						<c:when test="${contentTypeMap[aStatus.current.key] eq 'application'}">
							<c:choose>
								<c:when test="${contentFlashMap[aStatus.current.key] == 'true'}">
									<c:if test="${!empty contentDescriptionMap[aStatus.current.key]}">
										 <div class="hidden_summary">
											<c:out value="${contentDescriptionMap[aStatus.current.key]}"/>
										 </div>
									</c:if>
									
									<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" tabindex="-1"
											<c:if test="${!empty param.adWidth}">
												 width="${param.adWidth}"
											 </c:if>
											 <c:if test="${!empty param.adHeight}">
												 height="${param.adHeight}"
											 </c:if>>
										<param name="movie" value="<c:out value="${contentUrlMap[aStatus.current.key]}"/>" />
										<param name="quality" value="high"/>
										<param name="bgcolor" value="#FFFFFF"/>
										<param name="pluginurl" value="http://www.macromedia.com/go/getflashplayer"/>
										<param name="wmode" value="transparent"/>
										<c:if test="${!empty baseObjectPath}">
											<param name="base" value="${baseObjectPath}" />
										</c:if>
										<!--[if !IE]>-->
										<object data="<c:out value="${contentUrlMap[aStatus.current.key]}"/>"
												 <c:if test="${!empty param.adWidth}">
													 width="${param.adWidth}"
												 </c:if>
												 <c:if test="${!empty param.adHeight}">
													 height="${param.adHeight}"
												 </c:if>
												 tabindex="-1"
												 type="application/x-shockwave-flash">
											 <param name="movie" value="<c:out value="${contentUrlMap[aStatus.current.key]}"/>" />
											 <param name="quality" value="high"/>
											 <param name="bgcolor" value="#FFFFFF"/>
											 <param name="pluginurl" value="http://www.macromedia.com/go/getflashplayer"/>
											 <param name="wmode" value="transparent"/>
											 <c:if test="${!empty baseObjectPath}">
												<param name="base" value="${baseObjectPath}" />
											 </c:if>
										</object>
										<!--<![endif]-->
									</object>
								</c:when>
								<c:otherwise>
									<a id="WC_ContentAreaESpot_links_4_<c:out value='${aStatus.count}'/>" href="<c:out value="${contentAssetPathMap[aStatus.current.key]}"/>" target="_blank"
										title='<c:out value="${contentDescriptionMap[aStatus.current.key]}"/>'>
				
									<img id="ContentAreaESpotImg_${espotName}_${aStatus.count}" src='<c:out value="${contentImageMap[aStatus.current.key]}"/>'
															  alt='<c:out value="${contentDescriptionMap[aStatus.current.key]}"/>'
															  border="0"  />
									 </a>
									 
									<%--
										  *
										  * Display the content text, with optional click information.
										  *
									--%>
									<c:if test="${!empty contentUrlMap[aStatus.current.key]}">
										 <a id="WC_ContentAreaESpot_links_5_<c:out value='${aStatus.count}'/>" href="contentUrlMap[aStatus.current.key]" ${clickOpenBrowser} >
									</c:if>
									
									<c:out value="${contentTextMap[aStatus.current.key]}" escapeXml="false" />
									
									<c:if test="${!empty contentUrlMap[aStatus.current.key]}">
										</a>
									</c:if>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<a href="<c:out value='${contentAssetPathMap[aStatus.current.key]}'/>" target="_new">
								<c:out value="${contentAssetPathMap[aStatus.current.key]}"/>
							</a>
																					
							<c:if test="${!empty contentUrlMap[aStatus.current.key]}">
								<a href="${contentUrlMap[aStatus.current.key]}" ${clickOpenBrowser} >
							</c:if>
							
							<c:if test="${!empty contentTextMap[aStatus.current.key]}">
								<br/>
								<c:out value="${contentTextMap[aStatus.current.key]}" escapeXml="false" />
							</c:if>
							
							<c:if test="${!empty contentUrlMap[aStatus.current.key]}">
							   </a>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:when test="${contentFormatMap[aStatus.current.key] eq 'Text'}">

						<c:if test="${!empty contentUrlMap[aStatus.current.key]}">
							<a id="WC_ContentAreaESpot_links_7_<c:out value='${aStatus.count}'/>" href="${contentUrlMap[aStatus.current.key]}" ${clickOpenBrowser} >
						</c:if>							
						
						<c:out value="${contentTextMap[aStatus.current.key]}" escapeXml="false" />
					
						<c:if test="${!empty contentUrlMap[aStatus.current.key]}">
							</a>
						</c:if>
				</c:when>
			</c:choose>
		</c:forEach>
	</div>
	
<c:if test="${!emptyFooterContent}">
	<script type="text/javascript">
		dojo.addOnLoad(function() { 
			var footer = document.getElementById("WC_Footer_UI_Links_3");
			if(footer != null){
				footer.className = footer.className + " right_border";
			}
		});            
	</script>			
</c:if>
