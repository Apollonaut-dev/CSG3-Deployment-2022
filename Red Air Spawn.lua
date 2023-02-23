local CAPSpawner = SPAWN:New()
CAPSpawner:InitRandomizeTemplate({'T_RED_Su27', 'T_RED_Su30'})
CAPSpawner:InitLimit(10) -- 10 groups alive at once
CAPSpawner:InitRandomizeZones({ZONE:New('Zone-1'), ZONE:New('Zone-2')})

local spawn_count = 0

function CAPSpawner:OnSpawnGroup()