extends WorldEditBase

func _init():
    id = "PhoenixRisingWorldEdit"
    isRegular = false

func apply(world):
    var ShipRooms = load("res://Modules/PhoenixRising/world/syndicateShip/rooms.gd")
    ShipRooms.build(world, "CommandDeck")
    ShipRooms.build_upper(world, "SyndicateShipUpper")
    ShipRooms.build_lower(world, "SyndicateShipLower")
    _connect_interactions(world)

func _connect_interactions(world):
    var room = null

    room = world.getRoomByID("syndi_quarters")
    if room != null:
        room.connect("onEnter", self, "_on_quarters_enter")
        room.connect("onReact", self, "_on_quarters_react")

    room = world.getRoomByID("syndi_cargo_stairs")
    if room != null:
        room.connect("onEnter", self, "_on_cargo_stairs_enter")
        room.connect("onReact", self, "_on_cargo_stairs_react")

    room = world.getRoomByID("syndi_galley")
    if room != null:
        room.connect("onEnter", self, "_on_canteen_enter")
        room.connect("onReact", self, "_on_canteen_react")

    room = world.getRoomByID("syndi_cargo_stairs_down")
    if room != null:
        room.connect("onEnter", self, "_on_cargo_stairs_down_enter")
        room.connect("onReact", self, "_on_cargo_stairs_down_react")

    room = world.getRoomByID("syndi_upper_stairs")
    if room != null:
        room.connect("onEnter", self, "_on_upper_stairs_enter")
        room.connect("onReact", self, "_on_upper_stairs_react")

    room = world.getRoomByID("syndi_lower_stairs")
    if room != null:
        room.connect("onEnter", self, "_on_lower_stairs_enter")
        room.connect("onReact", self, "_on_lower_stairs_react")

    room = world.getRoomByID("syndi_lower_hall")
    if room != null:
        room.connect("onEnter", self, "_on_lower_hall_enter")
        room.connect("onReact", self, "_on_lower_hall_react")

    room = world.getRoomByID("syndi_lower_doorway")
    if room != null:
        room.connect("onEnter", self, "_on_lower_doorway_enter")
        room.connect("onReact", self, "_on_lower_doorway_react")

    room = world.getRoomByID("syndi_shower")
    if room != null:
        room.connect("onEnter", self, "_on_shower_enter")
        room.connect("onReact", self, "_on_shower_react")

    room = world.getRoomByID("syndi_storage")
    if room != null:
        room.connect("onEnter", self, "_on_storage_enter")
        room.connect("onReact", self, "_on_storage_react")

    room = world.getRoomByID("syndi_lower_placeholder")
    if room != null:
        room.connect("onEnter", self, "_on_empty_enter")
        room.connect("onReact", self, "_on_empty_react")

    room = world.getRoomByID("syndi_captain")
    if room != null:
        room.connect("onEnter", self, "_on_captain_enter")
        room.connect("onReact", self, "_on_captain_react")

func _on_quarters_enter(room):
    room.addButton("Rest", "Lie down on an empty bunk and recover", "rest")

func _on_quarters_react(_room, key):
    if key == "rest":
        _room.runScene("PhoenixRising_ShipRestScene")

func _on_canteen_enter(room):
    room.addButton("Eat", "Scrounge up a meal from ration packs and the replicator", "eat")

func _on_canteen_react(_room, key):
    if key == "eat":
        _room.runScene("PhoenixRising_ShipEatScene")

func _on_cargo_stairs_down_enter(room):
    room.addButton("Go down", "Descend to the lower deck", "go_down")

func _on_cargo_stairs_down_react(_room, key):
    if key == "go_down":
        GM.pc.setLocation("syndi_lower_stairs")
        GM.main.reRun()

func _on_lower_stairs_enter(room):
    room.addButton("Go up", "Head back up to the cargo hold", "go_up")

func _on_lower_stairs_react(_room, key):
    if key == "go_up":
        GM.pc.setLocation("syndi_cargo")
        GM.main.reRun()

func _on_storage_enter(room):
    room.addButton("Stash", "Store or retrieve items in the locker", "stash")

func _on_storage_react(_room, key):
    if key == "stash":
        _room.runScene("PlayerStashScene")

func _on_shower_enter(room):
    room.addButton("Shower", "Use the private shower", "shower")

