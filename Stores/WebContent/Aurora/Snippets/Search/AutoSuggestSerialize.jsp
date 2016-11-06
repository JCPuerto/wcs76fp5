<%--
 =================================================================
  Licensed Materials - Property of IBM

  WebSphere Commerce

  (C) Copyright IBM Corp. 2009, 2011 All Rights Reserved.

  US Government Users Restricted Rights - Use, duplication or
  disclosure restricted by GSA ADP Schedule Contract with
  IBM Corp.
 =================================================================
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://commerce.ibm.com/base" prefix="wcbase" %>
<%@ taglib uri="http://commerce.ibm.com/foundation" prefix="wcf" %>
<%@ taglib uri="http://commerce.ibm.com/coremetrics"  prefix="cm" %>
<%@ taglib uri="flow.tld" prefix="flow" %>
<%@ include file="../../include/JSTLEnvironmentSetup.jspf"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@page import="org.apache.solr.client.solrj.impl.CommonsHttpSolrServer"%>
<%@page import="org.apache.solr.client.solrj.SolrServer"%>
<%@page import="org.apache.solr.client.solrj.request.QueryRequest"%>
<%@page import="org.apache.solr.client.solrj.response.TermsResponse.Term"%>
<%@page import="org.apache.solr.common.params.TermsParams"%>
<%@page import="org.apache.solr.client.solrj.SolrRequest"%>
<%@page import="com.ibm.commerce.foundation.internal.server.services.search.config.solr.SolrSearchConfigurationRegistry"%>


<fmt:message var="suggestedKeyWords" key="SUGGESTED_KEYWORDS" bundle="${storeText}" />

<% 

		String SOLR_CORE_NAME = "coreName";
		String SOLR_SERVER_URL = "serverURL";
		String PARAM_TERM = "term";
		String PARAM_COUNT = "count";
		String PARAM_SHOWHEADER = "showHeader";
		String TERM_QUERY_TYPE = "/terms";
		String TERMS_FIELD = "spellCheck";

		int limit = 4; // default limit

		final int BUFFER_SIZE = 50;
		String requestURI = request.getRequestURI();

		String term = request.getParameter(PARAM_TERM);

		if (term != null) {
			int termLength = term.length();
			if (term.length() > 0) {
				String countParameter = request.getParameter(PARAM_COUNT);
				if (countParameter != null && countParameter.length() > 0) {
					limit = Integer.parseInt(countParameter);
				}
				String coreName = request.getParameter(SOLR_CORE_NAME);
				if (coreName == null || coreName.length() == 0) {
					return;
				}
				String serverURL = request.getParameter(SOLR_SERVER_URL);
				if (coreName != null) {
					SolrServer server = null;
					if (server == null) {
						server = SolrSearchConfigurationRegistry.getInstance().getServer(coreName);
					}
					if (server != null) {
						String lowerCaseTerm = term.toLowerCase();

						SolrQuery query = new SolrQuery();
						query.setQueryType(TERM_QUERY_TYPE);
						query.setTerms(true);
						query.setTermsLimit(limit);
						query.setTermsSortString(TermsParams.TERMS_SORT_COUNT);
						query.setTermsPrefix(lowerCaseTerm);
						query.addTermsField(TERMS_FIELD);
						QueryRequest termReq = new QueryRequest(query);
						termReq.setMethod(SolrRequest.METHOD.POST);
						List<Term> terms = termReq.process(server)
								.getTermsResponse().getTerms(TERMS_FIELD);
						StringBuffer responseBuffer = new StringBuffer(
								BUFFER_SIZE * limit);
						int total = terms.size();

						if(total > 0) {
							out.print("<div id='suggestedKeywordResults' class='results'>");

							String showHeader = request.getParameter(PARAM_SHOWHEADER);
							if (showHeader.equals("true")) {
								out.print("<div id='suggestedKeywordsHeader' class='heading'>");
								out.print(pageContext.getAttribute("suggestedKeyWords"));
								out.print("</div>");
							}

							out.print("<ul>");

							int selectionOffset = 0;

							// display keyword matches from the server
							for (int i = 0; i < total; i++) {
								Term responseTerm = terms.get(i);
								String theTerm = responseTerm.getTerm();
								String lowerResponseTerm = theTerm.toLowerCase();

								int termIndex = lowerResponseTerm.indexOf(lowerCaseTerm);

								out.print("<li id='suggestionItem_");
								out.print(selectionOffset);
								out.print("' role='listitem' tabindex='-1'><a role='listitem' href='#' onmouseout='this.className=\"\"' onmouseover='enableAutoSelect(");
								out.print(selectionOffset);
								out.print(");' onclick='selectAutoSuggest(this.title); return false;' title=\"");
								out.print(theTerm);
								out.print("\" id='autoSelectOption_");
								out.print(selectionOffset);
								out.print("'>");
								out.print(theTerm.substring(0, termIndex));
								out.print("<strong>");
								out.print(theTerm.substring(termIndex, termLength));
								out.print("</strong>");
								out.print(theTerm.substring(termIndex + termLength));
								out.print("</a></li>");
								selectionOffset++;

							}
							// record the original keyed in search term
							out.print("<input type='hidden' id='autoSuggestOriginalTerm' value='");
							out.print(term);
							out.print("'/>");
							out.print("<input type='hidden' id='dynamicAutoSuggestTotalResults' value='");
							out.print(selectionOffset);
							out.print("'/>");

							out.print("</ul></div>");
						}
					}
				}
			}
		}
%>
