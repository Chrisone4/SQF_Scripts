/*
Script by chrisone4

Example: Add the follow to init to set as repair bay
Eden:	[this, 10, 300] execVM "actions\echo\supplies\refuel_tanker.sqf";
Zeus:	[this, 10, 300] execVM "actions\echo\supplies\refuel_tanker.sqf";
[
	_tanker, // Object that contains an interior tank that can be refueled.
	10, // Range
	300 // How much each barrel should refuel to
] execVM "actions\echo\supplies\refuel_tanker.sqf";
*/

params [
	["_ammoTruck", objNull, [objNull]],
	["_range", 10, [0]],
	["_resupplyAmmount", 0, [0]]
];

if (_range < 5) then { _range = 5; };
if (_range > 20) then { _range = 20; };

if (isNil "ASOT_fnc_ListOfResupplyBoxes" || isNil "ASOT_fnc_resupply") then {
	ASOT_fnc_ListOfResupplyBoxes = {
		params ["_ammoTruck", "", "_this"];
		params ["_range", "_resupplyAmmount"];
		//params ["_refuelAmount"];
	
		private _nearObjects = nearestObjects [_ammoTruck, ["Box_EAF_AmmoVeh_F"], _range];
		private _resupplyAmmoChild = [];
		
		{
			private _class = typeOf _x;
			private _name = getText (configfile >> "CfgVehicles" >> _class >> "displayName");
			
			_resupplyAmmoChild pushBack [[
				"ASOT_resupplyAmmo",
				//"Replenish Fuel Supplies from Barrels",
				format ["Replenish Ordnance from %1", _name],
				"\A3\ui_f\data\igui\cfg\actions\settimer_ca.paa", //Change images
				{_this call ASOT_fnc_resupply},
				{true},
				{},
				[_x, _ammoTruck, _resupplyAmmount]
			] call ace_interact_menu_fnc_createAction, [], 1];
			_resupplyAmmoChild;
		} forEach _nearObjects;
	};
	
	ASOT_fnc_resupply = {
		(_this select 2) params ["_ammoSource", "_ammoTruck", "_resupplyAmmount", "_this"];
	
		_refuelTankerTimer = 40;
		private _animation = getText (ConfigFile >> "ACE_Repair" >> "Actions" >> "MiscRepair" >> "animationCaller");
		player playMoveNow _animation;
		
		[
			_refuelTankerTimer, [_ammoSource, _ammoTruck, _resupplyAmmount], {
				(_this select 0) params ["_ammoSource", "_ammoTruck", "_resupplyAmmount"];
				
				player switchMove '';
				
				[_ammoTruck, _resupplyAmmount] call ace_rearm_fnc_setSupplyCount;
				deleteVehicle _ammoSource;
			},
			{
				player switchMove '';
			},
			format ["Resupplying Ordnance...", _name]
		] call ace_common_fnc_progressBar;
	}; 
};

private _resupplyAmmo = [
	"ASOT_resupplyAmmo_Option",
	"Resupply Ordnance from Small Container", //Get name of classID
	"\A3\ui_f\data\igui\cfg\cursors\explosive_ca.paa", //Change images
	{},
	{true},
	{_this call ASOT_fnc_ListOfResupplyBoxes},
	[_range, _resupplyAmmount]
] call ace_interact_menu_fnc_createAction;

[_ammoTruck, 0, ["ACE_MainActions"], _resupplyAmmo] call ace_interact_menu_fnc_addActionToObject;
