do
  env.info("configuring Hound")

  Elint_blue = HoundElint:create(coalition.side.BLUE)

  Elint_blue:onScreenDebug(false)

  Elint_blue:setAtisUpdateInterval(10 * 60)

  Elint_blue:addSector("Crimean")
  Elint_blue:setZone("Crimean", "Crimean Sector")
  Elint_blue:addSector("Western")
  Elint_blue:setZone("Western", "Western Sector")
  Elint_blue:addSector("Eastern")
  Elint_blue:setZone("Eastern", "Eastern Sector")
  Elint_blue:addSector("Georgian")
  Elint_blue:setZone("Georgian", "Georgian Sector")
  Elint_blue:setTransmitter("all", "Graveley")
  Elint_blue:reportEWR('all', true)

  Elint_blue:systemOn()

  Elint_blue:useNATOCallsignes(true)

  SuperDuperMenu = missionCommands.addSubMenuForCoalition(coalition.side.BLUE, "ELINT Information")
  Elint_blue:setRadioMenuParent(SuperDuperMenu)

  --     elint:sensorAccurecy(0.5)
  local controller_Crimean = { freq = "280.100,122.100,55.100", modulation = "AM,AM,FM", gender = "male" }
  local atis_Crimean = { freq = "281.100,56.100", modulation = "AM,FM", interval = 60 }

  local controller_Western = { freq = "280.200,122.200,55.200", modulation = "AM,AM,FM", gender = "male" }
  local atis_Western = { freq = "281.200,56.200", modulation = "AM,FM", interval = 60 }
  local controller_Eastern = { freq = "280.300,122.300,55.300", modulation = "AM,AM,FM", gender = "male" }
  local atis_Eastern = { freq = "281.300,56.300", modulation = "AM,FM", interval = 60 }

  local controller_Georgian = { freq = "280.400,122.400,55.400", modulation = "AM,AM,FM", gender = "male" }
  local atis_Georgian = { freq = "281.400,56.400", modulation = "AM,FM", interval = 60 }

  Elint_blue:enableController("Crimean", controller_Crimean)
  Elint_blue:enableAtis("Crimean", atis_Crimean)
  Elint_blue:enableController("Western", controller_Western)
  Elint_blue:enableAtis("Western", atis_Western)
  Elint_blue:enableController("Eastern", controller_Eastern)
  Elint_blue:enableAtis("Eastern", atis_Eastern)
  Elint_blue:enableController("Georgian", controller_Georgian)
  Elint_blue:enableAtis("Georgian", atis_Georgian)
  Elint_blue:enableText("all")
  Elint_blue:enableNotifier("all", { freq = 280, modulation = "AM", gender = "male" })

  -- SCHEDULER:New(nil, function()
  --   Elint_blue:dumpIntelBrief()
  -- end, {}, 60 * 60, 60 * 60)

  mist.scheduleFunction(function()
    Elint_blue:dumpIntelBrief()
  end, {}, timer.getTime() + 60, 3600)

  --    Elint_blue:platformOn()
  env.info("Hound - End of config")

end
