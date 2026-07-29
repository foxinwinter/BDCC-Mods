extends SceneBase

func _init():
    sceneID = "BDCC2_TaviCommsScene"

func _run():
    if state == "":
        addCharacter("tavi")
        saynn("[i]Tavi is leaning against the captain's desk, scrolling through a datapad. She looks up when you step in.[/i]")
        saynn("[say=tavi]Hey. What's up?[/say]")
        addButton("What's the plan?", "Ask about the next move", "plan")
        addButton("Just checking in", "See how she's doing", "checkin")

    if state == "plan":
        addCharacter("tavi")
        saynn("[say=tavi]We're on Azure Cove. Nova's farm is a few klicks north. I say we take a day to scout the colony, get a feel for the place, then pay her a visit.[/say]")
        saynn("[i]She taps the datapad.[/i]")
        saynn("[say=tavi]No rush. We've got supplies, shelter, and a ship that's not on any wanted list yet. Let's use that.[/say]")
        addButton("Sounds good", "Nod and let her get back to work", "end")

    if state == "checkin":
        addCharacter("tavi")
        saynn("[say=tavi]I'm good. Better than good, actually. Never thought I'd see a real ocean again.[/say]")
        saynn("[i]She gestures vaguely at the viewport, where the curve of Azure Cove is visible.[/i]")
        saynn("[say=tavi]It's nice. Being able to breathe without someone telling you when.[/say]")
        addButton("It is", "Smile and leave her to it", "end")

func _react(_action, _args):
    if _action == "end":
        endScene()
        return
    setState(_action)
