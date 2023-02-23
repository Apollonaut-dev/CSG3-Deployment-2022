do
  -- MUST BE GLOBAL
  rusIADS = SkynetIADS:create('Russia')

--  local iadsDebug = rusIADS:getDebugSettings()
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
  
  rusIADS:setUpdateInterval(60)


  rusIADS:addEarlyWarningRadarsByPrefix('RusEWR')
  --rusIADS:addEarlyWarningRadarsByPrefix('rus_AWACS')
  rusIADS:addSAMSitesByPrefix('RusSAM')

  
  rusIADS:getSAMSitesByNatoName('SA-10'):setGoLiveRangeInPercent(75) 
  rusIADS:getSAMSitesByNatoName('SA-12'):setGoLiveRangeInPercent(75)
  rusIADS:getSAMSitesByNatoName('SA-11'):setGoLiveRangeInPercent(75)

  -- Command Center
  local CommandCenter = StaticObject.getByName('rusCommand-Center')
  local MainPowerSource1 = StaticObject.getByName('Eastern Power Station-3')
  local MainPowerSource2 = StaticObject.getByName('Eastern Power Station-4')

  if CommandCenter then
    rusIADS:addCommandCenter(CommandCenter):addPowerSource(MainPowerSource1):addPowerSource(MainPowerSource2)
  end

  ------------------------------------
  --Beslan Sector
  ------------------------------------

  -- EWR
  local PowerSource = StaticObject.getByName('Eastern Power Station-2')
  local ConnectionNodeEW = StaticObject.getByName('BS-Sector-Command')
  local rew = Unit.getByName('RusEWR-4')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-1')
  
  if rew then
    rusIADS:getEarlyWarningRadarByUnitName('RusEWR-4'):addPowerSource(PowerSource):addConnectionNode(ConnectionNodeEW)
    if sa15 then 
      sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100)
      rusIADS:getEarlyWarningRadarByUnitName('RusEWR-4'):addPointDefence(sa15)
    end
  end

  local ConnectionNodeEW = StaticObject.getByName('BS-Sector-Command')
  local rew = Unit.getByName('RusEWR-DE-1')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-1')
  
  if rew then
    if sa15 then 
      sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100)
      rusIADS:getEarlyWarningRadarByUnitName('RusEWR-DE-1'):addPointDefence(sa15)
    end
    if ConnectionNodeEW then
      rusIADS:getEarlyWarningRadarByUnitName('RusEWR-DE-1'):addConnectionNode(ConnectionNodeEW)
    end
  end
  
  local ConnectionNodeEW = StaticObject.getByName('BS-Sector-Command')
  local rew = Unit.getByName('RusEWR-DE-2')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-2')

  if rew then
    local s = rusIADS:getEarlyWarningRadarByUnitName('RusEWR-DE-2')
    if sa15 then 
      sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100)
      s:addPointDefence(sa15)
    end
    if ConnectionNodeEW then
      s:addConnectionNode(ConnectionNodeEW)
    end
  end
  
  --SAM

  local powerSource = StaticObject.getByName('Eastern Power Station-2')
  local connectionNodeEW = StaticObject.getByName('BS-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA12gl-3')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-1')

  if sam then
    if sa15 then 
      sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100)
      sam:addPointDefence(sa15)
    end
    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    if powerSource then
      sam:addPowerSource(powerSource)
    end
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
  end

  local powerSource = StaticObject.getByName('Eastern Power Station-1')
  local connectionNodeEW = StaticObject.getByName('BS-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA10-6')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-2')

  if sam then
    if sa15 then 
      sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100)
      sam:addPointDefence(sa15)
    end
    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(85)
    if powerSource then
      sam:addPowerSource(powerSource)
    end
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
    sam:setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
  end
  
  local connectionNodeEW = StaticObject.getByName('BS-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA11-5')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(60)
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
    sam:setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
    if sa15 then
      sam:addPointDefence(sa15)
    end
  end

  ------------------------------------
  --Mineralnye Vody Sector
  ------------------------------------

  -- EWR
  local ConnectionNodeEW = StaticObject.getByName('MV-Sector-Command')
  local rew = Unit.getByName('RusEWR-DE-3')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-3')
  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end

  if rew then
    local s = rusIADS:getEarlyWarningRadarByUnitName('RusEWR-DE-3')
    if ConnectionNodeEW then
      s:addConnectionNode(ConnectionNodeEW)
    end
    if sa15 then
      s:addPointDefence(sa15)
    end
  end

  --sam

  local powerSource1 = StaticObject.getByName('Eastern Power Station-3')
  local powerSource2 = StaticObject.getByName('Eastern Power Station-4')
  local connectionNodeEW = StaticObject.getByName('MV-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA12gi-3')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-3')

  if sam then
    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(100)
    if powerSource1 then
      sam:addPowerSource(powerSource1)
    end
    if powerSource2 then
      sam:addPowerSource(powerSource2)
    end
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
    sam:setAutonomousBehaviour(SkynetIADSAbstractRadarElement.AUTONOMOUS_STATE_DARK)
    if sa15 then
      sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100)
      sam:addPointDefence(sa15)
    end
    sam:setActAsEW(true)
  end
  
  local connectionNodeEW = StaticObject.getByName('MV-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA11-6')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(60)
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
  end

  ------------------------------------
  --Sochi Sector
  ------------------------------------

  -- EWR
  local PowerSource = StaticObject.getByName('Wester Power Station-3')
  local ConnectionNodeEW = StaticObject.getByName('SA-Sector-Command')
  local rew = Unit.getByName('RusEWR-5')

  if rew then
    local s = rusIADS:getEarlyWarningRadarByUnitName('RusEWR-5')
    if PowerSource then
      s:addPowerSource(PowerSource)
    end
    if ConnectionNodeEW then
      s:addConnectionNode(ConnectionNodeEW)
    end
  end
  
  --SAM
  
  local connectionNodeEW = StaticObject.getByName('SA-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA11-2')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
  end
  
  local connectionNodeEW = StaticObject.getByName('SA-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA11-8')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(70)
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
  end
  
  local connectionNodeEW = StaticObject.getByName('SA-Sector-Command')
  
  ------------------------------------
  --Maykop Sector
  ------------------------------------
  
  --SAM
  
  local connectionNodeEW = StaticObject.getByName('MK-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA11-9')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end      
  end
  
  local connectionNodeEW = StaticObject.getByName('MK-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA11-10')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
  end
  
  ------------------------------------
  --Anapa Sector
  ------------------------------------
  
  --EWR
  
  local PowerSource = StaticObject.getByName('Wester Power Station-1')
  local ConnectionNodeEW = StaticObject.getByName('AN-Sector-Command')
  local rew = Unit.getByName('RusEWR-3')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-6')
  
  if sa15 then
    sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100)
  end

  if rew then
    local s = rusIADS:getEarlyWarningRadarByUnitName('RusEWR-3')
    if PowerSource then
      s:addPowerSource(PowerSource)
    end
    if ConnectionNodeEW then
      s:addConnectionNode(ConnectionNodeEW)
    end
    if sa15 then
      sa15:addPointDefence(sa15)
    end
  end
  
  local ConnectionNodeEW = StaticObject.getByName('AN-Sector-Command')
  local rew = Unit.getByName('RusEWR-DE-6')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-6')

  if sa15 then
    sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100)
  end

  if rew then
    local s = rusIADS:getEarlyWarningRadarByUnitName('RusEWR-DE-6')
    
    if ConnectionNodeEW then
      s:addConnectionNode(ConnectionNodeEW)
    end
    if sa15 then
      s:addPointDefence(sa15)
    end
  end
  
  local ConnectionNodeEW = StaticObject.getByName('AN-Sector-Command')
  local rew = Unit.getByName('RusEWR-DE-7')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-7')

  if sa15 then
    sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100)
  end

  if rew then
    local s = rusIADS:getEarlyWarningRadarByUnitName('RusEWR-DE-7')
    if ConnectionNodeEW then 
      s:addConnectionNode(ConnectionNodeEW)
    end
    if sa15 then
      s:addPointDefence(sa15)
    end
  end
  
  --SAM
  
  local powerSource1 = StaticObject.getByName('Wester Power Station-1')
  local connectionNodeEW = StaticObject.getByName('AN-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA12gl-1')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-6')

  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(85)
    if powerSource1 then
      sam:addPowerSource(powerSource1)
    end
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
    if sa15 then
      sam:addPointDefence(sa15)
    end
  end

  local powerSource1 = StaticObject.getByName('Wester Power Station-1')
  local connectionNodeEW = StaticObject.getByName('AN-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA10-5')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-7')
  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end 
  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(100)
    if powerSource1 then
      sam:addPowerSource(powerSource1)
    end
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
    if sa15 then 
      sam:addPointDefence(sa15)
    end
      sam:setActAsEW(true)
  end
  
  local connectionNodeEW = StaticObject.getByName('AN-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA11-14')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
  end
  
  ------------------------------------
  --Eastern Crimea Sector
  ------------------------------------
  
  --EWR
  
  local ConnectionNodeEW = Unit.getByName('EC-Sector-Command')
  local rew = Unit.getByName('RusEWR-DE-8')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-8')
  if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end

  if rew then
    local s = rusIADS:getEarlyWarningRadarByUnitName('RusEWR-DE-8')
    if ConnectionNodeEW then 
      s:addConnectionNode(ConnectionNodeEW)
    end
    if sa15 then sa15:addPointDefence(sa15) end
  end
  
  --SAM
  
  local powerSource1 = StaticObject.getByName('Crimea Power Station-3')
  local connectionNodeEW = Unit.getByName('EC-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA12gi-2')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-8')
