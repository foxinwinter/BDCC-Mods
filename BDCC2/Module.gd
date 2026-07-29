extends Module

func _init():
    id = "BDCC2"
    author = "foxinwinter"
    gameExtenders = ["res://Modules/BDCC2/BDCC2GameExtender.gd"]
    worldEdits = ["res://Modules/BDCC2/BDCC2WorldEdit.gd"]
    scenes = [
        "res://Modules/BDCC2/Scenes/Ch1/Ch1WakeUpScene.gd",
        "res://Modules/BDCC2/Scenes/Ch1/Ch1BriefingScene.gd",
        "res://Modules/BDCC2/Scenes/Ch1/Ch1PrepScene.gd",
        "res://Modules/BDCC2/Scenes/Ch1/Ch1LaunchScene.gd",
    ]

func preInit():
    GlobalRegistry.registerMapFloor("SyndicateShipUpper", "res://Modules/BDCC2/world/syndicate_ship/upper_floor.tscn")

func postInit():
    Console.addCommand("bdcc2", self, "consoleRunBDCC2", [], "Run a BDCC2 chapter 1 scene (default: wakeup; also: briefing, prep, launch)")
    Console.addCommand("bdcc2flags", self, "consoleSetFlags", [], "Set flags to unlock BDCC2 content")
    Console.addCommand("bail", self, "consoleBail", [], "Return to your cell")

func consoleRunBDCC2(_args = []):
    var sceneMap = {
        "wakeup": "BDCC2_Ch1WakeUp",
        "briefing": "BDCC2_Ch1Briefing",
        "prep": "BDCC2_Ch1Prep",
        "launch": "BDCC2_Ch1Launch",
    }
    var scene = "BDCC2_Ch1WakeUp"
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
