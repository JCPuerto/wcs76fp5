<!--********************************************************************-->
<!--  Licensed Materials - Property of IBM                              -->
<!--                                                                    -->
<!--  WebSphere Commerce                                                -->
<!--                                                                    -->
<!--  (c) Copyright IBM Corp. 2009                                      -->
<!--                                                                    -->
<!--  US Government Users Restricted Rights - Use, duplication or       -->
<!--  disclosure restricted by GSA ADP Schedule Contract with IBM Corp. -->
<!--                                                                    -->
<!--********************************************************************-->
BEGIN_SYMBOL_DEFINITIONS
	
	<!-- DMRANKINGITEM table -->
	COLS:DMRANKINGITEM=DMRANKINGITEM:*
	
  <!-- DMRANKINGSTAT table -->
	COLS:DMRANKINGSTAT=DMRANKINGSTAT:*
		
END_SYMBOL_DEFINITIONS

<!-- ======================================================================== -->
<!-- Access Profiles                                                          -->
<!-- IBM_Admin_Details       All the columns from the table                   -->
<!-- ======================================================================== -->

<!-- Rankiing -->

<!-- ======================================================================== -->
<!-- This SQL will return the ranking list for the specified element in the   -->
<!-- current context store.                                                   -->
<!-- The access profiles that apply to this SQL are: IBM_Admin_Details        -->
<!-- @param DMELEMENT_ID The identifier of the campaign element.              -->
<!-- ======================================================================== -->
BEGIN_XPATH_TO_SQL_STATEMENT
	<!-- fetch a ranking list from DMRANKINGITEM -->
	name=/DMRANKINGITEM[DMELEMENT_ID= AND GROUP_ID=]+IBM_Admin_Details
	base_table=DMRANKINGITEM 
	sql= 
		SELECT  
				DMRANKINGITEM.$COLS:DMRANKINGITEM$ 
		FROM 
				DMRANKINGITEM 
		WHERE 
				DMRANKINGITEM.DMELEMENT_ID = ?DMELEMENT_ID? AND
				DMRANKINGITEM.GROUP_ID = ?GROUP_ID? AND
		    DMRANKINGITEM.STOREENT_ID = $CTX:STORE_ID$				
		ORDER BY SEQUENCE ASC
								 
END_XPATH_TO_SQL_STATEMENT

<!-- ======================================================================== -->
<!-- This SQL will return the ranking list for the specified element in the   -->
<!-- specified store.                                                         -->
<!-- The access profiles that apply to this SQL are: IBM_Admin_Details        -->
<!-- @param DMELEMENT_ID The identifier of the campaign element.              -->
<!-- @param STOREENT_ID The identifier of the store.                          -->
<!-- ======================================================================== -->
BEGIN_XPATH_TO_SQL_STATEMENT
	<!-- fetch a ranking list from DMRANKINGITEM -->
	name=/DMRANKINGITEM[DMELEMENT_ID= AND GROUP_ID= AND STOREENT_ID=]+IBM_Admin_Details
	base_table=DMRANKINGITEM 
	sql= 
		SELECT  
				DMRANKINGITEM.$COLS:DMRANKINGITEM$ 
		FROM 
				DMRANKINGITEM 
		WHERE 
				DMRANKINGITEM.DMELEMENT_ID = ?DMELEMENT_ID? AND
				DMRANKINGITEM.GROUP_ID = ?GROUP_ID? AND
				DMRANKINGITEM.STOREENT_ID = ?STOREENT_ID?				
								 
END_XPATH_TO_SQL_STATEMENT

<!-- ======================================================================== -->
<!-- This SQL will create a ranking statistic entry.                          -->
<!-- @param DMRANKINGSTAT_ID The primary key of the ranking statistic entry.  -->
<!-- @param OBJECT_ID The identifier of the object that generated the event.  -->
<!-- @param OBJECT_TYPE The type of statistic entry.                          -->
<!-- @param STOREENT_ID The store identifier.                                 -->
<!-- @param GROUP_ID The identifier of the group to which the object belongs. -->
<!-- @param AMOUNT The amount associated with the event.                      -->
<!-- ======================================================================== -->
BEGIN_SQL_STATEMENT
  <!-- insert entries into DMRANKINGSTAT -->
  base_table=DMRANKINGSTAT
	name=IBM_Admin_Insert_InsertDmrankingstat
	sql=insert into DMRANKINGSTAT (DMRANKINGSTAT_ID, OBJECT_ID, OBJECT_TYPE, STOREENT_ID, DMELEMENT_ID, GROUP_ID, AMOUNT, FLAG, TIMECREATED) values ( ?DMRANKINGSTAT_ID?, ?OBJECT_ID?, ?OBJECT_TYPE?, ?STOREENT_ID?, ?DMELEMENT_ID?, ?GROUP_ID?, ?AMOUNT?, 0, CURRENT_TIMESTAMP)
END_SQL_STATEMENT