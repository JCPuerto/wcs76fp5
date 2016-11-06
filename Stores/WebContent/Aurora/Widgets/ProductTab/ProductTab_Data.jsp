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
<%-- Pick the productId from WCParam, if empty pick from param --%>
<c:set var="uniqueID" value="${WCParam.productId}"/>
<c:if test="${empty uniqueID}">
	<c:set var="uniqueID" value="${param.productId}"/>
</c:if>
<c:set var="excludeUsageStr" value="NOUSAGE,ANGLEIMAGES_THUMBNAIL,ANGLEIMAGES_FULLIMAGE,ANGLEIMAGES_HDIMAGE,IMAGE_SIZE_55,IMAGE_SIZE_40,IMAGE_SIZE_330,IMAGE_SIZE_1000"/>
<wcf:url var="AttachmentPaginationURL" value="AttachmentPaginationView">
	<wcf:param name="storeId" value="${storeId}"/>
	<wcf:param name="catalogId" value="${catalogId}"/>
	<wcf:param name="langId" value="${langId}"/>
	<wcf:param name="productId" value="${uniqueID}"/>
	<wcf:param name="excludeUsageStr" value="${excludeUsageStr}"/>
</wcf:url>