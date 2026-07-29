extends Module

var _registeredTeleportCategories = {}
var _registeredTeleportSubAreas = {}
var _registeredRoomAliases = {}
var _modItemRegistrations = {}

func _init():
    id = "CheatMenu"
    author = "foxinwinter"
    gameExtenders = ["res://Modules/CheatMenu/BDCCTrackerExtender.gd"]
    scenes = ["res://Modules/CheatMenu/scenes/CheatMenuScene.gd"]

func registerTeleportCategory(categoryName, roomIDs):
    if not _registeredTeleportCategories.has(categoryName):
        _registeredTeleportCategories[categoryName] = []
    for rid in roomIDs:
        if not _registeredTeleportCategories[categoryName].has(rid):
            _registeredTeleportCategories[categoryName].append(rid)

func registerTeleportSubArea(areaName, subAreaName, roomIDs):
    if not _registeredTeleportSubAreas.has(areaName):
        _registeredTeleportSubAreas[areaName] = {}
    if not _registeredTeleportSubAreas[areaName].has(subAreaName):
        _registeredTeleportSubAreas[areaName][subAreaName] = []
    for rid in roomIDs:
        if not _registeredTeleportSubAreas[areaName][subAreaName].has(rid):
            _registeredTeleportSubAreas[areaName][subAreaName].append(rid)

func registerRoomAlias(roomID, alias):
    _registeredRoomAliases[roomID] = alias

func getRegisteredTeleportCategories():
    return _registeredTeleportCategories

func getRegisteredTeleportSubAreas():
    return _registeredTeleportSubAreas

func getRegisteredRoomAliases():
    return _registeredRoomAliases

func getModItemRegistrations():
    return _modItemRegistrations

func postInit():
    Console.addCommand("cheatmenu", self, "consoleOpenCheatMenu", [], "Open the cheat menu")
    Console.addCommand("tp",        self, "consoleTeleport",      ["roomID"], "Teleport to a room")
    Console.addCommand("credits",   self, "consoleCredits",       ["amount"], "Set credits to amount")
    Console.addCommand("heal",      self, "consoleHeal",          [],         "Fully heal the player")
    Console.addCommand("giveitem",  self, "consoleGiveItem",      ["itemID", "amount"], "Give an item")

func discoverModConfigs():
    var modules = GlobalRegistry.getModules()
    for modID in modules:
        var mod = modules[modID]
        if mod.id == "CheatMenu":
            continue
        var basePath = "res://Modules/" + mod.id + "/cheatMenu/"

        if mod.id == "PhoenixRising":
            var modBase = "res://Modules/" + mod.id + "/"
            Log.print("CheatMenu: testing loads for PhoenixRising:")
            var ts = load(modBase + "Module.gd")
            Log.print("CheatMenu:   Module.gd => " + str(ts != null))
            ts = load(modBase + "worldEdit.gd")
            Log.print("CheatMenu:   worldEdit.gd => " + str(ts != null))
            ts = load(modBase + "extender.gd")
            Log.print("CheatMenu:   extender.gd => " + str(ts != null))
            ts = load(basePath + "mod_info.gd")
            Log.print("CheatMenu:   cheatMenu/mod_info.gd => " + str(ts != null))
            ts = load(basePath + "locations.gd")
            Log.print("CheatMenu:   cheatMenu/locations.gd => " + str(ts != null))

        var infoPath = basePath + "mod_info.gd"
        var infoScript = load(infoPath)
        if infoScript == null or not infoScript.has_method("get_mod_info"):
            continue

        var info = infoScript.get_mod_info()
        var modName = info.get("mod_name", mod.id)

        var locPath = basePath + "locations.gd"
        var locScript = load(locPath)
        if locScript != null and locScript.has_method("get_locations"):
            var locs = locScript.get_locations()
            var subName = locs.get("sub_area_name", modName)
            var rooms = locs.get("rooms", [])
            var aliases = locs.get("aliases", {})
            if rooms.size() > 0:
                registerTeleportSubArea("Mods", subName, rooms)
                for rid in aliases:
                    registerRoomAlias(rid, aliases[rid])

        var itemPath = basePath + "items.gd"
        var itemScript = load(itemPath)
        if itemScript != null and itemScript.has_method("get_items"):
            var items = itemScript.get_items()
            for cat in items:
                if not _modItemRegistrations.has(cat):
                    _modItemRegistrations[cat] = []
                for subName in items[cat]:
                    var subItems = items[cat][subName]
                    var found = false
                    for existing in _modItemRegistrations[cat]:
                        if existing[0] == subName:
                            for itemID in subItems:
                                if not existing[1].has(itemID):
                                    existing[1].append(itemID)
                            found = true
                            break
                    if not found:
                        _modItemRegistrations[cat].append([subName, subItems.duplicate()])

        Log.print("CheatMenu: Discovered config for " + modName)

func consoleOpenCheatMenu(_args = []):
    GM.main.runScene("CheatMenuScene")
    GM.main.runCurrentScene()

func consoleTeleport(_args = []):
    if _args.size() < 1 or _args[0] == "":
        Log.print("Usage: tp <roomID>")
        return
    GM.pc.setLocation(_args[0])
    GM.world.aimCamera(_args[0], true)
    GM.main.runCurrentScene()
    Log.print("Teleported to: "+_args[0])

func consoleCredits(_args = []):
    if _args.size() < 1 or _args[0] == "":
        Log.print("Usage: credits <amount>")
        return
    var amount = int(_args[0])
    GM.pc.setCredits(amount)
    Log.print("Credits set to: "+str(amount))

func consoleHeal(_args = []):
    GM.pc.addPain(-GM.pc.painThreshold())
    GM.pc.addLust(-GM.pc.lustThreshold())
    GM.pc.addStamina(GM.pc.getMaxStamina() - GM.pc.getStamina())
    Log.print("Player healed")

func consoleGiveItem(_args = []):
    if _args.size() < 1 or _args[0] == "":
        Log.print("Usage: giveitem <itemID> [amount]")
        return
    var item = GlobalRegistry.createItem(_args[0])
    if item == null:
        Log.printerr("Unknown item: "+_args[0])
        return
    var amount = 1
    if _args.size() >= 2:
        amount = max(1, int(_args[1]))
    if item.canCombine():
        item.setAmount(amount)
    GM.pc.getInventory().addItem(item)
    Log.print("Received "+str(amount)+"x "+_args[0])
