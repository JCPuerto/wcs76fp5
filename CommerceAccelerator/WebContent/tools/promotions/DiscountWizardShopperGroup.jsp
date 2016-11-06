<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c)  Copyright  IBM Corp.  2000      All Rights Reserved

US Government Users Restricted Rights - Use, duplication or 
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="promoCommon.jsp" %>

   <%!
  static final int	 numOfVisibleItemsInList= 14;
  %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=discountWizardNLS.get("shopperGroupTitle")%></title>
<%= fPromoHeader%>

<jsp:useBean id="memberGroupList" scope="request" class="com.ibm.commerce.tools.promotions.CustomerGroupDataBean">
</jsp:useBean>
<%
	memberGroupList.setMemberGroupTypeId(new Integer(-1));
	com.ibm.commerce.beans.DataBeanManager.activate(memberGroupList, request);
%>
<style type='text/css'>
.selectWidth {width: 180px;}

</style>
<script language="JavaScript1.2" src="/wcs/javascript/tools/common/SwapList.js">
</script>
<script>
////////////////////////////////////////////////
// Load data from state of info for this page
// add them to the GUI
///////////////////////////////////////////////
function initializeState()
{

 var assignedShopperGroups  = new Array();	
 var noAssignedShopperGroups  = new Array();
 var shopperGroups = new Array();

 var visitedWizShopper = parent.get("visitedWizShopper", false);
 if (!visitedWizShopper) 
 {
 <% 
   int i=0;
   while (i<memberGroupList.getLength())
   {%>
	noAssignedShopperGroups[<%=i%>] ="<%=memberGroupList.getMemberGroupId(i)%>";
	var sgrp = new Object;
	sgrp.name ="<%=memberGroupList.getMemberGroupName(i)%>";
	sgrp.ref  ="<%=memberGroupList.getMemberGroupId(i)%>";				              
        shopperGroups[shopperGroups.length] = sgrp ;	
        <%
           i++;
  }%>
	document.f1.allGroups[0].checked=true;
	document.f1.allGroups[0].focus();
	
	parent.put("assignedShopperGroups", assignedShopperGroups);
	parent.put("shopperGroups", shopperGroups);
	parent.put("noAssignedShopperGroups", noAssignedShopperGroups);
 }
 else
 {
 	if(parent.get("allShoppers"))
 	{
 		document.f1.allGroups[0].checked=true;
 		document.f1.allGroups[0].focus();
 		document.all["shopperGroupArea"].style.display = "none";
 	}
 	else
 	{
  		document.f1.allGroups[1].checked=true;
  		document.f1.allGroups[1].focus();
 		document.all["shopperGroupArea"].style.display = "block";
 	
	}
 }
	
	
 // get all defined shopper's groups
   var  assignedShopperGroups= parent.get("assignedShopperGroups");
	for (var i=0; i< assignedShopperGroups.length; i++) {
	   var shopperGroupName = getShopperGroupName(assignedShopperGroups[i]);
      document.f1.definedShopperGroup.options[i] = new Option(shopperGroupName
                                                             , shopperGroupName
                                                             , false
                                                             , false);
      document.f1.definedShopperGroup.options[i].selected=false;
	} // get all defined shopper's groups

	// get all no-assigned shopper's groups
	var noAssignedShopperGroups = parent.get("noAssignedShopperGroups");
	
	for ( var i=0; i< noAssignedShopperGroups.length; i++) {
	   var shopperGroupName = getShopperGroupName(noAssignedShopperGroups[i]);		
	   document.f1.allShopperGroup.options[i] = new Option( shopperGroupName
                                                             , shopperGroupName
                                                             , false
                                                             , false);
      document.f1.allShopperGroup.options[i].selected=false;
	} // end of get all no-assigned shoper's group
	
	parent.setContentFrameLoaded(true);
	parent.put("visitedWizShopper", true);

}


