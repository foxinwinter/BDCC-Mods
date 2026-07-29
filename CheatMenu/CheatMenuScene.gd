extends SceneBase

var cheatRooms = {
    "Cellblock": [
        "cellblock_pink_playercell",
        "cellblock_orange_nearcell", "cellblock_red_nearcell", "cellblock_lilac_nearcell",
        "solitary_cell",
    ],
    "Main Hall": [
        "hall_mainentrance", "hall_checkpoint", "hall_elevator", "hall_canteen",
        "main_hallroom1", "main_hallroom5",
        "main_bathroom1", "main_shower1", "main_shower2",
        "main_laundry", "main_punishment_spot",
    ],
    "Greenhouses": [
        "main_greenhouses", "main_green_secret",
    ],
    "Yard & Gym": [
        "yard_waterfall",
        "gym_entrance", "gym_weights", "gym_yoga", "gym_secret",
        "main_bathroom2",
    ],
    "Medical": [
        "med_lobby_start", "med_elevator",
        "medical_nursery", "medical_confessionary",
        "med_researchlab", "med_milkingroom",
        "medical_hospitalwards", "medical_storage",
        "med_mental1", "medical_paddedcell_player",
    ],
    "Engineering": [
        "eng_lobby", "eng_breakroom", "eng_workshop",
        "eng_assemblylab", "eng_storage", "eng_robotics",
        "eng_controlroom", "eng_bluespacetransmitter",
    ],
    "Mineshaft": [
        "mining_elevator", "mining_nearentrance", "mining_taviroom",
    ],
    "Command Deck": [
        "cd_elevator", "cd_captain_office",
    ],
    "Fight Club": [
        "fight_entrance", "fight_arena", "fight_slutwall",
    ],
    "Blacktail Market": [
        "market_intro", "market_market", "market_luxe",
    ],
    "Misc": [
        "intro_intakearea", "intro_shower", "intro_elevator",
    ],
}

var _roomAliases = {
    "cellblock_red_nearcell":   "Tavi's Cell",
    "cellblock_lilac_nearcell": "Vion's Cell",
    "main_hallroom5":           "Prositution",
    "main_hallroom1":           "Vendomat",
    "main_shower1":             "Dressing Room",
    "hall_elevator":            "Elevator",
    "main_greenhouses":         "Apples",
    "main_green_secret":        "Storeroom",
    "gym_secret":               "Fight Club",
    "gym_yoga":                 "Yoga",
    "gym_weights":              "Weights",
    "gym_entrance":             "Gym Entrance",
    "yard_waterfall":           "Waterfall",
    "mining_taviroom":          "Tavi's Hangout",
    "cellblock_orange_nearcell": "Rahi's Cell",
    "main_punishment_spot":     "Stocks",
    "intro_intakearea":         "Intake Area",
    "intro_shower":             "Intake Shower",
    "intro_elevator":           "Intake Elevator",
}

var _selectedArea = ""
var _selectedCategory = ""
var _selectedSubCategory = ""
var _selectedStat = ""
var _selectedSkill = ""
var _itemPage = 0

var _itemSubCategories = {
    "BDSM": [
        ["Chastity", ["ChastityCage", "ChastityCageAdvanced", "ChastityCageFlat", "ChastityCagePermanent"]],
        ["Cuffs", ["ImaginaryAnkleCuffs", "ImaginaryWristCuffs", "inmateanklecuffs", "inmatewristcuffs", "policecuffs"]],
        ["Bondage", ["ZipTiesWrist", "ZipTiesAnkle", "ropeharness", "bondagemittens"]],
        ["Plugs", ["buttplug", "vaginalplug"]],
        ["Gags", ["ballgag", "caninedildogag", "ringgag", "basketmuzzle"]],
        ["Collars", ["inmatecollar", "oldcollar"]],
    ]
}

var _hiddenItemIDs = [
    "ChastityCagePermanentNormal", "SlutwallStatic", "StocksStatic",
]

var _removedFromCategory = {
    "BDSM": ["PortalPanties", "PortalPantiesUnlocked", "Fleshlight"],
}

func _init():
    sceneID = "CheatMenuScene"

func _initScene(_args = []):
    setState("main")