if sa15 then sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100) end
  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(75)
    if powerSource1 then
      sam:addPowerSource(powerSource1)
    end
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
    if sa15 then
      sam:addPointDefence(sa15)
    end
  end
  
  ------------------------------------
  --Western Crimea Sector
  ------------------------------------
  
  --EWR
  
  local PowerSource = StaticObject.getByName('Crimea Power Station-4')
  local ConnectionNodeEW = StaticObject.getByName('SP-Sector-Command')
  local rew = Unit.getByName('RusEWR-1')
 
  if rew then
    local s = rusIADS:getEarlyWarningRadarByUnitName('RusEWR-1')
    if PowerSource then
      s:addPowerSource(PowerSource)
    end 
    if ConnectionNodeEW then 
      s:addConnectionNode(ConnectionNodeEW)
    end
  end
  
  -- local ConnectionNodeEW = StaticObject.getByName('SP-Sector-Command')
  -- local rew = Unit.getByName('RusEWR-DE-11')
  -- local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-11'):setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100)

  -- if rew then
  --   rusIADS:getEarlyWarningRadarByUnitName('RusEWR-DE-11'):addConnectionNode(ConnectionNodeEW):addPointDefence(sa15)
  -- end
  
    local ConnectionNodeEW = StaticObject.getByName('SP-Sector-Command')
  local rew = Unit.getByName('RusEWR-DE-12')
  local sa15 = rusIADS:getSAMSiteByGroupName('RusSAM-SA15-PD-12')

  if sa15 then 
    sa15:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_SEARCH_RANGE):setGoLiveRangeInPercent(100)
  end
  if rew then
    local s = rusIADS:getEarlyWarningRadarByUnitName('RusEWR-DE-12')
    if ConnectionNodeEW then
      s:addConnectionNode(ConnectionNodeEW)
    end
    if sa15 then 
      s:addPointDefence(sa15)
    end
  end
  
  --SAM

  local connectionNodeEW = StaticObject.getByName('SP-Sector-Command')
  local sam = rusIADS:getSAMSiteByGroupName('RusSAM-SA11-1')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(85)
    if connectionNodeEW then
      sam:addConnectionNode(connectionNodeEW)
    end
  end
  
  rusIADS:activate()
  --end test
end