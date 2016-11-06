<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2000, 2009 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@include file="../common/common.jsp" %>

<%@page import="com.ibm.commerce.beans.DataBeanManager" %>
<%@page import="com.ibm.commerce.tools.util.ResourceDirectory" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>
<%@ page import="com.ibm.commerce.server.ECConstants" %>
<%@page import="com.ibm.commerce.tools.xml.*" %>
<%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
<%@page import="com.ibm.commerce.tools.util.*" %>
<%@page import="com.ibm.commerce.exception.*" %>
<%@page import="com.ibm.commerce.server.*" %>
<%@page import="com.ibm.commerce.command.*" %>

<%@ page import="com.ibm.commerce.scheduler.beans.*" %>

<jsp:useBean id="urlItems" scope="request" class="com.ibm.commerce.scheduler.beans.UrlRegistryItemsDataBean">
</jsp:useBean>
<jsp:useBean id="schedulerItems" scope="request" class="com.ibm.commerce.scheduler.beans.SchedulerItemsDataBean">
</jsp:useBean>
<jsp:useBean id="appTypeItems" scope="request" class="com.ibm.commerce.scheduler.beans.ApplicationTypeDataBean">
</jsp:useBean>
<jsp:useBean id="schCmdItems" scope="request" class="com.ibm.commerce.scheduler.beans.SchedulerCommandsDataBean">
</jsp:useBean>


<%
  String webalias = UIUtil.getWebPrefix(request);
  String calendarText = new String("");
  Integer store_id = null;
  Hashtable schedulerNLS = null;
  Hashtable adminconsoleNLS = null;
  CommandContext cmdContext  = (CommandContext)request.getAttribute(ECConstants.EC_COMMANDCONTEXT);
  store_id = cmdContext.getStoreId();
  String add_job_result_page = request.getParameter("RESULTPAGE");
  if (add_job_result_page == null ) add_job_result_page = "";
  String jobId = request.getParameter("jobId");
  if (jobId == null) jobId = "";
  String pathInfo =  request.getParameter("pathInfo");
  if (pathInfo == null) pathInfo = "";
  String queryString =  request.getParameter("queryString");
  if (queryString == null) queryString = "";
  String start =  request.getParameter("start");
  if (start == null) start = "";
  String host =  request.getParameter("host");
  if (host == null) host = "";
  String interval =  request.getParameter("interval");
  if (interval == null) interval = "";
  String attempts =  request.getParameter("attempts");
  if (attempts == null) attempts = "";
  String delay =  request.getParameter("delay");
  if (delay == null) delay = "";
  String policy =  request.getParameter("schedulerPolicy");
  if (policy == null) policy = "";
  String priority =  request.getParameter("priority");
  if (priority == null) priority = "";
  String applicationType =  request.getParameter("applicationType");
  if (applicationType == null) applicationType = "";
  String name =  request.getParameter("name");
  if (name == null) name = "";
  String interfaceName = new String("");
  
  String startYear = request.getParameter("startYear");
  if (startYear == null) startYear = "";
  String startMonth = request.getParameter("startMonth");
  if (startMonth == null) startMonth = "";
  String startDay = request.getParameter("startDay");
  if (startDay == null) startDay = "";
  String startTime = request.getParameter("startTime");
  if (startTime == null) startTime = "";

   try {
      // obtain the resource bundle for display
      calendarText = (String)((Hashtable)ResourceDirectory.lookup("campaigns.campaignsRB", cmdContext.getLocale())).get("calendarTool");
      schedulerNLS = (Hashtable)ResourceDirectory.lookup("adminconsole.SchedulerNLS", cmdContext.getLocale());
      adminconsoleNLS = (Hashtable)ResourceDirectory.lookup("adminconsole.AdminConsoleNLS", cmdContext.getLocale());
      if (jobId != null && !jobId.equals("") & add_job_result_page.equals("")) {
          schedulerItems.setJobRefNum(jobId);
          DataBeanManager.activate(schedulerItems, request);
          if (pathInfo.equals("")) pathInfo = schedulerItems.getPathInfo(0);
          if (queryString.equals("")) queryString = schedulerItems.getQueryString(0);
          if (start.equals("")) start = schedulerItems.getStart(0);
          if (host.equals("")) host = schedulerItems.getHost(0);
          if (interval.equals("")) interval = schedulerItems.getInterval(0);
          if (attempts.equals("")) attempts = schedulerItems.getAttempts(0);
          if (delay.equals("")) delay = schedulerItems.getDelay(0);
          if (policy.equals("")) policy = schedulerItems.getSequence(0);
          if (priority.equals("")) priority = schedulerItems.getPriority(0);
          if (applicationType.equals("")) applicationType = schedulerItems.getApplicationType(0);
          if (name.equals("")) name = schedulerItems.getUserReferenceNumber(0);
          interfaceName = schedulerItems.getInterfaceName(0);
                    
      } 
      
      	if (jobId != null && !jobId.equals("") && pathInfo != null && !pathInfo.equals("")) schCmdItems.setSchedulerCommand(pathInfo);
      	DataBeanManager.activate(schCmdItems, request);      
      
      // if the start is invalid, they will have to enter it.
      try {      
      	if (start != null && !start.equals("")) {
          Timestamp sTIME = Timestamp.valueOf(start);
          startYear = new String(""+(1900 + sTIME.getYear()));
          startMonth = new String(""+(sTIME.getMonth()+1));
          startDay = new String(""+sTIME.getDate());
          
          if (sTIME.getHours() < 10)
  	 	startTime = "0" + sTIME.getHours();
  	  else
  	 	startTime = "" + sTIME.getHours();
  	 	
  	  if (sTIME.getMinutes() < 10)
  	 	startTime = startTime + ":0" + sTIME.getMinutes();
  	  else
  	 	startTime = startTime + ":" + sTIME.getMinutes();          
      	}
      } catch (Exception e) {}
      
      DataBeanManager.activate(appTypeItems, request);
   } catch (ECSystemException ecSysEx) {
    ExceptionHandler.displayJspException(request, response, ecSysEx);
   } catch (Exception exc) {
    //ECSystemException ecSysEx = new ECSystemException(null,exc.getMessage(),null);
    ExceptionHandler.displayJspException(request, response, exc);
   }

