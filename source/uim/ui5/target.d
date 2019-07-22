module uim.ui5.target;

import uim.ui5;

class DUI5Target  : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }

	mixin(DataProperty!("string", "viewName"));
	mixin(DataProperty!("string", "title"));
	mixin(DataProperty!("string", "viewId"));
	mixin(DataProperty!("int", "viewLevel"));
	mixin(DataProperty!("string", "viewType")); //XML, JSON, JS, HTML, Template
	mixin(DataProperty!("string", "controlId"));
	mixin(DataProperty!("string", "viewPath"));
	mixin(DataProperty!("string", "parent"));
	mixin(DataProperty!("string", "controlAggregation"));
	mixin(DataProperty!("string", "transition")); // slide, flip, fade, show
	mixin(DataProperty!("string", "clearAggregation"));

	O loadFrom(this O)(Database db, UUID appid, string viewName) {
		foreach(row; db.execute("SELECT * FROM fragments WHERE (id = '%s') AND (viewname = '%s')".format(id, viewName)).cached) {
			return loadFrom(db, row);
		}
		return null;
	}
	O loadFrom(this O)(Database db, CachedResults.CachedRow row) {
		if (auto x = loadFrom(db, row)) {
			viewName = row["viewName"].as!string;
			if (row["title"].isNotNull) title = row["title"].as!string;
			if (row["viewid"].isNotNull) viewId = row["viewid"].as!string;
			if (row["viewlevel"].isNotNull) viewLevel = row["viewlevel"].as!int;
			if (row["viewtype"].isNotNull) viewType = row["viewtype"].as!string;
			if (row["controlid"].isNotNull) controlId = row["controlid"].as!string;
			if (row["viewpath"].isNotNull) viewPath = row["viewpath"].as!string;
			if (row["parent"].isNotNull) parent = row["parent"].as!string;
			if (row["controlaggregation"].isNotNull) controlAggregation = row["controlaggregation"].as!string;
			if (row["transition"].isNotNull) transition = row["transition"].as!string;
			if (row["clearaggregation"].isNotNull) clearAggregation = row["clearaggregation"].as!string;

			return cast(O)this;
		}
		return null;
	}

	override string toString() {
		string[] inners;
		if (viewName) inners ~= `viewName: "%s"`.format(viewName);
		if (viewType) inners ~= `viewType: "%s"`.format(viewType);
		if (viewLevel) inners ~= `viewLevel: %s`.format(viewLevel);
		if (viewPath) inners ~= `viewPath: "%s"`.format(viewPath);
		if (parent) inners ~= `parent: "%s"`.format(parent);
		if (controlId) inners ~= `controlId: "%s"`.format(controlId);
		if (controlAggregation) inners ~= `controlAggregation: "%s"`.format(controlAggregation);

		return "%s: {
			%s			
		}".format(viewName, inners.join(","));
	}
}
auto UI5Target() { return new DUI5Target; }

unittest {
	auto target = UI5Target; 
}