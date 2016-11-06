<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c)  Copyright  IBM Corp.  2000      All Rights Reserved

US Government Users Restricted Rights - Use, duplication or 
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">

<%@include file="promoCommon.jsp" %>

<%
PromotionDynamicListBean list = new PromotionDynamicListBean();
list.setRequest(request);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<script language="JavaScript">


function savePanelData()
{
  var ranges=new Array();
  
  ranges=parent.get("discountRanges","");
  
  var rangeFromArray=new Array();
  var discountValueArray=new Array();

  for(var i=0;i<ranges.length;i++)
  {
  	
  	rangeFromArray[i]=ranges[i].rangeFrom;
  	discountValueArray[i]=ranges[i].discount;
  }
  
  parent.put("rangeFromArray",rangeFromArray);
  parent.put("discountValueArray",discountValueArray);
}

function validatePanelData()
{
    ranges=parent.get("discountRanges","");
    
    if(ranges.length==0)
    {
    		  parent.alertDialog('<%= UIUtil.toJavaScript((String)discountWizardNLS.get("discountNothingDefined"))%>');
    	return false;
    }
    else
    	return true;
}
function loadPanelData()
 {
  if (parent.setContentFrameLoaded)
   {
    parent.setContentFrameLoaded(true);
   }
 }

function getHelp()
{
   if (defined(this.basefrm.getHelp)==true)
         return this.basefrm.getHelp();
}

var formStr = " <%= list.getForm() %> ";

</script>

</head>

<%=list.getFrameset()%>

</html>