// return the shopper group name by his reference
function getShopperGroupName(shopperGroupRef) {
   var groups = parent.get("shopperGroups");
	for (var i=0; i< groups.length; i++) {    
	   if ( shopperGroupRef == groups[i].ref ) {
		    return groups[i].name;
		}
	}
	return shopperGroupRef;
}

// return the shopper group reference number based on the
// shopper group name
function getshopperGroupRefnum(shopperGroupName) {
	 var groups = parent.get("shopperGroups");
	 for (var i=0; i< groups.length; i++) {
		  if ( shopperGroupName == groups[i].name ) {		     
			   return groups[i].ref;				
		   }
	  }
}


/////////////////////////////////////////////////////////////////////////////
// This function will validate the entry fields for this page before wizard
// goes to the next or previous page. This function will also be used to
// restore the user changes to the state of info
/////////////////////////////////////////////////////////////////////////////
function savePanelData()
{
   
   var assignedShopperGroups  = new Array();	
   var noAssignedShopperGroups  = new Array();	 

   if(document.f1.allGroups[1].checked)
   {
      parent.put("allShoppers",false);
   	// recreate the all shopper group list
      for (var i=0; i< document.f1.allShopperGroup.options.length; i++) {
         var groupRef = getshopperGroupRefnum(document.f1.allShopperGroup.options[i].value);
         noAssignedShopperGroups[i] = groupRef ;		
      }
      var groups = parent.get("shopperGroups");
      if(groups.length > 0)
   	parent.put("noAssignedShopperGroups", noAssignedShopperGroups);
   	 
   	// recreate the defined shopper group list
   	for (var i=0; i< document.f1.definedShopperGroup.options.length; i++) {
   	   var groupRef = getshopperGroupRefnum(document.f1.definedShopperGroup.options[i].value);
         assignedShopperGroups[i] = groupRef;		
   	}
       parent.put("assignedShopperGroups", assignedShopperGroups);
    }
    else
    parent.put("allShoppers",true);

 }

function validatePanelData()
{
     if ((document.f1.allGroups[1].checked)&&(isListBoxEmpty(document.f1.definedShopperGroup))) {
	  parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("emptyAssignShopperGroup").toString())%>');
         return false;
	}
     return true;
}

// this function will show all shopper group slash bucket
function showAllShopperGroup()
{
//check if there are any groups in this store
var shopperGroups=parent.get("shopperGroups");

 if(shopperGroups.length==0)
 {
    parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("emptyGroup").toString())%>');
    document.f1.allGroups[0].checked=true;
 }
 else
 {
 setItemsSelected(document.f1.definedShopperGroup);
 move(document.f1.definedShopperGroup,document.f1.allShopperGroup);	

 document.all["shopperGroupArea"].style.display = "block";
 }
}

function hideAllShopperGroup()
{
 setItemsSelected(document.f1.definedShopperGroup);
 move(document.f1.definedShopperGroup,document.f1.allShopperGroup);	

 document.all["shopperGroupArea"].style.display = "none";
}


////////////////////////////////////////////////////////////////
// This function is used to add one or more shopper groups to 
// defined shopper group list                
////////////////////////////////////////////////////////////////
function addToDefinedShopperGroup() {

   move(document.f1.allShopperGroup, document.f1.definedShopperGroup);
  updateSloshBuckets(document.f1.allShopperGroup, document.f1.addButton, document.f1.definedShopperGroup, document.f1.removeButton);

}

///////////////////////////////////////////////////////////////
// This function is used to remove one or more defined shopper
// groups from defined shopper group list
///////////////////////////////////////////////////////////////
function removeFromDefinedShopperGroup() {      
   move(document.f1.definedShopperGroup, document.f1.allShopperGroup);
 updateSloshBuckets(document.f1.definedShopperGroup, document.f1.removeButton,document.f1.allShopperGroup, document.f1.addButton);
}




</script>
<!-- ============================================================================
The sample Templates, HTML and Macros are furnished by IBM as simple
examples to provide an illustration. These examples have not been
thoroughly tested under all conditions.  IBM, therefore, cannot guarantee reliability, 
serviceability or function of these programs. All programs contained herein are provided 
to you "AS IS".

