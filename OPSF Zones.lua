
Zone={}
-- AWACS Zones
Zone.CrowsNest   = ZONE:FindByName("CrowsNest")   --Core.Zone#ZONE
Zone.Verison   = ZONE:FindByName("Verison")   --Core.Zone#ZONE
Zone.Watchtower   = ZONE:FindByName("Watchtower")   --Core.Zone#ZONE

-- ELINT Zones
Zone.Cinderella   = ZONE:FindByName("Cinderella")   --Core.Zone#ZONE
Zone.Poison = ZONE:FindByName("Poison") --Core.Zone#ZONE
Zone.WhiteSnake = ZONE:FindByName("WhiteSnake") --Core.Zone#ZONE
Zone.SkidRow = ZONE:FindByName("SkidRow") --Core.Zone#ZONE
-- Jammer Zones
Zone.Buzzer   = ZONE:FindByName("Buzzer")   --Core.Zone#ZONE
-- Tanker Zones
Zone.Coors   = ZONE:FindByName("Coors")   --Core.Zone#ZONE
Zone.Michelob   = ZONE:FindByName("Michelob")   --Core.Zone#ZONE
--NATO Home Base Zones
Zone.Incirlik   = ZONE:FindByName("Incirlik")   --Core.Zone#ZONE
Zone.Ramstein   = ZONE:FindByName("Ramstein")   --Core.Zone#ZONE
Zone.EAFBlair   = ZONE:FindByName("EAFBlair")   --Core.Zone#ZONE
-- Misc Zones
Zone.CP1   = ZONE:FindByName("CP1")   --Core.Zone#ZONE
AllZones=SET_ZONE:New():FilterOnce()

env.info('Loaded OPSF Zones...')