/*
Script by chrisone4
*/

/* Current Problems:
- Script not running on initial sholefs (Need to move it a little)
- Sholef not reloading while someone's the vehicle
- Two people reloading Sholef is pretty finickky
- Laser Guided Rounds disappear mid-flight
- Sholef not realoating at all
*/

#define ammoTrucks "Car", "Box_NATO_AmmoVeh_F"

params [
	["_sholef", objNull, [objNull]],
	["_range", 10, [0]]
];

if (_range < 5) then { _range = 5; };
if (_range > 30) then { _range = 30; };

if (isNil "ASOT_fnc_Rearm_list" || isNil "ASOT_fnc_Rearm_Hex") then {
	ASOT_fnc_Rearm_list = {
		params ["_sholef", "", "_this"];
		params ["_range"];

		private _nearObjects = nearestObjects [_sholef, [ammoTrucks], _range];
		private _ammoTruck = _nearObjects select 0;
		
		private _ACE_defaultSupplyCount = 1200;
		/*
		Only if the closest vehicle does not have a supply count above the default value (1200), then the _sholef loops through the other vehicles
		*/
		if(!([_ammoTruck] call ace_rearm_fnc_getSupplyCount > _ACE_defaultSupplyCount) && (alive _ammoTruck)) then {
			{
				if (alive _x) then {
					if([_x] call ace_rearm_fnc_getSupplyCount > _ACE_defaultSupplyCount) exitWith {
						_ammoTruck  = _x;
					};
				};
			} forEach _nearObjects;
		};
		
		private _actions = [];
		
		/*
		Catches if _ammoTruck is a vehicle that has more than the default supply value 
		AND if _nearObjects is empty (i.e. no vehicles around)
		*/
		if([_ammoTruck] call ace_rearm_fnc_getSupplyCount > _ACE_defaultSupplyCount) then {
			private _class = typeOf _ammoTruck;
			private _name = getText (configfile >> "CfgVehicles" >> _class >> "displayName");
			
			_actions pushBack [[
				"rearm_Hex",
				format ["HE Rnds from %1", _name],
				"\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa",
				{_this call ASOT_fnc_Rearm_Hex},
				{true},
				{},
				[_ammoTruck, _sholef, _range, "itc_land_g155hex", 24]
			] call ace_interact_menu_fnc_createAction, [], _range];
			
			_actions pushBack [[
				"rearm_smo",
				format ["Smoke Rnds from %1", _name],
				"\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa",
				{_this call ASOT_fnc_Rearm_Hex},
				{true},
				{},
				[_ammoTruck, _sholef, _range, "itc_land_g155smo", 24]
			] call ace_interact_menu_fnc_createAction, [], _range];
			
			_actions pushBack [[
				"rearm_ill",
				format ["Illum Rnds from %1", _name],
				"\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa",
				{_this call ASOT_fnc_Rearm_Hex},
				{true},
				{},
				[_ammoTruck, _sholef, _range, "itc_land_g155ill", 5]
			] call ace_interact_menu_fnc_createAction, [], _range];
			
			_actions pushBack [[
				"rearm_icm",
				format ["DPICM Rnds from %1", _name],
				"\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa",
				{_this call ASOT_fnc_Rearm_Hex},
				{true},
				{},
				[_ammoTruck, _sholef, _range, "itc_land_g155icm", 5]
			] call ace_interact_menu_fnc_createAction, [], _range];
			
			_actions pushBack [[
				"rearm_map",
				format ["AP Mine Rnds from %1", _name],
				"\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa",
				{_this call ASOT_fnc_Rearm_Hex},
				{true},
				{},
				[_ammoTruck, _sholef, _range, "itc_land_g155map", 5]
			] call ace_interact_menu_fnc_createAction, [], _range];
			
			_actions pushBack [[
				"rearm_mat",			
				format ["AT Mine Rnds from %1", _name],
				"\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa",
				{_this call ASOT_fnc_Rearm_Hex},
				{true},
				{},
				[_ammoTruck, _sholef, _range, "itc_land_g155mat", 5]
			] call ace_interact_menu_fnc_createAction, [], _range];
			
			_actions pushBack [[
				"rearm_pgm",
				format ["GPS Rnds from %1", _name],
				"\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa",
				{_this call ASOT_fnc_Rearm_Hex},
				{true},
				{},
				[_ammoTruck, _sholef, _range, "itc_land_g155pgm", 24]
			] call ace_interact_menu_fnc_createAction, [], _range];
			
			_actions pushBack [[
				"rearm_lgm",
				format ["LG Rnds from %1", _name],
				"\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa",
				{_this call ASOT_fnc_Rearm_Hex},
				{true},
				{},
				[_ammoTruck, _sholef, _range, "itc_land_g155lgm", 24]
			] call ace_interact_menu_fnc_createAction, [], _range];
			
			_actions pushBack [[
				"rearm_ext",
				format ["AT Parachute Rnds from %1", _name],
				"\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa",
				{_this call ASOT_fnc_Rearm_Hex},
				{true},
				{},
				[_ammoTruck, _sholef, _range, "itc_land_g155ext", 5]
			] call ace_interact_menu_fnc_createAction, [], _range];	
			_actions
		};
	};

	ASOT_fnc_Rearm_Hex = {
		(_this select 2) params ["_ammoTruck", "_sholef", "_range", "_ammoType", "_maximumAmount"];
		
		_shells = _sholef magazinesTurret [0];
		private _shellCounter = 0;
		{
			if(_x == _ammoType) then {
				_shellCounter = _shellCounter + 1;
			};
			
		} forEach _shells;		
		
		if(_shellCounter < _maximumAmount) then {
			private _amountToReload = (_maximumAmount - _shellCounter);
			private _suppliesInTruck = [_ammoTruck] call ace_rearm_fnc_getSupplyCount;
			
			private _suppliesNeeded = _amountToReload * 155;
			if(_suppliesInTruck < _suppliesNeeded) then {
				["Warning: Not enough supplies avaliable, continuing will lead to a partially filled magazine", 2, player] call ace_common_fnc_displayTextStructured
			};
			
			private _reloadMultiplier = 4;
			private _reloadTime = _amountToReload * _reloadMultiplier;
			//private _reloadTime = 1;
	
			[ 
				_reloadTime, [_ammoTruck, _sholef, _ammoType, _suppliesInTruck, _reloadMultiplier, _amountToReload], {
					(_this select 0) params["_ammoTruck", "_sholef","_ammoType", "_suppliesInTruck", "", "_amountToReload"];
					
					for "_i" from 1 to _amountToReload do {
						if([_ammoTruck] call ace_rearm_fnc_getSupplyCount < 155) exitWith {["Not enough Ammo Supply to reach full Magazine capacity", 2, player] call ace_common_fnc_displayTextStructured};
						
						_sholef addMagazineTurret [_ammoType,[0]];
						[_ammoTruck, _ammoType] call ace_rearm_fnc_removeMagazineFromSupply;
					};
					
					//playSound["A3\Sounds_F\sfx\blip1.wav", _sholef];
					//playSound "reloadSound";
				},
				{
					(_this select 0) params["_ammoTruck", "_sholef","_ammoType", "_suppliesInTruck", "_reloadMultiplier", ""];
					
					private _elapsedTime = floor (CBA_missionTime - _startTime);
					private _partialReloadAmount = floor (_elapsedTime/_reloadMultiplier);
					
					for "_i" from 1 to _partialReloadAmount do {
						if([_ammoTruck] call ace_rearm_fnc_getSupplyCount < 155) exitWith {["Not enough Ammo Supply to reach full Magazine capacity", 2, player] call ace_common_fnc_displayTextStructured};
						
						_sholef addMagazineTurret [_ammoType,[0]];
						[_ammoTruck, _ammoType] call ace_rearm_fnc_removeMagazineFromSupply;
					};
					[format["%1 Shell(s) Reloaded", _partialReloadAmount], 2, player] call ace_common_fnc_displayTextStructured;
					//playSound["A3\Sounds_F\sfx\blip1.wav", _sholef];
				},
				"Rearming Sholef..."
			] call ace_common_fnc_progressBar;
			
			/*
			This is designed to prevent overloading ammo by having two people reload in tadem,
			with 1 going until progress bar is completed and other cancelling (failing) at the last second.
			
			Currently, it works? but doesn't put ammo back into the Ammo Truck
			
			_postReloadShells = _sholef magazinesTurret [0];
			private _postReloadShellCounter = 0;
			{
				if(_x == _ammoType) then {
					_postReloadShellCounter = _postReloadShellCounter + 1;
				};
				
			} forEach _postReloadShells;
			systemChat str _postReloadShellCounter;
			
			if(_maximumAmount < _postReloadShellCounter) then {
				private _ammoToReturn = _postReloadShellCounter - _maximumAmount;
				for "_i" from 1 to _ammoToReturn do {
					_sholef removeMagazineTurret [_ammoType, [0]];
					[_ammoTruck, _ammoType] call ace_rearm_fnc_addMagazineFromSupply;
				};
			};
			*/
		} else {
			[format["At Maximum Shell Capacity %1/%2", _shellCounter, _maximumAmount], 2, player] call ace_common_fnc_displayTextStructured;
		};
	};
};

private _action = [
	"ASOT_RearmSholef",
	"Rearm Sholef",
	"\A3\ui_f\data\igui\cfg\weaponicons\aa_ca.paa",
	{},
	{true},
	{_this call ASOT_fnc_Rearm_list},
	[_range]
] call ace_interact_menu_fnc_createAction;

["itc_land_b_SPH_Sholef2", 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;