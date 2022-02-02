module uim.ui5;

// import from Phobos 
public import std.stdio;
public import std.string;
public import std.conv;
public import std.file;
public import std.uuid;

// import from external packages 
public import vibe.d;

// import from uim packages 
public import uim.core;
public import uim.oop;
public import uim.javascript;
public import uim.json;
public import uim.html;

// import from internal modules 
// public import uim.ui5.index;
public import uim.ui5.apps;
public import uim.ui5.appobj;
public import uim.ui5.control;
// public import uim.ui5.controller;
public import uim.ui5.css;
public import uim.ui5.component;
public import uim.ui5.data;
public import uim.ui5.formatter;
public import uim.ui5.fragment;
// public import uim.ui5.i18n;
// public import uim.ui5.manifest;
public import uim.ui5.model;
public import uim.ui5.repository;
public import uim.ui5.route;
public import uim.ui5.routes;
public import uim.ui5.target;
public import uim.ui5.targets;
public import uim.ui5.test;
// public import uim.ui5.view;
 
template DataProperty(string datatype, string name, bool key = false) {
	const char[] DataProperty = `
		@property void `~name~`(T)(T aValue) { if (("`~name~`" in properties) && (properties["`~name~`"])) properties["`~name~`"].value(aValue); else properties["`~name~`"] = new DData(aValue, `~((key) ? `true`:`false`)~`);}
		@property DData `~name~`() { if ("`~name~`" in properties) return properties["`~name~`"]; return null; }
	`;
}

class DData {
private: 
	Datatypes _datatype;
	bool bValue;
	int iValue;
	double dValue;
	string sValue;
	UUID uValue;

public:
	bool isNull = true;
	bool isKey = false;

	this(Datatypes aDatatype, bool aKey = false) { _datatype = aDatatype; isKey = aKey; }

	this(bool aValue, bool aKey = false)   { _datatype = Datatypes.BOOL; value = aValue; isNull = false; isKey = aKey; }
	this(int aValue, bool aKey = false)    { _datatype = Datatypes.INT; value = aValue; isNull = false; isKey = aKey; }
	this(double aValue, bool aKey = false) { _datatype = Datatypes.DOUBLE; value = aValue; isNull = false; isKey = aKey; }
	this(string aValue, bool aKey = false) { _datatype = Datatypes.STRING; value = aValue; isNull = false; isKey = aKey; }
	this(UUID aValue, bool aKey = false)   { _datatype = Datatypes.ID; value = aValue; isNull = false; isKey = aKey; }

	this(Datatypes aDatatype, bool aValue, bool aKey = false) { this(aDatatype); value = aValue; isNull = false; isKey = aKey; }
	this(Datatypes aDatatype, int aValue, bool aKey = false) { this(aDatatype); value = aValue; isNull = false; isKey = aKey; }
	this(Datatypes aDatatype, double aValue, bool aKey = false) { this(aDatatype); value = aValue; isNull = false; isKey = aKey; }
	this(Datatypes aDatatype, string aValue, bool aKey = false) { this(aDatatype); value = aValue; isNull = false; isKey = aKey; }
	this(Datatypes aDatatype, UUID aValue, bool aKey = false) { this(aDatatype); value = aValue; isNull = false; isKey = aKey; }
	// this(Datatypes aDatatype, ColumnData aValue, bool aKey = false) { this(aDatatype); value = aValue; isNull = false; isKey = aKey; }

	alias toString this;

	@property void value(bool newValue) {
		final switch(_datatype) {
			case Datatypes.BOOL: bValue = newValue; isNull = false; break;
			case Datatypes.INT: iValue = (newValue) ? 1 : 0; isNull = false; break;
			case Datatypes.DOUBLE: dValue = (newValue) ? 1 : 0; isNull = false; break;
			case Datatypes.STRING: sValue = (newValue) ? "1" : "0"; isNull = false; break;
			case Datatypes.ID: return;
		}
	}
	@property void value(int newValue) {
		final switch(_datatype) {
			case Datatypes.BOOL: bValue = (newValue != 0); isNull = false; break;
			case Datatypes.INT: iValue = newValue; isNull = false; break;
			case Datatypes.DOUBLE: dValue = to!double(newValue); isNull = false; break;
			case Datatypes.STRING: sValue = to!string(newValue); isNull = false; break;
			case Datatypes.ID: return;
		}
	}
	@property void value(double newValue) {
		final switch(_datatype) {
			case Datatypes.BOOL: bValue = (newValue != 0); isNull = false; break;
			case Datatypes.INT: iValue = to!int(newValue); isNull = false; break;
			case Datatypes.DOUBLE: dValue = newValue; isNull = false; break;
			case Datatypes.STRING: sValue = to!string(newValue); isNull = false; break;
			case Datatypes.ID: return;
		}
	}
	@property void value(string newValue) {
		final switch(_datatype) {
			case Datatypes.BOOL: bValue = (newValue != "0"); isNull = false; break;
			case Datatypes.INT: iValue = to!int(newValue); isNull = false; break;
			case Datatypes.DOUBLE: dValue = to!double(newValue); isNull = false; break;
			case Datatypes.STRING: sValue = newValue; isNull = false; break;
			case Datatypes.ID: uValue = UUID(newValue); isNull = false; break;
		}
	}
	@property void value(UUID newValue) {
		final switch(_datatype) {
			case Datatypes.BOOL: return;
			case Datatypes.INT: return;
			case Datatypes.DOUBLE: return;
			case Datatypes.STRING: sValue = newValue.toString; isNull = false; break;
			case Datatypes.ID: uValue = newValue; isNull = false; break;
		}
	}

