<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%--
  *****
  *
  * Parameters
  * -storeId
  * Specifies the store to use
  *
  * -catalogId
  * Specifies the catalog to use
  *
  * -catType
  * Mandatory. The catalog object type, valid vales are category, product, package, bundle, and item. 
  * 
  * -categoryId
  * mandatory if catType = "category". The category that contains the attachment
  *
  * -productId
  * mandatory if catType is not specified or catType = product/package/bundle/item. The product that contains the attachment
  *
  * -usage
  * Usage of the attachment (atchrlus.identifier)
  * If not specified, the page will get all attachments of the catalog object.
  *
  * -excludeUsageStr
  * Exclude any attachments which usage appears in the string (atchrlus.identifier)
  * If the is more than one usage type to exclude, separate them by comma 
  * If not specified, the page will get all attachments of the catalog object.
  *
  * -retrieveLanguageIndependentAtchAst
  * Specifies that the language independant assets should be returned. Should be set to 1 in all cases.
  *
  * This is an example of how this file could be included into a page - to retrieve attachment for a product:
  *		<c:import url="${jspStoreDir}Snippets/Catalog/Attachments/CatalogAttachmentAssetsDisplay.jsp">
  *			<c:param name="storeId" value="${WCParam.storeId}"/>
  *			<c:param name="catalogId" value="${WCParam.catalogId}"/>
  *			<c:param name="langId" value="${langId}"/>
  *			<c:param name="productId" value="${WCParam.productId}"/>
  *			<c:param name="catType" value="product"/>
  *			<c:param name="excludeUsageStr" value="ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40,IMAGE_SIZE_330,IMAGE_SIZE_1000"/>
  *			<wcf:param name="retrieveLanguageIndependentAtchAst" value="1"/>
  *		</c:import>
  *
  * This is an example of how this file could be included into a page - to retrieve attachment for a category:
  *		<c:import url="${jspStoreDir}Snippets/Catalog/Attachments/CatalogAttachmentAssetsDisplay.jsp">
  *			<c:param name="storeId" value="${WCParam.storeId}"/>
  *			<c:param name="catalogId" value="${WCParam.catalogId}"/>
  *			<c:param name="langId" value="${langId}"/>
  *			<c:param name="categoryId" value="${WCParam.categoryId}"/>
  *			<c:param name="catType" value="category"/>
  *			<wcf:param name="retrieveLanguageIndependentAtchAst" value="1"/>
  *		</c:import>
  *	
--%>

<!-- BEGIN CatalogAttachmentAssetsDisplay.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../../../include/JSTLEnvironmentSetup.jspf"%>
<%@ include file="../../../include/ErrorMessageSetup.jspf" %>

<%-- determines if it should retrieve attachment for catgroup or catentry --%>

<c:set var="isSiteMap" value="true"/>
<c:if test="${(!empty param.catType) && !(param.catType eq 'category')}">
		<c:set var="isSiteMap" value="false"/>
		
</c:if>