func _run():
    ensureCMButton()
    say("[center][i][rainbow freq=0.3]Mod Menu[/rainbow][/i][/center]")
    say("[center][i]Scene by foxinwinter[/i][/center]")

    match state:
        "main":
            showMainMenu()
        "tp_area":
            showTeleportAreas()
        "tp_room":
            showTeleportRooms()
        "items":
            showItemCategories()
        "items_credits":
            showCreditsMenu()
        "items_category":
            showItemsInCategory()
        "items_subcat":
            showSubCategories()
        "items_subcat_items":
            showSubCategoryItems()
        "items_custom":
            showCustomItemInput()
        "stats":
            showStatList()
        "stat_detail":
            showStatDetail()
        "skills":
            showSkillList()
        "skill_detail":
            showSkillDetail()
        "utilities":
            showUtilitiesMenu()
        "player":
            showPlayerMenu()
        "player_heal":
            showPlayerHealMenu()
        "player_misc":
            showPlayerMiscMenu()
        "encounters":
            showEncountersMenu()
        "encounters_dev":
            showEncountersDevMenu()

    GM.ui.updateButtons()

func ensureCMButton():
    if GM.ui == null or not is_instance_valid(GM.ui):
        return
    if GM.ui.find_node("BDCCCheatButton", true, false) != null:
        return
    var dgBtn = GM.ui.find_node("DebugMenuButton", true, false)
    if dgBtn == null or not is_instance_valid(dgBtn):
        return
    var cheatBtn = Button.new()
    cheatBtn.name = "BDCCCheatButton"
    cheatBtn.text = "CM"
    cheatBtn.hint_tooltip = "Open Cheat Menu"
    cheatBtn.connect("pressed", self, "_openCM")
    var parent = dgBtn.get_parent()
    parent.add_child(cheatBtn)
    parent.move_child(cheatBtn, dgBtn.get_index() + 1)

func _openCM():
    GM.main.runScene("CheatMenuScene")
    GM.main.runCurrentScene()

func showMainMenu():
    addButton("Teleport",    "Move to any room",           "menu_teleport")
    addButton("Give Items",  "Spawn items into inventory", "menu_items")
    addButton("Adjust Stats","Strength/Agility/Vitality/Sexiness", "menu_stats")
    addButton("Adjust Skills","BDSM/SexSlave/CumLover/etc","menu_skills")
    addButton("Utilities",   "Sleep, time advance, character creator", "menu_utilities")
    addButton("Player",      "Healing, godmode, status effects, misc", "menu_player")
    addButton("Close",       "Close cheat menu",           "menu_close")

func showTeleportAreas():
    for area in cheatRooms.keys():
        addButton(area, "", "tp_select_area", [area])
    addButton("Back", "", "menu_main")

func showTeleportRooms():
    var rooms = cheatRooms[_selectedArea]
    for room in rooms:
        var roomInfo = GM.world.getRoomByID(room)
        var name = roomInfo.getName() if roomInfo != null else room
        if _roomAliases.has(room):
            name = _roomAliases[room]
        addButton(name, room, "tp_go", [room])
    addButton("Back", "", "tp_area")

func showItemCategories():
    var cats = getItemCategories()
    for cat in cats:
        addButton(cat, "", "item_open_cat", [cat])
    addButton("Credits", "Add credits", "menu_items_credits")
    addButton("Custom ID...", "Type any item ID", "item_custom")
    addButton("Back", "", "menu_main")

func showCreditsMenu():
    addButton("+100",  "", "item_credits", [100])
    addButton("+500",  "", "item_credits", [500])
    addButton("+1000", "", "item_credits", [1000])
    addButton("+5000", "", "item_credits", [5000])
    addButton("+10000", "", "item_credits", [10000])
    addButton("Back to items", "", "menu_items")

func getItemCategories():
    var catMap = {}
    var refs = GlobalRegistry.getItemRefs()
    for itemID in refs:
        if _hiddenItemIDs.has(itemID):
            continue
        var item = refs[itemID]
        if item == null:
            continue
        var cat = item.getItemCategory()
        if !catMap.has(cat):
            catMap[cat] = []
        catMap[cat].append(itemID)
    var sorted = catMap.keys()
    sorted.sort()
    return sorted