	/* @property void value(ColumnData newValue) {
		final switch(_datatype) {
			case Datatypes.BOOL: bValue = newValue.as!bool; isNull = false; break;
			case Datatypes.INT: iValue = newValue.as!int; isNull = false; break;
			case Datatypes.DOUBLE: dValue = newValue.as!double; isNull = false; break;
			case Datatypes.STRING: sValue = newValue.as!string; isNull = false; break;
			case Datatypes.ID: uValue = UUID(newValue.as!string); isNull = false; break;
		}
	} */

	string toJSON() {
		if (isNull) return "NULL";
		final switch(_datatype) {
			case Datatypes.BOOL: return (bValue) ? "true" : "false";
			case Datatypes.INT: return to!string(iValue);
			case Datatypes.DOUBLE: return to!string(dValue);
			case Datatypes.STRING: return `"%s"`.format(sValue);
			case Datatypes.ID: return `"%s"`.format(uValue);
		}
	}
	override string toString() {
		if (isNull) return "NULL";
		final switch(_datatype) {
			case Datatypes.BOOL: return (bValue) ? "1" : "0";
			case Datatypes.INT: return to!string(iValue);
			case Datatypes.DOUBLE: return to!string(dValue);
			case Datatypes.STRING: return to!string(sValue);
			case Datatypes.ID: return uValue.toString;
		}
	}
	string[] toStrings(string seperator = ",") {
		if (isNull) return null;
		if (_datatype == Datatypes.STRING) return sValue.split(seperator);
		return [toString];
	}
	string toSQL() {
		if (isNull) return "NULL";
		final switch(_datatype) {
			case Datatypes.BOOL: return (bValue) ? "1" : "0";
			case Datatypes.INT: return to!string(iValue);
			case Datatypes.DOUBLE: return to!string(dValue);
			case Datatypes.STRING: return "'%s'".format(sValue);
			case Datatypes.ID: return "'%s'".format(uValue);
		}
	}
}
auto Data(Datatypes aDatatype, bool aKey = false) { return new DData(aDatatype, aKey); }
auto Data(bool aValue, bool aKey = false) { return new DData(aValue, aKey); }
auto Data(int aValue, bool aKey = false) { return new DData(aValue, aKey); }
auto Data(double aValue, bool aKey = false) { return new DData(aValue, aKey); }
auto Data(string aValue, bool aKey = false) { return new DData(aValue, aKey); }
auto Data(UUID aValue, bool aKey = false) { return new DData(aValue, aKey); }

auto Data(Datatypes aDatatype, bool aValue, bool aKey = false) { return new DData(aDatatype, aValue, aKey); }
auto Data(Datatypes aDatatype, int aValue, bool aKey = false) { return new DData(aDatatype, aValue, aKey); }
auto Data(Datatypes aDatatype, double aValue, bool aKey = false) { return new DData(aDatatype, aValue, aKey); }
auto Data(Datatypes aDatatype, string aValue, bool aKey = false) { return new DData(aDatatype, aValue, aKey); }
auto Data(Datatypes aDatatype, UUID aValue, bool aKey = false) { return new DData(aDatatype, aValue, aKey); }
// auto Data(Datatypes aDatatype, ColumnData aValue, bool aKey = false) { return new DData(aDatatype, aValue, aKey); }


enum Datatypes {
	STRING, BOOL, INT, DOUBLE, ID 
}

unittest {
	assert(Data(false).toString == "0");
	assert(Data(true).toString == "1");

	assert(Data(0).toString == "0");
	assert(Data(1).toString == "1");

	assert(Data(0.0).toString == "0.0");
	assert(Data(1.0).toString == "1.0");

	assert(Data("000").toString == "000");
	assert(Data("111").toString == "111");
}

/* Defines a JavaScript module with its ID, its dependencies and a module export value or factory. */
string ui5Define(string[] modules, string[] parameters, string content) {
	return jsFCall("sap.ui.define", [
		jsArray(modules), 
		jsFunc(parameters, content)
	])~`;`;
} 
unittest {
	assert(ui5Define(["a","b"], ["a","b"], "return x;") == "sap.ui.define([a,b],function(a,b){return x;});");
}

/* Defines a JavaScript module with its ID, its dependencies and a module export value or factory. */
string ui5Require(string[] modules, string[] parameters, string content) {
	return jsFCall("sap.ui.require", [
		jsArray(modules), 
		jsFunc(parameters, content)
	])~`;`;
} 
unittest {
	assert(ui5Require(["a","b"], ["a","b"], "return x;") == "sap.ui.define([a,b],function(a,b){return x;});");
}

string ui5Extend(string rootClass, string newClass, string[string] properties) {
	return `%s.extend(%s,%s);`.format(rootClass, newClass, jsObject(properties));
}
unittest {
	/// TODO
}