The sample Templates, HTML and Macros may include the names of individuals,
companies, brands and products in order to illustrate them as completely as
possible.  All of these are names are ficticious and any similarity to the names
and addresses used by actual persons or business enterprises is entirely coincidental.

Licensed Materials - Property of IBM

5697-D24

(c)  Copyright  IBM Corp.  1997, 1999.      All Rights Reserved

US Government Users Restricted Rights - Use, duplication or 
disclosure restricted by GSA ADP Schedule Contract with IBM Corp

=============================================================================== -->

</head>
<body class="content" onload="initializeState();">
   <h1><%=discountWizardNLS.get("shopperGroupTitle")%></h1>
   <!-- <p><%=discountWizardNLS.get("shopperGroupMsg")%></p> -->
   <form name='f1' id='f1'>
    <input type="radio" name="allGroups" value="true" onclick="javascript:hideAllShopperGroup()" id="WC_DiscountWizardShopperGroup_FormInput_allGroups_In_f1_1" /> <%=discountWizardNLS.get("assignToAllShopper")%>
    <br />
    <input type="radio" name="allGroups" value="false" onclick="javascript:showAllShopperGroup()" id="WC_DiscountWizardShopperGroup_FormInput_allGroups_In_f1_2" /> <%=discountWizardNLS.get("assignToGroups")%>

   <div id="shopperGroupArea" style="display:none">
    <blockquote>

       <table border='0' id="WC_DiscountWizardShopperGroup_Table_1">
         <tr>
        <td id="WC_DiscountWizardShopperGroup_TableCell_1"><%=discountWizardNLS.get("definedShopperGroups")%></td>
   	<td width='20' id="WC_DiscountWizardShopperGroup_TableCell_2">&nbsp;</td>
   	<td id="WC_DiscountWizardShopperGroup_TableCell_3"><%=discountWizardNLS.get("allShopperGroupsLbl")%></td>
         </tr>

   	  <!-- all shopper groups -->
          <tr>
           <td id="WC_DiscountWizardShopperGroup_TableCell_4">
   	     <select name='definedShopperGroup' class='selectWidth' multiple ="multiple" size='<%=numOfVisibleItemsInList%>' onchange="javascript:updateSloshBuckets(this, document.f1.removeButton, document.f1.allShopperGroup, document.f1.addButton);">

         	   </select>
     	   </td>

   	   <td width='20' valign='middle' id="WC_DiscountWizardShopperGroup_TableCell_5">
   	      <input type='button' name='addButton' class="disabled" style='width:125px' value='<%=discountWizardNLS.get("buttonAdd")%>' onclick='addToDefinedShopperGroup();parent.put("lastupdategui", "<%=discountWizardNLS.get("definedshoppergroups")%>");' /><font size="javascript:Util.isDoubleByteLocale(<%=fLocale%>)? '2' : '1'" style='float:left; padding-top:2px'>
   	      <input type='button' name='removeButton' class="disabled" style='width:125px' value='<%=discountWizardNLS.get("buttonRemove")%>' onclick='removeFromDefinedShopperGroup();parent.put("lastupdategui", "<%=discountWizardNLS.get("definedshoppergroups")%>");' /><font size="javascript:Util.isDoubleByteLocale(<%=fLocale%>)? '2' : '1'" style='float:left; padding-top:2px'>
   	   </font></font></td>
           <td id="WC_DiscountWizardShopperGroup_TableCell_6">
             <select name='allShopperGroup' class='selectWidth' multiple ="multiple" size='<%=numOfVisibleItemsInList%>' onchange="javascript:updateSloshBuckets(this, document.f1.addButton, document.f1.definedShopperGroup, document.f1.removeButton);">
   	     <!-- all available shopper groups for merchant -->

   	     </select>
   	   </td>
          </tr>
      </table>
   </blockquote>
  </div>
  </form>
</body>
</html>
