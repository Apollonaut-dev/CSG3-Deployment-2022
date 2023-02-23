-- local rus_MAX_SIMULTANEOUS_INTERCEPTS = 5
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
-- rus.QRFZones = SET_ZONE:New():FilterPrefixes( 'rus_QRF_ZONE' ):FilterOnce()

rus.Airwings = {}
rus.Squadrons = {}
-- Mozdok
local WH = STATIC:FindByName('rus_WH-1')
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
  rus.Squadrons.Mozdok.C2C:SetMissionRange( 400 )
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
local WH = STATIC:FindByName('rus_WH-2')
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
local WH = STATIC:FindByName('rus_WH-3')
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
  rus.Squadrons.Vaziani.Su30:AddMissionCapability( Su30Capability, 100 )
  rus.Squadrons.Vaziani.Su30:SetMissionRange( 250 )
  rus.Squadrons.Vaziani.Su30:SetFuelLowRefuel( true )
  rus.Airwings.Vaziani:AddSquadron( rus.Squadrons.Vaziani.Su30 )

end
-- Anapa
local WH = STATIC:FindByName('rus_WH-4')
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
  rus.Squadrons.Anapa.MiG31:AddMissionCapability( MiG31Capability, 100 )
  rus.Squadrons.Anapa.MiG31:SetMissionRange( 300 )
  rus.Squadrons.Anapa.MiG31:SetFuelLowRefuel( true )
  rus.Airwings.Anapa:AddSquadron( rus.Squadrons.Anapa.MiG31 )
  
  rus.Squadrons.Anapa.Su30 = SQUADRON:New( 'T_rus_Su30', 20, '19th Fighter SQ' )
  rus.Squadrons.Anapa.Su30:AddMissionCapability( Su30Capability, 100 )
  rus.Squadrons.Anapa.Su30:SetMissionRange( 300 )
  rus.Squadrons.Anapa.Su30:SetFuelLowRefuel( true )
  rus.Airwings.Anapa:AddSquadron( rus.Squadrons.Anapa.Su30 )

end
-- Kutaisi
local WH = STATIC:FindByName('rus_WH-5')
if WH then
  rus.Airwings.Kutaisi = AIRWING:New( 'rus_WH-5', '5th Airwing' )
  rus.Squadrons.Kutaisi = {}
  rus.Airwings.Kutaisi:NewPayload( 'P_rus_Su27', -1, Su27Capability, 100 )
  rus.Airwings.Kutaisi:NewPayload( 'P_rus_Su30', -1, Su30Capability, 100 )
  rus.Airwings.Kutaisi:NewPayload( 'P_rus_MiG31', -1, MiG31Capability, 100 )
  rus.Airwings.Kutaisi:NewPayload( 'P_rus_MiG29', -1, MiG29Capability, 100 )

  rus.Squadrons.Kutaisi.Su27 = SQUADRON:New( 'T_rus_Su27', 20, '16th Fighter SQ' )
  rus.Squadrons.Kutaisi.Su27:AddMissionCapability( Su33Capability, 100 )
  rus.Squadrons.Kutaisi.Su27:SetMissionRange( 250 )
  rus.Squadrons.Kutaisi.Su27:SetFuelLowRefuel( true )
  rus.Airwings.Kutaisi:AddSquadron( rus.Squadrons.Kutaisi.Su27 )
  
  rus.Squadrons.Kutaisi.MiG29 = SQUADRON:New( 'T_rus_MiG29', 20, '17th Fighter SQ' )
  rus.Squadrons.Kutaisi.MiG29:AddMissionCapability( MiG29Capability, 100 )
  rus.Squadrons.Kutaisi.MiG29:SetMissionRange( 250 )
  rus.Squadrons.Kutaisi.MiG29:SetFuelLowRefuel( true )
  rus.Airwings.Kutaisi:AddSquadron( rus.Squadrons.Kutaisi.MiG29 )
  
  rus.Squadrons.Kutaisi.MiG31 = SQUADRON:New( 'T_rus_MiG31', 20, '18th Fighter SQ' )
  rus.Squadrons.Kutaisi.MiG31:AddMissionCapability( MiG31Capability, 100 )
  rus.Squadrons.Kutaisi.MiG31:SetMissionRange( 250 )
  rus.Squadrons.Kutaisi.MiG31:SetFuelLowRefuel( true )
  rus.Airwings.Kutaisi:AddSquadron( rus.Squadrons.Kutaisi.MiG31 )
  
  rus.Squadrons.Kutaisi.Su30 = SQUADRON:New( 'T_rus_Su30', 20, '19th Fighter SQ' )
  rus.Squadrons.Kutaisi.Su30:AddMissionCapability( Su30Capability, 100 )
  rus.Squadrons.Kutaisi.Su30:SetMissionRange( 250 )
  rus.Squadrons.Kutaisi.Su30:SetFuelLowRefuel( true )
  rus.Airwings.Kutaisi:AddSquadron( rus.Squadrons.Kutaisi.Su30 )

