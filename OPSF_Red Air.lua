local rus_MAX_SIMULTANEOUS_INTERCEPTS = 3
-- local rus_MAX_SIMULTANEOUS_CAS = 2

local AWACSCapability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.AWACS }
local TankerCapability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.TANKER }
local Su27Capability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.GCICAP, AUFTRAG.Type.CAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.ESCORT }
local Su33Capability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.GCICAP, AUFTRAG.Type.CAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.ESCORT }
local Su30Capability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.GCICAP, AUFTRAG.Type.CAP, AUFTRAG.Type.INTERCEPT, AUFTRAG.Type.ESCORT }
local MiG31Capability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.GCICAP, AUFTRAG.Type.CAP, AUFTRAG.Type.INTERCEPT }
local MiG29Capability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.GCICAP, AUFTRAG.Type.CAP, AUFTRAG.Type.INTERCEPT }
local Su24Capability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.BOMBCARPET, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY, AUFTRAG.Type.STRIKE, AUFTRAG.Type.ANTISHIP, AUFTRAG.Type.SEAD }
local Su34Capability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.BOMBCARPET, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY, AUFTRAG.Type.STRIKE, AUFTRAG.Type.ANTISHIP, AUFTRAG.Type.SEAD }
local Su25Capability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.SEAD, AUFTRAG.Type.CAS, AUFTRAG.Type.CASENHANCED, AUFTRAG.Type.PATROLZONE }
local Mi24Capability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.BAI, AUFTRAG.Type.CAS, AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.AMMOSUPPLY, AUFTRAG.Type.FUELSUPPLY, AUFTRAG.Type.TROOPTRANSPORT, AUFTRAG.Type.RESCUEHELO, AUFTRAG.Type.RECON, AUFTRAG.Type.FACA }
local Mi28Capability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.BAI, AUFTRAG.Type.CAS, AUFTRAG.Type.PATROLZONE,  AUFTRAG.Type.RECON, AUFTRAG.Type.FACA }
local Ka50Capability = { AUFTRAG.Type.ALERT5, AUFTRAG.Type.BAI, AUFTRAG.Type.CAS, AUFTRAG.Type.PATROLZONE, AUFTRAG.Type.RECON, AUFTRAG.Type.FACA }

