import GUI
% CAMERON RUSHTON'S ISU

/* TABLE OF CONTENTS - Do CNTRL G

Sound: 85
Procedures & Set Boxes(Empty): 129
Title Screen: 1176
P1 Bricks: 1212
P2 Bricks: 3613
Draw Paddles: 5632
AI: 5668
Ball Collision With Ball: 5705
Ball Collision to Paddle: 5799
Pause Game: 5920
End Screen: 5944

*/
% Variables for Start Screen       % PLAYER ONE's BALL RANDOMLY SETS ychange to 0
var c : string (1)
var name1, name2 : string
name2 := "GLaDOS"
var computerName, userName : string
computerName := Sys.GetComputerName
userName := Sys.GetUserName
% Options
var Sound : boolean := true
% For Bricks
var setBox_x1, setBox_y1, setBox_x2, setBox_y2 : array 1 .. 6 of int
var box_x1, box_y1, box_x2, box_y2, Ebox_x1, Ebox_y1, Ebox_x2, Ebox_y2 : array 1 .. 120 of int
var countBox : int := 1
var isThere : array 1 .. 120 of boolean
% For Ball
var ball_1y, ball_2y : int := 200
var ball_2x : int := 1100
var ball_1x :int := 500
var xchange := -7
var xchange2 := 7
var ychange, ychange2 :int := 0
% For Paddles
var y1 : int := 160
var y2 : int := 160
var chars1 : array char of boolean
var bot : boolean := false 
% Other
var HomeFont := Font.New ("serif:16")
var bigFont := Font.New ("timesnewroman:56")
var font := Font.New ("timesnewroman:40")
var colours : int
var score1, score2 : int := 0
var unpause :boolean := false
% For Sound
const Hit_Wall : string := "HW.wav"
const Hit_Brick : string := "HB.wav"
const Hit_Paddle : string := "HP.wav"
const Loose_Ball : string := "LB.wav"
% AI %
var TrackP1Ball, TrackAIBall : boolean := false
% End AI %
/***************\
 * Set Bricks *
 \*************/

% Set Boxes - Creates each brick location based off of the first brick coords and stores the locations
setBox_x1 (1) := 650 % ... in an array to be called upon later via. procedures.
setBox_y1 (1) := 840
setBox_x2 (1) := 665
setBox_y2 (1) := 900
for i : 2 .. 13 % How many rows
    setBox_x1 (2) := setBox_x1 (1)
    setBox_y1 (2) := setBox_y1 (1) - 62 * i
    setBox_x2 (2) := setBox_x2 (1)
    setBox_y2 (2) := setBox_y2 (1) - 62 * i
    % First Red Block
    box_x1 (countBox) := setBox_x1 (2) + 20
    box_y1 (countBox) := setBox_y1 (2)
    box_x2 (countBox) := setBox_x2 (2) + 20
    box_y2 (countBox) := setBox_y2 (2)
    countBox += 1
    for j : 2 .. 7 % How many each row
	setBox_x1 (3) := setBox_x1 (2) + 20 * j
	setBox_y1 (3) := setBox_y1 (2)
	setBox_x2 (3) := setBox_x2 (2) + 20 * j
	setBox_y2 (3) := setBox_y2 (2)
	% All Blue Blocks
	box_x1 (countBox) := setBox_x1 (3) + 62
	box_y1 (countBox) := setBox_y1 (3)
	box_x2 (countBox) := setBox_x2 (3) + 62
	box_y2 (countBox) := setBox_y2 (3)
	countBox += 1
	if j = 7 then % Last Red Block
	    box_x1 (countBox) := setBox_x1 (3) + 128
	    box_y1 (countBox) := setBox_y1 (3)
	    box_x2 (countBox) := setBox_x2 (3) + 128
	    box_y2 (countBox) := setBox_y2 (3)
	    countBox += 1
	end if
    end for
end for

% Sound Processes
process PlayHitWall
	Music.PlayFile (Hit_Wall)
end PlayHitWall

process PlayHitPaddle
	Music.PlayFile (Hit_Paddle)
end PlayHitPaddle

process PlayLooseBall
	Music.PlayFile (Loose_Ball)
end PlayLooseBall

process PlayHitBrick
	Music.PlayFile (Hit_Brick)
end PlayHitBrick

% Unpause
procedure DoUnPause
unpause := true
end DoUnPause

% Procedures for Title Screen
procedure DoNothing (status : boolean)
end DoNothing

procedure exitprogram
quit  %                 Make This Into Close Window
end exitprogram

% AI %
procedure MoveUp
y2 += 10
end MoveUp

procedure MoveDown
y2 -= 10
end MoveDown

procedure Stop
y2 += 0
end Stop
% End AI %

% ROW ONE of DRAW BRICKS
% First Red
procedure drawbox1
    drawfillbox (box_x1 (1), box_y1 (1), box_x2 (1), box_y2 (1), 40)
end drawbox1

% Blue
procedure drawbox2
    drawfillbox (box_x1 (2), box_y1 (2), box_x2 (2), box_y2 (2), 34)
end drawbox2

% Blue
procedure drawbox3
    drawfillbox (box_x1 (3), box_y1 (3), box_x2 (3), box_y2 (3), 34)
end drawbox3

% Blue
procedure drawbox4
    drawfillbox (box_x1 (4), box_y1 (4), box_x2 (4), box_y2 (4), 34)
end drawbox4

% Blue
procedure drawbox5
    drawfillbox (box_x1 (5), box_y1 (5), box_x2 (5), box_y2 (5), 34)
end drawbox5

% Blue
procedure drawbox6
    drawfillbox (box_x1 (6), box_y1 (6), box_x2 (6), box_y2 (6), 34)
end drawbox6

% Blue
procedure drawbox7
    drawfillbox (box_x1 (7), box_y1 (7), box_x2 (7), box_y2 (7), 34)
end drawbox7

% Last Red
procedure drawbox8
    drawfillbox (box_x1 (8), box_y1 (8), box_x2 (8), box_y2 (8), 40)
end drawbox8

% ROW TWO
% First Red
procedure drawbox9
    drawfillbox (box_x1 (9), box_y1 (9), box_x2 (9), box_y2 (9), 40)
end drawbox9

% Blue
procedure drawbox10
    drawfillbox (box_x1 (10), box_y1 (10), box_x2 (10), box_y2 (10), 34)
end drawbox10

% Blue
procedure drawbox11
    drawfillbox (box_x1 (11), box_y1 (11), box_x2 (11), box_y2 (11), 34)
end drawbox11

% Blue
procedure drawbox12
    drawfillbox (box_x1 (12), box_y1 (12), box_x2 (12), box_y2 (12), 34)
end drawbox12

% Blue
procedure drawbox13
    drawfillbox (box_x1 (13), box_y1 (13), box_x2 (13), box_y2 (13), 34)
end drawbox13

% Blue
procedure drawbox14
    drawfillbox (box_x1 (14), box_y1 (14), box_x2 (14), box_y2 (14), 34)
end drawbox14

% Blue
procedure drawbox15
    drawfillbox (box_x1 (15), box_y1 (15), box_x2 (15), box_y2 (15), 34)
end drawbox15

% Last Red
procedure drawbox16
    drawfillbox (box_x1 (16), box_y1 (16), box_x2 (16), box_y2 (16), 40)
end drawbox16

% ROW THREE
% First Red
procedure drawbox17
    drawfillbox (box_x1 (17), box_y1 (17), box_x2 (17), box_y2 (17), 40)
end drawbox17

% Blue
procedure drawbox18
    drawfillbox (box_x1 (18), box_y1 (18), box_x2 (18), box_y2 (18), 34)
end drawbox18

% Blue
procedure drawbox19
    drawfillbox (box_x1 (19), box_y1 (19), box_x2 (19), box_y2 (19), 34)
end drawbox19

% Blue
procedure drawbox20
    drawfillbox (box_x1 (20), box_y1 (20), box_x2 (20), box_y2 (20), 34)
end drawbox20

% Blue
procedure drawbox21
    drawfillbox (box_x1 (21), box_y1 (21), box_x2 (21), box_y2 (21), 34)
end drawbox21

% Blue
procedure drawbox22
    drawfillbox (box_x1 (22), box_y1 (22), box_x2 (22), box_y2 (22), 34)
end drawbox22

% Blue
procedure drawbox23
    drawfillbox (box_x1 (23), box_y1 (23), box_x2 (23), box_y2 (23), 34)
end drawbox23

% Last Red
procedure drawbox24
    drawfillbox (box_x1 (24), box_y1 (24), box_x2 (24), box_y2 (24), 40)
end drawbox24

% ROW FOUR
% First Red
procedure drawbox25
    drawfillbox (box_x1 (25), box_y1 (25), box_x2 (25), box_y2 (25), 40)
end drawbox25

% Blue
procedure drawbox26
    drawfillbox (box_x1 (26), box_y1 (26), box_x2 (26), box_y2 (26), 34)
end drawbox26

% Blue
procedure drawbox27
    drawfillbox (box_x1 (27), box_y1 (27), box_x2 (27), box_y2 (27), 34)
end drawbox27

% Blue
procedure drawbox28
    drawfillbox (box_x1 (28), box_y1 (28), box_x2 (28), box_y2 (28), 34)
end drawbox28

% Blue
procedure drawbox29
    drawfillbox (box_x1 (29), box_y1 (29), box_x2 (29), box_y2 (29), 34)
end drawbox29

% Blue
procedure drawbox30
    drawfillbox (box_x1 (30), box_y1 (30), box_x2 (30), box_y2 (30), 34)
end drawbox30

% Blue
procedure drawbox31
    drawfillbox (box_x1 (31), box_y1 (31), box_x2 (31), box_y2 (31), 34)
end drawbox31

% Last Red
procedure drawbox32
    drawfillbox (box_x1 (32), box_y1 (32), box_x2 (32), box_y2 (32), 40)
end drawbox32

% ROW FIVE
% First Red
procedure drawbox33
    drawfillbox (box_x1 (33), box_y1 (33), box_x2 (33), box_y2 (33), 40)
end drawbox33

% Blue
procedure drawbox34
    drawfillbox (box_x1 (34), box_y1 (34), box_x2 (34), box_y2 (34), 34)
end drawbox34

% Blue
procedure drawbox35
    drawfillbox (box_x1 (35), box_y1 (35), box_x2 (35), box_y2 (35), 34)
end drawbox35

% Blue
procedure drawbox36
    drawfillbox (box_x1 (36), box_y1 (36), box_x2 (36), box_y2 (36), 34)
end drawbox36

% Blue
procedure drawbox37
    drawfillbox (box_x1 (37), box_y1 (37), box_x2 (37), box_y2 (37), 34)
end drawbox37

% Blue
procedure drawbox38
    drawfillbox (box_x1 (38), box_y1 (38), box_x2 (38), box_y2 (38), 34)
end drawbox38

% Blue
procedure drawbox39
    drawfillbox (box_x1 (39), box_y1 (39), box_x2 (39), box_y2 (39), 34)
end drawbox39

% Last Red
procedure drawbox40
    drawfillbox (box_x1 (40), box_y1 (40), box_x2 (40), box_y2 (40), 40)
end drawbox40

% ROW SIX
% First Red
procedure drawbox41
    drawfillbox (box_x1 (41), box_y1 (41), box_x2 (41), box_y2 (41), 40)
end drawbox41

% Blue
procedure drawbox42
    drawfillbox (box_x1 (42), box_y1 (42), box_x2 (42), box_y2 (42), 34)
end drawbox42

% Blue
procedure drawbox43
    drawfillbox (box_x1 (43), box_y1 (43), box_x2 (43), box_y2 (43), 34)
end drawbox43

% Blue
procedure drawbox44
    drawfillbox (box_x1 (44), box_y1 (44), box_x2 (44), box_y2 (44), 34)
end drawbox44

% Blue
procedure drawbox45
    drawfillbox (box_x1 (45), box_y1 (45), box_x2 (45), box_y2 (45), 34)
end drawbox45

% Blue
procedure drawbox46
    drawfillbox (box_x1 (46), box_y1 (46), box_x2 (46), box_y2 (46), 34)
end drawbox46

% Blue
procedure drawbox47
    drawfillbox (box_x1 (47), box_y1 (47), box_x2 (47), box_y2 (47), 34)
end drawbox47

% Last Red
procedure drawbox48
    drawfillbox (box_x1 (48), box_y1 (48), box_x2 (48), box_y2 (48), 40)