end
-- Batumi
local WH = STATIC:FindByName('rus_WH-6')
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
-- Kobuleti
local WH = STATIC:FindByName('rus_WH-7')
if WH then
  rus.Airwings.Kobuleti = AIRWING:New( 'rus_WH-7', '7th Airwing' )
  rus.Squadrons.Kobuleti = {}
  rus.Airwings.Kobuleti:NewPayload( 'P_rus_Su25T', -1, Su25Capability, 100 )

  rus.Squadrons.Kobuleti.Su25T = SQUADRON:New( 'T_rus_Su25T', 20, '20th Fighter SQ' )
  rus.Squadrons.Kobuleti.Su25T:AddMissionCapability( Su25Capability, 100 )
  rus.Squadrons.Kobuleti.Su25T:SetMissionRange( 150 )
  rus.Squadrons.Kobuleti.Su25T:SetRadio( 270 )
  rus.Squadrons.Kobuleti.Su25T:SetFuelLowThreshold( 15 )
  rus.Airwings.Kobuleti:AddSquadron( rus.Squadrons.Kobuleti.Su25T )
  

end
-- Senaki
local WH = STATIC:FindByName('rus_WH-8')
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

-- Sukhumi
local WH = STATIC:FindByName('rus_WH-9')
if WH then
  rus.Airwings.Sukhumi = AIRWING:New( 'rus_WH-9', '9th Airwing' )
  rus.Squadrons.Sukhumi = {}
  rus.Airwings.Sukhumi:NewPayload( 'P_rus_Su27', -1, Su27Capability, 100 )

  rus.Squadrons.Sukhumi.Su27 = SQUADRON:New( 'T_rus_Su27', 20, '22nd Fighter SQ' )
  rus.Squadrons.Sukhumi.Su27:AddMissionCapability( Su33Capability, 100 )
  rus.Squadrons.Sukhumi.Su27:SetMissionRange( 250 )
  rus.Squadrons.Sukhumi.Su27:SetFuelLowRefuel( true )
  rus.Airwings.Sukhumi:AddSquadron( rus.Squadrons.Sukhumi.Su27 )
  

