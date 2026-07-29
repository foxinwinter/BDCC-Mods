extends Module

func _init():
    id = "CheatMenu"
    author = "foxinwinter"
    gameExtenders = ["res://Modules/CheatMenu/BDCCTrackerExtender.gd"]
    scenes = ["res://Modules/CheatMenu/CheatMenuScene.gd"]

func postInit():
    Console.addCommand("cheatmenu", self, "consoleOpenCheatMenu", [], "Open the cheat menu")
    Console.addCommand("tp",        self, "consoleTeleport",      ["roomID"], "Teleport to a room")
    Console.addCommand("credits",   self, "consoleCredits",       ["amount"], "Set credits to amount")
    Console.addCommand("heal",      self, "consoleHeal",          [],         "Fully heal the player")
    Console.addCommand("giveitem",  self, "consoleGiveItem",      ["itemID", "amount"], "Give an item")

func consoleOpenCheatMenu(_args = []):
    GM.main.runScene("CheatMenuScene")
    GM.main.runCurrentScene()

func consoleTeleport(_args = []):
    if _args.size() < 1 or _args[0] == "":
        Log.print("Usage: tp <roomID>")
        return
    GM.pc.setLocation(_args[0])
    GM.world.aimCamera(_args[0], true)
    GM.main.runCurrentScene()
    Log.print("Teleported to: "+_args[0])

func consoleCredits(_args = []):
    if _args.size() < 1 or _args[0] == "":
        Log.print("Usage: credits <amount>")
        return
    var amount = int(_args[0])
    GM.pc.setCredits(amount)
    Log.print("Credits set to: "+str(amount))

func consoleHeal(_args = []):
    GM.pc.addPain(-GM.pc.painThreshold())
    GM.pc.addLust(-GM.pc.lustThreshold())
    GM.pc.addStamina(GM.pc.getMaxStamina() - GM.pc.getStamina())
    Log.print("Player healed")

func consoleGiveItem(_args = []):
    if _args.size() < 1 or _args[0] == "":
        Log.print("Usage: giveitem <itemID> [amount]")
        return
    var item = GlobalRegistry.createItem(_args[0])
    if item == null:
        Log.printerr("Unknown item: "+_args[0])
        return
    var amount = 1
    if _args.size() >= 2:
        amount = max(1, int(_args[1]))
    if item.canCombine():
        item.setAmount(amount)
    GM.pc.getInventory().addItem(item)
    Log.print("Received "+str(amount)+"x "+_args[0])
