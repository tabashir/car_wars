CLS

INPUT "Number of Cars ", num
DIM name$(num)
DIM speed(num)
DIM pha$(5, 10)
DIM hc(num)
DIM hcdata(30, 17)
DIM hctemp(num)
DIM driver(num)
GOSUB getdata
n = 0
WHILE n < num
n = n + 1
PRINT "Please input name for driver "; n;
INPUT name$(n)
INPUT "What is your handling class"; hc(n)
INPUT "What is your driver skill"; driver(n)
hctemp(n) = hc(n)
WEND

GOSUB initspeed

REM main program loop

progloop:
FOR phase = 1 TO 5
endphase:
CLS
COLOR 7
PRINT "The following have a half-move sometime this turn :"
PRINT
FOR n = 1 TO num
tempspeed = speed(n)
COLOR 2
IF tempspeed / 10 <> INT(tempspeed / 10) THEN PRINT name$(n)
COLOR 7
NEXT n
PRINT
GOSUB checkmove
GOSUB printhandling
COLOR 12
PRINT "NB Always change HC before Speed when Braking !!!"
COLOR 7
INPUT "<RETURN>, next phase, H,  change Handling Class, S, change speed, Q, quit ", nt$
IF nt$ = "Q" OR nt$ = "q" THEN END
IF nt$ = "h" OR nt$ = "H" THEN GOSUB handling
IF nt$ = "h" OR nt$ = "H" THEN GOTO endphase
IF nt$ = "s" OR nt$ = "S" THEN GOSUB speedchange
IF nt$ = "s" OR nt$ = "S" THEN GOTO endphase
IF phase = 5 THEN GOSUB endofturn
NEXT phase
REM INPUT "Speed Change Anybody (<Return> = continue game)", ans$
REM IF ans$ = "Y" OR ans$ = "y" THEN GOSUB speedchange
GOSUB updatehc
GOTO progloop

endofturn:
CLS
PRINT "End of Turn"
FOR w = 1 TO 100000
NEXT w

checkmove:
COLOR 3
PRINT "Phase : "; phase
PRINT
COLOR 7
PRINT "These players move this Phase:"
PRINT
n = 0
WHILE n < num
n = n + 1
tempspeed = speed(n)
flag = 0
IF tempspeed > 250 THEN flag = 6
IF tempspeed > 250 THEN tempspeed = tempspeed - 250
IF tempspeed > 200 THEN flag = 5
IF tempspeed > 200 THEN tempspeed = tempspeed - 200
IF tempspeed > 150 THEN flag = 4
IF tempspeed > 150 THEN tempspeed = tempspeed - 150
IF tempspeed > 100 THEN flag = 3
IF tempspeed > 100 THEN tempspeed = tempspeed - 100
IF tempspeed > 50 THEN flag = 2
IF tempspeed > 50 THEN tempspeed = tempspeed - 50
tempspeed = tempspeed / 5
COLOR 2
IF pha$(phase, tempspeed) = "y" AND flag = 6 THEN PRINT name$(n); " (6 Spaces)"
IF pha$(phase, tempspeed) = "y" AND flag = 5 THEN PRINT name$(n); " (5 Spaces)"
IF pha$(phase, tempspeed) = "y" AND flag = 4 THEN PRINT name$(n); " (4 Spaces)"
IF pha$(phase, tempspeed) = "y" AND flag = 3 THEN PRINT name$(n); " (3 spaces)"
IF pha$(phase, tempspeed) = "y" AND flag = 2 THEN PRINT name$(n); " (2 Spaces)"
IF pha$(phase, tempspeed) = "y" AND flag = 0 THEN PRINT name$(n)
IF pha$(phase, tempspeed) = "n" AND flag = 6 THEN PRINT name$(n); " (5 Spaces)"
IF pha$(phase, tempspeed) = "n" AND flag = 5 THEN PRINT name$(n); " (4 Spaces)"
IF pha$(phase, tempspeed) = "n" AND flag = 4 THEN PRINT name$(n); " (3 Spaces)"
IF pha$(phase, tempspeed) = "n" AND flag = 3 THEN PRINT name$(n); " (2 Spaces)"
IF pha$(phase, tempspeed) = "n" AND flag = 2 THEN PRINT name$(n)
COLOR 7
WEND
PRINT
RETURN

