<!--********************************************************************-->
<!--  Licensed Materials - Property of IBM                              -->
<!--                                                                    -->
<!--  WebSphere Commerce                                                -->
<!--                                                                    -->
<!--  (c) Copyright IBM Corp. 2012                                      -->
<!--                                                                    -->
<!--  US Government Users Restricted Rights - Use, duplication or       -->
<!--  disclosure restricted by GSA ADP Schedule Contract with IBM Corp. -->
<!--                                                                    -->
<!--********************************************************************-->


<!-- ========================================================================= -->
<!--  Determine if indexing in the given schema is being performed             -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IS_PERFORMING_INDEXING_WITH_SCHEMA
	base_table=TI_DELTA_CATENTRY
	sql=
	SELECT CATENTRY_ID
	  FROM $SCHEMA$.TI_DELTA_CATENTRY
	 WHERE MASTERCATALOG_ID = ?masterCatalogId?
       AND ACTION = 'P'
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine if indexing in the given schema is being performed             -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=IS_PERFORMING_CATGROUP_INDEXING_WITH_SCHEMA
	base_table=TI_DELTA_CATGROUP
	sql=
	SELECT CATGROUP_ID
	  FROM $SCHEMA$.TI_DELTA_CATGROUP
	 WHERE MASTERCATALOG_ID = ?masterCatalogId?
       AND ACTION = 'P'
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Check for delta or full update from the catalog group delta update table -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=CHECK_FOR_DELTA_CATGROUP_INDEXING
	base_table=TI_DELTA_CATGROUP
	sql=
	SELECT TI_DELTA_CATGROUP.MASTERCATALOG_ID,
		   TI_DELTA_CATGROUP.CATGROUP_ID,
		   TI_DELTA_CATGROUP.ACTION
	  FROM TI_DELTA_CATGROUP
	 WHERE (TI_DELTA_CATGROUP.MASTERCATALOG_ID = ?masterCatalogId?
	 	    AND TI_DELTA_CATGROUP.CATGROUP_ID = ?catalogGroupId?
		    AND TI_DELTA_CATGROUP.ACTION = 'U')
	    OR (TI_DELTA_CATGROUP.MASTERCATALOG_ID = ?masterCatalogId?
		    AND TI_DELTA_CATGROUP.ACTION = 'F')			
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Check for only full update from the catalog group delta update table     -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=CHECK_FOR_FULL_CATGROUP_INDEXING
	base_table=TI_DELTA_CATGROUP
	sql=
	SELECT TI_DELTA_CATGROUP.MASTERCATALOG_ID,
		   TI_DELTA_CATGROUP.CATGROUP_ID,
		   TI_DELTA_CATGROUP.ACTION
	  FROM TI_DELTA_CATGROUP
	 WHERE TI_DELTA_CATGROUP.MASTERCATALOG_ID = ?masterCatalogId?
       AND TI_DELTA_CATGROUP.ACTION = 'F'	
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Check for any action from the catalog group delta update table           -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=CHECK_FOR_ANY_CATGROUP_INDEXING
	base_table=TI_DELTA_CATGROUP
	sql=
	SELECT TI_DELTA_CATGROUP.MASTERCATALOG_ID,
		   TI_DELTA_CATGROUP.CATGROUP_ID,
		   TI_DELTA_CATGROUP.ACTION
	  FROM TI_DELTA_CATGROUP
	 WHERE TI_DELTA_CATGROUP.MASTERCATALOG_ID = ?masterCatalogId?	
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Get the lastest update from TI_CATENTRY_WS table                         -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=GET_MAXMUM_LASTUPDATE_FROM_CATENTRY_WS
	base_table=TI_CATENTRY_WS
	sql=
	SELECT max(lastupdate) as lastupdate
	  FROM TI_CATENTRY_WS
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Get the lastest update from TI_CATGROUP_WS table                         -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=GET_MAXMUM_LASTUPDATE_FROM_CATGROUP_WS
	base_table=TI_CATGROUP_WS
	sql=
	SELECT max(lastupdate) as lastupdate
	  FROM TI_CATGROUP_WS
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Undo catalog entry in TI_DELTA_CATENTRY table                            -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=RESET_TI_DELTA_CATENTRY
	base_table=TI_DELTA_CATENTRY
	sql=
    DELETE FROM TI_DELTA_CATENTRY
     WHERE MASTERCATALOG_ID = ?masterCatalogId? 
	   AND CATENTRY_ID = ?catalogEntryId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Undo catalog entry in TI_DELTA_CATGROUP table                            -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=RESET_TI_DELTA_CATGROUP
	base_table=TI_DELTA_CATGROUP
	sql=
    DELETE FROM TI_DELTA_CATGROUP
     WHERE MASTERCATALOG_ID = ?masterCatalogId? 
	   AND CATGROUP_ID = ?catalogGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Select a row from the catalog entry workspace table                      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_TI_CATENTRY_WS
	base_table=TI_CATENTRY_WS
	sql=
	SELECT LASTUPDATE FROM TI_CATENTRY_WS where MASTERCATALOG_ID = ?masterCatalogId? 
	and CATENTRY_ID = ?catalogEntryId?
	and TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Select a row from the catalog group workspace table                      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_TI_CATGROUP_WS
	base_table=TI_CATGROUP_WS
	sql=
	SELECT LASTUPDATE FROM TI_CATGROUP_WS where MASTERCATALOG_ID = ?masterCatalogId? 
	and CATGROUP_ID = ?catalogGroupId?
	and TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Insert a row into the catalog entry workspace table                      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=INSERT_TI_CATENTRY_WS
	base_table=TI_CATENTRY_WS
	sql=
	INSERT INTO TI_CATENTRY_WS 
	(MASTERCATALOG_ID, CATENTRY_ID, LASTUPDATE, TASKGROUP, ACTION, CONTENT_BASE) 
	VALUES 
	(?masterCatalogId?, ?catalogEntryId?, ?lastupdate?, ?taskGroupId?, ?action?, 1)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Insert a row into the catalog group workspace table                      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=INSERT_TI_CATGROUP_WS
	base_table=TI_CATGROUP_WS
	sql=
	INSERT INTO TI_CATGROUP_WS 
	(MASTERCATALOG_ID, CATGROUP_ID, LASTUPDATE, TASKGROUP, ACTION, CONTENT_BASE) 
	VALUES 
	(?masterCatalogId?, ?catalogGroupId?, ?lastupdate?, ?taskGroupId?, ?action?, 1)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Update a row in the catalog entry workspace table                        -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=UPDATE_TI_CATENTRY_WS
	base_table=TI_CATENTRY_WS
	sql=
	UPDATE TI_CATENTRY_WS SET LASTUPDATE = ?lastupdate?, ACTION = ?action?
	 WHERE MASTERCATALOG_ID = ?masterCatalogId?
	   AND CATENTRY_ID = ?catalogEntryId? 
	   AND TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Update a row in the catalog group workspace table                        -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=UPDATE_TI_CATGROUP_WS
	base_table=TI_CATGROUP_WS
	sql=
	UPDATE TI_CATGROUP_WS SET LASTUPDATE = ?lastupdate?, ACTION = ?action? 
	 WHERE MASTERCATALOG_ID = ?masterCatalogId?
	   AND CATGROUP_ID = ?catalogGroupId? 
	   AND TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Delete a row from the catalog entry workspace table                      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=DELETE_TI_CATENTRY_WS
	base_table=TI_CATENTRY_WS
	sql=
	DELETE FROM TI_CATENTRY_WS where MASTERCATALOG_ID = ?masterCatalogId? 
	and CATENTRY_ID = ?catalogEntryId?
	and TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Delete a row from the catalog group workspace table                      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=DELETE_TI_CATGROUP_WS
	base_table=TI_CATGROUP_WS
	sql=
	DELETE FROM TI_CATGROUP_WS where MASTERCATALOG_ID = ?masterCatalogId? 
	and CATGROUP_ID = ?catalogGroupId?
	and TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Select rows from the catalog entry workspace table by catalog entry      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_BY_CATENTRY_TI_CATENTRY_WS
	base_table=TI_CATENTRY_WS
	sql=
	SELECT ACTION, TASKGROUP FROM TI_CATENTRY_WS where
	MASTERCATALOG_ID = ?masterCatalogId? and 
	CATENTRY_ID = ?catalogEntryId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Select rows from the catalog group workspace table by catalog group      -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_BY_CATGROUP_TI_CATGROUP_WS
	base_table=TI_CATGROUP_WS
	sql=
	SELECT ACTION, TASKGROUP FROM TI_CATGROUP_WS where
	MASTERCATALOG_ID = ?masterCatalogId? and 
	CATGROUP_ID = ?catalogGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Select rows from the catalog entry workspace table by taskgroup          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_BY_TASKGROUP_TI_CATENTRY_WS
	base_table=TI_CATENTRY_WS
	sql=
	SELECT CATENTRY_ID, MASTERCATALOG_ID, ACTION FROM TI_CATENTRY_WS where 
	TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Select rows from the catalog group workspace table by taskgroup          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_BY_TASKGROUP_TI_CATGROUP_WS
	base_table=TI_CATGROUP_WS
	sql=
	SELECT CATGROUP_ID, MASTERCATALOG_ID, ACTION FROM TI_CATGROUP_WS where 
	TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Select masterCatalogs from the catalog entry workspace table          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_CATALOG_ID_TI_CATENTRY_WS
	base_table=TI_CATENTRY_WS
	sql=
	SELECT DISTINCT MASTERCATALOG_ID FROM TI_CATENTRY_WS where 
	TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Select masterCatalogs from the catalog group workspace table             -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_CATALOG_ID_TI_CATGROUP_WS
	base_table=TI_CATGROUP_WS
	sql=
	SELECT DISTINCT MASTERCATALOG_ID FROM TI_CATGROUP_WS where 
	TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Select all rows from the catalog entry workspace table by master catalog -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_MASTERCATALOG_ID_TI_CATENTRY_WS
	base_table=TI_CATENTRY_WS
	sql=
	SELECT CATENTRY_ID, ACTION, TASKGROUP FROM TI_CATENTRY_WS where
	MASTERCATALOG_ID = ?masterCatalogId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Select all rows from the catalog group workspace table by master catalog -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_MASTERCATALOG_ID_TI_CATGROUP_WS
	base_table=TI_CATGROUP_WS
	sql=
	SELECT CATGROUP_ID, ACTION, TASKGROUP FROM TI_CATGROUP_WS where
	MASTERCATALOG_ID = ?masterCatalogId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Delete rows from the catalog entry workspace table by taskgroup          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=DELETE_BY_TASKGROUP_TI_CATENTRY_WS
	base_table=TI_CATENTRY_WS
	sql=
	DELETE FROM TI_CATENTRY_WS where TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Delete rows from the catalog group workspace table by taskgroup          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=DELETE_BY_TASKGROUP_TI_CATGROUP_WS
	base_table=TI_CATGROUP_WS
	sql=
	DELETE FROM TI_CATGROUP_WS where TASKGROUP = ?taskGroupId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Insert a row into the catalog entry delta update workspace table         -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=INSERT_TI_DELTA_CATENTRY_WORKSPACE
	base_table=TI_DELTA_CATENTRY
	sql=
	INSERT INTO TI_DELTA_CATENTRY (MASTERCATALOG_ID, CATENTRY_ID, ACTION, LASTUPDATE, CONTENT_BASE) 
	VALUES (?masterCatalogId?, ?catalogEntryId?, ?action?, ?lastupdate?, 1)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Insert a row into the catalog group delta update workspace table         -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=INSERT_TI_DELTA_CATGROUP_WORKSPACE
	base_table=TI_DELTA_CATGROUP
	sql=
	INSERT INTO TI_DELTA_CATGROUP (MASTERCATALOG_ID, CATGROUP_ID, ACTION, LASTUPDATE, CONTENT_BASE) 
	VALUES (?masterCatalogId?, ?catalogGroupId?, ?action?, ?lastupdate?, 1)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Deep search for catentried and categroups.                               -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=DEEP_SELECT_CATENTRIES_FOR_CATGROUP
	base_table=CATGROUP
	dbtype=any
	sql=
		WITH CATEGORY (CATGROUP_ID) AS (
			SELECT 
				DISTINCT CATGROUP.CATGROUP_ID CATGROUP_ID 
			FROM 
				CATGROUP 
			WHERE 
				CATGROUP.CATGROUP_ID=?catalogGroupId? 
			UNION ALL 
			SELECT  
				CATGRPREL.CATGROUP_ID_CHILD 
			FROM 
				CATEGORY, CATGRPREL 
			WHERE 
				CATEGORY.CATGROUP_ID = CATGRPREL.CATGROUP_ID_PARENT 
				AND 
				CATGRPREL.CATALOG_ID=?masterCatalogId?	
		)
		SELECT 
			CATGROUP.CATGROUP_ID, CATGPENREL.CATENTRY_ID
		FROM 
		    CATEGORY, CATGPENREL, CATGROUP
		WHERE 
            CATEGORY.CATGROUP_ID = CATGROUP.CATGROUP_ID
            AND
            CATGPENREL.CATGROUP_ID = CATEGORY.CATGROUP_ID 
            AND 
            CATGPENREL.CATALOG_ID =?masterCatalogId?	
            AND
            CATGROUP.MARKFORDELETE=0 

	dbtype=oracle
	sql=
		WITH CATEGORY AS (
			SELECT 
				DISTINCT CATGROUP.CATGROUP_ID CATGROUP_ID 
			FROM 
				CATGROUP 
			WHERE 
				CATGROUP.CATGROUP_ID=?catalogGroupId?
			UNION ALL 
			SELECT 
				CATGRPREL.CATGROUP_ID_CHILD CATGROUP_ID
			FROM 
				CATGRPREL 
			WHERE 
				CATGRPREL.CATALOG_ID=?masterCatalogId?
			START WITH 
				CATGRPREL.CATGROUP_ID_PARENT=?catalogGroupId?
			CONNECT BY PRIOR 
				CATGRPREL.CATGROUP_ID_CHILD = CATGRPREL.CATGROUP_ID_PARENT	
		) 
		SELECT 
			CATGROUP.CATGROUP_ID, CATGPENREL.CATENTRY_ID
		FROM 
		    CATEGORY, CATGPENREL, CATGROUP
		WHERE 
            CATEGORY.CATGROUP_ID = CATGROUP.CATGROUP_ID
            AND
            CATGPENREL.CATGROUP_ID = CATEGORY.CATGROUP_ID 
            AND 
            CATGPENREL.CATALOG_ID =?masterCatalogId?	
            AND
            CATGROUP.MARKFORDELETE=0  

