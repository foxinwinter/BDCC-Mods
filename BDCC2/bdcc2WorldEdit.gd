extends WorldEditBase

func _init():
    id = "BDCC2WorldEdit"
    isRegular = false

func apply(world):
    var ShipRooms = load("res://Modules/BDCC2/world/syndicateShip/rooms.gd")
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

    room = world.getRoomByID("syndi_shower")
    if room != null:
        room.connect("onEnter", self, "_on_shower_enter")
        room.connect("onReact", self, "_on_shower_react")

    room = world.getRoomByID("syndi_storage")
    if room != null:
        room.connect("onEnter", self, "_on_storage_enter")
        room.connect("onReact", self, "_on_storage_react")

    room = world.getRoomByID("syndi_captain")
    if room != null:
        room.connect("onEnter", self, "_on_captain_enter")
        room.connect("onReact", self, "_on_captain_react")

func _on_quarters_enter(room):
    room.addButton("Rest", "Lie down on an empty bunk and recover", "rest")

func _on_quarters_react(_room, key):
    if key == "rest":
        _room.runScene("BDCC2_ShipRestScene")

func _on_canteen_enter(room):
    room.addButton("Eat", "Scrounge up a meal from ration packs and the replicator", "eat")

func _on_canteen_react(_room, key):
    if key == "eat":
        _room.runScene("BDCC2_ShipEatScene")

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

func _on_captain_enter(room):
    var ch1complete = GM.main.getFlag("BDCC2.Ch1Complete", false)
    var ch2complete = GM.main.getFlag("BDCC2.Ch2Complete", false)
    if not ch1complete:
        room.addButton("Tavi", "Talk to Tavi about the plan", "tavi_talk")
    elif not ch2complete:
        room.addButton("Tavi", "Head to Azure Cove with Tavi", "tavi_talk")
    else:
        room.addButton("Tavi", "Chat with Tavi", "tavi_talk")

func _on_captain_react(_room, key):
    if key == "tavi_talk":
        var morningDone = GM.main.getFlag("BDCC2.Ch1_MorningDone", false)
        var shipLifeDone = GM.main.getFlag("BDCC2.Ch1_ShipLifeDone", false)
        var nightWatchDone = GM.main.getFlag("BDCC2.Ch1_NightWatchDone", false)
        var arrived = GM.main.getFlag("BDCC2.Ch1_ArrivalDone", false)
        if not morningDone:
            _room.runScene("BDCC2_Ch1_MorningAfter")
            return
        if not shipLifeDone:
            _room.runScene("BDCC2_Ch1_ShipLife")
            return
        if not nightWatchDone:
            _room.runScene("BDCC2_Ch1_NightWatch")
            return
        if not arrived:
            _room.runScene("BDCC2_Ch1_Arrival")
            return
        var toFarmDone = GM.main.getFlag("BDCC2.Ch2_ToFarmDone", false)
        var meetNovaDone = GM.main.getFlag("BDCC2.Ch2_MeetNovaDone", false)
        var recruitDone = GM.main.getFlag("BDCC2.Ch2_RecruitDone", false)
        if not toFarmDone:
            _room.runScene("BDCC2_Ch2_ToTheFarm")
            return
        if not meetNovaDone:
            _room.runScene("BDCC2_Ch2_MeetNova")
            return
        if not recruitDone:
            _room.runScene("BDCC2_Ch2_RecruitNova")
            return
        _room.runScene("BDCC2_TaviCommsScene")

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
