extends EventBase

var _blocking = false

func _init():
    id = "BDCC2SceneBlocker"

func registerTriggers(es):
    es.addTrigger(self, Trigger.SceneAndStateHook, ["rahi3RahiPassOutScene", ""])

func run(_triggerID, _args):
    if _blocking:
        return
    if not _isBDCC2Active():
        return
    _blocking = true
    var currentScene = GM.main.getCurrentScene()
    if currentScene != null:
        currentScene.endScene()
    _blocking = false

func _isBDCC2Active():
    if GM.main == null:
        return false
    var hasKillEnding = GM.main.getFlag("TaviModule.Ch7KillEnding", false)
    var hasMaxCorruption = GM.main.getFlag("TaviModule.Ch6CorruptionStage", 0) >= 4
    var hasCh7Done = GM.main.getFlag("TaviModule.Ch7CaptainSceneHappened", false)
    return hasKillEnding and hasMaxCorruption and hasCh7Done