END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine all facetable columns registered for search                    -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_CATEGORY_FACET_OVERRIDE
	base_table=FACETCATGRP
	sql=
	SELECT FACETCATGRP.SEQUENCE,FACETCATGRP.STOREENT_ID,FACETCATGRP.DISPLAYABLE,SRCHATTRPROP.PROPERTYVALUE
	from FACETCATGRP, FACET, SRCHATTRPROP
	where  FACET.FACET_ID=FACETCATGRP.FACET_ID and 
		  FACET.SRCHATTR_ID=SRCHATTRPROP.SRCHATTR_ID and 
		  CATGROUP_ID=?categoryId? and 
		  FACETCATGRP.storeent_id IN (?storeList?) and 
		  SRCHATTRPROP.PROPERTYNAME IN ('facet','facet-classicAttribute','facet-category','facet-range')
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine if a facet exists (via facet_id in FACET table)                -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACET_RECORD
	base_table=FACET
	sql=
	SELECT FACET_ID
	from FACET
	where FACET_ID=?facetId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the catalog entries associated with an attribute dictionary    -->
<!--  attribute.                                                               -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_CATENTRY_FOR_ATTRIBUTE_DICTIONARY_ATTRIBUTE
	base_table=CATENTRYATTR
	sql=
	SELECT CATENTRY_ID
	from CATENTRYATTR
	where ATTR_ID=?attrId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the facetable columns registered in the table SRCHATTRPROP.    -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACETABLE_COLUMNS_SRCHATTRPROP
	base_table=SRCHATTRPROP
	sql=
	select PROPERTYNAME,PROPERTYVALUE 
	from SRCHATTRPROP LEFT JOIN SRCHATTR on 
	SRCHATTRPROP.SRCHATTR_ID=SRCHATTR.SRCHATTR_ID 
	where indextype=?indexType? and propertyname in ('facet','facet-classicAttribute','facet-category','facet-range')
