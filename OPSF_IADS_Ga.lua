do

  -------------------------------------------
  -------------------------------------------
  --Georgia IADS
  -------------------------------------------
  -------------------------------------------
  -- MUST BE GLOBAL
  gaIADS = SkynetIADS:create('Georgia')

--  local iadsDebug = gaIADS:getDebugSettings()
--  iadsDebug.IADSStatus = true
--  iadsDebug.contacts = true
--
--  iadsDebug.samWentDark = true
--  iadsDebug.radarWentLive = true
--  iadsDebug.noWorkingCommmandCenter = true
--  iadsDebug.ewRadarNoConnection = true
--  iadsDebug.samNoConnection = true
--  iadsDebug.jammerProbability = true
--  iadsDebug.addedEWRadar = true
--  iadsDebug.hasNoPower = true
--  iadsDebug.harmDefence = true
--  iadsDebug.samSiteStatusEnvOutput = true
--  iadsDebug.earlyWarningRadarStatusEnvOutput = true
--
--  gaIADS:setUpdateInterval(60)


  gaIADS:addEarlyWarningRadarsByPrefix('gaEWR')
  gaIADS:addSAMSitesByPrefix('gaSAM')


  gaIADS:getSAMSitesByNatoName('SA-10'):setGoLiveRangeInPercent(75)
  gaIADS:getSAMSitesByNatoName('SA-5'):setGoLiveRangeInPercent(75)
  gaIADS:getSAMSitesByNatoName('SA-12'):setGoLiveRangeInPercent(75)
  gaIADS:getSAMSitesByNatoName('SA-11'):setGoLiveRangeInPercent(75)

  -- Command Center
  local CommandCenter = StaticObject.getByName('GaCommand-Center')
  local MainPowerSource1 = StaticObject.getByName('Georgia Power Station-2')
  local MainPowerSource2 = StaticObject.getByName('Georgia Power Station-3')
  local MainPowerSource3 = StaticObject.getByName('Georgia Power Station-4')

  if CommandCenter then
    local s = gaIADS:addCommandCenter(CommandCenter)
    if MainPowerSource1 then
    s:addPowerSource(MainPowerSource1)
    end
    if MainPowerSource2 then
      s:addPowerSource(MainPowerSource2)
    end
    if MainPowerSource3 then s
      :addPowerSource(MainPowerSource3)
    end
  end

  ------------------------------------
  --Vaziani Sector
  ------------------------------------

  --EWR--

  local PowerSource1 = StaticObject.getByName('Georgia Power Station-2')
  local PowerSource2 = StaticObject.getByName('Georgia Power Station-3')
  local PowerSource3 = StaticObject.getByName('Georgia Power Station-4')
  local ConnectionNodeEW = StaticObject.getByName('Viz-Sector-Command')
  local rew = Unit.getByName('gaEWR-3')
  local sa15 = gaIADS:getSAMSiteByGroupName('gaSAM-SA15-PD-1')

  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end

  if rew then
    local s = gaIADS:getEarlyWarningRadarByUnitName('gaEWR-3')
    if PowerSource1 then s:addPowerSource(PowerSource1) end 
    if PowerSource2 then s:addPowerSource(PowerSource2) end
    if PowerSource3 then s:addPowerSource(PowerSource3) end
    if ConnectionNodeEW then s:addConnectionNode(ConnectionNodeEW) end
    if sa15 then s:addPointDefence(sa15) end
  end

  local ConnectionNodeEW = StaticObject.getByName('Viz-Sector-Command')
  local rew = Unit.getByName('gaEWR-DE-1')
  local sa15 = gaIADS:getSAMSiteByGroupName('gaSAM-SA15-PD-2')
  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end
  
  if rew then
    local s = gaIADS:getEarlyWarningRadarByUnitName('gaEWR-DE-1')
    if ConnectionNodeEW then s:addConnectionNode(ConnectionNodeEW) end 
    if sa15 then s:addPointDefence(sa15) end  
  end

  local ConnectionNodeEW = StaticObject.getByName('Viz-Sector-Command')
  local rew = Unit.getByName('gaEWR-DE-2')
  local sa15 = gaIADS:getSAMSiteByGroupName('gaSAM-SA15-PD-1')
  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end

  if rew then
    local s = gaIADS:getEarlyWarningRadarByUnitName('gaEWR-DE-2')
    if ConnectionNodeEW then s:addConnectionNode(ConnectionNodeEW) end
    if sa15 then s:addPointDefence(sa15) end
  end

  local ConnectionNodeEW = StaticObject.getByName('Viz-Sector-Command')
  local rew = Unit.getByName('gaEWR-DE-3')
  local sa15 = gaIADS:getSAMSiteByGroupName('gaSAM-SA15-PD-3')
  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end

  if rew then
    local s = gaIADS:getEarlyWarningRadarByUnitName('gaEWR-DE-3')
    if ConnectionNodeEW then s:addConnectionNode(ConnectionNodeEW) end
    if sa15 then s:addPointDefence(sa15)end
  end

  --SAM--

  local PowerSource1 = StaticObject.getByName('Georgia Power Station-2')
  local PowerSource2 = StaticObject.getByName('Georgia Power Station-3')
  local PowerSource3 = StaticObject.getByName('Georgia Power Station-4')
  local connectionNodeEW = StaticObject.getByName('Viz-Sector-Command')
  local sam = gaIADS:getSAMSiteByGroupName('gaSAM-SA5-1')
  local sa15 = gaIADS:getSAMSiteByGroupName('gaSAM-SA15-PD-2')
  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(85)
    if PowerSource1 then sam:addPowerSource(PowerSource1) end
    if PowerSource2 then sam:addPowerSource(PowerSource2) end 
    if PowerSource3 then sam:addPowerSource(PowerSource3) end
    if connectionNodeEW then sam:addConnectionNode(connectionNodeEW) end
    if sa15 then sam:addPointDefence(sa15) end
    sam:setActAsEW(true)
  end

  local PowerSource1 = StaticObject.getByName('Georgia Power Station-2')
  local PowerSource2 = StaticObject.getByName('Georgia Power Station-3')
  local PowerSource3 = StaticObject.getByName('Georgia Power Station-4')
  local connectionNodeEW = StaticObject.getByName('Viz-Sector-Command')
  local sam = gaIADS:getSAMSiteByGroupName('gaSAM-SA12gi-1')
  local sa15 = gaIADS:getSAMSiteByGroupName('gaSAM-SA15-PD-3')

  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    if PowerSource1 then sam:addPowerSource(PowerSource1) end
    if PowerSource2 then sam:addPowerSource(PowerSource2) end 
    if PowerSource3 then sam:addPowerSource(PowerSource3) end
    if connectionNodeEW then sam:addConnectionNode(connectionNodeEW) end
    if sa15 then sam:addPointDefence(sa15) end
  end


  local connectionNodeEW = StaticObject.getByName('Viz-Sector-Command')
  local sam = gaIADS:getSAMSiteByGroupName('gaSAM-SA11-3')


  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(70)
    if connectionNodeEW then sam:addConnectionNode(connectionNodeEW) end
  end

  local connectionNodeEW = StaticObject.getByName('Viz-Sector-Command')
  local sam = gaIADS:getSAMSiteByGroupName('gaSAM-SA11-4')


  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    if connectionNodeEW then sam:addConnectionNode(connectionNodeEW) end
  end

  ------------------------------------
  --Kutaisi Sector
  ------------------------------------

  --EWR--

  local PowerSource1 = StaticObject.getByName('Georgia Power Station-1')
  local ConnectionNodeEW = StaticObject.getByName('Kut-Sector-Command')
  local rew = Unit.getByName('gaEWR-2')

  if rew then
    local s = gaIADS:getEarlyWarningRadarByUnitName('gaEWR-2')
    if PowerSource1 then s:addPowerSource(PowerSource1) end 
    if ConnectionNodeEW then s:addConnectionNode(ConnectionNodeEW) end
  end

  local ConnectionNodeEW = StaticObject.getByName('Kut-Sector-Command')
  local rew = Unit.getByName('gaEWR-DE-4')

  if rew then
    local s = gaIADS:getEarlyWarningRadarByUnitName('gaEWR-DE-4')
    if ConnectionNodeEW then s:addConnectionNode(ConnectionNodeEW) end
  end

  --SAM--

  local PowerSource1 = StaticObject.getByName('Georgia Power Station-6')
  local connectionNodeEW = StaticObject.getByName('Kut-Sector-Command')
  local sam = gaIADS:getSAMSiteByGroupName('gaSAM-SA12gl-1')
  local sa15 = gaIADS:getSAMSiteByGroupName('gaSAM-SA15-PD-4')
  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(95)
    if PowerSource1 then sam:addPowerSource(PowerSource1) end
    if connectionNodeEW then sam:addConnectionNode(connectionNodeEW) end
    if sa15 then sam:addPointDefence(sa15) end
    sam:setActAsEW(true)
  end

  local connectionNodeEW = StaticObject.getByName('Kut-Sector-Command')
  local sam = gaIADS:getSAMSiteByGroupName('gaSAM-SA11-2')

  if sam then
    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
  end

  local connectionNodeEW = StaticObject.getByName('Kut-Sector-Command')
  local sam = gaIADS:getSAMSiteByGroupName('gaSAM-SA11-1')

  if sam then
    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(100)
    if connectionNodeEW then 
      sam:addConnectionNode(connectionNodeEW)
    end
  end

  local connectionNodeEW = StaticObject.getByName('Kut-Sector-Command')
  local sam = gaIADS:getSAMSiteByGroupName('gaSAM-SA11-5')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(100)
    if connectionNodeEW then sam:addConnectionNode(connectionNodeEW) end
  end

  ------------------------------------
  --Sukhumi Sector
  ------------------------------------

  --EWR--

  local PowerSource1 = StaticObject.getByName('Georgia Power Station-5')
  local ConnectionNodeEW = StaticObject.getByName('Suk-Sector-Command')
  local rew = Unit.getByName('gaEWR-1')

  if rew then
    local s = gaIADS:getEarlyWarningRadarByUnitName('gaEWR-1')
    if PowerSource1 then s:addPowerSource(PowerSource1) end 
    if ConnectionNodeEW then s:addConnectionNode(ConnectionNodeEW) end
  end

  local ConnectionNodeEW = StaticObject.getByName('Kut-Sector-Command')
  local rew = Unit.getByName('gaEWR-DE-5')

  if rew then
    local s = gaIADS:getEarlyWarningRadarByUnitName('gaEWR-DE-5')
    if ConnectionNodeEW then s:addConnectionNode(ConnectionNodeEW) end
  end

  local ConnectionNodeEW = StaticObject.getByName('Kut-Sector-Command')
  local rew = Unit.getByName('gaEWR-DE-6')

  if rew then
    local s = gaIADS:getEarlyWarningRadarByUnitName('gaEWR-DE-6')
    if ConnectionNodeEW then s:addConnectionNode(ConnectionNodeEW) end
  end

  --SAM--

  local PowerSource1 = StaticObject.getByName('Georgia Power Station-5')
  local connectionNodeEW = StaticObject.getByName('Suk-Sector-Command')
  local sam = gaIADS:getSAMSiteByGroupName('gaSAM-SA10-1')
  local sa15 = gaIADS:getSAMSiteByGroupName('gaSAM-SA15-PD-6')
  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(60)
    if PowerSource1 then sam:addPowerSource(PowerSource1) end
    if connectionNodeEW then sam:addConnectionNode(connectionNodeEW) end
    if sa15 then sam:addPointDefence(sa15) end
  end

  local connectionNodeEW = StaticObject.getByName('Suk-Sector-Command')
  local sam = gaIADS:getSAMSiteByGroupName('gaSAM-SA11-7')

  if sam then
    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(100)
    if connectionNodeEW then sam:addConnectionNode(connectionNodeEW) end
  end

  local connectionNodeEW = StaticObject.getByName('Suk-Sector-Command')
  local sam = gaIADS:getSAMSiteByGroupName('gaSAM-SA8-1')

  if sam then
    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(110)
    if connectionNodeEW then sam:addConnectionNode(connectionNodeEW) end
  end

  gaIADS:activate()

end
