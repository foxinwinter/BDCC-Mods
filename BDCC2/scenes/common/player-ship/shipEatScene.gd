extends "res://Scenes/SceneBase.gd"

func _init():
    sceneID = "BDCC2_ShipEatScene"

func _run():
    if state == "":
        playAnimation(StageScene.Solo, "sit")

        saynn("You rummage through the cabinets in the ship's small mess. Ration packs, powdered supplements, and a few cans of something labeled 'protein substitute' are stacked haphazardly on the shelves.")

        saynn("The replicator flickers as you poke at its interface. A few buttons are labeled in Syndicate shorthand you don't fully understand. You mash one at random and it whirs to life, dispensing a lukewarm tray of something beige.")

        saynn("You grab a spoon from the drawer and sit down at the bolted table. It doesn't look great, but it's food.")

        addButton("Eat it", "Fuel up", "doeat")
        addButton("Not hungry", "Leave it", "donteat")

    if state == "doeat":
        saynn("You choke down the meal. It's bland and the texture is weird, but your stomach appreciates it. The replicator's attempt at coffee is even worse — bitter and vaguely chemical.")

        addButton("Continue", "Clean up and get going", "endthescene")
        GM.ES.triggerRun(Trigger.EatingInCanteen)

    if state == "donteat":
        saynn("You push the tray aside. Maybe later. You stash the ration pack back in the cabinet for another time.")

        addButton("Continue", "Leave", "endthescene")
        GM.ES.triggerRun(Trigger.EatingInCanteen)

func _react(_action: String, _args):
    if _action == "doeat":
        GM.pc.afterEatingAtCanteen()
        processTime(60 * 5)

        if(GM.ES.triggerReact(Trigger.EatingInCanteen)):
            endScene()
            return

        addMessage("You got an energy boost and don't feel as hungry anymore.")

    if _action == "endthescene":
        endScene()
        return

    setState(_action)
