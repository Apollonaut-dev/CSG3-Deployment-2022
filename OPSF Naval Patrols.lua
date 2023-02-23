do
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('USNS CP'):FilterOnce()
  local fleet = GROUP:FindByName('USNS Group')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(20) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('TARSAG CP'):FilterOnce()
  local fleet = GROUP:FindByName('SAG1')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(25) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('TDRSAG CP'):FilterOnce()
  local fleet = GROUP:FindByName('SAG2')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(25) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF2 CP'):FilterOnce()
  local fleet = GROUP:FindByName('Krivak-1')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    env.info('checking fleet Krivak-1')
    -- init
    if not fleet then return end
    env.info('routing fleet Krivak-1')
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF2 CP'):FilterOnce()
  local fleet = GROUP:FindByName('Grisha-1')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF2 CP'):FilterOnce()
  local fleet = GROUP:FindByName('Grisha-2')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(20) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF2 CP'):FilterOnce()
  local fleet = GROUP:FindByName('Grisha-3')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(20) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF1 CP'):FilterOnce()
  local fleet = GROUP:FindByName('SevFleet')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF3 CP'):FilterOnce()
  local fleet = GROUP:FindByName('RusConvoy-1')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF3 CP'):FilterOnce()
  local fleet = GROUP:FindByName('RusConvoy-2')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF3 CP'):FilterOnce()
  local fleet = GROUP:FindByName('RusConvoy-3')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF3 CP'):FilterOnce()
  local fleet = GROUP:FindByName('RusConvoy-4')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF3 CP'):FilterOnce()
  local fleet = GROUP:FindByName('RusConvoy-5')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF3 CP'):FilterOnce()
  local fleet = GROUP:FindByName('RusConvoy-6')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF3 CP'):FilterOnce()
  local fleet = GROUP:FindByName('RusConvoy-7')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF3 CP'):FilterOnce()
  local fleet = GROUP:FindByName('RusConvoy-8')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF3 CP'):FilterOnce()
  local fleet = GROUP:FindByName('RusConvoy-9')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('BSF3 CP'):FilterOnce()
  local fleet = GROUP:FindByName('RusConvoy-10')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(30) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(20))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60*10)
  
end