#include "..\..\script_macros.hpp"
/*
    File: fn_withdrawLivreA.sqf
    Author: Novax
	github : https://github.com/Novax69 <== Find my other scripts for arma here
    Date : 26/04/2020

    Description:
    Retire l'argent dans le livret A
    withdraw the A book :D
*/

private ["_value","_playerUID"];
_value = parseNumber(ctrlText 690015);
_playerUID = getPlayerUID player;




if (_value > 999999) exitWith {hint localize "STR_ATM_GreaterThan";};
if (_value < 0) exitWith {};
if (!([str(_value)] call TON_fnc_isnumber)) exitWith {hint localize "STR_ATM_notnumeric"};
if (_value > LIVREA) exitWith {hint "Pas assez d'argent dans le livre A"};

CASH = CASH + _value;
LIVREA = LIVREA - _value;

[_playerUID,LIVREA] remoteExecCall ["DB_fnc_updateLivreA",RSERV];



hint format["Tu as bien retiré %1 € de ton livret A",[_value] call life_fnc_numberText];
[] call life_fnc_livretAMenu;
[6] call SOCK_fnc_updatePartial; //Silent Sync