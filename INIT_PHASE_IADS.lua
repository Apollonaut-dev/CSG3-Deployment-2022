do
    -- this script must be later than all IADS scripts in the load file trigger order
  local rusIADS = rusIADS
  local gaIADS = gaIADS

  local RusSHORAD = SET_GROUP:New():FilterPrefixes('RusSHORAD'):FilterOnce();
  local GaSHORAD = SET_GROUP:New():FilterPrefixes('GaSHORAD'):FilterOnce();


  -- TODO FIND NEAREST COMMAND SECTOR DYNAMICALLY:
  local RusCommandSectors = {
    StaticObject.getByName('BS-Sector-Command'),
    StaticObject.getByName('AN-Sector-Command'),
    Unit.getByName('EC-Sector-Command'),
    StaticObject.getByName('SP-Sector-Command'),
    StaticObject.getByName('MV-Sector-Command'),
    StaticObject.getByName('SA-Sector-Command'),
    StaticObject.getByName('MK-Sector-Command')
  }

  local rusConnectionNodeEW = StaticObject.getByName('BS-Sector-Command')
  RusSHORAD:ForEach(function(g)
    local sam = rusIADS:getSAMSiteByGroupName(g:GetName())
    if sam then
      sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
      sam:setGoLiveRangeInPercent(100)
      sam:addConnectionNode(rusConnectionNodeEW)
    end
  end)

  local gaConnectionNodeEW = StaticObject.getByName('Kut-Sector-Command')
  GaSHORAD:ForEach(function(g)
    local sam = gaIADS:getSAMSiteByGroupName(g:GetName())
    if sam then
      sam:setEngagementZone(SkynetIADSAbstractRadarElement.GO_LIVE_WHEN_IN_KILL_ZONE)
      sam:setGoLiveRangeInPercent(100)
      sam:addConnectionNode(gaConnectionNodeEW)
    end
  end)
end
