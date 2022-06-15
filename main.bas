'add doging and missed attacks
'add more monsters
'add more quests
'add monster run away
'add fight events
'add monsters only show up at levels _-_ instead of always PROBLEM WITH MAX LEVEL

DECLARE SUB GAMELOOP()
DECLARE SUB MonsterSelection()
DECLARE SUB BossSelection()
DECLARE SUB PLAYERATFOREST()
DECLARE SUB PLAYERATTACKEDBYMONSTER()
DECLARE SUB MonsterTurn()
DECLARE SUB PAttack()
DECLARE SUB PDefend()
DECLARE SUB PRunAway()
DECLARE SUB MonsterDefeated()
DECLARE SUB Town()
DECLARE SUB AtInn()
DECLARE SUB AtShop()
DECLARE SUB EndGame()

'MAKES VARIABLES SHARED SO THEY CAN BE ACCESSED BY SUBROUTIENS
'DON'T FORGET TO PUT VARIABLES IN HERE
DIM SHARED Action, PLAYERNAME$, playerhealth, playerfullhealth, playermaxhealth, PLAYERDEFENCE, PLAYERMAXDEFENCE, PLAYERATTACK, PLAYERMAXATTACK, PlayerLevel, PLAYERMONEY, PLAYERQUEST, PLAYERLOCATION$, MONSTERNAME$, MONSTERLEVEL, MONSTERHEALTH, MONSTERATTACK, MONSTERCHARGEATTACK, MONSTERCHARGEATTACKCHANCE, MONSTERCHARGEATTACKTURNS, MONCHARGEATTACKTURNSLEFT, MONSTERISCHARGING, MONSTERCRITATTACK, MONSTERCRITATTACKCHANCE, MONSTERREWARD, MONSTERRUNDIFFICULTY, MONSTERISBOSS, BossLevel, BossReward, BossDefeated, GameDone

WHILE PLAYERNAME$ = "" OR PLAYERNAME$ = " " OR PLAYERNAME$ = "  "
  PRINT "ENTER PLAYERNAME TO BEGIN"
  INPUT PLAYERNAME$
  PRINT
  IF PLAYERNAME$ = "" OR PLAYERNAME$ = " " OR PLAYERNAME$ = "  " THEN
    PRINT "Invalid Name Try Again" 
  END IF
WEND

' Player Variables
playerhealth = 100
playerfullhealth = 100
playermaxhealth = 300
PLAYERDEFENCE = 10 ' Precent of damage blocked
PLAYERMAXDEFENCE = 90
PLAYERATTACK = 3
PLAYERMAXATTACK = 15
PlayerLevel = 0
PLAYERMONEY = 10
PLAYERQUEST = 0
PLAYERLOCATION$ = "town"

' Monster Variables
MONSTERNAME$ = "NULL"
MONSTERLEVEL = 9999999
MONSTERHEALTH = 10
MONSTERATTACK = 3
MONSTERCHARGEATTACK = 4
MONSTERCHARGEATTACKCHANCE = 10
MONSTERCHARGEATTACKTURNS = 2
MONCHARGEATTACKTURNSLEFT = 1
MONSTERISCHARGING = 0
MONSTERCRITATTACK = 2 'THIS IS MULTIPLIED
MONSTERCRITATTACKCHANCE = 3
MONSTERREWARD = 3
MONSTERRUNDIFFICULTY = 80 'LESS THAN | OUT OF 100 | PRECENT CHANCE OF RUNING

MONSTERISBOSS = 0
BossLevel = 9999
BossReward = 10000
BossDefeated = 0

GameDone = 0

PRINT PLAYERNAME$; " has "; INT(playerhealth); " hp and "; PLAYERMONEY; " Coins."
PRINT
PRINT "One day "; PLAYERNAME$; " gets 3 letters."
PRINT "The first letter reads: "
PRINT "   Defeat the Dragon in the forest(12 levels) | Reward: 10,000 coins"
PRINT
PRINT PLAYERNAME$; " decides to accept 1 of the letters."
PRINT "Choose a letter to accept (Press 1)"', 2, or 3)"

