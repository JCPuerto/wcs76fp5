<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c)  Copyright  IBM Corp.  2000      All Rights Reserved

US Government Users Restricted Rights - Use, duplication or 
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<%@include file="promoCommon.jsp" %>

<jsp:useBean id="list" scope="request" class="com.ibm.commerce.tools.common.ui.DynamicListBean"></jsp:useBean>

<%
    list.setRequest(request);    
%>


<script src="/wcs/javascript/tools/common/Util.js">
</script>

<script language="JavaScript">


function savePanelData()
{
    var checkedId = new Array();
    checkedId = basefrm.getChecked();
    var aCalCode_Id = checkedId[0];
    parent.put("<%= ECPromotionsConstants.EC_Calcode_Id%>",aCalCode_Id);
    
    var aCategoryId=top.getData("categoryId",1);
    parent.put("<%=ECConstants.EC_CATEGORY_ID%>",aCategoryId.toString());
    	
}

function validatePanelData()
{
	checkedId = basefrm.getChecked();
	if(checkedId=="")
	{
		parent.alertDialog('<%= UIUtil.toJavaScript( discountWizardNLS.get("discountMissMsg").toString())%>');
		return false;
	}
	if(checkedId.length!=1)
	{
		parent.alertDialog('<%= UIUtil.toJavaScript( discountWizardNLS.get("discountMoreMsg").toString())%>');
		return false;
	}
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

function visibleList(s)
  {
      if (defined(this.scrollcontrol.visibleList)==true)
         this.scrollcontrol.visibleList(s);
  }

var formStr = " <%= list.getForm() %> ";  

</script>

</head>

<%=
    list.getScrollControlFrameset()
%>
</html>
