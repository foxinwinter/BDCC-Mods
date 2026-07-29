extends WorldEditBase

func _init():
    id = "BDCC2WorldEdit"
    isRegular = false

func apply(world):
    var ShipRooms = load("res://Modules/BDCC2/world/syndicate_ship/rooms.gd")
    ShipRooms.build(world, "CommandDeck")
    ShipRooms.build_upper(world, "SyndicateShipUpper")
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

    room = world.getRoomByID("syndi_upper_stairs")
    if room != null:
        room.connect("onEnter", self, "_on_upper_stairs_enter")
        room.connect("onReact", self, "_on_upper_stairs_react")

func _on_quarters_enter(room):
    room.addButton("Rest", "Lie down on an empty bunk and recover", "rest")

func _on_quarters_react(_room, key):
    if key == "rest":
        var timePassed = 60 * 60
        GM.main.processTime(timePassed)
        GM.pc.afterRestingInBed(timePassed)
        GM.main.setRoomMemory(GM.pc.location, "You rest on an empty bunk for a while. The thin mattress is surprisingly comfortable.")
        GM.main.reRun()

func _on_canteen_enter(room):
    room.addButton("Eat", "Scrounge up a meal from ration packs and the replicator", "eat")

func _on_canteen_react(_room, key):
    if key == "eat":
        GM.pc.afterEatingAtCanteen()
        GM.main.processTime(60 * 5)
        GM.main.setRoomMemory(GM.pc.location, "You throw together a meal from the ration packs and flickering replicator. It's bland but filling.")
        GM.main.reRun()

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
