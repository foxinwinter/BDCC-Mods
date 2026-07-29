extends SceneBase

func _init():
    sceneID = "BDCC2_Ch1WakeUp"

func _initScene(_args = []):
    pass

func _run():
    if state == "":
        var hasRahi = getFlag("RahiModule.rahiMile8Happened", false)
        if hasRahi:
            addCharacter("rahi")
        addCharacter("tavi", ["naked"])
        playAnimation(StageScene.Duo, "stand", {npc="tavi", npcBodyState={naked=true}})
        saynn("Your eyes open to the low hum of a ship's engines. The ceiling is wrong. The air smells different. Recycled, metallic, unfamiliar.")
        saynn("For a moment your brain tries to place you back in the cellblock. But the ache in your neck reminds you. You fell asleep on a bench. A real bench. On a real ship. A stolen one.")
        saynn("Tavi is in the pilot's seat, her tail curling lazily as she watches the stars streak by. She notices you stirring and glances back over her shoulder.")
        saynn("[say=tavi]Morning, sleepyhead~. You were out for a while.[/say]")
        saynn("You sit up slowly, rubbing your neck. The ship is small — a Syndicate troop transport. Functional. Ugly. Yours.")
        saynn("[say=pc]How long?[/say]")
        saynn("[say=tavi]Ten hours. Give or take. You needed it.[/say]")
        if hasRahi:
            saynn("A soft weight shifts against your side. Rahi is curled into a ball, her tail wrapped around her snout, still fast asleep. You carefully disentangle yourself without waking her.")
        saynn("Tavi swivels her chair to face you. Her expression shifts from playful to serious.")
        saynn("[say=tavi]We're about six hours out from Themis Relay Station. That's where my ship is.[/say]")
        saynn("[say=pc]The one with Elena's backup?[/say]")
        saynn("[say=tavi]Yeah..[/say]")
        addButton("Continue", "Listen to Tavi", "the_explanation")

    if state == "the_explanation":
        addCharacter("tavi", ["naked"])
        playAnimation(StageScene.Duo, "stand", {npc="tavi", npcBodyState={naked=true}})
        saynn("Tavi pulls up a holographic display from the ship's console. A station schematic flickers into view — rings of docked vessels, security checkpoints, the confiscated assets bay marked in red.")
        saynn("[say=tavi]Themis is an AlphaCorp relay hub. Not the biggest, not the most guarded. But it's not exactly a candy store either. My ship's been sitting in their impound bay for.. over a year now.[/say]")
        saynn("Her claw traces a path through the schematic.")
        saynn("[say=tavi]Docking permissions, guard patrols, biometric locks.. They'll have all of it. We can't just roll up and ask nicely.[/say]")
        saynn("[say=pc]So what's the plan?[/say]")
        saynn("Tavi's ears flick back. She's been thinking about this.")
        saynn("[say=tavi]The plan is we don't rush in blind. We get close, we scout, we find the weak points. Then we hit hard and fast before they know what's happening. But first.. we need to look like we belong there.[/say]")
        saynn("[say=pc]AlphaCorp uniforms?[/say]")
        saynn("[say=tavi]AlphaCorp uniforms, fake IDs, a cover story. The whole package. There's a fringe settlement a few hours off the main trade lane — Rustbreak. No questions asked, if you've got the credits.[/say]")
        saynn("She taps the console and the schematic is replaced by a nav plot.")
        saynn("[say=tavi]We stop there first. Gear up. Then we hit Themis.[/say]")
        addButton("Sounds like a plan", "Agree with Tavi", "end_scene")

func _react(_action, _args):
    if _action == "end_scene":
        endScene()
        return
    setState(_action)