end drawbox48

% ROW SEVEN
% First Red
procedure drawbox49
    drawfillbox (box_x1 (49), box_y1 (49), box_x2 (49), box_y2 (49), 40)
end drawbox49

% Blue
procedure drawbox50
    drawfillbox (box_x1 (50), box_y1 (50), box_x2 (50), box_y2 (50), 34)
end drawbox50

% Blue
procedure drawbox51
    drawfillbox (box_x1 (51), box_y1 (51), box_x2 (51), box_y2 (51), 34)
end drawbox51

% Blue
procedure drawbox52
    drawfillbox (box_x1 (52), box_y1 (52), box_x2 (52), box_y2 (52), 34)
end drawbox52

% Blue
procedure drawbox53
    drawfillbox (box_x1 (53), box_y1 (53), box_x2 (53), box_y2 (53), 34)
end drawbox53

% Blue
procedure drawbox54
    drawfillbox (box_x1 (54), box_y1 (54), box_x2 (54), box_y2 (54), 34)
end drawbox54

% Blue
procedure drawbox55
    drawfillbox (box_x1 (55), box_y1 (55), box_x2 (55), box_y2 (55), 34)
end drawbox55

% Last Red
procedure drawbox56
    drawfillbox (box_x1 (56), box_y1 (56), box_x2 (56), box_y2 (56), 40)
end drawbox56

% ROW EIGHT
% First Red
procedure drawbox57
    drawfillbox (box_x1 (57), box_y1 (57), box_x2 (57), box_y2 (57), 40)
end drawbox57

% Blue
procedure drawbox58
    drawfillbox (box_x1 (58), box_y1 (58), box_x2 (58), box_y2 (58), 34)
end drawbox58

% Blue
procedure drawbox59
    drawfillbox (box_x1 (59), box_y1 (59), box_x2 (59), box_y2 (59), 34)
end drawbox59

% Blue
procedure drawbox60
    drawfillbox (box_x1 (60), box_y1 (60), box_x2 (60), box_y2 (60), 34)
end drawbox60

% Blue
procedure drawbox61
    drawfillbox (box_x1 (61), box_y1 (61), box_x2 (61), box_y2 (61), 34)
end drawbox61

% Blue
procedure drawbox62
    drawfillbox (box_x1 (62), box_y1 (62), box_x2 (62), box_y2 (62), 34)
end drawbox62

% Blue
procedure drawbox63
    drawfillbox (box_x1 (63), box_y1 (63), box_x2 (63), box_y2 (63), 34)
end drawbox63

% Last Red
procedure drawbox64
    drawfillbox (box_x1 (64), box_y1 (64), box_x2 (64), box_y2 (64), 40)
end drawbox64

% ROW NINE
% First Red
procedure drawbox65
    drawfillbox (box_x1 (65), box_y1 (65), box_x2 (65), box_y2 (65), 40)
end drawbox65

% Blue
procedure drawbox66
    drawfillbox (box_x1 (66), box_y1 (66), box_x2 (66), box_y2 (66), 34)
end drawbox66

% Blue
procedure drawbox67
    drawfillbox (box_x1 (67), box_y1 (67), box_x2 (67), box_y2 (67), 34)
end drawbox67

% Blue
procedure drawbox68
    drawfillbox (box_x1 (68), box_y1 (68), box_x2 (68), box_y2 (68), 34)
end drawbox68

% Blue
procedure drawbox69
    drawfillbox (box_x1 (69), box_y1 (69), box_x2 (69), box_y2 (69), 34)
end drawbox69

% Blue
procedure drawbox70
    drawfillbox (box_x1 (70), box_y1 (70), box_x2 (70), box_y2 (70), 34)
end drawbox70

% Blue
procedure drawbox71
    drawfillbox (box_x1 (71), box_y1 (71), box_x2 (71), box_y2 (71), 34)
end drawbox71

% Last Red
procedure drawbox72
    drawfillbox (box_x1 (72), box_y1 (72), box_x2 (72), box_y2 (72), 40)
end drawbox72

% ROW TEN
% First Red
procedure drawbox73
    drawfillbox (box_x1 (73), box_y1 (73), box_x2 (73), box_y2 (73), 40)
end drawbox73

% Blue
procedure drawbox74
    drawfillbox (box_x1 (74), box_y1 (74), box_x2 (74), box_y2 (74), 34)
end drawbox74

% Blue
procedure drawbox75
    drawfillbox (box_x1 (75), box_y1 (75), box_x2 (75), box_y2 (75), 34)
end drawbox75

% Blue
procedure drawbox76
    drawfillbox (box_x1 (76), box_y1 (76), box_x2 (76), box_y2 (76), 34)
end drawbox76

% Blue
procedure drawbox77
    drawfillbox (box_x1 (77), box_y1 (77), box_x2 (77), box_y2 (77), 34)
end drawbox77

% Blue
procedure drawbox78
    drawfillbox (box_x1 (78), box_y1 (78), box_x2 (78), box_y2 (78), 34)
end drawbox78

% Blue
procedure drawbox79
    drawfillbox (box_x1 (79), box_y1 (79), box_x2 (79), box_y2 (79), 34)
end drawbox79

% Last Red
procedure drawbox80
    drawfillbox (box_x1 (80), box_y1 (80), box_x2 (80), box_y2 (80), 40)
end drawbox80

% ROW ELEVEN
% First Red
procedure drawbox81
    drawfillbox (box_x1 (81), box_y1 (81), box_x2 (81), box_y2 (81), 40)
end drawbox81

% Blue
procedure drawbox82
    drawfillbox (box_x1 (82), box_y1 (82), box_x2 (82), box_y2 (82), 34)
end drawbox82

% Blue
procedure drawbox83
    drawfillbox (box_x1 (83), box_y1 (83), box_x2 (83), box_y2 (83), 34)
end drawbox83

% Blue
procedure drawbox84
    drawfillbox (box_x1 (84), box_y1 (84), box_x2 (84), box_y2 (84), 34)
end drawbox84

% Blue
procedure drawbox85
    drawfillbox (box_x1 (85), box_y1 (85), box_x2 (85), box_y2 (85), 34)
end drawbox85

% Blue
procedure drawbox86
    drawfillbox (box_x1 (86), box_y1 (86), box_x2 (86), box_y2 (86), 34)
end drawbox86

% Blue
procedure drawbox87
    drawfillbox (box_x1 (87), box_y1 (87), box_x2 (87), box_y2 (87), 34)
end drawbox87

% Last Red
procedure drawbox88
    drawfillbox (box_x1 (88), box_y1 (88), box_x2 (88), box_y2 (88), 40)
end drawbox88

% ROW TWELVE
% First Red
procedure drawbox89
    drawfillbox (box_x1 (89), box_y1 (89), box_x2 (89), box_y2 (89), 40)
end drawbox89

% Blue
procedure drawbox90
    drawfillbox (box_x1 (90), box_y1 (90), box_x2 (90), box_y2 (90), 34)
end drawbox90

% Blue
procedure drawbox91
    drawfillbox (box_x1 (91), box_y1 (91), box_x2 (91), box_y2 (91), 34)
end drawbox91

% Blue
procedure drawbox92
    drawfillbox (box_x1 (92), box_y1 (92), box_x2 (92), box_y2 (92), 34)
end drawbox92

% Blue
procedure drawbox93
    drawfillbox (box_x1 (93), box_y1 (93), box_x2 (93), box_y2 (93), 34)
end drawbox93

% Blue
procedure drawbox94
    drawfillbox (box_x1 (94), box_y1 (94), box_x2 (94), box_y2 (94), 34)
end drawbox94

% Blue
procedure drawbox95
    drawfillbox (box_x1 (95), box_y1 (95), box_x2 (95), box_y2 (95), 34)
end drawbox95

% Last Red
procedure drawbox96
    drawfillbox (box_x1 (96), box_y1 (96), box_x2 (96), box_y2 (96), 40)
end drawbox96

% BRICK OUTLINE %
countBox := 1
setBox_x1 (1) := 650 % ... in an array to be called upon later via. procedures.
setBox_y1 (1) := 840
setBox_x2 (1) := 665
setBox_y2 (1) := 900
for i : 2 .. 13 % How many rows
    setBox_x1 (2) := setBox_x1 (1)
    setBox_y1 (2) := setBox_y1 (1) - 62 * i
    setBox_x2 (2) := setBox_x2 (1)
    setBox_y2 (2) := setBox_y2 (1) - 62 * i
    % First Red Block
    Ebox_x1 (countBox) := setBox_x1 (2) + 20
    Ebox_y1 (countBox) := setBox_y1 (2)
    Ebox_x2 (countBox) := setBox_x2 (2) + 20
    Ebox_y2 (countBox) := setBox_y2 (2)
    countBox += 1
    for j : 2 .. 7 % How many each row
	setBox_x1 (3) := setBox_x1 (2) + 20 * j
	setBox_y1 (3) := setBox_y1 (2)
	setBox_x2 (3) := setBox_x2 (2) + 20 * j
	setBox_y2 (3) := setBox_y2 (2)
	% All Blue Blocks
	Ebox_x1 (countBox) := setBox_x1 (3) + 62
	Ebox_y1 (countBox) := setBox_y1 (3)
	Ebox_x2 (countBox) := setBox_x2 (3) + 62
	Ebox_y2 (countBox) := setBox_y2 (3)
	countBox += 1
	if j = 7 then % Last Red Block
	    Ebox_x1 (countBox) := setBox_x1 (3) + 128
	    Ebox_y1 (countBox) := setBox_y1 (3)
	    Ebox_x2 (countBox) := setBox_x2 (3) + 128
	    Ebox_y2 (countBox) := setBox_y2 (3)
	    countBox += 1
	end if
    end for
end for

% ROW ONE of DRAW BRICKS
% First Red
procedure drawEmptyBox1
    drawbox (Ebox_x1 (1), Ebox_y1 (1), Ebox_x2 (1), Ebox_y2 (1), 17)
end drawEmptyBox1

% Blue
procedure drawEmptyBox2
    drawbox (Ebox_x1 (2), Ebox_y1 (2), Ebox_x2 (2), Ebox_y2 (2), 17)
end drawEmptyBox2

% Blue
procedure drawEmptyBox3
    drawbox (Ebox_x1 (3), Ebox_y1 (3), Ebox_x2 (3), Ebox_y2 (3), 17)
end drawEmptyBox3

% Blue
procedure drawEmptyBox4
    drawbox (Ebox_x1 (4), Ebox_y1 (4), Ebox_x2 (4), Ebox_y2 (4), 17)
end drawEmptyBox4

% Blue
procedure drawEmptyBox5
    drawbox (Ebox_x1 (5), Ebox_y1 (5), Ebox_x2 (5), Ebox_y2 (5), 17)
end drawEmptyBox5

% Blue
procedure drawEmptyBox6
    drawbox (Ebox_x1 (6), Ebox_y1 (6), Ebox_x2 (6), Ebox_y2 (6), 17)
end drawEmptyBox6

% Blue
procedure drawEmptyBox7
    drawbox (Ebox_x1 (7), Ebox_y1 (7), Ebox_x2 (7), Ebox_y2 (7), 17)
end drawEmptyBox7

% Last Red
procedure drawEmptyBox8
    drawbox (Ebox_x1 (8), Ebox_y1 (8), Ebox_x2 (8), Ebox_y2 (8), 17)
end drawEmptyBox8

% ROW TWO
% First Red
procedure drawEmptyBox9
    drawbox (Ebox_x1 (9), Ebox_y1 (9), Ebox_x2 (9), Ebox_y2 (9), 17)
end drawEmptyBox9

% Blue
procedure drawEmptyBox10
    drawbox (Ebox_x1 (10), Ebox_y1 (10), Ebox_x2 (10), Ebox_y2 (10), 17)
end drawEmptyBox10

% Blue
procedure drawEmptyBox11
    drawbox (Ebox_x1 (11), Ebox_y1 (11), Ebox_x2 (11), Ebox_y2 (11), 17)
end drawEmptyBox11

% Blue
procedure drawEmptyBox12
    drawbox (Ebox_x1 (12), Ebox_y1 (12), Ebox_x2 (12), Ebox_y2 (12), 17)
end drawEmptyBox12

% Blue
procedure drawEmptyBox13
    drawbox (Ebox_x1 (13), Ebox_y1 (13), Ebox_x2 (13), Ebox_y2 (13), 17)
