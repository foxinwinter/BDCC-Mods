extends SceneBase

func _init():
    sceneID = "PhoenixRising_Ch1_MorningAfter"

func _run():
    if state == "":
        GM.pc.setLocation("bdcc2_syndiship")
        aimCameraAndSetLocName("bdcc2_syndiship")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("Your eyes open to the low hum of a ship's engines. The ceiling is wrong. The air smells different. Recycled, metallic, unfamiliar.")

        saynn("For a moment your brain tries to place you back in the cellblock. But the ache in your neck reminds you. You fell asleep on a bench. On a real ship. A stolen one.")

        saynn("Tavi is in the pilot's seat, her tail curling lazily as she watches the stars streak by. She notices you stirring and glances back.")

        saynn("[say=tavi]Morning, sleepyhead~. You were out for a while.. I missed having you watch me~.[/say]")

        saynn("You sit up slowly, rubbing your neck.")

        saynn("[say=pc]How long?[/say]")

        saynn("[say=tavi]Ten hours. Give or take. You needed it.. I almost started touching myself to pass the time~.[/say]")

        saynn("She swivels her chair to face you.")

        saynn("[say=tavi]We're in the clear, cutie~. No pursuit. No alerts. Syndicate's too busy fighting AlphaCorp over the prison to care about one missing transport.. or what we get up to on it~.[/say]")

        saynn("[say=pc]So what now?[/say]")

        saynn("Tavi's ears flick back. She's been thinking about this.")

        saynn("[say=tavi]We need allies. Resources. A real plan~. I've got a name — someone who owes me. Used to be AlphaCorp. Got out. Set up shop on a resort colony called Azure Cove.[/say]")

        saynn("[say=pc]Who?[/say]")

        saynn("[say=tavi]Nova~. She was a guard back at BDCC. But she's not like the others. She helped me more than once. When the shooting started, she held the medical wing instead of hunting inmates. AlphaCorp gave her a medal and enough creds to disappear.. Lucky her~.[/say]")

        saynn("Tavi pulls up a nav plot on the display. A blue dot pulses at the edge of the sector.")

        saynn("[say=tavi]Azure Cove~. Three days at current speed. If anyone's worth bringing into this, it's her.. Gives us plenty of time to.. bond~.[/say]")

        addButton("Set course", "Head for Azure Cove", "set_course")

    if state == "set_course":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("Tavi taps the console. The ship's engines hum as it adjusts course.")

        saynn("[say=tavi]Course locked~. We'll have time to.. rest. Repair. And figure out our approach.. in more ways than one~.[/say]")

        saynn("She stretches, her spine cracking audibly.")

        saynn("[say=tavi]Make yourself at home, owner~. It's not much, but it's ours now.. And I plan on making it feel real nice~.[/say]")

        saynn("She offers you a small, genuine smile. For a moment, the weight of everything — the prison, the captain, the escape — seems to lift.")

        addButton("Explore the ship", "Get familiar with your new home", "end_scene")

func _react(_action, _args):
    if _action == "end_scene":
        GM.main.setFlag("PhoenixRising.Ch1_MorningDone", true)
        endScene()
        return
    setState(_action)