WHILE PLAYERQUEST = 0
  INPUT Action
  IF Action = 1 THEN
    PRINT PLAYERNAME$; " accepts the first letter."
    Action = 0
    PLAYERQUEST = 1
    BossLevel = 12
    BossReward = 10000
  ELSE
    PRINT "Invalid command try again"
    PRINT "Choose a letter to accept (Press 1)"
    Action = 0
  END IF
WEND

INPUT SPACE
GAMELOOP()

SUB GAMELOOP()
  WHILE playerhealth > 0 AND GameDone = 0
    IF PLAYERLOCATION$ = "forest" THEN
      PLAYERATFOREST()
    ELSE IF PLAYERLOCATION$ = "forestMonster" THEN
      PLAYERATTACKEDBYMONSTER()
    ELSE IF PLAYERLOCATION$ = "town" THEN
      Town()
    ELSE IF PLAYERLOCATION$ = "Ending" THEN
      EndGame()
    ELSE
      PRINT "WHERE ARE YOU"
    END IF
  WEND
  IF playerhealth <= 0 THEN
    PRINT
    PRINT PLAYERNAME$; " has been defeated."
  END IF
END SUB

SUB MonsterSelection()
  MONSTERNAME$ = "NULL"
  MONSTERLEVEL = 9999999
  MONSTERHEALTH = 10
  MONSTERATTACK = 3
  MONSTERCHARGEATTACK = 4
  MONSTERCHARGEATTACKCHANCE = 10
  MONSTERCHARGEATTACKTURNS = 2
  MONCHARGEATTACKTURNSLEFT = 1
  MONSTERISCHARGING = 0
  MONSTERCRITATTACK = 2 'THIS IS MULTIPLIED
  MONSTERCRITATTACKCHANCE = 3
  MONSTERREWARD = 3
  MONSTERRUNDIFFICULTY = 80 'LESS THAN | OUT OF 100 | PRECENT CHANCE OF RUNING
  MONSTERISBOSS = 0
  WHILE MONSTERLEVEL > PlayerLevel
    monster = INT(RND * 4) + 1
    IF monster = 1 THEN
      MONSTERNAME$ = "Slime"
      MONSTERLEVEL = 1
      MONSTERHEALTH = 5
      MONSTERATTACK = 2
      MONSTERCHARGEATTACK = 4
      MONSTERCHARGEATTACKCHANCE = 5
      MONSTERCHARGEATTACKTURNS = INT(RND * 2) + 1
      MONSTERCRITATTACK = 2 'THIS IS MULTIPLIED
      MONSTERCRITATTACKCHANCE = 10
      MONSTERREWARD = INT(RND * 2) + 1
      MONSTERRUNDIFFICULTY = 99 'LESS THAN | OUT OF 100 | PRECENT CHANCE OF RUNING
    ELSE IF monster = 2 THEN
      MONSTERNAME$ = "Goblin"
      MONSTERLEVEL = 4
      MONSTERHEALTH = 7
      MONSTERATTACK = 3
      MONSTERCHARGEATTACK = 5
      MONSTERCHARGEATTACKCHANCE = 4
      MONSTERCHARGEATTACKTURNS = 1
      MONSTERCRITATTACK = 2 'THIS IS MULTIPLIED
      MONSTERCRITATTACKCHANCE = 12
      MONSTERREWARD = 3
      MONSTERRUNDIFFICULTY = 90 'LESS THAN | OUT OF 100 | PRECENT CHANCE OF RUNING
    ELSE IF monster = 3 THEN
      MONSTERNAME$ = "Giant Spider"
      MONSTERLEVEL = 7
      MONSTERHEALTH = 10
      MONSTERATTACK = 4
      MONSTERCHARGEATTACK = 7
      MONSTERCHARGEATTACKCHANCE = 4
      MONSTERCHARGEATTACKTURNS = 2
      MONSTERCRITATTACK = 2 'THIS IS MULTIPLIED
      MONSTERCRITATTACKCHANCE = 10
      MONSTERREWARD = 4
      MONSTERRUNDIFFICULTY = 80 'LESS THAN | OUT OF 100 | PRECENT CHANCE OF RUNING
    ELSE IF monster = 4 THEN
      MONSTERNAME$ = "Knight"
      MONSTERLEVEL = 10
      MONSTERHEALTH = 15
      MONSTERATTACK = 6
      MONSTERCHARGEATTACK = 9
      MONSTERCHARGEATTACKCHANCE = 6
      MONSTERCHARGEATTACKTURNS = 3
      MONSTERCRITATTACK = 2 'THIS IS MULTIPLIED
      MONSTERCRITATTACKCHANCE = 10
      MONSTERREWARD = 10
      MONSTERRUNDIFFICULTY = 60 'LESS THAN | OUT OF 100 | PRECENT CHANCE OF RUNING
    END IF
  WEND