end drawEmptyBox13

% Blue
procedure drawEmptyBox14
    drawbox (Ebox_x1 (14), Ebox_y1 (14), Ebox_x2 (14), Ebox_y2 (14), 17)
end drawEmptyBox14

% Blue
procedure drawEmptyBox15
    drawbox (Ebox_x1 (15), Ebox_y1 (15), Ebox_x2 (15), Ebox_y2 (15), 17)
end drawEmptyBox15

% Last Red
procedure drawEmptyBox16
    drawbox (Ebox_x1 (16), Ebox_y1 (16), Ebox_x2 (16), Ebox_y2 (16), 17)
end drawEmptyBox16

% ROW THREE
% First Red
procedure drawEmptyBox17
    drawbox (Ebox_x1 (17), Ebox_y1 (17), Ebox_x2 (17), Ebox_y2 (17), 17)
end drawEmptyBox17

% Blue
procedure drawEmptyBox18
    drawbox (Ebox_x1 (18), Ebox_y1 (18), Ebox_x2 (18), Ebox_y2 (18), 17)
end drawEmptyBox18

% Blue
procedure drawEmptyBox19
    drawbox (Ebox_x1 (19), Ebox_y1 (19), Ebox_x2 (19), Ebox_y2 (19), 17)
end drawEmptyBox19

% Blue
procedure drawEmptyBox20
    drawbox (Ebox_x1 (20), Ebox_y1 (20), Ebox_x2 (20), Ebox_y2 (20), 17)
end drawEmptyBox20

% Blue
procedure drawEmptyBox21
    drawbox (Ebox_x1 (21), Ebox_y1 (21), Ebox_x2 (21), Ebox_y2 (21), 17)
end drawEmptyBox21

% Blue
procedure drawEmptyBox22
    drawbox (Ebox_x1 (22), Ebox_y1 (22), Ebox_x2 (22), Ebox_y2 (22), 17)
end drawEmptyBox22

% Blue
procedure drawEmptyBox23
    drawbox (Ebox_x1 (23), Ebox_y1 (23), Ebox_x2 (23), Ebox_y2 (23), 17)
end drawEmptyBox23

% Last Red
procedure drawEmptyBox24
    drawbox (Ebox_x1 (24), Ebox_y1 (24), Ebox_x2 (24), Ebox_y2 (24), 17)
end drawEmptyBox24

% ROW FOUR
% First Red
procedure drawEmptyBox25
    drawbox (Ebox_x1 (25), Ebox_y1 (25), Ebox_x2 (25), Ebox_y2 (25), 17)
end drawEmptyBox25

% Blue
procedure drawEmptyBox26
    drawbox (Ebox_x1 (26), Ebox_y1 (26), Ebox_x2 (26), Ebox_y2 (26), 17)
end drawEmptyBox26

% Blue
procedure drawEmptyBox27
    drawbox (Ebox_x1 (27), Ebox_y1 (27), Ebox_x2 (27), Ebox_y2 (27), 17)
end drawEmptyBox27

% Blue
procedure drawEmptyBox28
    drawbox (Ebox_x1 (28), Ebox_y1 (28), Ebox_x2 (28), Ebox_y2 (28), 17)
end drawEmptyBox28

% Blue
procedure drawEmptyBox29
    drawbox (Ebox_x1 (29), Ebox_y1 (29), Ebox_x2 (29), Ebox_y2 (29), 17)
end drawEmptyBox29

% Blue
procedure drawEmptyBox30
    drawbox (Ebox_x1 (30), Ebox_y1 (30), Ebox_x2 (30), Ebox_y2 (30), 17)
end drawEmptyBox30

% Blue
procedure drawEmptyBox31
    drawbox (Ebox_x1 (31), Ebox_y1 (31), Ebox_x2 (31), Ebox_y2 (31), 17)
end drawEmptyBox31

% Last Red
procedure drawEmptyBox32
    drawbox (Ebox_x1 (32), Ebox_y1 (32), Ebox_x2 (32), Ebox_y2 (32), 17)
end drawEmptyBox32

% ROW FIVE
% First Red
procedure drawEmptyBox33
    drawbox (Ebox_x1 (33), Ebox_y1 (33), Ebox_x2 (33), Ebox_y2 (33), 17)
end drawEmptyBox33

% Blue
procedure drawEmptyBox34
    drawbox (Ebox_x1 (34), Ebox_y1 (34), Ebox_x2 (34), Ebox_y2 (34), 17)
end drawEmptyBox34

% Blue
procedure drawEmptyBox35
    drawbox (Ebox_x1 (35), Ebox_y1 (35), Ebox_x2 (35), Ebox_y2 (35), 17)
end drawEmptyBox35

% Blue
procedure drawEmptyBox36
    drawbox (Ebox_x1 (36), Ebox_y1 (36), Ebox_x2 (36), Ebox_y2 (36), 17)
end drawEmptyBox36

% Blue
procedure drawEmptyBox37
    drawbox (Ebox_x1 (37), Ebox_y1 (37), Ebox_x2 (37), Ebox_y2 (37), 17)
end drawEmptyBox37

% Blue
procedure drawEmptyBox38
    drawbox (Ebox_x1 (38), Ebox_y1 (38), Ebox_x2 (38), Ebox_y2 (38), 17)
end drawEmptyBox38

% Blue
procedure drawEmptyBox39
    drawbox (Ebox_x1 (39), Ebox_y1 (39), Ebox_x2 (39), Ebox_y2 (39), 17)
end drawEmptyBox39

% Last Red
procedure drawEmptyBox40
    drawbox (Ebox_x1 (40), Ebox_y1 (40), Ebox_x2 (40), Ebox_y2 (40), 17)
end drawEmptyBox40

% ROW SIX
% First Red
procedure drawEmptyBox41
    drawbox (Ebox_x1 (41), Ebox_y1 (41), Ebox_x2 (41), Ebox_y2 (41), 17)
end drawEmptyBox41

% Blue
procedure drawEmptyBox42
    drawbox (Ebox_x1 (42), Ebox_y1 (42), Ebox_x2 (42), Ebox_y2 (42), 17)
end drawEmptyBox42

% Blue
procedure drawEmptyBox43
    drawbox (Ebox_x1 (43), Ebox_y1 (43), Ebox_x2 (43), Ebox_y2 (43), 17)
end drawEmptyBox43

% Blue
procedure drawEmptyBox44
    drawbox (Ebox_x1 (44), Ebox_y1 (44), Ebox_x2 (44), Ebox_y2 (44), 17)
end drawEmptyBox44

% Blue
procedure drawEmptyBox45
    drawbox (Ebox_x1 (45), Ebox_y1 (45), Ebox_x2 (45), Ebox_y2 (45), 17)
end drawEmptyBox45

% Blue
procedure drawEmptyBox46
    drawbox (Ebox_x1 (46), Ebox_y1 (46), Ebox_x2 (46), Ebox_y2 (46), 17)
end drawEmptyBox46

% Blue
procedure drawEmptyBox47
    drawbox (Ebox_x1 (47), Ebox_y1 (47), Ebox_x2 (47), Ebox_y2 (47), 17)
end drawEmptyBox47

% Last Red
procedure drawEmptyBox48
    drawbox (Ebox_x1 (48), Ebox_y1 (48), Ebox_x2 (48), Ebox_y2 (48), 17)
end drawEmptyBox48

% ROW SEVEN
% First Red
procedure drawEmptyBox49
    drawbox (Ebox_x1 (49), Ebox_y1 (49), Ebox_x2 (49), Ebox_y2 (49), 17)
end drawEmptyBox49

% Blue
procedure drawEmptyBox50
    drawbox (Ebox_x1 (50), Ebox_y1 (50), Ebox_x2 (50), Ebox_y2 (50), 17)
end drawEmptyBox50

% Blue
procedure drawEmptyBox51
    drawbox (Ebox_x1 (51), Ebox_y1 (51), Ebox_x2 (51), Ebox_y2 (51), 17)
end drawEmptyBox51

% Blue
procedure drawEmptyBox52
    drawbox (Ebox_x1 (52), Ebox_y1 (52), Ebox_x2 (52), Ebox_y2 (52), 17)
end drawEmptyBox52

% Blue
procedure drawEmptyBox53
    drawbox (Ebox_x1 (53), Ebox_y1 (53), Ebox_x2 (53), Ebox_y2 (53), 17)
end drawEmptyBox53

% Blue
procedure drawEmptyBox54
    drawbox (Ebox_x1 (54), Ebox_y1 (54), Ebox_x2 (54), Ebox_y2 (54), 17)
end drawEmptyBox54

% Blue
procedure drawEmptyBox55
    drawbox (Ebox_x1 (55), Ebox_y1 (55), Ebox_x2 (55), Ebox_y2 (55), 17)
end drawEmptyBox55

% Last Red
procedure drawEmptyBox56
    drawbox (Ebox_x1 (56), Ebox_y1 (56), Ebox_x2 (56), Ebox_y2 (56), 17)
end drawEmptyBox56

% ROW EIGHT
% First Red
procedure drawEmptyBox57
    drawbox (Ebox_x1 (57), Ebox_y1 (57), Ebox_x2 (57), Ebox_y2 (57), 17)
end drawEmptyBox57

% Blue
procedure drawEmptyBox58
    drawbox (Ebox_x1 (58), Ebox_y1 (58), Ebox_x2 (58), Ebox_y2 (58), 17)
end drawEmptyBox58

% Blue
procedure drawEmptyBox59
    drawbox (Ebox_x1 (59), Ebox_y1 (59), Ebox_x2 (59), Ebox_y2 (59), 17)
end drawEmptyBox59

% Blue
procedure drawEmptyBox60
    drawbox (Ebox_x1 (60), Ebox_y1 (60), Ebox_x2 (60), Ebox_y2 (60), 17)
end drawEmptyBox60

% Blue
procedure drawEmptyBox61
    drawbox (Ebox_x1 (61), Ebox_y1 (61), Ebox_x2 (61), Ebox_y2 (61), 17)
end drawEmptyBox61

% Blue
procedure drawEmptyBox62
    drawbox (Ebox_x1 (62), Ebox_y1 (62), Ebox_x2 (62), Ebox_y2 (62), 17)
end drawEmptyBox62

% Blue
procedure drawEmptyBox63
    drawbox (Ebox_x1 (63), Ebox_y1 (63), Ebox_x2 (63), Ebox_y2 (63), 17)
end drawEmptyBox63

% Last Red
procedure drawEmptyBox64
    drawbox (Ebox_x1 (64), Ebox_y1 (64), Ebox_x2 (64), Ebox_y2 (64), 17)
end drawEmptyBox64

% ROW NINE
% First Red
procedure drawEmptyBox65
    drawbox (Ebox_x1 (65), Ebox_y1 (65), Ebox_x2 (65), Ebox_y2 (65), 17)
end drawEmptyBox65

% Blue
procedure drawEmptyBox66
    drawbox (Ebox_x1 (66), Ebox_y1 (66), Ebox_x2 (66), Ebox_y2 (66), 17)
end drawEmptyBox66

% Blue
procedure drawEmptyBox67
    drawbox (Ebox_x1 (67), Ebox_y1 (67), Ebox_x2 (67), Ebox_y2 (67), 17)
end drawEmptyBox67

% Blue
procedure drawEmptyBox68
    drawbox (Ebox_x1 (68), Ebox_y1 (68), Ebox_x2 (68), Ebox_y2 (68), 17)
end drawEmptyBox68

% Blue
procedure drawEmptyBox69
    drawbox (Ebox_x1 (69), Ebox_y1 (69), Ebox_x2 (69), Ebox_y2 (69), 17)
end drawEmptyBox69

% Blue
procedure drawEmptyBox70
    drawbox (Ebox_x1 (70), Ebox_y1 (70), Ebox_x2 (70), Ebox_y2 (70), 17)
end drawEmptyBox70

% Blue
procedure drawEmptyBox71
    drawbox (Ebox_x1 (71), Ebox_y1 (71), Ebox_x2 (71), Ebox_y2 (71), 17)
end drawEmptyBox71

% Last Red
procedure drawEmptyBox72
    drawbox (Ebox_x1 (72), Ebox_y1 (72), Ebox_x2 (72), Ebox_y2 (72), 17)
end drawEmptyBox72

% ROW TEN
% First Red
procedure drawEmptyBox73
    drawbox (Ebox_x1 (73), Ebox_y1 (73), Ebox_x2 (73), Ebox_y2 (73), 17)