end
-- Gudata
local WH = STATIC:FindByName('rus_WH-10')
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
-- Soganlug
local WH = STATIC:FindByName('rus_WH-11')
if WH then
  rus.Airwings.Soganlug = AIRWING:New( 'rus_WH-11', '11th Airwing' )
  rus.Squadrons.Soganlug = {}
  rus.Airwings.Soganlug:NewPayload( 'T_rus_Ka50', -1, Ka50Capability, 100 )
  rus.Airwings.Soganlug:NewPayload( 'T_rus_Mi28', -1, Mi28Capability, 100 )
  rus.Airwings.Soganlug:NewPayload( 'T_rus_Mi24', -1, Mi24Capability, 100 )

  rus.Squadrons.Soganlug.Ka50 = SQUADRON:New( 'T_rus_Ka50', 20, '4th Attack SQ' )
  rus.Squadrons.Soganlug.Ka50:AddMissionCapability( Ka50Capability, 100 )
  rus.Squadrons.Soganlug.Ka50:SetMissionRange( 50 )
  rus.Squadrons.Soganlug.Ka50:SetFuelLowRefuel( true )
  rus.Airwings.Soganlug:AddSquadron( rus.Squadrons.Soganlug.Ka50 )
  
  rus.Squadrons.Soganlug.Mi28 = SQUADRON:New( 'T_rus_Mi28', 20, '5th Attack SQ' )
  rus.Squadrons.Soganlug.Mi28:AddMissionCapability( Mi28Capability, 100 )
  rus.Squadrons.Soganlug.Mi28:SetMissionRange( 50 )
  rus.Squadrons.Soganlug.Mi28:SetFuelLowRefuel( true )
  rus.Airwings.Soganlug:AddSquadron( rus.Squadrons.Soganlug.Mi28 )
  
  rus.Squadrons.Soganlug.Mi24 = SQUADRON:New( 'T_rus_Mi24', 20, '6th Attack SQ' )
  rus.Squadrons.Soganlug.Mi24:AddMissionCapability( Mi24Capability, 100 )
  rus.Squadrons.Soganlug.Mi24:SetMissionRange( 50 )
  rus.Squadrons.Soganlug.Mi24:SetFuelLowRefuel( true )
  rus.Airwings.Soganlug:AddSquadron( rus.Squadrons.Soganlug.Mi24 )

end
-- Gelendzhik
local WH = STATIC:FindByName('rus_WH-12')
if WH then
  rus.Airwings.Gelendzhik = AIRWING:New( 'rus_WH-12', '12th Airwing' )
  rus.Squadrons.Gelendzhik = {}
  rus.Airwings.Gelendzhik:NewPayload( 'T_rus_Ka50', -1, Ka50Capability, 100 )
  rus.Airwings.Gelendzhik:NewPayload( 'T_rus_Mi28', -1, Mi28Capability, 100 )
  rus.Airwings.Gelendzhik:NewPayload( 'T_rus_Mi24', -1, Mi24Capability, 100 )

  rus.Squadrons.Gelendzhik.Ka50 = SQUADRON:New( 'T_rus_Ka50', 20, '7th Attack SQ' )
  rus.Squadrons.Gelendzhik.Ka50:AddMissionCapability( Ka50Capability, 100 )
  rus.Squadrons.Gelendzhik.Ka50:SetMissionRange( 50 )
  rus.Squadrons.Gelendzhik.Ka50:SetFuelLowRefuel( true )
  rus.Airwings.Gelendzhik:AddSquadron( rus.Squadrons.Gelendzhik.Ka50 )
  
  rus.Squadrons.Gelendzhik.Mi28 = SQUADRON:New( 'T_rus_Mi28', 20, '8th Attack SQ' )
  rus.Squadrons.Gelendzhik.Mi28:AddMissionCapability( Mi28Capability, 100 )
  rus.Squadrons.Gelendzhik.Mi28:SetMissionRange( 50 )
  rus.Squadrons.Gelendzhik.Mi28:SetFuelLowRefuel( true )
  rus.Airwings.Gelendzhik:AddSquadron( rus.Squadrons.Gelendzhik.Mi28 )
  
  rus.Squadrons.Gelendzhik.Mi24 = SQUADRON:New( 'T_rus_Mi24', 20, '9th Attack SQ' )
  rus.Squadrons.Gelendzhik.Mi24:AddMissionCapability( Mi24Capability, 100 )
  rus.Squadrons.Gelendzhik.Mi24:SetMissionRange( 50 )
  rus.Squadrons.Gelendzhik.Mi24:SetFuelLowRefuel( true )
  rus.Airwings.Gelendzhik:AddSquadron( rus.Squadrons.Gelendzhik.Mi24 )

