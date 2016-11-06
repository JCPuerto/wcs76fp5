<%
/*
 *-------------------------------------------------------------------
 * Licensed Materials - Property of IBM 
 *
 * WebSphere Commerce
 *
 * (c) Copyright International Business Machines Corporation. 2005
 *     All rights reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 *-------------------------------------------------------------------
*/
%>


<%@ page import="com.ibm.commerce.beans.DataBeanManager,
	com.ibm.commerce.tools.segmentation.SegmentCountriesDataBean" %>


<%
	SegmentCountriesDataBean segmentCountries = new SegmentCountriesDataBean();
	DataBeanManager.activate(segmentCountries, request);
	SegmentCountriesDataBean.Country[] countries = segmentCountries.getCountries();
%>

<style type="text/css">
.selectWidth {width: 280px;}
</style>

<script language="JavaScript">
<!-- hide script from old browsers
var allCountries = new Array();
<%
	if (countries != null) {
		for (int i=0; i<countries.length; i++) {
%>
allCountries[<%= i %>] = new Object();
allCountries[<%= i %>].countryName = "<%= countries[i].getName() %>";
allCountries[<%= i %>].countryAbbr = "<%= countries[i].getAbbr() %>";
<%
		}
	}
%>

function showCountry () {
	with (document.segmentForm) {
		var selectValue = getSelectValue(<%= SegmentConstants.ELEMENT_COUNTRY_OP %>);
		showDivision(document.all.countryDiv, (selectValue == "<%= SegmentConstants.VALUE_ONE_OF %>" ||
			selectValue == "<%= SegmentConstants.VALUE_NOT_ONE_OF %>"));
	}
}

function loadCountry () {
	with (document.segmentForm) {
		if (parent.get) {
			var o = parent.get("<%= SegmentConstants.ELEMENT_SEGMENT_DETAILS %>", null);
			if (o != null) {
				loadSelectValue(<%= SegmentConstants.ELEMENT_COUNTRY_OP %>, o.<%= SegmentConstants.ELEMENT_COUNTRY_OP %>);
				var values = o.<%= SegmentConstants.ELEMENT_COUNTRIES %>;
				var currentSelected = 0;
				var currentAvailable = 0;
				for (var i=0; i<allCountries.length; i++) {
					var found = false;
					for (var j=0; j<values.length; j++) {
						if (allCountries[i].countryAbbr == values[j]) {
							<%= SegmentConstants.ELEMENT_COUNTRIES %>.options[currentSelected] = new Option(allCountries[i].countryName, allCountries[i].countryAbbr);
							currentSelected++;
							found = true;
							break;
						}
					}
					if (!found) {
						availableCountries.options[currentAvailable] = new Option(allCountries[i].countryName, allCountries[i].countryAbbr);
						currentAvailable++;
					}
				}
			}
			initializeSloshBuckets(<%= SegmentConstants.ELEMENT_COUNTRIES %>, removeFromCountrySloshBucketButton, availableCountries, addToCountrySloshBucketButton);
		}
		showCountry();
	}
}

function saveCountry () {
	with (document.segmentForm) {
		if (parent.get) {
			var o = parent.get("<%= SegmentConstants.ELEMENT_SEGMENT_DETAILS %>", null);
			if (o != null) {
				o.<%= SegmentConstants.ELEMENT_COUNTRY_OP %> = getSelectValue(<%= SegmentConstants.ELEMENT_COUNTRY_OP %>);
				var values = new Array();
				for (var i=0; i<<%= SegmentConstants.ELEMENT_COUNTRIES %>.length; i++) {
					values[i] = <%= SegmentConstants.ELEMENT_COUNTRIES %>.options[i].value;
				}
				o.<%= SegmentConstants.ELEMENT_COUNTRIES %> = values;
			}
		}
	}
}

function addToSelectedCountries () {
	with (document.segmentForm) {
		move(availableCountries, <%= SegmentConstants.ELEMENT_COUNTRIES %>);
		updateSloshBuckets(<%= SegmentConstants.ELEMENT_COUNTRIES %>, addToCountrySloshBucketButton, availableCountries, removeFromCountrySloshBucketButton);
	}
}

function removeFromSelectedCountries () {
	with (document.segmentForm) {
		move(<%= SegmentConstants.ELEMENT_COUNTRIES %>, availableCountries);
		updateSloshBuckets(<%= SegmentConstants.ELEMENT_COUNTRIES %>, removeFromCountrySloshBucketButton, availableCountries, addToCountrySloshBucketButton);
	}
}
//-->
</script>

<p><label for="<%= SegmentConstants.ELEMENT_COUNTRY_OP %>"><%= segmentsRB.get(SegmentConstants.MSG_COUNTRY_PANEL_TITLE) %></label><br>
<select name="<%= SegmentConstants.ELEMENT_COUNTRY_OP %>" id="<%= SegmentConstants.ELEMENT_COUNTRY_OP %>" onChange="showCountry()">
	<option value="<%= SegmentConstants.VALUE_DO_NOT_USE %>"><%= segmentsRB.get(SegmentConstants.MSG_DO_NOT_USE_COUNTRY) %></option>
	<option value="<%= SegmentConstants.VALUE_ONE_OF %>"><%= segmentsRB.get(SegmentConstants.MSG_COUNTRY_ONE_OF) %></option>
	<option value="<%= SegmentConstants.VALUE_NOT_ONE_OF %>"><%= segmentsRB.get(SegmentConstants.MSG_COUNTRY_NOT_ONE_OF) %></option>
</select>

<div id="countryDiv" style="display: none; margin-left: 20">
<br/>
<table>
	<tr>
		<td>
			<label for="<%= SegmentConstants.ELEMENT_COUNTRIES %>"><%= segmentsRB.get(SegmentConstants.MSG_SELECTED_COUNTRIES_PROMPT) %></label><br>
			<select name="<%= SegmentConstants.ELEMENT_COUNTRIES %>"
				id="<%= SegmentConstants.ELEMENT_COUNTRIES %>"
				tabindex="1"
				class="selectWidth"
				size="10"
				multiple onChange="javascript:updateSloshBuckets(this, document.segmentForm.removeFromCountrySloshBucketButton, document.segmentForm.availableCountries, document.segmentForm.addToCountrySloshBucketButton);">
			</select>
		</td>
		<td width="150px" align="center">
			<table cellpadding="2" cellspacing="2">
				<tr><td>
					<input type="button" tabindex="4" name="addToCountrySloshBucketButton" value="  <%= segmentsRB.get(SegmentConstants.MSG_COUNTRY_ADD_BUTTON) %>  " onClick="addToSelectedCountries()">
				</td></tr>
				<tr><td>
					<input type="button" tabindex="2" name="removeFromCountrySloshBucketButton" value="  <%= segmentsRB.get(SegmentConstants.MSG_COUNTRY_REMOVE_BUTTON) %>  " onClick="removeFromSelectedCountries()">
				</td></tr>
			</table>
		</td>
		<td>
			<label for="availableCountries"><%= segmentsRB.get(SegmentConstants.MSG_AVAILABLE_COUNTRIES_PROMPT) %></label><br>
			<select name="availableCountries"
				id="availableCountries"
				tabindex="3"
				class="selectWidth"
				size="10"
				multiple onChange="javascript:updateSloshBuckets(this, document.segmentForm.addToCountrySloshBucketButton, document.segmentForm.<%= SegmentConstants.ELEMENT_COUNTRIES %>, document.segmentForm.removeFromCountrySloshBucketButton);">
			</select>
		</td>
	</tr>
</table>
</div>
