parameter maxAltitude, degreesFromNorth.

clearScreen.

lock throttle to 1.0.

print "Counting down:".
from {local countdown is 3.} until countdown = 0 step {set countdown to countdown - 1.} DO {
    print "..." + countdown.
    wait 1.
}

when maxThrust = 0 then {
    print "Staging" at (0,0).
    stage.
    preserve.
}.

set trigger to 1000.
set pitchAboveHorizon to 90.

when ship:altitude > trigger then {
    set trigger to trigger + 1000.

    if pitchAboveHorizon > 45 {
        set pitchAboveHorizon to pitchAboveHorizon - 5.
        preserve.
    }
}.

set mySteer to heading(degreesFromNorth, pitchAboveHorizon).
lock steering to mySteer.

until ship:apoapsis > maxAltitude * 1000 {
    if ship:altitude > 1000 and ship:altitude < trigger {
        set mySteer TO heading(degreesFromNorth, pitchAboveHorizon).
        print "Pitching to " + pitchAboveHorizon + " degrees" at (0,5).
    }
    
    print "->APOAPSIS TARGET: " + maxAltitude*1000 + " m" AT (0,14).
    print "->APOAPSIS NOW: " + round(ship:apoapsis) + " m" AT (0,15).
}.

print maxAltitude + " km apoapsis reached, cutting throttle".

lock throttle to 0.

set ship:control:pilotmainthrottle to 0.

run orbit(maxAltitude).