END SUB

SUB BossSelection()
  MONSTERNAME$ = "NULL"
  MONSTERMINLEVEL = 0
  MONSTERMAXLEVEL = 0
  MONSTERHEALTH = 10
  MONSTERATTACK = 3
  MONSTERCHARGEATTACK = 4
  MONSTERCHARGEATTACKCHANCE = 10
  MONSTERCHARGEATTACKTURNS = 2
  MONCHARGEATTACKTURNSLEFT = 1
  MONSTERISCHARGING = 0
  MONSTERCRITATTACK = 2 'THIS IS MULTIPLIED
  MONSTERCRITATTACKCHANCE = 3
  MONSTERREWARD = 0
  MONSTERRUNDIFFICULTY = 99 'LESS THAN | OUT OF 100 | PRECENT CHANCE OF RUNING
  MONSTERISBOSS = 1
  IF PLAYERQUEST = 1 THEN
    MONSTERNAME$ = "Dragon"
    MONSTERHEALTH = 50
    MONSTERATTACK = 10
    MONSTERCHARGEATTACK = 20
    MONSTERCHARGEATTACKCHANCE = 6
    MONSTERCHARGEATTACKTURNS = 3
    MONSTERCRITATTACK = 2 'THIS IS MULTIPLIED
    MONSTERCRITATTACKCHANCE = 10
    MONSTERRUNDIFFICULTY = 1 'LESS THAN | OUT OF 100 | PRECENT CHANCE OF RUNING
    MONCHARGEATTACKTURNSLEFT = MONSTERCHARGEATTACKTURNS
  ELSE IF PLAYERQUEST = 2 THEN
    MONSTERNAME$ = "Stone Giant"
    MONSTERHEALTH = 50
    MONSTERATTACK = 10
    MONSTERCHARGEATTACK = 18
    MONSTERCHARGEATTACKCHANCE = 5
    MONSTERCHARGEATTACKTURNS = 4
    MONSTERCRITATTACK = 1.2 'THIS IS MULTIPLIED
    MONSTERCRITATTACKCHANCE = 7
    MONSTERRUNDIFFICULTY = 1 'LESS THAN | OUT OF 100 | PRECENT CHANCE OF RUNING
  ELSE IF PLAYERQUEST = 3 THEN
    PRINT
  END IF
END SUB

