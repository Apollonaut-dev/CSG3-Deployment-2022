do
-------------------------------------------
  -------------------------------------------
  --Turkey IADS
  -------------------------------------------
  -------------------------------------------
  --
  turIADS = SkynetIADS:create('Turkey')
--
--  local iadsDebug = turIADS:getDebugSettings()
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
  
  turIADS:setUpdateInterval(60)


  turIADS:addEarlyWarningRadarsByPrefix('TurEWR')
  --rusIADS:addEarlyWarningRadarsByPrefix('rAWACS')
  turIADS:addSAMSitesByPrefix('TurSAM')

  
  turIADS:getSAMSitesByNatoName('SA-10'):setGoLiveRangeInPercent(75) 
  turIADS:getSAMSitesByNatoName('SA-12'):setGoLiveRangeInPercent(75)
  turIADS:getSAMSitesByNatoName('SA-11'):setGoLiveRangeInPercent(75)

  -- Command Center
  local CommandCenter = StaticObject.getByName('TurCommand-Center')

  if CommandCenter then
    turIADS:addCommandCenter(CommandCenter)
  end

  ------------------------------------
  --East Sector
  ------------------------------------

  -- EWR
  local ConnectionNodeEW = Unit.getByName('ECS-1')
  local rew = Unit.getByName('TurEWR-1')

  if rew then
    turIADS:getEarlyWarningRadarByUnitName('TurEWR-1'):addConnectionNode(ConnectionNodeEW)
  end

  --SAM


  local connectionNodeEW = Unit.getByName('ECS-1')
  local sam = turIADS:getSAMSiteByGroupName('TurSAM-SA10-1')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(80)
    sam:addConnectionNode(connectionNodeEW)
  end
  
  local connectionNodeEW = Unit.getByName('ECS-1')
  local sam = turIADS:getSAMSiteByGroupName('TurSAM-Hawk-3')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    sam:addConnectionNode(connectionNodeEW)
  end

  ------------------------------------
  --West Sector
  ------------------------------------

  -- EWR
  local ConnectionNodeEW = Unit.getByName('ECS-2')
  local rew = Unit.getByName('TurEWR-2')

  if rew then
    turIADS:getEarlyWarningRadarByUnitName('TurEWR-2'):addConnectionNode(ConnectionNodeEW)
  end



  
  turIADS:activate()
  
  -----------------------------------------
  -------------------------------------------
  --US IADS
  -------------------------------------------
  -------------------------------------------  

usIADS = SkynetIADS:create('US')

--  local iadsDebug = usIADS:getDebugSettings()
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
  
  usIADS:setUpdateInterval(60)


  usIADS:addEarlyWarningRadarsByPrefix('TurEWR')
  --rusIADS:addEarlyWarningRadarsByPrefix('rAWACS')
  usIADS:addSAMSitesByPrefix('usSAM')

  -- Command Center
  local CommandCenter = Unit.getByName('usSAM-Patriot-1-5')

  if CommandCenter then
    usIADS:addCommandCenter(CommandCenter)
  end
  
------------------------------------
--West Turkey
------------------------------------

  -- EWR
  local ConnectionNodeEW = Unit.getByName('usSAM-Patriot-1-6')
  local rew = Unit.getByName('TurEWR-2')

  if rew then
    usIADS:getEarlyWarningRadarByUnitName('TurEWR-2'):addConnectionNode(ConnectionNodeEW)
  end

  --sam

  local connectionNodeEW = Unit.getByName('usSAM-Patriot-1-6')
  local sam = usIADS:getSAMSiteByGroupName('usSAM-Patriot-1')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    sam:addConnectionNode(connectionNodeEW)
  end
  
  
  local connectionNodeEW = Unit.getByName('usSAM-Patriot-1-6')
  local sam = usIADS:getSAMSiteByGroupName('usSAM-NASM-1')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    sam:addConnectionNode(connectionNodeEW)
  end
  

  
  
------------------------------------
--East Turkey
------------------------------------

  -- EWR
  local ConnectionNodeEW = Unit.getByName('usSAM-Patriot-4-6')
  local rew = Unit.getByName('TurEWR-1')

  if rew then
    usIADS:getEarlyWarningRadarByUnitName('TurEWR-1'):addConnectionNode(ConnectionNodeEW)
  end

  --sam
  
  local connectionNodeEW = Unit.getByName('usSAM-Patriot-4-6')
  local sam = usIADS:getSAMSiteByGroupName('usSAM-Patriot-4')
 

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    sam:addConnectionNode(connectionNodeEW)
  end
  
  local connectionNodeEW = Unit.getByName('usSAM-Patriot-4-6')
  local sam = usIADS:getSAMSiteByGroupName('usSAM-NASM-14')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    sam:addConnectionNode(connectionNodeEW)
  end
  
  local connectionNodeEW = Unit.getByName('usSAM-Patriot-4-6')
  local sam = usIADS:getSAMSiteByGroupName('usSAM-NASM-15')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    sam:addConnectionNode(connectionNodeEW)
  end
   
 usIADS:activate()
 
 -----------------------------------------
  -------------------------------------------
  --Ukrain IADS
  -------------------------------------------
  -------------------------------------------  

ukrIADS = SkynetIADS:create('Ukraine')

--  local iadsDebug = ukrIADS:getDebugSettings()
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
  
  ukrIADS:setUpdateInterval(60)


  ukrIADS:addEarlyWarningRadarsByPrefix('ukrEWR')
  --rusIADS:addEarlyWarningRadarsByPrefix('rAWACS')
  ukrIADS:addSAMSitesByPrefix('ukrSAM')

  -- Command Center
  local CommandCenter = StaticObject.getByName('ukrCommand-Center-1')

  if CommandCenter then
    ukrIADS:addCommandCenter(CommandCenter)
  end
  
  -- EWR
  local ConnectionNodeEW = StaticObject.getByName('UkraineCNC-1')
  local rew = Unit.getByName('ukrEWR-1')

  if rew then
    ukrIADS:getEarlyWarningRadarByUnitName('ukrEWR-1'):addConnectionNode(ConnectionNodeEW)
  end
  
  local ConnectionNodeEW = StaticObject.getByName('UkraineCNC-1')
  local rew = Unit.getByName('ukrEWR-2')

  if rew then
    ukrIADS:getEarlyWarningRadarByUnitName('ukrEWR-2'):addConnectionNode(ConnectionNodeEW)
  end

  --sam

  local connectionNodeEW = StaticObject.getByName('UkraineCNC-1')
  local sam = ukrIADS:getSAMSiteByGroupName('ukrSAM-SA10-1')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    sam:addConnectionNode(connectionNodeEW)
  end
  
  local connectionNodeEW = StaticObject.getByName('UkraineCNC-1')
  local sam = ukrIADS:getSAMSiteByGroupName('ukrSAM-SA10-3')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    sam:addConnectionNode(connectionNodeEW)
  end

  
  local connectionNodeEW = StaticObject.getByName('UkraineCNC-1')
  local sam = ukrIADS:getSAMSiteByGroupName('ukrSAM-SA10-5')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    sam:addConnectionNode(connectionNodeEW)
  end
  
  local connectionNodeEW = StaticObject.getByName('UkraineCNC-1')
  local sam = ukrIADS:getSAMSiteByGroupName('ukrSAM-SA10-6')

  if sam then

    sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
    sam:setGoLiveRangeInPercent(90)
    sam:addConnectionNode(connectionNodeEW)
  end
  
    ukrIADS:activate()
  
 
end