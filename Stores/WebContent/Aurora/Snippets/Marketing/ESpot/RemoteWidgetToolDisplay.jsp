
<%-- 
  *****
  * This JSP displays the store's remote widget customization tool. You can manipulate the following properties 
  * of a remote widget:
  *  - Layout (side bar and banner)
  *  - Color (background and border)
  *****
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ include file="../../../Common/EnvironmentSetup.jspf" %>
<%@ include file="../../../Common/JSTLEnvironmentSetupExtForRemoteWidgets.jspf"%>
<%@ include file="../../../Common/nocache.jspf" %>


<!DOCTYPE HTML>

<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2010, 2012 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<!-- BEGIN RemoteWidgetToolDisplay.jsp  -->
<html xmlns="http://www.w3.org/1999/xhtml" lang="${shortLocale}" xml:lang="${shortLocale}">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title><fmt:message key="GET_WIDGET_TITLE"/></title>
	<link rel="stylesheet" href="<c:out value="${jspStoreImgDir}${env_vfileStylesheet}"/>" type="text/css"/>
	<script type="text/javascript" src="<c:out value="${dojoFile}"/>" djConfig="${dojoConfigParams}"></script>
	<%@ include file="RemoteWidgetToolIntegration.jspf"%>
	<%@ include file="../../../Common/CommonJSToInclude.jspf"%>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Widgets/Search.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Widgets/MiniShopCartDisplay/MiniShopCartDisplay.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Widgets/Department/Department.js"/>"></script>
	<script type="text/javascript" src="<c:out value="${jsAssetsDir}javascript/Common/ShoppingActions.js"/>"></script>
	
	<script type="text/javascript">       
		dojo.require("wc.widget.WCColorPicker");
		dojo.addOnLoad(function() { parseWidget("colorPicker");} );
		dojo.addOnLoad(onLoad);
	</script>
</head>

<body>

