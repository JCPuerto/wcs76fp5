<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c) Copyright IBM Corp.  2006
All Rights Reserved

US Government Users Restricted Rights - Use, duplication or
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->
<%
//********************************************************************
//*-------------------------------------------------------------------
//* Licensed Materials - Property of IBM
//*
//* WebSphere Commerce
//*
//* (c) Copyright IBM Corp. 2000, 2002
//*
//* US Government Users Restricted Rights - Use, duplication or
//* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
//*
//*-------------------------------------------------------------------
//*
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- Generic JSP for all components -->

<%@ page import="com.ibm.commerce.tools.util.*" %>
<%@ page import="com.ibm.commerce.tools.promotions.*" %>
<%@ page import="com.ibm.commerce.utils.*" %>
<%@ page import="com.ibm.commerce.server.*" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ page import="com.ibm.commerce.tools.common.ui.taglibs.*" %>
<%@ page import="com.ibm.commerce.tools.common.ui.*" %>

<%@ page import="javax.servlet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.*" %>
<%@ page import="java.lang.reflect.*" %>

<%@include file="../common/common.jsp" %>

<script src="/wcs/javascript/tools/common/dynamiclist.js">
</script>

<!-- Get user bean -->
<%
         CommandContext cmdContext = (CommandContext)request.getAttribute(com.ibm.commerce.server.ECConstants.EC_COMMANDCONTEXT);
         Locale fLocale = cmdContext.getLocale();

         String xmlfile = request.getParameter("ActionXMLFile");
         Hashtable actionXML = (Hashtable)ResourceDirectory.lookup(xmlfile);
         Hashtable action = (Hashtable)actionXML.get("action");
         String resourcefile = (String)action.get("resourceBundle");

         Hashtable discountWizardNLS = (Hashtable) ResourceDirectory.lookup(resourcefile, fLocale); 
         Integer fStoreId = cmdContext.getStoreId();
         String fLanguageId = cmdContext.getLanguageId().toString();
%>

    <!-- user javascript function include here -->
    <!-- javascript function defined in XML will be included in parent frame -->


<%= fHeader %>
<link rel="stylesheet" href="<%= UIUtil.getCSSFile(fLocale) %>" type="text/css" />

<%

	   Hashtable scrollcontrol = (Hashtable) action.get("scrollcontrol");
	   if (scrollcontrol != null){
	       String title = (String) scrollcontrol.get("title");
%>
           <title><%= UIUtil.toHTML(discountWizardNLS.get(title).toString())%></title>
<%
	   }
%>


<script language="JavaScript">
//global var to get the selected currency
var fCurr=parent.parent.get("discCurr");

var discountNothingDefinedMsg="<%= UIUtil.toJavaScript((String)discountWizardNLS.get("discountNothingDefined"))%>";

function initializeState()
{
   var ranges = new Array();

   if(top.getData("discountRanges"))
   {
     if(rangeChange())
     {
     	parent.parent.put("discountRanges","");
     	top.saveData("","discountRanges");
     }
     else
     {
         ranges=top.getData("discountRanges");
         
         var newRanges=new Array();
     
         newRanges=formatRanges(ranges);
             
         parent.parent.put("discountRanges",newRanges);
     }
     
   }
//save the current info
  parent.parent.put("oldDiscCurr",parent.parent.get("discCurr",null));
  parent.parent.put("oldDiscType",parent.parent.get("discType",null));
  parent.parent.put("oldRangeType",parent.parent.get("rangeType",null));
  parent.parent.put("oldDiscSubType",parent.parent.get("discSubType",null));
  
  //update panel tab
  if(parent.parent.getPanelAttribute("DiscountWizardRanges","hasTab")=="NO")
  {
    parent.parent.setPanelAccess("DiscountWizardProductLevel", false);
    parent.parent.setPanelAttribute( "DiscountWizardProductLevel", "hasTab", "NO" );
    parent.parent.setPanelAccess("DiscountWizardOrderLevel", false);
    parent.parent.setPanelAttribute( "DiscountWizardOrderLevel", "hasTab", "NO" );
    parent.parent.setPanelAccess("DiscountWizardCustomType", true );
    parent.parent.setPanelAttribute( "DiscountWizardCustomType", "hasTab", "YES" );
    parent.parent.pageArray=top.getData("rangePageArray");
    
    if(eval(parent.parent.get("discType"))==1)
    {
      parent.parent.setPanelAccess("DiscountWizardCustom", true );
      parent.parent.setPanelAttribute( "DiscountWizardCustom", "hasTab", "YES" );
    }
    parent.parent.setPanelAttribute( "DiscountWizardRanges", "hasTab", "YES" );
    parent.parent.TABS.location.reload();
  }
}

