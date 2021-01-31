parameter maxAltitude.

clearScreen.

lock target to kerbin.

set maxAltitude to 240.
set steeringAltitude to (maxAltitude * 1000) * 0.95.

set targetMu to target:mu.
set targetRadius to target:radius.
set speedNeededToOrbit to sqrt(targetMu / (targetRadius + (maxAltitude * 1000))).

// if trgt:tostring = "kerbin" {
// 	lock target to kerbin.
// 	print ">Target to orbit KERBIN" at (0,15).
// } else if trgt:tostring = "mun" {
// 	lock target to mun.
// 	print ">Target to orbit MUN" at (0,15).
// } else if trgt:tostring = "minmus" {
// 	lock target to minmus.
// 	print ">Target to orbit MINMUS" at (0,15).
// } else {
// 	lock target to kerbin.
// 	print ">Target to orbit ELSE" at (0,15).
// }

print "Waiting to reach 80 km to create the maneuver node..." at (0,0).

until ship:altitude >= 80000 {
	print "Ship altitude: " + ship:altitude + " m" at (0,1).
}.

set apoapsisTime to time:seconds+eta:apoapsis.
print "apoapsisTime: " + apoapsisTime.

set vApoapsis to velocityAt(ship, apoapsisTime):obt:mag.
print "vApoasis: " + vApoapsis.

set deltaV to speedNeededToOrbit - vApoapsis.
print "deltaV: " + deltaV.

set myNode to node(eta:apoapsis+time:seconds, 0, 0, deltaV).
add myNode.

//------------------------------------------------------------
//calculate ship's max acceleration
set max_acc to ship:maxthrust/ship:mass.

set burn_duration to myNode:deltav:mag/max_acc.
print "Raw Estimated burn duration: " + (burn_duration) + " s".

// set np to myNode:deltav. //points to node, don't care about the roll direction.
// lock steering to np.

//now we need to wait until the burn vector and ship's facing are aligned
// wait until vang(np, ship:facing:vector) < 0.25.

//the ship is facing the right direction, let's wait for our burn time
// wait until myNode:eta <= (burn_duration/2).
//------------------------------------------------------------
wait 10.

// set max_acc to ship:maxthrust / ship:mass.
// set burn_duration to myNode:deltav:mag / max_acc.

print "____________/FIXED\____________" at (0,0).
print ">Target to orbit: " + target at (0,1).
print ">OrbitSpeed: " + round(speedNeededToOrbit) + " m/s" at (0,2).
print ">Waiting to reach " + steeringAltitude/1000 + "km to steer to node" at (0,3).

// calculando a velocidade para orbitar
until ship:altitude > steeringAltitude { // maxAltitude = 240km => 95% = 228km
	print "___________/UPDATES\___________" at (0,4).
	print ">ETA:SHIP: " + round(eta:apoapsis) + " seg" at (0,5).
	print ">NODE:ETA: " + (myNode:ETA) + " seg" at (0,6).
	print ">BURN DUR. " + (burn_duration) + " seg" at (0,7).
	print ">BURN START. " + round(burn_duration/2) + " seg" at (0,8).
}.

set mySteer to ship:prograde.
lock steering to mySteer.

// UNTIL SHIP:APOAPSIS < (SHIP:PERIAPSIS + 5000) {
until ship:velocity:orbit:mag >= speedNeededToOrbit {
	print "___________/UPDATES\___________" at (0,4).
	print ">ETA:SHIP: " + round(eta:apoapsis) + " seg" at (0,5).
	print ">NODE:ETA: " + (myNode:ETA) + " seg" at (0,6).
	print ">BURN DUR. " + (burn_duration) + " seg" at (0,7).
	print ">BURN START. " + round(burn_duration/2) + "seg" at (0,8).

	set mySteer to myNode:deltav.

	if myNode:eta <= burn_duration / 2 and throttle < 1.0 {
		lock throttle to 1.0.
	}
}.

lock throttle TO 0.

remove myNode.

print "The ship is orbting.".
print "Apoapsis: " + obt:apoapsis/1000 + " km".
print "Periapsis:" + obt:periapsis/1000 + " km".

set ship:control:pilotmainthrottle to 0.