end drawEmptyBox73

% Blue
procedure drawEmptyBox74
    drawbox (Ebox_x1 (74), Ebox_y1 (74), Ebox_x2 (74), Ebox_y2 (74), 17)
end drawEmptyBox74

% Blue
procedure drawEmptyBox75
    drawbox (Ebox_x1 (75), Ebox_y1 (75), Ebox_x2 (75), Ebox_y2 (75), 17)
end drawEmptyBox75

% Blue
procedure drawEmptyBox76
    drawbox (Ebox_x1 (76), Ebox_y1 (76), Ebox_x2 (76), Ebox_y2 (76), 17)
end drawEmptyBox76

% Blue
procedure drawEmptyBox77
    drawbox (Ebox_x1 (77), Ebox_y1 (77), Ebox_x2 (77), Ebox_y2 (77), 17)
end drawEmptyBox77

% Blue
procedure drawEmptyBox78
    drawbox (Ebox_x1 (78), Ebox_y1 (78), Ebox_x2 (78), Ebox_y2 (78), 17)
end drawEmptyBox78

% Blue
procedure drawEmptyBox79
    drawbox (Ebox_x1 (79), Ebox_y1 (79), Ebox_x2 (79), Ebox_y2 (79), 17)
end drawEmptyBox79

% Last Red
procedure drawEmptyBox80
    drawbox (Ebox_x1 (80), Ebox_y1 (80), Ebox_x2 (80), Ebox_y2 (80), 17)
end drawEmptyBox80

% ROW ELEVEN
% First Red
procedure drawEmptyBox81
    drawbox (Ebox_x1 (81), Ebox_y1 (81), Ebox_x2 (81), Ebox_y2 (81), 17)
end drawEmptyBox81

% Blue
procedure drawEmptyBox82
    drawbox (Ebox_x1 (82), Ebox_y1 (82), Ebox_x2 (82), Ebox_y2 (82), 17)
end drawEmptyBox82

% Blue
procedure drawEmptyBox83
    drawbox (Ebox_x1 (83), Ebox_y1 (83), Ebox_x2 (83), Ebox_y2 (83), 17)
end drawEmptyBox83

% Blue
procedure drawEmptyBox84
    drawbox (Ebox_x1 (84), Ebox_y1 (84), Ebox_x2 (84), Ebox_y2 (84), 17)
end drawEmptyBox84

% Blue
procedure drawEmptyBox85
    drawbox (Ebox_x1 (85), Ebox_y1 (85), Ebox_x2 (85), Ebox_y2 (85), 17)
end drawEmptyBox85

% Blue
procedure drawEmptyBox86
    drawbox (Ebox_x1 (86), Ebox_y1 (86), Ebox_x2 (86), Ebox_y2 (86), 17)
end drawEmptyBox86

% Blue
procedure drawEmptyBox87
    drawbox (Ebox_x1 (87), Ebox_y1 (87), Ebox_x2 (87), Ebox_y2 (87), 17)
end drawEmptyBox87

% Last Red
procedure drawEmptyBox88
    drawbox (Ebox_x1 (88), Ebox_y1 (88), Ebox_x2 (88), Ebox_y2 (88), 17)
end drawEmptyBox88

% ROW TWELVE
% First Red
procedure drawEmptyBox89
    drawbox (Ebox_x1 (89), Ebox_y1 (89), Ebox_x2 (89), Ebox_y2 (89), 17)
end drawEmptyBox89

% Blue
procedure drawEmptyBox90
    drawbox (Ebox_x1 (90), Ebox_y1 (90), Ebox_x2 (90), Ebox_y2 (90), 17)
end drawEmptyBox90

% Blue
procedure drawEmptyBox91
    drawbox (Ebox_x1 (91), Ebox_y1 (91), Ebox_x2 (91), Ebox_y2 (91), 17)
end drawEmptyBox91

% Blue
procedure drawEmptyBox92
    drawbox (Ebox_x1 (92), Ebox_y1 (92), Ebox_x2 (92), Ebox_y2 (92), 17)
end drawEmptyBox92

% Blue
procedure drawEmptyBox93
    drawbox (Ebox_x1 (93), Ebox_y1 (93), Ebox_x2 (93), Ebox_y2 (93), 17)
end drawEmptyBox93

% Blue
procedure drawEmptyBox94
    drawbox (Ebox_x1 (94), Ebox_y1 (94), Ebox_x2 (94), Ebox_y2 (94), 17)
end drawEmptyBox94

% Blue
procedure drawEmptyBox95
    drawbox (Ebox_x1 (95), Ebox_y1 (95), Ebox_x2 (95), Ebox_y2 (95), 17)
end drawEmptyBox95

% Last Red
procedure drawEmptyBox96
    drawbox (Ebox_x1 (96), Ebox_y1 (96), Ebox_x2 (96), Ebox_y2 (96), 17)
end drawEmptyBox96

% Make all blocks = true
for i : 1 .. 120
    isThere (i) := true
end for

/****************\
 * TITLE SCREEN *
\****************/
setscreen ("graphics:1579;817,nobuttonbar") % MY RESOLUTION : maxx = 1579, maxy = 817
put "Hello ", userName, " on ", computerName, "."
% Create Check Boxes /* Taken from Example programs */
var cb1 : int := GUI.CreateCheckBoxFull (maxx div 2 - 60, maxy div 2 - 200, "Sound (Higher FPS = OFF)", DoNothing, GUI.RIGHT, '2')
var cb2 : int := GUI.CreateCheckBoxFull (maxx div 2 + 60, maxy div 2 - 200,"One Player Mode", DoNothing, GUI.RIGHT, '2')
%GUI.SetCheckBox (cb1, true)
% Create Buttons /* Taken from Example programs */
var startBtn : int := GUI.CreateButton (maxx div 2 - 40, maxy div 2, 0, "Start", GUI.Quit)
var quitBtn : int := GUI.CreateButton (maxx div 2 + 20, maxy div 2, 0, "Quit", exitprogram)

loop
randint (colours,1,10)
Font.Draw (" Welcome To Cameron's Brick Breaker Game! ", 1, maxy div 2+200, font, colours)
Font.Draw (" (And Generic Title Screen) ", 100, maxy div 2+100, font, brightblue)
    exit when GUI.ProcessEvent
end loop

var cb1Status : boolean := GUI.GetCheckBox (cb1)
var cb2Status : boolean := GUI.GetCheckBox (cb2)
put "These are your settings: "
put ""
if cb1Status then
    put "Sound ON"
    Sound := true
else
    put "Sound OFF"
    Sound := false
end if
if cb2Status then
    put "Bot ON"
    bot := true
else
    put "Bot OFF"
    bot := false
end if    
put skip
delay (2000)
cls
put "Please enter Player One's name: "..
get name1
put "Thank You ", name1, "!"
delay (500)
cls
if bot = false then
put "Please enter Player Two's name: "..
get name2
put "Thank You ", name2, "!"
delay (500)
cls
end if
View.Set ("offscreenonly")
loop
    cls
    % Brick Collision Detection and Erase Module (BCDEM)
    % PLAYER ONE
if isThere (1) = true then
    drawbox1
    drawEmptyBox1
end if
if ball_1y > box_y1 (1) and ball_1y < box_y2 (1) and ball_1x > box_x1 (1) and ball_1x < box_x2 (1) and isThere (1) = true then
    isThere (1) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7     
    elsif xchange = 7 and ychange = 7 or xchange = 7 and ychange = 5 then % There can be an event where ychange = 5 and hit this brick
	xchange := -7
	ychange := 7       
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (2) = true then
    drawbox2
    drawEmptyBox2
end if
if ball_1y > box_y1 (2) and ball_1y < box_y2 (2) and ball_1x > box_x1 (2) and ball_1x < box_x2 (2) and isThere (2) = true then
    isThere (2) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (3) = true then
    drawbox3
    drawEmptyBox3
end if
if ball_1y > box_y1 (3) and ball_1y < box_y2 (3) and ball_1x > box_x1 (3) and ball_1x < box_x2 (3) and isThere (3) = true then
    isThere (3) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (4) = true then
    drawbox4
    drawEmptyBox4
end if
if ball_1y > box_y1 (4) and ball_1y < box_y2 (4) and ball_1x > box_x1 (4) and ball_1x < box_x2 (4) and isThere (4) = true then
    isThere (4) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (5) = true then
    drawbox5
    drawEmptyBox5
end if
if ball_1y > box_y1 (5) and ball_1y < box_y2 (5) and ball_1x > box_x1 (5) and ball_1x < box_x2 (5) and isThere (5) = true then
    isThere (5) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (6) = true then
    drawbox6
    drawEmptyBox6
end if
if ball_1y > box_y1 (6) and ball_1y < box_y2 (6) and ball_1x > box_x1 (6) and ball_1x < box_x2 (6) and isThere (6) = true then
    isThere (6) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (7) = true then
    drawbox7
    drawEmptyBox7
end if
if ball_1y > box_y1 (7) and ball_1y < box_y2 (7) and ball_1x > box_x1 (7) and ball_1x < box_x2 (7) and isThere (7) = true then
    isThere (7) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (8) = true then
    drawbox8
    drawEmptyBox8
end if
if ball_1y > box_y1 (8) and ball_1y < box_y2 (8) and ball_1x > box_x1 (8) and ball_1x < box_x2 (8) and isThere (8) = true then
    isThere (8) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (9) = true then
    drawbox9
    drawEmptyBox9
end if
if ball_1y > box_y1 (9) and ball_1y < box_y2 (9) and ball_1x > box_x1 (9) and ball_1x < box_x2 (9) and isThere (9) = true then
    isThere (9) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (10) = true then
    drawbox10
    drawEmptyBox10
end if
if ball_1y > box_y1 (10) and ball_1y < box_y2 (10) and ball_1x > box_x1 (10) and ball_1x < box_x2 (10) and isThere (10) = true then
    isThere (10) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (11) = true then
    drawbox11
    drawEmptyBox11
end if
if ball_1y > box_y1 (11) and ball_1y < box_y2 (11) and ball_1x > box_x1 (11) and ball_1x < box_x2 (11) and isThere (11) = true then
    isThere (11) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (12) = true then
    drawbox12
    drawEmptyBox12
end if
if ball_1y > box_y1 (12) and ball_1y < box_y2 (12) and ball_1x > box_x1 (12) and ball_1x < box_x2 (12) and isThere (12) = true then
    isThere (12) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (13) = true then
    drawbox13
    drawEmptyBox13
end if
if ball_1y > box_y1 (13) and ball_1y < box_y2 (13) and ball_1x > box_x1 (13) and ball_1x < box_x2 (13) and isThere (13) = true then
    isThere (13) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (14) = true then
    drawbox14
    drawEmptyBox14
end if
if ball_1y > box_y1 (14) and ball_1y < box_y2 (14) and ball_1x > box_x1 (14) and ball_1x < box_x2 (14) and isThere (14) = true then
    isThere (14) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (15) = true then
    drawbox15
    drawEmptyBox15
end if
if ball_1y > box_y1 (15) and ball_1y < box_y2 (15) and ball_1x > box_x1 (15) and ball_1x < box_x2 (15) and isThere (15) = true then
    isThere (15) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (16) = true then
    drawbox16
    drawEmptyBox16
end if
if ball_1y > box_y1 (16) and ball_1y < box_y2 (16) and ball_1x > box_x1 (16) and ball_1x < box_x2 (16) and isThere (16) = true then
    isThere (16) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (17) = true then
    drawbox17
    drawEmptyBox17
end if
if ball_1y > box_y1 (17) and ball_1y < box_y2 (17) and ball_1x > box_x1 (17) and ball_1x < box_x2 (17) and isThere (17) = true then
    isThere (17) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (18) = true then
    drawbox18
    drawEmptyBox18
end if
if ball_1y > box_y1 (18) and ball_1y < box_y2 (18) and ball_1x > box_x1 (18) and ball_1x < box_x2 (18) and isThere (18) = true then
    isThere (18) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (19) = true then
    drawbox19
    drawEmptyBox19
end if
if ball_1y > box_y1 (19) and ball_1y < box_y2 (19) and ball_1x > box_x1 (19) and ball_1x < box_x2 (19) and isThere (19) = true then
    isThere (19) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (20) = true then
    drawbox20
    drawEmptyBox20
