
<!--==========================================================================
Licensed Materials - Property of IBM

WebSphere Commerce

(c)  Copyright  IBM Corp.  2000      All Rights Reserved

US Government Users Restricted Rights - Use, duplication or 
disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
===========================================================================-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="promoCommon.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%= fPromoHeader%>
<script src="/wcs/javascript/tools/common/Util.js">
</script>

</head>
<body class="content" onload="initializeState();">
<script>


//global var to get the selected currency
var fCurr=top.getData("discCurr");

//////////////////////////////////////////////////////////
// Load data and initialize the data from state of info
//////////////////////////////////////////////////////////
function initializeState()
{  
  var ranges = new Array();
  ranges = top.getData("discountRanges"); 

  
  var index=top.getData("modifyRangeIndex");
  var modifyEntryOfRangeFrom    = ranges[index].rangeFrom;
  
  var modifyEntryOfRangeDiscount= ranges[index].discount;
  
  
  // add them to GUI
  var whichDiscountType = top.getData("rangeType");
  if ( whichDiscountType == 1 ) 
  {
  	document.f1.rangefrom.value= parent.numberToStr(modifyEntryOfRangeFrom.toString(),"<%=fLanguageId%>",0);
  }
  else
  	document.f1.rangefrom.value= parent.numberToCurrency(modifyEntryOfRangeFrom.toString(),fCurr,"<%=fLanguageId%>");
   if(top.getData("discSubType")==0)
  {
  	//percent discount
     document.f1.discount.value = parent.numberToStr(modifyEntryOfRangeDiscount.toString(),"<%=fLanguageId%>", 0);
     
  }
  else
  {
       document.f1.discount.value = parent.numberToCurrency(modifyEntryOfRangeDiscount.toString(),fCurr,"<%=fLanguageId%>");
  }
  
  document.f1.rangefrom.focus();
  document.f1.rangefrom.select();
  
}


function discountType()
{
  if(top.getData("rangeType")==0)
    document.write("("+fCurr+")");
  else
    document.write('<%=UIUtil.toJavaScript((String)discountWizardNLS.get("byUnit"))%>');
}

function cancelAction()
{
  parent.location.replace("WizardView?XMLFile=discount.discountWizard&startingPage=DiscountWizardRanges");

}

////////////////////////////////////////////////////////////
// Add new range to the state of info
////////////////////////////////////////////////////////////
function savePanelData() 
{  
if(validatePanelData())
{
  var ranges; 
  ranges = top.getData("discountRanges");

  // get the modified row index
  
  var index=top.getData("modifyRangeIndex");
  var whichDiscountType = top.getData("rangeType");
  
  if ( whichDiscountType == 1 )
  { 
	ranges[index].rangeFrom = parent.strToInteger(trim(document.f1.rangefrom.value),"<%=fLanguageId%>");
  }
  else
  {
  	ranges[index].rangeFrom = parent.currencyToNumber(trim(document.f1.rangefrom.value),fCurr,"<%=fLanguageId%>");
  }
  if(top.getData("discSubType")==0)
  {
  	//percent discount
  	ranges[index].discount  = parent.strToInteger(trim(document.f1.discount.value),"<%=fLanguageId%>");
  }
  else
  {
  	//currency discount
  	ranges[index].discount = parent.currencyToNumber(trim(document.f1.discount.value),fCurr,"<%=fLanguageId%>");
  }	
  top.saveData(ranges,"discountRanges");
  parent.location.replace("WizardView?XMLFile=discount.discountWizard&startingPage=DiscountWizardRanges");
  }
}

function showFormatRange(range){
  var whichDiscountType = top.getData("rangeType");
  if ( whichDiscountType == 1 ) {
	   // This is the quantity
	return parent.numberToStr(range.toString(),"<%=fLanguageId%>",0);	   
  }
  else if(whichDiscountType == 0){
  // this is a $ value
  	return parent.numberToCurrency(range.toString(),fCurr,"<%=fLanguageId%>");
  }
}

function showFormatDiscount(d){
 if (top.getData("discSubType")==0)
      return parent.numberToStr(d.toString(),"<%=fLanguageId%>",0);
 else
      return parent.numberToCurrency(d.toString(),fCurr,"<%=fLanguageId%>");
}