end
-- Novorossiysk
local WH = STATIC:FindByName('rus_WH-13')
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
local WH = STATIC:FindByName('rus_WH-14')
if WH then
  rus.Airwings.Krymsk = AIRWING:New( 'rus_WH-14', '14th Airwing' )
  rus.Squadrons.Krymsk = {}
  rus.Airwings.Krymsk:NewPayload( 'P_rus_Su33', -1, Su33Capability, 100 )

  rus.Squadrons.Krymsk.Su33 = SQUADRON:New( 'T_rus_Su33', 20, '25th Fighter SQ' )
  rus.Squadrons.Krymsk.Su33:AddMissionCapability( Su33Capability, 100 )
  rus.Squadrons.Krymsk.Su33:SetMissionRange( 250 )
  rus.Squadrons.Krymsk.Su33:SetFuelLowRefuel( true )
  rus.Airwings.Krymsk:AddSquadron( rus.Squadrons.Krymsk.Su33 )
  

end
-- Krasnodar
local WH = STATIC:FindByName('rus_WH-15')
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
  rus.Squadrons.Krasnodar.MiG31:AddMissionCapability( MiG31Capability, 100 )
  rus.Squadrons.Krasnodar.MiG31:SetMissionRange( 300 )
  rus.Squadrons.Krasnodar.MiG31:SetFuelLowRefuel( true )
  rus.Airwings.Krasnodar:AddSquadron( rus.Squadrons.Krasnodar.MiG31 )
  
  rus.Squadrons.Krasnodar.Su30 = SQUADRON:New( 'T_rus_Su30', 20, '28th Fighter SQ' )
  rus.Squadrons.Krasnodar.Su30:AddMissionCapability( Su30Capability, 100 )
  rus.Squadrons.Krasnodar.Su30:SetMissionRange( 300 )
  rus.Squadrons.Krasnodar.Su30:SetFuelLowRefuel( true )
  rus.Airwings.Krasnodar:AddSquadron( rus.Squadrons.Krasnodar.Su30 )

end
-- KrasnodarP
local WH = STATIC:FindByName('rus_WH-16')
if WH then
  rus.Airwings.KrasnodarP = AIRWING:New( 'rus_WH-16', '16th Airwing' )
  rus.Squadrons.KrasnodarP = {}
  rus.Airwings.KrasnodarP:NewPayload('P_rus_Su24', -1, Su24Capability, 100)
  rus.Airwings.KrasnodarP:NewPayload( 'P_rus_Su34', -1, Su34Capability, 100 )
  
  rus.Squadrons.KrasnodarP.Su24 = SQUADRON:New( 'T_rus_Su24', 20, '29th Fighter SQ' )
  rus.Squadrons.KrasnodarP.Su24:AddMissionCapability( Su24Capability, 100 )
  rus.Squadrons.KrasnodarP.Su24:SetMissionRange( 500 )
  rus.Squadrons.KrasnodarP.Su24:SetFuelLowRefuel( true )
  rus.Airwings.KrasnodarP:AddSquadron( rus.Squadrons.KrasnodarP.Su24 )
  
  rus.Squadrons.KrasnodarP.Su34 = SQUADRON:New( 'T_rus_Su34', 20, '30th Fighter SQ' )
  rus.Squadrons.KrasnodarP.Su34:AddMissionCapability( Su34Capability, 100 )
  rus.Squadrons.KrasnodarP.Su34:SetMissionRange( 300 )
  rus.Squadrons.KrasnodarP.Su34:SetFuelLowRefuel( true )
  rus.Airwings.Krasnodar:AddSquadron( rus.Squadrons.KrasnodarP.Su34 )
  
end
-- Beslan
local WH = STATIC:FindByName('rus_WH-17')
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
local WH = STATIC:FindByName('rus_WH-18')
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
local WH = STATIC:FindByName('rus_WH-19')
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