%>

<HTML>
<HEAD>
<%= fHeader %>
<link rel=stylesheet href="<%= com.ibm.commerce.tools.util.UIUtil.getCSSFile(cmdContext.getLocale()) %>" type="text/css"> 
<TITLE><%= (jobId != null && !jobId.equals("")) ? schedulerNLS.get("schedulerEditTitle") : schedulerNLS.get("schedulerAddTitle") %></TITLE>
<SCRIPT SRC="<%=webalias%>javascript/tools/common/DateUtil.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript">
<!---- //hide script from old browsers
       //


	var schCmds = new Array();
<%
for (int i = 0; i < schCmdItems.size(); i++) {

%>
	schCmds[<%=i%>] = new Array();
<%	
	Vector chkCmds = schCmdItems.getCheckCommandInfo(i);
	for (int j=0 ; j < chkCmds.size(); j++) {
	
		Hashtable chkItem = (Hashtable)chkCmds.elementAt(j);
%>		
		schCmds[<%=i%>][<%=j%>] = new Array();		
		schCmds[<%=i%>][<%=j%>][0] = <%= chkItem.get("CHKCMD_ID") %>;
		schCmds[<%=i%>][<%=j%>][1] = '<%= UIUtil.toJavaScript(((schedulerNLS.get("schedulerCheckCmd_"+chkItem.get("CHKCMD_DISPLAYNAME")) != null) ? schedulerNLS.get("schedulerCheckCmd_"+chkItem.get("CHKCMD_DISPLAYNAME")) : chkItem.get("CHKCMD_DISPLAYNAME"))) %>';
		schCmds[<%=i%>][<%=j%>][2] = '<%= UIUtil.toJavaScript(chkItem.get("CHKCMD_INTERFACENAME")) %>';	
<%		
	}	
}
%>
	
	function populateCheckCommands(pathInfo) {
				
		var defaultVal = '<%= UIUtil.toJavaScript(interfaceName) %>';
		
		if (document.schedulerForm.pathInfo.value == '') return;
		
		document.schedulerForm.displayCheckCmdId.selectedIndex = 0;
		document.schedulerForm.displayCheckCmdId.length = 1;
						
		var schCmdSelected = document.schedulerForm.pathInfo.selectedIndex;
		
		var firstOption = new Option();
		document.schedulerForm.displayCheckCmdId.options[0] = firstOption;
		document.schedulerForm.displayCheckCmdId.options[0].selected = true;
		
		for ( i = 0; i < schCmds[schCmdSelected].length; i++ ) {
			var newOption = new Option(schCmds[schCmdSelected][i][1]);
			document.schedulerForm.displayCheckCmdId.options[i] = newOption;
			if(schCmds[schCmdSelected][i][2] == defaultVal) 
				document.schedulerForm.displayCheckCmdId.options[i].selected = true;
		}
		
		
	}


      function lengthValidation( param, length ) {
          if (!parent.isValidUTF8length(param.value, length)) {
               param.focus();
               param.select();
               alertDialog('<%=UIUtil.toJavaScript(adminconsoleNLS.get("AdminConsoleExceedMaxLength"))%>');
               return false;
          }
          return true;
      }      
       
    function validatePanelData() {

          // building the URL
          <%= (jobId != null && !jobId.equals("")) ? "var url = 'EditJob?URL=MsgMessagingSystemResponseView&ERR_COM=MsgMessagingSystemResponseView&jobId="+jobId+"';" : "var url = 'AddJob?URL=MsgMessagingSystemResponseView&ERR_COM=MsgMessagingSystemResponseView';" %>
          var params = '';
          var pathInfo = '';
          var start = '';

	  start = schedulerForm.startYear.value + ":" +  schedulerForm.startMonth.value + ":" + schedulerForm.startDay.value + ":" + schedulerForm.startTime.value + ":00";

          // commands that must be specified
          if (schedulerForm.pathInfo.value == '') {
               alertDialog('<%= UIUtil.toJavaScript((String)schedulerNLS.get("schedulerPathInfoMissing")) %>');
               return false;
          } else {
               pathInfo = '&pathInfo=' + schedulerForm.pathInfo.value
          }
          if (schedulerForm.startTime.value == '') {
               alertDialog('<%= UIUtil.toJavaScript((String)schedulerNLS.get("schedulerStartMissing")) %>');
               return false;
          } else {
          	document.schedulerForm.start.value = start;
                start = '&start=' + start;
          }

          // store id
          params = params + '&storeId=<%=store_id%>';
          
          // optional parameters
          if (schedulerForm.name.value != '') params = params + '&name=' + escape(schedulerForm.name.value);
          
          if (schedulerForm.queryString.value != '') {
          	if (lengthValidation(schedulerForm.queryString, 1000)) {
          		params = params + '&queryString=' + escape(schedulerForm.queryString.value);
          	}
          	else {
          		return false;
          	}
          }
          
          if (schedulerForm.host.value != '') {
          	if (lengthValidation(schedulerForm.host, 128)) {
          		params = params + '&host=' + escape(schedulerForm.host.value);
          	}
          	else {
          		return false;
          	}
          }
          
          if (schedulerForm.interval.value != '') {
          	if(isValidPositiveInteger(schedulerForm.interval.value)) { 
          		if(schedulerForm.applicationType.value == '<%= ECConstants.EC_SCHED_BROADCAST %>'  && schedulerForm.interval.value > 0) {
           			schedulerForm.interval.focus();
          			schedulerForm.interval.select();
          			alertDialog('<%=UIUtil.toJavaScript(schedulerNLS.get("schedulerBroadcastIntervalWarning"))%>') ;
          			return false;
          		}
          	
          		params = params + '&interval=' + schedulerForm.interval.value;
          	}
          	else {           		
          		schedulerForm.interval.focus();
          		schedulerForm.interval.select();
          		alertDialog('<%=UIUtil.toJavaScript(schedulerNLS.get("schedulerIncorrectIntervalValue"))%>');
          		return false;
          	}
          }
          
          if (schedulerForm.attempts.value != '') {
          	if(isValidPositiveInteger(schedulerForm.attempts.value)) {
          		if(schedulerForm.applicationType.value == '<%= ECConstants.EC_SCHED_BROADCAST %>' && schedulerForm.attempts.value > 0) {
          			schedulerForm.attempts.focus();
          			schedulerForm.attempts.select();
          			alertDialog('<%=UIUtil.toJavaScript(schedulerNLS.get("schedulerBroadcastAttemptsWarning"))%>') ;
          			return false;
          		}
          		params = params + '&attempts=' + schedulerForm.attempts.value;
          	}
          	else {
          		schedulerForm.attempts.focus();
          		schedulerForm.attempts.select();
          		alertDialog('<%=UIUtil.toJavaScript(schedulerNLS.get("schedulerIncorrectAttemptsValue"))%>');
          		return false;          
          	}
          }
          
          if (schedulerForm.delay.value != '') {
          	if(isValidPositiveInteger(schedulerForm.delay.value)) { 
          		if(schedulerForm.applicationType.value == '<%= ECConstants.EC_SCHED_BROADCAST %>' && schedulerForm.delay.value > 0) {
          			schedulerForm.delay.focus();
          			schedulerForm.delay.select();
          			alertDialog('<%=UIUtil.toJavaScript(schedulerNLS.get("schedulerBroadcastDelayWarning"))%>') ;
          			return false;
          		}
          		params = params + '&delay=' + schedulerForm.delay.value; 
          	} else {
          		schedulerForm.delay.focus();
          		schedulerForm.delay.select();
          		alertDialog('<%=UIUtil.toJavaScript(schedulerNLS.get("schedulerIncorrectRetriesValue"))%>');
          		return false;
          	}
          }
          
          if (schedulerForm.applicationType.value != '') {
          	params = params + '&applicationType=' + schedulerForm.applicationType.value;
          }

	  if(schedulerForm.schedulerPolicy.value != '') {
  		params = params + '&schedulerPolicy=' + schedulerForm.schedulerPolicy.value;
  	}
	  
  	if(schedulerForm.priority.value != '') {
  		params = params + '&priority=' + schedulerForm.priority.value;
  	}
	  
	  var checkIndex = document.schedulerForm.displayCheckCmdId.selectedIndex;
	  var cmdIndex = document.schedulerForm.pathInfo.selectedIndex;	  
	  params = params + '&checkCmdId=' + schCmds[cmdIndex][checkIndex][0];
	  document.schedulerForm.checkCmdId.value = schCmds[cmdIndex][checkIndex][0];
		
          //location.href = url + pathInfo + start + params;
          
          document.schedulerForm.submit();
    }
    
    function setupDate1() {
    	window.yearField = document.schedulerForm.startYear;
    	window.monthField = document.schedulerForm.startMonth;
    	window.dayField = document.schedulerForm.startDay;
    }

    function onLoad() {
       if (parent.setContentFrameLoaded)
       {

<% 
	if("YES".equals(add_job_result_page)) {
	
		com.ibm.commerce.beans.ErrorDataBean errorBean = new com.ibm.commerce.beans.ErrorDataBean();
  		com.ibm.commerce.beans.DataBeanManager.activate (errorBean, request);  
	
		if (errorBean.getMessage() != null && ((String)errorBean.getMessage()).length() > 0) {
%>  		
  			alertDialog('<%= UIUtil.toJavaScript((String)errorBean.getMessage() ) %>');
<%		
		} else {
%>
			top.goBack();
<%		
		}
	}  
%>       
          parent.setContentFrameLoaded(true);
       }
    }

