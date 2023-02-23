-- require  ('C:\\Users\\antho\\Saved Games\\DCS.openbeta\\Missions\\CSG-3\\Moose_Dynamic_Loader')
-- require ('C:\\Users\\antho\\Saved Games\\DCS.openbeta\\Missions\\Moose\\DCS.lua')

-- dofile("./bin/jsDb_init.lua")
-- dofile('C:\\Users\\antho\\Saved Games\\DCS.openbeta\\Missions\\CSG-3\\Moose_Dynamic_Loader')
-- dofile('C:\\Users\\antho\\Saved Games\\DCS.openbeta\\Missions\\Moose\\DCS.lua')

-- math.randomseed(os.time())

-- TODO optimization -- minimize heap allocations/garbage collection
-- TODO incorrect usage handling -- opszones can only belong to one region
-- TODO incorrect usage warning -- Regions cannot contain zero opszones
-- TODO feature enhancement -- support helo zones
-- TODO check for and avoid heap allocations in scheduled functions
-- Region adjacency graph
local REGION_GRAPH = {}
for i=0,20 do
  REGION_GRAPH[i] = {}
  for j=0,20 do
    REGION_GRAPH[i][j] = 0
  end
end

function set_adjacent(R1, R2) 
  REGION_GRAPH[R1][R2] = 1
  REGION_GRAPH[R2][R1] = 1
end

function is_adjacent( R1, R2 )
  return REGION_GRAPH[R1][R2] == 1
end

set_adjacent(1, 2)
set_adjacent(2, 3)
set_adjacent(3, 4)
set_adjacent(3, 5)
set_adjacent(4,5)
set_adjacent(5, 6)
set_adjacent(5, 7)
set_adjacent(4, 6)
set_adjacent(4, 7)
set_adjacent(6, 7)
set_adjacent(6, 8)
set_adjacent(7, 8)
set_adjacent(8, 9)
set_adjacent(7, 9)
set_adjacent(7,10)
set_adjacent(9, 10)
set_adjacent(9, 11)
set_adjacent(10, 12)
set_adjacent(11, 12)
set_adjacent(11, 16)
set_adjacent(12, 15)
set_adjacent(12, 13)
set_adjacent(12, 15)
set_adjacent(13, 14)
set_adjacent(13, 15)
set_adjacent(15, 17)
set_adjacent(14, 17)
set_adjacent(17, 18)
set_adjacent(17, 19)
set_adjacent(18, 19)
set_adjacent(15, 16)
set_adjacent(16, 19)
set_adjacent(16, 20)
set_adjacent(19, 20)
set_adjacent(1, 0)
set_adjacent(2, 0)
set_adjacent(3, 0)
set_adjacent(4, 0)
set_adjacent(7, 0)
set_adjacent(10, 0)
set_adjacent(12, 0)
set_adjacent(13, 0)
set_adjacent(14, 0)

REGIONS = SET_ZONE:New():FilterPrefixes('Region'):FilterOnce()

-- the following refer to the same trigger zones. One is the MOOSE#ZONE wrapper only, the second is a MOOSE#OPSZONE
local STRATEGICZONES = SET_ZONE:New():FilterPrefixes('OPSZONE'):FilterOnce()
local OPSZONES = SET_ZONE:New()

-- local BorderRegions = nil
BORDERREGIONS = nil

-- should only be executed on hard-restart (reset campaign to beginning)0
function init_deployment()
  return nil
end

-- should be executed once every soft-restart (restart mission, continue from where it was left off)
function init_restart()
  env.info('init soft restart')
  -- set up relationship between OPSZONES and Regions; give them references to each other
  local opszones = STRATEGICZONES.Set
  for _, z in pairs(opszones) do -- not using MOOSE#SET_ZONE.ForEach because MOOSE FSM schedules this call 'semi-asynchronously' but this all needs to be complete before the rest of the script
    -- create OPSZONE for this trigger zone
    local ops = OPSZONE:New(z)
    OPSZONES:Add(ops)

    ops:SetDrawZone(true)
    ops:Start()
    -- find which region this opszone belongs to
    local region_subscript = string.match(z:GetName(), "OPSZONE%-(%d*)%-(%d*)")
    local region = ZONE:FindByName('Region-' .. region_subscript)
    
    if not region.opszones then
      region.opszones = {}
    end -- if reference list does not already exist
    region.opszones[z:GetName()] = ops
    z.region = region
    ops.region = region
  end
end

