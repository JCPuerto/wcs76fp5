<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2008, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@include file="BrowserCacheControl.jsp" %>

<%@page import="java.net.URL"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="com.ibm.icu.util.TimeZone"%>
<%@page import="com.ibm.commerce.command.CommandContext" %>
<%@page import="com.ibm.commerce.tools.segmentation.SegmentDataBean"%>
<%@page import="com.ibm.commerce.foundation.internal.server.services.search.metadata.solr.SolrSearchServiceConstants"%>
<%@page import="com.ibm.commerce.context.preview.PreviewContext"%>
<%@page import="com.ibm.commerce.foundation.server.services.businesscontext.ContextService"%>
<%@page import="com.ibm.commerce.foundation.server.services.businesscontext.ContextServiceFactory"%>
<%@page import="com.ibm.commerce.catalog.facade.server.helpers.SearchUpdateHelper"%>
<%@page import="com.ibm.commerce.catalog.facade.server.helpers.CatalogComponentHelper"%>
<%@page import="com.ibm.commerce.foundation.internal.server.services.search.config.solr.SolrSearchConfigurationRegistry"%>
<%@page import="com.ibm.commerce.foundation.internal.server.services.dataaccess.workspace.util.PhysicalDataHelperProvider"%>
<%@page import="com.ibm.commerce.foundation.internal.server.services.dataaccess.logging.SearchServiceSystemMessageKeys"%>
<%@page import="com.ibm.commerce.foundation.internal.server.services.dataaccess.workspace.util.PhysicalDataHelperFactory"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<fmt:setLocale value="${param.locale}" />
<fmt:setBundle basename="com.ibm.commerce.stores.preview.properties.StorePreviewer" var="resources" />
<fmt:setBundle basename="com.ibm.commerce.catalog.logging.properties.WcCatalogMessages" var="catalogMsgs" />