updatehc:
FOR n = 1 TO num
IF hc(n) < 0 THEN hctemp(n) = hctemp(n) - hc(n) - driver(n)
hctemp(n) = hctemp(n) + hc(n) + driver(n)
IF hctemp(n) > hc(n) THEN hctemp(n) = hc(n)
NEXT n
RETURN

speedchange:
FOR n = 1 TO num
PRINT n; " : "; name$(n); " "; speed(n); " Mph."
NEXT n

speedch:
INPUT "Which Car (<RETURN> = Continue Game)"; cou
IF cou = 0 THEN RETURN
IF cou > num THEN GOTO speedch
IF cou < 0 THEN GOTO speedch
INPUT "What is your change in speed "; spdchg
IF spdchg <> INT(spdchg) THEN PRINT "invalid amount, try again.": GOTO speedch
speed(cou) = speed(cou) + spdchg
GOTO speedchange
RETURN

initspeed:
n = 0
WHILE n < num
n = n + 1
PRINT "Please enter "; name$(n); "`s initial speed ";
INPUT speed(n)
CHECK = speed(n)
GOSUB CHECK
WEND
RETURN

CHECK:
IF (CHECK / 5) = INT(CHECK / 5) THEN RETURN
n = n - 1
PRINT "Invalid entry, speed must be in units of 5, please try again"
flag = 1
RETURN

getdata:
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-2
DATA 2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,-2
DATA 4,4,3,2,1,1,1,1,1,1,1,1,1,1,1,1,-2
DATA 5,4,3,2,2,1,1,1,1,1,1,1,1,1,1,1,0
DATA 6,4,3,2,2,1,1,1,1,1,1,1,1,1,1,1,1
DATA 6,5,4,3,2,1,1,1,1,1,1,1,1,1,1,1,1
DATA 7,5,4,3,2,2,1,1,1,1,1,1,1,1,1,1,2
DATA 7,6,5,4,3,2,1,1,1,1,1,1,1,1,1,1,2
DATA 7,7,5,4,3,2,1,1,1,1,1,1,1,1,1,1,3
DATA 7,7,6,5,4,3,1,1,1,1,1,1,1,1,1,1,3
DATA 7,7,6,5,4,3,2,1,1,1,1,1,1,1,1,1,4
DATA 7,7,7,5,4,3,2,1,1,1,1,1,1,1,1,1,4
DATA 7,7,7,6,5,4,3,1,1,1,1,1,1,1,1,1,5
DATA 7,7,7,7,5,4,3,2,1,1,1,1,1,1,1,1,5
DATA 7,7,7,7,6,5,4,3,1,1,1,1,1,1,1,1,6
DATA 7,7,7,7,7,5,4,3,1,1,1,1,1,1,1,1,6
DATA 7,7,7,7,7,5,4,3,2,1,1,1,1,1,1,1,7
DATA 7,7,7,7,7,7,4,3,2,1,1,1,1,1,1,1,7
DATA 7,7,7,7,7,7,4,3,2,1,1,1,1,1,1,1,8
DATA 7,7,7,7,7,7,7,4,3,2,1,1,1,1,1,1,8
DATA 7,7,7,7,7,7,7,5,4,2,1,1,1,1,1,1,9
DATA 7,7,7,7,7,7,7,6,4,2,1,1,1,1,1,1,9
DATA 7,7,7,7,7,7,7,6,4,3,2,1,1,1,1,1,10
DATA 7,7,7,7,7,7,7,6,5,4,2,1,1,1,1,1,10
DATA 7,7,7,7,7,7,7,7,6,4,3,1,1,1,1,1,11
DATA 7,7,7,7,7,7,7,7,6,5,3,2,1,1,1,1,11
DATA 7,7,7,7,7,7,7,7,7,6,4,2,1,1,1,1,12
DATA 7,7,7,7,7,7,7,7,7,6,5,3,1,1,1,1,12
DATA 7,7,7,7,7,7,7,7,7,6,5,3,2,1,1,1,13
DATA 7,7,7,7,7,7,7,7,7,7,6,4,2,1,1,1,13
FOR n = 1 TO 30
FOR t = 1 TO 17
READ hcdata(n, t)
NEXT t
NEXT n
DATA y,y,y,y,y,y,y,y,y,y
DATA n,n,n,n,n,n,y,y,y,y
DATA n,n,y,y,y,y,y,y,y,y
DATA n,n,n,n,n,n,n,n,y,y
DATA n,n,n,n,y,y,y,y,y,y
FOR n = 1 TO 5
FOR t = 1 TO 10
READ pha$(n, t)
NEXT t
NEXT n
RETURN

