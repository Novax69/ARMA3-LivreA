#include "..\..\script_macros.hpp"
/*
    File: fn_depositLivreA.sqf
    Author: Novax
   	github : https://github.com/Novax69 <== Find my other scripts for arma here
    Date : 26/04/2020

    Description:
    Depose l'argent dans le livret A
    Deposit inside the A book :D
*/

private ["_value","_playerUID","_depositLimit","_aboveNb","_useDonorLevel"];
_value = parseNumber(ctrlText 690015);
_depositLimit = LIFE_SETTINGS(getNumber,"nov_depositLimit");
_useDonorLevel = LIFE_SETTINGS(getNumber,"nov_useDonator");

if(_useDonorLevel) then {
	_donorLevel = FETCH_CONST(life_donorlevel); // don't forget to enable life_donorlevel in config_master
	_depositLimit = _depositLimit + (10000 * _donorLevel); // Bigger Limit for donators
};

_playerUID = getPlayerUID player;

if (_value > 999999) exitWith {hint localize "STR_ATM_GreaterThan";};
if (_value < 0) exitWith {};
if (!([str(_value)] call TON_fnc_isnumber)) exitWith {hint localize "STR_ATM_notnumeric"};
if (_value > CASH) exitWith {hint localize "STR_ATM_NotEnoughCash"};
if (_value + LIVREA > _depositLimit) exitWith {
    _aboveNb = (_value + LIVREA) - _depositLimit; // Dit de combien c'est dépassé
    hint format["La limite sur le compte est de %1€, tu as mis %2 € de trop",[_depositLimit] call life_fnc_numberText,[_aboveNb] call life_fnc_numberText];
};


CASH = CASH - _value;
LIVREA = LIVREA + _value;



[_playerUID,LIVREA] remoteExecCall ["DB_fnc_updateLivreA",RSERV];

hint format["Vous avez bien déposé %1 € dans votre livret A",[_value] call life_fnc_numberText];

[] call life_fnc_livretAMenu;
[6] call SOCK_fnc_updatePartial; //Silent Sync