// -->
</script>

<SCRIPT SRC="<%=webalias%>javascript/tools/common/Util.js"></SCRIPT>

</HEAD>
<BODY ONLOAD="onLoad()" class="content">
<SCRIPT FOR=document EVENT="onclick()">
document.all.CalFrame.style.display="none";
</SCRIPT>

<script>
document.writeln('<iframe name="calendar" title="' + top.calendarTitle + '" style="display:none;position:absolute;width:198;height:230;z-index=100" ID="CalFrame" marginheight=0 marginwidth=0 noresize frameborder=0 scrolling=no src="Calendar"></iframe>');
</script>

<FORM NAME="schedulerForm" METHOD="POST" ACTION="<%= (jobId != null && !jobId.equals("")) ? "EditJob" : "AddJob" %>">
<% if (jobId != null && !jobId.equals("")) { %>
	<input type="hidden" name="jobId" value="<%=jobId%>">
<% } %>
<input type="hidden" name="RESULTPAGE" value="YES">
<input type="hidden" name="URL" value="MsgMessagingSystemResponseView">
<input type="hidden" name="ERR_COM" value="StoreSchedulerAddView">
<input type="hidden" name="start" value="00:00:00">
<input type="hidden" name="langId" value="<%=cmdContext.getPreferredLanguage()%>">
<H1><%= (jobId != null && !jobId.equals("")) ? schedulerNLS.get("schedulerEditTitle") : schedulerNLS.get("schedulerAddTitle")  %></H1>
<TABLE>
     <TR><TD><LABEL for="S1"><%= schedulerNLS.get("schedulerPathInfoCaption") %></LABEL></TD></TR>
     <TR><TD>

               <select name="pathInfo" id="S1" onChange="populateCheckCommands(this)">
