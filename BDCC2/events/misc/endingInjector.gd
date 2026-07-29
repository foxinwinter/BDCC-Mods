extends EventBase

func _init():
    id = "BDCC2EndingInjector"

func registerTriggers(es):
    es.addTrigger(self, Trigger.SceneAndStateHook, ["Ch7KillEndingScene", "ep_end"])
    es.addTrigger(self, Trigger.SceneAndStateHook, ["Ch7KillEndingScene", "bdcc2_continue"])

func run(_triggerID, _args):
    if not _isBDCC2Active():
        return
    var scene = GM.main.getCurrentScene()
    if scene == null or scene.sceneID != "Ch7KillEndingScene":
        return
    if _args[1] == "ep_end":
        GM.ui.addButton("Continue", "Start Broken Dreams 2", "bdcc2_continue")
    if _args[1] == "bdcc2_continue":
        var currentScene = GM.main.getCurrentScene()
        if currentScene != null:
            GM.main.setFlag("BDCC2.TeleportedToShip", true)
            GM.pc.setLocation("syndi_captain")
            GM.world.aimCamera("syndi_captain", true)
            currentScene.endScene()

func _isBDCC2Active():
    if GM.main == null:
        return false
    var hasKillEnding = GM.main.getFlag("TaviModule.Ch7KillEnding", false)
    var hasMaxCorruption = GM.main.getFlag("TaviModule.Ch6CorruptionStage", 0) >= 4
    var hasCh7Done = GM.main.getFlag("TaviModule.Ch7CaptainSceneHappened", false)
    return hasKillEnding and hasMaxCorruption and hasCh7Done