SUB PLAYERATFOREST()
  PlayerLevel = PlayerLevel + 1
  PRINT PLAYERNAME$; " is "; PlayerLevel; " levels deep in the forest. "
  PRINT PLAYERNAME$; " is in a forest"
  IF PlayerLevel < BossLevel THEN
    PRINT "Press 1 to go deeper into the forest | Press 2 to go back to the town"
  ELSE
    PRINT "Press 1 to fight the Dragon | Press 2 to go back to the town"
  END IF
  Action = 0
  WHILE PLAYERLOCATION$ = "forest"
    INPUT Action
    IF Action = 1 THEN
      IF PlayerLevel < BossLevel THEN
        MonsterSelection()
      ELSE
        BossSelection()
      END IF
      PLAYERLOCATION$ = "forestMonster"
    ELSE IF Action = 2 THEN
      PLAYERLOCATION$ = "town"
      PlayerLevel = 0
    ELSE
      PRINT "Unknowen Command Try Again"
      Action = 0
      PRINT "Press 1 go deeper into the forest | Press 2 to go back to the town"
    END IF
  WEND
END SUB

SUB PLAYERATTACKEDBYMONSTER()
  PRINT PLAYERNAME$; " gets attacked by a "; MONSTERNAME$; "!"
  INPUT SPACE
  PRINT PLAYERNAME$; " has "; INT(playerhealth); " hp."
  PRINT "The "; MONSTERNAME$; " has "; MONSTERHEALTH; " hp and "; MONSTERATTACK; " Attack."
  PRINT "Press 1 to attack | Press 2 to defend | Press 3 to try to run"
  WHILE PLAYERLOCATION$ = "forestMonster" AND playerhealth > 0
    INPUT Action
    IF Action = 1 THEN
      PAttack()
      IF PLAYERLOCATION$ = "forestMonster" AND playerhealth > 0 THEN
        Action = 0
        PRINT "Press 1 to attack | Press 2 to defend | Press 3 to try to run"
      END IF
    ELSE IF Action = 2 THEN
      PDefend()
      Action = 0
      PRINT "Press 1 to attack | Press 2 to defend | Press 3 to try to run"
    ELSE IF Action = 3 THEN
      PRunAway()
      IF PLAYERLOCATION$ = "forestMonster" THEN
        Action = 0
        PRINT "Press 1 to attack | Press 2 to defend | Press 3 to try to run"
      END IF
    ELSE
      PRINT "Unknowen Command Try Again"
      Action = 0
      PRINT "Press 1 to attack | Press 2 to defend | Press 3 to try to run"
    END IF
  WEND
END SUB