<%

          for (int i=0; i < schCmdItems.size(); i++) {
         	String isSELECTED = "";
          	if (schCmdItems.getSchedulerCommand(i).equals(pathInfo)) isSELECTED = "SELECTED";
               out.println("<option value='" + schCmdItems.getSchedulerCommand(i) + "' " + isSELECTED + ">");
               out.println(schCmdItems.getSchedulerCommand(i));
               out.println("</option>");
          }
%>
          </select>
          </TD></TR>
     <TR><TD><LABEL for="S2"><%= schedulerNLS.get("schedulerQueryStringCaption") %></LABEL></TD></TR>
     <TR><TD><INPUT NAME="queryString" SIZE="40" id="S2" VALUE="<%= queryString %>"></TD></TR>

     <TR><TD>
     <TABLE>
     <TR><TD>&nbsp;</TD>
     	 <TD><%= schedulerNLS.get("schedulerYear") %></TD>
     	 <TD><%= schedulerNLS.get("schedulerMonth") %></TD>
     	 <TD><%= schedulerNLS.get("schedulerDay") %></TD>
     	 <TD></TD><TD></TD><TD></TD></TR>     
     <TR><TD><LABEL for="S2"><%= schedulerNLS.get("schedulerStartCaption") %></LABEL></TD>
     	<TD><INPUT NAME="startYear" VALUE="<%= startYear %>" maxlength="4" size="4" id="S2"></TD>
     <TD><INPUT NAME="startMonth" VALUE="<%= startMonth %>" maxlength="2" size="2" id="S2"></TD>
     <TD><INPUT NAME="startDay" VALUE="<%= startDay %>" maxlength="2" size="2" id="S2"></TD>
     <TD><A HREF="javascript:setupDate1();showCalendar(document.schedulerForm.calImg1)">
               <IMG SRC="<%=webalias%>images/tools/calendar/calendar.gif" BORDER="0" alt="<%=calendarText%>" id=calImg1></A>&nbsp;&nbsp;&nbsp;&nbsp;</TD>
     <TD><LABEL for="S3"><%= schedulerNLS.get("schedulerStartTime") %></LABEL></TD>
     <TD><INPUT NAME="startTime" VALUE="<%= startTime %>" maxlength="5" size="5" id="S3"></TD></TR>     
     </TABLE>
     </TD></TR>     

     <TR><TD><LABEL for="S4"><%= schedulerNLS.get("schedulerNameCaption") %></LABEL></TD></TR>
     <TR><TD><INPUT NAME="name"  SIZE="40" id="S4" VALUE="<%= name %>"></TD></TR>    
     <TR><TD><LABEL for="S6"><%= schedulerNLS.get("schedulerHostCaption") %></LABEL></TD></TR>
     <TR><TD><INPUT NAME="host"  SIZE="40" id="S6" VALUE="<%= host %>"></TD></TR>
     
     <TR><TD><LABEL for="S7"><%= schedulerNLS.get("schedulerIntervalCaption") %></LABEL></TD></TR>
     <TR><TD><INPUT NAME="interval"  SIZE="10" id="S7" VALUE="<%= interval %>"></TD></TR>
     
     <TR><TD><LABEL for="S8"><%= schedulerNLS.get("schedulerAttemptsCaption") %></LABEL></TD></TR>
     <TR><TD><INPUT NAME="attempts"  SIZE="10" id="S8" VALUE="<%= attempts %>"></TD></TR>
     
     <TR><TD><LABEL for="S9"><%= schedulerNLS.get("schedulerDelayCaption") %></LABEL></TD>
     </TR>
     <TR><TD><INPUT NAME="delay"  SIZE="10" id="S9" VALUE="<%= delay %>"></TD></TR>
     
     <TR><TD><LABEL for="S10"><%= schedulerNLS.get("schedulerSchedulerPolicyCaption") %></LABEL></TD></TR>
     <TR><TD>
     <select name="schedulerPolicy" id="S10">
     	<option value="0" <%= (policy.equals("0") || policy.equals("")) ? "SELECTED" : "" %>><%= schedulerNLS.get("schedulerPolicyValue_0")%></option>
     	<option value="1" <%= (policy.equals("1")) ? "SELECTED" : "" %>><%= schedulerNLS.get("schedulerPolicyValue_1")%></option>
     </select>
     
     </TD></TR>
     
     <TR><TD><LABEL for="S11"><%= schedulerNLS.get("schedulerPriorityCaption") %></LABEL> <%=schedulerNLS.get("schedulerPriorityNote")%></TD></TR>
     <TR><TD><select name="priority" id="S11"><%
     
     if (priority.equals("")) priority = "" + java.lang.Thread.NORM_PRIORITY;
     
     for(int i=java.lang.Thread.MIN_PRIORITY; i <= java.lang.Thread.MAX_PRIORITY; i++) {
     
     %>
     <option VALUE="<%=i%>" <%= (priority.equals(""+i)) ? "SELECTED" : ""  %>><%=i%></option>
     <%
     
     }
     
     %></TD></TR>
     
     <TR><TD><LABEL for="S12"><%= schedulerNLS.get("schedulerApplicationTypeCaption") %></LABEL></TD></TR>
     
     <TR><TD><select NAME="applicationType" id="S12">
     		<option value=""></option>
     		
