-- No MOOSE settings menu. Comment out this line if required.
_SETTINGS:SetPlayerMenuOff()

CVW17 = AIRWING:New("TDR")
CVW17:SetTakeoffAir()
CVW17:SetDespawnAfterHolding()
CVW17:Start()

-- OPSGROUP:New(GROUP:FindByName('TDR')):SwitchTACAN(71, 'TDR', 'TDR', 'X')

VAW112 = SQUADRON:New("Wizard", 4, "VAW112")
VAW112:AddMissionCapability({ AUFTRAG.Type.AWACS }, 100)
VAW112:SetMissionRange(200)

VAW112DL = SQUADRON:New("VAWDL", 4, "VAW112DL")
VAW112DL:AddMissionCapability({ AUFTRAG.Type.AWACS }, 100)
VAW112DL:SetMissionRange(200)

VAQ132 = SQUADRON:New("Prowler", 4, "VAQ132")
VAQ132:SetMissionRange(200)

VS30 = SQUADRON:New("Harpoon", 8, "VS30")
VS30:SetMissionRange(200)

CVW17:AddSquadron(VAW112)
CVW17:AddSquadron(VAW112DL)
CVW17:AddSquadron(VAQ132)
CVW17:AddSquadron(VS30)

CVW17:NewPayload(GROUP:FindByName("Wizard"), -1, { AUFTRAG.Type.ORBIT }, 100)
CVW17:NewPayload(GROUP:FindByName("VAWDL"), -1, { AUFTRAG.Type.AWACS }, 100)
-- CVW17:NewPayload(GROUP:FindByName("Viking"), 2, { AUFTRAG.Type.ORBIT}, 100)
CVW17:NewPayload(GROUP:FindByName("Harpoon"), -1, { AUFTRAG.Type.ORBIT }, 100)
CVW17:NewPayload(GROUP:FindByName("Prowler"), -1, { AUFTRAG.Type.ORBIT }, 100)

function CVW17:OnAfterFlightOnMission( From, Event, To, Flightgroup, Mission )
  local grp = Flightgroup:GetGroup()
  Flightgroup:SwitchInvisible( true )
  
  if string.match(grp:GetName(), "VAQ132") then
    local jammerunit = grp:GetDCSObject():getUnit(1)
    local Jammer = SkynetIADSJammer:create(jammerunit, rusIADS)
    Jammer:masterArmSafe(true)
    Jammer:disableFor('SA-10B')
    Jammer:disableFor('SA-10')
    Jammer:disableFor('SA-12')
    Jammer:setMaximumEffectiveDistance(100)
    Jammer:masterArmOn(true)

    local elintunit = grp:GetDCSObject():getUnit(1)
    local recon = Elint_blue:addPlatform(elintunit:getName())
  elseif string.match(grp:GetName(), "VS30") then
    local elintunit = grp:GetDCSObject():getUnit(1)
    local recon = Elint_blue:addPlatform(elintunit:getName())
  elseif string.match(grp:GetName(), "VAW112") then
    local elintunit = grp:GetDCSObject():getUnit(1)
    local recon = Elint_blue:addPlatform(elintunit:getName())
  end

  function grp:OnAfterRTB(From, Event, To) 
    Elint_blue:removePlatform(grp:GetName())
  end
end

-- S-3B Recovery Tanker spawning in air.
local tdrtanker = RECOVERYTANKER:New("TDR", "TDRS3B")
tdrtanker:SetRadio(251.100)
tdrtanker:SetModex(701)
tdrtanker:SetCallsign(CALLSIGN.Tanker.Arco, 1)
tdrtanker:SetTACAN(55, "AR1")
tdrtanker:SetAltitude(14000)
tdrtanker:SetSpeed(UTILS.KnotsToAltKIAS(275, 14000))
tdrtanker:SetRacetrackDistances(35, -10)
tdrtanker:SetTakeoffAir()
tdrtanker:__Start(1)

local tdrrescuehelo = RESCUEHELO:New("TDR", "RescueHeloTDR")
tdrrescuehelo:SetHomeBase(AIRBASE:FindByName("Dunham"))
tdrrescuehelo:SetModex(42)
tdrrescuehelo:__Start(1)

TDR = NAVYGROUP:New("TDR")
TDR:Activate()

function case111()
  TDR:TurnIntoWindStop()
  MessageToAll("99 Rough Rider recovery opperations complete, returning to base course")
end

