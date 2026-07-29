extends SceneBase

func _init():
    sceneID = "PhoenixRising_TaviCommsScene"

func _run():
    if state == "":
        addCharacter("tavi")
        saynn("[i]Tavi is leaning against the captain's desk, scrolling through a datapad. She looks up when you step in.[/i]")
        saynn("[say=tavi]Hey there, owner~. Come to keep your needy pet company~?[/say]")
        addButton("What's the plan?", "Ask about the next move", "plan")
        addButton("Just checking in", "See how she's doing", "checkin")

    if state == "plan":
        addCharacter("tavi")
        saynn("[say=tavi]We're on Azure Cove, cutie~. Nova's farm is a few klicks north. I say we take a day to scout the colony, get a feel for the place.. maybe find a nice quiet spot~. Then we pay her a visit.[/say]")
        saynn("[i]She taps the datapad.[/i]")
        saynn("[say=tavi]No rush~. We've got supplies, shelter, and a ship that's not on any wanted list yet. Let's use that.. in every way possible~.[/say]")
        addButton("Sounds good", "Nod and let her get back to work", "end")

    if state == "checkin":
        addCharacter("tavi")
        saynn("[say=tavi]I'm good, owner~. Better than good, actually. Never thought I'd see a real ocean again.. Makes me wanna find a secluded cove and see what you do to me under the stars~.[/say]")
        saynn("[i]She gestures vaguely at the viewport, where the curve of Azure Cove is visible.[/i]")
        saynn("[say=tavi]It's nice~. Being able to breathe without someone telling you when.. and being able to moan as loud as I want~.[/say]")
        addButton("It is", "Smile and leave her to it", "end")

func _react(_action, _args):
    if _action == "end":
        endScene()
        return
    setState(_action)