-- @param Region MOOSE#ZONE
-- @returns coalition.side.BLUE | coalition.side.RED | "unoccupied" | "contested"
function update_region_ownership( Region )
  -- env.info("updating region: " .. Region:GetName())
  local region = Region

  if not region.opszones then
    env.info(string.format('No opszones in region %s', region:GetName()))
    return "unoccupied"
  end

  local has_unoccupied = false
  local all_unoccupied = true
  local flag_blue_controlled = true
  local flag_red_controlled = true
  env.info('updating ownership of ' .. region:GetName())
  for _, z in pairs(region.opszones) do
    if z:GetOwner() == coalition.side.RED then
      flag_blue_controlled = false
      all_unoccupied = false
    elseif z:GetOwner() == coalition.side.BLUE then
      flag_red_controlled = false
      all_unoccupied = false
    else
      flag_blue_controlled = false
      flag_red_controlled = false
      has_unoccupied = true
    end
  end

  if flag_blue_controlled then
    return coalition.side.BLUE
  elseif flag_red_controlled then
    return coalition.side.RED
  elseif all_unoccupied then
    return "unoccupied"
  elseif has_unoccupied or (flag_red_controlled == false and flag_blue_controlled == false) then
    return "contested"
  end
end

-- TODO can do dependency injection
-- TODO make BorderEdges and BorderRegions persistent to avoid heap allocations and more garbage collection runtime
function calculate_borders()
  local BorderEdges = {}
  local BorderRegions = SET_ZONE:New()
  REGIONS:ForEach(function( R1 )
    REGIONS:ForEach(function( R2 )
      local r1 = tonumber(string.match(R1:GetName(), 'Region%-(%d*)'))
      local r2 = tonumber(string.match(R2:GetName(), 'Region%-(%d*)'))
      -- env.info(string.format('r1, r2 index: %s, %s', r1, r2))
      if not (R1 == R2) and is_adjacent(r1, r2) then
        local R1_ownership = R1.ownership -- update_region_ownership(R1)
        local R2_ownership = R2.ownership -- update_region_ownership(R2)
        -- env.info(string.format('regions %s and %s are adjacent', r1, r2))
        -- env.info(string.format('R1 ownership: %s', R1_ownership))
        -- env.info(string.format('R2 ownership: %s', R2_ownership))
        if R1_ownership ~= R2_ownership then
          table.insert(BorderEdges, { R1, R2 })
          if not BorderRegions:IsInSet(R1) then
            BorderRegions:AddZone(R1)
          end
          if not BorderRegions:IsInSet(R2) then
            BorderRegions:AddZone(R2)
          end
        end
      end
    end)
  end)
  return BorderRegions, BorderEdges
end

-- <<< START >>> --
init_restart()

-- may need to replace region state updates via polling with region state updates in response to Captured/Guarded events, i.e. OPSZONE state changes
-- event driven may not significantly enhance performance because this is all single threaded however
SCHEDULER:New(nil, function()
  local change_flag = false
  for _, r in pairs(REGIONS.Set) do
    local new_ownership = update_region_ownership(r)
    -- don't need to do anything if ownership has not changed TODO not sure about this goto, it's a little hackey but lua has no continue and this avoids nested if statements
    if new_ownership ~= r.ownership then
      r.ownership = new_ownership
      r:UndrawZone()
      change_flag = true
    end
  end
  local BorderRegions = calculate_borders()
  BORDERREGIONS = BorderRegions
  for _, r in pairs(REGIONS.Set) do
    if change_flag then
      local linetype = 1
      if BorderRegions:IsInSet(r) then
        env.info(string.format('%s is in Border Set', r:GetName()))
        linetype = 2
      end

      -- don't draw Region-0
      if r:GetName() ~= 'Region-0' then
        if r.ownership == coalition.side.BLUE then
          env.info(string.format('region %s is now owned by %s', r:GetName(), 'BLUE'))
          r:DrawZone(coalition.side.ALL, { 0, 0, 1 }, 0.5, { 0, 0, 1 }, 0.5, linetype)
        elseif r.ownership == coalition.side.RED then
          env.info(string.format('region %s is now owned by %s', r:GetName(), 'RED'))
          r:DrawZone(coalition.side.ALL, { 1, 0, 0 }, 0.5, { 1, 0, 0 }, 0.5, linetype)
        elseif r.ownership == "contested" then
          env.info(string.format('region %s is now contested', r:GetName()))
          r:DrawZone(coalition.side.ALL, { 1, 0, 1 }, 0.5, { 1, 0, 1 }, 0.5, linetype)
        elseif r.ownership == "unoccupied" then
          env.info(string.format('region %s is now unoccupied', r:GetName()))
          r:DrawZone(coalition.side.ALL, { 0, 1, 0 }, 0.5, { 0, 1, 0 }, 0.5, linetype)
        end
      end
    end
  end
end, {}, 5)

-- <<< END >>> --