function isValidPercentage(pValue, languageId)
{
	if ( !parent.isValidInteger(pValue, languageId))
	{
		return false;
	}
	else if( ! (eval(pValue) <= 100))
	{
		return false;
	}
	else if (! (eval(pValue) >= 0) )
	{
		return false;
	}
	return true;
}
/////////////////////////////////////////////////////////////////////////////
// This function will validate the entry fields for this page before wizard
// goes to the next or previous page. This function will also be used to
// restore the user changes to the state of info
/////////////////////////////////////////////////////////////////////////////
function validatePanelData() {
  //check in cell "range Start"

    var whichDiscountType = top.getData("rangeType");
  if ( whichDiscountType == 1 ) 
  {
  // This is the quantity range


     if ( !parent.isValidInteger(trim(document.f1.rangefrom.value), "<%=fLanguageId%>"))
     {
        // range from must be a integer
   	  parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("rangeFromNotNumber").toString())%>');
   	  document.f1.rangefrom.focus();
   	  document.f1.rangefrom.select();
   	  return false;
     }
     
     if(parent.strToInteger(trim(document.f1.rangefrom.value), "<%=fLanguageId%>")< 0)
     {
   	  parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("rangeFromNotNumber").toString())%>');
   	  document.f1.rangefrom.select();
   	  return false;
     }
     
   if((parent.strToInteger(trim(document.f1.rangefrom.value), "<%=fLanguageId%>")).toString().length >14)
   {
   	parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("rangeTooLong").toString())%>');
   	document.f1.rangefrom.focus();
   	document.f1.rangefrom.select();
   	return false;
   }
  }
  else if ( whichDiscountType == 0)
  {
  	//this is a $ value range
  	if(!parent.isValidCurrency(trim(document.f1.rangefrom.value),fCurr,"<%=fLanguageId%>"))
  	{
        // range from must be a currency value
   	  parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("rangeFromNotNumber").toString())%>');
   	  document.f1.rangefrom.focus();
   	  document.f1.rangefrom.select();
   	  return false;
     	}
     
       	if(parent.currencyToNumber(trim(document.f1.rangefrom.value), "<%=fLanguageId%>")<0)
     	{
        // range from must >=0
   	  parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("rangeFromNotNumber").toString())%>');
   	  document.f1.rangefrom.select();
   	  return false;
     	}
     		
   if((parent.currencyToNumber(trim(document.f1.rangefrom.value), "<%=fLanguageId%>")).toString().length >14)
   {
   	parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("rangeTooLong").toString())%>');
   	document.f1.rangefrom.focus();
   	document.f1.rangefrom.select();
   	return false;
   }
  }
  
  var ranges = new Array();
  if(top.getData("discountRanges"))
      ranges = top.getData("discountRanges"); 
  

  var index=top.getData("modifyRangeIndex");
  if(ranges.length>1)
  {
      if(eval(index)<ranges.length-1)
      {
         if(eval(parseFloat(parent.strToNumber(trim(document.f1.rangefrom.value), "<%=fLanguageId%>")))>= eval(parseFloat(parent.strToNumber(ranges[eval(index)+1].rangeFrom), "<%=fLanguageId%>" )))
         {
            parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("rangeFromBig").toString())%>');
            document.f1.rangefrom.focus();
            document.f1.rangefrom.select();
            return false;
         }
       }
      if(eval(index)>0)
      { 
      	if(eval(parseFloat(parent.strToNumber(trim(document.f1.rangefrom.value), "<%=fLanguageId%>")))<= eval(parseFloat(parent.strToNumber(ranges[eval(index)-1].rangeFrom), "<%=fLanguageId%>" )))
      	{
         	parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("rangeFromSmall").toString())%>');
         	document.f1.rangefrom.focus();
        	document.f1.rangefrom.select();
        	return false;
      	}
      }
   
  }	 
  
  
  // check in cell "discount"

  if (top.getData("discSubType")==0)
  {
     if ( !isValidPercentage(trim(document.f1.discount.value),"<%=fLanguageId%>")) 
     {
	 parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("percentageInvalid").toString())%>'); 
	 document.f1.discount.focus();
	 document.f1.discount.select();
	 return false;
     }
  }
  else
  {
    if(!parent.isValidCurrency(trim(document.f1.discount.value),fCurr,"<%=fLanguageId%>"))
    {
	 parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountNotNumber").toString())%>'); 
	 document.f1.discount.focus();
	 document.f1.discount.select();
	 return false;
    }
    
    if(parent.currencyToNumber(trim(document.f1.discount.value), "<%=fLanguageId%>") <0)
    {
	 parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountNotNumber").toString())%>'); 
	 document.f1.discount.select();
	 return false;
    }
    
   if((parent.currencyToNumber(trim(document.f1.discount.value), "<%=fLanguageId%>")).toString().length >14)
   {
   	parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("currencyTooLong").toString())%>');
   	document.f1.discount.focus();
   	document.f1.discount.select();
   	return false;
   }
   
   if(whichDiscountType == 0)
   {
    if(parent.currencyToNumber(trim(document.f1.discount.value), "<%=fLanguageId%>")>eval(parseFloat(parent.strToNumber(trim(document.f1.rangefrom.value), "<%=fLanguageId%>"))))
    {
    parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountOverRange").toString())%>');
   	document.f1.discount.focus();
   	document.f1.discount.select();
   	return false;
    }
   }
  }
  return true;
}   


