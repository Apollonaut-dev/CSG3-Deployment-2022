local USNS_checkpoints = SET_ZONE:New():FilterPrefixes('USNS CP'):FilterOnce()
local USNS = GROUP:FindByName('USNS Group')

local TARSAG_checkpoints = SET_ZONE:New():FilterPrefixes('TARSAG CP'):FilterOnce()
local TARSAG = GROUP:FindByName('SAG1')

local TDRSAG_checkpoints = SET_ZONE:New():FilterPrefixes('TDRSAG CP'):FilterOnce()
local TDRSAG = GROUP:FindByName('SAG2')

local BSF1_checkpoints = SET_ZONE:New():FilterPrefixes('BSF1 CP'):FilterOnce()
local BSF1 = GROUP:FindByName('SevFleet')

local BSF2_checkpoints = SET_ZONE:New():FilterPrefixes('BSF2 CP'):FilterOnce()
local BSF2 = {
  GROUP:FindByName('Krivak-1'),
  GROUP:FindByName('Grisha-1'),
  GROUP:FindByName('Grisha-2'),
  GROUP:FindByName('Grisha-3')
}

local BSF3_checkpoints = SET_ZONE:New():FilterPrefixes('BSF3 CP'):FilterOnce()
local BSF3 = { 
  GROUP:FindByName('RusConvoy-1'),
  GROUP:FindByName('RusConvoy-2'),
  GROUP:FindByName('RusConvoy-3'),
  GROUP:FindByName('RusConvoy-4'),
  GROUP:FindByName('RusConvoy-5'),
  GROUP:FindByName('RusConvoy-6'),
  GROUP:FindByName('RusConvoy-7'),
  GROUP:FindByName('RusConvoy-8'),
  GROUP:FindByName('RusConvoy-9'),
  GROUP:FindByName('RusConvoy-10')
}

SCHEDULER:New(nil, function()
  if USNS then
    if not USNS.current_checkpoint then
      USNS.current_checkpoint = USNS_checkpoints:GetRandom()
      USNS:RouteToVec2(USNS.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      USNS_checkpoints:Remove(USNS.current_checkpoint:GetName())
    elseif USNS.current_checkpoint:Get2DDistance(USNS:GetCoordinate()) < UTILS.NMToMeters(20) then
      local previous_checkpoint = USNS.current_checkpoint
      USNS.current_checkpoint = USNS_checkpoints:GetRandom()
      USNS:RouteToVec2(USNS.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      USNS_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end
  if TARSAG then
    if not TARSAG.current_checkpoint then
      TARSAG.current_checkpoint = TARSAG_checkpoints:GetRandom()
      TARSAG:RouteToVec2(TARSAG.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      TARSAG_checkpoints:Remove(TARSAG.current_checkpoint:GetName())
    elseif TARSAG.current_checkpoint:Get2DDistance(TARSAG:GetCoordinate()) < UTILS.NMToMeters(20) then
      local previous_checkpoint = TARSAG.current_checkpoint
      TARSAG.current_checkpoint = TARSAG_checkpoints:GetRandom()
      TARSAG:RouteToVec2(TARSAG.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      TARSAG_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end
  if TDRSAG then
    if not TDRSAG.current_checkpoint then
      TDRSAG.current_checkpoint = TDRSAG_checkpoints:GetRandom()
      TDRSAG:RouteToVec2(TDRSAG.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      TDRSAG_checkpoints:Remove(TDRSAG.current_checkpoint:GetName())
    elseif TDRSAG.current_checkpoint:Get2DDistance(TDRSAG:GetCoordinate()) < UTILS.NMToMeters(20) then
      local previous_checkpoint = TDRSAG.current_checkpoint
      TDRSAG.current_checkpoint = TDRSAG_checkpoints:GetRandom()
      TDRSAG:RouteToVec2(TDRSAG.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
      TDRSAG_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end
  -- if BSF1 then
  --   if not BSF1.current_checkpoint then
  --     BSF1.current_checkpoint = BSF1_checkpoints:GetRandom()
  --     BSF1:RouteToVec2(BSF1.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
  --     BSF1_checkpoints:Remove(BSF1.current_checkpoint:GetName())
  --   elseif BSF1.current_checkpoint:Get2DDistance(BSF1:GetCoordinate()) < UTILS.NMToMeters(20) then
  --     local previous_checkpoint = BSF1.current_checkpoint
  --     BSF1.current_checkpoint = BSF1_checkpoints:GetRandom()
  --     BSF1:RouteToVec2(BSF1.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
  --     BSF1_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
  --   end
  -- end
  for _, fleet in pairs(BSF2) do
    if fleet then
      if not fleet.current_checkpoint then
        fleet.current_checkpoint = BSF2_checkpoints:GetRandom()
        fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
        BSF2_checkpoints:Remove(fleet.current_checkpoint:GetName())
      elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(20) then
        local previous_checkpoint = fleet.current_checkpoint
        fleet.current_checkpoint = BSF2_checkpoints:GetRandom()
        fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
        BSF2_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
      end
    end
  end
  for _, fleet in pairs(BSF3) do
    if fleet then
      if not fleet.current_checkpoint then
        fleet.current_checkpoint = BSF3_checkpoints:GetRandom()
        fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
        BSF3_checkpoints:Remove(fleet.current_checkpoint:GetName())
      elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(20) then
        local previous_checkpoint = fleet.current_checkpoint
        fleet.current_checkpoint = BSF3_checkpoints:GetRandom()
        fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(15))
        BSF3_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
      end
    end
  end
end, {}, 60, 9000)