local SideMissions = { 
  [1] = {
    name = "Escort VIP",
    aggressor = coalition.side.NEUTRAL,
    description = "ATTN: VIP is on a flight requiring safe passage from %% to %%. CVW-17 has been tasked with fighter-escort of the VIP aircraft. VIP will arrive in the Black Sea shortly.",
    createMission = function()
      -- TODO define spawners outside this function

        local depart = SET_ZONE:New():FilterPrefixes('M_VIP_START'):FilterOnce():GetRandom()
        local destination = SET_ZONE:New():FilterPrefixes('M_VIP_END'):FilterOnce():GetRandom()

        local VIPSpawner = SPAWN:New('T_VIP-1'):InitRandomizeTemplate({'T_VIP-1', 'T_VIP-2', 'T_VIP-3', 'T_VIP-4', 'T_VIP-5, T_VIP-6, T_VIP-7, T_VIP-8'}):SpawnInZone(depart)
        local VIPAIEscortSpawner = SPAWN:New('T_ESCORT-1'):InitRandomizeTemplate({'T_ESCORT-1', 'T_ESCORT-2', 'T_ESCORT-3'}):SpawnInZone(depart)
        VIPSpawner:OnSpawnGroup(function (g) 
          g:RouteToVec2(destination:GetVec2())
          VIPAIEscortSpawner:OnSpawnGroup(function (e) 
            local fg = FLIGHTGROUP:New(e)
            fg:AddMission(AUFTRAG:NewESCORT(g, {300, 0, -150}))
          end)
          VIPAIEscortSpawner:Spawn()
        end)
        return function() 
          VIPSpawner:Spawn()
        end
    end
  },
  [2] = {
    name = "Intercept RED HVT aircraft",
    description = "We have received Intel of a Russian HVT travelling to Iran. Intercept the aircraft and force a diversion to Turkey."
  },
  [3] = {
    name = "Anti-Ship Strike"
  },
  [4] = {
    name = "Intercept Anti-Ship Strike", 
    aggressor = coalition.side.RED, 
    description = "ATTN: We have received intel that suggests the Russians will attack one of our naval groups in the Black Sea imminently!", 
    createMission = function() 
      local navygroups = SET_GROUP:New():FilterCategories("ship"):FilterCoalitions('blue'):FilterOnce()

      if navygroups:Count() == 0 then return false end

      return function()
        env.info(string.format("RedChief dispatching antiship mission"))
        local target = navygroups:GetRandom()
        local auf = AUFTRAG:NewANTISHIP(target, 2000)
        rusChief:AddMission(auf)
      end
    end
  },
  [5] = {
    name = "DEAD Russian air defences"
  },
  [6] = {
    name = "Intercept Russian DEAD flight"
  },
  [7] = {
    name = "Frontline CAS"
  },
  [8] = {
    name = "Intercept Russian CAS",
    description = "There may be AAA and SHORAD"
  },
  [9] = {
    name = "Deep strike Russian asset"
  },
  [10] = {
    name = "Intercept Russian deep strike"
  },
  [11] = {
    name = "BARCAP for Bomber Escort",
  },
  [12] = {
    name = "Intercept enemy bombers"
  },
  [13] = {
    name = "Armed reconnaissance"
  },
  [14] = {
    name = "Intercept enemy surveillance aircraft"
  },
  [15] = {
    name = "Smuggler Intercept",
    description = "We have received intel that a civillian shipping vessel is covertly ferrying Russian special forces to Turkey. SH-60s carrying US Navy Seals have been dispatched to intercept. CVW-17 is to provide overwatch and top-cover."
  },
  [16] = {
   name = 'support blue attacking red opszone' 
  },
  [17] = {
    name = 'stop red attacking blue opszone'
  },
  [18] = {
    name = 'protect blue logistics convoy'
  },
  [19] = {
    name = 'interdict red logistics convoy'
  },
  [20] = {
    name = 'support extraction of blue special forces',
    description = 'night'
  },
  [21] = {
    name = 'inderdict red special forces',
    description = 'night'
  },
  [22] = {
    name = 'Fire & Manouvre enemy artillery groups shelling civillian targets'
  }
}

