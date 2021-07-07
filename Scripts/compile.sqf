if (isServer) then {
	//Echo Presets	
	fnc_preset_one = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_one.sqf";
	fnc_preset_two = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_two.sqf";
	fnc_preset_three = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_three.sqf";
	fnc_preset_four = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_four.sqf";
	fnc_preset_five = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_five.sqf";
	fnc_preset_six = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_six.sqf";
	fnc_preset_seven = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_seven.sqf";
	fnc_preset_eight = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_eight.sqf";
	fnc_preset_nine = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_nine.sqf";
	fnc_preset_ten = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_ten.sqf";
	fnc_preset_eleven = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_eleven.sqf";
	fnc_preset_twelve = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_twelve.sqf";
	fnc_preset_thirteen = compile preprocessFileLineNumbers "actions\echo\fortify\presets\preset_thirteen.sqf";
};
	
fnc_rearm_sholef = compile preprocessFileLineNumbers "actions\golf\RearmSholef.sqf";

if(!isDedicated) then {
	//fnc_unpackIntoBay = compile preprocessFileLineNumbers "actions\echo\repairbay\RepairBay.sqf";
	//fnc_packIntoBox = compile preprocessFileLineNumbers "actions\echo\repairbay\RepairBox.sqf";
	//arsenal_config = compile preprocessFileLineNumbers "chsa\config.sqf";
}