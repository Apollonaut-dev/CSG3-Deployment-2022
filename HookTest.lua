-- function onGameEvent(eventName,arg1,arg2,arg3,arg4)
--   --"friendly_fire", playerID, weaponName, victimPlayerID
--   --"mission_end", winner, msg
--   --"kill", killerPlayerID, killerUnitType, killerSide, victimPlayerID, victimUnitType, victimSide, weaponName
--   --"self_kill", playerID
--   --"change_slot", playerID, slotID, prevSide
--   --"connect", playerID, name
--   --"disconnect", playerID, name, playerSide, reason_code
--   --"crash", playerID, unit_missionID
--   --"eject", playerID, unit_missionID
--   --"takeoff", playerID, unit_missionID, airdromeName
--   --"landing", playerID, unit_missionID, airdromeName
--   --"pilot_death", playerID, unit_missionID
--   env.info('Hook received event: '..eventName)
-- end

local test = {}

function test.onPlayerTryConnect(ipaddr, name, ucid, playerID)
    print('onPlayerTryConnect(%s, %s, %s, %d)', ipaddr, name, ucid, playerID)
    -- if you want to gently intercept the call, allowing other user scripts to get it,
    -- you better return nothing here
    return true -- allow the player to connect
end

function test.onSimulationStart()
    print('Current mission is '..DCS.getMissionName())
end

DCS.setUserCallbacks(test)  -- here we set our callbacks