extends GameExtender

var _continueUnlocked = false

func _init():
    id = "BDCC2"

func register(_GES):
    _GES.register(self, ExtendGame.pcUpdateNonBattleEffects)

func pcUpdateNonBattleEffects(_pc):
    if _continueUnlocked:
        return
    if GM.main == null or GM.pc == null:
        return
    var hasKillEnding = GM.main.getFlag("TaviModule.Ch7KillEnding", false)
    var hasMaxCorruption = GM.main.getFlag("TaviModule.Ch6CorruptionStage", 0) >= 4
    var hasCh7Done = GM.main.getFlag("TaviModule.Ch7CaptainSceneHappened", false)
    if hasKillEnding and hasMaxCorruption and hasCh7Done:
        _continueUnlocked = true
        if GM.ui != null:
            GM.ui.updateButtons()
