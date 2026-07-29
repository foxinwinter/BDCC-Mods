extends Module

func _init():
    id = "BDCC2"
    author = "foxinwinter"
    gameExtenders = ["res://Modules/BDCC2/extender.gd"]
    worldEdits = ["res://Modules/BDCC2/worldEdit.gd"]
    events = [
        "res://Modules/BDCC2/events/misc/sceneBlocker.gd",
        "res://Modules/BDCC2/events/misc/endingInjector.gd",
    ]
    quests = [
        "res://Modules/BDCC2/quests/quests.gd",
    ]
    scenes = [
        "res://Modules/BDCC2/scenes/ch1/ch1MorningAfter.gd",
        "res://Modules/BDCC2/scenes/ch1/ch1ShipLife.gd",
        "res://Modules/BDCC2/scenes/ch1/ch1NightWatch.gd",
        "res://Modules/BDCC2/scenes/ch1/ch1Arrival.gd",
        "res://Modules/BDCC2/scenes/ch2/ch2ToTheFarm.gd",
        "res://Modules/BDCC2/scenes/ch2/ch2MeetNova.gd",
        "res://Modules/BDCC2/scenes/ch2/ch2RecruitNova.gd",
        "res://Modules/BDCC2/scenes/common/player-ship/taviCommsScene.gd",
        "res://Modules/BDCC2/scenes/common/player-ship/shipRestScene.gd",
        "res://Modules/BDCC2/scenes/common/player-ship/shipEatScene.gd",
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
    GlobalRegistry.registerMapFloor("SyndicateShipUpper", "res://Modules/BDCC2/world/syndicateShip/floors/upperFloor.tscn")
    GlobalRegistry.registerMapFloor("SyndicateShipLower", "res://Modules/BDCC2/world/syndicateShip/floors/lowerFloor.tscn")

func postInit():
    Console.addCommand("bdcc2", self, "consoleRunBDCC2", [], "Run a BDCC2 chapter 1 scene (morningafter, shiplife, nightwatch, arrival)")
    Console.addCommand("bdcc2flags", self, "consoleSetFlags", [], "Set flags to unlock BDCC2 content")
    Console.addCommand("bail", self, "consoleBail", [], "Return to your cell")

func consoleRunBDCC2(_args = []):
    var sceneMap = {
        "morningafter": "BDCC2_Ch1_MorningAfter",
        "shiplife": "BDCC2_Ch1_ShipLife",
        "nightwatch": "BDCC2_Ch1_NightWatch",
        "arrival": "BDCC2_Ch1_Arrival",
    }
    var scene = "BDCC2_Ch1_MorningAfter"
    if _args.size() >= 1 and _args[0] in sceneMap:
        scene = sceneMap[_args[0]]
    GM.main.runScene(scene)
    GM.main.runCurrentScene()

func consoleSetFlags(_args = []):
    GM.main.setFlag("TaviModule.Ch7KillEnding", true)
    GM.main.setFlag("TaviModule.Ch6CorruptionStage", 4)
    GM.main.setFlag("TaviModule.Ch7CaptainSceneHappened", true)
    Log.print("BDCC2: Kill ending flags set. Reload to trigger extender.")

func consoleBail(_args = []):
    var cellRoom = "cellblock_orange_playercell"
    GM.pc.setLocation(cellRoom)
    GM.world.aimCamera(cellRoom, true)
    GM.main.runCurrentScene()
    Log.print("Bailed to your cell.")
