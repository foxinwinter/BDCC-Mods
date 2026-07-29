static func build(world, floorID):
    _add_room(world, floorID, "bdcc2_syndiship", Vector2(15, 5), {
        name = "Syndicate Ship - Cockpit",
        desc = "The cockpit of the stolen Syndicate troop transport. Two worn pilot seats face a cluttered console with flickering displays. Stars streak past the viewport. Emergency tape holds one panel together. It's small, cramped, and yours.",
        icon = RoomStuff.RoomSprite.COMPUTER,
        color = RoomStuff.RoomColor.Blue,
        gridColor = RoomStuff.RoomColor.Blue,
        canN = false, canS = true, canW = false, canE = false,
    })
    _add_room(world, floorID, "syndi_corridor", Vector2(15, 6), {
        name = "Main Corridor",
        desc = "A narrow corridor runs the length of the ship. Pipes and conduits line the ceiling, some wrapped in cheap insulation. The deck plates are scuffed from countless bootprints. Hatches lead to the quarters, galley, and lower deck.",
        icon = RoomStuff.RoomSprite.NONE,
        color = RoomStuff.RoomColor.Grey,
        gridColor = RoomStuff.RoomColor.Grey,
        canN = true, canS = true, canW = true, canE = true,
    })
    _add_room(world, floorID, "syndi_quarters", Vector2(14, 6), {
        name = "Crew Quarters",
        desc = "Tightly packed bunks line the walls, four-high on each side. The bedding is military-issue synthfiber, thin and rough. Personal effects from the original crew are still scattered around — a datapad wedged between mattresses, a worn deck of cards, a half-empty bottle of cheap synth-whiskey under a pillow.",
        icon = RoomStuff.RoomSprite.BED,
        color = RoomStuff.RoomColor.Pink,
        gridColor = RoomStuff.RoomColor.Pink,
        canN = false, canS = false, canW = false, canE = true,
    })
    _add_room(world, floorID, "syndi_galley", Vector2(16, 6), {
        name = "Canteen",
        desc = "The ship's small mess area. A bolted-down table with mismatched chairs, a replicator that flickers when you use it, and a sink that drips. Cabinets rattle with ration packs and powdered nutrient supplements. The smell of stale synth-coffee lingers.",
        icon = RoomStuff.RoomSprite.CANTEEN,
        color = RoomStuff.RoomColor.Orange,
        gridColor = RoomStuff.RoomColor.Orange,
        canN = false, canS = false, canW = true, canE = false,
    })
    _add_room(world, floorID, "syndi_cargo", Vector2(15, 7), {
        name = "Cargo Hold",
        desc = "A wide, open space taking up most of the lower deck. Cargo nets secure a few scattered crates — Syndicate supplies, empty weapon racks, and a tarp-covered shape that might be a ground vehicle. The overhead lights buzz and several have burned out, leaving pools of shadow between the stacks.",
        icon = RoomStuff.RoomSprite.NONE,
        color = RoomStuff.RoomColor.Grey,
        gridColor = RoomStuff.RoomColor.Grey,
        canN = true, canS = true, canW = false, canE = true,
    })
    _add_room(world, floorID, "syndi_cargo_stairs", Vector2(16, 7), {
        name = "Cargo Stairs - Going Up",
        desc = "A narrow staircase bolted to the wall of the cargo hold, leading up into the dark. The grating hums under your weight. A sign on the railing reads: CREW UPPER DECK — AUTHORIZED PERSONNEL ONLY. This goes UP, not down.",
        icon = RoomStuff.RoomSprite.STAIRS,
        color = RoomStuff.RoomColor.Grey,
        gridColor = RoomStuff.RoomColor.Grey,
        canN = false, canS = false, canW = true, canE = false,
    })
    _add_room(world, floorID, "syndi_engine", Vector2(15, 8), {
        name = "Engine Room",
        desc = "The heart of the ship. A compact fusion reactor hums behind a reinforced cage, casting a faint blue glow across the room. Cables snake across the floor in bundles. The heat is noticeable. A diagnostic terminal beeps steadily, reporting all systems nominal.",
        icon = RoomStuff.RoomSprite.COMPUTER,
        color = RoomStuff.RoomColor.Red,
        gridColor = RoomStuff.RoomColor.Red,
        canN = true, canS = false, canW = false, canE = false,
    })
    world.addTransitions([floorID])

static func build_upper(world, floorID):
    _add_room(world, floorID, "syndi_upper_stairs", Vector2(0, 0), {
        name = "Upper Deck Stairwell",
        desc = "The top of the stairwell. A short corridor stretches ahead, dimly lit by emergency strips. The hum of the ship's engines is louder up here. A hatch to your side leads back down to the cargo hold.",
        icon = RoomStuff.RoomSprite.STAIRS,
        color = RoomStuff.RoomColor.Grey,
        gridColor = RoomStuff.RoomColor.Grey,
        canN = false, canS = true, canW = false, canE = false,
    })
    _add_room(world, floorID, "syndi_upper_teleporter", Vector2(0, 1), {
        name = "Teleporter Chamber",
        desc = "The chamber hums with contained energy. A circular platform sits in the center, ringed by four crystal conduits that pulse with a faint blue light. The air feels charged, making your hair stand on end. The platform looks intact and functional.",
        icon = RoomStuff.RoomSprite.IMPORTANT,
        color = RoomStuff.RoomColor.Blue,
        gridColor = RoomStuff.RoomColor.Blue,
        canN = true, canS = false, canW = false, canE = false,
    })
    world.addTransitions([floorID])

static func _add_room(world, floorID, roomID, pos, data):
    if world.getRoomByID(roomID) != null:
        return
    world.addRoom(floorID, roomID, pos, {
        name = data.name,
        desc = data.desc,
        icon = data.icon,
        color = data.color,
        gridColor = data.gridColor,
        canW = data.canW,
        canN = data.canN,
        canE = data.canE,
        canS = data.canS,
    })