// This is function is to detemine if the user have navigate back to previous
//panel and change anything which may affect the range.
function rangeChange()
{
    if(parent.parent.get("oldDiscCurr"))
    {
     	if(parent.parent.get("oldDiscCurr")!=parent.parent.get("discCurr"))
     	{
     	    if ( parent.parent.get("rangeType") == 0 )
     	    	return true;
     	    if(parent.parent.get("discSubType")==1||parent.parent.get("discSubType")==2)
     	    	return true;
     	}
     }
     
    if(parent.parent.get("oldRangeType")==1||parent.parent.get("oldRangeType")==0)
    	if(eval(parent.parent.get("oldRangeType"),"")!=eval(parent.parent.get("rangeType"),""))
    		return true;
    		
   if(parent.parent.get("oldDiscType")==1||parent.parent.get("oldDiscType")==0)
    	if(eval(parent.parent.get("oldDiscType"))!=eval(parent.parent.get("discType")))
    		return true;
    		
   if(parent.parent.get("oldDiscSubType")==1||parent.parent.get("oldDiscSubType")==0||parent.parent.get("oldDiscSubType")==2)
   	if(eval(parent.parent.get("oldDiscSubType"))!=eval(parent.parent.get("discSubType","")))
    		return true;
    		
   return false;
}

function addRangeAction()
{
  var ranges=new Array();
  ranges=parent.parent.get("discountRanges","");

    if(ranges.length<=15){
	top.saveModel(parent.parent.model);
	
	top.saveData(ranges,"discountRanges");
	top.saveData(parent.parent.get("rangeType"),"rangeType");
	top.saveData(parent.parent.get("discCurr"),"discCurr");
	top.saveData(parent.parent.get("discSubType"),"discSubType");
	top.saveData(parent.parent.pageArray, "rangePageArray");
	
	top.showContent("/webapp/wcs/tools/servlet/DialogView?XMLFile=discount.rangeAdd");
	parent.parent.put("visitedWizCustomRange",true);
		
   	parent.parent.setContentFrameLoaded(true);
    	
    }
    else
    	parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("rangeTooManyMsg").toString())%>');
}


function performDelete() {

	var ranges = parent.parent.get("discountRanges","");
	var index= parent.getChecked();
  
  if(eval(ranges[index].rangeFrom)==0){
	// can not delete first row a time
		parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("cannotRemove").toString())%>');
	 	return;
	}
	 
	var newRanges=new Array();
	for(var i=0;i<eval(index.toString());i++)
  	newRanges[i]=ranges[i];
	for(var i=eval(index.toString())+1;i<ranges.length;i++)
	 	newRanges[i-1]=ranges[i];
	 	
	 	parent.removeEntry(index);
	
	top.saveData(newRanges,"discountRanges");
    parent.basefrm.location.href="/webapp/wcs/tools/servlet/DiscountWizRangesView?ActionXMLFile=discount.discountRange";  
  
}

function modifyRangeAction()
{
  if (parent.parent.isInsideMC()) { 
	var index=parent.getChecked();
	top.saveModel(parent.parent.model);
	
	top.saveData(ranges,"discountRanges");
	top.saveData(parent.parent.get("rangeType"),"rangeType");
	top.saveData(parent.parent.get("discCurr"),"discCurr");
	top.saveData(parent.parent.get("discSubType"),"discSubType");
	top.saveData(eval(index.toString()),"modifyRangeIndex");
	top.saveData(parent.parent.pageArray, "rangePageArray");
	
	top.showContent("/webapp/wcs/tools/servlet/DialogView?XMLFile=discount.rangeModify");
	parent.parent.put("visitedWizCustomRange",true);
		
   	parent.parent.setContentFrameLoaded(true);
}
  
}

//formart the ranges in the frame 
function formatRanges(ranges)
{
     var whichDiscountType = parent.parent.get("rangeType");
     
     if(eval(ranges[0].rangeFrom)>0)
     {
        var aRange=new Object;
         	
        aRange.rangeFrom = 0;
        aRange.rangeTo = <%=ECPromotionsConstants.EC_Range_Max%>;
        aRange.discount=0; 
        
        for(var i=ranges.length;i>0;i--)
          ranges[i]=ranges[i-1];
     	ranges[0]=aRange;
     }
     
  //format RangeTo
     var increValue= 1;      
     if ( whichDiscountType == 0 ) {
         // increValue = 1 / Math.pow(10,parent.parent.numericInfo[fCurr]["<%=fLanguageId%>"]["currency"]["minFrac"]);    
         var ninfo= parent.parent.getNumericInfo(fCurr,"<%=fLanguageId%>");
         increValue = 1 / Math.pow(10,ninfo["minFrac"]);
     }
     if(ranges.length>1)      
      for(var i=0; i<ranges.length-1;i++)
       ranges[i].rangeTo=eval(parseFloat(ranges[i+1].rangeFrom) - parseFloat(increValue)); 
     
     // ranges[0].rangeFrom=0;  
     ranges[ranges.length-1].rangeTo = <%=ECPromotionsConstants.EC_Range_Max%>;
     
     return ranges;
}


