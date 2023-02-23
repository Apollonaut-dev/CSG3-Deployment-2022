do
  local USN_checkpoints = SET_ZONE:New():FilterPrefixes('USN CP'):FilterOnce()
  local fleet = GROUP:FindByName('CSG-3')

  local s, sid = SCHEDULER:New()

  s:Schedule(fleet, function()
    -- init
    if not fleet then return end
    if not fleet.current_checkpoint then
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(25))
      USN_checkpoints:Remove(fleet.current_checkpoint:GetName())
    elseif fleet.current_checkpoint:Get2DDistance(fleet:GetCoordinate()) < UTILS.NMToMeters(5) then
      local previous_checkpoint = fleet.current_checkpoint
      fleet.current_checkpoint = USN_checkpoints:GetRandom()
      fleet:RouteToVec2(fleet.current_checkpoint:GetVec2(), UTILS.KnotsToMps(25))
      USN_checkpoints:Add(previous_checkpoint:GetName(), previous_checkpoint)
    end
  end, {}, 0, 60)
end
