------------------------------
-- TANKER Ops global defaults
------------------------------

-- Fueltreshold in %, tanker will go home, e.g. 0.1 for 10%
_TankerFuelThreshold2 = 0.20
-- Timing - post which the tanker will go home in seconds when a replacement is called
_TankerTimeToGo2 = 240
-- Monitoring - how often to check in seconds
_TankerMonitor2 = 30

------------------------------
-- Support Airwings
------------------------------
    
local elintauftrag=AUFTRAG:NewORBIT(Zone.Buzzer:GetCoordinate(), 30000, UTILS.KnotsToAltKIAS(250,30000), 295, 20)
elintauftrag:SetRepeat(2)
elintauftrag:SetTime("00:30", "06:00")
elintauftrag:AssignSquadrons({VAQ132})
elintauftrag:SetRequiredAssets(1)

CVW17:AddMission(elintauftrag)

local elintauftrag=AUFTRAG:NewORBIT(Zone.Buzzer:GetCoordinate(), 30000, UTILS.KnotsToAltKIAS(250,30000), 295, 20)
elintauftrag:SetRepeat(2)
elintauftrag:SetTime("08:30", "13:00")
elintauftrag:AssignSquadrons({VAQ132})
elintauftrag:SetRequiredAssets(1)

CVW17:AddMission(elintauftrag)

local elintauftrag=AUFTRAG:NewORBIT(Zone.Buzzer:GetCoordinate(), 30000, UTILS.KnotsToAltKIAS(250,30000), 295, 20)
elintauftrag:SetRepeat(2)
elintauftrag:SetTime("14:00", "18:30")
elintauftrag:AssignSquadrons({VAQ132})
elintauftrag:SetRequiredAssets(1)

CVW17:AddMission(elintauftrag)

local elintauftrag=AUFTRAG:NewORBIT(Zone.Buzzer:GetCoordinate(), 30000, UTILS.KnotsToAltKIAS(250,30000), 295, 20)
elintauftrag:SetRepeat(2)
elintauftrag:SetTime("19:00", "23:45")
elintauftrag:AssignSquadrons({VAQ132})
elintauftrag:SetRequiredAssets(1)

CVW17:AddMission(elintauftrag)

local elintauftrag=AUFTRAG:NewORBIT(Zone.Cinderella:GetCoordinate(), 20000, UTILS.KnotsToAltKIAS(250,20000), 359, 30)
elintauftrag:SetRepeat(2)
elintauftrag:AssignSquadrons({VS30})
elintauftrag:SetRequiredAssets(1)

CVW17:AddMission(elintauftrag)

local elintauftrag=AUFTRAG:NewORBIT(Zone.Poison:GetCoordinate(), 20000, UTILS.KnotsToAltKIAS(250,20000), 120, 30)
elintauftrag:SetRepeat(2)
elintauftrag:AssignSquadrons({VS30})
elintauftrag:SetRequiredAssets(1)

CVW17:AddMission(elintauftrag) 

local auftrag=AUFTRAG:NewAWACS(Zone.Verison:GetCoordinate(), 30000, UTILS.KnotsToAltKIAS(250,30000), 310, 50)
  auftrag:SetRadio(265)
  auftrag:SetRepeat(4)
  auftrag:AssignSquadrons({VAW112DL})
  auftrag:SetRequiredAssets(1)

  function auftrag:OnAfterStarted(From,Event,To)
    
  local OpsGroups = auftrag:GetOpsGroups()
  local AuftragGroup = OpsGroups[1]:GetGroup()

        AuftragGroup:CommandSetCallsign(CALLSIGN.AWACS.Wizard,2)
end 

  CVW17:AddMission(auftrag)

local testawacs = AWACS:New("VAW112", CVW17, coalition.side.BLUE, "TDR", 'CrowsNest', 'Bulls', 'Chicago', 264.1, radio.modulation.AM)
--testawacs:SetEscort(2)
testawacs:SetAwacsDetails(CALLSIGN.AWACS.Wizard, 1, 30, 300, 290, 50)

-- if DEV_MODE then
--   -- testawacs:SetSRS("G:\\DCS-SimpleRadio-Standalone", "female", "en-US", 5002)
-- else 

-- end
if _G.DEV_MODE then
  -- env.info('DEV_MODE set')
  testawacs:SetSRS("G:\\DCS-SimpleRadio-Standalone", "female", "en-US", 5002)
  env.info('starting MOOSE.AWACS in DEV_MODE')
else
  testawacs:SetSRS("C:\\Program Files\\DCS-SimpleRadio-Standalone", "female", "en-US", 5003)
end
--testawacs:SetAICAPDetails(CALLSIGN.Aircraft.Ford, 4, 4, 300)
testawacs:SetCustomCallsigns({
    Devil = 'Bengel',
    Snake = 'Winder',
    Colt = 'Camelot',
    Enfield = 'Victory',
    Uzi = 'Evil Eye'
})
testawacs:SetModernEra()
testawacs:__Start(5)



