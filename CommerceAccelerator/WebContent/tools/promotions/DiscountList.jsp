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
<%@ page import="com.ibm.commerce.utils.*" %>
<%@ page import="com.ibm.commerce.command.CommandContext" %>

<%@ page import="com.ibm.commerce.tools.common.ui.taglibs.*" %>
<%@ page import="com.ibm.commerce.tools.common.ui.*" %>

<%@ page import="javax.servlet.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.*" %>
<%@ page import="java.lang.reflect.*" %>

<%@ page import="com.ibm.commerce.tools.util.UIUtil" %> 

<%@include file="../common/common.jsp" %>

<!-- Get user bean -->
<%
    try{
         CommandContext cmdContext = (CommandContext)request.getAttribute(com.ibm.commerce.server.ECConstants.EC_COMMANDCONTEXT);
         Locale jLocale = cmdContext.getLocale();

         String xmlfile = request.getParameter("ActionXMLFile");
         Hashtable actionXML = (Hashtable)ResourceDirectory.lookup(xmlfile); 
	   Hashtable action = (Hashtable)actionXML.get("action");
	   String beanClass = (String)action.get("beanClass");
         String resourcefile = (String)action.get("resourceBundle");

         Class clazz = Class.forName(beanClass);
         SimpleDynamicListBean simpleList = (SimpleDynamicListBean)clazz.newInstance();

         Hashtable NLSfile = (Hashtable) ResourceDirectory.lookup(resourcefile, jLocale); 
         String jStoreID = cmdContext.getStoreId().toString();
         String jLanguageID = cmdContext.getLanguageId().toString();

         simpleList.setParm("storeID",jStoreID);
         simpleList.setParm("languageID",jLanguageID);

         Hashtable parms = (Hashtable)action.get("parameter");
         for (Enumeration p=parms.keys(); p.hasMoreElements();) {
             String para = (String)p.nextElement();
             String tmpValue = request.getParameter(para);
             if(tmpValue !=null )
                simpleList.setParm(para,tmpValue);
         }
         simpleList.setParm("startindex","0");
         simpleList.setParm("endindex","0");

         com.ibm.commerce.beans.DataBeanManager.activate((com.ibm.commerce.beans.DataBean)simpleList, request);
%>
         <!-- user javascript function include here -->
<%
         Vector jsFiles = Util.convertToVector(action.get("jsFile"));
         if (jsFiles != null)
	   {
		// loop over all jsFiles
		for (Enumeration jsFile = jsFiles.elements(); jsFile.hasMoreElements();)
		{
			Hashtable javaScriptFile = (Hashtable) jsFile.nextElement();

			// get src for jsFile
			String jsSRC = (String) javaScriptFile.get("src");
			if (jsSRC != null)
			{
%>
           <script src="<%= jsSRC %>">
</script>
<%
			}
		}
         }
%>

           <%= fHeader %>
           <link rel="stylesheet" href="<%= UIUtil.getCSSFile(jLocale) %>" type="text/css" />
<%
         Hashtable scrollcontrol = (Hashtable) action.get("scrollcontrol");
	   if (scrollcontrol != null){
	       String title = (String) scrollcontrol.get("title");
%>
           <title><%= UIUtil.toHTML((String)NLSfile.get(title)) %></title>
<%
	   }
%>
           <script language="JavaScript">
           function create() {
              top.setContent('<%= UIUtil.toJavaScript((String)NLSfile.get("createDiscount")) %>','/webapp/wcs/tools/servlet/WizardView?XMLFile=discount.discountWizard',true);
           }
           
           function detail() {
              top.setContent('<%= UIUtil.toJavaScript((String)NLSfile.get("discountDetail")) %>','/webapp/wcs/tools/servlet/DialogView?XMLFile=discount.discountDetails&amp;calcodeId=' + parent.getSelected(),true);
           }
           
           function remove() {
              if (parent.confirmDialog('<%= UIUtil.toJavaScript((String)NLSfile.get("DiscountDeleteMsg")) %>'))
                top.showContent('/webapp/wcs/tools/servlet/DiscountPublish?calcodeId='+ parent.getSelected() +'&amp;status=2')
           }

           
</script>
           <script src="/wcs/javascript/tools/common/dynamiclist.js">
</script>
           </head>

           <body class="content_list">

           <script> parent.loadFrames()
</script>
           <script>
                   var storeID = "<%= jStoreID %>";
                   var languageID = "<%= jLanguageID %>";

                   function getLang() {
                       return languageID;
                   }
        
                   function getStore() {
                       return storeID;
                   }

                   function getResultsSize(){
                       return <%=simpleList.getListSize()%>;
                   }

                   <%=simpleList.getUserJSfnc(NLSfile)%>

           
</script>

           <%
              int startIndex = Integer.parseInt(request.getParameter("startindex"));
              int listSize = Integer.parseInt(request.getParameter("listsize"));
              int endIndex = startIndex + listSize;
              int rowselect = 1;
              int totalsize = simpleList.getListSize();
              int totalpage = totalsize/listSize;
           %>
           <%=comm.addControlPanel(xmlfile,totalpage,totalsize,jLocale)%>
           <form name='<%=(String)action.get("formName")%>'>
              <%= comm.startDlistTable((String)NLSfile.get("accessProducts")) %>
              <%= comm.startDlistRowHeading() %>
              <%= comm.addDlistCheckHeading() %>
           <%
              String[][] tmp = simpleList.getHeadings();
              String orderByParm = request.getParameter("orderby");

              for(int i=0; i<tmp.length; i++){
           %>
                  <%= comm.addDlistColumnHeading((String)NLSfile.get(tmp[i][0]),tmp[i][1],orderByParm.equals(tmp[i][1])) %>
           <%
              }
           %>
              <%= comm.endDlistRow() %>

           <%
              if (endIndex > simpleList.getListSize()) {
                  endIndex = simpleList.getListSize();
              }

              int indexFrom = startIndex;
              for (int i = indexFrom; i < endIndex; i++)
              {
           %>
                 <%= comm.startDlistRow(rowselect) %>
                 <%= comm.addDlistCheck(simpleList.getCheckBoxName(i),"none") %>
           <%
                 String[] tmpcol = simpleList.getColumns(i);
           %>
                 <%= comm.addDlistColumn( tmpcol[0], simpleList.getDefaultAction(i),(String)NLSfile.get(tmp[0][0]) ) %>
                 <%= comm.addDlistColumn( (String)NLSfile.get(tmpcol[1]), "none") %>
                 <%= comm.addDlistColumn( TimestampHelper.getDateTimeFromTimestamp(Timestamp.valueOf(tmpcol[2]),jLocale), "none") %>
           <%
                 if (tmpcol[3]==null || tmpcol[3].equals("")) {
           %>
                 <%= comm.addDlistColumn( (String)NLSfile.get("neverExpire"), "none") %>                 
           <%
                 } else {
           %>
                 <%= comm.addDlistColumn( TimestampHelper.getDateTimeFromTimestamp(Timestamp.valueOf(tmpcol[3]),jLocale), "none") %>
           <%
                 }
           %>
                 <%= comm.addDlistColumn( tmpcol[4], "none", (String)NLSfile.get(tmp[4][0])) %>
                 <%= comm.endDlistRow() %>
           <%
                 if(rowselect==1){
                    rowselect = 2;
                 }else{
                    rowselect = 1;
                 }
              }
           %>
<%
    } catch (Exception e)	{
         com.ibm.commerce.exception.ExceptionHandler.displayJspException(request, response, e);
    }
%>
           </form>
           <script>
           <!--
             parent.afterLoads();
             parent.setResultssize(getResultsSize());
           //-->
           
</script>

         </body>
         </html>


