-- VAQ132 Jammer + ELINT at Buzzer VAQ132-1
local jammerunit = Group.getByName('VAQ132-1'):getUnit(1)
local Jammer = SkynetIADSJammer:create(jammerunit, rusIADS)
Jammer:masterArmSafe(true)
Jammer:disableFor('SA-10B')
Jammer:disableFor('SA-10')
Jammer:disableFor('SA-12')
Jammer:setMaximumEffectiveDistance(100)
Jammer:masterArmOn(true)

-- VS30 ELINT Harpoon-1 and Harpoon-2
local h1 = Group.getByName('Harpoon-1'):getUnit(1)
Elint_blue:addPlatform(h1:getName())
local h2 = Group.getByName('Harpoon-2'):getUnit(1)
Elint_blue:addPlatform(h2:getName())

-- VAWDL ELINT + AWACS VAWDL-1
local u = Group.getByName('VAWDL-1'):getUnit(1)
Elint_blue:addPlatform(u:getName())

