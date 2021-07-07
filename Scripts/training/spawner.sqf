/*
Script by chrisone4

Example: Add the follow to init to set as repair bay
Eden:	[this] execVM "actions\training\spawner.sqf";
[
	_spawner, // Object that spawns entities.
] execVM "actions\training\spawner.sqf";
*/

params [
	["_spawner", objNull, [objNull]],
	["_kbArr", objNull]
];

if (isNil "ASOT_fnc_ListOfSpawn_Options" || isNil "ASOT_fnc_Spawner" || isNil "ASOT_fnc_ListOfSpawn_Options_Civilians" || isNil "ASOT_fnc_Spawner_Civilians") then {
	ASOT_fnc_ListOfSpawn_Options = {
		params ["_spawner", "", "_this"];
		params ["", "_kbArr"];

		private _chanceToSpawn = 1.0;
		
		private _spawnOptionsChild = [];
		_spawnOptionsChild pushBack [[
			"ASOT_spawner_easy",
			"Spawn Enemies - Easy",
			"\A3\ui_f\data\igui\cfg\simpletasks\types\target_ca.paa",
			{_this call ASOT_fnc_Spawner},
			{true},
			{},
			[_kbArr, _chanceToSpawn, 10]
		] call ace_interact_menu_fnc_createAction, [], 1];
		_spawnOptionsChild;
		
		_spawnOptionsChild pushBack [[
			"ASOT_spawner_medium",
			"Spawn Enemies - Medium",
			"\A3\ui_f\data\igui\cfg\simpletasks\types\target_ca.paa",
			{_this call ASOT_fnc_Spawner},
			{true},
			{},
			[_kbArr, _chanceToSpawn, 15]
		] call ace_interact_menu_fnc_createAction, [], 1];
		_spawnOptionsChild;
		
		_spawnOptionsChild pushBack [[
			"ASOT_spawner_hard",
			"Spawn Enemies - Hard",
			"\A3\ui_f\data\igui\cfg\simpletasks\types\target_ca.paa",
			{_this call ASOT_fnc_Spawner},
			{true},
			{},
			[_kbArr, _chanceToSpawn, 20]
		] call ace_interact_menu_fnc_createAction, [], 1];
		_spawnOptionsChild;
		
				_spawnOptionsChild pushBack [[
			"ASOT_spawner_hard",
			"Spawn Enemies - Very Hard",
			"\A3\ui_f\data\igui\cfg\simpletasks\types\target_ca.paa",
			{_this call ASOT_fnc_Spawner},
			{true},
			{},
			[_kbArr, _chanceToSpawn, 30]
		] call ace_interact_menu_fnc_createAction, [], 1];
		_spawnOptionsChild;
	};
	
	ASOT_fnc_ListOfSpawn_Options_Civilians = {
		params ["_spawner", "", "_this"];
		params ["", "_kbArr"];

		private _chanceToSpawn = 1.0;
		
		private _spawnOptionsChild = [];
		_spawnOptionsChild pushBack [[
			"ASOT_spawner_easy",
			"Spawn 2+ Hostages",
			"\A3\ui_f\data\igui\cfg\HoldActions\holdAction_secure_ca.paa",
			{_this call ASOT_fnc_Spawner_Civilians},
			{true},
			{},
			[_kbArr, _chanceToSpawn, 2]
		] call ace_interact_menu_fnc_createAction, [], 1];
		_spawnOptionsChild;
		
		_spawnOptionsChild pushBack [[
			"ASOT_spawner_medium",
			"Spawn 5+ Hostages",
			"\A3\ui_f\data\igui\cfg\HoldActions\holdAction_secure_ca.paa",
			{_this call ASOT_fnc_Spawner_Civilians},
			{true},
			{},
			[_kbArr, _chanceToSpawn, 5]
		] call ace_interact_menu_fnc_createAction, [], 1];
		_spawnOptionsChild;
		
		_spawnOptionsChild pushBack [[
			"ASOT_spawner_hard",
			"Spawn 10+ Hostages",
			"\A3\ui_f\data\igui\cfg\HoldActions\holdAction_secure_ca.paa",
			{_this call ASOT_fnc_Spawner_Civilians},
			{true},
			{},
			[_kbArr, _chanceToSpawn, 10]
		] call ace_interact_menu_fnc_createAction, [], 1];
		_spawnOptionsChild;
		
				_spawnOptionsChild pushBack [[
			"ASOT_spawner_hard",
			"Spawn 15+ Hostages",
			"\A3\ui_f\data\igui\cfg\HoldActions\holdAction_secure_ca.paa",
			{_this call ASOT_fnc_Spawner_Civilians},
			{true},
			{},
			[_kbArr, _chanceToSpawn, 15]
		] call ace_interact_menu_fnc_createAction, [], 1];
		_spawnOptionsChild;
	};
	
	ASOT_fnc_Spawner = {
		(_this select 2) params ["_kbArr", "_chance", "_minimumEN", "_this"];
		
		private _enCounter = 0;		
		
		while {_enCounter <= _minimumEN} do {
			{
				if(random 100 < _chance) then {
					private _group = createGroup[BLUFOR, true];
					
					private _randomEN = floor random 5;
					private _randomDir = random 360;
					private _pos = getPos _x;
					
					if(_randomEN == 0) then {
						"O_Soldier_AAR_F" createUnit [_pos, _group, "this disableAI 'PATH'; this setUnitPos 'UP'; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					if(_randomEN == 1) then {
						"O_support_AMG_F" createUnit [_pos, _group, "this disableAI 'PATH'; this setUnitPos 'UP'; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					if(_randomEN == 2) then {
						"O_engineer_F" createUnit [_pos, _group, "this disableAI 'PATH'; this setUnitPos 'UP'; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					if(_randomEN == 3) then {
						"O_Fighter_Pilot_F" createUnit [_pos, _group, "this disableAI 'PATH'; this setUnitPos 'UP'; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					if(_randomEN == 4) then {
						"O_Soldier_AAR_F" createUnit [_pos, _group, "this disableAI 'PATH'; this setUnitPos 'UP'; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					if(_randomEN == 5) then {
						"O_Soldier_AAR_F" createUnit [_pos, _group, "this disableAI 'PATH'; this setUnitPos 'UP'; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					_kbArr deleteAt _forEachIndex;
					_enCounter = _enCounter + 1;
				};
			} forEach _kbArr;
		};
		
		if(_enCounter >= _minimumEN) then {
			["Kill House Ready!", 2, player] call ace_common_fnc_displayTextStructured;
		};
	}; 
		
	ASOT_fnc_Spawner_Civilians = {
		(_this select 2) params ["_kbArr", "_chance", "_minimumCiv", "_this"];
		
		private _civCounter = 0;
		
		while {_civCounter <= _minimumCiv} do {
			{
				if(random 100 < _chance) then {
					private _group = createGroup[Civilian, true];
					
					private _randomCiv = floor random 5;
					private _randomDir = random 360;
					private _pos = getPos _x;
					
					if(_randomCiv == 0) then {
						"C_man_1" createUnit [_pos, _group, "[this, true] call ACE_captives_fnc_setHandcuffed; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					if(_randomCiv == 1) then {
						"C_man_p_beggar_F" createUnit [_pos, _group, "[this, true] call ACE_captives_fnc_setHandcuffed; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					if(_randomCiv == 2) then {
						"C_Man_casual_8_F" createUnit [_pos, _group, "[this, true] call ACE_captives_fnc_setHandcuffed; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					if(_randomCiv == 3) then {
						"C_Man_formal_4_F" createUnit [_pos, _group, "[this, true] call ACE_captives_fnc_setHandcuffed; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					if(_randomCiv == 4) then {
						"C_Man_casual_4_F" createUnit [_pos, _group, "[this, true] call ACE_captives_fnc_setHandcuffed; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					if(_randomCiv == 5) then {
						"C_Man_casual_2_F" createUnit [_pos, _group, "[this, true] call ACE_captives_fnc_setHandcuffed; this setDir _randomDir; this setPosATL _pos"]; 
					};
					
					_kbArr deleteAt _forEachIndex;
					_civCounter = _civCounter + 1;
				};
			} forEach _kbArr;
		};
		
		if(_civCounter >= _minimumCiv) then {
			["Spawning Complete", 2, player] call ace_common_fnc_displayTextStructured;
		};
	}; 
};

private _spawnspawnerEnemies = [
	"ASOT_Spawn_Option",
	"Spawn Enemies",
	"\A3\ui_f\data\igui\cfg\simpletasks\types\use_ca.paa",
	{},
	{true},
	{_this call ASOT_fnc_ListOfSpawn_Options},
	[_spawner, _kbArr]
] call ace_interact_menu_fnc_createAction;

[_spawner, 0, ["ACE_MainActions"], _spawnspawnerEnemies] call ace_interact_menu_fnc_addActionToObject;

private _spawnspawnerEnemies_Civilians = [
	"ASOT_Spawn_Option_Civilians",
	"Spawn Hostages",
	"\A3\ui_f\data\igui\cfg\simpletasks\types\use_ca.paa",
	{},
	{true},
	{_this call ASOT_fnc_ListOfSpawn_Options_Civilians},
	[_spawner, _kbArr]
] call ace_interact_menu_fnc_createAction;

[_spawner, 0, ["ACE_MainActions"], _spawnspawnerEnemies_Civilians] call ace_interact_menu_fnc_addActionToObject;