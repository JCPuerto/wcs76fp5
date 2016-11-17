<?xml version="1.0" encoding="ISO-8859-1" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="GENERATOR" content="IBM Software Development Platform" />

<!-- SECTION 1A -->

<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>

<!-- END OF SECTION 1A -->


<title>MyNewJSPTemplate.jsp</title>
</head>

<!-- SECTION 2 -->

<fmt:setLocale value="${CommandContext.locale}" />
<fmt:setBundle basename="${sdb.directory}/TutorialNLS" var="tutorial" />

<!-- END OF SECTION 2 -->

<body>
<p>Hello World!.</p>


<!-- SECTION 3 -->

<h1><fmt:message key="WebSphereCommerceInformation" bundle="${tutorial}" /> </h1>
 
<h2><fmt:message key="Tutorial" bundle="${tutorial}" /> </h2>

<!-- END OF SECTION 3 --> 



<!-- SECTION 4 -->

<h3><fmt:message key="ParametersFromCmd" bundle="${tutorial}" /> </h3>

<fmt:message key="ControllerParm1" bundle="${tutorial}" />
<c:out value="${controllerParm1}"/> <br />
 
<fmt:message key="ControllerParm2" bundle="${tutorial}" />
<c:out value="${controllerParm2}"/> <br /> <br />

<!-- END OF SECTION 4 --> 

  

<!-- SECTION 5 -->

<c:if test="${mndbInstance.calledByControllerCmd}">
   <fmt:message key="Example" bundle="${tutorial}" /> <br />
   <fmt:message key="CalledByControllerCmd" bundle="${tutorial}" /> <br />
   <fmt:message key="CalledByWhichControllerCmd" bundle="${tutorial}" /> 
   <b><c:out value="${mndbInstance.callingCommandName}" /></b> <br /> <br />
</c:if>

<!-- END OF SECTION 5 --> 


<!-- SECTION 6 -->
  
<!-- END OF SECTION 6 --> 


<!-- SECTION 7 -->
  
<!-- END OF SECTION 7 --> 


<!-- SECTION 8 -->

<!-- END OF SECTION 8 -->

<!-- SECTION 9 -->

<!-- END OF SECTION 9 -->


</body>
</html>