end if
if ball_1y > box_y1 (20) and ball_1y < box_y2 (20) and ball_1x > box_x1 (20) and ball_1x < box_x2 (20) and isThere (20) = true then
    isThere (20) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (21) = true then
    drawbox21
    drawEmptyBox21
end if
if ball_1y > box_y1 (21) and ball_1y < box_y2 (21) and ball_1x > box_x1 (21) and ball_1x < box_x2 (21) and isThere (21) = true then
    isThere (21) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (22) = true then
    drawbox22
    drawEmptyBox22
end if
if ball_1y > box_y1 (22) and ball_1y < box_y2 (22) and ball_1x > box_x1 (22) and ball_1x < box_x2 (22) and isThere (22) = true then
    isThere (22) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (23) = true then
    drawbox23
    drawEmptyBox23
end if
if ball_1y > box_y1 (23) and ball_1y < box_y2 (23) and ball_1x > box_x1 (23) and ball_1x < box_x2 (23) and isThere (23) = true then
    isThere (23) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (24) = true then
    drawbox24
    drawEmptyBox24
end if
if ball_1y > box_y1 (24) and ball_1y < box_y2 (24) and ball_1x > box_x1 (24) and ball_1x < box_x2 (24) and isThere (24) = true then
    isThere (24) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (25) = true then
    drawbox25
    drawEmptyBox25
end if
if ball_1y > box_y1 (25) and ball_1y < box_y2 (25) and ball_1x > box_x1 (25) and ball_1x < box_x2 (25) and isThere (25) = true then
    isThere (25) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (26) = true then
    drawbox26
    drawEmptyBox26
end if
if ball_1y > box_y1 (26) and ball_1y < box_y2 (26) and ball_1x > box_x1 (26) and ball_1x < box_x2 (26) and isThere (26) = true then
    isThere (26) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (27) = true then
    drawbox27
    drawEmptyBox27
end if
if ball_1y > box_y1 (27) and ball_1y < box_y2 (27) and ball_1x > box_x1 (27) and ball_1x < box_x2 (27) and isThere (27) = true then
    isThere (27) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (28) = true then
    drawbox28
    drawEmptyBox28
end if
if ball_1y > box_y1 (28) and ball_1y < box_y2 (28) and ball_1x > box_x1 (28) and ball_1x < box_x2 (28) and isThere (28) = true then
    isThere (28) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (29) = true then
    drawbox29
    drawEmptyBox29
end if
if ball_1y > box_y1 (29) and ball_1y < box_y2 (29) and ball_1x > box_x1 (29) and ball_1x < box_x2 (29) and isThere (29) = true then
    isThere (29) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (30) = true then
    drawbox30
    drawEmptyBox30
end if
if ball_1y > box_y1 (30) and ball_1y < box_y2 (30) and ball_1x > box_x1 (30) and ball_1x < box_x2 (30) and isThere (30) = true then
    isThere (30) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (31) = true then
    drawbox31
    drawEmptyBox31
end if
if ball_1y > box_y1 (31) and ball_1y < box_y2 (31) and ball_1x > box_x1 (31) and ball_1x < box_x2 (31) and isThere (31) = true then
    isThere (31) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (32) = true then
    drawbox32
    drawEmptyBox32
end if
if ball_1y > box_y1 (32) and ball_1y < box_y2 (32) and ball_1x > box_x1 (32) and ball_1x < box_x2 (32) and isThere (32) = true then
    isThere (32) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (33) = true then
    drawbox33
    drawEmptyBox33
end if
if ball_1y > box_y1 (33) and ball_1y < box_y2 (33) and ball_1x > box_x1 (33) and ball_1x < box_x2 (33) and isThere (33) = true then
    isThere (33) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (34) = true then
    drawbox34
    drawEmptyBox34
end if
if ball_1y > box_y1 (34) and ball_1y < box_y2 (34) and ball_1x > box_x1 (34) and ball_1x < box_x2 (34) and isThere (34) = true then
    isThere (34) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (35) = true then
    drawbox35
    drawEmptyBox35
end if
if ball_1y > box_y1 (35) and ball_1y < box_y2 (35) and ball_1x > box_x1 (35) and ball_1x < box_x2 (35) and isThere (35) = true then
    isThere (35) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (36) = true then
    drawbox36
    drawEmptyBox36
end if
if ball_1y > box_y1 (36) and ball_1y < box_y2 (36) and ball_1x > box_x1 (36) and ball_1x < box_x2 (36) and isThere (36) = true then
    isThere (36) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (37) = true then
    drawbox37
    drawEmptyBox37
end if
if ball_1y > box_y1 (37) and ball_1y < box_y2 (37) and ball_1x > box_x1 (37) and ball_1x < box_x2 (37) and isThere (37) = true then
    isThere (37) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (38) = true then
    drawbox38
    drawEmptyBox38
end if
if ball_1y > box_y1 (38) and ball_1y < box_y2 (38) and ball_1x > box_x1 (38) and ball_1x < box_x2 (38) and isThere (38) = true then
    isThere (38) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (39) = true then
    drawbox39
    drawEmptyBox39
end if
if ball_1y > box_y1 (39) and ball_1y < box_y2 (39) and ball_1x > box_x1 (39) and ball_1x < box_x2 (39) and isThere (39) = true then
    isThere (39) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (40) = true then
    drawbox40
    drawEmptyBox40
end if
if ball_1y > box_y1 (40) and ball_1y < box_y2 (40) and ball_1x > box_x1 (40) and ball_1x < box_x2 (40) and isThere (40) = true then
    isThere (40) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (41) = true then
    drawbox41
    drawEmptyBox41
end if
if ball_1y > box_y1 (41) and ball_1y < box_y2 (41) and ball_1x > box_x1 (41) and ball_1x < box_x2 (41) and isThere (41) = true then
    isThere (41) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (42) = true then
    drawbox42
    drawEmptyBox42
end if
if ball_1y > box_y1 (42) and ball_1y < box_y2 (42) and ball_1x > box_x1 (42) and ball_1x < box_x2 (42) and isThere (42) = true then
    isThere (42) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (43) = true then
    drawbox43
    drawEmptyBox43
end if
if ball_1y > box_y1 (43) and ball_1y < box_y2 (43) and ball_1x > box_x1 (43) and ball_1x < box_x2 (43) and isThere (43) = true then
    isThere (43) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (44) = true then
    drawbox44
    drawEmptyBox44
end if
if ball_1y > box_y1 (44) and ball_1y < box_y2 (44) and ball_1x > box_x1 (44) and ball_1x < box_x2 (44) and isThere (44) = true then
    isThere (44) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (45) = true then
    drawbox45
    drawEmptyBox45
end if
if ball_1y > box_y1 (45) and ball_1y < box_y2 (45) and ball_1x > box_x1 (45) and ball_1x < box_x2 (45) and isThere (45) = true then
    isThere (45) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (46) = true then
    drawbox46
    drawEmptyBox46
end if
if ball_1y > box_y1 (46) and ball_1y < box_y2 (46) and ball_1x > box_x1 (46) and ball_1x < box_x2 (46) and isThere (46) = true then
    isThere (46) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (47) = true then
    drawbox47
    drawEmptyBox47
end if
if ball_1y > box_y1 (47) and ball_1y < box_y2 (47) and ball_1x > box_x1 (47) and ball_1x < box_x2 (47) and isThere (47) = true then
    isThere (47) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (48) = true then
    drawbox48
    drawEmptyBox48
end if
if ball_1y > box_y1 (48) and ball_1y < box_y2 (48) and ball_1x > box_x1 (48) and ball_1x < box_x2 (48) and isThere (48) = true then
    isThere (48) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (49) = true then
    drawbox49
    drawEmptyBox49
end if
if ball_1y > box_y1 (49) and ball_1y < box_y2 (49) and ball_1x > box_x1 (49) and ball_1x < box_x2 (49) and isThere (49) = true then
    isThere (49) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (50) = true then
    drawbox50
    drawEmptyBox50
end if
if ball_1y > box_y1 (50) and ball_1y < box_y2 (50) and ball_1x > box_x1 (50) and ball_1x < box_x2 (50) and isThere (50) = true then
    isThere (50) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (51) = true then
    drawbox51
    drawEmptyBox51
end if
if ball_1y > box_y1 (51) and ball_1y < box_y2 (51) and ball_1x > box_x1 (51) and ball_1x < box_x2 (51) and isThere (51) = true then
    isThere (51) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (52) = true then
    drawbox52
    drawEmptyBox52
end if
if ball_1y > box_y1 (52) and ball_1y < box_y2 (52) and ball_1x > box_x1 (52) and ball_1x < box_x2 (52) and isThere (52) = true then
    isThere (52) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (53) = true then
    drawbox53
    drawEmptyBox53
end if
if ball_1y > box_y1 (53) and ball_1y < box_y2 (53) and ball_1x > box_x1 (53) and ball_1x < box_x2 (53) and isThere (53) = true then
    isThere (53) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (54) = true then
    drawbox54
    drawEmptyBox54
end if
if ball_1y > box_y1 (54) and ball_1y < box_y2 (54) and ball_1x > box_x1 (54) and ball_1x < box_x2 (54) and isThere (54) = true then
    isThere (54) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
 if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (55) = true then
    drawbox55
    drawEmptyBox55
end if
if ball_1y > box_y1 (55) and ball_1y < box_y2 (55) and ball_1x > box_x1 (55) and ball_1x < box_x2 (55) and isThere (55) = true then
    isThere (55) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (56) = true then
    drawbox56
    drawEmptyBox56
end if
if ball_1y > box_y1 (56) and ball_1y < box_y2 (56) and ball_1x > box_x1 (56) and ball_1x < box_x2 (56) and isThere (56) = true then
    isThere (56) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (57) = true then
    drawbox57
    drawEmptyBox57
end if
if ball_1y > box_y1 (57) and ball_1y < box_y2 (57) and ball_1x > box_x1 (57) and ball_1x < box_x2 (57) and isThere (57) = true then
    isThere (57) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (58) = true then
    drawbox58
    drawEmptyBox58
end if
if ball_1y > box_y1 (58) and ball_1y < box_y2 (58) and ball_1x > box_x1 (58) and ball_1x < box_x2 (58) and isThere (58) = true then
    isThere (58) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (59) = true then
    drawbox59
    drawEmptyBox59
end if
if ball_1y > box_y1 (59) and ball_1y < box_y2 (59) and ball_1x > box_x1 (59) and ball_1x < box_x2 (59) and isThere (59) = true then
    isThere (59) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (60) = true then
    drawbox60
    drawEmptyBox60
end if
if ball_1y > box_y1 (60) and ball_1y < box_y2 (60) and ball_1x > box_x1 (60) and ball_1x < box_x2 (60) and isThere (60) = true then
    isThere (60) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (61) = true then
    drawbox61
    drawEmptyBox61
end if
if ball_1y > box_y1 (61) and ball_1y < box_y2 (61) and ball_1x > box_x1 (61) and ball_1x < box_x2 (61) and isThere (61) = true then
    isThere (61) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (62) = true then
    drawbox62
    drawEmptyBox62
end if
if ball_1y > box_y1 (62) and ball_1y < box_y2 (62) and ball_1x > box_x1 (62) and ball_1x < box_x2 (62) and isThere (62) = true then
    isThere (62) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (63) = true then
    drawbox63
    drawEmptyBox63
end if
if ball_1y > box_y1 (63) and ball_1y < box_y2 (63) and ball_1x > box_x1 (63) and ball_1x < box_x2 (63) and isThere (63) = true then
    isThere (63) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (64) = true then
    drawbox64
    drawEmptyBox64
end if
if ball_1y > box_y1 (64) and ball_1y < box_y2 (64) and ball_1x > box_x1 (64) and ball_1x < box_x2 (64) and isThere (64) = true then
    isThere (64) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
 if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (65) = true then
    drawbox65
    drawEmptyBox65
end if
if ball_1y > box_y1 (65) and ball_1y < box_y2 (65) and ball_1x > box_x1 (65) and ball_1x < box_x2 (65) and isThere (65) = true then
    isThere (65) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (66) = true then
    drawbox66
    drawEmptyBox66
end if
if ball_1y > box_y1 (66) and ball_1y < box_y2 (66) and ball_1x > box_x1 (66) and ball_1x < box_x2 (66) and isThere (66) = true then
    isThere (66) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (67) = true then
    drawbox67
    drawEmptyBox67