SUB MonsterTurn()
  IF MONSTERISCHARGING = 1 THEN
    IF MONCHARGEATTACKTURNSLEFT = 0 THEN
      moncritchan = INT(RND * MONSTERCRITATTACKCHANCE) + 1
      IF moncritchan = 1 THEN
        PRINT "The "; MONSTERNAME$; " uses its charged attack." 
        PRINT "CRITICAL ATTACK!!"
        IF Action = 2 THEN
          PRINT "The "; MONSTERNAME$; " attacked "; PLAYERNAME$; " for "; INT((MONSTERCHARGEATTACK * MONSTERCRITATTACK) * (PLAYERDEFENCE / 100)); " damage!"
          playerhealth = playerhealth - INT(((MONSTERCHARGEATTACK * MONSTERCRITATTACK) * (PLAYERDEFENCE / 100)))
        ELSE
          PRINT "The "; MONSTERNAME$; " attacked "; PLAYERNAME$; " for "; INT(MONSTERCHARGEATTACK * MONSTERCRITATTACK); " damage!"
          playerhealth = playerhealth - INT((MONSTERCHARGEATTACK * MONSTERCRITATTACK))
        END IF
        IF playerhealth > 0 THEN
          PRINT PLAYERNAME$; " has "; INT(playerhealth); " hp left."
        END IF
      ELSE
        PRINT "The "; MONSTERNAME$; " uses its charged attack." 
        IF Action = 2 THEN
          PRINT "The "; MONSTERNAME$; " attacked "; PLAYERNAME$; " for ";INT(MONSTERCHARGEATTACK * (PLAYERDEFENCE / 100)); " damage."
          playerhealth = playerhealth - INT((MONSTERCHARGEATTACK * (PLAYERDEFENCE / 100)))
        ELSE
          PRINT "The "; MONSTERNAME$; " attacked "; PLAYERNAME$; " for "; INT(MONSTERCHARGEATTACK); " damage."
          playerhealth = playerhealth - INT(MONSTERCHARGEATTACK)
        END IF
        IF playerhealth > 0 THEN
          PRINT PLAYERNAME$; " has "; INT(playerhealth); " hp left."
        END IF
      END IF
      MONCHARGEATTACKTURNSLEFT = MONSTERCHARGEATTACKTURNS
      MONSTERISCHARGING = 0
    ELSE
      PRINT "The "; MONSTERNAME$; " is still charging an attack."
      MONCHARGEATTACKTURNSLEFT = MONCHARGEATTACKTURNSLEFT - 1
    END IF
  ELSE
    monchargechan = INT(RND * MONSTERCHARGEATTACKCHANCE) + 1
    IF monchargechan = 1 THEN
      PRINT "The "; MONSTERNAME$; " starts charging an attack."
      MONSTERISCHARGING = 1
    ELSE
      moncritchan = INT(RND * MONSTERCRITATTACKCHANCE) + 1
      IF moncritchan = 1 THEN
        PRINT "CRITICAL ATTACK!!"
        IF Action = 2 THEN
          PRINT "The "; MONSTERNAME$; " attacked "; PLAYERNAME$; " for "; INT((MONSTERATTACK * MONSTERCRITATTACK) * (PLAYERDEFENCE / 100)); " damage!"
          playerhealth = playerhealth - INT(((MONSTERATTACK * MONSTERCRITATTACK) * (PLAYERDEFENCE / 100)))
        ELSE
          PRINT "The "; MONSTERNAME$; " attacked "; PLAYERNAME$; " for "; INT(MONSTERATTACK * MONSTERCRITATTACK); " damage!"
          playerhealth = playerhealth - INT((MONSTERATTACK * MONSTERCRITATTACK))
        END IF
        IF playerhealth > 0 THEN
          PRINT PLAYERNAME$; " has "; INT(playerhealth); " hp left."
        END IF
      ELSE
        IF Action = 2 THEN
          PRINT "The "; MONSTERNAME$; " attacked "; PLAYERNAME$; " for "; INT(MONSTERATTACK * (PLAYERDEFENCE / 100)); " damage."
          playerhealth = playerhealth - INT((MONSTERATTACK * (PLAYERDEFENCE / 100)))
        ELSE
          PRINT "The "; MONSTERNAME$; " attacked "; PLAYERNAME$; " for "; INT(MONSTERATTACK); " damage."
          playerhealth = playerhealth - INT(MONSTERATTACK)
        END IF
        IF playerhealth > 0 THEN
          PRINT PLAYERNAME$; " has "; INT(playerhealth); " hp left."
        END IF
      END IF
    END IF
  END IF
END SUB

SUB MonsterDefeated()
  'PRINT "The "; MONSTERNAME$; " has 0 hp left."
  IF MONSTERISBOSS = 0 THEN
    INPUT SPACE
    PRINT PLAYERNAME$; " defeated the "; MONSTERNAME$; " and got "; MONSTERREWARD; " gold."
    PLAYERMONEY = PLAYERMONEY + MONSTERREWARD
    PRINT PLAYERNAME$; " now has "; INT(playerhealth); " hp, "; PLAYERMONEY; " Coins.";
    Action = 0
    INPUT SPACE
    PLAYERLOCATION$ = "forest"
    PRINT
  ELSE
    INPUT SPACE
    PRINT PLAYERNAME$; " has defeated the "; MONSTERNAME$; " !"
    PRINT PLAYERNAME$; " returns to the town to claim their Reward "
    Action = 0
    INPUT SPACE
    PLAYERLOCATION$ = "Ending"
    PRINT
  END IF