func getItemsForCategory(category):
    var result = []
    var refs = GlobalRegistry.getItemRefs()
    var removalList = _removedFromCategory[category] if _removedFromCategory.has(category) else []
    for itemID in refs:
        if _hiddenItemIDs.has(itemID):
            continue
        if removalList.has(itemID):
            continue
        var item = refs[itemID]
        if item == null:
            continue
        if item.getItemCategory() == category:
            result.append(itemID)
    result.sort()
    return result

func showItemsInCategory():
    var items = getItemsForCategory(_selectedCategory)
    var perPage = 12
    var totalPages = max(1, ceil(float(items.size()) / perPage))
    if _itemPage >= totalPages:
        _itemPage = totalPages - 1
    var startIdx = _itemPage * perPage
    var endIdx = min(startIdx + perPage, items.size())
    var perRow = 5
    var lastRowStart = 10
    var itemsOnPage = endIdx - startIdx
    var itemsInLastRow = max(0, itemsOnPage - lastRowStart)

    for pos in range(lastRowStart):
        if pos < itemsOnPage:
            var itemID = items[startIdx + pos]
            var item = GlobalRegistry.createItem(itemID)
            var name = itemID
            if item != null:
                name = item.getStackName()
            if name.length() > 21:
                name = name.substr(0, 18) + "..."
            addButton(name, itemID, "item_give", [itemID])
        else:
            addButton("", "", "")

    for pos in range(itemsInLastRow):
        var itemID = items[startIdx + lastRowStart + pos]
        var item = GlobalRegistry.createItem(itemID)
        var name = itemID
        if item != null:
            name = item.getStackName()
        if name.length() > 21:
            name = name.substr(0, 18) + "..."
        addButton(name, itemID, "item_give", [itemID])

    var slotsLeft = perRow - itemsInLastRow
    for j in range(slotsLeft - 3):
        addButton("", "", "")
    addButton("<< Prev", "", "item_cat_prev")
    addButton("Next >>", "", "item_cat_next")
    addButton("Back", "", "menu_items")

func showSubCategories():
    var subs = _itemSubCategories[_selectedCategory]
    for sub in subs:
        addButton(sub[0], "", "item_open_subcat", [sub[0]])
    var blanksNeeded = 5 - (subs.size() % 5) - 1
    for j in range(blanksNeeded):
        addButton("", "", "")
    addButton("Back", "", "menu_items")

func showSubCategoryItems():
    var subs = _itemSubCategories[_selectedCategory]
    var items = []
    for sub in subs:
        if sub[0] == _selectedSubCategory:
            items = sub[1]
            break
    var perPage = 12
    var totalPages = max(1, ceil(float(items.size()) / perPage))
    if _itemPage >= totalPages:
        _itemPage = totalPages - 1
    var startIdx = _itemPage * perPage
    var endIdx = min(startIdx + perPage, items.size())
    var perRow = 5
    var lastRowStart = 10
    var itemsOnPage = endIdx - startIdx
    var itemsInLastRow = max(0, itemsOnPage - lastRowStart)

    for pos in range(lastRowStart):
        if pos < itemsOnPage:
            var itemID = items[startIdx + pos]
            var item = GlobalRegistry.createItem(itemID)
            var name = itemID
            if item != null:
                name = item.getStackName()
            if name.length() > 21:
                name = name.substr(0, 18) + "..."
            addButton(name, itemID, "item_give", [itemID])
        else:
            addButton("", "", "")

    for pos in range(itemsInLastRow):
        var itemID = items[startIdx + lastRowStart + pos]
        var item = GlobalRegistry.createItem(itemID)
        var name = itemID
        if item != null:
            name = item.getStackName()
        if name.length() > 21:
            name = name.substr(0, 18) + "..."
        addButton(name, itemID, "item_give", [itemID])

    var slotsLeft = perRow - itemsInLastRow
    for j in range(slotsLeft - 3):
        addButton("", "", "")
    addButton("<< Prev", "", "item_subcat_prev")
    addButton("Next >>", "", "item_subcat_next")
    addButton("Back", "", "item_subcat_back")

func showCustomItemInput():
    addTextbox("custom_item_id")
    addButton("Submit", "Spawn the item by ID", "item_custom_submit")
    addButton("Back", "", "menu_items")

