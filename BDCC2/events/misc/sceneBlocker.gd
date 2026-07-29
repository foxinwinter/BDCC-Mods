extends EventBase

func _init():
    id = "BDCC2SceneBlocker"

func registerTriggers(es):
    es.addTrigger(self, Trigger.WakeUpInCell)

func react(_triggerID, _args):
    if not _isBDCC2Active():
        return false
    if getFlag("RahiModule.rahi3SceneHappened"):
        return false
    if not getFlag("RahiModule.rahi2SceneHappened"):
        return false
    setFlag("RahiModule.rahi3SceneHappened", true)
    setFlag("RahiModule.rahi3DayHappened", GM.main.getDays())
    return true

func getPriority():
    return 6

func _isBDCC2Active():
    if GM.main == null:
        return false
    var hasKillEnding = GM.main.getFlag("TaviModule.Ch7KillEnding", false)
    var hasMaxCorruption = GM.main.getFlag("TaviModule.Ch6CorruptionStage", 0) >= 4
    var hasCh7Done = GM.main.getFlag("TaviModule.Ch7CaptainSceneHappened", false)
    return hasKillEnding and hasMaxCorruption and hasCh7Done
