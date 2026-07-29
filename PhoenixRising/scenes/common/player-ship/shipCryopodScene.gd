extends "res://Scenes/SceneBase.gd"

func _init():
    sceneID = "PhoenixRising_ShipCryopodScene"

func _run():
    if state == "":
        playAnimation(StageScene.Cryopod, "idle", {bodyState={naked=true}})

        saynn("In the corner of the room, a dusty old cryopod hums with a low idle. A layer of grime coats the glass, but the blue fluid inside still glows faintly. Looks like someone left it behind when they stripped the rest of the room.")

        saynn("You wipe the glass and check the controls. They're still operational. A label on the side reads \"Model 7 Automed — For emergency medical use only.\"")

        addButton("Use cryopod", "Strip down and let the pod do its work", "use_pod")
        addButton("Leave it", "It's probably not worth the hassle", "endthescene")

    if state == "used":
        saynn("You shed your clothes and step inside. The glass seals shut with a hiss, and the pod begins to fill with warm blue fluid. It's thick and heavy, lifting you off the floor until you're floating.")

        saynn("Tiny bubbles stream past your face. Your muscles loosen, your mind goes quiet, and you feel the familiar tingle of nanites knitting tissue and flushing out fatigue. Whoever built this thing knew what they were doing.")

        addButton("Continue", "Let the process finish", "continue1")

    if state == "done":
        playAnimation(StageScene.Sleeping, "sleep", {bodyState={naked=true}})

        saynn("Time blurs. Eventually the fluid drains, the glass unseals, and cool air hits your damp skin. You step out feeling renewed — no pain, no stiffness, just a deep sense of relief.")

        saynn("The pod's display flickers: [i]Treatment complete. Subject discharged.[/i]")

        addButton("Get dressed and leave", "Time to go", "endthescene")

func _react(_action: String, _args):
    if _action == "use_pod":
        GM.pc.afterCryopodTreatment()
        processTime(60 * 60 * 4)
        setState("used")
        return

    if _action == "continue1":
        setState("done")
        return

    if _action == "endthescene":
        endScene()
        return

    setState(_action)