END_SQL_STATEMENT


<!-- ========================================================================= -->
<!--  Determine the facet information                                          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACETABLE_INFORMATION
	base_table=FACET
	sql=
	select 
	srchattr.srchattr_id as srchattr_id,
	srchattrprop.propertyname as propertyname,
	srchattrprop.propertyvalue as propertyvalue,
	srchattr.identifier as srchattridentifier,
	facet.facet_id as facet_id,
	facet.attr_id as attr_id,
	facet.selection as selection,
	facet.keyword_search as keyword_search,
	facet.zero_display as zero_display,
	facet.storeent_id as storeent_id,
	facet.max_display as max_display,
	facet.sequence as sequence,
	facet.sort_order as sort_order,
	facet.field1 as ffield1,
	facet.field2 as ffield2,
	facet.field3 as ffield3,
	facetdesc.name as fname,
	facetdesc.language_id as flang,
	facetdesc.description as fdesc,
	facetdesc.field1 as fdescfield1,
	facetdesc.field2 as fdescfield2,
	facetdesc.field3 as fdescfield3,
	attr.identifier as attridentifier,
	attr.attrtype_id as attrtype,
	attr.sequence as attrsequence,
	attr.facetable as facetable,
	attrdesc.name as attrname,
	attrdesc.language_id as attrlang,
	attrdesc.description as attrdesc 
	from srchattrprop 
	LEFT JOIN srchattr ON srchattrprop.srchattr_id=srchattr.srchattr_id 
	LEFT JOIN facet ON facet.srchattr_id=srchattr.srchattr_id 
	LEFT JOIN facetdesc ON facet.facet_id=facetdesc.facet_id and facetdesc.language_id=?languageId?
	LEFT JOIN attr on facet.attr_id=attr.attr_id  and attr.facetable<>0
	LEFT JOIN attrdesc on attr.attr_id=attrdesc.attr_id and attrdesc.language_id=?languageId?
	where 
	srchattrprop.propertyname in ('facet','facet-classicAttribute','facet-category','facet-range') and 
	srchattr.indextype=?indexType? and 
	srchattrprop.propertyvalue in (?propertyValue?) and
	facet.storeent_id IN (?storeList?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the facet information                                          -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACETABLE_INFORMATION_FOR_KEYWORD_SEARCH
	base_table=FACET
	sql=
	select 
	srchattr.srchattr_id as srchattr_id,
	srchattrprop.propertyname as propertyname,
	srchattrprop.propertyvalue as propertyvalue,
	srchattr.identifier as srchattridentifier,
	facet.facet_id as facet_id,
	facet.attr_id as attr_id,
	facet.selection as selection,
	facet.keyword_search as keyword_search,
	facet.zero_display as zero_display,
	facet.storeent_id as storeent_id,
	facet.max_display as max_display,
	facet.sequence as sequence,
	facet.field1 as ffield1,
	facet.field2 as ffield2,
	facet.field3 as ffield3,
	facetdesc.name as fname,
	facetdesc.language_id as flang,
	facetdesc.description as fdesc,
	facetdesc.field1 as fdescfield1,
	facetdesc.field2 as fdescfield2,
	facetdesc.field3 as fdescfield3,
	attr.identifier as attridentifier,
	attr.attrtype_id as attrtype,
	attr.sequence as attrsequence,
	attr.facetable as facetable,
	attrdesc.name as attrname,
	attrdesc.language_id as attrlang,
	attrdesc.description as attrdesc 
	from srchattrprop 
	JOIN srchattr ON srchattrprop.srchattr_id=srchattr.srchattr_id 
	JOIN facet ON facet.srchattr_id=srchattr.srchattr_id 
	LEFT JOIN facetdesc ON facet.facet_id=facetdesc.facet_id and facetdesc.language_id=?languageId?
	LEFT JOIN attr on facet.attr_id=attr.attr_id and attr.facetable<>0
	LEFT JOIN attrdesc on attr.attr_id=attrdesc.attr_id and attrdesc.language_id=?languageId?
	where 
	facet.keyword_search=1 and
	srchattr.indextype=?indexType? and 
	srchattrprop.propertyname IN ('facet','facet-classicAttribute','facet-category','facet-range') and 
	facet.storeent_id IN (?storeList?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the image and sequence of the facetable attribute values       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACET_VALUE_IMAGE_AND_SEQUENCE
	base_table=ATTRDICTSRCHCONF
	sql=
	select attrdictsrchconf.SRCHFIELDNAME,attrvaldesc.value,attrval.storeent_id,attrvaldesc.sequence,attrvaldesc.image1,attrvaldesc.image2 
	from 
	attrdictsrchconf left outer join attr on attrdictsrchconf.attr_id=attr.attr_id
	left outer join attrval on attr.attr_id=attrval.attr_id
	left outer join attrvaldesc on attr.attr_id=attrvaldesc.attr_id
	where 
	attrdictsrchconf.ATTR_ID is not NULL and
	attr.facetable=1 and
	attr.storeent_id in ($STOREPATH:catalog$) and
	attrvaldesc.language_id=?language_id? and 
	attrdictsrchconf.SRCHFIELDNAME in (?searchFieldList?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the facet configuration for a list of search columns           -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACET_CONFIGURATION_FOR_SEARCH_COLUMNS
	base_table=FACET
	sql=
	select propertyvalue, selection, sort_order, keyword_search, zero_display, max_display from 
	srchattrprop join facet on srchattrprop.srchattr_id=facet.srchattr_id 
	where propertyname in ('facet','facet-classicAttribute','facet-category','facet-range')
		and storeent_id in (?storeList?)
		and propertyvalue in (?propertyValueList?)
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine an attribute is facetable or searchable                        -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_ATTRIBUTE_STORE
	base_table=ATTR
	sql=
	select STOREENT_ID from ATTR
	 where ATTR_ID=?attributeId?
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the number of active workspaces                                -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_ACTIVE_WORKSPACES
	base_table=CMFWKSPC
	sql=
	select IDENTIFIER from CMFWKSPC
	 where STATUS = 1
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  Determine the order of facets for a given category                       -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACET_ORDER_FOR_CATEGORY_NAVIGATION
	base_table=FACET
	sql=
	SELECT FACET.SRCHATTR_ID, COALESCE(FACETCATGRP.SEQUENCE, FACET.SEQUENCE) SEQUENCE
	FROM FACET
	  LEFT OUTER JOIN FACETCATGRP ON FACET.FACET_ID = FACETCATGRP.FACET_ID 
	  		AND FACETCATGRP.CATGROUP_ID=?catalogGroupId?
	  		AND FACETCATGRP.STOREENT_ID in ($STOREPATH:catalog$)
	WHERE FACET.SRCHATTR_ID IN (?srchAttrId?)
        ORDER BY SEQUENCE ASC
END_SQL_STATEMENT


<!-- ========================================================================= -->
<!--  Determine the order of facets for keyword search                         -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=SELECT_FACET_ORDER_FOR_KEYWORD_SEARCH 
	base_table=FACET
	sql=
	SELECT FACET.SRCHATTR_ID, FACET.SEQUENCE
	FROM FACET
	WHERE FACET.SRCHATTR_ID IN (?srchAttrId?)
        ORDER BY SEQUENCE ASC
END_SQL_STATEMENT

<!-- ========================================================================= -->
<!--  To update srchattr identifier -->
<!-- ========================================================================= -->
BEGIN_SQL_STATEMENT
	name=UPDATE_SRCHATTR_IDENTIFIER
	base_table=SRCHATTR
	sql=
	update srchattr set identifier = ?identifier? where srchattr_id IN (?srchattr_id?)
END_SQL_STATEMENT