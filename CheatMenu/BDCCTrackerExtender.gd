extends GameExtender

var godmode = false
var _cheatButtonAdded = false

func _init():
    id = "CheatMenu"
    Log.print("CheatMenu extender initialized")

func register(_GES:GameExtenderSystem):
    Log.print("CheatMenu extender registering hooks")
    _GES.register(self, ExtendGame.pcProcessTime)
    _GES.register(self, ExtendGame.pcProcessBattleTurn)
    _GES.register(self, ExtendGame.pcUpdateNonBattleEffects)
    Log.print("CheatMenu extender hooks registered")
    call_deferred("_ensureCheatButton")

func pcUpdateNonBattleEffects(_pc:Player):
    if _cheatButtonAdded:
        return
    call_deferred("_ensureCheatButton")

func _ensureCheatButton():
    if _cheatButtonAdded:
        return
    if GM.ui == null or not is_instance_valid(GM.ui):
        return
    if GM.ui.find_node("BDCCCheatButton", true, false) != null:
        _cheatButtonAdded = true
        return
    var dgBtn = GM.ui.find_node("DebugMenuButton", true, false)
    if dgBtn == null or not is_instance_valid(dgBtn):
        return
    var parent = dgBtn.get_parent()
    if parent == null or not is_instance_valid(parent):
        return
    var cheatBtn = Button.new()
    cheatBtn.name = "BDCCCheatButton"
    cheatBtn.text = "CM"
    cheatBtn.hint_tooltip = "Open Cheat Menu"
    cheatBtn.connect("pressed", self, "_openCM")
    parent.add_child(cheatBtn)
    parent.move_child(cheatBtn, dgBtn.get_index() + 1)
    _cheatButtonAdded = true
    Log.print("CheatMenu: cheat button added to UI")

func pcProcessTime(_pc:Player, _seconds):
    if godmode:
        healPC(_pc)

func pcProcessBattleTurn(_pc:Player):
    if godmode:
        healPC(_pc)

func _openCM():
    GM.main.runScene("CheatMenuScene")
    GM.main.runCurrentScene()

func healPC(_pc:Player):
    _pc.addPain(-_pc.painThreshold())
    _pc.addLust(-_pc.lustThreshold())
    _pc.addStamina(_pc.getMaxStamina() - _pc.getStamina())