printhandling:
COLOR 2
PRINT
FOR n = 1 TO num
PRINT n; " : "; name$(n), "     HC : "; hctemp(n), "   Speed : "; speed(n)
NEXT n
PRINT
RETURN

handling:
FOR n = 1 TO num
PRINT n; " : "; name$(n), "     HC : "; hctemp(n), "   Speed : "; speed(n)
NEXT n
althandling:
COLOR 7
INPUT "Which Car (<RETURN> = Continue Game)"; cou
IF cou = 0 THEN RETURN
IF cou > num THEN GOTO althandling
IF cou < 0 THEN GOTO althandling
hcinput:
PRINT "Current Handling Class is :"; hctemp(cou)
INPUT "What modification"; hcmd
IF hcmd <> INT(hcmd) THEN PRINT "Input invalid, try again": GOTO hcinput
IF hcmd > 10 THEN PRINT "Input invalid, try again": GOTO hcinput
IF hcmd < 1 THEN PRINT "Input invalid, try again": GOTO hcinput
INPUT "Is this permanent <RETURN> = No"; per$
IF per$ <> "" THEN hc(cou) = hc(cou) - hcmd: GOTO handling
hctemp(cou) = hctemp(cou) - hcmd
IF hctemp(cou) < -6 THEN hctemp(cou) = -6
PRINT "New Handling Class is : "; hctemp(cou)
hccheck(cou) = hctemp(cou)
GOSUB hccheck
GOTO handling

hccheck:
COLOR 7
make$ = ""
tempspeed = speed(cou)
IF tempspeed / 5 <> INT(tempspeed / 5) THEN tempspeed = tempspeed + 5
tempspeed = tempspeed / 10
ctmod = hcdata(tempspeed, 17)
testfig = hccheck(cou) + 7
test = hcdata(tempspeed, testfig)
IF test = 1 THEN PRINT "Still Safe!!": RETURN
IF test = 7 THEN GOSUB crash
IF test < 7 THEN PRINT "You need a "; test; " did you make it <RETURN> for Yes"; : INPUT make$
IF make$ <> "" THEN GOSUB crash
RETURN

crash:
IF make$ = "Y" OR make$ = "y" THEN RETURN
GOSUB getroll
mhtinput:
INPUT "Is this a due to a Manoeuvre,Hazard or is there a trailer attached (M/H/T)"; mht$
IF mht$ <> "M" AND mht$ <> "m" AND mht$ <> "H" AND mht$ <> "h" AND mht$ <> "T" AND mht$ <> "t" THEN PRINT "It must be one of the three": GOTO mhtinput
INPUT "What was the difficulty of the maneuver/hazard ?"; dmod
roll = roll + ctmod + driver(cou) + dmod - 3
PRINT
IF mht$ = "m" OR mht$ = "M" THEN GOSUB mantable
IF mht$ = "h" OR mht$ = "H" THEN GOSUB haztable
IF mht$ = "t" OR mht$ = "T" THEN GOSUB rigtable
RETURN

getroll:
PRINT "Oh shit,its die rolling time......."
PRINT "The modifier is : "; ctmod
inptroll:
INPUT "What did you roll (Without any modifier)"; roll
IF roll <> INT(roll) THEN PRINT "incorrect input,try again": GOTO inptroll
RETURN

