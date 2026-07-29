extends SceneBase

func _init():
    sceneID = "BDCC2_Ch1Launch"

func _initScene(_args = []):
    setFlag("BDCC2.phase", "launch")

func _run():
    if state == "":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("The stolen Syndicate transport hums beneath you as you settle into the co-pilot's seat. The uniform itches. The fake ID feels heavy in your pocket. Ahead, through the viewport, Themis Relay Station grows from a distant speck to a sprawling structure.")
        saynn("It's bigger than the schematic suggested. Four docking rings, bristling with antennae and sensor arrays. AlphaCorp insignias everywhere. Traffic control beacons pulse in a steady rhythm.")
        saynn("Tavi runs through the approach checklist, her movements efficient and focused. The playfulness from earlier is gone. She's in mission mode now.")
        saynn("[say=tavi]Transmitting our fake credentials to traffic control. Stand by..[/say]")
        addButton("Watch the approach", "Observe as you draw closer", "approach")

    if state == "approach":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("The comms crackle. A flat, automated voice reads out docking clearance. You're assigned to berth 3-C, public port. Tavi acknowledges and guides the ship in.")
        saynn("[say=tavi]Phase one is go. We're in.[/say]")
        saynn("The ship glides into the docking bay. Magnetic clamps engage with a heavy thud. Through the viewport you can see the station interior — clean corridors, moving walkways, AlphaCorp personnel in crisp uniforms going about their business.")
        saynn("Tavi kills the engines and turns to you.")
        saynn("[say=tavi]Alright. Remember the plan. We scout first, find the service tunnels, locate a uniform source. No heroics. Not yet.[/say]")
        saynn("She holds your gaze for a moment.")
        saynn("[say=tavi]Stay close. Stay sharp. We walk out of here with my ship and Elena's backup, or we don't walk out at all.[/say]")
        addButton("Let's move", "Step onto Themis station", "end_chapter")

    if state == "end_chapter":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("You take a breath. Then another. The airlock hisses as it cycles.")
        saynn("The door opens.")
        saynn("Themis Station stretches out before you — a maze of corridors, cameras, and guards. Somewhere in its depths, Tavi's ship waits. And somewhere in that ship, Elena's backup holds the key to everything.")
        saynn("You step forward.")
        saynn("[say=tavi]Welcome to Themis. Try not to break anything until I tell you to.[/say]")
        saynn("She flashes you a grin over her shoulder — the same reckless, infuriating, brilliant grin that's carried you this far.")
        saynn("Chapter 1 complete.")
        setFlag("BDCC2.Ch1Complete", true)
        addButton("Continue", "End chapter 1", "end_scene")

func _react(_action, _args):
    if _action == "end_scene":
        endScene()
        return
    setState(_action)
