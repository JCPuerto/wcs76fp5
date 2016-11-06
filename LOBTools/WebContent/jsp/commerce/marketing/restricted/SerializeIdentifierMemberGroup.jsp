<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2007, 2008 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf"%>

<object objectType="Identifier_MemberGroup">
   <parent><object objectId="${element.parentElementIdentifier.name}"/></parent>
   <elementName><wcf:cdata data="${element.memberGroupConditionElementIdentifier.name}"/></elementName>
   <elementType><wcf:cdata data="${element.conditionUsage}"/></elementType>
   <conditionName><wcf:cdata data="${element.memberGroupConditionElementIdentifier.name}"/></conditionName>
   <conditionUniqueId><wcf:cdata data="${element.memberGroupConditionElementIdentifier.uniqueID}"/></conditionUniqueId>
   <conditionVariable><wcf:cdata data="${element.simpleConditionVariable}"/></conditionVariable>
   <conditionOperator><wcf:cdata data="${element.simpleConditionOperator}"/></conditionOperator>
   <conditionValue><wcf:cdata data="${element.simpleConditionValue}"/></conditionValue>
   <conditionUsage><wcf:cdata data="${element.conditionUsage}"/></conditionUsage>
   <conditionParentName><wcf:cdata data="${element.parentElementIdentifier.name}"/></conditionParentName>

   <%-- Retrieve the member group information by name --%>
   <c:set var="memberGroupName" value="${element.simpleConditionValue}" />
   <c:if test="${memberGroupName != ''}">
        <c:set var="segmentName" value="${memberGroupName}" />
        <jsp:directive.include file="GetCustomerSegmentsByName.jsp" />
   </c:if>
</object>