end if
if ball_1y > box_y1 (67) and ball_1y < box_y2 (67) and ball_1x > box_x1 (67) and ball_1x < box_x2 (67) and isThere (67) = true then
    isThere (67) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (68) = true then
    drawbox68
    drawEmptyBox68
end if
if ball_1y > box_y1 (68) and ball_1y < box_y2 (68) and ball_1x > box_x1 (68) and ball_1x < box_x2 (68) and isThere (68) = true then
    isThere (68) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (69) = true then
    drawbox69
    drawEmptyBox69
end if
if ball_1y > box_y1 (69) and ball_1y < box_y2 (69) and ball_1x > box_x1 (69) and ball_1x < box_x2 (69) and isThere (69) = true then
    isThere (69) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (70) = true then
    drawbox70
    drawEmptyBox70
end if
if ball_1y > box_y1 (70) and ball_1y < box_y2 (70) and ball_1x > box_x1 (70) and ball_1x < box_x2 (70) and isThere (70) = true then
    isThere (70) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (71) = true then
    drawbox71
    drawEmptyBox71
end if
if ball_1y > box_y1 (71) and ball_1y < box_y2 (71) and ball_1x > box_x1 (71) and ball_1x < box_x2 (71) and isThere (71) = true then
    isThere (71) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (72) = true then
    drawbox72
    drawEmptyBox72
end if
if ball_1y > box_y1 (72) and ball_1y < box_y2 (72) and ball_1x > box_x1 (72) and ball_1x < box_x2 (72) and isThere (72) = true then
    isThere (72) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
     if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (73) = true then
    drawbox73
    drawEmptyBox73
end if
if ball_1y > box_y1 (73) and ball_1y < box_y2 (73) and ball_1x > box_x1 (73) and ball_1x < box_x2 (73) and isThere (73) = true then
    isThere (73) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (74) = true then
    drawbox74
    drawEmptyBox74
end if
if ball_1y > box_y1 (74) and ball_1y < box_y2 (74) and ball_1x > box_x1 (74) and ball_1x < box_x2 (74) and isThere (74) = true then
    isThere (74) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (75) = true then
    drawbox75
    drawEmptyBox75
end if
if ball_1y > box_y1 (75) and ball_1y < box_y2 (75) and ball_1x > box_x1 (75) and ball_1x < box_x2 (75) and isThere (75) = true then
    isThere (75) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (76) = true then
    drawbox76
    drawEmptyBox76
end if
if ball_1y > box_y1 (76) and ball_1y < box_y2 (76) and ball_1x > box_x1 (76) and ball_1x < box_x2 (76) and isThere (76) = true then
    isThere (76) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (77) = true then
    drawbox77
    drawEmptyBox77
end if
if ball_1y > box_y1 (77) and ball_1y < box_y2 (77) and ball_1x > box_x1 (77) and ball_1x < box_x2 (77) and isThere (77) = true then
    isThere (77) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
 if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (78) = true then
    drawbox78
    drawEmptyBox78
end if
if ball_1y > box_y1 (78) and ball_1y < box_y2 (78) and ball_1x > box_x1 (78) and ball_1x < box_x2 (78) and isThere (78) = true then
    isThere (78) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (79) = true then
    drawbox79
    drawEmptyBox79
end if
if ball_1y > box_y1 (79) and ball_1y < box_y2 (79) and ball_1x > box_x1 (79) and ball_1x < box_x2 (79) and isThere (79) = true then
    isThere (79) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
 if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (80) = true then
    drawbox80
    drawEmptyBox80
end if
if ball_1y > box_y1 (80) and ball_1y < box_y2 (80) and ball_1x > box_x1 (80) and ball_1x < box_x2 (80) and isThere (80) = true then
    isThere (80) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
 if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (81) = true then
    drawbox81
    drawEmptyBox81
end if
if ball_1y > box_y1 (81) and ball_1y < box_y2 (81) and ball_1x > box_x1 (81) and ball_1x < box_x2 (81) and isThere (81) = true then
    isThere (81) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (82) = true then
    drawbox82
    drawEmptyBox82
end if
if ball_1y > box_y1 (82) and ball_1y < box_y2 (82) and ball_1x > box_x1 (82) and ball_1x < box_x2 (82) and isThere (82) = true then
    isThere (82) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
     if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (83) = true then
    drawbox83
    drawEmptyBox83
end if
if ball_1y > box_y1 (83) and ball_1y < box_y2 (83) and ball_1x > box_x1 (83) and ball_1x < box_x2 (83) and isThere (83) = true then
    isThere (83) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (84) = true then
    drawbox84
    drawEmptyBox84
end if
if ball_1y > box_y1 (84) and ball_1y < box_y2 (84) and ball_1x > box_x1 (84) and ball_1x < box_x2 (84) and isThere (84) = true then
    isThere (84) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (85) = true then
    drawbox85
    drawEmptyBox85
end if
if ball_1y > box_y1 (85) and ball_1y < box_y2 (85) and ball_1x > box_x1 (85) and ball_1x < box_x2 (85) and isThere (85) = true then
    isThere (85) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
      if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (86) = true then
    drawbox86
    drawEmptyBox86
end if
if ball_1y > box_y1 (86) and ball_1y < box_y2 (86) and ball_1x > box_x1 (86) and ball_1x < box_x2 (86) and isThere (86) = true then
    isThere (86) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (87) = true then
    drawbox87
    drawEmptyBox87
end if
if ball_1y > box_y1 (87) and ball_1y < box_y2 (87) and ball_1x > box_x1 (87) and ball_1x < box_x2 (87) and isThere (87) = true then
    isThere (87) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
     if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (88) = true then
    drawbox88
    drawEmptyBox88
end if
if ball_1y > box_y1 (88) and ball_1y < box_y2 (88) and ball_1x > box_x1 (88) and ball_1x < box_x2 (88) and isThere (88) = true then
    isThere (88) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
     if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (89) = true then
    drawbox89
    drawEmptyBox89
end if
if ball_1y > box_y1 (89) and ball_1y < box_y2 (89) and ball_1x > box_x1 (89) and ball_1x < box_x2 (89) and isThere (89) = true then
    isThere (89) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 or xchange = 7 and ychange = -5 then % This brick is also prone to being hit with a different ball speed.
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (90) = true then
    drawbox90
    drawEmptyBox90
end if
if ball_1y > box_y1 (90) and ball_1y < box_y2 (90) and ball_1x > box_x1 (90) and ball_1x < box_x2 (90) and isThere (90) = true then
    isThere (90) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (91) = true then
    drawbox91
    drawEmptyBox91
end if
if ball_1y > box_y1 (91) and ball_1y < box_y2 (91) and ball_1x > box_x1 (91) and ball_1x < box_x2 (91) and isThere (91) = true then
    isThere (91) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (92) = true then
    drawbox92
    drawEmptyBox92
end if
if ball_1y > box_y1 (92) and ball_1y < box_y2 (92) and ball_1x > box_x1 (92) and ball_1x < box_x2 (92) and isThere (92) = true then
    isThere (92) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
     if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (93) = true then
    drawbox93
    drawEmptyBox93
end if
if ball_1y > box_y1 (93) and ball_1y < box_y2 (93) and ball_1x > box_x1 (93) and ball_1x < box_x2 (93) and isThere (93) = true then
    isThere (93) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (94) = true then
    drawbox94
    drawEmptyBox94
end if
if ball_1y > box_y1 (94) and ball_1y < box_y2 (94) and ball_1x > box_x1 (94) and ball_1x < box_x2 (94) and isThere (94) = true then
    isThere (94) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (95) = true then
    drawbox95
    drawEmptyBox95
end if
if ball_1y > box_y1 (95) and ball_1y < box_y2 (95) and ball_1x > box_x1 (95) and ball_1x < box_x2 (95) and isThere (95) = true then
    isThere (95) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if isThere (96) = true then
    drawbox96
    drawEmptyBox96
end if
if ball_1y > box_y1 (96) and ball_1y < box_y2 (96) and ball_1x > box_x1 (96) and ball_1x < box_x2 (96) and isThere (96) = true then
    isThere (96) := false
    if xchange = -7 and ychange = -7 then
	xchange := 7
	ychange := -7
    elsif xchange = -7 and ychange = 7 then
	xchange := 7
	ychange := 7
    elsif xchange = 7 and ychange = 7 then
	xchange := -7
	ychange := 7
    elsif xchange = 7 and ychange = -7 then
	xchange := -7
	ychange := -7
    end if
    score1 += 10    
    if Sound = true then
    fork PlayHitBrick
    end if
end if
% PLAYER TWO

