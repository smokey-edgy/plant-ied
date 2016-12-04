SE_fnc_pointInCircle = {
  params ["_originX", "_originY", "_radius"];
  _angle = random 1 * pi * 2;
  _r = (random 1)* _radius;
  _x = _originX + _r * (cos _angle);
  _y = _originY + _r * (sin _angle);
  _z = 0;
  [_x, _y, _z]
};

SE_fnc_randomPointNearPositionWithinRadius = {
  params ["_pos", "_radius"];
  _x = _pos select 0;
  _y = _pos select 1;
  ([_x, _y, _radius] call SE_fnc_pointInCircle)
};

SE_fnc_plantIED = {
  params ["_pos"];
  _ied = "IEDLandSmall_Remote_Ammo" createVehicle _pos;

  _trigger = createTrigger ["EmptyDetector", _pos];
  _trigger setTriggerArea  [1, 1, 0, false];
  _trigger setTriggerActivation ["ANY", "PRESENT", true];
  _trigger setTriggerStatements ["{isPlayer _x} count thisList > 0;", "_ied = (nearestObject [thisTrigger, ""IEDLandSmall_Remote_Ammo""]);
                                          _ied setDamage 1;
                                          ",
                                          ""];
};

_randomNearbyPoint = ([position player, 150] call SE_fnc_randomPointNearPositionWithinRadius);
([_randomNearbyPoint] call SE_fnc_plantIED);
