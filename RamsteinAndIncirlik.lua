local IncirlikAW = AIRWING:New('IncirlikWH', 'IncirlikAirwing')
IncirlikAW:SetTakeoffAir()
IncirlikAW:Start()

function IncirlikAW:OnAfterFlightOnMission(From, Event, To, Flightgroup, Mission )
  local fg = Flightgroup
  fg:SetDespawnAfterHolding()
end

local IncirlikTankerSQ = SQUADRON:New('IncirlikTanker', 20, 'Incirlik-Refuelling-Squadron')
IncirlikTankerSQ:AddMissionCapability({ AUFTRAG.Type.TANKER }, 100)
IncirlikTankerSQ:SetMissionRange(500)
IncirlikTankerSQ:SetFuelLowRefuel( true )
IncirlikTankerSQ:SetFuelLowThreshold( 10 )
IncirlikTankerSQ:SetRadio( 252 )
IncirlikAW:AddSquadron(IncirlikTankerSQ)

local Texaco1 = AUFTRAG:NewTANKER(Zone.Michelob:GetCoordinate(), 15000, UTILS.KnotsToAltKIAS(250, 15000), 90, 20, 1)
Texaco1:SetTACAN(118, "TX1")
Texaco1:SetRadio(252.1)
Texaco1:SetRepeat(99)
function Texaco1:OnAfterStarted(From, Event, To)
  local og = Texaco1:GetOpsGroups()
  local g = og[1]:GetGroup()
  g:CommandSetCallsign(CALLSIGN.Tanker.Texaco, 1)
end
local Texaco2 = AUFTRAG:NewTANKER(Zone.Michelob:GetCoordinate(), 18000, UTILS.KnotsToAltKIAS(250, 18000), 90, 20, 1)
Texaco2:SetTACAN(119, "TX2")
Texaco2:SetRadio(252.2)
Texaco2:SetRepeat(99)
function Texaco2:OnAfterStarted(From, Event, To)
  local og = Texaco2:GetOpsGroups()
  local g = og[1]:GetGroup()
  g:CommandSetCallsign(CALLSIGN.Tanker.Texaco, 2)
end
local Texaco3 = AUFTRAG:NewTANKER(Zone.Michelob:GetCoordinate(), 21000, UTILS.KnotsToAltKIAS(250, 21000), 90, 20, 1)
Texaco3:SetTACAN(120, "TX3")
Texaco3:SetRadio(252.3)
Texaco3:SetRepeat(99)
function Texaco3:OnAfterStarted(From, Event, To)
  local og = Texaco3:GetOpsGroups()
  local g = og[1]:GetGroup()
  g:CommandSetCallsign(CALLSIGN.Tanker.Texaco, 3)
end

local IncirlikCompassCallSQ = SQUADRON:New('Magic-2', 20, 'Incirlik Compass Call Squadron')
IncirlikCompassCallSQ:SetMissionRange(500)
IncirlikCompassCallSQ:SetFuelLowRefuel(true)
IncirlikCompassCallSQ:SetFuelLowThreshold(15)
IncirlikAW:AddSquadron(IncirlikCompassCallSQ)

local CompassCallAuftrag = AUFTRAG:NewORBIT(Zone.SkidRow:GetCoordinate(), 29000, UTILS.KnotsToAltKIAS(250, 29000), 270, 20)
CompassCallAuftrag:AssignCohort(IncirlikCompassCallSQ)
CompassCallAuftrag:SetRepeat(99)

function CompassCallAuftrag:OnAfterStarted() 
  local og = CompassCallAuftrag:GetOpsGroups()
  local g = og[1]:GetGroup()
  g:CommandSetCallsign(CALLSIGN.AWACS.Magic, 2)
end

local IncirlikE3SQ = SQUADRON:New('Darkstar', 20, 'Incirlik AWACS Squadron')
IncirlikE3SQ:AddMissionCapability({AUFTRAG.Type.AWACS}, 100)
IncirlikE3SQ:SetMissionRange(300)
IncirlikE3SQ:SetFuelLowRefuel(true)
IncirlikE3SQ:SetFuelLowThreshold(15)
IncirlikE3SQ:SetCallsign(CALLSIGN.AWACS.Darkstar)
IncirlikE3SQ:SetRadio(264)
IncirlikAW:AddSquadron(IncirlikE3SQ)