local SideMissions = { 
  [1] = {
    name = "Escort VIP",
    aggressor = coalition.side.NEUTRAL,
    description = "ATTN: VIP is on a flight requiring safe passage from %% to %%. CVW-17 has been tasked with fighter-escort of the VIP aircraft. VIP will arrive in the Black Sea shortly.",
  },
  [2] = {
    name = "Intercept RED HVT aircraft",
    description = "We have received Intel of a Russian HVT travelling to Iran. Intercept the aircraft and force a diversion to Turkey."
  },
  [3] = {
    name = "Anti-Ship Strike"
  },
  [4] = {
    name = "Intercept Anti-Ship Strike", 
    aggressor = coalition.side.RED, 
    description = "ATTN: We have received intel that suggests the Russians will attack one of our naval groups in the Black Sea imminently!", 
  },
  [5] = {
    name = "DEAD Russian air defences"
  },
  [6] = {
    name = "Intercept Russian DEAD flight"
  },
  [7] = {
    name = "Frontline CAS"
  },
  [8] = {
    name = "Intercept Russian CAS",
    description = "There may be AAA and SHORAD"
  },
  [9] = {
    name = "Deep strike Russian asset"
  },
  [10] = {
    name = "Intercept Russian deep strike"
  },
  [11] = {
    name = "BARCAP for Bomber Escort",
  },
  [12] = {
    name = "Intercept enemy bombers"
  },
  [13] = {
    name = "Armed reconnaissance"
  },
  [14] = {
    name = "Intercept enemy surveillance aircraft"
  },
  [15] = {
    name = "Smuggler Intercept",
    description = "We have received intel that a civillian shipping vessel is covertly ferrying Russian special forces to Turkey. SH-60s carrying US Navy Seals have been dispatched to intercept. CVW-17 is to provide overwatch and top-cover."
  },
  [16] = {
   name = 'support blue attacking red opszone' 
  },
  [17] = {
    name = 'stop red attacking blue opszone'
  },
  [18] = {
    name = 'protect blue logistics convoy'
  },
  [19] = {
    name = 'interdict red logistics convoy'
  },
  [20] = {
    name = 'support extraction of blue special forces',
    description = 'night'
  },
  [21] = {
    name = 'inderdict red special forces',
    description = 'night'
  }
}

-- SCHEDULER:New(nil, function( BorderRegions )
--   env.info('how many border regions')
--   env.info(BORDERREGIONS:Count())

--   local initMission = SideMissions[1]:createMission()
--   if initMission == nil then
--     env.info('could not create a side mission')
--   else
--     local description = initMission()
--     -- TODO send this to bot
--     env.info(description)
--   end
-- end, { BORDERREGIONS }, 180)


-- SideMissionGenerators = {}

-- SideMissionGenerators = {
--   [1] = {
--     description = "anti-ship strike",
--     type = "defensive",
--     generator = function(target, package_strength) end,
--     isPossible = function() return true end
--   },
--   [2] = {
--     description = "Russian logistics with fighter-escort",
--     type = "offensive",
--     generator = function(target, package_strength) end,
--     isPossible = function() return true end
--   },
--   [3] = {
--     description = "SCUD hunt with SHORAD",
--     type = "offensive",
--     generator = function(target, package_strength) end,
--     isPossible = function() return true end
--   },
--   [4] = {
--     description = "pinpoint strike on blue position",
--     type = "defensive",
--     generator = function(target, package_strength) 
--       local target = ZONE:New(target)
--       local Su24Spawner = SPAWN:New('R_Su24')
--       Su24Spawner:OnAfterSpawn(function (b) 
--         b:RouteToZone(target)
--       end)
--     end,
--     isPossible = function() return true end
--   },
--   [5] = {
--     description = "escrot reconnaissance flight",
--     type = "offensive",
--     generator = function(target, package_strength) end,
--     isPossible = function() return true end
--   },
--   [6] = {
--     description = "pinpoint strike on red position",
--     type = "offensive",
--     generator = function(target, package_strength) end,
--     isPossible = function() return true end
--   },
--   [7] = {
--     description = "anti-ship strike",
--     type = "offensive",
--     generator = function(target, package_strength) end,
--     isPossible = function() return true end
--   },
--   [8] = {
--     description = "trade blockade enforcement: escort blue vessel to intercept smuggler ship -- smugglers on RHIBs try to escape after killing blue soldiers",
--     type = "offensive",
--     generator = function(target, package_strength) end,
--     isPossible = function() return true end
--   },
--   [9] = {
--     description = "Neutralize enemy CAS/helicopter hunt",
--     type = "defensive",
--     generator = function(target, package_strength) end,
--     isPossible = function() return true end
--   },
--   [10] = {
--     description = "bombers probe defenses (very complicated to implement",
--     type = "defensive",
--     generator = function(target, package_strength) end,
--     isPossible = function() return true end
--   },
--   [11] = {
--     description = "DEAD",
--     type = "offensive",
--     generator = function(target, package_strength) end,
--     isPossible = function() return true end
--   },
--   [12] = {
--     description = "Escort of friendly commercial jet carrying VIP to Georgia",
--     type = "defensive",
--     generator = function(target, package_strength) end,
--     isPossible = function() return true end
--   },
--   [13] = {

--   }
-- }
