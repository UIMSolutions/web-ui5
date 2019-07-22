module uim.ui5.route;

import uim.ui5;

class DUI5Route  : DUI5AppObj {
	this() { super(); }
	this(DUI5App myApp) { super(myApp); }

	mixin(DataProperty!("STRING", "name"));
	mixin(DataProperty!("STRING", "pattern"));
	mixin(DataProperty!("STRING", "target"));
	mixin(DataProperty!("BOOL", "greedy"));
	mixin(DataProperty!("STRING", "parent"));

	string[] targets() { return null; }

	O loadFrom(this O)(Database db, CachedResults.CachedRow row) {
		if (row) {
			return cast(O)this;
		}
		return null;
	}

	override string toString() {
		string[] inners;
		if (pattern) inners ~= `pattern: "%s"`.format(pattern);
		if (name) inners ~= `name: "%s"`.format(name);
		if (target) inners ~= `target: "%s"`.format(target);
		if (greedy) inners ~= `greedy: %s`.format(greedy);
		if (parent) inners ~= `parent: "%s"`.format(parent);

		return "{
			%s			
		}".format(inners.join(","));
	}
}
auto UI5Route() { return new DUI5Route; }

unittest {
	auto route = UI5Route;
}