for _, A in pairs( rus.Airwings ) do
  function A:OnAfterFlightOnMission( From, Event, To, Flightgroup, Mission )
    local flightgroup = Flightgroup
    -- env.info('flightgroup' .. flatdump(flightgroup))
    local mission = Mission
  
    local escortAWACS1
    local escortAWACS2
    if mission:GetType() == AUFTRAG.Type.AWACS then
      local Escortee = flightgroup:GetGroup()
      Escortee:SetCommandImmortal(true)
      -- local escortAWACS1 = AUFTRAG:NewESCORT( Escortee, POINT_VEC3:New( -100, 0, 200 ), 60, nil )
      escortAWACS1 = AUFTRAG:NewESCORT( Escortee, POINT_VEC3:New( -100, 0, 200 ), 60, nil )
      escortAWACS1:SetMissionRange( 250 )
      escortAWACS1:SetEngageDetected(50)
      escortAWACS1:SetRequiredAssets( 1 )
      -- escortAWACS1:SetRepeat(1)
      -- local escortAWACS2 = AUFTRAG:NewESCORT( Escortee, POINT_VEC3:New( -100, 0, -200 ), 60, nil )
      escortAWACS2 = AUFTRAG:NewESCORT( Escortee, POINT_VEC3:New( -100, 0, -200 ), 60, nil )
      escortAWACS2:SetMissionRange( 250 )
      escortAWACS2:SetEngageDetected(50)
      escortAWACS2:SetRequiredAssets( 1 )
      -- escortAWACS2:SetRepeat(1)
      function escortAWACS1:OnBeforeRepeat()
        env.info('before repeat')
      end
      function escortAWACS2:OnBeforeRepeat()
        env.info('before repeat')
      end
      rusChief:AddMission( escortAWACS1 )
      rusChief:AddMission( escortAWACS2 )
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
        escortAWACS2:Cancel()
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
  env.info('alt: '.. alt.. 'type: '..type(alt))
  if dir == '' then dir = 0 else dir = tonumber(dir) end
  if leg == '' then leg = 20 else leg = tonumber(leg) end
  if alt == '' then alt = 1000 * math.random( 26, 32 ) else alt = tonumber(alt) end
  -- env.info('new alt: '.. tostring(alt == '')..tostring(not alt)..tostring(tonumber(alt)))
  local mission = AUFTRAG:NewAWACS(ep:GetCoordinate(), alt, UTILS.KnotsToAltKIAS(250, alt), dir, leg)
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
  env.info('new alt: '.. tostring(alt == '')..tostring(not alt)..tostring(tonumber(alt)))
  local mission = AUFTRAG:NewTANKER(tp:GetCoordinate(), alt, UTILS.KnotsToAltKIAS(250, alt), dir, leg, 1)
  mission:SetRepeat(99)
  rusChief:AddMission(mission)
end)

rus.CAPAnchors:ForEachZone( function( cap )
  env.info( 'creating cap mission for zone: ' .. cap:GetName() )
  local dir, leg, alt = string.match( cap:GetName(), "rus_CAP_TRACK%-?%d?_?(%w*)_?(%w*)_?(%w*)$" )
  if dir == '' then dir = 0 else dir = tonumber(dir) end
  if leg == '' then leg = 20 else leg = tonumber(leg) end
  if alt == '' then alt = 1000 * math.random( 26, 32 ) else alt = tonumber(alt) end
  -- local mission = AUFTRAG:NewGCICAP(cap:GetCoordinate(), alt, UTILS.KnotsToAltKIAS(250, alt), dir, leg)
  local mission = AUFTRAG:NewCAP( cap, alt, UTILS.KnotsToAltKIAS( 220, alt ), cap:GetCoordinate(), dir, leg )
  -- mission:SetRepeat(999)
  mission:SetMissionRange( 250 )
  mission:SetEngageDetected(math.random(60,120))
  mission:SetPriority( 1, true, 1 )
  mission:SetRequiredAssets( 2 )
  mission:SetRepeat( 99 )

  rusChief:AddMission( mission )
end )

-- Commented Out V1.1.0 14-2-2023
-- -- setup INTERCEPT scanners
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
--             InterceptMission:SetRequiredAssets( math.max( 2, Contact.group:GetSize() ) )
--             InterceptMission:SetRepeatOnFailure( 2 )
--             InterceptMission:SetMissionSpeed( UTILS.KnotsToAltKIAS( speed, height ) )
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

env.info( 'Red Air started successfully' )