func showStatList():
    var sh = GM.pc.getSkillsHolder()
    var statsDict = GlobalRegistry.getStats()
    var sorted = statsDict.keys()
    sorted.sort()
    for statID in sorted:
        var val = sh.getBaseStat(statID)
        var statInfo = GlobalRegistry.getStat(statID)
        var name = statID
        if statInfo != null:
            name = statInfo.getVisibleName()
        addButton(name + ": " + str(val), "", "stat_open", [statID])
    addButton("+5 Levels", "", "skills_add_levels", [5])
    addButton("+10 Levels", "", "skills_add_levels", [10])
    addButton("Back", "", "menu_main")

func showStatDetail():
    var sh = GM.pc.getSkillsHolder()
    var val = sh.getBaseStat(_selectedStat)
    var statInfo = GlobalRegistry.getStat(_selectedStat)
    var name = _selectedStat
    if statInfo != null:
        name = statInfo.getVisibleName()
    addButton("+1 " + name, "", "stat_add", [_selectedStat, 1])
    addButton("+5 " + name, "", "stat_add", [_selectedStat, 5])
    addButton("+10 " + name, "", "stat_add", [_selectedStat, 10])
    addButton("-1 " + name, "", "stat_add", [_selectedStat, -1])
    addButton("-5 " + name, "", "stat_add", [_selectedStat, -5])
    addButton("Set to 0", "", "stat_add", [_selectedStat, -999])
    addButton("Back to stats", "", "menu_stats")

func showSkillList():
    var sh = GM.pc.getSkillsHolder()
    var skillsDict = GlobalRegistry.getSkills()
    var sorted = skillsDict.keys()
    sorted.sort()
    for skillID in sorted:
        sh.ensureSkillExists(skillID)
        var skill = sh.getSkill(skillID)
        var level = 0
        var name = skillID
        if skill != null:
            level = skill.getLevel()
            name = skill.getVisibleName()
        addButton(name + ": " + str(level), "", "skill_open", [skillID])
    addButton("Back", "", "menu_main")

func showSkillDetail():
    var sh = GM.pc.getSkillsHolder()
    sh.ensureSkillExists(_selectedSkill)
    var skill = sh.getSkill(_selectedSkill)
    var level = 0
    var name = _selectedSkill
    if skill != null:
        level = skill.getLevel()
        name = skill.getVisibleName()
    addButton("+1 " + name, "", "skill_set", [_selectedSkill, level + 1])
    addButton("+5 " + name, "", "skill_set", [_selectedSkill, level + 5])
    addButton("+10 " + name, "", "skill_set", [_selectedSkill, level + 10])
    addButton("+50 " + name, "", "skill_set", [_selectedSkill, level + 50])
    addButton("Set to 0", "", "skill_set", [_selectedSkill, 0])
    addButton("Back to skills", "", "menu_skills")

func showUtilitiesMenu():
    addButton("Sleep (Next Day)",   "Advance to next morning", "util_sleep")
    addButton("+2 Hours",           "Advance time by 2 hours", "util_time", [2*60*60])
    addButton("+8 Hours",           "Advance time by 8 hours", "util_time", [8*60*60])
    addButton("Open Character Creator", "Change appearance",   "util_charcreator")
    addButton("Encounters",         "Trigger slavery scenarios", "menu_encounters")
    addButton("Back", "", "menu_main")

func showEncountersMenu():
    addButton("Soft Slavery",      "Start slavery with any NPC",     "enc_soft")
    addButton("Portal Panties",    "Configure and wear Portal Panties", "enc_portalpanties")
    addButton("Dev",               "Developer tools",                "menu_encounters_dev")
    addButton("Back", "", "menu_main")

func showEncountersDevMenu():
    addButton("Anim Browser",    "Browse and test animations",     "enc_anim")
    addButton("PC Override",     "Override PC appearance",         "enc_pcoverride")
    addButton("Back", "", "menu_encounters")

func showPlayerMenu():
    addButton("Healing", "", "player_heal")
    addButton("Misc",    "", "player_misc")
    addButton("Back", "", "menu_main")