<!-- Page Start -->
<div id="page">
	<%-- This file includes the progressBar mark-up and success/error message display markup --%>
	<%@ include file="../../../Common/CommonJSPFToInclude.jspf"%>
	<!-- Header Widget -->
	<div class="header_wrapper_position" id="headerWidget">
		<%out.flush();%>
		<c:import url = "${env_jspStoreDir}/Widgets/Header/Header.jsp" />
		<%out.flush();%>
	</div>
	<!-- Main Content Start -->
	<div class="content_wrapper_position" role="main">
		<div class="content_wrapper" role="main">
			<div class="content_left_shadow">
				<div class="content_right_shadow">
					<div class="main_content">
						<div class="container_full_width">
							<div id="remote_widget_tool_box">
								<div class="remote_widget_tool" id="WC_RemoteWidgetToolDisplay_div_1">
									<h1><fmt:message key="GET_WIDGET_TOOLING_TITLE"/></h1>
									
									<div class="myaccount_header" id="EventDate"></div>
									<div class="remote_widget_tool_create_body" id="WC_RemoteWidgetToolDisplay_div_2">
										<div id="inner_form_wrapper" >
											<div class="remote_widget_tool_create_description"><fmt:message key="GET_WIDGET_TOOLING_DESCRIPTION"/></div>
											<a class="remote_widget_tool_customize" id="WC_RemoteWidgetToolDisplay_a_1" href="#" onclick="expandArea(); return false;"><fmt:message key="GET_WIDGET_TOOLING_CUSTOMIZE"/></a> 
											<a id="WC_RemoteWidgetToolDisplay_closed" class="remote_widget_tool_customize_button" href="#" style="display:none" onclick="expandArea(); return false;">
												<img src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/close_icon.gif" alt='<fmt:message key="GET_WIDGET_COLLAPSE"/>'/>
											</a>
											<a id="WC_RemoteWidgetToolDisplay_open" class="remote_widget_tool_customize_button" href="#" onclick="expandArea(); return false;">
												<img src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/open_icon.gif" alt='<fmt:message key="GET_WIDGET_EXPAND"/>'/>
											</a>
											<form name="RemoteWidgetForm" id="inner_form" style="display:none">
												<div class="row">
													<div class="column" id="layoutDiv">
														<div class="row"> 
															<fmt:message key="GET_WIDGET_LAYOUT"/>
														</div>
														<div class="row">
															<div class="remote_widget_tool_radio_button_column" id="WC_RemoteWidgetToolDisplay_div_3">
																<input name="layout_button" id ="vertical_design" type="radio" value="vertical_design" checked="checked" onclick="switchLayout(true)"/>
															</div>
															<div class="remote_widget_tool_layout_column" id="WC_RemoteWidgetToolDisplay_div_4">
																<div class="layout_type" id="WC_RemoteWidgetToolDisplay_div_5">
																	<div class ="row">
																		<div class="remote_widget_tool_layout_image" id="WC_RemoteWidgetToolDisplay_div_6">
																			<label for="vertical_design">
																				<img id="vertical_design_picture" src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/vertical_option.png" alt='<fmt:message key="GET_WIDGET_VERTICAL_DESIGN"/>' />
																			</label>
																		</div>
																	</div>
																	<div class = "row">
																		<label for="vertical_design"><fmt:message key="GET_WIDGET_SIDEBAR"/></label>
																	</div>
																</div>
															</div>
															<div class="remote_widget_tool_radio_button_column" id="WC_RemoteWidgetToolDisplay_div_8"> 
																<br />
															</div>
															<div class="remote_widget_tool_radio_button_column" id="WC_RemoteWidgetToolDisplay_div_9">
																<input type="radio" id = "horizontal_design" value="horizontal_design" name="layout_button" onclick="switchLayout(false)" />
															</div>
															<div class="remote_widget_tool_layout_column" id="WC_RemoteWidgetToolDisplay_div_10">
																<div class="layout_type" id="WC_RemoteWidgetToolDisplay_div_11">
																	<div class ="row">
																		<div class="remote_widget_tool_layout_image" id="WC_RemoteWidgetToolDisplay_div_12">
																			<label for="horizontal_design">
																				<img id="horizontal_design_picture" src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/horizontal_option.png" alt='<fmt:message key="GET_WIDGET_HORIZONTAL_DESIGN"/>' />
																			</label>
																		</div>
																	</div>
																	<div class = "row">
																		<label for="horizontal_design"><fmt:message key="GET_WIDGET_BANNER"/></label>
																	</div>
																</div>
															</div>
														</div>
													</div>
													<div class="column">
														<div class = "row">
															<label for="layout_width"><fmt:message key="GET_WIDGET_WIDTH"/></label>
															<div class = "layout_design_textBox_info" id="WC_RemoteWidgetToolDisplay_div_13">
																<input class = "remote_widget_input_box" id="layout_width" size="10" type="text" onblur="setWidth(this); return false;"/>
																<fmt:message key="GET_WIDGET_MIN_MAX">
																	<fmt:param value="<span id='layout_width_min'>0</span>"/>
																	<fmt:param value="<span id='layout_width_max'>0</span>"/>
																</fmt:message> 
															</div>
														</div>
														<div class = "row">
															<label for="layout_height"><fmt:message key="GET_WIDGET_HEIGHT"/></label>
															<div class = "layout_design_textBox_info" id="WC_RemoteWidgetToolDisplay_div_14">
																<input class = "remote_widget_input_box" id="layout_height" type="text" size="10"  onblur="setHeight(this); return false;"/>
																<fmt:message key="GET_WIDGET_MIN_MAX">
																	<fmt:param value="<span id='layout_height_min'>0</span>"/>
																	<fmt:param value="<span id='layout_height_max'>0</span>"/>
																</fmt:message> 
															</div>
														</div>
													</div>
													<div class="column">
														<div class = "row">
															<div class = "row"><fmt:message key="GET_WIDGET_BACKGROUNDCOLOR"/></div>
															<div class = "row">
																<div class = "RemoteWidgetTool_color_choice_column" id="WC_RemoteWidgetToolDisplay_div_15">
																	<div id="backGroundColor" class="colorChose"></div>
																</div>
																<div class = "RemoteWidgetTool_radio_button_column" id="WC_RemoteWidgetToolDisplay_div_16"> 
																	<a href = "#" id="WC_RemoteWidgetToolDisplay_a_2" onclick="launchColorPicker('color_palette', 'colorPickerDiv', 'backGroundColor', 'fillColor');">
																		<img id="color_palette" src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/color_palette.png" alt="<fmt:message key='GET_WIDGET_COLOR_PALLETE'/>" />
																	</a>
																</div>
															</div>
														</div>
														<div class = "row">
															<div class = "row"><fmt:message key="GET_WIDGET_BORDERCOLOR"/></div>
															<div class = "row">
																<div class = "RemoteWidgetTool_color_choice_column" id="WC_RemoteWidgetToolDisplay_div_17">
																	<div id="borderColor" class="colorChose"></div>
																</div>
																<div class = "RemoteWidgetTool_radio_button_column" id="WC_RemoteWidgetToolDisplay_div_18"> 
																	<a href = "#" id="WC_RemoteWidgetToolDisplay_a_3" onclick="launchColorPicker('color_palette2', 'colorPickerDiv', 'borderColor', 'borderColor')">
																		<img id="color_palette2" src="<c:out value="${hostPath}${jspStoreImgDir}" />images/remoteWidget/color_palette.png" alt="<fmt:message key='GET_WIDGET_COLOR_PALLETE'/>" /> 
																	</a>
																</div>
															</div>
														</div>
													</div>
												</div>
											</form>
											<div class="clear_float"></div>
											<div class="widget_style RegistryCreateHeading" id="WC_RemoteWidgetToolDisplay_div_19"></div>
											<div class="remote_widget_tool_preview_description"><fmt:message key="GET_WIDGET_PREVIEW"/></div>
											<div class="remote_widget_tool_preview" id="WC_RemoteWidgetToolDisplay_div_20">
												<a href="#" role="button" class="button_primary" id="WC_RemoteWidgetToolDisplay_a_4" onclick="share(); return false;">
													<div class="left_border"></div>
													<div class="button_text"><fmt:message key="GET_WIDGET_PUBLISH"/></div>												
													<div class="right_border"></div>
												</a> 
											</div>
											<div class ="remote_widget_tool_layout_preview" id="clippingContainer" style="width: 900px;">
												<div class="remote_widget_tool_layout_preview_content" id="contentContainer">
													<div id="contentDiv">
														<fmt:message key="GET_WIDGET_FLASHPLAYER9"/><br><br>
														<a id="WC_RemoteWidgetToolDisplay_a_5" href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="<fmt:message key="GET_WIDGET_FLASHPLAYER9_ALT"/>"/></a>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<br />
							</div>
							<div id="colorPickerDiv" style="display:none"><div dojoType="wc.widget.WCColorPicker" id="colorPicker" onChange="updateColor()"/></div></div> 
							<!-- Content End -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Main Content End -->
	<!-- Footer Widget -->
	<div class="footer_wrapper_position">
		<%out.flush();%>
		<c:import url = "${env_jspStoreDir}/Widgets/Footer/Footer.jsp" />
		<%out.flush();%>
	</div>
</div>
    
<flow:ifEnabled feature="Analytics"><cm:pageview/></flow:ifEnabled>
</body>
</html>

<!-- END RemoteWidgetToolDisplay.jsp -->
