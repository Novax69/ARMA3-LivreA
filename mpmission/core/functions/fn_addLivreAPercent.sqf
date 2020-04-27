#include "..\..\script_macros.hpp"
/*
    File: fn_addLivreAPercent.sqf
    Author: Novax
	github : https://github.com/Novax69 <== Find my other scripts for arma here
	Date : 26/04/2020

    Description: Edit the livret A account every 30 minutes of gameplay can be tweaked with donorLevel

*/

private["_donorLevel","_percent","_useDonorLevel","_percentRate"];

_useDonorLevel = true; // Change this if you want every player to have the same update on Livret A
_percentRate = 2; // Change this if you want a bigger percent added (default 2%)


// Only works if the player is a donor
if(_useDonorLevel) then {
	_donorLevel = FETCH_CONST(life_donorlevel); // don't forget to enable life_donorlevel in config_master
	_percentRate = _percentRate + (_donorLevel / 4); // Add 1/4 of the donator Level Level 1 : 2.25 / 2 => 2.5 ... 
};

while { true } do {
	_percent = round((LIVREA * _percentRate) / 100); // Add _percentRate
	sleep 1800.0; // Every 30 min
	LIVREA = LIVREA + _percent;
	[getPlayerUID player,LIVREA] remoteExecCall ["DB_fnc_updateLivreA",RSERV];
    systemChat format ["Votre livret A a augmenté de %1€ il est maintenant à %2€",[_percent] call life_fnc_numberText,[LIVREA] call life_fnc_numberText];
};