mantable:
IF roll <= 2 THEN PRINT "Trivial (1/4 inch) skid.": PRINT "Weapon fire now at -3": RETURN
IF roll > 2 AND roll < 5 THEN PRINT "Minor (1/2 inch) skid. Speed reduced by 5mph": PRINT "Weapon fire now at -6": RETURN
IF roll > 4 AND roll < 7 THEN PRINT "Moderate (3/4 inch) skid. Tyres take 1 point of damage": PRINT "Speed reduced by 10 mph. Trival skid next move": PRINT "Weapon fire now at -6": RETURN
IF roll > 6 AND roll < 9 THEN PRINT "Severe (1 inch) skid. Tyres takes 2 damage.": PRINT "Speed reduced by 20 mph. Minor skid on next move": PRINT "No further Non-Auto Fire.": RETURN
IF roll > 8 AND roll < 11 THEN PRINT "Spun out. Tyres take 1D damage at start (see comp. pg 14)": RETURN
IF roll > 10 AND roll < 13 THEN PRINT "Rolling.........(see comp pg 14)": RETURN
IF roll > 12 AND roll < 15 THEN PRINT "Rolling.........Burning on a 4,5 or 6(see comp pg 14)": RETURN
IF roll > 15 THEN PRINT "Hope you got wings!!!!!! (see comp pg 14)": RETURN
RETURN

haztable:
IF roll < 5 THEN PRINT "Minor (1/4 inch) fishtail. Weapon fire now at -3": RETURN
IF roll > 4 AND roll < 9 THEN PRINT "Major (1/2 inch) fishtail. Weapon fire now at -6": RETURN
IF roll > 8 AND roll < 11 THEN PRINT "Minor (1/4 inch) fishtail. No further Non-Auto Weapon fire"
IF roll > 10 AND roll < 15 THEN PRINT "Major (1/2 inch) fishtail.": PRINT "No further Non-Auto Weapon fire."
IF roll > 15 THEN PRINT "BIG (3/4 inch) fishtail. No further Non-Auto Weapon fire"
GOSUB getroll
roll = roll + ctmod + driver(cou) + dmod - 3
GOSUB mantable
RETURN

rigtable:
IF roll < 0 THEN PRINT "Tractor does Trivial (1/4 inch) skid.": PRINT "Weapon fire now at -3": RETURN
IF roll = 0 OR roll = 1 THEN PRINT "Trailer does Minor (1/4 inch) fishtail.": PRINT "Weapon fire now at -3": RETURN
IF roll = 2 OR roll = 3 THEN PRINT "Tractor does Minor (1/2 inch) skid.": PRINT "Weapon fire now at -6": RETURN
IF roll = 4 THEN PRINT "Trailer does Major (1/2 inch) fishtail.": PRINT "Weapon fire now at -6": RETURN
IF roll = 5 OR roll = 6 THEN PRINT "Tractor does Minor (1/4 inch) skid.": PRINT "Trailer does Major (1/2 inch) fishtail.": PRINT "Weapon fire now at -6": RETURN
IF roll = 7 OR roll = 8 THEN PRINT "Tractor does Major (3/4 inch) skid.": PRINT "Trailer does BIG (3/4 inch) fishtail.": PRINT "No further Non-Auto Weapon fire.": RETURN
IF roll = 9 OR roll = 10 THEN PRINT "Trailer does Extreme (1 inch) fishtail.": PRINT "No further Non-Auto Weapon fire.": RETURN
IF roll = 11 OR roll = 12 THEN PRINT "Tractor does Extreme (1 inch) skid.": PRINT "Trailer does Extreme (1 inch) fishtail.": PRINT "No further Non-Auto Weapon fire.": RETURN
IF roll = 13 THEN PRINT "Kingpin breaks. D2 hazard and 5th wheel takes 1d-2.": PRINT "No further Non-Auto Weapon fire.": RETURN
IF roll = 14 OR roll = 15 THEN PRINT "Kingpin breaks. D2 hazard and 5th wheel takes 1d-2. Trailer rolls.": PRINT "No further Non-Auto Weapon fire.": RETURN
IF roll = 16 THEN PRINT "Kingpin breaks. Tractor rolls (burning on a 4,5,6)!! 5th wheel takes 1d-2.": PRINT "No further Non-Auto Weapon fire.": RETURN
IF roll = 17 THEN PRINT "Kingpin breaks. Tractor and Trailer rolls (burning on a 4,5,6)!!. 5th wheel takes 1d-2.": PRINT "No further Non-Auto Weapon fire.": RETURN
IF roll = 18 THEN PRINT "Kingpin breaks. Tractor flips. 5th wheel takes 1d-2.": PRINT "No further Non-Auto Weapon fire.": RETURN
IF roll > 18 THEN PRINT "Kingpin breaks. Tractor flips,Trailer rolls. 5th wheel takes 1d-2.": PRINT "No further Non-Auto Weapon fire.": RETURN
RETURN

