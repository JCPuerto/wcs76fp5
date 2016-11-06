//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2008, 2010 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

/** 
 * @fileOverview This file is to be included in all full pages that use the CatalogEntryThumbnailDisplay.jspf.
 * It prepares all the code required for the Product Quick Info pop-up reveal.
 */

	//Make the Product Quick Info pop-up window movable.
	dojo.require("dojo.dnd.move");
	dojo.require("dijit.Dialog");
	dojo.require("dojo._base.event");
	
	/** The variable stores the Product Quick Info pop-up window. */
	var m1;
	
	/** 
	 * This variable is the id of element to display the pop-up around on <Enter> key click.
	 * Its default value is set to empty.
	 */
	var nodeId = "";
	/** 
	 * Used by the Brazil store, this variable is the id of the product entry to use. The ProductID
	 * in the Madisons store has been increment by one, so its really productID + 1. Hence, Brazil
	 * store will use the original productID, called origProductID. Its default value is set to empty.
	 */
	var origProductID = "";
	
	/** The variable stores the identifier of the order item to be replaced */
	var replaceOrderItemId;
	
	/** The response from the server */
	var responseJSON;
	
	/** 
	 * Initializes the Product Quick Info pop-up window to a movable dialog.
	 */	
	var initPopup = function(){
		m1 = new dojo.dnd.Moveable("second_level_category_popup", {handle: "popupHeader"});
	};
	
	var changeAttrId = "";
	var changeContractId = "";
	
	dojo.addOnLoad(initPopup);


	function setUpdateOrderItemIdsForItem(changeAttr, itemPosition) {
		changeAttrId = changeAttr;
		if (itemPosition != "") {
			changeContractId = 'B2BContractSelectExt_id_' + itemPosition;
		}
	}
	
	/** 
	 * Displays the Product Quick Info button.
	 * 
	 * @param {string} id The id of the div area to show.
	 */
	function showPopupButton(id){
		if(document.getElementById("popupButton_"+id)!=null && document.getElementById("popupButton_"+id)!='undefined'){
			var popupButton = document.getElementById("popupButton_"+id);
			popupButton.style.visibility="visible";
		}
	}

	/** 
	 * Hides the Product Quick Info button.
	 * 
	 * @param {string} id The id of the div area to hide. 
	 */	
	function hidePopupButton(id){
		if(document.getElementById("popupButton_"+id)!=null && document.getElementById("popupButton_"+id)!='undefined') {
			var popupButton = document.getElementById("popupButton_"+id);
			popupButton.style.visibility="hidden";
		}
	}
	 
	 /** 
		 * Overrides the hidePopupButton function above by also checking to see if the user clicks shift+tab.
		 * 
		 * @param {string} id The id of the div area to hide. 
		 * @param {event} event The keystroke event entered by the user. 
		 */	
	 function shiftTabHidePopupButton(id, e){
		 if ((e.shiftKey) && (dojo.keys.TAB)){
				 
				 hidePopupButton(id);
			 } 
			 
		}
		 
	 

	/** 
	 * Displays the Product Quick Info pop-up containing product information.
	 * Retrieves product information in JSON format via an Ajax call.
	 * 
	 * @param {string} productId The id of the product to display.
	 * @param {string} event The event triggered from user actions.
	 * @param {string} targetId The id of the dojo element to display the pop-up next to.
	 * @param {string} nodeId The id of element to display the pop-up around on <Enter> key click.
	 * @param {object} productActionList The object containing Product Quick Info pop-up action list settings.
	 * @param {string} popUpQty The quantity to be displayed for this product.
	 */		
	function showPopup(productId,event,targetId,nodeId,productActionList,popUpQty){
		if(event == null || (event != null && event.type!="keypress") || (event != null && event.type=="keypress" && event.keyCode==13)){
			resetPopUp();
			
			if ( typeof(isBrazilStore) != 'undefined' && isBrazilStore ){
				this.nodeId = nodeId; //save the parent node
	        }
			//Default action list is used if it is not passed into this method
			if(productActionList == null){
				productActionList = new popupActionProperties();
			}
			
			//From the productActionList object properties
			//hide/show the action links from the Quick Info 		
			if(productActionList.showAddToCart){
				if(document.getElementById('addToCartAjaxButton')){
					document.getElementById('addToCartAjaxButton').style.visibility='visible';
				} else if(document.getElementById('addToCartButton')){
					document.getElementById('addToCartButton').style.visibility='visible';
				}			
			} else {
				if(document.getElementById('addToCartAjaxButton')){
					document.getElementById('addToCartAjaxButton').style.visibility='hidden';
				} else if(document.getElementById('addToCartButton')){
					document.getElementById('addToCartButton').style.visibility='hidden';
				}			
			}
	
			if(productActionList.showWishList){
				if(document.getElementById('addToWishListLinkAjax')){
					document.getElementById('addToWishListLinkAjax').style.display='block';
				} else if(document.getElementById('addToWishListLink')){
					document.getElementById('addToWishListLink').style.display='block';					
				}
			} else {
				if(document.getElementById('addToWishListLinkAjax')){
					dojo.style("addToWishListLinkAjaxDivContainer","display","none");
				} else if(document.getElementById('addToWishListLink')){
					dojo.style("addToWishListLinkContainer","display","none");
				}
			}
					
			if(productActionList.showProductCompare && document.getElementById('compare')){
				if(document.getElementById('addToCompareLink')){
					document.getElementById('addToCompareLink').style.display='block';
					dojo.style("addToCompareLinkContainer","display","block");
				}
			} else {
				if(document.getElementById('addToCompareLink')){
					dojo.style("addToCompareLinkContainer","display","none");
				}
			}		
			
			
			if(productActionList.showReplaceCartItem){
				if(document.getElementById('replaceCartItemAjax')){
					dojo.style("replaceCartItemAjaxContainer","display","block");
					document.getElementById('replaceCartItemAjax').style.display = 'block';
				} else if(document.getElementById('replaceCartItemNonAjax')){
					dojo.style("replaceCartItemNonAjaxContainer","display","block");
					document.getElementById('replaceCartItemNonAjax').style.display = 'block';
				}		

				//When showing the quick info pop-up for replace item flow
				//Don't show the requisition list links
				if(document.getElementById('addToNewRequisitionList')){
					dojo.style("addToNewRequisitionListContainer","display","none");

				}
				if(document.getElementById('addToExistingRequisitionList')){
					dojo.style("addToExistingRequisitionListContainer","display","none");

				}				
			} else {
				if(document.getElementById('replaceCartItemAjax')){
					dojo.style("replaceCartItemAjaxContainer","display","none");
				} else if(document.getElementById('replaceCartItemNonAjax')){
					dojo.style("replaceCartItemNonAjaxContainer","display","none");
				}		
			}		
			
			//Do not display the Quantity field if the product is not buyable
			if(!productActionList.showAddToCart && !productActionList.showWishList){
				if(document.getElementById('productPopUpQty')){
					document.getElementById('productPopUpQty').disabled = true;
				}
			} else {
				if(document.getElementById('productPopUpQty')){
					document.getElementById('productPopUpQty').disabled = false;
				}
			}
			//Set the quantity to Quantity field
			if(popUpQty == null)
			{
				document.getElementById('productPopUpQty').value = 1;
			}else {
				document.getElementById('productPopUpQty').value = popUpQty;
			}
		
			dijit.byId('second_level_category_popup').closeButtonNode.style.display='none';
			closeAllDialogs(); // close all dijit.dialogs first
			dijit.byId('second_level_category_popup').show();
			
			// hides the DialogUnderlayWrapper component, the component that grays out the screen behind,
			// as we do not want the background to be greyed out
			dojo.query('.dijitDialogUnderlayWrapper', document).forEach(function(tag) {		
				tag.style.display='none';
			});		
			
			var parameters = {};
			parameters.storeId = CommonContextsJS.storeId;
			parameters.langId=CommonContextsJS.langId;
			parameters.catalogId=CommonContextsJS.catalogId;
			parameters.productId=productId;	
	
			dojo.publish("ajaxRequestInitiated");
			dojo.xhrPost({
					url: getAbsoluteURL() + "GetCatalogEntryDetailsByID",				
					handleAs: "json-comment-filtered",
					content: parameters,
					service: this,
					load: populatePopUp,
					error: function(errObj,ioArgs) {
						console.debug("CatalogEntryThumbnailDisplay.showPopup: Unexpected error occurred during an xhrPost request.");
						dojo.publish("ajaxRequestCompleted");
					}
				});
		}
	}

	/** 
	 * Populates all the contents of the Product Quick Info pop-up with the JSON returned from the server.
	 * 
	 * @param {object} serviceRepsonse The JSON response from the service.
	 * @param {object} ioArgs The arguments from the service call.
	 */		
	function populatePopUp(serviceResponse, ioArgs) {
		//save the serviceResponse
		responseJSON = serviceResponse;
		 
		//populate the entitledItemJsonObject
		categoryDisplayJS.setEntitledItemJsonObject(serviceResponse.productAttributes);

		var catEntryID = serviceResponse.catalogEntry.catalogEntryIdentifier.uniqueID;
		var isProductBean = false;
		var singleSKUProduct = false;
		var singleSKUProduct_catEntryId = "";
		if(serviceResponse.catalogEntry.catalogEntryTypeCode=='ProductBean') {
			isProductBean = true;
			if(dojo.byId("catalogEntryTypeCode")!=null && dojo.byId("catalogEntryTypeCode")!=undefined){
				dojo.byId("catalogEntryTypeCode").value="ProductBean";
			}
			if(serviceResponse.singleSKUProduct_catEntryId && serviceResponse.singleSKUProduct_catEntryId!='') {
				singleSKUProduct = true;
				singleSKUProduct_catEntryId = serviceResponse.singleSKUProduct_catEntryId;
			}
		}
		var isBundleBean = false;
		if(serviceResponse.catalogEntry.catalogEntryTypeCode=='BundleBean') {
			isBundleBean = true;
		}
		var isItemBean = false;
		if(serviceResponse.catalogEntry.catalogEntryTypeCode=='ItemBean') {
			isItemBean = true;
			if(dojo.byId("catalogEntryTypeCode")!=null && dojo.byId("catalogEntryTypeCode")!=undefined){
				dojo.byId("catalogEntryTypeCode").value="ItemBean";
			}
		}
		
		var isPackageBean = false;
		if(serviceResponse.catalogEntry.catalogEntryTypeCode=='PackageBean') {
			isPackageBean = true;
		}
		document.getElementById('productIdQuickInfo').innerHTML = catEntryID;
		document.getElementById('productName').innerHTML = serviceResponse.catalogEntry.description[0].name;
		var baseImageUrl = dojo.byId('baseUrlImageDir').innerHTML;
		if ( serviceResponse.catalogEntry.description[0].fullImage != serviceResponse.catalogEntry.objectPath){
			document.getElementById('productFullImage').src = serviceResponse.catalogEntry.description[0].fullImage;
		}
		else{
			document.getElementById('productFullImage').src = baseImageUrl + "images/NoImageIcon.jpg";
		}
		
        /*Brazil - display non-payment promotion price */
        if ( typeof(isBrazilStore) != 'undefined' && isBrazilStore ){
			if ( isProductBean ){//if its a 'product', get the first item  
				origProductID = serviceResponse.productAttributes[0].catentry_id;
			}
			else {
				//get 'productId' from parent node because the 'productId' parameter that was
				// passed in, has been increment by 1
				// for example, productId = catentry_id+1.  
				origProductID = nodeId.match(/\d+/)[0];
			}
			// check to see if there's an existing promotion within given node 
        	var brazilFeaturedNonPaymentPromotion =  dojo.byId('WC_RightSidebarESpotDisplay_'+origProductID+'_div_1_BrazilFeaturedNonPaymentPromotion'); 		
			if ( brazilFeaturedNonPaymentPromotion != null && (dojo.query('.discount_price', brazilFeaturedNonPaymentPromotion).length != 0)){
	            dojo.style(dojo.byId('productPrice'),"display","none");
	            var id = dojo.byId('WC_PromotionDiscountDisplay_'+origProductID+'_0');            
	            dojo.addClass(dojo.byId('WC_PromotionDiscountDisplay_'+origProductID+'_0'),'promo_desc');            
	        	dojo.byId('BrazilFeaturedNonPaymentPromotion').innerHTML = brazilFeaturedNonPaymentPromotion.innerHTML;
	        }else{
				if (serviceResponse.catalogEntry.offerPrice) {
					document.getElementById('productPrice').innerHTML = serviceResponse.catalogEntry.offerPrice;
		            dojo.style(dojo.byId('productPrice'),"display","inline");

		                //move down the QTY node since no other promotions are showing
		            	if ( !dojo.isIE ){//Safari & FF are needed to adjust product quantity node
	        	        	var productQuantity = dojo.byId('productQuantity');
		            		dojo.style(productQuantity,"marginTop","-30px");
		            	}
				}
			}
		}//end of Brazil store Promotion display
        else{ //Madisons store..display offerPrice
			if (serviceResponse.catalogEntry.offerPrice) {
				document.getElementById('productPrice').innerHTML = serviceResponse.catalogEntry.offerPrice;
			}
		}
        
        /*Brazil - display featured installment option price */
        if ( typeof(isBrazilStore) != 'undefined' && isBrazilStore )
        {
            var catalogEntryFeaturedInstallmentPrice = dojo.byId('WC_CatalogEntryFeaturedInstallmentOption_'+origProductID+'_div');
            if ( catalogEntryFeaturedInstallmentPrice != null ){
                var featuredInstallmentPrice = catalogEntryFeaturedInstallmentPrice.innerHTML.replace(/^\s+|\s+$/g,"");//Remove leading and trailing blanks
                
                //display the installment option; i.e, 3x of $50.23
                if ( featuredInstallmentPrice.length != 0){
    				dojo.byId('BrazilCatalogEntryFeaturedInstallmentOption').innerHTML = catalogEntryFeaturedInstallmentPrice.innerHTML;
        	        dojo.style(dojo.byId('promoDetails'),"display","inline");

                }else{//no installment price, hide the span
                	dojo.style(dojo.byId('BrazilCatalogEntryFeaturedInstallmentOption'),"display","none");
            	}
    		}
        }//end of Brazil Store installments

		document.getElementById('productLongDescription').innerHTML = serviceResponse.catalogEntry.description[0].longDescription + '<br />';
		
		var descAttributesHTML = "";
		for (var i in serviceResponse.catalogEntryAttributes.attributes) {
			if (serviceResponse.catalogEntryAttributes.attributes[i].usage == "Descriptive" ) 
			{				
				descAttributesHTML = descAttributesHTML + serviceResponse.catalogEntryAttributes.attributes[i].name + ' : ';
				if (serviceResponse.catalogEntryAttributes.attributes[i].value != null )
				{
					descAttributesHTML = descAttributesHTML + serviceResponse.catalogEntryAttributes.attributes[i].value.value + '<br />';
				}
				else
				{
					descAttributesHTML = descAttributesHTML + '<br />';
				}			
			}
		}
		document.getElementById('productDescriptiveAttributes').innerHTML = descAttributesHTML;
		
		document.getElementById('productSKUValue').innerHTML = serviceResponse.catalogEntry.catalogEntryIdentifier.externalIdentifier.partNumber;
		document.getElementById('productMoreInfoLink').href = serviceResponse.catalogEntryURL;

		/*Brazil - show the free shipping image */
		if ( typeof(isBrazilStore) != 'undefined' && isBrazilStore ){
        	var free_shipping_div = dojo.byId('free_shipping_promotion_div');
        	var brazilFeaturedShippingPromotionDiv  = dojo.byId('WC_RightSidebarESpotDisplay_'+origProductID+'_div_1_BrazilFeaturedShippingPromotion');

        	//get innerHtml to show Free Shipping
            if ( free_shipping_div != null && brazilFeaturedShippingPromotionDiv != null ){
            	free_shipping_div.innerHTML = brazilFeaturedShippingPromotionDiv.parentNode.innerHTML + '<br />';
            }
	 	}else{
		// Brazil store not interested in all the marketing promotions
        // but Madisons store will continue to show the marketing text
    		for (var i in serviceResponse.catalogEntryPromotions) {
    			document.getElementById('productPromotions').innerHTML = serviceResponse.catalogEntryPromotions[i] + '<br />';
    		}
        }

        if(document.getElementById("selectedAttr_"+replaceOrderItemId) !=null)
		var selectedAttributeArray = document.getElementById("selectedAttr_"+replaceOrderItemId).value.toString().split("|");
		categoryDisplayJS.moreInfoUrl='ProductDisplay?storeId='+storeId+'&catalogId='+catalogId+'&langId='+langId+'&productId='+catEntryID;

		var attributesHTML = "";
		for (var i in serviceResponse.catalogEntryAttributes.attributes) {
			if (serviceResponse.catalogEntryAttributes.attributes[i].usage == "Defining") {
				if (isProductBean) {
					attributesHTML = attributesHTML + '<label for="attrValue_'+ i + '" class="nodisplay">'+serviceResponse.catalogEntryAttributes.attributes[i].name+document.getElementById('requiredFieldText').innerHTML+'</label><span class="required-field">* </span><span>' + serviceResponse.catalogEntryAttributes.attributes[i].name + ' : </span>';
					attributesHTML = attributesHTML + '<select name="attrValue" class="drop_down" id="attrValue_' + i + '" onChange="JavaScript:categoryDisplayJS.setSelectedAttribute(\'' + (serviceResponse.catalogEntryAttributes.attributes[i].name).replace("'","\\'") + '\',this.options[this.selectedIndex].value);updateMoreInfoUrl();">';
					attributesHTML = attributesHTML + '<option value="">'+document.getElementById("selectText").innerHTML+'</option>';
					for (var j in serviceResponse.catalogEntryAttributes.attributes[i].allowedValue) {
						if(document.getElementById("selectedAttr_"+replaceOrderItemId) !=null && serviceResponse.catalogEntryAttributes.attributes[i].allowedValue[j].value == selectedAttributeArray[i]){
							var selected = 'selected';
							categoryDisplayJS.setSelectedAttribute(serviceResponse.catalogEntryAttributes.attributes[i].name,selectedAttributeArray[i]);
							updateMoreInfoUrl();
							attributesHTML = attributesHTML + '<option value="' + serviceResponse.catalogEntryAttributes.attributes[i].allowedValue[j].value.replace('"','inches') +'"selected='+selected+'>' + serviceResponse.catalogEntryAttributes.attributes[i].allowedValue[j].value + '</option>';
						}
						else{
						attributesHTML = attributesHTML + '<option value="' + serviceResponse.catalogEntryAttributes.attributes[i].allowedValue[j].value.replace('"','inches') +'">' + serviceResponse.catalogEntryAttributes.attributes[i].allowedValue[j].value + '</option>';	
					}
				}
					attributesHTML = attributesHTML + '</select><br />';
				} else {
					attributesHTML = attributesHTML + serviceResponse.catalogEntryAttributes.attributes[i].name + ' : ' + serviceResponse.catalogEntryAttributes.attributes[i].value.value + '<br />';
				}
			}
		}
		if (attributesHTML != '') {
			attributesHTML = attributesHTML + '<br />';
		}
		if (isProductBean && !singleSKUProduct) {
			document.getElementById('productAttributes').innerHTML = attributesHTML;
		}
		
		if(isBundleBean){
			if(document.getElementById('productPopUpQty')){
				document.getElementById('productPopUpQty').disabled = true;
			}
			document.getElementById('productActions').style.display = 'none';
			document.getElementById('moreinfo').style.display = 'block';
		}
		else{
			document.getElementById('productActions').style.display = 'block';
			document.getElementById('moreinfo').style.display = 'none';
			
			categoryDisplayJS.setCurrentCatalogEntryId(catEntryID);
			if (isProductBean && singleSKUProduct) {
				categoryDisplayJS.setCurrentCatalogEntryId(singleSKUProduct_catEntryId);
			}
			
			//Populate the links for adding items/products/packages to requisition list
			if(isProductBean){
				if(document.getElementById('addToNewRequisitionList')){
					if (singleSKUProduct) {
						categoryDisplayJS.setCurrentPageType("item");
						document.getElementById('addToNewRequisitionList').href = "javascript:categoryDisplayJS.addItemToNewListFromProductDetail('" + singleSKUProduct_catEntryId + "', 'productPopUpQty', document.location.href);";
						document.getElementById('addToExistingRequisitionList').href = "javascript:RequisitionList.showReqListPopup('productPopUpQty');";
					} else {
						categoryDisplayJS.setCurrentPageType("product");
						document.getElementById('addToNewRequisitionList').href = "javascript:categoryDisplayJS.addToNewListFromProductDetail('entitledItem_"+catEntryID+"', 'productPopUpQty', document.location.href);";
						document.getElementById('addToExistingRequisitionList').href = "javascript:RequisitionList.showReqListPopupForItem('entitledItem_"+catEntryID+"', 'productPopUpQty');";
					}
				}				
			} else if(isItemBean || isPackageBean){
				if(document.getElementById('addToNewRequisitionList')){
					if(isItemBean){
						categoryDisplayJS.setCurrentPageType("item");
					} else {
						categoryDisplayJS.setCurrentPageType("package");
					}
					document.getElementById('addToNewRequisitionList').href = "javascript:categoryDisplayJS.addItemToNewListFromProductDetail('" + catEntryID + "', 'productPopUpQty', document.location.href);";
					document.getElementById('addToExistingRequisitionList').href = "javascript:RequisitionList.showReqListPopup('productPopUpQty');";
				}		
			}
		}
		
		// Setup addToCart button
		if(isBundleBean){
			// Disable add to cart for Bundles in all cases
			if(document.getElementById('addToCartAjaxButton')){
				document.getElementById('addToCartAjaxButton').style.visibility='hidden';
			} else if(document.getElementById('addToCartButton')){
				document.getElementById('addToCartButton').style.visibility='hidden';
			}
		} else {
			var addtoCart;
			if(document.getElementById('addToCartLinkAjax')){
				if(isProductBean) {
					if (singleSKUProduct) {
						addtoCart = document.getElementById('addToCartLinkAjax');
						addtoCart.href = "JavaScript:categoryDisplayJS.AddItem2ShopCartAjax('"+singleSKUProduct_catEntryId+"',document.getElementById('productPopUpQty').value); hidePopup('second_level_category_popup');";
					} else {
						addtoCart = document.getElementById('addToCartLinkAjax');
						addtoCart.href = "JavaScript:categoryDisplayJS.Add2ShopCartAjax('entitledItem_"+catEntryID+"',document.getElementById('productPopUpQty').value, true);";
					}
				} else {
					addtoCart = document.getElementById('addToCartLinkAjax');
					addtoCart.href = "JavaScript:categoryDisplayJS.AddItem2ShopCartAjax('"+catEntryID+"',document.getElementById('productPopUpQty').value); hidePopup('second_level_category_popup');";
				}
			}
			if(document.getElementById('addToCartLink')){
				if(isProductBean) {
					addtoCart = document.getElementById('addToCartLink');
					addtoCart.href = "#";
					//Must dynamically set the onclick event as follows for IE6
					if (singleSKUProduct) {
						addtoCart.onclick = new Function("categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_"+singleSKUProduct_catEntryId+"'),document.getElementById('productPopUpQty').value); hidePopup('second_level_category_popup');return false;");
					} else {
						addtoCart.onclick = new Function("categoryDisplayJS.Add2ShopCart('entitledItem_"+catEntryID+"',document.getElementById('OrderItemAddForm_"+catEntryID+"'),document.getElementById('productPopUpQty').value, true); return false;");
					}
				} else {
					addtoCart = document.getElementById('addToCartLink');
					addtoCart.href = "#";
					//Must dynamically set the onclick event as follows for IE6
					addtoCart.onclick = new Function("categoryDisplayJS.AddItem2ShopCart(document.getElementById('OrderItemAddForm_"+catEntryID+"'),document.getElementById('productPopUpQty').value); hidePopup('second_level_category_popup');return false;");
				}
			}
		}

		
		if (document.getElementById('addToWishListLinkAjax')) {
			if(isItemBean || isPackageBean){
				document.getElementById('addToWishListLinkAjax').href = "JavaScript:categoryDisplayJS.AddItem2WishListAjax("+catEntryID+"); hidePopup('second_level_category_popup');";
			} else if (isProductBean && singleSKUProduct) {
				document.getElementById('addToWishListLinkAjax').href = "JavaScript:categoryDisplayJS.AddItem2WishListAjax("+singleSKUProduct_catEntryId+"); hidePopup('second_level_category_popup');";
			} else {
				document.getElementById('addToWishListLinkAjax').href = "JavaScript:categoryDisplayJS.Add2WishListAjax('entitledItem_"+catEntryID+"'); hidePopup('second_level_category_popup');";
			}
		} else if(document.getElementById('addToWishListLink')) {
			document.getElementById('addToWishListLink').href = "#";
			//Must dynamically set the onclick event as follows for IE6
			if(isItemBean || isPackageBean){
				document.getElementById('addToWishListLink').onclick = new Function("categoryDisplayJS.AddItem2WishList(document.getElementById('OrderItemAddForm_"+catEntryID+"'));hidePopup('second_level_category_popup');return false;");
			} else if (isProductBean && singleSKUProduct) {
				document.getElementById('addToWishListLink').onclick = new Function("categoryDisplayJS.AddItem2WishList(document.getElementById('OrderItemAddForm_"+singleSKUProduct_catEntryId+"'));hidePopup('second_level_category_popup');return false;");
			} else {
				document.getElementById('addToWishListLink').onclick = new Function("categoryDisplayJS.Add2WishList('entitledItem_"+catEntryID+"',document.getElementById('OrderItemAddForm_"+catEntryID+"')); hidePopup('second_level_category_popup');return false;");
			}
		}
		if (document.getElementById('addToCompareLink')) {
			document.getElementById('addToCompareLink').href = "JavaScript:compareProductJS.Add2CompareAjax('"+catEntryID+"', '" + serviceResponse.productCompareImagePath +"', '" + serviceResponse.catalogEntryURL+ "','"+serviceResponse.compareImageDescription+"'); delayHidePopup();";
		}
		if (document.getElementById('replaceCartItemAjax')) {
			document.getElementById('replaceCartItemAjax').href = "JavaScript:dojo.byId('" + changeAttrId + "').disabled=1; if (dojo.byId('" + changeContractId + "') != null) {dojo.byId('" + changeContractId + "').disabled=1;} categoryDisplayJS.ReplaceItemAjax('entitledItem_"+catEntryID+"',document.getElementById('productPopUpQty').value); hidePopup('second_level_category_popup'); ";
		}
		if (document.getElementById('replaceCartItemNonAjax')) {
			document.getElementById('replaceCartItemNonAjax').href = "#";
			//Must dynamically set the onclick event as follows for IE6			
			document.getElementById('replaceCartItemNonAjax').onclick = new Function("categoryDisplayJS.ReplaceItemNonAjax('entitledItem_"+catEntryID+"',document.getElementById('productPopUpQty').value,document.getElementById('ReplaceItemForm')); hidePopup('second_level_category_popup');return false;");
		}
		gobackFocus();//set the default focus to the Close button
		
		dojo.publish("ajaxRequestCompleted");
	}
	
	/**
	 *  This function is used to dynamically update the more info link url based on the selection of attributes in the 
	 *  Quickinfo popup.
	 */

	function updateMoreInfoUrl() {
			document.getElementById('productMoreInfoLink').href = categoryDisplayJS.moreInfoUrl;
	}
	/** 
	 * Reset all contents of the Product Quick Info pop-up.
	 * This dialog will be re-used across all products on the page.
	 */			
	function resetPopUp() {
		document.getElementById('productName').innerHTML = "";
		document.getElementById('productPrice').innerHTML = "";
		document.getElementById('productLongDescription').innerHTML = "";
		document.getElementById('productDescriptiveAttributes').innerHTML = "";
		document.getElementById('productSKUValue').innerHTML = "";
		document.getElementById('productMoreInfoLink').href = "";
		document.getElementById('productPromotions').innerHTML = "";
        if ( typeof(isBrazilStore) != 'undefined' && isBrazilStore ){
        	dojo.byId('free_shipping_promotion_div').innerHTML = "";
        	dojo.byId('BrazilCatalogEntryFeaturedInstallmentOption').innerHTML = "";
        	dojo.style(dojo.byId('BrazilCatalogEntryFeaturedInstallmentOption'),"display","inline");
        	dojo.byId('BrazilFeaturedNonPaymentPromotion').innerHTML = "";
            if ( !dojo.isIE ){//Safari & FF are needed to reset product quantity node back to the normal
        	    dojo.style(dojo.byId('productQuantity'),"marginTop","0px");
            }

        }
        
		if(document.getElementById('productPopUpQty')){
			document.getElementById('productPopUpQty').disabled = false;
			document.getElementById('productPopUpQty').value = "1";
		}
		
		document.getElementById('productAttributes').innerHTML = "";
		if (document.getElementById('addToCartLinkAjax')) {
			document.getElementById('addToCartLinkAjax').href = "";
		} else if (document.getElementById('addToCartLink')) {
			document.getElementById('addToCartLink').href = "";
		}
		
		if (document.getElementById('addToWishListLinkAjax')) {
			document.getElementById('addToWishListLinkAjax').href = "";
		} else if (document.getElementById('addToWishListLink')) {
			document.getElementById('addToWishListLink').href = "";
		}
		
		if (document.getElementById('addToCompareLink')) {
			document.getElementById('addToCompareLink').href = "";
		}
		if(document.getElementById('replaceCartItemAjax')){
			document.getElementById('replaceCartItemAjax').href= "";
		} else if(document.getElementById('replaceCartItemNonAjax')){
			document.getElementById('replaceCartItemNonAjax').href = "";
		}
		//set the default product image - NoImageIcon.jpg
		if (dojo.byId('baseUrlImageDir')){
		    var baseImageUrl = dojo.byId('baseUrlImageDir').innerHTML;
		    dojo.byId('productFullImage').src = baseImageUrl + "images/NoImageIcon.jpg";
		}		
		categoryDisplayJS.selectedAttributes = new Object();
		categoryDisplayJS.selectedProducts = new Object();
	}
	
	/** 
	 * Hides the Product Quick Info pop-up.
	 * 
	 * @param {string} id The id of the Product Quick Info pop-up to hide.
	 * @param {object} event The event triggered from user actions.
	 */		
	function hidePopup(id,event){
	if(event!=null && event.type=="keypress" && event.keyCode!="27"){
			return;
		}else{		
			var quickInfo = dijit.byId(id);
			if(quickInfo != null){
				quickInfo.hide();
			}
		}
	}

	/** 
	 * Stores the identifier of the order item which is the candidate for replacement.
	 * 
	 * @param {string} changeOrderItemId The id of the order item to be replaced.
	 */	
	function saveChangeOrderItemId(changeOrderItemId){
		replaceOrderItemId = changeOrderItemId;
	}

	/** 
	 * Defines the list of actions that show up in the Product Quick Info pop-up.
	 * Each property corresponds to an action.
	 * Default settings show the first 3 links.
	 */	
	function popupActionProperties() {
		this.showAddToCart = true;
		this.showWishList = true;
		this.showProductCompare = true;
		this.showReplaceCartItem = false;
	}

	/** 
	 * Transfers the focus to the "Close" button,
	 * when pressing the <Tab> key on the last focusable element in the Product Quick Info pop-up.
	 */	
	function gobackFocus() {
		document.getElementById('closeLink').focus();
	}

	/** 
	 * Transfers the focus to the last focusable element present in the Product Quick Info pop-up,
	 * when pressing the <Shift+Tab> keys on the "Close" button.
	 */		
	function setbackFocus(event) {
		if(event.shiftKey && event.keyCode == dojo.keys.TAB)
		{
			if(document.getElementById('replaceCartItemNonAjax') && document.getElementById('replaceCartItemNonAjax').style.display!="none") {
				document.getElementById('replaceCartItemNonAjax').focus();
			} else if(document.getElementById('replaceCartItemAjax') && document.getElementById('replaceCartItemAjax').style.display!="none") {
				document.getElementById('replaceCartItemAjax').focus();
			} else if(document.getElementById('addToCompareLink') && document.getElementById('addToCompareLink').style.display!="none") {
				document.getElementById('addToCompareLink').focus();
			} else if(document.getElementById('addToWishListLink') && document.getElementById('addToWishListLink').style.display!="none") {
				document.getElementById('addToWishListLink').focus();
			} else if(document.getElementById('addToWishListLinkAjax') && document.getElementById('addToWishListLinkAjax').style.display!="none") {
				document.getElementById('addToWishListLinkAjax').focus();
			} else {
				document.getElementById('productMoreInfoLink').focus();
			}
			
			dojo.stopEvent(event);
		}
	}
	
	/** 
	 * Triggers a call to the hidePopup() function after a delay of a certain amount of time.
	 */			
	function delayHidePopup() {
		setTimeout(dojo.hitch(this,"hidePopup",'second_level_category_popup'),200);
	}