function case112()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 30 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  TDR:AddTurnIntoWind(timerecovery_start, timerecovery_end, 28, false, -9)
  MessageToAll("99 Rough Rider Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

function case113()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 60 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  TDR:AddTurnIntoWind(timerecovery_start, timerecovery_end, 28, false, -9)
  MessageToAll("99 Rough Rider Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

function case114()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 90 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  TDR:AddTurnIntoWind(timerecovery_start, timerecovery_end, 28, false, -9)
  MessageToAll("99 Rough Rider Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

function case115()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 120 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  TDR:AddTurnIntoWind(timerecovery_start, timerecovery_end, 28, false, -9)
  MessageToAll("99 Rough Rider Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

function case116()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 240 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  TDR:AddTurnIntoWind(timerecovery_start, timerecovery_end, 28, false, -9)
  MessageToAll("99 Rough Rider Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

function case117()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 480 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  TDR:AddTurnIntoWind(timerecovery_start, timerecovery_end, 28, false, -9)
  MessageToAll("99 Rough Rider Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- Tarawa
-----------------------------------------------------------------------------------------------------------------------------------------

-- S-3B spawning on TDR.
local tartanker = RECOVERYTANKER:New("Tarawa", "Arco3")

-- Custom settings for radio frequency, TACAN, callsign and modex.
-- tartanker:SetTakeoffAir()
tartanker:SetHomeBase(AIRBASE:FindByName("TDR"))
tartanker:SetRadio(251.300)
tartanker:SetModex(703)
tartanker:SetCallsign(CALLSIGN.Tanker.Arco, 3)
tartanker:SetTACAN(57, "AR3")
tartanker:SetAltitude(14000)
tartanker:SetSpeed(UTILS.KnotsToAltKIAS(275, 14000))
tartanker:SetRacetrackDistances(35, -10)
tartanker:SetTakeoffAir()
tartanker:__Start(1)

local tarrescuehelo = RESCUEHELO:New("Tarawa", "RescueHeloTAR")
tarrescuehelo:SetHomeBase(AIRBASE:FindByName("San Antonio"))
tarrescuehelo:SetModex(65)
tarrescuehelo:__Start(1)

Tarawa = NAVYGROUP:New("Tarawa")
Tarawa:Activate()

function case131()
  Tarawa:TurnIntoWindStop()
  MessageToAll("99 Proud Eagle recovery opperations complete, returning to base course")
end

function case132()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 30 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  Tarawa:AddTurnIntoWind(timerecovery_start, timerecovery_end, 10, false, 0)
  MessageToAll("99 Proud Eagle Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

function case133()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 60 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  Tarawa:AddTurnIntoWind(timerecovery_start, timerecovery_end, 10, false, 0)
  MessageToAll("99 Proud Eagle Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

function case134()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 90 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  Tarawa:AddTurnIntoWind(timerecovery_start, timerecovery_end, 10, false, 0)
  MessageToAll("99 Proud Eagle Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

function case135()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 120 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  Tarawa:AddTurnIntoWind(timerecovery_start, timerecovery_end, 10, false, 0)
  MessageToAll("99 Proud Eagle Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

function case136()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 240 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  Tarawa:AddTurnIntoWind(timerecovery_start, timerecovery_end, 10, false, 0)
  MessageToAll("99 Proud Eagle Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

function case137()
  local timenow = timer.getAbsTime()
  local timeend = timenow + 480 * 60
  local timerecovery_start = UTILS.SecondsToClock(timenow, false)
  timerecovery_end = UTILS.SecondsToClock(timeend, false)

  Tarawa:AddTurnIntoWind(timerecovery_start, timerecovery_end, 10, false, 0)
  MessageToAll("99 Proud Eagle Turning, at time " .. timerecovery_start .. " until " .. timerecovery_end)
end

TopMenu1 = MENU_COALITION:New(coalition.side.BLUE, "Carrier Menus")

Menu11 = MENU_COALITION:New(coalition.side.BLUE, "USS Theodore Roosevelt", TopMenu1)
Menu13 = MENU_COALITION:New(coalition.side.BLUE, "USS Tarawa", TopMenu1)

Menu111 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Stop Recovery and return to base course", Menu11, case111)
Menu112 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request TDR turn into the wind for 30 minutes", Menu11, case112)
Menu113 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request TDR turn into the wind for 60 minutes", Menu11, case113)
Menu114 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request TDR turn into the wind for 90 minutes", Menu11, case114)
Menu115 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request TDR turn into the wind for 2 hours", Menu11, case115)
Menu116 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request TDR turn into the wind for 4 hours", Menu11, case116)
Menu117 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request TDR turn into the wind for 8 hours", Menu11, case117)

Menu131 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Stop Recovery and return to base course", Menu13, case131)
Menu132 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request Tarawa turn into the wind for 30 minutes", Menu13, case132)
Menu133 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request Tarawa turn into the wind for 60 minutes", Menu13, case133)
Menu134 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request Tarawa turn into the wind for 90 minutes", Menu13, case134)
Menu135 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request Tarawa turn into the wind for 2 hours", Menu13, case135)
Menu136 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request Tarawa turn into the wind for 4 hours", Menu13, case136)
Menu137 = MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Request Tarawa turn into the wind for 8 hours", Menu13, case137)

function BeaconResetter() 
  local TDRBeacon = UNIT:FindByName('TDR'):GetBeacon()
  local TWABeacon = UNIT:FindByName('Tarawa'):GetBeacon()
  TDRBeacon:ActivateTACAN(71, 'X', 'TDR', true)
  TDRBeacon:ActivateICLS(15)
  TDRBeacon:ActivateLink4(336)
  TWABeacon:ActivateTACAN(1, 'X', 'TWA', true)
end
-- TIMER:New(BeaconResetter):Start(30, 300) -- apprently breaks courseline
MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Reset Carrier Beacons", TopMenu1, BeaconResetter)

function NotifyLiveLSO() 
  MESSAGE:New('ATTN LIVE LSO NOW ON 128.0', 30, "LSO"):ToAll()
end
MENU_COALITION_COMMAND:New(coalition.side.BLUE, "Notify Live LSO", nil, NotifyLiveLSO)

