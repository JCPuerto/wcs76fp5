
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
<title><%=discountWizardNLS.get("addRangeWindowTitle")%></title>
<%= fPromoHeader%> 
<script src="/wcs/javascript/tools/common/Util.js">
</script>
</head>
<body class="content" onload="document.f1.rangefrom.focus();">
<script>
//global var to get the selected currency
var fCurr=top.getData("discCurr");

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
  var datasent = new Object;
  var whichDiscountType = top.getData("rangeType");
  var ranges = new Array();
  if(top.getData("discountRanges"))
      ranges = top.getData("discountRanges");
  
  if ( whichDiscountType == 1 )
  { 
	datasent.rangeFrom = parent.strToInteger(trim(document.f1.rangefrom.value),"<%=fLanguageId%>");
  }
  else
  {
  	datasent.rangeFrom = parent.currencyToNumber(trim(document.f1.rangefrom.value),fCurr,"<%=fLanguageId%>");
  }

  datasent.rangeTo = <%=ECPromotionsConstants.EC_Range_Max%>;

  if(top.getData("discSubType")==0)
  {
  	//percent discount
  	datasent.discount=parent.strToNumber(trim(document.f1.discount.value),"<%=fLanguageId%>");
  
  }
  else
  {
  	//currency discount
  	datasent.discount = parent.currencyToNumber(trim(document.f1.discount.value),fCurr,"<%=fLanguageId%>");
  }
  
     if((ranges.length==0)&&(eval(datasent.rangeFrom)>0))
   {
         var bRange=new Object;
  	
  	bRange.rangeFrom = 0;
  	bRange.rangeTo = <%=ECPromotionsConstants.EC_Range_Max%>;
  	bRange.discount=0;
  	ranges[0]=bRange;
  }
  
   ranges[ranges.length]=datasent;
   
       //sorting
    for(var i=0;i<ranges.length-1;i++)
     for(var j=i+1;j<ranges.length;j++)
      if(eval(ranges[i].rangeFrom)>eval(ranges[j].rangeFrom))
      {
      var temp=ranges[j].rangeFrom;
      ranges[j].rangeFrom=ranges[i].rangeFrom;
      ranges[i].rangeFrom=temp;
        
      temp=ranges[j].discount;
      ranges[j].discount=ranges[i].discount;
      ranges[i].discount=temp;
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

  // check for value of 'range from', the value of range from should be larger than
  // the value of range to in the previous range (row)
    	
  var whichDiscountType = top.getData("rangeType");
  if ( whichDiscountType == 1 ) 
  {
	   // This is the quantity range

     if ( !parent.isValidInteger(trim(document.f1.rangefrom.value), "<%=fLanguageId%>"))
     {
        // range from must be a integer
   	  parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("rangeFromNotNumber").toString())%>');
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
  
  for(var i=0;i<ranges.length;i++)
  {
  
  	if(eval(parseFloat(parent.strToNumber(trim(document.f1.rangefrom.value), "<%=fLanguageId%>")))
  	==ranges[i].rangeFrom){
  		parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("rangeFromSame").toString())%>');
  		document.f1.rangefrom.select();
	  return false;
  	}
  }
  
  // check in cell "discount"
  if (top.getData("discSubType")==0)
  {
    if ( !isValidPercentage(trim(document.f1.discount.value),"<%=fLanguageId%>")) 
      {
	 parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("percentageInvalid").toString())%>'); 
	 document.f1.discount.select();
	 return false;
     }
  }
  else
  {
    if(!parent.isValidCurrency(trim(document.f1.discount.value),fCurr,"<%=fLanguageId%>"))
    {
	 parent.alertDialog('<%= UIUtil.toJavaScript(discountWizardNLS.get("discountNotNumber").toString())%>'); 
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
<h1><%=discountWizardNLS.get("addRangeWindowTitle")%></h1>

	   <p><%=discountWizardNLS.get("rangeToMsg")%></p>

   <form name="f1" id="f1">
 	<%=discountWizardNLS.get("discountRangeFrom")%><script language="JavaScript">discountType()
</script>
 	<br />


	<input type='text' name='rangefrom' value="" size="10" maxlength="14" id="WC_DiscountWizardRanges_Add_FormInput_rangefrom_In_f1_1" /><br /><br />

        <script language="JavaScript">
	if(top.getData("discSubType")==0)
	{
	    // label should represent the percentage value for discount
		document.write("<%=UIUtil.toJavaScript((String)discountWizardNLS.get("discountInPercent"))%>");
	 }
	else
	{
   	 	document.write("<%=UIUtil.toJavaScript((String)discountWizardNLS.get("discountRate"))%>"+"("+fCurr+")");
   	 }
	   
</script>
	   <br />
	<input type='text' name='discount' value="" size="10" maxlength="14" id="WC_DiscountWizardRanges_Add_FormInput_discount_In_f1_1" /><br /><br />
   </form>
<p><%=discountWizardNLS.get("currentRange")%></p>
<form name="rangeForm" id="rangeForm">
<table class="list" width = "60%" summary='<%=discountWizardNLS.get("discountRangeTblMsg")%>'>
<tr class="list_roles">
   <th width="20%" id="t1">
       <table class="list_role_off" id="WC_DiscountWizardRanges_Add_Table_1">
       	<tr>
   			<td class="list_header" id="WC_DiscountWizardRanges_Add_TableCell_1"><%= discountWizardNLS.get("discountRangeFrom") %>
   				<script language="JavaScript">discountType()
				</script>
    		</td>
    	</tr>
       </table>
   </th>
   <th width="20%" id="t2">
       <table class="list_role_off" id="WC_DiscountWizardRanges_Add_Table_2">
          <tr>
   		<td class="list_header" id="WC_DiscountWizardRanges_Add_TableCell_2"><%= discountWizardNLS.get("discountRangeTo") %>
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
      
         document.writeln('<tr class='+classId+'>');
         document.writeln('<td class="list_info1" headers="t1">'  + showFormatRange(ranges[i].rangeFrom)+ '</td>');
         if(ranges[i].rangeTo==<%=ECPromotionsConstants.EC_Range_Max%> ) 
              document.writeln('<td class="list_info1" headers="t2">' + '<%=UIUtil.toJavaScript((String)discountWizardNLS.get("andUp"))%>' + '</td>');
         else	 
              document.writeln('<td class="list_info1" headers="t2">' + showFormatRange(ranges[i].rangeTo) + '</td>');
         document.writeln('<td class="list_info1" headers="t3">' + showFormatDiscount(ranges[i].discount) + '</td>');
         document.writeln('</tr>');

         if (classId == "list_row1")
            classId = "list_row2";
         else
            classId = "list_row1"
         
      }
   }
   
   document.writeln('</table>');
   document.writeln('</form>');
   
   if(!top.getData("discountRanges"))
   	document.write('<p><%=UIUtil.toJavaScript((String)discountWizardNLS.get("discountNoRanges"))%></p>');

   top.showProgressIndicator(false);

</script>

</body>
</html>