if ball_2y > box_y1 (1) and ball_2y < box_y2 (1) and ball_2x > box_x1 (1) and ball_2x < box_x2 (1) and isThere (1) = true then
    isThere (1) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7     
    elsif xchange2 = 7 and ychange2 = 7 or xchange2 = 7 and ychange2 = 5 then % There can be an event where ychange2 = 5 and hit this brick
	xchange2 := -7
	ychange2 := 7       
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (2) and ball_2y < box_y2 (2) and ball_2x > box_x1 (2) and ball_2x < box_x2 (2) and isThere (2) = true then
    isThere (2) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (3) and ball_2y < box_y2 (3) and ball_2x > box_x1 (3) and ball_2x < box_x2 (3) and isThere (3) = true then
    isThere (3) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (4) and ball_2y < box_y2 (4) and ball_2x > box_x1 (4) and ball_2x < box_x2 (4) and isThere (4) = true then
    isThere (4) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (5) and ball_2y < box_y2 (5) and ball_2x > box_x1 (5) and ball_2x < box_x2 (5) and isThere (5) = true then
    isThere (5) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (6) and ball_2y < box_y2 (6) and ball_2x > box_x1 (6) and ball_2x < box_x2 (6) and isThere (6) = true then
    isThere (6) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (7) and ball_2y < box_y2 (7) and ball_2x > box_x1 (7) and ball_2x < box_x2 (7) and isThere (7) = true then
    isThere (7) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (8) and ball_2y < box_y2 (8) and ball_2x > box_x1 (8) and ball_2x < box_x2 (8) and isThere (8) = true then
    isThere (8) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (9) and ball_2y < box_y2 (9) and ball_2x > box_x1 (9) and ball_2x < box_x2 (9) and isThere (9) = true then
    isThere (9) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (10) and ball_2y < box_y2 (10) and ball_2x > box_x1 (10) and ball_2x < box_x2 (10) and isThere (10) = true then
    isThere (10) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (11) and ball_2y < box_y2 (11) and ball_2x > box_x1 (11) and ball_2x < box_x2 (11) and isThere (11) = true then
    isThere (11) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (12) and ball_2y < box_y2 (12) and ball_2x > box_x1 (12) and ball_2x < box_x2 (12) and isThere (12) = true then
    isThere (12) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (13) and ball_2y < box_y2 (13) and ball_2x > box_x1 (13) and ball_2x < box_x2 (13) and isThere (13) = true then
    isThere (13) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (14) and ball_2y < box_y2 (14) and ball_2x > box_x1 (14) and ball_2x < box_x2 (14) and isThere (14) = true then
    isThere (14) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (15) and ball_2y < box_y2 (15) and ball_2x > box_x1 (15) and ball_2x < box_x2 (15) and isThere (15) = true then
    isThere (15) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (16) and ball_2y < box_y2 (16) and ball_2x > box_x1 (16) and ball_2x < box_x2 (16) and isThere (16) = true then
    isThere (16) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (17) and ball_2y < box_y2 (17) and ball_2x > box_x1 (17) and ball_2x < box_x2 (17) and isThere (17) = true then
    isThere (17) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (18) and ball_2y < box_y2 (18) and ball_2x > box_x1 (18) and ball_2x < box_x2 (18) and isThere (18) = true then
    isThere (18) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (19) and ball_2y < box_y2 (19) and ball_2x > box_x1 (19) and ball_2x < box_x2 (19) and isThere (19) = true then
    isThere (19) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (20) and ball_2y < box_y2 (20) and ball_2x > box_x1 (20) and ball_2x < box_x2 (20) and isThere (20) = true then
    isThere (20) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (21) and ball_2y < box_y2 (21) and ball_2x > box_x1 (21) and ball_2x < box_x2 (21) and isThere (21) = true then
    isThere (21) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (22) and ball_2y < box_y2 (22) and ball_2x > box_x1 (22) and ball_2x < box_x2 (22) and isThere (22) = true then
    isThere (22) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (23) and ball_2y < box_y2 (23) and ball_2x > box_x1 (23) and ball_2x < box_x2 (23) and isThere (23) = true then
    isThere (23) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (24) and ball_2y < box_y2 (24) and ball_2x > box_x1 (24) and ball_2x < box_x2 (24) and isThere (24) = true then
    isThere (24) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (25) and ball_2y < box_y2 (25) and ball_2x > box_x1 (25) and ball_2x < box_x2 (25) and isThere (25) = true then
    isThere (25) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (26) and ball_2y < box_y2 (26) and ball_2x > box_x1 (26) and ball_2x < box_x2 (26) and isThere (26) = true then
    isThere (26) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (27) and ball_2y < box_y2 (27) and ball_2x > box_x1 (27) and ball_2x < box_x2 (27) and isThere (27) = true then
    isThere (27) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (28) and ball_2y < box_y2 (28) and ball_2x > box_x1 (28) and ball_2x < box_x2 (28) and isThere (28) = true then
    isThere (28) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (29) and ball_2y < box_y2 (29) and ball_2x > box_x1 (29) and ball_2x < box_x2 (29) and isThere (29) = true then
    isThere (29) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (30) and ball_2y < box_y2 (30) and ball_2x > box_x1 (30) and ball_2x < box_x2 (30) and isThere (30) = true then
    isThere (30) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (31) and ball_2y < box_y2 (31) and ball_2x > box_x1 (31) and ball_2x < box_x2 (31) and isThere (31) = true then
    isThere (31) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (32) and ball_2y < box_y2 (32) and ball_2x > box_x1 (32) and ball_2x < box_x2 (32) and isThere (32) = true then
    isThere (32) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (33) and ball_2y < box_y2 (33) and ball_2x > box_x1 (33) and ball_2x < box_x2 (33) and isThere (33) = true then
    isThere (33) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (34) and ball_2y < box_y2 (34) and ball_2x > box_x1 (34) and ball_2x < box_x2 (34) and isThere (34) = true then
    isThere (34) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (35) and ball_2y < box_y2 (35) and ball_2x > box_x1 (35) and ball_2x < box_x2 (35) and isThere (35) = true then
    isThere (35) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (36) and ball_2y < box_y2 (36) and ball_2x > box_x1 (36) and ball_2x < box_x2 (36) and isThere (36) = true then
    isThere (36) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (37) and ball_2y < box_y2 (37) and ball_2x > box_x1 (37) and ball_2x < box_x2 (37) and isThere (37) = true then
    isThere (37) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (38) and ball_2y < box_y2 (38) and ball_2x > box_x1 (38) and ball_2x < box_x2 (38) and isThere (38) = true then
    isThere (38) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (39) and ball_2y < box_y2 (39) and ball_2x > box_x1 (39) and ball_2x < box_x2 (39) and isThere (39) = true then
    isThere (39) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (40) and ball_2y < box_y2 (40) and ball_2x > box_x1 (40) and ball_2x < box_x2 (40) and isThere (40) = true then
    isThere (40) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (41) and ball_2y < box_y2 (41) and ball_2x > box_x1 (41) and ball_2x < box_x2 (41) and isThere (41) = true then
    isThere (41) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (42) and ball_2y < box_y2 (42) and ball_2x > box_x1 (42) and ball_2x < box_x2 (42) and isThere (42) = true then
    isThere (42) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (43) and ball_2y < box_y2 (43) and ball_2x > box_x1 (43) and ball_2x < box_x2 (43) and isThere (43) = true then
    isThere (43) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (44) and ball_2y < box_y2 (44) and ball_2x > box_x1 (44) and ball_2x < box_x2 (44) and isThere (44) = true then
    isThere (44) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (45) and ball_2y < box_y2 (45) and ball_2x > box_x1 (45) and ball_2x < box_x2 (45) and isThere (45) = true then
    isThere (45) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (46) and ball_2y < box_y2 (46) and ball_2x > box_x1 (46) and ball_2x < box_x2 (46) and isThere (46) = true then
    isThere (46) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (47) and ball_2y < box_y2 (47) and ball_2x > box_x1 (47) and ball_2x < box_x2 (47) and isThere (47) = true then
    isThere (47) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (48) and ball_2y < box_y2 (48) and ball_2x > box_x1 (48) and ball_2x < box_x2 (48) and isThere (48) = true then
    isThere (48) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (49) and ball_2y < box_y2 (49) and ball_2x > box_x1 (49) and ball_2x < box_x2 (49) and isThere (49) = true then
    isThere (49) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (50) and ball_2y < box_y2 (50) and ball_2x > box_x1 (50) and ball_2x < box_x2 (50) and isThere (50) = true then
    isThere (50) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (51) and ball_2y < box_y2 (51) and ball_2x > box_x1 (51) and ball_2x < box_x2 (51) and isThere (51) = true then
    isThere (51) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (52) and ball_2y < box_y2 (52) and ball_2x > box_x1 (52) and ball_2x < box_x2 (52) and isThere (52) = true then
    isThere (52) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (53) and ball_2y < box_y2 (53) and ball_2x > box_x1 (53) and ball_2x < box_x2 (53) and isThere (53) = true then
    isThere (53) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (54) and ball_2y < box_y2 (54) and ball_2x > box_x1 (54) and ball_2x < box_x2 (54) and isThere (54) = true then
    isThere (54) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
 if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (55) and ball_2y < box_y2 (55) and ball_2x > box_x1 (55) and ball_2x < box_x2 (55) and isThere (55) = true then
    isThere (55) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (56) and ball_2y < box_y2 (56) and ball_2x > box_x1 (56) and ball_2x < box_x2 (56) and isThere (56) = true then
    isThere (56) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (57) and ball_2y < box_y2 (57) and ball_2x > box_x1 (57) and ball_2x < box_x2 (57) and isThere (57) = true then
    isThere (57) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (58) and ball_2y < box_y2 (58) and ball_2x > box_x1 (58) and ball_2x < box_x2 (58) and isThere (58) = true then
    isThere (58) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (59) and ball_2y < box_y2 (59) and ball_2x > box_x1 (59) and ball_2x < box_x2 (59) and isThere (59) = true then
    isThere (59) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (60) and ball_2y < box_y2 (60) and ball_2x > box_x1 (60) and ball_2x < box_x2 (60) and isThere (60) = true then
    isThere (60) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (61) and ball_2y < box_y2 (61) and ball_2x > box_x1 (61) and ball_2x < box_x2 (61) and isThere (61) = true then
    isThere (61) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (62) and ball_2y < box_y2 (62) and ball_2x > box_x1 (62) and ball_2x < box_x2 (62) and isThere (62) = true then
    isThere (62) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (63) and ball_2y < box_y2 (63) and ball_2x > box_x1 (63) and ball_2x < box_x2 (63) and isThere (63) = true then
    isThere (63) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (64) and ball_2y < box_y2 (64) and ball_2x > box_x1 (64) and ball_2x < box_x2 (64) and isThere (64) = true then
    isThere (64) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
 if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (65) and ball_2y < box_y2 (65) and ball_2x > box_x1 (65) and ball_2x < box_x2 (65) and isThere (65) = true then
    isThere (65) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (66) and ball_2y < box_y2 (66) and ball_2x > box_x1 (66) and ball_2x < box_x2 (66) and isThere (66) = true then
    isThere (66) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (67) and ball_2y < box_y2 (67) and ball_2x > box_x1 (67) and ball_2x < box_x2 (67) and isThere (67) = true then
    isThere (67) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (68) and ball_2y < box_y2 (68) and ball_2x > box_x1 (68) and ball_2x < box_x2 (68) and isThere (68) = true then
    isThere (68) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (69) and ball_2y < box_y2 (69) and ball_2x > box_x1 (69) and ball_2x < box_x2 (69) and isThere (69) = true then
    isThere (69) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (70) and ball_2y < box_y2 (70) and ball_2x > box_x1 (70) and ball_2x < box_x2 (70) and isThere (70) = true then
    isThere (70) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (71) and ball_2y < box_y2 (71) and ball_2x > box_x1 (71) and ball_2x < box_x2 (71) and isThere (71) = true then
    isThere (71) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (72) and ball_2y < box_y2 (72) and ball_2x > box_x1 (72) and ball_2x < box_x2 (72) and isThere (72) = true then
    isThere (72) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
     if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (73) and ball_2y < box_y2 (73) and ball_2x > box_x1 (73) and ball_2x < box_x2 (73) and isThere (73) = true then
    isThere (73) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (74) and ball_2y < box_y2 (74) and ball_2x > box_x1 (74) and ball_2x < box_x2 (74) and isThere (74) = true then
    isThere (74) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (75) and ball_2y < box_y2 (75) and ball_2x > box_x1 (75) and ball_2x < box_x2 (75) and isThere (75) = true then
    isThere (75) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (76) and ball_2y < box_y2 (76) and ball_2x > box_x1 (76) and ball_2x < box_x2 (76) and isThere (76) = true then
    isThere (76) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (77) and ball_2y < box_y2 (77) and ball_2x > box_x1 (77) and ball_2x < box_x2 (77) and isThere (77) = true then
    isThere (77) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
 if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (78) and ball_2y < box_y2 (78) and ball_2x > box_x1 (78) and ball_2x < box_x2 (78) and isThere (78) = true then
    isThere (78) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (79) and ball_2y < box_y2 (79) and ball_2x > box_x1 (79) and ball_2x < box_x2 (79) and isThere (79) = true then
    isThere (79) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
 if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (80) and ball_2y < box_y2 (80) and ball_2x > box_x1 (80) and ball_2x < box_x2 (80) and isThere (80) = true then
    isThere (80) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
 if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (81) and ball_2y < box_y2 (81) and ball_2x > box_x1 (81) and ball_2x < box_x2 (81) and isThere (81) = true then
    isThere (81) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (82) and ball_2y < box_y2 (82) and ball_2x > box_x1 (82) and ball_2x < box_x2 (82) and isThere (82) = true then
    isThere (82) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
     if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (83) and ball_2y < box_y2 (83) and ball_2x > box_x1 (83) and ball_2x < box_x2 (83) and isThere (83) = true then
    isThere (83) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (84) and ball_2y < box_y2 (84) and ball_2x > box_x1 (84) and ball_2x < box_x2 (84) and isThere (84) = true then
    isThere (84) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (85) and ball_2y < box_y2 (85) and ball_2x > box_x1 (85) and ball_2x < box_x2 (85) and isThere (85) = true then
    isThere (85) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
      if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (86) and ball_2y < box_y2 (86) and ball_2x > box_x1 (86) and ball_2x < box_x2 (86) and isThere (86) = true then
    isThere (86) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (87) and ball_2y < box_y2 (87) and ball_2x > box_x1 (87) and ball_2x < box_x2 (87) and isThere (87) = true then
    isThere (87) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
     if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (88) and ball_2y < box_y2 (88) and ball_2x > box_x1 (88) and ball_2x < box_x2 (88) and isThere (88) = true then
    isThere (88) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
     if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (89) and ball_2y < box_y2 (89) and ball_2x > box_x1 (89) and ball_2x < box_x2 (89) and isThere (89) = true then
    isThere (89) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 or xchange2 = 7 and ychange2 = -5 then % This brick is also prone to being hit with a different ball speed.
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (90) and ball_2y < box_y2 (90) and ball_2x > box_x1 (90) and ball_2x < box_x2 (90) and isThere (90) = true then
    isThere (90) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
  if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (91) and ball_2y < box_y2 (91) and ball_2x > box_x1 (91) and ball_2x < box_x2 (91) and isThere (91) = true then
    isThere (91) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (92) and ball_2y < box_y2 (92) and ball_2x > box_x1 (92) and ball_2x < box_x2 (92) and isThere (92) = true then
    isThere (92) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
     if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (93) and ball_2y < box_y2 (93) and ball_2x > box_x1 (93) and ball_2x < box_x2 (93) and isThere (93) = true then
    isThere (93) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
    if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (94) and ball_2y < box_y2 (94) and ball_2x > box_x1 (94) and ball_2x < box_x2 (94) and isThere (94) = true then
    isThere (94) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
   if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (95) and ball_2y < box_y2 (95) and ball_2x > box_x1 (95) and ball_2x < box_x2 (95) and isThere (95) = true then
    isThere (95) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10
	if Sound = true then
    fork PlayHitBrick
    end if
end if