END SUB

SUB PAttack()
  PRINT PLAYERNAME$; " decided to attack the "; MONSTERNAME$; "."
  critical = INT(RND * 10) + 1
  IF critical = 5 THEN
    PRINT "CRITICAL ATTACK!!"
    PRINT PLAYERNAME$; " attacked the "; MONSTERNAME$; " for "; PLAYERATTACK * 2; " damage!"
    MONSTERHEALTH = MONSTERHEALTH - (PLAYERATTACK * 2)
    IF MONSTERHEALTH > 0 THEN
      PRINT "The "; MONSTERNAME$; " has "; MONSTERHEALTH; " health left."
      INPUT SPACE
      MonsterTurn()
    ELSE
      MonsterDefeated()
    END IF
  ELSE
    PRINT PLAYERNAME$; " attacked the "; MONSTERNAME$; " for "; PLAYERATTACK; " damage."
    MONSTERHEALTH = MONSTERHEALTH - PLAYERATTACK
    IF MONSTERHEALTH > 0 THEN
      PRINT "The "; MONSTERNAME$; " has "; INT(MONSTERHEALTH); " health left."
      INPUT SPACE
      MonsterTurn()
    ELSE
      MonsterDefeated()
    END IF
  END IF
END SUB

SUB PDefend()
  PRINT PLAYERNAME$; " decided to try defend themself"
  INPUT SPACE
  MonsterTurn()
END SUB

SUB PRunAway()
  PRINT PLAYERNAME$; " tried to run away"
  RunSuccessful = INT(RND * 100) + 1
  IF RunSuccessful <= MONSTERRUNDIFFICULTY THEN
    PRINT PLAYERNAME$; " got away"
    INPUT SPACE
    Action = 0
    PLAYERLOCATION$ = "forest"
    PlayerLevel = PlayerLevel - 1
  ELSE
    PRINT "The "; MONSTERNAME$; " blocked the way"
    INPUT SPACE
    MonsterTurn()
  END IF
END SUB

SUB Town()
  Action = 0
  PRINT PLAYERNAME$; " is at the town"
  PRINT "Press 1 to go to the inn | Press 2 to go to the shop | Press 3 to go to the forest"
  WHILE PLAYERLOCATION$ = "town"
    INPUT Action
    IF Action = 1 THEN
      AtInn()
      Action = 0
      PRINT "Press 1 to go to the inn | Press 2 to go to the shop | Press 3 to go to the forest"
    ELSE IF Action = 2 THEN
      AtShop()
      Action = 0
      PRINT "Press 1 to go to the inn | Press 2 to go to the shop | Press 3 to go to the forest"
    ELSE IF Action = 3 THEN
      PRINT PLAYERNAME$; " goes to the forest"
      Action = 0
      PLAYERLOCATION$ = "forest"
      PRINT
    ELSE
      PRINT "Unknowen Command Try Again"
      Action = 0
      PRINT "Press 1 to go to the inn | Press 2 to go to the shop | Press 3 to go to the forest"
    END IF
  WEND
END SUB

SUB AtInn()
  'Put inn cost in variable later
  PRINT PLAYERNAME$; " goes to the inn."
  PRINT PLAYERNAME$; " now has "; INT(playerhealth); " health."
  PRINT "It costs 20 coins to stay at the inn."
  PAtInn = 1
  WHILE PAtInn = 1
    Action = 0
    PRINT "Press 1 to leave | Press 2 to stay at the inn"
    INPUT Action
    IF Action = 1 THEN
      PRINT PLAYERNAME$; " left the inn."
      PAtInn = 0
    ELSE IF Action = 2 THEN
      IF (PLAYERMONEY - 20) >= 0 THEN
        PLAYERMONEY = PLAYERMONEY - 20
        playerhealth = playerfullhealth
        PRINT PLAYERNAME$; " stayed at the inn and got full health."
        INPUT SPACE
        PRINT PLAYERNAME$; " now has "; playerhealth; " health."
      ELSE
        PRINT PLAYERNAME$; " dosn't have enough coins."
      END IF
    ELSE
      PRINT "Unknowen Command Try Again"
    END IF
  WEND
