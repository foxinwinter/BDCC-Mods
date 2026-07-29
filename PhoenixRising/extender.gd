extends GameExtender

var _firstRun = true

func _init():
    id = "PhoenixRising"

func register(_GES):
    _GES.register(self, ExtendGame.pcUpdateNonBattleEffects)

func pcUpdateNonBattleEffects(_pc):
    if GM.main == null or GM.pc == null:
        return
    var hasKillEnding = GM.main.getFlag("TaviModule.Ch7KillEnding", false)
    var hasMaxCorruption = GM.main.getFlag("TaviModule.Ch6CorruptionStage", 0) >= 4
    var hasCh7Done = GM.main.getFlag("TaviModule.Ch7CaptainSceneHappened", false)
    if not hasKillEnding or not hasMaxCorruption or not hasCh7Done:
        return
    if _firstRun:
        _firstRun = false
        if not GM.main.getFlag("PhoenixRising.TeleportedToShip", false):
            _removeCollars()
            GM.main.setFlag("PhoenixRising.TeleportedToShip", true)
            GM.pc.setLocation("syndi_captain")
            GM.world.aimCamera("syndi_captain", true)
            GM.main.reRun()
            return

func _removeCollars():
    GM.pc.getInventory().removeItemFromSlot(InventorySlot.Neck)
    var tavi = GM.main.getCharacter("tavi")
    if tavi != null:
        tavi.getInventory().removeItemFromSlot(InventorySlot.Neck)
