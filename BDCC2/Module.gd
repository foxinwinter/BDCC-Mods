extends Module

func _init():
    id = "PhoenixRising"
    author = "foxinwinter"
    gameExtenders = ["res://Modules/PhoenixRising/extender.gd"]
    worldEdits = ["res://Modules/PhoenixRising/worldEdit.gd"]
    events = [
        "res://Modules/PhoenixRising/events/misc/sceneBlocker.gd",
        "res://Modules/PhoenixRising/events/misc/endingInjector.gd",
    ]
    items = [
        "res://Modules/PhoenixRising/items/LowerDeckKey.gd",
    ]
    quests = [
        "res://Modules/PhoenixRising/quests/quests.gd",
    ]
    scenes = [
        "res://Modules/PhoenixRising/scenes/ch1/ch1MorningAfter.gd",
        "res://Modules/PhoenixRising/scenes/ch1/ch1ShipLife.gd",
        "res://Modules/PhoenixRising/scenes/ch1/ch1NightWatch.gd",
        "res://Modules/PhoenixRising/scenes/ch1/ch1Arrival.gd",
        "res://Modules/PhoenixRising/scenes/ch2/ch2ToTheFarm.gd",
        "res://Modules/PhoenixRising/scenes/ch2/ch2MeetNova.gd",
        "res://Modules/PhoenixRising/scenes/ch2/ch2RecruitNova.gd",
        "res://Modules/PhoenixRising/scenes/common/player-ship/taviCommsScene.gd",
        "res://Modules/PhoenixRising/scenes/common/player-ship/shipRestScene.gd",
        "res://Modules/PhoenixRising/scenes/common/player-ship/shipEatScene.gd",
        "res://Modules/PhoenixRising/scenes/common/player-ship/shipCryopodScene.gd",
    ]

func getFlags():
    return {
        "TeleportedToShip": flag(FlagType.Bool),
        "Ch1Complete": flag(FlagType.Bool),
        "Ch1_MorningDone": flag(FlagType.Bool),
        "Ch1_ShipLifeDone": flag(FlagType.Bool),
        "Ch1_NightWatchDone": flag(FlagType.Bool),
        "Ch1_ArrivalDone": flag(FlagType.Bool),
        "Ch2Complete": flag(FlagType.Bool),
        "Ch2_ToFarmDone": flag(FlagType.Bool),
        "Ch2_MeetNovaDone": flag(FlagType.Bool),
        "Ch2_RecruitDone": flag(FlagType.Bool),
        "Complete": flag(FlagType.Bool),
    }

func preInit():
    GlobalRegistry.registerMapFloor("SyndicateShipUpper", "res://Modules/PhoenixRising/world/syndicateShip/floors/upperFloor.tscn")
    GlobalRegistry.registerMapFloor("SyndicateShipLower", "res://Modules/PhoenixRising/world/syndicateShip/floors/lowerFloor.tscn")

func postInit():
    Console.addCommand("phoenixrising", self, "consoleRunPhoenixRising", [], "Run a PhoenixRising chapter 1 scene (morningafter, shiplife, nightwatch, arrival)")
    Console.addCommand("phoenixrisingflags", self, "consoleSetFlags", [], "Set flags to unlock PhoenixRising content")
    Console.addCommand("bail", self, "consoleBail", [], "Return to your cell")

func consoleRunPhoenixRising(_args = []):
    GM.pc.getInventory().removeItemFromSlot(InventorySlot.Neck)
    var tavi = GM.main.getCharacter("tavi")
    if tavi != null:
        tavi.getInventory().removeItemFromSlot(InventorySlot.Neck)
    var sceneMap = {
        "morningafter": "PhoenixRising_Ch1_MorningAfter",
        "shiplife": "PhoenixRising_Ch1_ShipLife",
        "nightwatch": "PhoenixRising_Ch1_NightWatch",
        "arrival": "PhoenixRising_Ch1_Arrival",
    }
    var scene = "PhoenixRising_Ch1_MorningAfter"
    if _args.size() >= 1 and _args[0] in sceneMap:
        scene = sceneMap[_args[0]]
    GM.main.runScene(scene)
    GM.main.runCurrentScene()

func consoleSetFlags(_args = []):
    GM.main.setFlag("TaviModule.Ch7KillEnding", true)
    GM.main.setFlag("TaviModule.Ch6CorruptionStage", 4)
    GM.main.setFlag("TaviModule.Ch7CaptainSceneHappened", true)
    Log.print("PhoenixRising: Kill ending flags set. Reload to trigger extender.")

func consoleBail(_args = []):
    var cellRoom = "cellblock_orange_playercell"
    GM.pc.setLocation(cellRoom)
    GM.world.aimCamera(cellRoom, true)
    GM.main.runCurrentScene()
    Log.print("Bailed to your cell.")