END SUB

SUB AtShop()
  'Put inn cost in variable later
  PRINT PLAYERNAME$; " goes to the shop."
  PRINT
  PAtShop = 1
  WHILE PAtShop = 1
    PRINT PLAYERNAME$; " has "; PLAYERMONEY; " coins"
    PRINT
    Action = 0
    PRINT "There are 3 items"
    PRINT "Item 2: +20 max health | 30 Coins"
    PRINT "Item 3: +1 attack | 20 Coins"
    PRINT "Item 4: +10% defence | 50 Coins"
    PRINT "Press 1 to leave | Press the Item number to purchase it."
    INPUT Action
    IF Action = 1 THEN
      PRINT PLAYERNAME$; " left the shop."
      PAtShop = 0
    ELSE IF Action = 2 THEN
      IF (PLAYERMONEY - 30) >= 0 AND playerfullhealth + 20 <= playermaxhealth THEN
        PLAYERMONEY = PLAYERMONEY - 30
        playerfullhealth = playerfullhealth + 20
        PRINT PLAYERNAME$; " got +20 max health."
        INPUT SPACE
        PRINT PLAYERNAME$; " now has "; INT(playerhealth); " / "; playerfullhealth; " health."
      ELSE IF playerfullhealth + 20 > playermaxhealth THEN
        PRINT PLAYERNAME$; " can't get more health."
      ELSE
        PRINT PLAYERNAME$; " dosn't have enough coins."
      END IF
    ELSE IF Action = 3 THEN
      IF (PLAYERMONEY - 20) >= 0 AND PLAYERATTACK + 1 <= PLAYERMAXATTACK THEN
        PLAYERMONEY = PLAYERMONEY - 20
        PLAYERATTACK = PLAYERATTACK + 1
        PRINT PLAYERNAME$; " got +1 attack."
        INPUT SPACE
        PRINT PLAYERNAME$; " now has "; PLAYERATTACK; " attack power."
      ELSE IF LAYERATTACK + 1 > PLAYERMAXATTACK THEN
        PRINT PLAYERNAME$; " can't get more attack."
      ELSE
        PRINT PLAYERNAME$; " dosn't have enough coins."
      END IF
    ELSE IF Action = 4 THEN
      IF (PLAYERMONEY - 60) >= 0 AND PLAYERDEFENCE + 1 <= PLAYERMAXDEFENCE THEN
        PLAYERMONEY = PLAYERMONEY - 60
        PLAYERDEFENCE = PLAYERDEFENCE + 10
        PRINT PLAYERNAME$; " got +10% defence."
        INPUT SPACE
        PRINT PLAYERNAME$; " now has "; PLAYERDEFENCE; "% defence."
      ELSE IF PLAYERDEFENCE + 1 > PLAYERMAXDEFENCE THEN
        PRINT PLAYERNAME$; " can't get more defence."
      ELSE
        PRINT PLAYERNAME$; " dosn't have enough coins."
        PRINT
      END IF
    ELSE
      PRINT "Unknowen Command Try Again"
      PRINT
    END IF
  WEND
END SUB

SUB EndGame()
  PRINT PLAYERNAME$; " returned back to the town and claimed his reward of "; MONSTERREWARD; " coins."
  PRINT "The End"
  INPUT SPACE
  PRINT "you can now:"
  PRINT "(1) keep playing and see how far you can get or"
  PRINT "restart and try a different quest"
  Action = 0
  INPUT Action
  IF Action = 1 THEN
    PLAYERLOCATION$ = "town"
  ELSE
    endgame = 1
  END IF
END SUB