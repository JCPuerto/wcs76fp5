//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2010 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

var widgetPointer = new Object({widgetId:'', colorsLayer:'', minWidth:0, maxWidth:0, minHeight:0, maxHeight:0, mediaLayer:"", mediaURL:""});
var sideBar = null;
var banner = null;

if(sidebarWidgetId != ""){
	sideBar = new Object({widgetId:sidebarWidgetId, colorsLayer:sidebarColors, minWidth:150, maxWidth:900, minHeight:390, maxHeight:900, mediaLayer:feedLayer, mediaURL:feedURL});
	widgetPointer = sideBar;
}
if(bannerWidgetId != ""){
	banner = new Object({widgetId:bannerWidgetId, colorsLayer:bannerColors, minWidth:600, maxWidth:1680, minHeight:90, maxHeight:200, mediaLayer:feedLayer, mediaURL:feedURL});
	if(sideBar==null){widgetPointer = banner;}
}
var params = {menu:"false", allowfullscreen:"true", allowscriptaccess:"always", wmode:"transparent"};
var expressInstallURL = "http://serve.a-widget.com/kickFlash/scripts/expressInstall2.swf";
var swfURL = "http://serve.a-widget.com/service/getWidgetSwf.kickAction";

var flashvars = {affiliateSiteId: affiliateId, widgetId: widgetPointer.widgetId, width:500, height:100, loadedJSCallback:"loadedJSCallback", revision:"2", js:1};
var attributes = {id:"kickWidget_"+affiliateId+"_"+widgetPointer.widgetId, name:"kickWidget_"+affiliateId+"_"+widgetPointer.widgetId};

swfobject.embedSWF(swfURL, "contentDiv", 500, 100, "9.0.28", expressInstallURL, flashvars, params, attributes);

function getWidget() {
	return navigator.appName.indexOf("Microsoft") != -1 ? window['kickWidget_' + affiliateId + '_' + widgetPointer.widgetId] : document['kickWidget_' + affiliateId + '_' + widgetPointer.widgetId];
}

function onLoad(){
	if(!(sideBar && banner)){ document.getElementById("layoutDiv").style.display = 'none'; }
	document.getElementById("vertical_design").checked = "checked";
}

function loadedJSCallback(loadedSWF){
	var widget = getWidget();
	if(widget.getComponentProperty("", "height")){
		 document.RemoteWidgetForm.layout_width.value = widget.getComponentProperty("", "width");
		 document.RemoteWidgetForm.layout_height.value = widget.getComponentProperty("", "height");
		 widget.height = parseInt(widget.getComponentProperty("", "height"));
		 widget.width = parseInt(widget.getComponentProperty("", "width"));
		 setMinMax(widget.height, widget.width);
		 setTimeout("this.setComponents()", 500);
	 }
}

function setMinMax(widgetHeight, widgetWidth){
	widgetPointer.minWidth = Math.min(widgetWidth, widgetPointer.minWidth);
	widgetPointer.maxWidth = Math.max(widgetWidth, widgetPointer.maxWidth);
	widgetPointer.minHeight = Math.min(widgetHeight, widgetPointer.minHeight);
	widgetPointer.maxHeight = Math.max(widgetHeight, widgetPointer.maxHeight);
	dojo.byId("layout_width_min").innerHTML = widgetPointer.minWidth;
	dojo.byId("layout_width_max").innerHTML = widgetPointer.maxWidth;
	dojo.byId("layout_height_min").innerHTML = widgetPointer.minHeight;
	dojo.byId("layout_height_max").innerHTML = widgetPointer.maxHeight;
}

function setComponents(){
	var widget = getWidget();
	if(widget.getComponentProperty(widgetPointer.colorsLayer, "fillColor")){
		var bgColor = widget.getComponentProperty(widgetPointer.colorsLayer, "fillColor");
		var borderColor = widget.getComponentProperty(widgetPointer.colorsLayer, "borderColor");
		document.getElementById("backGroundColor").style.backgroundColor = "#"+bgColor[0].toString(16);
		document.getElementById("borderColor").style.backgroundColor = "#"+borderColor[0].toString(16);
	}
	if(widgetPointer.mediaURL != "" && widgetPointer.mediaLayer != ""){
		var feedURL = decodeURIComponent(widgetPointer.mediaURL.split("&amp;").join("&")) + "&update="+ new Date().getTime();
		widget.setComponentProperty(widgetPointer.mediaLayer, "mediaURL", feedURL);
	}
	var containerWidth = parseInt(document.getElementById("clippingContainer").style.width.replace("px",""));
	if(parseInt(widget.getComponentProperty("", "width")) > containerWidth){
		document.getElementById("contentContainer").style.borderWidth = "1px";
	}else{
		document.getElementById("contentContainer").style.borderWidth = "0px";
	}
}

function setWidth(inputText){
	var widget = getWidget();
	if(widget.getComponentProperty("", "width")){
		var value = inputText.value;
		if(isNaN(value) || value > widgetPointer.maxWidth || value < widgetPointer.minWidth || value == ""){
			inputText.value = widget.getComponentProperty("", "width");
		}else{
			// KickApps has an issue with the scrollbar not calculating its scroll width correctly.
			// As a workaround, set the width to 1px less than the requested, then update to the actual
			// value in syncWidth()
			widget.setComponentProperty("", "width", value - 1);
			widget.width = parseInt(value);
			setTimeout("this.syncWidth()", 250);
			
			var containerWidth = parseInt(document.getElementById("clippingContainer").style.width.replace("px", ""));
			if(parseInt(value) > containerWidth) {
				document.getElementById("contentContainer").style.borderWidth = "1px";
			}
			else {
				document.getElementById("contentContainer").style.borderWidth = "0px";
			}
		}
	}
}