if ball_2y > box_y1 (96) and ball_2y < box_y2 (96) and ball_2x > box_x1 (96) and ball_2x < box_x2 (96) and isThere (96) = true then
    isThere (96) := false
    if xchange2 = -7 and ychange2 = -7 then
	xchange2 := 7
	ychange2 := -7
    elsif xchange2 = -7 and ychange2 = 7 then
	xchange2 := 7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = 7 then
	xchange2 := -7
	ychange2 := 7
    elsif xchange2 = 7 and ychange2 = -7 then
	xchange2 := -7
	ychange2 := -7
    end if
    score2 += 10    
    if Sound = true then
    fork PlayHitBrick
    end if
end if

/****************\
 * Draw Paddles *   Dynamic Paddle
 \**************/

Input.KeyDown (chars1)
if chars1 ('w') then
    y1 := y1 + 12
end if
if y1 > maxy - 60 then
    y1 := maxy - 70
end if

if chars1 ('s') then
    y1 := y1 - 12
end if
if y1 < 0 then
    y1 := 0
end if

drawfillbox (10, y1, 18, y1 + 80, 41)

if bot = false then
if chars1 (KEY_UP_ARROW) then
    y2 := y2 + 12
end if
if y2 > maxy - 60 then
    y2 := maxy - 70
end if

if chars1 (KEY_DOWN_ARROW) then
    y2 := y2 - 12
end if
if y2 < 0 then
    y2 := 0
end if
else

% AI % if my ball is on his side and my ball is coming towards him and his ball is moving away then... or " and " and his ball is farther away then... 
if ball_1x > maxx div 2 + 100 and xchange > 0 and xchange2 < 0 or ball_1x > maxx div + 200 and xchange > 0 and ball_1x > ball_2x + 60 then
    if ball_1y > y2 + 40 then 
	MoveUp
    end if
    if ball_1y < y2 + 40 then
	MoveDown
    end if
    if ball_1y > y2 + 20 and ball_1y < y2 + 50 and ball_1x > 0 then
	TrackP1Ball := true
    end if

     if TrackP1Ball = true then % This makes the AI paddle look smoother (Less jerkey)
	 y2 := ball_1y - 40
	 TrackAIBall := false
     end if
elsif ball_1x < maxx div 2 and ball_2x < maxx div 2 then
Stop
else
    if ball_2y > y2 + 40 then % Have it move first, and then once the ball is close enough, have it track.
	MoveUp
    end if
    if ball_2y < y2 + 40 then
	MoveDown
    end if
    if ball_2y > y2 + 20 and ball_2y < y2 + 50 and  ball_2x > maxx - 50 and ball_2x > 0 then
	TrackAIBall := true
    end if
    
     if TrackAIBall = true and TrackP1Ball = false then % This makes the AI paddle look smoother (Less jerkey)
	 y2 := ball_2y - 40
     end if
end if
% End AI %

end if
drawfillbox (maxx - 14, y2, maxx - 6, y2 + 80, 33)
/*************************\
 * Draw Ball and Physics *
 \***********************/
% Physics for walls
drawfilloval (ball_1x, ball_1y, 5, 5, 41)
drawfilloval (ball_2x, ball_2y, 5, 5, 33)
delay (10)
View.Update
ball_1x += xchange
ball_2x += xchange2
ball_1y += ychange
ball_2y += ychange2
% TOP PLAYER ONE
if ball_1y > maxy - 10 then
    ychange := -7
    if Sound = true then
	fork PlayHitWall
    end if
end if
% TOP PLAYER TWO
if ball_2y > maxy - 10 then
    ychange2 := -7
    if Sound = true then
	fork PlayHitWall
    end if
end if
% PLAYER ONE ON Right SIDE
if ball_1x > maxx - 5 then
    xchange := -7
    if Sound = true then
	fork PlayHitWall
    end if
end if
% PLAYER TWO SIDE (Right)
if ball_2x > maxx - 5 then
    ball_2x := 1100
    ball_2y := 200
    if bot = true then
    TrackP1Ball := false
    end if
    y2 := 160
    xchange2 := 7
    ychange2 := 0
    score2 -= 10
    if Sound = true then
	fork PlayHitWall
    end if
end if
% BOTTOM PLAYER ONE
if ball_1y < 5  then
    ychange := 7
    if Sound = true then
	fork PlayHitWall
    end if
end if
% BOTTOM PLAYER TWO
if ball_2y < 5  then
    ychange2 := 7
    if Sound = true then
	fork PlayHitWall
    end if
end if
% PLAYER ONE SIDE (Left)
if ball_1x < 1 then
    ball_1x := 500
    ball_1y := 200
    y1 := 160
    xchange := -7
    ychange := 0    
    score1 -= 10
     if Sound = true then
	  fork PlayLooseBall
     end if
end if
% PLAYER TWO ON Left SIDE
if ball_2x < 1 then
    xchange2 := 7
     if Sound = true then
	  fork PlayLooseBall
     end if
end if

% Drawing Score
var newscore1 : string
newscore1 := intstr (score1)
Font.Draw (newscore1, 250, 400, bigFont, green) 
var newscore2 : string
newscore2 := intstr (score2)
Font.Draw (newscore2, 1200, 400, bigFont, green) 
 
Font.Draw (name1, 250, 600, font, purple)
Font.Draw (name2, 1200, 600, font, purple)
View.Update

% Collision for paddle PLAYER ONE
if ball_1x < 20 and ball_1y >= y1 and ball_1y <= y1 + 80 then
xchange := 7
    % Semi-Dynamic Collision
    if ychange = -7 or ychange = 0 then
	if ball_1y <= y1 + 40 and ball_1y >= y1 + 21 then
	    ychange := -7
	end if
	if ball_1y <= y1 + 80 and ball_1y >= y1 + 41 then
	    ychange := 7
	end if
    end if
    if ychange = 7 or ychange = 0 then
	if ball_1y <= y1+41 and ball_1y >= y1 then
	    ychange := -7
	end if
	if ball_1y <= y1 + 60 and ball_1y >= y1 + 42 then
	    ychange := 7
	end if
     end if

    if Sound = true then
    fork PlayHitPaddle
    end if
end if

if ball_2x < 20 and ball_2y >= y1 and ball_2y <= y1 + 80 then
xchange2 := 7
    % Semi-Dynamic Collision
    if ychange2 = -7 then
	if ball_2y <= y1 + 40 and ball_2y >= y1 + 21 then
	    ychange2 := -7
	end if
	if ball_2y <= y1 + 80 and ball_2y >= y1 + 41 then
	    ychange2 := 7
	end if
    end if
    if ychange2 = 7 then
	if ball_2y <= y1+41 and ball_2y >= y1 then
	    ychange2 := -7
	end if
	if ball_2y <= y1 + 60 and ball_2y >= y1 + 42 then
	    ychange2 := 7
	end if
     end if

    if Sound = true then
    fork PlayHitPaddle
    end if
end if
% If PLAYER ONE's BALL hits PLAYER TWO's PADDLE
if ball_1x > 1557 and ball_1y >= y2 and ball_1y <= y2 + 80 and xchange > 0 then
TrackP1Ball := false
score2 += 50
    xchange := -7
	if Sound = true then
    fork PlayHitPaddle
    end if
end if
% Collision for paddle PLAYER TWO
if ball_2x > 1557 and ball_2y >= y2 and ball_2y <= y2 + 80 then
xchange2 := -7
    % Semi-Dynamic Collision
    if ychange2 = -7 or ychange2 = 0 then
	if ball_2y <= y2 + 40 and ball_2y >= y2 then
	    ychange2 := -7
	end if
	if ball_2y <= y2 + 80 and ball_2y >= y2 + 41 then
	    ychange2 := 7
	end if
    end if
    if ychange2 = 7 or ychange2 = 0 then
	if ball_2y <= y2+41 and ball_2y >= y2 then
	    ychange := -7
	end if
	if ball_2y <= y2 + 80 and ball_2y >= y2 + 42 then
	    ychange2 := 7
	end if
     end if

    if Sound = true then
    fork PlayHitPaddle
    end if
end if

if ball_1x > 1557 and ball_1y >= y2 and ball_1y <= y2 + 80 then
xchange := -7
    % Semi-Dynamic Collision
    if ychange = -7 then
	if ball_1y <= y2 + 40 and ball_1y >= y2 then
	    ychange := -7
	end if
	if ball_1y <= y2 + 80 and ball_1y >= y2 + 41 then
	    ychange := 7
	end if
    end if
    if ychange = 7 then
	if ball_1y <= y2+41 and ball_1y >= y2 then
	    ychange := -7
	end if
	if ball_1y <= y2 + 80 and ball_1y >= y2 + 42 then
	    ychange := 7
	end if
     end if

    if Sound = true then
    fork PlayHitPaddle
    end if
end if
% If PLAYER TWO'S BALL hits PLAYER ONE'S PADDLE
if ball_2x < 25 and ball_2y >= y1 and ball_2y <= y1 + 80 and xchange2 < 0 then
score1 += 50 %                                                                      THIS DOESN'T WORK!! : /
    xchange2 := 7
    if Sound = true then
	fork PlayHitPaddle
    end if
end if
    
    exit when isThere(1) = false and isThere(2) = false and isThere(3) = false and isThere(4) = false and isThere(5) = false and isThere(6) = false and isThere(7) = false and isThere(8) = false and isThere(9) = false and isThere(10) = false and isThere(11) = false and isThere(12) = false and isThere(13) = false and isThere(14) = false and isThere(15) = false and isThere(16) = false and isThere(17) = false and isThere(18) = false and isThere(19) = false and isThere(20) = false and isThere(21) = false and isThere(22) = false and isThere(23) = false and isThere(24) = false and isThere(25) = false and isThere(26) = false and isThere(27) = false and isThere(28) = false and isThere(29) = false and isThere(30) = false and isThere(31) = false and isThere(32) = false and isThere(33) = false and isThere(34) = false and isThere(35) = false and isThere(36) = false and isThere(37) = false and isThere(38) = false and isThere(39) = false and isThere(40) = false and isThere(41) = false and isThere(42) = false and isThere(43) = false and isThere(44) = false and isThere(45) = false and isThere(46) = false and isThere(47) = false and isThere(48) = false and isThere(49) = false and isThere(50) = false and isThere(51) = false and isThere(52) = false and isThere(53) = false and isThere(54) = false and isThere(55) = false and isThere(56) = false and isThere(57) = false and isThere(58) = false and isThere(59) = false and isThere(60) = false and isThere(61) = false and isThere(62) = false and isThere(63) = false and isThere(64) = false and isThere(65) = false and isThere(66) = false and isThere(67) = false and isThere(68) = false and isThere(69) = false and isThere(70) = false and isThere(71) = false and isThere(72) = false and isThere(73) = false and isThere(74) = false and isThere(75) = false and isThere(76) = false and isThere(77) = false and isThere(78) = false and isThere(79) = false and isThere(80) = false

    % Pause Game
if chars1 ('p') then
    loop
	locate (20, 100)
	put "GAME PAUSED"
	locate (21, 98)
	put "Press any key to unpause"
	View.Update
	getch (c)
	DoUnPause
	exit when unpause = true
    end loop
end if

end loop

View.Set ("nooffscreenonly")
delay (500)
cls

var newscore1 : string
newscore1 := intstr (score1)
var newscore2 : string
newscore2 := intstr (score2)

if score1 > score2 then
Font.Draw (name1, 1, maxy div 2 + 200, bigFont, red)
Font.Draw (" WINS WITH ", 100, maxy div 2 + 200, bigFont, red)
Font.Draw (newscore1, 200, maxy div 2 + 200, bigFont, red)
Font.Draw (" POINTS! ", 300, maxy div 2 + 200, bigFont, red)
%put name1, " WINS WITH ", score1, " POINTS!"
elsif score1 < score2 then
Font.Draw (name2, 1, maxy div 2 + 200, bigFont, red)
Font.Draw (" WINS WITH ", 100, maxy div 2 + 200, bigFont, red)
Font.Draw (newscore2, 200, maxy div 2 + 200, bigFont, red)
Font.Draw (" POINTS! ", 300, maxy div 2 + 200, bigFont, red)
%put name2, " WINS WITH ", score2, " POINTS!"
else
Font.Draw (" TIE WITH ", 100, maxy div 2 + 200, bigFont, red)
Font.Draw (newscore1, 200, maxy div 2 + 200, bigFont, red)
Font.Draw (" POINTS EACH! ", 300, maxy div 2 + 200, bigFont, red)
%put "TIE WITH ", score1, " POINTS EACH!"
end if