<%
	com.ibm.icu.text.SimpleDateFormat dateFormat = new com.ibm.icu.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	String timeZoneId = request.getParameter("timeZoneId");
	String previewStartTime = request.getParameter("start");
	String timeZoneDisplayName = "";
	String clientDateFormat = request.getParameter("dateFormat");
	String clientTimeFormat = request.getParameter("timeFormat");
	
	String localeStr = request.getParameter("locale");
	Locale locale = null;
	if (localeStr == null) {
		locale = Locale.getDefault();
	}
	else {
		String[] localeInfo = localeStr.split("_");
		if (localeInfo.length == 1) {
			locale = new Locale(localeInfo[0]);
		}
		else{
			locale = new Locale(localeInfo[0], localeInfo[1]);
		}
	}
	
	if (previewStartTime == null) {
	 	long currentMillis = System.currentTimeMillis();
		java.sql.Timestamp previewTime = new java.sql.Timestamp(currentMillis);
		if (timeZoneId !=null && !timeZoneId.equals("")) {
			TimeZone preferredTz = TimeZone.getTimeZone(timeZoneId);
			TimeZone serverTz = TimeZone.getTimeZone(TimeZone.getDefault().getID());
			int offset = preferredTz.getOffset(previewTime.getTime()) - serverTz.getOffset(previewTime.getTime());
			previewTime.setTime(previewTime.getTime() + offset);
		}
		previewStartTime = dateFormat.format(new java.util.Date(previewTime.getTime()));
	}
	
	if (timeZoneId !=null && !timeZoneId.equals("")) {
		timeZoneDisplayName = TimeZone.getTimeZone(timeZoneId).getDisplayName(locale);
	}
	
	String includedMemberGroupIds = request.getParameter("includedMemberGroupIds");
	/* determine member group names */
	String mbrGroupIncludedNames = "";
	CommandContext aCommandContext = (CommandContext)request.getAttribute("CommandContext");
	
	if (includedMemberGroupIds != null && !includedMemberGroupIds.equals("")) {
		int mbGrpIncludedCounter = 0;
		try {
			java.util.StringTokenizer st = new java.util.StringTokenizer(includedMemberGroupIds, ",");
			while (st.hasMoreElements()) {	

					SegmentDataBean segmentDataBean = new SegmentDataBean();
					segmentDataBean.setCommandContext(aCommandContext);
					segmentDataBean.setId(st.nextToken());
					segmentDataBean.populate();

					if (mbGrpIncludedCounter > 0) {
							mbrGroupIncludedNames += ", ";
					}
					String mbrGrpName = segmentDataBean.getSegmentDisplayName();
					if (mbrGrpName == null || mbrGrpName.equals("")) {
							mbrGrpName = segmentDataBean.getSegmentName();
					}
					mbrGroupIncludedNames += mbrGrpName;
					mbGrpIncludedCounter++;

			} // end while
		}catch(Exception e) {}
	}

	SolrSearchConfigurationRegistry searchRegistry =
			SolrSearchConfigurationRegistry.getInstance();
	Integer storeId = aCommandContext.getStoreId();
	if(searchRegistry.isSearchEnabled(storeId)) {
		ResourceBundle resourceBundle = ResourceBundle.getBundle(
				SolrSearchServiceConstants.FOUNDATION_RESOURCE_BUNDLE,
				aCommandContext.getLocale());
		Long masterCatalogId = SolrSearchConfigurationRegistry
				.getInstance().getMasterCatalog(storeId);
		String message = null;
		if (masterCatalogId != null) {
			boolean isIndexing = false;
			// Check workspace schema if working with non-approved content;
			// otherwise, this request will be performed against the base
			// schema
			Map workspaceData = PhysicalDataHelperFactory
					.getPhysicalDataHelperProvider().getWorkspaceData();
			if (workspaceData != null) {
				String readSchema = (String) workspaceData
						.get(PhysicalDataHelperProvider.WORKSPACE_READ_SCHEMA);
				if (readSchema != null && readSchema.length() > 0) {
					if (SearchUpdateHelper.isPerformingSearchIndexing(
							SolrSearchServiceConstants.INDEX_NAME_CATALOG_ENTRY,
							masterCatalogId.toString(), readSchema)) {
						isIndexing = true;
					}
					if (SearchUpdateHelper.isPerformingSearchIndexing(
							SolrSearchServiceConstants.INDEX_NAME_CATALOG_GROUP,
							masterCatalogId.toString(), readSchema)) {
						isIndexing = true;
					}
				}
			}
			if (SearchUpdateHelper.isPerformingSearchIndexing(
					SolrSearchServiceConstants.INDEX_NAME_CATALOG_ENTRY,
					masterCatalogId.toString())) {
				isIndexing = true;
			}
			if (SearchUpdateHelper.isPerformingSearchIndexing(
					SolrSearchServiceConstants.INDEX_NAME_CATALOG_GROUP,
					masterCatalogId.toString())) {
				isIndexing = true;
			}
			if (isIndexing) {
				String indexingWarningThreshold = SolrSearchConfigurationRegistry
						.getInstance()
						.getExtendedConfigurationPropertyValue(
								SolrSearchServiceConstants.PROPERTY_NAME_INDEXING_WARNING_THRESHOLD);
				int count = SearchUpdateHelper.countAnyIndexing(
						SolrSearchServiceConstants.INDEX_NAME_CATALOG_ENTRY,
						masterCatalogId.toString());
				int threshold = 1000;
				if (indexingWarningThreshold != null
						&& indexingWarningThreshold.length() > 0) {
					threshold = Integer.valueOf(indexingWarningThreshold);
				}
				if (threshold < count) {
					message = "CWXFS3302I: A large amount of pending changes have been detected in your workspace. Indexing might take an above average amount of time to complete.";
					if (resourceBundle != null) {
						message = resourceBundle
								.getString(SearchServiceSystemMessageKeys.INDEXING_STATUS_LONG_WAIT);
					}
				} else {
					message = "CWXFS3301I: Pending changes in your workspace are being indexed. Updates should be available soon.";
					if (resourceBundle != null) {
						message = resourceBundle
								.getString(SearchServiceSystemMessageKeys.INDEXING_STATUS_PENDING);
					}
				}
			} else {
				message = "The search index is up to date.";
				if (resourceBundle != null) {
					message = resourceBundle
							.getString(SearchServiceSystemMessageKeys.INDEXING_STATUS_IDLE);
				}
			}
		}
		if (message != null && message.startsWith("CWXFS330")) {
			message = message.substring(12);
		}
		pageContext.setAttribute("indexMsg", message);
	}

