<!-- ========================================================================
  Licensed Materials - Property of IBM

 WebSphere Commerce

  (c) Copyright IBM Corp. 2001, 2002

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 ===========================================================================-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
<%@page import="java.util.*" %>
<%@page import="com.ibm.commerce.tools.util.*" %>
<%@page import="com.ibm.commerce.tools.xml.*" %>

<%@include file="/tools/common/common.jsp" %>
<%@include file="/tools/reporting/ReportFrameworkHelper.jsp" %>
<%@include file="/tools/reporting/ReportStartDateEndDateHelper.jspf" %>
 

<%
   CommandContext biCommandContext = (CommandContext) request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
   Locale biLocale = biCommandContext.getLocale();
   Hashtable biNLS = (Hashtable)com.ibm.commerce.tools.util.ResourceDirectory.lookup("bi.biNLS", biLocale);
%>
<HTML>
<HEAD>

<link rel=stylesheet href="<%= UIUtil.getCSSFile(biLocale) %>" type="text/css">
   <%=fHeader%>

   <title><%=biNLS.get("marketplaceActivityDistributor")%></title>
   <script src="/wcs/javascript/tools/common/Util.js"></script>
   <script src="/wcs/javascript/tools/common/DateUtil.js"></script>
   <script src="/wcs/javascript/tools/common/SwapList.js"></script>
   <script src="/wcs/javascript/tools/reporting/ReportHelpers.js"></script>
   <script>

      ///////////////////////////////////////////////////////////////////////////////////////////////////////
      // Call the initialize routines for the various elements of the page
      ///////////////////////////////////////////////////////////////////////////////////////////////////////
      function initializeValues()
      {
         //onLoadStartDateEndDate("enquiryPeriod");
                ResetValues();
                onLoadStatOption("myHelperMarketplaceActivityDistributor");
                if (parent.setContentFrameLoaded) parent.setContentFrameLoaded(true);
      }


      ///////////////////////////////////////////////////////////////////////////////////////////////////////
      // Call the save routines for the various elements of the page
      ///////////////////////////////////////////////////////////////////////////////////////////////////////
       function savePanelData()
      {

                saveStatOption("myHelperMarketplaceActivityDistributor");
		setReportFrameworkOutputView("DialogView");
		setReportFrameworkParameter("XMLFile","bi.biMarketplaceActivityDistributorReportOutputDialog");
		setReportFrameworkReportXML("bi.biMarketplaceActivityDistributorReport");

		if (document.forms["myHelperMarketplaceActivityDistributor"].rbsort[0].checked) {
			setReportFrameworkParameter("sortOrder","DESC");
		} else {
			setReportFrameworkParameter("sortOrder","ASC");
		}

		if (document.forms["myHelperMarketplaceActivityDistributor"].rbname[0].checked) {
			setReportFrameworkParameter("sortBy","11");
		} else if (document.forms["myHelperMarketplaceActivityDistributor"].rbname[1].checked) {
			setReportFrameworkParameter("sortBy","7");
		}  

		setReportFrameworkReportName("biMarketplaceActivityDistributorReport");

		if (document.all.time.selectedIndex != 0) {
			var startDate = getPreselectedStartDate(document.all.time.value);
			var endDate = getPreselectedEndDate(document.all.time.value);

			setReportFrameworkParameter("StartDate", startDate);
		 	setReportFrameworkParameter("EndDate", endDate);
		} else {
			saveStartDateEndDate("enquiryPeriod");
			setEndDate();
		 	setReportFrameworkParameter("StartDate", returnStartDateAsTimestamp("enquiryPeriod"));
			setReportFrameworkParameter("EndDate", returnEndDateAsTimestamp("enquiryPeriod"));
		}
	 	setReportFrameworkParameter("ReportType", "UserInput");
        saveReportFramework();
        top.saveModel(parent.model);
        return true;

      }

      ///////////////////////////////////////////////////////////////////////////////////////////////////////
      // Call the validate routines for the various elements of the page
      ///////////////////////////////////////////////////////////////////////////////////////////////////////
       function validatePanelData()
      {
        if(document.all.time.selectedIndex != 0 &&
                (document.enquiryPeriod.StartDateEndDateHelperYearSD.value != "" ||
                     document.enquiryPeriod.StartDateEndDateHelperMonthSD.value != "" || document.enquiryPeriod.StartDateEndDateHelperDaySD.value != "" ))
              {
                     parent.alertDialog("<%=UIUtil.toJavaScript(biNLS.get("SelectAnyOneOption"))%>");
                     ResetValues();
                     return false;

                }
               if(document.all.time.selectedIndex == 0)
               {
                      if (validateStartDateEndDate("enquiryPeriod") == false) return false;
               }
         return true;
      }