func _on_shower_react(_room, key):
    if key == "shower":
        _room.runScene("TakingAShowerScene")

func _on_lower_hall_enter(room):
    room.addButton("Go through doorway", "Try to open the locked door to the north", "go_doorway")

func _on_lower_hall_react(_room, key):
    if key == "go_doorway":
        if GM.pc.getInventory().hasItemID("bdcc2_lower_deck_key"):
            GM.pc.setLocation("syndi_lower_doorway")
            GM.main.reRun()
        else:
            GM.main.addMessage("The door is locked. You need a key.")

func _on_lower_doorway_enter(room):
    room.addButton("Go back", "Return to the main corridor", "go_back")

func _on_lower_doorway_react(_room, key):
    if key == "go_back":
        GM.pc.setLocation("syndi_lower_hall")
        GM.main.reRun()

func _on_empty_enter(room):
    room.addButton("Use cryopod", "Step into the old medical cryopod for healing", "use_cryopod")

func _on_empty_react(_room, key):
    if key == "use_cryopod":
        _room.runScene("PhoenixRising_ShipCryopodScene")

func _on_captain_enter(room):
    room.addButton("Rest", "Lie down on the captain's bed and recover", "rest")
    if not GM.pc.getInventory().hasItemID("bdcc2_lower_deck_key"):
        room.addButton("Search desk", "Look through the captain's desk for anything useful", "search_desk")
    var ch1complete = GM.main.getFlag("PhoenixRising.Ch1Complete", false)
    var ch2complete = GM.main.getFlag("PhoenixRising.Ch2Complete", false)
    if not ch1complete:
        room.addButton("Tavi", "Talk to Tavi about the plan", "tavi_talk")
    elif not ch2complete:
        room.addButton("Tavi", "Head to Azure Cove with Tavi", "tavi_talk")
    else:
        room.addButton("Tavi", "Chat with Tavi", "tavi_talk")

func _on_captain_react(_room, key):
    if key == "rest":
        _room.runScene("PhoenixRising_ShipRestScene")
        return
    if key == "search_desk":
        GM.pc.getInventory().addItemID("bdcc2_lower_deck_key")
        GM.main.addMessage("You found a rusted key labeled 'LOWER DECK ACCESS'.")
        return
    if key == "tavi_talk":
        var morningDone = GM.main.getFlag("PhoenixRising.Ch1_MorningDone", false)
        var shipLifeDone = GM.main.getFlag("PhoenixRising.Ch1_ShipLifeDone", false)
        var nightWatchDone = GM.main.getFlag("PhoenixRising.Ch1_NightWatchDone", false)
        var arrived = GM.main.getFlag("PhoenixRising.Ch1_ArrivalDone", false)
        if not morningDone:
            _room.runScene("PhoenixRising_Ch1_MorningAfter")
            return
        if not shipLifeDone:
            _room.runScene("PhoenixRising_Ch1_ShipLife")
            return
        if not nightWatchDone:
            _room.runScene("PhoenixRising_Ch1_NightWatch")
            return
        if not arrived:
            _room.runScene("PhoenixRising_Ch1_Arrival")
            return
        var toFarmDone = GM.main.getFlag("PhoenixRising.Ch2_ToFarmDone", false)
        var meetNovaDone = GM.main.getFlag("PhoenixRising.Ch2_MeetNovaDone", false)
        var recruitDone = GM.main.getFlag("PhoenixRising.Ch2_RecruitDone", false)
        if not toFarmDone:
            _room.runScene("PhoenixRising_Ch2_ToTheFarm")
            return
        if not meetNovaDone:
            _room.runScene("PhoenixRising_Ch2_MeetNova")
            return
        if not recruitDone:
            _room.runScene("PhoenixRising_Ch2_RecruitNova")
            return
        _room.runScene("PhoenixRising_TaviCommsScene")

func _on_cargo_stairs_enter(room):
    room.addButton("Go up", "Climb the stairs to the upper deck", "go_up")

func _on_cargo_stairs_react(_room, key):
    if key == "go_up":
        GM.pc.setLocation("syndi_upper_stairs")
        GM.main.reRun()

func _on_upper_stairs_enter(room):
    room.addButton("Go down", "Head back down to the cargo hold", "go_down")

func _on_upper_stairs_react(_room, key):
    if key == "go_down":
        GM.pc.setLocation("syndi_cargo")
        GM.main.reRun()
