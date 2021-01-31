CLEARSCREEN.

LOCK THROTTLE TO 1.0.

PRINT "Counting down:".
FROM {local countdown is 3.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "..." + countdown.
    WAIT 1.
}

WHEN MAXTHRUST = 0 THEN {
    PRINT "Staging".
    STAGE.
    PRESERVE.
}.

SET mysteer TO HEADING(90,90).
LOCK STEERING TO mysteer. // from now on we'll be able to change steering by just assigning a new value to MYSTEER

UNTIL SHIP:APOAPSIS > 85000 { //apoasis limit

    IF SHIP:ALTITUDE > 1000 AND SHIP:ALTITUDE < 2000 {
        SET MYSTEER TO HEADING(90,85).
        PRINT "Pitching to 85 degrees" AT(0,5).

    } ELSE IF SHIP:ALTITUDE > 2000 AND SHIP:ALTITUDE < 3000 {
        SET MYSTEER TO HEADING(90,80).
        PRINT "Pitching to 80 degrees" AT(0,6).
    
    } ELSE IF SHIP:ALTITUDE > 3000 AND SHIP:ALTITUDE < 4000 {
        SET MYSTEER TO HEADING(90,75).
        PRINT "Pitching to 75 degrees" AT(0,7).

    } ELSE IF SHIP:ALTITUDE > 4000 AND SHIP:ALTITUDE < 5000 {
        SET MYSTEER TO HEADING(90,70).
        PRINT "Pitching to 70 degrees" AT(0,8).

    } ELSE IF SHIP:ALTITUDE > 5000 AND SHIP:ALTITUDE < 6000 {
        SET MYSTEER TO HEADING(90,65).
        PRINT "Pitching to 65 degrees" AT(0,9).

    } ELSE IF SHIP:ALTITUDE > 6000 AND SHIP:ALTITUDE < 7000 {
        SET MYSTEER TO HEADING(90,60).
        PRINT "Pitching to 60 degrees" AT(0,10).

    } ELSE IF SHIP:ALTITUDE > 7000 AND SHIP:ALTITUDE < 8000 {
        SET MYSTEER TO HEADING(90,55).
        PRINT "Pitching to 55 degrees" AT(0,11).

    } ELSE IF SHIP:ALTITUDE > 8000 AND SHIP:ALTITUDE < 9000 {
        SET MYSTEER TO HEADING(90,50).
        PRINT "Pitching to 50 degrees" AT(0,12).

    } ELSE IF SHIP:ALTITUDE > 9000 AND SHIP:ALTITUDE < 10000 {
        SET MYSTEER TO HEADING(90,45).
        PRINT "Pitching to 45 degrees" AT(0,13).
        PRINT "----------------------" AT(0,14).

    } ELSE {
        PRINT "->APOAPSIS: " + ROUND(SHIP:APOAPSIS) AT (0,15).
    }.

}.

PRINT "85km apoapsis reached, cutting throttle".

LOCK THROTTLE TO 0.

SET SHIP:CONTROL:PILOTMAINTHROTTLE TO 0.

RUN orbit.