function ResetValues()
       {
              document.enquiryPeriod.StartDateEndDateHelperYearSD.value = "";
              document.enquiryPeriod.StartDateEndDateHelperMonthSD.value = "";
              document.enquiryPeriod.StartDateEndDateHelperDaySD.value = "";
              document.enquiryPeriod.StartDateEndDateHelperYearED.value = "";
              document.enquiryPeriod.StartDateEndDateHelperMonthED.value = "";
              document.enquiryPeriod.StartDateEndDateHelperDayED.value = "";
              document.all.time.selectedIndex = 0;
       }

       function setEndDate()
       {
             if((document.enquiryPeriod.StartDateEndDateHelperYearSD.value != "" &&
                     document.enquiryPeriod.StartDateEndDateHelperMonthSD.value != "" && document.enquiryPeriod.StartDateEndDateHelperDaySD.value != "" ) &&
                       (document.enquiryPeriod.StartDateEndDateHelperYearED.value == "" &&
                     document.enquiryPeriod.StartDateEndDateHelperMonthED.value == "" && document.enquiryPeriod.StartDateEndDateHelperDayED.value == "" ))
              {

                            parent.alertDialog("<%=UIUtil.toJavaScript(biNLS.get("EndDateIsCurrentDate"))%>");
                            document.enquiryPeriod.StartDateEndDateHelperYearED.value = getCurrentYear();
                            document.enquiryPeriod.StartDateEndDateHelperMonthED.value = getCurrentMonth();
                            document.enquiryPeriod.StartDateEndDateHelperDayED.value = getCurrentDay();
              }

       }
///////////////////////////////////////////////////////////////////////////////////////////////////////
   // Validate is done by the HTML radio button
   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   function validateStatOption(container)
   {
      return true;
   }

   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   // initialize function for the status dates
   ///////////////////////////////////////////////////////////////////////////////////////////////////////
     
   function onLoadStatOption(container)
   {

                   var myContainer = parent.get(container, null);
           
         // If this is the first time set it to the default.                  
      if (myContainer == null) {
                     myContainer = new Object();
       
                     myContainer.StatusChosen = 1;
                     
                     with (document.forms[container]) {
                            rbname[0].checked = true;
                            rbsort[0].checked = true;
                     }
                     parent.put(container, myContainer);
                     return;             
      } else {
                    // If it is not the first time set it to the last selected.
                     if(myContainer.StatusChosen == 4){
                            document.forms[container].rbname[1].checked = true;
                            document.forms[container].rbsort[1].checked = true;
                     }               
                      else if(myContainer.StatusChosen == 3){
                            document.forms[container].rbname[1].checked = true;
                            document.forms[container].rbsort[0].checked = true;
                     } 
                      else if(myContainer.StatusChosen == 2){
                            document.forms[container].rbname[0].checked = true;
                            document.forms[container].rbsort[1].checked = true;
                     } 
                      else {
                            document.forms[container].rbname[0].checked = true;
                            document.forms[container].rbsort[0].checked = true;
                     }
                     parent.put(container, myContainer);
                    return;
      }
   }
   
   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   // save function for the Staus selected
   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   function saveStatOption(container)
   {

          
      myContainer = parent.get(container,null);
      if (myContainer == null) return;

      with (document.forms[container]) {
                
                   if (rbname[1].checked){
                            if(rbsort[1].checked)
                                   myContainer.StatusChosen = 4;
                             else
                                   myContainer.StatusChosen = 3;
                     }
                      else{
                            if(rbsort[1].checked)
                                   myContainer.StatusChosen = 2;
                             else
                                   myContainer.StatusChosen = 1;
                     }
      }
      parent.put(container, myContainer);
   }

   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   // Return the Status Chosen
   ///////////////////////////////////////////////////////////////////////////////////////////////////////  
   function returnStatOptionDOrganization(container) {
      return document.forms[container].rbname[0].checked;
   }

   function returnStatOptionOVTransferred(container) {
      return document.forms[container].rbname[1].checked;
   }
   

 ///////////////////////////////////////////////////////////////////////////////////////////////////////
   // Return the Orderby Status Chosen
   ///////////////////////////////////////////////////////////////////////////////////////////////////////  
    function returnOrderbyDesc(container) {
      return document.forms[container].rbsort[0].checked;
   }

    function returnOrderbyAsc(container) {
      return document.forms[container].rbsort[1].checked;
   }