%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="${pageContext.request.locale.language}" lang="${pageContext.request.locale.language}">
	<head>
		<script type="text/javascript">
			var dateTimeFormat = "yyyy/MM/dd HH:mm:ss";
			var UI_TIME_FORMAT_SEPARATOR = ":";
			var YEAR_DEFAULT_FOR_YY = "20";
			var clientTime = new Date();

			function format(date, fmt) {
				if (date && fmt) {
					var resultstr = fmt;
					if(resultstr.indexOf('yyyy') != -1){
						resultstr = replace(resultstr, "yyyy", padleft(date.getFullYear(), "0", 4));
					}else{
						resultstr = replace(resultstr, "yy", padleft(date.getFullYear().toString().slice(2), "0", 2));
					}
					if(resultstr.indexOf('MM') != -1){
						resultstr = replace(resultstr, "MM", padleft((date.getMonth()+1),"0",2));
					}else{
						resultstr = replace(resultstr, "M", date.getMonth()+1);
					}
					if(resultstr.indexOf('dd') != -1){
						resultstr = replace(resultstr, "dd", padleft(date.getDate(),"0",2));
					}else{
						resultstr = replace(resultstr, "d", date.getDate());
					}
					
					resultstr = replace(resultstr, "HH", padleft(date.getHours(),"0",2));
					resultstr = replace(resultstr, "mm", padleft(date.getMinutes(),"0",2));
					resultstr = replace(resultstr, "ss", padleft(date.getSeconds(),"0",2));
					resultstr = replace(resultstr, "SSS", padleft(date.getMilliseconds(),"0",3));
					resultstr = replace(resultstr, "AM", padleft(date.getMilliseconds(),"0",3));
					
					
					return resultstr;
				}
				else {
					return "";
				}
			}
			
			function parse (str, fmt) {
				if (str) {
					//if (str.indexOf(" ") >= 0) return null;
					
					str = trim(str);
					var currentDate = new Date();
					
					var year = currentDate.getFullYear();
					var month = currentDate.getMonth();
					var day = currentDate.getDate();
					var hours = 0;
					var minutes = 0;
					var seconds = 0;
					var milliseconds = 0;
					var t;
					if(fmt.indexOf("dd") < 0){
						t = fmt.indexOf("d");
						if (t >= 0) {
							fmt = insertStringAt(fmt,'d',t);
							if(!isInteger(str.substr(t+1,1))){
								str = insertStringAt(str,'0',t);
							}
						}
					}
					if(fmt.indexOf("MM") < 0){
						t = fmt.indexOf("M");
						if (t >= 0) {
							fmt = insertStringAt(fmt,'M',t);
							if(!isInteger(str.substr(t+1,1))){
								str = insertStringAt(str,'0',t);
							}
						}
					}
					if(fmt.indexOf("yyyy") < 0){
						t = fmt.indexOf("yy");
						if (t >= 0) {
							fmt = insertStringAt(fmt,'yy',t);
							str = insertStringAt(str,YEAR_DEFAULT_FOR_YY,t); //always assume year 2000 plus
						}
					}
					
					
					var i;
					i = fmt.indexOf("yyyy");
					if (i >= 0) {
						year = Number(str.substr(i,4));
					}
					
					i = fmt.indexOf("MM");
					if (i >= 0) {
						month = Number(str.substr(i,2)) - 1;
					}
					
					i = fmt.indexOf("dd");
					if (i >= 0) {
						day = Number(str.substr(i,2));
					}
					
					i = fmt.indexOf("HH");
					if (i >= 0 && str.length > i) {
						hours = Number(str.substr(i,2));
					}
					
					i = fmt.indexOf("mm");
					if (i >= 0 && str.length > i) {
						minutes = Number(str.substr(i,2));
					}
					
					i = fmt.indexOf("ss");
					if (i >= 0 && str.length > i) {
						seconds = Number(str.substr(i,2));
					}
					
					i = fmt.indexOf("SSS");
					if (i >= 0 && str.length > i) {
						milliseconds = Number(str.substr(i,3));
					}
					
					
					// set year under 100 with Date's constructor will be added with 1900.
					// use setFullYear to avoid, also use set methods for others for consistency.					
					var resultdate = new Date();	
					resultdate.setDate(1);	
					resultdate.setFullYear(year);					
					resultdate.setMonth(month);					
					resultdate.setDate(day);					
					resultdate.setHours(hours);					
					resultdate.setMinutes(minutes);					
					resultdate.setSeconds(seconds);					
					resultdate.setMilliseconds(milliseconds);				
					// to ensure the original str is same as the result str
					if (resultdate.getTime()) {
						if (resultdate.getFullYear() != year || resultdate.getMonth() !=  month || resultdate.getDate() != day) {
							return null;
						}
						return resultdate;
					}
					else {
						return null;
					}
				}
				else {
					return null;
				}
			}
			
			function isInteger (s) {
				// s is an integer string if it is a number string that does not contain decimal point
				return s && s.indexOf('.') < 0 && isNumber(s);
			}
			
			function trim (s) {
				if (typeof(s) == "undefined" || s == null) {
					return s;
				}
				s = s.toString();
				while (s.length > 0 && s.substring(0, 1) == ' ') {
					s = s.substring(1, s.length);
				}

				while (s.length > 0 && s.substring(s.length - 1, s.length) == ' ') {
					s = s.substring(0, s.length - 1);
				}

				return s;
			}
			
			function insertStringAt (str, insertStr, index) {
				var str1 = str.slice(0,index);
				var str2 = str.slice(index,str.length);
				return str1 + insertStr + str2;
			}

			function getFormattedTime (date, sec, fmt) {
				if(date){
					if (!fmt) {
						fmt = "12HR";
					}
					if(fmt=="12HR"){
						return get12HourFormattedTime(date,sec);
					}else if(fmt=="24HR"){
						return get24HourFormattedTime(date,sec);
					}
				}
				return null;
			}

			function get24HourFormattedTime (date, sec) {
				if(sec){
					return [date.getHours(),
							UI_TIME_FORMAT_SEPARATOR,
							getFormattedMinutes(date.getMinutes()),
							UI_TIME_FORMAT_SEPARATOR,
							getFormattedMinutes(date.getSeconds())
						   ].join("");
				}else{
					return [date.getHours(),
							UI_TIME_FORMAT_SEPARATOR,
							getFormattedMinutes(date.getMinutes())
						   ].join("");
				}
			}

			function get12HourFormattedTime (date, sec) {
				if(sec){
					return [get12HourFormattedHours(date.getHours()),
							UI_TIME_FORMAT_SEPARATOR,
							getFormattedMinutes(date.getMinutes()),
							UI_TIME_FORMAT_SEPARATOR,
							getFormattedMinutes(date.getSeconds()),
							" ",
							get12HourFormattedAppendix(date.getHours())
						   ].join("");
				}else{
					return [get12HourFormattedHours(date.getHours()),
							UI_TIME_FORMAT_SEPARATOR,
							getFormattedMinutes(date.getMinutes()),
							" ",
							get12HourFormattedAppendix(date.getHours())
						   ].join("");
				}
			}
			
			function get12HourFormattedHours(hours) {
				var fHours = hours % 12;
				if(fHours == 0){
					fHours = 12;
				}
				var result = fHours < 10? [0, fHours].join("") : String(fHours);
				return result;
			}

			function getFormattedMinutes (minutes) {
				return minutes < 10 ? [0, minutes].join("") : String(minutes);
			}

			function get12HourFormattedAppendix (hours) {
				return hours > 11 ? "PM" : "AM";
			}

			function replace (s, r, n) {
				return s.split(r).join(n);
			}

			function padleft (s, c, stringlength) {
				var n = stringlength - s.toString().length;
				var padstr = "";
				for (var i = 0; i < n; i++) {
					padstr += c;
				}
				return padstr + s;
			}


			function setInnerText(obj, text){
				if(obj.innerText != undefined){
					obj.innerText = text;
				}else if(obj.textContent != undefined){
					obj.textContent = text;
				}
			}
			
			function displayTimeInfo() {
				var start = "<%= previewStartTime %>";
				var startTime = parse(start, dateTimeFormat);
				var clientDateFormat = "<%= clientDateFormat %>";
				var clientTimeFormat = "<%= clientTimeFormat %>";
				var formattedDate = format(startTime, clientDateFormat);
				var formattedTime = getFormattedTime(startTime, true, clientTimeFormat);
				setInnerText(document.getElementById("previewStartTime"), formattedDate + " " + formattedTime + " <%= timeZoneDisplayName %>");
			<c:if test="${param.status == false}">
				funClock();
			</c:if>
			}
			
			function funClock() {
				var start = "<%= previewStartTime %>";
				var startTime = parse(start, dateTimeFormat);
				var elapsedTime = new Date();
				var clientDateFormat = "<%= clientDateFormat %>";
				var clientTimeFormat = "<%= clientTimeFormat %>";
				elapsedTime.setTime(startTime.getTime() + elapsedTime.getTime() - clientTime.getTime());
				var formattedDate = format(elapsedTime, clientDateFormat);
				var formattedTime = getFormattedTime(elapsedTime, true, clientTimeFormat);
				setInnerText(document.getElementById("previewTime"), formattedDate + " " + formattedTime + " <%= timeZoneDisplayName %>");
				setTimeout("funClock()", 1000)
			} 

			

			/*
				START - KEY PRESS FUNCTION
			*/
			var clickedOnce = false;
			var spotsShown = false;

			// outlines all the e-spots and content spots on the page
			function outlineSpots() {
				if (parent.frames[1] != null) {
					with (parent.frames[1]) {
						var all = parent.frames[1].document.getElementsByTagName('*');
						  for (var i = 0; i < all.length; i++) {
						    if (all[i].className == 'caption') {all[i].style.display='block';}
						    if (all[i].className == 'genericESpot') {all[i].style.border='2px dashed red';}
						    if (all[i].className == 'genericCSpot') {all[i].style.border='2px dashed blue';}
						    if (all[i].className == 'searchResultSpot') {all[i].style.border='2px dashed limegreen';}
						    if (all[i].className == 'ESpotInfo') {all[i].style.display='block';}
						  }
					}
				}
			}

			function hideSpots() {
				if (parent.frames[1] != null) {
					if (parent.frames[1] != null) {
						var all = parent.frames[1].document.getElementsByTagName('*');
						for (var i = 0; i < all.length; i++) {
							if (all[i].className == 'caption') {all[i].style.display='none';}
							if (all[i].className == 'genericESpot') {all[i].style.border='0px solid white';}
							if (all[i].className == 'genericCSpot') {all[i].style.border='0px solid white';}
							if (all[i].className == 'searchResultSpot') {all[i].style.border='0px solid white';}
							if (all[i].className == 'ESpotInfo') {all[i].style.display='none';}
						}
					}
				}
			}


			function onUnLoadClearButton() {
				spotsShown = false;
				clickedOnce = false;
				setInnerText(document.getElementById('showSpots'), "<fmt:message key="storePreviewShowESpotsBtnText" bundle="${resources}" />");
				return true;
			}

			function showESpots() {
				if (clickedOnce == false) {
					// add an onunload function to the body frame to make sure the 'show marketing spots' button
					// is in sync with the page.
					clickedOnce = true;
					if (parent.frames[1] != null) {
						var obj2=parent.frames[1].document.getElementsByTagName('body')[0];
						obj2.onunload=onUnLoadClearButton;
					}
				}

				if (spotsShown == false) {
					setInnerText(document.getElementById('showSpots'), "<fmt:message key="storePreviewHideESpotsBtnText" bundle="${resources}" />");
					spotsShown = true;
					outlineSpots();
				} else {
					spotsShown = false;
					setInnerText(document.getElementById('showSpots'), "<fmt:message key="storePreviewShowESpotsBtnText" bundle="${resources}" />");
					hideSpots();
				}
			}
			/*
				END - KEY PRESS FUNCTION
			*/

			function hideDetails() {
				document.getElementById('detailsSection').style.display='none';
				parent.document.getElementById('previewFrames').rows = "37,*";
				setInnerText(document.getElementById('showHideButton'), "<fmt:message key="storePreviewShowDetailsBtnText" bundle="${resources}" />");
				document.getElementById('showHideLink').href="javascript:showDetails()";
				document.getElementById('showRefreshLink').style.visibility="hidden";
			}

			function showDetails() {
				document.getElementById('detailsSection').style.display='block';
				parent.document.getElementById('previewFrames').rows = "137,*";
				setInnerText(document.getElementById('showHideButton'), "<fmt:message key="storePreviewHideDetailsBtnText" bundle="${resources}" />");
				document.getElementById('showHideLink').href="javascript:hideDetails()";
				document.getElementById('showRefreshLink').style.visibility="visible";
			}
		</script>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><fmt:message key="storePreviewHeaderFrameTitle" bundle="${resources}" /></title>
		<style type="text/css">
			body {
				padding:0px;
				margin:0px;
				line-height:16px;
			}
			a {
				text-decoration:none;
			}
			#store_preview {
				width:100%;
				font-family:Verdana, Arial, Helvetica, sans-serif;
				font-size:11px;
				color:#2c2c2c;
			}
			#store_preview .bold{
				font-weight:bold;
				color:#1065aa;
			}
			#store_preview .header {
				background-image: url('${staticAssetContextRoot}/images/preview/header_background_tile.png');
				background-repeat:repeat-x;
				height:28px;
				width:100%;
				padding-top:3px;
			}
			#store_preview .title {
				font-size:14px;
				float:left;
				padding:4px 11px 0px 10px;
			}
			.details {
				padding:1px 7px 5px 5px;
			}
			.details_container {
				background-color:#dfe8fb;
				border:solid 1px #bcd0fb;
				padding:5px;
			}
			.details_container .content {
				padding-left:3px;
			}
			a.light_button {
				color: #27629C;
				cursor: pointer;
				display: -moz-inline-box;
				display: inline-block;
				height: 17px;
				padding: 2px;
			}
			a.light_button div.button_text {
				background: transparent url('${staticAssetContextRoot}/images/preview/b_main_bg.png') top left repeat-x;
				float: left;
				height: 17px;
				padding: 1px 2px 2px 9px;
			}
			
			a.light_button div.button_right {
				background: transparent url('${staticAssetContextRoot}/images/preview/b_right.png') no-repeat;
				float: left;
				height: 20px;
				width: 6px;
			}
		</style>
	</head>

	<body onload="displayTimeInfo()">
		<div id="store_preview">
		     <div class="header"> <span class="title"><fmt:message key="storePreviewHeading" bundle="${resources}" /></span>
		        <a class="light_button" href="javascript:hideDetails();" id="showHideLink"><div id="showHideButton" class="button_text"><fmt:message key="storePreviewHideDetailsBtnText" bundle="${resources}" /></div><div class="button_right"></div></a>
		        <a class="light_button" href="#" onclick="window.location.reload();" id="showRefreshLink"><div id="showRefreshButton" class="button_text"><fmt:message key="storePreviewRefreshDetailsBtnText" bundle="${resources}" /></div><div class="button_right"></div></a>
		     </div>
		     <div class="details" id="detailsSection">
		          <div class="details_container">
		               <div class="content">
		               		<span class="bold"><fmt:message key="storePreviewStartTimeMsg" bundle="${resources}" />&nbsp;&nbsp;:</span> <span id="previewStartTime"></span>
		               		<br/>
		               		<span class="bold"><fmt:message key="storePreviewInvStatusTitle" bundle="${resources}" /></span>
		               		<c:choose>
								<c:when test="${param.invstatus == -1}"><fmt:message key="storePreviewInvStatusDupWthCnst" bundle="${resources}" /></c:when>
								<c:when test="${param.invstatus == 1}"><fmt:message key="storePreviewInvStatusDupWthoutCnst" bundle="${resources}" /></c:when>
								<c:otherwise><fmt:message key="storePreviewInvStatusReal" bundle="${resources}" /></c:otherwise>
							</c:choose>
							<br/>
		               		<c:choose>
								<c:when test="${param.status == true}">
									<span class="bold"><fmt:message key="storePreviewTimeStatusStatic" bundle="${resources}" /></span>
								</c:when>
								<c:otherwise>
		               				<span class="bold"><fmt:message key="storePreviewTimeStatusRolling" bundle="${resources}" />&nbsp;&nbsp;:</span> <span id="previewTime"></span>
								</c:otherwise>
							</c:choose>
		                    <br/>
		                    <c:if test="${!empty param.includedMemberGroupIds}">
		                    	<span class="bold"><fmt:message key="storePreviewCustomerSegments" bundle="${resources}" /></span>&nbsp;<%= mbrGroupIncludedNames %><br/>
				    		</c:if>
				    		<c:if test="${!empty indexMsg}">
					    		<span class="bold">
						    			<c:out value="${indexMsg}"/>
					    		</span>
				    		</c:if>
		               </div>
		               <div class="marketing_btn">
		               		<a class="light_button" href="javascript:showESpots();"><div id="showSpots" class="button_text"><fmt:message key="storePreviewShowESpotsBtnText" bundle="${resources}" /></div><div class="button_right"></div></a>
						</div>
		          </div>
		     </div>
		</div>
	</body>
</html>
