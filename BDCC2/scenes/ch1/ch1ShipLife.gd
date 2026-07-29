extends SceneBase

func _init():
    sceneID = "BDCC2_Ch1_ShipLife"

func _run():
    if state == "":
        GM.pc.setLocation("syndi_quarters")
        aimCameraAndSetLocName("syndi_quarters")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="tavi"})
        saynn("Two days into the journey and you're starting to learn the ship's rhythms. The engine has a particular vibration during FTL. The recycler groans every four hours. And the galley's replicator has exactly three settings: bland, burnt, and questionable.")

        saynn("Tavi is sitting on one of the bunks, a datapad in her lap, her brow furrowed.")

        saynn("[say=pc]Problem?[/say]")

        saynn("[say=tavi]Syndicate nav数据库。 It's encrypted. Not the usual kind either — this is military-grade. They didn't want anyone knowing where this ship has been.[/say]")

        saynn("[say=pc]Can you crack it?[/say]")

        saynn("She taps her chin.")

        saynn("[say=tavi]Give me an hour and a quiet room. Maybe.[/say]")

        addButton("Help her", "Lend a hand with the decryption", "help")
        addButton("Leave her to it", "Let her work and explore on your own", "explore")

    if state == "help":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="tavi"})
        saynn("You pull up a second datapad and sit beside her. She walks you through the encryption protocol — Syndicate military architecture, layered keys, recursive obfuscation. It's dense, but you pick it up faster than expected.")

        saynn("An hour passes. Then two. You work in tandem, trading observations, chasing dead ends, backtracking. When the final layer finally cracks, the log spills open — a list of Syndicate supply caches, safehouse coordinates, and ship maintenance records.")

        saynn("Tavi lets out a low whistle.")

        saynn("[say=tavi]Well. That's useful.[/say]")

        saynn("She looks at you, a glint in her eye.")

        saynn("[say=tavi]Good work. We make a decent team.[/say]")

        saynn("There's something warm in the way she says it.")

        addButton("Any time", "Smile and stretch", "end_scene")

    if state == "explore":
        saynn("You leave Tavi to her work and wander the ship. It's small — a troop transport, not a luxury cruiser — but it has everything you need.")

        saynn("The cargo hold is mostly empty, a few abandoned Syndicate crates bolted to the floor. The lower deck has a teleporter room, the machine humming with dormant power. The cockpit offers the best view — endless star-dusted void stretching in every direction.")

        saynn("When you circle back to the quarters, Tavi is exactly where you left her, datapad in hand, but there's a satisfied smirk on her face.")

        saynn("[say=tavi]Cracked it. Syndicate nav logs. Full of goodies.[/say]")

        saynn("She tosses you a ration bar from a freshly opened crate.")

        saynn("[say=tavi]Breakfast is on me.[/say]")

        addButton("Nice work", "Catch the bar and sit down", "end_scene")

func _react(_action, _args):
    if _action == "end_scene":
        GM.main.setFlag("BDCC2.Ch1_ShipLifeDone", true)
        endScene()
        return
    setState(_action)