</SCRIPT>
</HEAD>

<BODY ONLOAD="initializeValues()" CLASS=content>

   <h1><%=biNLS.get("marketplaceActivityDistributor") %></h1>
   <%=biNLS.get("marketplaceActivityDistributorDescription") %>
   <p>

<table border="0" bordercolor="black" CELLPADDING="0" CELLSPACING="0" width="400">
<tr>
       <td>
       <DIV ID=pageBody STYLE="display: block; margin-left: 0">
      <form>
	  <label for="time"><%=biNLS.get("labelTimePeriod")%></label><br>
             <select id="time">
                    <option value="pleaseSelect" selected><%=biNLS.get("pleaseSelect")%></option>
                    <option value="Yesterday"><%=biNLS.get("yesterdayTitle")%></option>
                    <option value="Weekly"><%=biNLS.get("thisWeekTitle")%></option>
                    <option value="Monthly"><%=biNLS.get("thisMonthTitle")%></option>
                    <option value="Quarterly"><%=biNLS.get("thisQuarterTitle")%></option>
                    <option value="Yearly"><%=biNLS.get("thisYearTitle")%></option>
             </select>
      </form>
   </DIV>

  <DIV ID=pageBody STYLE="display: block; margin-left: 50">
  <B><%=biNLS.get("or")%></B>
  </DIV>
  <DIV ID=pageBody STYLE="display: block; margin-left: 0">
      <%=generateStartDateEndDate("enquiryPeriod", biNLS, null)%>
   </DIV>

       </td>
</tr>
</table>

<br>
<table border="0" bordercolor="black" CELLPADDING="0" CELLSPACING="0">
       <tr>

              <td>
              <table border="0" bordercolor="black" CELLPADDING="0" CELLSPACING="0" width="210">
              <tr>
                     <td align="left">
                            <B><%=biNLS.get("sortby")%></B>
                     </td>
              </tr>
              </table>
              </td>

              <td>
              <table border="0" bordercolor="black" CELLPADDING="0" CELLSPACING="0" width="210">
              <tr>
                     <td align="left">
                       <B><%=biNLS.get("orderby")%></B>
                     </td>
              </tr>
              </table>
              </td>

              </tr>
</table>
<DIV ID=pageBody STYLE="display: block; margin-center:5">
              
 <FORM NAME=myHelperMarketplaceActivityDistributor>
         <TABLE border=0 bordercolor=red CELLPADDING=0 CELLSPACING=0 width=400> 
               <TR>

               <TD ALIGN=left VALIGN=TOP>                                                                                              
                <TABLE border=0 bordercolor=black CELLPADDING=0 CELLSPACING=0 width=200>
                 <TR HEIGHT=5>
                  <TD ALIGN=left VALIGN=TOP>
                    <INPUT TYPE=RADIO NAME=rbname VALUE=All id=s1>
				<label for= s1>
                             <%= biNLS.get("distributorOrg") %>
			      </label>
                    </INPUT>
                    <BR>
                    <BR>
                    <INPUT TYPE=RADIO NAME=rbname VALUE=PayA id=s2>
				<label for= s2>	
                             <%= biNLS.get("ovTransferred") %>
                        </label> 
                    </INPUT>
                    <BR>                                                     
                  </TD>
                </TR>
           </TABLE>
         </TD>

      <TD>&nbsp;</TD>

      <TD ALIGN=left VALIGN=TOP>
      <TABLE border=0 bordercolor=black CELLPADDING=0 CELLSPACING=0 width=200>
           <TR HEIGHT=5>
              <TD ALIGN=left VALIGN=TOP>
                  <INPUT TYPE=RADIO  NAME=rbsort VALUE=All id=ord1>
				<label for= ord1>
				    <%= biNLS.get("descend") %>
				</label>
			</INPUT>
                  <BR>
			<BR>
			<INPUT TYPE=RADIO NAME=rbsort VALUE=PayA id=ord2>
				<label for= ord2>
				     <%= biNLS.get("ascend") %>
                        </label>
			</INPUT>
                  <BR>                                                                 
               </TD>
            </TR>
       </TABLE>
     </TD>
    </TR>
   </TABLE>
  </FORM>
 


</DIV>


</BODY>
</HTML>