local AWACSauftrag = AUFTRAG:NewAWACS(Zone.Watchtower:GetCoordinate(), 35000, UTILS.KnotsToAltKIAS(250, 35000), 270, 20)
AWACSauftrag:AssignCohort(IncirlikE3SQ)
AWACSauftrag:SetRepeat(99)

local RamsteinAW = AIRWING:New('RamsteinWH', 'RamsteinAirwing')
RamsteinAW:SetTakeoffAir()
RamsteinAW:Start()

function RamsteinAW:OnAfterFlightOnMission(From, Event, To, Flightgroup, Mission )
  local fg = Flightgroup
  fg:SetDespawnAfterHolding()
end


local RamsteinTankerSQ = SQUADRON:New('RamsteinTanker', 20, 'Ramstein-Refuelling-Squadron')
RamsteinTankerSQ:AddMissionCapability({ AUFTRAG.Type.TANKER }, 100)
RamsteinTankerSQ:SetMissionRange(500)
RamsteinTankerSQ:SetFuelLowRefuel( true )
RamsteinTankerSQ:SetFuelLowThreshold( 10 )
RamsteinTankerSQ:SetRadio( 252 )
RamsteinAW:AddSquadron(RamsteinTankerSQ)

local Texaco4 = AUFTRAG:NewTANKER(Zone.Coors:GetCoordinate(), 15000, UTILS.KnotsToAltKIAS(250, 15000), 90, 20, 1)
Texaco4:SetTACAN(121, "TX4")
Texaco4:SetRadio(252.4)
Texaco4:SetRepeat(99)
function Texaco4:OnAfterStarted(From, Event, To)
  local og = Texaco4:GetOpsGroups()
  local g = og[1]:GetGroup()
  g:CommandSetCallsign(CALLSIGN.Tanker.Texaco, 4)
end
local Texaco5 = AUFTRAG:NewTANKER(Zone.Coors:GetCoordinate(), 18000, UTILS.KnotsToAltKIAS(250, 18000), 90, 20, 1)
Texaco5:SetTACAN(122, "TX5")
Texaco5:SetRadio(252.5)
Texaco5:SetRepeat(99)
function Texaco5:OnAfterStarted(From, Event, To)
  local og = Texaco5:GetOpsGroups()
  local g = og[1]:GetGroup()
  g:CommandSetCallsign(CALLSIGN.Tanker.Texaco, 5)
end
local Texaco6 = AUFTRAG:NewTANKER(Zone.Coors:GetCoordinate(), 21000, UTILS.KnotsToAltKIAS(250, 21000), 90, 20, 1)
Texaco6:SetTACAN(123, "TX6")
Texaco6:SetRadio(252.6)
Texaco6:SetRepeat(99)
function Texaco6:OnAfterStarted(From, Event, To)
  local og = Texaco6:GetOpsGroups()
  local g = og[1]:GetGroup()
  g:CommandSetCallsign(CALLSIGN.Tanker.Texaco, 6)
end

local RamsteinRivetJointSQ = SQUADRON:New('Magic-1', 20, 'Ramstein Rivet Joint Squadron')
RamsteinRivetJointSQ:SetMissionRange(500)
RamsteinRivetJointSQ:SetFuelLowRefuel(true)
RamsteinRivetJointSQ:SetFuelLowThreshold(15)
RamsteinAW:AddSquadron(RamsteinRivetJointSQ)

local RivetJointAuftrag = AUFTRAG:NewORBIT(Zone.WhiteSnake:GetCoordinate(), 29000, UTILS.KnotsToAltKIAS(250, 29000), 270, 20)
RivetJointAuftrag:AssignCohort(RamsteinRivetJointSQ)
RivetJointAuftrag:SetRepeat(99)

function RivetJointAuftrag:OnAfterStarted() 
  local og = RivetJointAuftrag:GetOpsGroups()
  local g = og[1]:GetGroup()
  g:CommandSetCallsign(CALLSIGN.AWACS.Magic, 1)
end

TIMER:New(function()
  IncirlikAW:AddMission(Texaco1)
  IncirlikAW:AddMission(Texaco2)
  IncirlikAW:AddMission(Texaco3)
  IncirlikAW:AddMission(CompassCallAuftrag)
  IncirlikAW:AddMission(AWACSauftrag)

  RamsteinAW:AddMission(Texaco4)
  RamsteinAW:AddMission(Texaco5)
  RamsteinAW:AddMission(Texaco6)
  RamsteinAW:AddMission(RivetJointAuftrag)
end):Start(12)

