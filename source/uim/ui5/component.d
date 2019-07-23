module uim.ui5.component;

import uim.ui5;

class DUI5Component : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }
	this(string someContent) { super(someContent); }
	this(DUI5App myApp, string someContent) { super(myApp, someContent); }

	mixin(OProperty!("string[string]", "libs")); 

	O loadFrom(this O)(Database db, UUID appid) {
		foreach(row; db.execute("SELECT * FROM components WHERE (id = '%s')".format(appid)).cached) {
			return loadFrom(db, row);
		}
		return null;
	}
	O loadFrom(this O)(Database db, CachedResults.CachedRow row) {
		if (row) {
			auto libsFullNames = rows["libfullnames"].split(",");
			foreach(ref n; libsFullNames) n = n.strip;

			auto libsNames = rows["libnames"].split(",");
			foreach(ref n; libsNames) n = n.strip;

			return cast(O)this;
		}
		return null;
	}

	override string toString() {
		string[] fullNames;
		string[] names;
		foreach(k, v; libs) {
			fullNames ~= "'k'";
			names ~= v;
		}
		return `sap.ui.define([`~fullNames.join(",")~`],
			function(`~names.join(",")~`) {
				"use strict";
				
				var Component = UIComponent.extend("`~app.name~`.Component", {
					metadata : {
						manifest : "json"
						}
					});
				return Component;
			});`;
	}
}
auto UI5Component() { return new DUI5Component; }

unittest {
	auto component = UI5Component;
}

/** 
 * sap.ui.define(['jquery.sap.global', 'sap/ui/core/UIComponent'],
	function(jQuery, UIComponent) {
	"use strict";

	var Component = UIComponent.extend("samples.components.sample.Component", {
		metadata : {
			manifest : "json"
		}
	});
	return Component;
});
**/

