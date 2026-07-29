extends SceneBase

func _init():
    sceneID = "BDCC2_Ch1Briefing"

func _initScene(_args = []):
    setFlag("BDCC2.phase", "briefing")

func _run():
    if state == "":
        addCharacter("tavi", ["naked"])
        playAnimation(StageScene.Duo, "stand", {npc="tavi", npcBodyState={naked=true}})
        saynn("The ship drifts in low-power mode, tucked behind a chunk of debris on the outskirts of the Rustbreak asteroid field. Tavi has the station schematics pulled up on every available screen.")
        saynn("[say=tavi]Alright. Let's go over this properly.[/say]")
        saynn("She enlarges a section of the schematic — a cylindrical hub with four docking rings. The lowest ring pulses red.")
        saynn("[say=tavi]Confiscated assets bay. Section seven. My ship is here. But getting to it means going through the main hangar, a security checkpoint, a staff-only corridor, and the impound office. Three layers of ID checks, two biometric scanners, and a guard rotation of about forty minutes.[/say]")
        saynn("[say=pc]You've been studying this.[/say]")
        saynn("Tavi grins.")
        saynn("[say=tavi]I had ten hours to kill while you were drooling on my bench. What else was I supposed to do?[/say]")
        addButton("Tell me the plan", "Hear Tavi's approach", "the_plan")

    if state == "the_plan":
        addCharacter("tavi", ["naked"])
        playAnimation(StageScene.Duo, "stand", {npc="tavi", npcBodyState={naked=true}})
        saynn("Tavi pulls back to a wider view of the station.")
        saynn("[say=tavi]Phase one: we dock at the public port. No disguises yet — just two travelers looking to refuel and resupply. We scout the layout, time the patrols, and locate the service tunnels.[/say]")
        saynn("She highlights a secondary access route snaking around the main corridor.")
        saynn("[say=tavi]Phase two: we find a couple of off-duty uniforms. Laundry chutes, locker rooms, maybe a drunk guard we can borrow from. We suit up, move through the service tunnels to the impound office.[/say]")
        saynn("[say=pc]And if we're caught?[/say]")
        saynn("Tavi's smile sharpens.")
        saynn("[say=tavi]Phase three: we don't get caught. But if we do.. that's what the stolen Syndicate guns are for.[/say]")
        saynn("She leans back, tail swishing.")
        saynn("[say=tavi]Once we're in the impound bay, I hotwire the ship, you cover the door. We're out before the alarm even finishes cycling.[/say]")
        saynn("[say=pc]Sounds almost too easy.[/say]")
        saynn("[say=tavi]That's because it won't be. Something will go wrong. It always does. But we're good at adapting, aren't we~?[/say]")
        addButton("We are", "Agree and move to prep", "start_prep")
        addButton("Let's go over it again", "Review the schematics once more", "the_plan")

    if state == "start_prep":
        saynn("Tavi nods and powers down the hologram.")
        saynn("[say=tavi]Then let's get moving. Rustbreak first. We need creds, gear, and a change of clothes.[/say]")
        saynn("She stretches, her spine cracking audibly.")
        saynn("[say=tavi]I'll handle the supplies. You handle.. looking like you belong on a station, not in a cellblock.[/say]")
        saynn("She winks.")
        addButton("Let's go", "Head to Rustbreak", "end_scene")

func _react(_action, _args):
    if _action == "end_scene":
        endScene()
        return
    setState(_action)