local rus_EW = SET_GROUP:New():FilterPrefixes( { 'rEWR', 'rAWACS', 'rRECCE' } ):FilterStart() -- :FilterOnce() -- :FilterStart()
local rusChief = CHIEF:New( coalition.side.RED, rus_EW, 'Colonel Sokalov' )
rusChief:SetClusterAnalysis(false) -- buggy as-is and much more complicated to use OnAfterNewCluster, particularly cleaning up in OnAfterLostContact (membership of clusters changes even when individual contacts' detection states do not)
local rus = {}  

rus.AWACSAnchors = SET_ZONE:New():FilterPrefixes( 'rus_AWACS_TRACK' ):FilterOnce()
rus.TankerAnchors = SET_ZONE:New():FilterPrefixes( 'rus_TANKER_TRACK' ):FilterOnce()
rus.CAPAnchors = SET_ZONE:New():FilterPrefixes( 'rus_CAP_TRACK' ):FilterOnce()
rus.QRFZones = SET_ZONE:New():FilterPrefixes( 'rus_QRF_ZONE' ):FilterOnce()

rus.Airwings = {}
rus.Squadrons = {}
-- Mozdok
local WH = STATIC:FindByName('rus_WH-1', false)
if WH then
  rus.Airwings.Mozdok = AIRWING:New( 'rus_WH-1', '1st Airwing' )
  rus.Squadrons.Mozdok = {}
  rus.Airwings.Mozdok:NewPayload( 'T_rus_AWACS', -1, AWACSCapability, 100 )
  rus.Airwings.Mozdok:NewPayload( 'T_rus_TANKER', -1, TankerCapability, 100 )
  rus.Airwings.Mozdok:NewPayload( 'P_rus_Su27', -1, Su27Capability, 100 )
  rus.Airwings.Mozdok:NewPayload( 'P_rus_MiG31', -1, MiG31Capability, 100 )
  rus.Airwings.Mozdok:NewPayload( 'P_rus_MiG29', -1, MiG29Capability, 100 )
  rus.Airwings.Mozdok:NewPayload('P_rus_Su24', -1, Su24Capability, 100)
  rus.Airwings.Mozdok:NewPayload( 'P_rus_Su25T', -1, Su25Capability, 100 )

  rus.Squadrons.Mozdok.C2C = SQUADRON:New( 'T_rus_AWACS', 20, '1st Elint SQ' )
  rus.Squadrons.Mozdok.C2C:AddMissionCapability( AWACSCapability, 100 )
  rus.Squadrons.Mozdok.C2C:SetMissionRange( 500 )
  rus.Squadrons.Mozdok.C2C:SetFuelLowRefuel( true )
  rus.Squadrons.Mozdok.C2C:SetTurnoverTime( 60, 720 )
  rus.Squadrons.Mozdok.C2C:SetRadio( 264 )
  rus.Squadrons.Mozdok.C2C:SetCallsign( CALLSIGN.AWACS.Overlord )
  rus.Airwings.Mozdok:AddSquadron( rus.Squadrons.Mozdok.C2C )

  rus.Squadrons.Mozdok.Tanker = SQUADRON:New( 'T_rus_TANKER', 20, '2nd Tanker SQ' )
  rus.Squadrons.Mozdok.Tanker:AddMissionCapability( TankerCapability, 100 )
  rus.Squadrons.Mozdok.Tanker:SetMissionRange( 500 )
  rus.Squadrons.Mozdok.Tanker:SetTurnoverTime( 60, 720 )
  rus.Squadrons.Mozdok.Tanker:SetRadio( 252 )
  rus.Squadrons.Mozdok.Tanker:SetCallsign( CALLSIGN.Tanker.Shell )
  rus.Airwings.Mozdok:AddSquadron( rus.Squadrons.Mozdok.Tanker )

  rus.Squadrons.Mozdok.Su27 = SQUADRON:New( 'T_rus_Su27', 20, '4th Fighter SQ' )
  rus.Squadrons.Mozdok.Su27:AddMissionCapability( Su27Capability, 100 )
  rus.Squadrons.Mozdok.Su27:SetMissionRange( 250 )
  rus.Squadrons.Mozdok.Su27:SetFuelLowRefuel( true )
  rus.Squadrons.Mozdok.Su27:SetRadio( 270 )
  rus.Squadrons.Mozdok.Su27:SetCallsign( CALLSIGN.Aircraft.Springfield )
  rus.Airwings.Mozdok:AddSquadron( rus.Squadrons.Mozdok.Su27 )

  rus.Squadrons.Mozdok.MiG31 = SQUADRON:New( 'T_rus_MiG31', 20, '5th Fighter SQ' )
  rus.Squadrons.Mozdok.MiG31:AddMissionCapability( MiG31Capability, 100 )
  rus.Squadrons.Mozdok.MiG31:SetMissionRange( 350 )
  rus.Squadrons.Mozdok.MiG31:SetFuelLowRefuel( true )
  rus.Squadrons.Mozdok.MiG31:SetRadio( 270 )
  rus.Squadrons.Mozdok.MiG31:SetCallsign( CALLSIGN.Aircraft.Springfield )
  rus.Airwings.Mozdok:AddSquadron( rus.Squadrons.Mozdok.MiG31 )

  rus.Squadrons.Mozdok.MiG29 = SQUADRON:New( 'T_rus_MiG29', 20, '6th Fighter SQ' )
  rus.Squadrons.Mozdok.MiG29:AddMissionCapability( MiG29Capability, 100 )
  rus.Squadrons.Mozdok.MiG29:SetMissionRange( 100 )
  rus.Squadrons.Mozdok.MiG29:SetRadio( 270 )
  rus.Squadrons.Mozdok.MiG29:SetCallsign( CALLSIGN.Aircraft.Springfield )
  rus.Airwings.Mozdok:AddSquadron( rus.Squadrons.Mozdok.MiG29 )

  rus.Squadrons.Mozdok.Su25T = SQUADRON:New( 'T_rus_Su25T', 20, '7th Fighter SQ' )
  rus.Squadrons.Mozdok.Su25T:AddMissionCapability( Su25Capability, 100 )
  rus.Squadrons.Mozdok.Su25T:SetMissionRange( 150 )
  rus.Squadrons.Mozdok.Su25T:SetRadio( 270 )
  rus.Squadrons.Mozdok.Su25T:SetCallsign( CALLSIGN.Aircraft.Springfield )
  rus.Squadrons.Mozdok.Su25T:SetFuelLowThreshold( 15 )
  rus.Airwings.Mozdok:AddSquadron( rus.Squadrons.Mozdok.Su25T )
end
-- Maykop
local WH = STATIC:FindByName('rus_WH-2', false)
if WH then
  rus.Airwings.Maycop = AIRWING:New( 'rus_WH-2', '2nd Airwing' )
  rus.Squadrons.Maycop = {}
  rus.Airwings.Maycop:NewPayload( 'P_rus_Su27', -1, Su27Capability, 100 )
  rus.Airwings.Maycop:NewPayload( 'P_rus_Su30', -1, Su30Capability, 100 )
  rus.Airwings.Maycop:NewPayload( 'P_rus_MiG31', -1, MiG31Capability, 100 )
  rus.Airwings.Maycop:NewPayload( 'P_rus_MiG29', -1, MiG29Capability, 100 )

  rus.Squadrons.Maycop.Su27 = SQUADRON:New( 'T_rus_Su27', 20, '8th Fighter SQ' )
  rus.Squadrons.Maycop.Su27:AddMissionCapability( Su27Capability, 100 )
  rus.Squadrons.Maycop.Su27:SetMissionRange( 250 )
  rus.Squadrons.Maycop.Su27:SetFuelLowRefuel( true )
  rus.Airwings.Maycop:AddSquadron( rus.Squadrons.Maycop.Su27 )
  
  rus.Squadrons.Maycop.MiG29 = SQUADRON:New( 'T_rus_MiG29', 20, '9th Fighter SQ' )
  rus.Squadrons.Maycop.MiG29:AddMissionCapability( MiG29Capability, 100 )
  rus.Squadrons.Maycop.MiG29:SetMissionRange( 250 )
  rus.Squadrons.Maycop.MiG29:SetFuelLowRefuel( true )
  rus.Airwings.Maycop:AddSquadron( rus.Squadrons.Maycop.MiG29 )
  
  rus.Squadrons.Maycop.MiG31 = SQUADRON:New( 'T_rus_MiG31', 20, '10th Fighter SQ' )
  rus.Squadrons.Maycop.MiG31:AddMissionCapability( MiG31Capability, 100 )
  rus.Squadrons.Maycop.MiG31:SetMissionRange( 250 )
  rus.Squadrons.Maycop.MiG31:SetFuelLowRefuel( true )
  rus.Airwings.Maycop:AddSquadron( rus.Squadrons.Maycop.MiG31 )
  
  rus.Squadrons.Maycop.Su30 = SQUADRON:New( 'T_rus_Su30', 20, '11th Fighter SQ' )
  rus.Squadrons.Maycop.Su30:AddMissionCapability( Su30Capability, 100 )
  rus.Squadrons.Maycop.Su30:SetMissionRange( 250 )
  rus.Squadrons.Maycop.Su30:SetFuelLowRefuel( true )
  rus.Airwings.Maycop:AddSquadron( rus.Squadrons.Maycop.Su30 )

end
-- Vaziani
local WH = STATIC:FindByName('rus_WH-3', false)
if WH then
  rus.Airwings.Vaziani = AIRWING:New( 'rus_WH-3', '3rd Airwing' )
  rus.Squadrons.Vaziani = {}
  rus.Airwings.Vaziani:NewPayload( 'P_rus_Su27', -1, Su27Capability, 100 )
  rus.Airwings.Vaziani:NewPayload( 'P_rus_Su30', -1, Su30Capability, 100 )
  rus.Airwings.Vaziani:NewPayload( 'P_rus_MiG31', -1, MiG31Capability, 100 )
  rus.Airwings.Vaziani:NewPayload( 'P_rus_MiG29', -1, MiG29Capability, 100 )

  rus.Squadrons.Vaziani.Su27 = SQUADRON:New( 'T_rus_Su27', 20, '12th Fighter SQ' )
  rus.Squadrons.Vaziani.Su27:AddMissionCapability( Su27Capability, 100 )
  rus.Squadrons.Vaziani.Su27:SetMissionRange( 250 )
  rus.Squadrons.Vaziani.Su27:SetFuelLowRefuel( true )
  rus.Airwings.Vaziani:AddSquadron( rus.Squadrons.Vaziani.Su27 )
  
  rus.Squadrons.Vaziani.MiG29 = SQUADRON:New( 'T_rus_MiG29', 20, '13th Fighter SQ' )
  rus.Squadrons.Vaziani.MiG29:AddMissionCapability( MiG29Capability, 100 )
  rus.Squadrons.Vaziani.MiG29:SetMissionRange( 250 )
  rus.Squadrons.Vaziani.MiG29:SetFuelLowRefuel( true )
  rus.Airwings.Vaziani:AddSquadron( rus.Squadrons.Vaziani.MiG29 )
  
  rus.Squadrons.Vaziani.MiG31 = SQUADRON:New( 'T_rus_MiG31', 20, '14th Fighter SQ' )
  rus.Squadrons.Vaziani.MiG31:AddMissionCapability( MiG31Capability, 100 )
  rus.Squadrons.Vaziani.MiG31:SetMissionRange( 250 )
  rus.Squadrons.Vaziani.MiG31:SetFuelLowRefuel( true )
  rus.Airwings.Vaziani:AddSquadron( rus.Squadrons.Vaziani.MiG31 )
  
  rus.Squadrons.Vaziani.Su30 = SQUADRON:New( 'T_rus_Su30', 20, '15th Fighter SQ' )
  rus.Squadrons.Vaziani.Su30:AddMissionCapability( Su30Capability, 50 )
  rus.Squadrons.Vaziani.Su30:SetMissionRange( 250 )
  rus.Squadrons.Vaziani.Su30:SetFuelLowRefuel( true )
  rus.Airwings.Vaziani:AddSquadron( rus.Squadrons.Vaziani.Su30 )

end
-- Anapa
local WH = STATIC:FindByName('rus_WH-4', false)
if WH then
  rus.Airwings.Anapa = AIRWING:New( 'rus_WH-4', '4th Airwing' )
  rus.Squadrons.Anapa = {}
  rus.Airwings.Anapa:NewPayload( 'P_rus_Su33', -1, Su33Capability, 100 )
  rus.Airwings.Anapa:NewPayload( 'P_rus_Su30', -1, Su30Capability, 100 )
  rus.Airwings.Anapa:NewPayload( 'P_rus_MiG31', -1, MiG31Capability, 100 )
  rus.Airwings.Anapa:NewPayload( 'P_rus_MiG29', -1, MiG29Capability, 100 )

  rus.Squadrons.Anapa.Su33 = SQUADRON:New( 'T_rus_Su33', 20, '16th Fighter SQ' )
  rus.Squadrons.Anapa.Su33:AddMissionCapability( Su33Capability, 100 )
  rus.Squadrons.Anapa.Su33:SetMissionRange( 300 )
  rus.Squadrons.Anapa.Su33:SetFuelLowRefuel( true )
  rus.Airwings.Anapa:AddSquadron( rus.Squadrons.Anapa.Su33 )
  
  rus.Squadrons.Anapa.MiG29 = SQUADRON:New( 'T_rus_MiG29', 20, '17th Fighter SQ' )
  rus.Squadrons.Anapa.MiG29:AddMissionCapability( MiG29Capability, 100 )
  rus.Squadrons.Anapa.MiG29:SetMissionRange( 300 )
  rus.Squadrons.Anapa.MiG29:SetFuelLowRefuel( true )
  rus.Airwings.Anapa:AddSquadron( rus.Squadrons.Anapa.MiG29 )
  
  rus.Squadrons.Anapa.MiG31 = SQUADRON:New( 'T_rus_MiG31', 20, '18th Fighter SQ' )
  rus.Squadrons.Anapa.MiG31:AddMissionCapability( MiG31Capability, 99 )
  rus.Squadrons.Anapa.MiG31:SetMissionRange( 300 )
  rus.Squadrons.Anapa.MiG31:SetFuelLowRefuel( true )
  rus.Airwings.Anapa:AddSquadron( rus.Squadrons.Anapa.MiG31 )
  
  rus.Squadrons.Anapa.Su30 = SQUADRON:New( 'T_rus_Su30', 20, '19th Fighter SQ' )
  rus.Squadrons.Anapa.Su30:AddMissionCapability( Su30Capability, 99 )
  rus.Squadrons.Anapa.Su30:SetMissionRange( 300 )
  rus.Squadrons.Anapa.Su30:SetFuelLowRefuel( true )
  rus.Airwings.Anapa:AddSquadron( rus.Squadrons.Anapa.Su30 )
end
-- Batumi
local WH = STATIC:FindByName('rus_WH-6', false)
if WH then
  rus.Airwings.Batumi = AIRWING:New( 'rus_WH-6', '6th Airwing' )
  rus.Squadrons.Batumi = {}
  rus.Airwings.Batumi:NewPayload( 'T_rus_Ka50', -1, Ka50Capability, 100 )
  rus.Airwings.Batumi:NewPayload( 'T_rus_Mi28', -1, Mi28Capability, 100 )
  rus.Airwings.Batumi:NewPayload( 'T_rus_Mi24', -1, Mi24Capability, 100 )

  rus.Squadrons.Batumi.Ka50 = SQUADRON:New( 'T_rus_Ka50', 20, '1st Attack SQ' )
  rus.Squadrons.Batumi.Ka50:AddMissionCapability( Ka50Capability, 100 )
  rus.Squadrons.Batumi.Ka50:SetMissionRange( 50 )
  rus.Squadrons.Batumi.Ka50:SetFuelLowRefuel( true )
  rus.Airwings.Batumi:AddSquadron( rus.Squadrons.Batumi.Ka50 )
  
  rus.Squadrons.Batumi.Mi28 = SQUADRON:New( 'T_rus_Mi28', 20, '2nd Attack SQ' )
  rus.Squadrons.Batumi.Mi28:AddMissionCapability( Mi28Capability, 100 )
  rus.Squadrons.Batumi.Mi28:SetMissionRange( 50 )
  rus.Squadrons.Batumi.Mi28:SetFuelLowRefuel( true )
  rus.Airwings.Batumi:AddSquadron( rus.Squadrons.Batumi.Mi28 )
  
  rus.Squadrons.Batumi.Mi24 = SQUADRON:New( 'T_rus_Mi24', 20, '3rd Attack SQ' )
  rus.Squadrons.Batumi.Mi24:AddMissionCapability( Mi24Capability, 100 )
  rus.Squadrons.Batumi.Mi24:SetMissionRange( 50 )
  rus.Squadrons.Batumi.Mi24:SetFuelLowRefuel( true )
  rus.Airwings.Batumi:AddSquadron( rus.Squadrons.Batumi.Mi24 )

end
-- Senaki
local WH = STATIC:FindByName('rus_WH-8', false)
if WH then
  rus.Airwings.Senaki = AIRWING:New( 'rus_WH-8', '8th Airwing' )
  rus.Squadrons.Senaki = {}
  rus.Airwings.Senaki:NewPayload( 'P_rus_MiG29', -1, MiG29Capability, 100 )

  rus.Squadrons.Senaki.MiG29 = SQUADRON:New( 'T_rus_MiG29', 20, '21st Fighter SQ' )
  rus.Squadrons.Senaki.MiG29:AddMissionCapability( MiG29Capability, 100 )
  rus.Squadrons.Senaki.MiG29:SetMissionRange( 150 )
  rus.Squadrons.Senaki.MiG29:SetFuelLowRefuel( true )
  rus.Airwings.Senaki:AddSquadron( rus.Squadrons.Senaki.MiG29 )
end
-- Gudata
local WH = STATIC:FindByName('rus_WH-10', false)
if WH then
  rus.Airwings.Gudata = AIRWING:New( 'rus_WH-10', '10th Airwing' )
  rus.Squadrons.Gudata = {}
  rus.Airwings.Gudata:NewPayload( 'P_rus_Su25T', -1, Su25Capability, 100 )

  rus.Squadrons.Gudata.Su25T = SQUADRON:New( 'T_rus_Su25T', 20, '23rd Fighter SQ' )
  rus.Squadrons.Gudata.Su25T:AddMissionCapability( Su25Capability, 100 )
  rus.Squadrons.Gudata.Su25T:SetMissionRange( 150 )
  rus.Squadrons.Gudata.Su25T:SetRadio( 270 )
  rus.Squadrons.Gudata.Su25T:SetFuelLowThreshold( 15 )
  rus.Airwings.Gudata:AddSquadron( rus.Squadrons.Gudata.Su25T )
  

end
-- Novorossiysk
local WH = STATIC:FindByName('rus_WH-13', false)
if WH then
  rus.Airwings.Novorossiysk = AIRWING:New( 'rus_WH-13', '13th Airwing' )
  rus.Squadrons.Novorossiysk = {}
  rus.Airwings.Novorossiysk:NewPayload( 'P_rus_Su25T', -1, Su25Capability, 100 )

  rus.Squadrons.Novorossiysk.Su25T = SQUADRON:New( 'T_rus_Su25T', 20, '24th Fighter SQ' )
  rus.Squadrons.Novorossiysk.Su25T:AddMissionCapability( Su25Capability, 100 )
  rus.Squadrons.Novorossiysk.Su25T:SetMissionRange( 150 )
  rus.Squadrons.Novorossiysk.Su25T:SetRadio( 270 )
  rus.Squadrons.Novorossiysk.Su25T:SetFuelLowThreshold( 15 )
  rus.Airwings.Novorossiysk:AddSquadron( rus.Squadrons.Novorossiysk.Su25T )
  

end
-- Krymsk
local WH = STATIC:FindByName('rus_WH-14', false)
if WH then
  rus.Airwings.Krymsk = AIRWING:New( 'rus_WH-14', '14th Airwing' )
  rus.Squadrons.Krymsk = {}
  rus.Airwings.Krymsk:NewPayload( 'P_rus_Su30', -1, Su30Capability, 100 )
  rus.Airwings.Krymsk:NewPayload( 'P_rus_MiG29-1', -1, MiG29Capability, 100 )

  rus.Squadrons.Krymsk.Su30 = SQUADRON:New( 'T_rus_Su30', 20, '25th Fighter SQ' )
  rus.Squadrons.Krymsk.Su30:AddMissionCapability( Su30Capability, math.random(98, 100) )
  rus.Squadrons.Krymsk.Su30:SetMissionRange( 250 )
  rus.Squadrons.Krymsk.Su30:SetFuelLowRefuel( true )
  rus.Airwings.Krymsk:AddSquadron( rus.Squadrons.Krymsk.Su30 )
  
  rus.Squadrons.Krymsk.MiG29 = SQUADRON:New( 'T_rus_MiG29', 20, '17th Fighter SQ' )
  rus.Squadrons.Krymsk.MiG29:AddMissionCapability( MiG29Capability, math.random(98, 100) )
  rus.Squadrons.Krymsk.MiG29:SetMissionRange( 300 )
  rus.Squadrons.Krymsk.MiG29:SetFuelLowRefuel( true )
  rus.Airwings.Krymsk:AddSquadron( rus.Squadrons.Krymsk.MiG29 )

end
-- Krasnodar
local WH = STATIC:FindByName('rus_WH-15', false)
if WH then
  rus.Airwings.Krasnodar = AIRWING:New( 'rus_WH-15', '15th Airwing' )
  rus.Squadrons.Krasnodar = {}
  rus.Airwings.Krasnodar:NewPayload( 'P_rus_Su30', -1, Su30Capability, 100 )
  rus.Airwings.Krasnodar:NewPayload( 'P_rus_MiG31', -1, MiG31Capability, 100 )
  rus.Airwings.Krasnodar:NewPayload( 'P_rus_MiG29', -1, MiG29Capability, 100 )
  
  rus.Squadrons.Krasnodar.MiG29 = SQUADRON:New( 'T_rus_MiG29', 20, '26th Fighter SQ' )
  rus.Squadrons.Krasnodar.MiG29:AddMissionCapability( MiG29Capability, 100 )
  rus.Squadrons.Krasnodar.MiG29:SetMissionRange( 150 )
  rus.Squadrons.Krasnodar.MiG29:SetFuelLowRefuel( true )
  rus.Airwings.Krasnodar:AddSquadron( rus.Squadrons.Krasnodar.MiG29 )
  
  rus.Squadrons.Krasnodar.MiG31 = SQUADRON:New( 'T_rus_MiG31', 20, '27th Fighter SQ' )
  rus.Squadrons.Krasnodar.MiG31:AddMissionCapability( MiG31Capability, 75 )
  rus.Squadrons.Krasnodar.MiG31:SetMissionRange( 300 )
  rus.Squadrons.Krasnodar.MiG31:SetFuelLowRefuel( true )
  rus.Airwings.Krasnodar:AddSquadron( rus.Squadrons.Krasnodar.MiG31 )
  
  rus.Squadrons.Krasnodar.Su30 = SQUADRON:New( 'T_rus_Su30', 20, '28th Fighter SQ' )
  rus.Squadrons.Krasnodar.Su30:AddMissionCapability( Su30Capability, 50 )
  rus.Squadrons.Krasnodar.Su30:SetMissionRange( 300 )
  rus.Squadrons.Krasnodar.Su30:SetFuelLowRefuel( true )
  rus.Airwings.Krasnodar:AddSquadron( rus.Squadrons.Krasnodar.Su30 )

end
-- Beslan
local WH = STATIC:FindByName('rus_WH-17', false)
if WH then
  rus.Airwings.Beslan = AIRWING:New( 'rus_WH-17', '17th Airwing' )
  rus.Squadrons.Beslan = {}
  rus.Airwings.Beslan:NewPayload( 'T_rus_Ka50', -1, Ka50Capability, 100 )
  rus.Airwings.Beslan:NewPayload( 'T_rus_Mi28', -1, Mi28Capability, 100 )
  rus.Airwings.Beslan:NewPayload( 'T_rus_Mi24', -1, Mi24Capability, 100 )

  rus.Squadrons.Beslan.Ka50 = SQUADRON:New( 'T_rus_Ka50', 20, '10th Attack SQ' )
  rus.Squadrons.Beslan.Ka50:AddMissionCapability( Ka50Capability, 100 )
  rus.Squadrons.Beslan.Ka50:SetMissionRange( 50 )
  rus.Squadrons.Beslan.Ka50:SetFuelLowRefuel( true )
  rus.Airwings.Beslan:AddSquadron( rus.Squadrons.Beslan.Ka50 )
  
  rus.Squadrons.Beslan.Mi28 = SQUADRON:New( 'T_rus_Mi28', 20, '11th Attack SQ' )
  rus.Squadrons.Beslan.Mi28:AddMissionCapability( Mi28Capability, 100 )
  rus.Squadrons.Beslan.Mi28:SetMissionRange( 50 )
  rus.Squadrons.Beslan.Mi28:SetFuelLowRefuel( true )
  rus.Airwings.Beslan:AddSquadron( rus.Squadrons.Beslan.Mi28 )
  
  rus.Squadrons.Beslan.Mi24 = SQUADRON:New( 'T_rus_Mi24', 20, '12th Attack SQ' )
  rus.Squadrons.Beslan.Mi24:AddMissionCapability( Mi24Capability, 100 )
  rus.Squadrons.Beslan.Mi24:SetMissionRange( 50 )
  rus.Squadrons.Beslan.Mi24:SetFuelLowRefuel( true )
  rus.Airwings.Beslan:AddSquadron( rus.Squadrons.Beslan.Mi24 )

end
-- Nalchik
local WH = STATIC:FindByName('rus_WH-18', false)
if WH then
  rus.Airwings.Nalchik = AIRWING:New( 'rus_WH-18', '18th Airwing' )
  rus.Squadrons.Nalchik = {}
  rus.Airwings.Nalchik:NewPayload( 'P_rus_Su25T', -1, Su25Capability, 100 )

  rus.Squadrons.Nalchik.Su25T = SQUADRON:New( 'T_rus_Su25T', 20, '31st Fighter SQ' )
  rus.Squadrons.Nalchik.Su25T:AddMissionCapability( Su25Capability, 100 )
  rus.Squadrons.Nalchik.Su25T:SetMissionRange( 150 )
  rus.Squadrons.Nalchik.Su25T:SetRadio( 270 )
  rus.Squadrons.Nalchik.Su25T:SetFuelLowThreshold( 15 )
  rus.Airwings.Nalchik:AddSquadron( rus.Squadrons.Nalchik.Su25T )
end
-- Mineralnye
local WH = STATIC:FindByName('rus_WH-19', false)
if WH then
  rus.Airwings.Mineralnye = AIRWING:New( 'rus_WH-19', '19th Airwing' )
  rus.Squadrons.Mineralnye = {}
  rus.Airwings.Mineralnye:NewPayload( 'P_rus_Su34', -1, Su34Capability, 100 )
  rus.Airwings.Mineralnye:NewPayload( 'P_rus_MiG31', -1, MiG31Capability, 100 )
  rus.Airwings.Mineralnye:NewPayload( 'P_rus_Su27', -1, Su27Capability, 100 )

  rus.Squadrons.Mineralnye.Su34 = SQUADRON:New( 'T_rus_Su34', 20, '32nd Fighter SQ' )
  rus.Squadrons.Mineralnye.Su34:AddMissionCapability( Su34Capability, 100 )
  rus.Squadrons.Mineralnye.Su34:SetMissionRange( 300 )
  rus.Squadrons.Mineralnye.Su34:SetFuelLowRefuel( true )
  rus.Airwings.Mineralnye:AddSquadron( rus.Squadrons.Mineralnye.Su34 )
  
  rus.Squadrons.Mineralnye.MiG31 = SQUADRON:New( 'T_rus_MiG31', 20, '23rd Fighter SQ' )
  rus.Squadrons.Mineralnye.MiG31:AddMissionCapability( MiG31Capability, 100 )
  rus.Squadrons.Mineralnye.MiG31:SetMissionRange( 300 )
  rus.Squadrons.Mineralnye.MiG31:SetFuelLowRefuel( true )
  rus.Airwings.Mineralnye:AddSquadron( rus.Squadrons.Mineralnye.MiG31 )
  
   rus.Squadrons.Mineralnye.Su27 = SQUADRON:New( 'T_rus_Su27', 20, '24th Fighter SQ' )
  rus.Squadrons.Mineralnye.Su27:AddMissionCapability( Su33Capability, 100 )
  rus.Squadrons.Mineralnye.Su27:SetMissionRange( 250 )
  rus.Squadrons.Mineralnye.Su27:SetFuelLowRefuel( true )
  rus.Airwings.Mineralnye:AddSquadron( rus.Squadrons.Mineralnye.Su27 )
end
-- Sochi
local WH = STATIC:FindByName('rus_WH-16', false)
if WH then
  rus.Airwings.Sochi = AIRWING:New( 'rus_WH-16', '16th Airwing' )
  rus.Squadrons.Sochi = {}
  rus.Airwings.Sochi:NewPayload( 'P_rus_Su30', -1, Su30Capability, 100 )
  rus.Airwings.Sochi:NewPayload( 'P_rus_MiG31', -1, MiG31Capability, 100 )
  rus.Airwings.Sochi:NewPayload( 'P_rus_Su27', -1, Su27Capability, 100 )
  rus.Airwings.Sochi:NewPayload( 'P_rus_MiG29', -1, Su27Capability, 100 )

  rus.Squadrons.Sochi.Su30 = SQUADRON:New( 'T_rus_Su30', 20, '60th Fighter SQ' )
  rus.Squadrons.Sochi.Su30:AddMissionCapability( Su30Capability, 99 )
  rus.Squadrons.Sochi.Su30:SetMissionRange( 300 )
  rus.Squadrons.Sochi.Su30:SetFuelLowRefuel( true )
  rus.Airwings.Sochi:AddSquadron( rus.Squadrons.Sochi.Su30 )
  
  rus.Squadrons.Sochi.MiG31 = SQUADRON:New( 'T_rus_MiG31', 20, '61st Fighter SQ' )
  rus.Squadrons.Sochi.MiG31:AddMissionCapability( MiG31Capability, 100 )
  rus.Squadrons.Sochi.MiG31:SetMissionRange( 300 )
  rus.Squadrons.Sochi.MiG31:SetFuelLowRefuel( true )
  rus.Airwings.Sochi:AddSquadron( rus.Squadrons.Sochi.MiG31 )
  
  rus.Squadrons.Sochi.Su27 = SQUADRON:New( 'T_rus_Su27', math.random(95, 100), '62nd Fighter SQ' )
  rus.Squadrons.Sochi.Su27:AddMissionCapability( Su33Capability, 100 )
  rus.Squadrons.Sochi.Su27:SetMissionRange( 250 )
  rus.Squadrons.Sochi.Su27:SetFuelLowRefuel( true )
  rus.Airwings.Sochi:AddSquadron( rus.Squadrons.Sochi.Su27 )

  rus.Squadrons.Sochi.MiG29 = SQUADRON:New( 'T_rus_MiG29', 20, '63rd Fighter SQ' )
  rus.Squadrons.Sochi.MiG29:AddMissionCapability( MiG29Capability, 100 )
  rus.Squadrons.Sochi.MiG29:SetMissionRange( 250 )
  rus.Squadrons.Sochi.MiG29:SetFuelLowRefuel( true )
  rus.Airwings.Sochi:AddSquadron( rus.Squadrons.Sochi.MiG29 )
end

for _, A in pairs( rus.Airwings ) do
  function A:OnAfterFlightOnMission( From, Event, To, Flightgroup, Mission )
    local flightgroup = Flightgroup
    local mission = Mission
  
    local escortAWACS1
    -- local escortAWACS2
    if mission:GetType() == AUFTRAG.Type.AWACS then
      local Escortee = flightgroup:GetGroup()
      escortAWACS1 = AUFTRAG:NewESCORT( Escortee, POINT_VEC3:New( -100, 0, 200 ), 60, nil )
      escortAWACS1:SetMissionRange( 250 )
      escortAWACS1:SetEngageDetected(50)
      escortAWACS1:SetRequiredAssets( 1 )
      escortAWACS1:SetRepeat(1)
      function escortAWACS1:OnBeforeRepeat()
        env.info('Repeating AWACS Escort')
      end
      rusChief:AddMission( escortAWACS1 )
    end

    if mission:GetType() == AUFTRAG.Type.ESCORT then
      env.info('Escort dispatched')
      mission:SetEngageDetected(50)
      function mission:OnAfterDone() 
        env.info('ESCORT done')
      end
    end

    flightgroup:GetGroup():CommandEPLRS( true, 5 )
    flightgroup:GetGroup():OptionROTEvadeFire()
    flightgroup:SetDespawnAfterLanding()

    function flightgroup:OnAfterFuelLow(From, Event, To) 
      env.info('TODO route to homebase fuel low. Refuel?: '..tostring(flightgroup.fuellowrefuel)) 
    end
    function flightgroup:OnAfterHolding( From, Event, To ) 
      self:ClearToLand( 5 ) 
      if mission:GetType() == AUFTRAG.Type.AWACS then
        escortAWACS1:Cancel()
        -- escortAWACS2:Cancel()
      end
    end
  end
  rusChief:AddAirwing( A )
end
rusChief:Start()

-- setup 24/7 CAP, AWACS, Tankers

rus.AWACSAnchors:ForEachZone(function (ep) 
  env.info('creating AWACS mission for ' .. ep:GetName())
  local dir, leg, alt = string.match( ep:GetName(), "rus_AWACS_TRACK%-?%d?_?(%w*)_?(%w*)_?(%w*)$" )
  if dir == '' then dir = 0 else dir = tonumber(dir) end
  if leg == '' then leg = 20 else leg = tonumber(leg) end
  if alt == '' then alt = 1000 * math.random( 26, 32 ) else alt = tonumber(alt) end
  local mission = AUFTRAG:NewAWACS(ep:GetCoordinate(), alt, 275, dir, leg)
  mission:SetRepeat(99)
  -- mission:SetRequiredEscorts(1)
  rusChief:AddMission(mission)
end)

rus.TankerAnchors:ForEachZone(function (tp) 
  env.info('creating TANKER mission for ' .. tp:GetName())
  local dir, leg, alt = string.match( tp:GetName(), "rus_TANKER_TRACK%-?%d?_?(%w*)_?(%w*)_?(%w*)$" )
  if dir == '' then dir = 0 else dir = tonumber(dir) end
  if leg == '' then leg = 20 else leg = tonumber(leg) end
  if alt == '' then alt = 1000 * math.random( 26, 32 ) else alt = tonumber(alt) end

  local mission = AUFTRAG:NewTANKER(tp:GetCoordinate(), alt, 275, dir, leg, 1)
  mission:SetRepeat(99)
  rusChief:AddMission(mission)
end)

SCHEDULER:New(nil, function () 
  rus.CAPAnchors:ForEachZone( function( cap )
    env.info( 'creating cap mission for zone: ' .. cap:GetName() )
    -- cancel the current mission
    if cap.capmish then 
      cap.capmish:SetRepeat(0)
      cap.capmish:Cancel() 
    end 

    local dir, leg, alt = string.match( cap:GetName(), "rus_CAP_TRACK%-?%d?_?(%w*)_?(%w*)_?(%w*)$" )

    if dir == '' then dir = 0 else dir = tonumber(dir) end
    if leg == '' then leg = 20 else leg = tonumber(leg) end
    if alt == '' then alt = 1000 * math.random( 26, 32 ) else alt = tonumber(alt) end
    
    -- local mission = AUFTRAG:NewCAP( cap, alt, 275, cap:GetCoordinate(), dir, leg )
    local mission = AUFTRAG:NewGCICAP(cap:GetCoordinate(), alt, 275, dir, leg)
    mission:SetMissionRange( 250 )
    mission:SetEngageDetected(math.random(70,110))
    mission:SetPriority( 1, true, 1 )
    mission:SetRequiredAssets( 2 )
    mission:SetRepeat( 1 )
    cap.capmish = mission

    function mission:OnBeforeRepeat()
      env.info('Repeating CAP')
    end
    
    rusChief:AddMission( mission )
  end )
end, {}, 30, 7200)

-- rus.CAPAnchors:ForEachZone( function( cap )
--   env.info( 'creating cap mission for zone: ' .. cap:GetName() )
--   local dir, leg, alt = string.match( cap:GetName(), "rus_CAP_TRACK%-?%d?_?(%w*)_?(%w*)_?(%w*)$" )
--   if dir == '' then dir = 0 else dir = tonumber(dir) end
--   if leg == '' then leg = 20 else leg = tonumber(leg) end
--   if alt == '' then alt = 1000 * math.random( 26, 32 ) else alt = tonumber(alt) end
--   local mission = AUFTRAG:NewCAP( cap, alt, 275, cap:GetCoordinate(), dir, leg )
--   mission:SetMissionRange( 250 )
--   mission:SetEngageDetected(math.random(70,120))
--   mission:SetPriority( 1, true, 1 )
--   mission:SetRequiredAssets( 2 )
--   mission:SetRepeat( 99 )

--   function mission:OnBeforeRepeat()
--     env.info('Repeating  CAP Escort')
--   end

--   rusChief:AddMission( mission )
-- end )

-- Commented Out V1.1.0 14-2-2023
-- setup INTERCEPT scanners
-- rus.QRFZoneScanners = {}
-- function rusChief:OnAfterNewContact( From, Event, To, Contact )
--   if Contact.ctype == INTEL.Ctype.AIRCRAFT then
--     if Contact.group:GetDCSObject():getCoalition() == coalition.side.RED then return end
--     env.info( 'BLUFOR aircraft detected' )
--     if not rus.QRFZoneScanners[Contact.groupname] then

--       local function groupInZone()
--         if Contact.mission then return end
--         local numMissions = rusChief.commander:CountMissions( { AUFTRAG.Type.INTERCEPT }, true )
--         if numMissions >= rus_MAX_SIMULTANEOUS_INTERCEPTS then return end
--         rus.QRFZones:ForEachZone( function ( z )
--           if not z then return end
--           if Contact.group and Contact.group:IsInZone( z ) then
--             local xcomp = Contact.velocity.x
--             local ycomp = Contact.velocity.y
--             local zcomp = Contact.velocity.z
--             local speed = math.sqrt( xcomp * xcomp + ycomp * ycomp + zcomp * zcomp )
--             local height = Contact.position.y
--             env.info( 'checking intercept...' )
--             local InterceptMission = AUFTRAG:NewINTERCEPT( Contact.group )
--             InterceptMission:SetMissionRange( 250 )
--             InterceptMission:SetPriority( 1, true, 1 )
--             InterceptMission:SetRequiredAssets( math.max( 1, Contact.group:GetSize() / 2) )
--             InterceptMission:SetRepeatOnFailure( 1 )
--             InterceptMission:SetMissionSpeed( 350 )
--             InterceptMission:SetMissionAltitude( height )
--             rusChief:AddMission( InterceptMission )
--             Contact.mission = InterceptMission
--             return
--           end
--         end )
--       end

--       local scheduler, sid = SCHEDULER:New( nil, groupInZone, {}, 1, 10 )
--       rus.QRFZoneScanners[Contact.groupname] = { ['scheduler'] = scheduler, ['sid'] = sid }
--     end
--   end
-- end

-- -- cleanup schedulers and auftrag when the contact is lost
-- function rusChief:OnAfterLostContact( From, Event, To, Contact )
--   if Contact.ctype == INTEL.Ctype.AIRCRAFT then
--     rus.QRFZoneScanners[Contact.groupname].scheduler:Stop( rus.QRFZoneScanners[Contact.groupname].sid )
--     rus.QRFZoneScanners[Contact.groupname] = nil -- allow garbage collection of scheduler
--     if Contact.mission ~= nil and not Contact.mission:IsDone() then
--       Contact.mission:Cancel() -- optional may need to make this logic more complicated, because EWR may lose contact even if interceptors don't, actually if at least one of them detects it, it shouldn't be dropped
--     end
--   end
-- end

-- CAPSpawner = SPAWN:New('SevastapolCAPTemplate')
-- CAPSpawner:InitRandomizeTemplate({'T_rus_Su27', 'T_rus_MiG31', 'T_rus_MiG29', 'T_rus_Su33', 'T_rus_Su30'})
-- local r1 = math.random(60, 180)
-- local r2 = math.random(60, 180)
-- local r3 = math.random(60, 120)
-- -- random 2 or 3 flights every 3 +/- 1 hour
-- SCHEDULER:New(nil, function () 
--   CAPSpawner:SpawnInZone(ZONE:FindByName('CrimeaSpawn'))
-- end, {}, 30, 60, 0, r1) 

-- SCHEDULER:New(nil, function () 
--   CAPSpawner:SpawnInZone(ZONE:FindByName('CrimeaSpawn'))
-- end, {}, 7200, 60, 3600, r2)

-- SCHEDULER:New(nil, function () 
--   CAPSpawner:SpawnInZone(ZONE:FindByName('CrimeaSpawn'))
-- end, {}, 14400, 60, 3600, r3)

-- cap_spawn_count = 0
-- CAPSpawner:OnSpawnGroup(function (g) 
--   cap_spawn_count = cap_spawn_count + 1
--   local fg = FLIGHTGROUP:New(g)
--   local alt = 1000 * math.random( 22, 32 )
--   local cap
--   if cap_spawn_count % 2 == 0 then
--     cap = ZONE:FindByName('rus_CAP_Sevastapol-1')
--   else
--     cap = ZONE:FindByName('rus_CAP_Sevastapol-2')
--   end
--   local auftrag = AUFTRAG:NewCAP(cap, alt, 275, cap:GetCoordinate(), 90, 40)
--   auftrag:SetMissionRange( 250 )
--   auftrag:SetEngageDetected(math.random(80,120))
--   auftrag:SetPriority( 1, true, 1 )
--   fg:AddMission(auftrag)
-- end)

-- env.info( 'Red Air started successfully' )