</script>
<h1><%=discountWizardNLS.get("modifyRangeWindowTitle")%></h1>
	   <p><%=discountWizardNLS.get("rangeToMsg")%></p>
   <form name="f1" id="f1">
     <%=discountWizardNLS.get("discountRangeFrom")%><script language="JavaScript">discountType()
</script>
     <br />
     <input type='text' name='rangefrom' value="" size="10" maxlength="14" id="WC_DiscountWizardRanges_Modify_FormInput_rangefrom_In_f1_1" /><br /><br />
	<script language="JavaScript">
   if(top.getData("discSubType")==0)
   {
      document.write('<%=UIUtil.toJavaScript((String) discountWizardNLS.get("discountInPercent"))%> ')
   }
   else
   {
      document.write('<%=UIUtil.toJavaScript((String) discountWizardNLS.get("discountRate"))%>');
      document.write("("+fCurr+")");
   }
	
</script>
	 <br />
    <input type='text' name='discount' value="" size="10" maxlength="14" id="WC_DiscountWizardRanges_Modify_FormInput_discount_In_f1_1" /><br /><br />

   </form>
 <p><%=discountWizardNLS.get("currentRange")%></p>
<form name="rangeForm" id="rangeForm">
<table class="list" width = "60%" summary='<%=discountWizardNLS.get("discountRangeTblMsg")%>'>
<tr class="list_roles">
   <th width="20%" id="t1">
       <table class="list_role_off" id="WC_DiscountWizardRanges_Modify_Table_1">
          <tr>
   		<td class="list_header" id="WC_DiscountWizardRanges_Modify_TableCell_1"><%= discountWizardNLS.get("discountRangeFrom") %>
   			<script language="JavaScript">discountType()
</script>
    		</td>
    	 </tr>
       </table>
   </th>
   <th width="20%" id="t2">
       <table class="list_role_off" id="WC_DiscountWizardRanges_Modify_Table_2">
          <tr>
   		<td class="list_header" id="WC_DiscountWizardRanges_Modify_TableCell_2"><%= discountWizardNLS.get("discountRangeTo") %>
   			<script language="JavaScript">discountType()
</script>
    		</td>
    	 </tr>
       </table>
   </th>

   <script language="JavaScript">
  if (top.getData("discSubType")==0)
   {
      document.write('<th width="20%" id="t3"> <table class="list_role_off"> <tr><td class="list_header">'+'<%= UIUtil.toJavaScript((String)discountWizardNLS.get("discountInPercent"))%>');
      document.write('</td></tr></table></th>')
   }
   else
   {
      document.write('<th width="20%" id="t3"> <table class="list_role_off"> <tr><td class="list_header">'+'<%= UIUtil.toJavaScript((String)discountWizardNLS.get("discountRate"))%>');
      document.write("("+fCurr+")");
      document.write('</td></tr></table></th>')
   }
       
   
</script>
</tr>

<script>
   if(top.getData("discountRanges"))
   {
      var ranges=top.getData("discountRanges");
      var classId = "list_row1";

      for (var i=0; i < ranges.length; i++)
      if(eval(ranges[i].rangeTo)>0)      
      {
         document.writeln('<tr CLASS='+classId+'>');
         document.writeln('<td headers="t1" class="list_info1">'  + showFormatRange(ranges[i].rangeFrom)+ '</td>');
         if(ranges[i].rangeTo==<%=ECPromotionsConstants.EC_Range_Max%> ) 
              document.writeln('<td headers="t2" class="list_info1">'  + '<%=UIUtil.toJavaScript((String)discountWizardNLS.get("andUp"))%>' + '</TD>');
         else	 
              document.writeln('<td headers="t2" class="list_info1">'  + showFormatRange(ranges[i].rangeTo) + '</td>');
         document.writeln('<td headers="t3" class="list_info1">' + showFormatDiscount(ranges[i].discount) + '</td>');
         document.writeln('</tr>');

         if (classId == "list_row1")
            classId = "list_row2";
         else
            classId = "list_row1"
         
      }
   }
</script>

</table></form>
<script>   
   if(!top.getData("discountRanges"))
   	document.write('<p><%=UIUtil.toJavaScript((String)discountWizardNLS.get("discountNoRanges"))%></p>');

   top.showProgressIndicator(false);

</script>

</body>
</html>