func showPlayerHealMenu():
    addButton("Full Heal",          "Heal pain, stamina, lust", "player_heal_full")
    addButton("Clear Status Effects", "Remove all negative effects", "player_status_clear")
    var ext = GlobalRegistry.getGameExtender("CheatMenu")
    var gm = ext.godmode if ext != null else false
    addButton("GodMode: " + ("ON" if gm else "OFF"), "Toggle godmode (heals all damage)", "player_godmode_toggle")
    addButton("Remove Restraints",   "", "player_unrestrain")
    addButton("Back", "", "menu_player")

func showPlayerMiscMenu():
    addButton("Reset Perks", "", "player_reset_perks")
    addButton("Reset Stats", "", "player_reset_stats")
    addButton("Back", "", "menu_player")

func removeBadStatusEffects():
    var effects = GM.pc.getStatusEffects()
    var badColor = Color(0.7, 0.1, 0.1)
    for effectID in effects:
        var effect = effects[effectID]
        if effect != null and effect.getIconColor() == badColor:
            GM.pc.removeEffect(effectID)

func _react(action, _args):
    match action:
        "menu_main":
            setState("main")
        "menu_teleport":
            setState("tp_area")
        "menu_items":
            setState("items")
        "menu_items_credits":
            setState("items_credits")
        "menu_stats":
            setState("stats")
        "menu_skills":
            setState("skills")
        "menu_utilities":
            setState("utilities")
        "menu_player":
            setState("player")
        "menu_close":
            endScene()
        "tp_select_area":
            _selectedArea = _args[0]
            setState("tp_room")
        "tp_area":
            setState("tp_area")
        "tp_go":
            doTeleport(_args[0])
        "item_open_cat":
            _selectedCategory = _args[0]
            _itemPage = 0
            if _itemSubCategories.has(_selectedCategory):
                setState("items_subcat")
            else:
                setState("items_category")
        "item_open_subcat":
            _selectedSubCategory = _args[0]
            _itemPage = 0
            setState("items_subcat_items")
        "item_subcat_prev":
            var subs = _itemSubCategories[_selectedCategory]
            var items = []
            for sub in subs:
                if sub[0] == _selectedSubCategory:
                    items = sub[1]
                    break
            var totalP = max(1, ceil(float(items.size()) / 12))
            _itemPage = totalP - 1 if _itemPage <= 0 else _itemPage - 1
            setState("items_subcat_items")
        "item_subcat_next":
            var subs = _itemSubCategories[_selectedCategory]
            var items = []
            for sub in subs:
                if sub[0] == _selectedSubCategory:
                    items = sub[1]
                    break
            var totalP = max(1, ceil(float(items.size()) / 12))
            _itemPage = 0 if _itemPage >= totalP - 1 else _itemPage + 1
            setState("items_subcat_items")
        "item_subcat_back":
            setState("items_subcat")
        "item_cat_prev":
            var catItems = getItemsForCategory(_selectedCategory)
            var totalP = max(1, ceil(float(catItems.size()) / 12))
            _itemPage = totalP - 1 if _itemPage <= 0 else _itemPage - 1
            setState("items_category")
        "item_cat_next":
            var catItems = getItemsForCategory(_selectedCategory)
            var totalP = max(1, ceil(float(catItems.size()) / 12))
            _itemPage = 0 if _itemPage >= totalP - 1 else _itemPage + 1
            setState("items_category")
        "item_custom":
            setState("items_custom")
        "item_custom_submit":
            var itemID = getTextboxData("custom_item_id")
            if itemID != null and itemID != "":
                giveItem(str(itemID))
            setState("items")
        "item_credits":
            GM.pc.addCredits(_args[0])
            addMessage("Added " + str(_args[0]) + " credits!")
        "item_give":
            giveItem(_args[0])
        "stat_open":
            _selectedStat = _args[0]
            setState("stat_detail")
        "stat_add":
            statAdd(_args[0], _args[1])
        "skill_open":
            _selectedSkill = _args[0]
            setState("skill_detail")
        "skill_set":
            skillSet(_args[0], _args[1])
        "skills_add_levels":
            var sh = GM.pc.getSkillsHolder()
            sh.setLevel(sh.getLevel() + _args[0])
            addMessage("Added " + str(_args[0]) + " levels! Free stat points: " + str(sh.getFreeStatPoints()))
            setState("stats")
        "player_heal":
            setState("player_heal")
        "player_misc":
            setState("player_misc")
        "player_heal_full":
            doHeal()
            addMessage("Fully healed!")
        "player_status_clear":
            removeBadStatusEffects()
            addMessage("Negative status effects removed!")
        "player_godmode_toggle":
            var ext = GlobalRegistry.getGameExtender("CheatMenu")
            if ext != null:
                ext.godmode = !ext.godmode
                addMessage("GodMode: " + ("ON" if ext.godmode else "OFF"))
            setState("player_heal")
        "player_unrestrain":
            GM.pc.removeAllRestraints()
            addMessage("Restraints removed!")
        "player_reset_perks":
            GM.pc.getSkillsHolder().resetPickedPerks()
            addMessage("Perks reset!")
        "player_reset_stats":
            GM.pc.getSkillsHolder().resetStats()
            addMessage("Stats reset!")
        "util_sleep":
            GM.main.startNewDay()
            addMessage("Slept until morning!")
        "util_time":
            GM.main.processTime(_args[0])
            addMessage("Time advanced!")
        "util_charcreator":
            GM.main.runScene("CharacterCreatorScene", [true])
        "menu_encounters":
            setState("encounters")
        "enc_soft":
            var psMod = GlobalRegistry.getModule("PlayerSlaveryModule")
            if psMod != null:
                GM.main.runScene(psMod.getSlaveryStartScene())
                endScene()
        "enc_portalpanties":
            var inv = GM.pc.getInventory()
            if inv == null:
                return
            var equipped = inv.getEquippedItem(InventorySlot.UnderwearBottom)
            var ppItem = null
            if equipped != null and equipped.id == "PortalPanties":
                ppItem = equipped
            else:
                var items = inv.getAllItems()
                for it in items:
                    if it.id == "PortalPanties":
                        ppItem = it
                        break
                if ppItem == null:
                    ppItem = GlobalRegistry.createItem("PortalPanties")
                    if ppItem != null:
                        inv.addItem(ppItem)
            if ppItem != null and ppItem.has_method("getUniqueID"):
                GM.main.runScene("ConfigurePantiesScene", [ppItem.getUniqueID()])
                endScene()
        "menu_encounters_dev":
            setState("encounters_dev")
        "enc_anim":
            GM.main.runScene("SimpleAnimPlayerScene")
            endScene()
        "enc_pcoverride":
            GM.main.runScene("PCOverrideExample")
            endScene()