function syncWidth() {
	var widget = getWidget();
	if(widget) {
		var widgetWidth = widget.getComponentProperty("", "width");
		if(widgetWidth) {
			widget.setComponentProperty("", "width", widgetWidth + 1);
		}
	}
}

function setHeight(inputText){
	var widget = getWidget();
	if(widget.getComponentProperty("", "height")){
		var value = inputText.value;
		if(isNaN(value) || value > widgetPointer.maxHeight || value < widgetPointer.minHeight || value == ""){
			inputText.value = widget.getComponentProperty("", "height");
		}
		else {
			// KickApps has an issue with the scrollbar not calculating its scroll height correctly.
			// As a workaround, set the height to 1px less than the requested, then update to the actual
			// value in syncHeight()
			widget.setComponentProperty("", "height", value - 1);
			widget.height = parseInt(value);
			setTimeout("this.syncHeight()", 250);
		}
	}
}

function syncHeight() {
	var widget = getWidget();
	if(widget) {
		var widgetHeight = widget.getComponentProperty("", "height");
		if(widgetHeight) {
			widget.setComponentProperty("", "height", widgetHeight + 1);
		}
	}
}

function share(){
	if(widgetPointer.widgetId != ""){
		var widget = getWidget();
		widget.saveWidgetPlacement("onWidgetPlacementSaved", saveWidgetText);
	}
}

function onWidgetPlacementSaved(isSaved){
	var widget = getWidget();
	if (isSaved){
		widget.showShareMenu(shareWidgetText);
	}
}

function launchColorPicker(relativeId, contentId, paletteDiv, property) {
	// Calculate the X and Y co-ordinates for the dialog. We don't want it to be at the center of the screen.
	var c = dojo.coords(dojo.byId(relativeId),true);
	var x1 = c.x;
	var y1 = c.y;
	if(this.colorPickerDlg && dojo.byId(contentId)){
		this.colorPickerDlg.y = y1 + c.h;
		this.colorPickerDlg.x = x1;
	}
	
	// Dialog is not yet created. Create one.
	if(!this.colorPickerDlg){
		var panel = document.getElementById(contentId);
		this.colorPickerDlg = new wc.widget.WCDialog({relatedSource: relativeId, x:x1,y:y1, closeOnTimeOut:false},panel);
		this.colorPickerDlg.x=x1;
		this.colorPickerDlg.y = y1 + c.h;
	}
	this.colorPickerDlg.paletteDiv = paletteDiv;
	this.colorPickerDlg.property = property;
	dijit.byId("colorPicker").attr("value", document.getElementById(paletteDiv).style.backgroundColor);
	
	this.colorPickerDlg.cancelCloseOnTimeOut();
	this.colorPickerDlg.show();
}

function updateColor() {
	var widget = getWidget();
	if(this.colorPickerDlg && widget.getComponentProperty(widgetPointer.colorsLayer, "fillColor")){
		// gets color value from picker
		var picker = document.getElementById("colorPicker");
		var value = parseInt(picker.value.replace("#",""),16);

		// updates KickApps widget and palette
		var backgroundColor = [value,value];
		widget.setComponentProperty(widgetPointer.colorsLayer, this.colorPickerDlg.property, backgroundColor);
		document.getElementById(this.colorPickerDlg.paletteDiv).style.backgroundColor = picker.value;
	}
}

function switchLayout(vertical){
	if(vertical){
		widgetPointer = sideBar;
	}else{
		widgetPointer = banner;
	}
	var container = dojo.byId("contentContainer");
	for(var i = container.childNodes.length - 1; i >= 0; i--) {
		container.removeChild(container.childNodes[i]);
	}
	var contentDiv = document.createElement("div");
	contentDiv.setAttribute("id", "contentDiv");
	container.appendChild(contentDiv);

	flashvars = {affiliateSiteId: affiliateId, widgetId: widgetPointer.widgetId, width:500, height:100, loadedJSCallback:"loadedJSCallback", revision:"2", js:1};
	attributes = {id:"kickWidget_"+affiliateId+"_"+widgetPointer.widgetId, name:"kickWidget_"+affiliateId+"_"+widgetPointer.widgetId};
	swfobject.embedSWF(swfURL, "contentDiv", 500, 100, "9.0.28", expressInstallURL, flashvars, params, attributes);
}

function expandArea(){
	var innerForm = dojo.byId("inner_form");
	var minus = dojo.byId("WC_RemoteWidgetToolDisplay_closed");
	var plus = dojo.byId("WC_RemoteWidgetToolDisplay_open");
	if(innerForm.style.display == 'none'){
		innerForm.style.display = '';
		plus.style.display = 'none'; 
		minus.style.display = ''; 
	}else{
		innerForm.style.display = 'none';
		plus.style.display = ''; 
		minus.style.display = 'none';
	}
}