<c:choose>
	<c:when test="${(!empty param.catType) && (param.catType eq 'category') &&(!empty param.categoryId)}">
		
		<wcbase:useBean id="catObject" classname="com.ibm.commerce.catalog.beans.CategoryDataBean" scope="page">
			<c:set property="categoryId" value="${param.categoryId}" target="${catObject}" />
			<c:if test="${(!empty param.catalogId)}">
				<c:set property="catalogId" value="${param.catalogId}" target="${catObject}" />
			</c:if>
		</wcbase:useBean>
		<c:choose>
			<c:when test="${!empty param.usage}">
				<c:set property="attachmentUsage" value="${param.usage}" target="${catObject}" />
				<c:set var="AttachmentDataBeans" value="${catObject.attachmentsByUsage}" />
			</c:when>
			<c:otherwise>
				<c:set var="AttachmentDataBeans" value="${catObject.allAttachments}" />
			</c:otherwise>
		</c:choose>
		
		<c:set var="currentAttachmentCount" value="0" />
		<c:set var="showHeader" value="true"/>
		
		<c:forEach items="${AttachmentDataBeans}" var="attachmentDB" varStatus="status">
			<%-- checks the usage type of this attachment and see if should exclude this attachment from display --%>
	        <c:set var="AttachmentAssetDataBeans" value="${attachmentDB.attachmentAssets}" />
	        <c:forEach items="${AttachmentAssetDataBeans}" var="AttachmentAssetDataBean">
			    <c:set var="displayAttachment" value="true" />
	            <c:forTokens items="${param.excludeUsageStr}" delims="," var="usageType">
				    <c:if test="${usageType == attachmentDB.attachmentRelationUsage.identifier}">
					    <c:set var="displayAttachment" value="false" />
				    </c:if>
			    </c:forTokens>
			
			    <c:if test="${displayAttachment}">
			    
			    <c:set var="currentAttachmentCount" value="${currentAttachmentCount+1}" />
				
					<c:if test="${!isSiteMap && showHeader}">
						<div id="CatalogAttachmentAssetsDisplay_div_1">
						<div class="info_table info_table_width">
							<div class="row">
								<div class="label1 strong"><fmt:message key="ATTACHMENT" bundle="${storeText}" /></div>
								<div class="info_content1 strong"><fmt:message key="DESCRIPTION" bundle="${storeText}" /></div>
								<div class="label2 strong"><fmt:message key="USAGE" bundle="${storeText}" /></div>
								<div class="clear_float"></div>
							</div>
							<c:set var="showHeader" value="false"/>
					</c:if>		
					    
				    <c:set var="mimeType" value="${AttachmentAssetDataBean.mimeType}" />
				    <c:set var="mimePart" value="" />
				    <c:forTokens items="${mimeType}" delims="/" var="mimePartFromType" end="0">
					    <c:set var="mimePart" value="${mimePartFromType}" />
				    </c:forTokens>
	  		
				    <c:choose>
				
					    <c:when test="${(mimePart eq 'image') || (mimePart eq 'images')}">
							<c:choose>
							   	<c:when test="${isSiteMap}">
							   		  <p>
							   	</c:when>
							   	<c:otherwise>
							   		<div class="row">
							   	</c:otherwise>
							</c:choose>
							    <c:choose>
								    <c:when test="${!empty URL}">
											<c:if test="${!isSiteMap}">
										    <div class="label1">
											</c:if> 
										    <a href="<c:out value='${URL}'/>" id="WC_CatalogAttachmentAssetsDisplay_links_1_<c:out value='${status.count}'/>">
											    <img
												    src='<c:out value="${AttachmentAssetDataBean.objectPath}${AttachmentAssetDataBean.attachmentAssetPath}"/>'
												    <c:choose>
													   	<c:when test="${isSiteMap}">
													   		alt='<c:out value="${catObject.description.name}"/>'
													   	</c:when>
													   	<c:otherwise>
													   		alt='<c:out value="${attachmentDB.longDescription}"/>'
													   	</c:otherwise>
														</c:choose>
												    <c:if test="${not empty attachHeight}">
													    height="<c:out value='${attachHeight}' />"
												    </c:if>
												    <c:if test="${not empty attachWidth}">
													    width="<c:out value='${attachWidth}' />"
												    </c:if>
												    <c:if test="${not empty attachControls}">
													    border="<c:out value='${attachControls}' />" 
												    </c:if>
												    <c:if test="${not empty attachBorder}">
													    controls="<c:out value='${attachBorder}' />"
												    </c:if> 
											    />
										    </a>
											<c:if test="${!isSiteMap}">
											</div>
											<div class="info_content1">
											<c:if test="${!empty(attachmentDB.shortDescription)}">
												&nbsp;<c:out value="${attachmentDB.shortDescription}"/>
												<br/>
											</c:if>																			
											<c:if test="${!empty(attachmentDB.longDescription)}">
												&nbsp;<c:out value="${attachmentDB.longDescription}"/>
											</c:if>	
											</div>
											<div class="label2">
											<c:if test="${!empty(attachmentDB.usageDataBean.name)}">
												<c:out value="${attachmentDB.usageDataBean.name}"/>
											</c:if>	
											</div>
											<div class="clear_float"> </div>
											</c:if> 
								    </c:when>
								    <c:otherwise>			
											<c:if test="${!isSiteMap}">
											<div class="label1">
											</c:if>
										    <img
											    src='<c:out value="${AttachmentAssetDataBean.objectPath}${AttachmentAssetDataBean.attachmentAssetPath}"/>'
											    <c:choose>
														<c:when test="${isSiteMap}">
													   	alt='<c:out value="${catObject.description.name}"/>'
													  </c:when>
													  <c:otherwise>
													   	alt='<c:out value="${attachmentDB.longDescription}"/>'
													  </c:otherwise>
													</c:choose>
											    <c:if test="${not empty attachHeight}">
												    height="<c:out value='${attachHeight}' />"
											    </c:if>
											    <c:if test="${not empty attachWidth}">
												    width="<c:out value='${attachWidth}' />"
											    </c:if>
											    <c:if test="${not empty attachControls}">
												    border="<c:out value='${attachControls}' />" 
											    </c:if>
											    <c:if test="${not empty attachBorder}">
												    controls="<c:out value='${attachBorder}' />"
											    </c:if>
										    /> 
											<c:if test="${!isSiteMap}">
											</div>
											<div class="info_content1">
											<c:if test="${!empty(attachmentDB.shortDescription)}">
												&nbsp;<c:out value="${attachmentDB.shortDescription}"/>
												<br/>
											</c:if>										
											<c:if test="${!empty(attachmentDB.longDescription)}">
												&nbsp;<c:out value="${attachmentDB.longDescription}"/>
											</c:if>	
											</div>
											<div class="label2">
											<c:if test="${!empty(attachmentDB.usageDataBean.name)}">
												<c:out value="${attachmentDB.usageDataBean.name}"/>
											</c:if>	
											</div>
											<div class="clear_float"> </div>
											</c:if>
								    </c:otherwise>
							    </c:choose>
					    	<c:choose>
							   	<c:when test="${isSiteMap}">
							   		</p>
							   	</c:when>
							   	<c:otherwise>
							   		</div>
							   	</c:otherwise>
							</c:choose>
					    </c:when>
			
	    			    <c:when test="${(mimePart eq 'application') || (mimePart eq 'applications') || ( mimePart eq 'text') 							
												||(mimePart eq 'textyv' ) || (mimePart eq 'video') || (mimePart eq 'audio')	
												|| (mimePart eq 'model')}"> 
						   
						   
						    <c:choose>
							   	<c:when test="${isSiteMap}">
							   		   <p class="left">
							   	</c:when>
							   	<c:otherwise>
							   		<div class="row">
							   	</c:otherwise>
							</c:choose>
						   
				    			<c:choose>
									<c:when test="${(mimeType eq 'application/x-shockwave-flash')}" >
									<c:if test="${!isSiteMap}">
									<div class="label1">
									</c:if>
										<object data="${AttachmentAssetDataBean.objectPath}${AttachmentAssetDataBean.attachmentAssetPath}"
											<c:choose>
												<c:when test="${not empty attachHeight}">
													height="<c:out value='${attachHeight}' />"
												</c:when>
												<c:otherwise>
													height="60"
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${not empty attachWidth}">
													width="<c:out value='${attachWidth}' />"
												</c:when>
												<c:otherwise>
													width="60"
												</c:otherwise>
											</c:choose>
											type="application/x-shockwave-flash">
												<param name="movie" value="${AttachmentAssetDataBean.objectPath}${AttachmentAssetDataBean.attachmentAssetPath}" />
												<param name="quality" value="high"/>
												<param name="bgcolor" value="#FFFFFF"/>
												<param name="wmode" value="transparent"/>
												<param name="pluginurl" value="http://www.macromedia.com/go/getflashplayer"/>
										</object>
										<c:if test="${!isSiteMap}">
										</div>
										<div class="info_content1">
										<c:if test="${!empty(attachmentDB.shortDescription)}">
											&nbsp;<c:out value="${attachmentDB.shortDescription}"/>
											<br/>
										</c:if>									
										<c:if test="${!empty(attachmentDB.longDescription)}">
											&nbsp;<c:out value="${attachmentDB.longDescription}"/>
										</c:if>
										</div>
										<div class="label2">
										<c:if test="${!empty(attachmentDB.usageDataBean.name)}">
											<c:out value="${attachmentDB.usageDataBean.name}"/>
										</c:if>	
										</div>
										<div class="clear_float"> </div>
										</c:if>
									</c:when>
									<c:otherwise>
										<c:if test="${!isSiteMap}">
										<div class="label1">
										</c:if>
										<c:set var="MimeStatus" value="1" />
										<a href="<c:out value='${AttachmentAssetDataBean.objectPath}${AttachmentAssetDataBean.attachmentAssetPath}'/>"target="_blank" id="WC_CatalogAttachmentAssetsDisplay_links_2_<c:out value='${status.count}'/>">
											<img src='<c:out value="${jspStoreImgDir}${attachmentDB.usageDataBean.image}"/>'
												alt='<c:out value="${attachmentDB.longDescription}"/>'
												align="left" /> 
										</a>
										<c:if test="${!isSiteMap}">
											&nbsp;
											<a href="<c:out value='${AttachmentAssetDataBean.objectPath}${AttachmentAssetDataBean.attachmentAssetPath}'/>" target="_blank" id="WC_CatalogAttachmentAssetsDisplay_links_download_<c:out value='${status.count}'/>" class="catalog_link">
												<fmt:message key="DOWNLOAD" bundle="${storeText}"/> 
											</a>
										</div>
										<div class="info_content1">
										<c:if test="${!empty(attachmentDB.shortDescription)}">
											&nbsp;<c:out value="${attachmentDB.shortDescription}"/>
											<br/>
										</c:if>										
										<c:if test="${!empty(attachmentDB.longDescription)}">
											&nbsp;<c:out value="${attachmentDB.longDescription}"/>
										</c:if>		
										</div>
										<div class="label2">
										<c:if test="${!empty(attachmentDB.usageDataBean.name)}">
											<c:out value="${attachmentDB.usageDataBean.name}"/>
										</c:if>	
										</div>
										<div class="clear_float"> </div>
										</c:if>
									</c:otherwise>
								</c:choose>
							<c:choose>
							   	<c:when test="${isSiteMap}">
							   		   </p>
							   	</c:when>
							   	<c:otherwise>
							   		</div>
							   	</c:otherwise>
							</c:choose>
						</c:when>	
					
					    <c:when test="${empty mimePart}">
						    <c:choose>
							   	<c:when test="${isSiteMap}">
							   		   <p class="left">
							   	</c:when>
							   	<c:otherwise>
							   		<div class="row">
							   	</c:otherwise>
							</c:choose>
								<c:if test="${!isSiteMap}">
								<div class="label1">
								</c:if>
								<c:set var="http" value=""/>
								<c:if test='${ fn:indexOf(AttachmentAssetDataBean.attachmentAssetPath,"://") == -1 }'>
									<c:set var="http" value="http://"/>
								</c:if>
							    <a href="<c:out value='${http}${AttachmentAssetDataBean.attachmentAssetPath}'/>" target="_new" id="WC_CatalogAttachmentAssetsDisplay_links_3_<c:out value='${status.count}'/>"> 
								    <c:out value="${AttachmentAssetDataBean.attachmentAssetPath}"/>
							    </a>
								<c:if test="${!isSiteMap}">
								</div>
								<div class="info_content1">
							    <c:if test="${!empty(attachmentDB.shortDescription)}">
								    &nbsp;<c:out value="${attachmentDB.shortDescription}"/>
								    <br/>
							    </c:if>							
							    <c:if test="${!empty(attachmentDB.longDescription)}">
								    &nbsp;<c:out value="${attachmentDB.longDescription}"/>
							    </c:if>
								</div>
								<div class="label2">
									<c:if test="${!empty(attachmentDB.usageDataBean.name)}">
										<c:out value="${attachmentDB.usageDataBean.name}"/>
									</c:if>	
								</div>
								<div class="clear_float"> </div>
								</c:if>
						    <c:choose>
							   	<c:when test="${isSiteMap}">
							   		   </p>
							   	</c:when>
							   	<c:otherwise>
							   		</div>
							   	</c:otherwise>
							</c:choose>
					    </c:when>
				
					    <c:when test="${(mimePart eq 'uri')}">
						    
						    <c:choose>
							   	<c:when test="${isSiteMap}">
							   		   <p class="left">
							   	</c:when>
							   	<c:otherwise>
							   		<div class="row">
							   	</c:otherwise>
							</c:choose>
								<c:if test="${!isSiteMap}">
								<div class="label1">
								</c:if>
							    <fmt:bundle basename="web.ReusableObjects.AttachmentDisplay">
								    <fmt:message key="MoreInfo" />
							    </fmt:bundle> 
							    <a href="<c:out value='${AttachmentAssetDataBean.objectPath}${AttachmentAssetDataBean.attachmentAssetPath}' />" target="_blank" id="WC_CatalogAttachmentAssetsDisplay_links_4_<c:out value='${status.count}'/>"> 
								    <c:out value="${AttachmentAssetDataBean.name}" />
							    </a> 
								<c:if test="${!isSiteMap}">
								</div>
								<div class="info_content1">
							    <c:if test="${!empty(attachmentDB.shortDescription)}">
								    &nbsp;<c:out value="${attachmentDB.shortDescription}"/>
								    <br/>
							    </c:if>							
							    <c:if test="${!empty(attachmentDB.longDescription)}">
								    &nbsp;<c:out value="${attachmentDB.longDescription}"/>
							    </c:if>
								</div>
								<div class="label2">
									<c:if test="${!empty(attachmentDB.usageDataBean.name)}">
										<c:out value="${attachmentDB.usageDataBean.name}"/>
									</c:if>	
								</div>
								<div class="clear_float"> </div>
								</c:if>
							    <c:set var="MimeStatus" value="2" />
						    <c:choose>
							   	<c:when test="${isSiteMap}">
							   		   </p>
							   	</c:when>
							   	<c:otherwise>
							   		</div>
							   	</c:otherwise>
							</c:choose>
					    </c:when>
				
					    <c:otherwise>
						    <c:choose>
							   	<c:when test="${isSiteMap}">
							   		   <p class="left">
							   	</c:when>
							   	<c:otherwise>
							   		<div class="row">
							   	</c:otherwise>
							</c:choose>
								<c:if test="${!isSiteMap}">
								<div class="label1">
								</c:if>
							    <fmt:bundle basename="web.ReusableObjects.AttachmentDisplay">
								    <fmt:message key="UnknownAttachmentType" />
							    </fmt:bundle>
								<c:if test="${!isSiteMap}">
								</div>
								<div class="info_content1">
							    <c:if test="${!empty(attachmentDB.shortDescription)}">
								    &nbsp;<c:out value="${attachmentDB.shortDescription}"/>
								    <br/>
							    </c:if>							
							    <c:if test="${!empty(attachmentDB.longDescription)}">
								    &nbsp;<c:out value="${attachmentDB.longDescription}"/>
							    </c:if>
								</div>
								<div class="label2">
									<c:if test="${!empty(attachmentDB.usageDataBean.name)}">
										<c:out value="${attachmentDB.usageDataBean.name}"/>
									</c:if>	
								</div>
								<div class="clear_float"> </div>
								</c:if>
							    <c:set var="MimeStatus" value="3" />
						    <c:choose>
							   	<c:when test="${isSiteMap}">
							   		   </p>
							   	</c:when>
							   	<c:otherwise>
							   		</div>
							   	</c:otherwise>
							</c:choose>
					    </c:otherwise>
				    </c:choose>
			    </c:if>
	        </c:forEach>
		</c:forEach>
		
		<c:if test="${!isSiteMap}">
			<c:if test="${currentAttachmentCount != 0}">
			</div>
			</div>
			</c:if>
		</c:if>
	</c:when>

	<%-- Display attachments for catalog entry using a separate jsp, which uses the new store front service instead of data bean --%>
	<c:when test="${(!empty param.catType) && (param.catType != 'category') && (!empty param.productId)}">
		<%@ include file="CatalogEntryAttachmentAssetsDisplay.jspf"%>
	</c:when>
</c:choose>	


	

<!-- END CatalogAttachmentAssetsDisplay.jsp -->