func statAdd(statID, amount):
    var sh = GM.pc.getSkillsHolder()
    if amount == -999:
        sh.setStat(statID, 0)
        addMessage(statID + " set to 0")
    elif amount < 0:
        var newVal = max(0, sh.getBaseStat(statID) + amount)
        sh.setStat(statID, newVal)
        addMessage(statID + " -> " + str(newVal))
    else:
        var actual = min(amount, sh.getFreeStatPoints())
        sh.increaseStatIfCan(statID, actual)
        addMessage(statID + " +" + str(actual) + " (free: " + str(sh.getFreeStatPoints()) + ")")
    setState("stat_detail")

func skillSet(skillID, level):
    var sh = GM.pc.getSkillsHolder()
    sh.ensureSkillExists(skillID)
    var skill = sh.getSkill(skillID)
    if skill != null:
        skill.setLevel(level)
        addMessage(skillID + " set to " + str(level))
    setState("skill_detail")

func doTeleport(roomID):
    GM.pc.setLocation(roomID)
    GM.main.aimCameraAndSetLocName(roomID)
    endScene()

func doHeal():
    GM.pc.addPain(-GM.pc.painThreshold())
    GM.pc.addLust(-GM.pc.lustThreshold())
    GM.pc.addStamina(GM.pc.getMaxStamina() - GM.pc.getStamina())

func giveItem(itemID):
    var item = GlobalRegistry.createItem(itemID)
    if item != null:
        if item.canCombine():
            item.setAmount(1)
        GM.pc.getInventory().addItem(item)
        addMessage("Received " + item.getStackName() + "!")
    else:
        addMessage("Unknown item: " + itemID)