<%
	  String isSelected = "";
          for (int i=0; i < appTypeItems.size(); i++) {
            if (!appTypeItems.getApplicationType(i).equals(ECConstants.EC_SCHED_BROADCAST)) {           
               if (appTypeItems.getApplicationType(i).equals(applicationType)) {
                  isSelected = "SELECTED";
               } else {
                  isSelected = "";
               }
               out.println("<option value='" + appTypeItems.getApplicationType(i) + "' "  +  isSelected + ">");
               out.println(((schedulerNLS.get("schedulerAppType_"+appTypeItems.getApplicationType(i)) != null) ? schedulerNLS.get("schedulerAppType_"+appTypeItems.getApplicationType(i)) : appTypeItems.getApplicationType(i)));
               out.println("</option>");
            }
          }
%>     		
    	</select>
     </TD>
     
     <TR><TD><LABEL for="S13"><%= schedulerNLS.get("schedulerCheckCommandCaption") %></LABEL></TD></TR>
     <TR><TD><select NAME="displayCheckCmdId" id="S13">   
     	<option value=""><%= schedulerNLS.get("schedulerCheckCommandSelectPathInfo") %></option>
     		
	</select>
	<SCRIPT Language="JavaScript">
		populateCheckCommands(this);		
	</SCRIPT>
	<input type="hidden" name="checkCmdId" value="0">
     </TD></TR>


</TABLE>


</FORM>
</BODY>
</HTML>

