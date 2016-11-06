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


BEGIN_SYMBOL_DEFINITIONS
	
	<!-- The table for noun Folder  -->
		<!-- Defining all columns of the table -->
		COLS:FOLDER = FOLDER:* 	
		<!-- Defining all columns of the FOLDERITEM table -->
		COLS:FOLDERITEM = FOLDERITEM:* 	
		<!-- Defining the unique ID column of the table -->
		COLS:FOLDER_ID = FOLDER:FOLDER_ID
		<!-- Defining the identifier column of the table -->
		COLS:FOLDER_IDENTIFIER = FOLDER:IDENTIFIER
		<!-- Defining the description column of the table -->
		COLS:FOLDER_DESC = FOLDER:DESCRIPTION
		
END_SYMBOL_DEFINITIONS

<!-- ======================================================================  -->
<!-- XPath: /Folder[FolderIdentifier[(UniqueID=)]]							 -->
<!-- AccessProfile:	IBM_Admin_UpdateFolder 								     -->
<!-- Get the information for a folder with a specified unique ID for an 	 -->
<!--		update operation. 												 -->
<!-- Access profile includes all columns from the table. 					 -->
<!-- @param UniqueID  The Unique ID of the folder to retrieve 				 -->   
<!-- ======================================================================  -->
BEGIN_XPATH_TO_SQL_STATEMENT
	name=/Folder[FolderIdentifier[(UniqueID=)]]+IBM_Admin_UpdateFolder
	base_table=FOLDER
	sql=	
		SELECT 
	     				FOLDER.$COLS:FOLDER$
	     	FROM
	     				FOLDER
	     	WHERE
						FOLDER.FOLDER_ID = ?UniqueID? 
END_XPATH_TO_SQL_STATEMENT



<!-- ==================================================================================  -->
<!-- XPath: /Folder[FolderIdentifier[(UniqueID=)]]										 -->
<!-- AccessProfile:	IBM_Admin_ChildFolderItems 											 -->
<!-- Get the information for a folder with a specified unique ID for an 				 -->
<!--	update operation. This access profile will also return the folder 				 -->
<!--    items in the specified folder.   												 -->
<!-- Access profile includes all columns from the table. 								 -->
<!-- @param UniqueID Unique ID of the folder to retrieve.								 -->   
<!-- ==================================================================================  -->
BEGIN_XPATH_TO_SQL_STATEMENT
	name=/Folder[FolderIdentifier[(UniqueID=)]]+IBM_Admin_UpdateFolderItems
	base_table=FOLDER
	sql=	
		SELECT 
	     				FOLDER.$COLS:FOLDER$,
	     				FOLDERITEM.$COLS:FOLDERITEM$
	     	FROM
	     				FOLDER
	     	LEFT JOIN
	     				FOLDERITEM
	     	ON
	     				FOLDER.FOLDER_ID = FOLDERITEM.FOLDER_ID
	     	WHERE
						FOLDER.FOLDER_ID = ?UniqueID? 
END_XPATH_TO_SQL_STATEMENT


<!-- ========================================================================== --> 
<!--	Retrieve a folder with a given unique ID and a folder item with a 		-->
<!--		given reference ID and folder item type.							-->
<!--	AccessProfile:	IBM_Admin_FindFolderItemsByReferenceIDTypeAndFolder		-->
<!--		 Will return a folder and folder item object with all columns 		-->
<!--		 in the FOLDER and FOLDERITEM tables joined together.				-->
<!--	@param UniqueID The unique ID of a folder.								-->
<!--	@param ReferenceID The reference ID of a folder item.					-->
<!--	@param FolderItemType The folder item type of a folder item.			-->
<!--=========================================================================== -->
BEGIN_XPATH_TO_SQL_STATEMENT
	name=/Folder[FolderIdentifier[(UniqueID=)] and FolderItem[(ReferenceID=) and (FolderItemType=)]]+IBM_Admin_FindFolderItemsByReferenceIDTypeAndFolder
	base_table=FOLDERITEM
	sql=
			SELECT 
	     				FOLDERITEM.$COLS:FOLDERITEM$
	     	FROM
	     				FOLDERITEM
	     	WHERE
						FOLDERITEM.REFERENCE_ID=?ReferenceID? 
			AND
						FOLDERITEM.FOLDERITEMTYPE=?FolderItemType?
			AND
						FOLDERITEM.FOLDER_ID=?UniqueID?
END_XPATH_TO_SQL_STATEMENT