function onLoad() {
  parent.loadFrames()
}

function pageTop(){
	if ( parent.parent.get("rangeType") == 1 ) {
	  // rate type is quantity
	  document.write('<P><%=UIUtil.toJavaScript((String)discountWizardNLS.get("discountRangesInstruction1"))%>');
	} else
	if ( parent.parent.get("rangeType") == 0 ) {
	  // rate type is dolloar
	  document.write('<%=UIUtil.toJavaScript((String)discountWizardNLS.get("discountRangesInstruction2"))%>');
	} 
	
	document.write('<%=UIUtil.toJavaScript((String)discountWizardNLS.get("discountRangesInstruction3"))%></P>');
}

function discountType()
{
  if(parent.parent.get("rangeType")==0)
    return "("+fCurr+")";
  else
    return '<%=UIUtil.toJavaScript((String)discountWizardNLS.get("byUnit"))%>';
}

function showFormatRange(range){
  var whichDiscountType = parent.parent.get("rangeType");
  if ( whichDiscountType == 1 ) {
	   // This is the quantity
	return parent.parent.numberToStr(range.toString(),"<%=fLanguageId%>",0);	   
  }
  else if(whichDiscountType == 0){
  // this is a $ value
  	return parent.parent.numberToCurrency(range.toString(),fCurr,"<%=fLanguageId%>");
  }
}

function showFormatDiscount(d){
 if (parent.parent.get("discSubType")==0)
      return parent.parent.numberToStr(d.toString(),"<%=fLanguageId%>",0);
 else
      return parent.parent.numberToCurrency(d.toString(),fCurr,"<%=fLanguageId%>");
}



</script>
<script src="/wcs/javascript/tools/common/Util.js">
</script>
</head>
<body class="content_list">
<script language="JavaScript">
<!--
//For IE
if (document.all) {
    onLoad();
}
//-->

</script>
<h1><%=discountWizardNLS.get("discountRangeTitle")%></h1>
<script language="JavaScript">
initializeState();
pageTop();

</script>
<form name='<%=(String)action.get("formName")%>'>
<script language="JavaScript">
  startDlistTable('<%=discountWizardNLS.get("discountRangeTblMsg")%>');
  startDlistRowHeading();
  addDlistCheckHeading(false);
  addDlistColumnHeading(""+'<%= discountWizardNLS.get("discountRangeFrom") %>'+"&nbsp;"+discountType(),false,"35%");
  addDlistColumnHeading(""+'<%= discountWizardNLS.get("discountRangeTo") %>'+"&nbsp;"+discountType(),false,"35%");
    
  if (parent.parent.get("discSubType")==0)
  {
      addDlistColumnHeading('<%= UIUtil.toJavaScript((String)discountWizardNLS.get("discountInPercent"))%>',false,"30%");
  }
  else
  {
      addDlistColumnHeading(""+'<%=UIUtil.toJavaScript((String)discountWizardNLS.get("discountRate"))%>'+"&nbsp;("+fCurr+")",false,"30%");
  }
  endDlistRow();
  
  if(parent.parent.get("discountRanges"))
  {
      var ranges=parent.parent.get("discountRanges");
      var rowColor = 1;

      for (var i=0; i < ranges.length; i++)
      if(eval(ranges[i].rangeTo)>0)      
      {
         startDlistRow(rowColor);
         addDlistCheck(i);
         addDlistColumn(showFormatRange(ranges[i].rangeFrom));
         
         if(ranges[i].rangeTo==<%=ECPromotionsConstants.EC_Range_Max%> )
           addDlistColumn('<%=UIUtil.toJavaScript((String)discountWizardNLS.get("andUp"))%>');           
         else
           addDlistColumn(showFormatRange(ranges[i].rangeTo));
         addDlistColumn(showFormatDiscount(ranges[i].discount)); 
         
         endDlistRow();

         if (rowColor == 1)
            rowColor = 2;
         else
            rowColor = 1         
      }
      
   }
   endDlistTable();

</script>
</form>
<script>   
   if(!top.getData("discountRanges"))
   	document.write('<p><%=UIUtil.toJavaScript((String)discountWizardNLS.get("discountNoRanges"))%></p>');
      
   parent.parent.put("visitedWizCustomRange",true);
		
   parent.parent.setContentFrameLoaded(true);
    parent.afterLoads();
    parent.setButtonPos('0px','93px');

</script>

</body>
</html>
