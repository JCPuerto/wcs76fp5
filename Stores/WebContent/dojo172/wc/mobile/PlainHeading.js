//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2011 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

dojo.provide("wc.mobile.PlainHeading");

dojo.require("dojox.mobile.Heading");

dojo.declare("wc.mobile.PlainHeading", [ dojox.mobile.Heading ], {

	buildRendering: function() {
		this.domNode = this.containerNode = this.srcNodeRef;
	},

	_setBackAttr: function(/*String*/back){
		console.log(this.domNode);
		if(!this._btn){
			var btn = dojo.create("DIV", this.backProp, this.domNode, "first");
			//var head = dojo.create("DIV", {className:""}, btn);
			var body = btn;

			this._body = body;
			//this._head = head;
			this._btn = btn;
			this.backBtnNode = btn;
			this.connect(body, "onclick", "onClick");
			//var neck = dojo.create("DIV", {className:""}, btn);
		}
		this.back = back;
		this._body.innerHTML = this._cv(this.back);
		//this.resize();
	}

});
