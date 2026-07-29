extends SceneBase

func _init():
    sceneID = "BDCC2_Ch1Prep"

func _run():
    if state == "":
        GM.pc.setLocation("bdcc2_syndiship")
        aimCameraAndSetLocName("bdcc2_syndiship")
        addCharacter("tavi", ["naked"])
        playAnimation(StageScene.Duo, "stand", {npc="tavi", npcBodyState={naked=true}})
        saynn("Rustbreak is exactly what you expected — a ramshackle collection of prefab habs bolted to the inside of a hollowed asteroid. The air smells of ozone, cheap synth-booze, and desperation.")
        saynn("Tavi leads you through the main thoroughfare with the confidence of someone who's been here before. She probably has.")
        saynn("[say=tavi]Keep your eyes open and your hand near your weapon. Rustbreak doesn't have laws, just suggestions.[/say]")
        saynn("She ducks into a supply depot tucked between a seedy bar and a decommissioned mining rig. The vendor is a heavyset lizard with cybernetic eyes and a bored expression.")
        addButton("Browse supplies", "Look at what's available", "supplies")

    if state == "supplies":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("The depot has a little bit of everything. Tavi moves through the aisles with practiced efficiency, grabbing items and tossing them onto the counter.")
        saynn("[say=tavi]AlphaCorp uniform replicas — cheap knock-offs but they'll pass a cursory glance. Two sets. Fake ID chips — these are good, fresh encryption. And..[/say]")
        saynn("She holds up a small silver disk.")
        saynn("[say=tavi]A universal keychip. For the impound bay door. The real ones are paired to each station, but this is a Syndicate black-market special. It'll brute-force the lock in about four minutes.[/say]")
        saynn("The vendor quotes a price. Tavi raises an eyebrow and looks at you.")
        addButton("Pay the price", "Cover the cost", "pay_full")
        addButton("Haggle", "Try to talk the price down", "haggle")

    if state == "pay_full":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        var cost = 1200
        if GM.pc.getCredits() >= cost:
            GM.pc.setCredits(GM.pc.getCredits() - cost)
            saynn("You transfer the credits. The vendor's expression doesn't change, but he pushes the goods across the counter. Tavi scoops them up with a grin.")
            saynn("[say=tavi]See? Easy. Now let's get changed.[/say]")
            GM.main.setFlag("BDCC2.hasDisguises", true)
            GM.main.setFlag("BDCC2.hasKeychip", true)
            GM.main.setFlag("BDCC2.hasFakeIDs", true)
            addButton("Head to the ship", "Get changed and debrief", "changed")
        else:
            saynn("You check your credstick. Empty. The captain's credits didn't survive the escape.")
            saynn("Tavi sighs.")
            saynn("[say=tavi]Of course. Alright. New plan. We earn it.[/say]")
            addButton("How?", "Ask what she has in mind", "earn_it")

    if state == "haggle":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("Tavi leans on the counter, her tail curling with amusement as you try to negotiate. The vendor stares at you with unblinking cybernetic eyes.")
        saynn("After a tense thirty seconds, he grunts and knocks fifteen percent off the price.")
        saynn("[say=tavi]Not bad. You're learning.[/say]")
        var cost = 1020
        if GM.pc.getCredits() >= cost:
            GM.pc.setCredits(GM.pc.getCredits() - cost)
            saynn("You transfer the reduced amount. The vendor bags the goods. Tavi claps you on the shoulder.")
            saynn("[say=tavi]Alright, team. Let's gear up.[/say]")
            GM.main.setFlag("BDCC2.hasDisguises", true)
            GM.main.setFlag("BDCC2.hasKeychip", true)
            GM.main.setFlag("BDCC2.hasFakeIDs", true)
            addButton("Head to the ship", "Get changed and debrief", "changed")
        else:
            saynn("Even with the discount, your credstick comes up short.")
            saynn("Tavi rubs her face.")
            saynn("[say=tavi]Alright. New approach. We make some quick creds.[/say]")
            addButton("How?", "Ask what she has in mind", "earn_it")

    if state == "earn_it":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("Tavi leads you out of the depot and into the dingy bar next door. The air is thick with smoke and the low murmur of dangerous conversations.")
        saynn("[say=tavi]Rustbreak always has work for people who don't ask questions. A few hours, a few jobs, and we'll have enough. Stay close, keep quiet, and let me do the talking.[/say]")
        saynn("She flashes you a reassuring smile.")
        saynn("[say=tavi]We've got this.[/say]")
        addButton("Work the jobs", "Do some odd jobs for creds", "do_jobs")

    if state == "do_jobs":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("Three hours later, you're both dirtier, smell like industrial lubricant, but your credstick has enough to cover the supplies. Tavi counts the creds with a satisfied nod.")
        saynn("[say=tavi]Told you. Now let's go buy our tickets to Themis.[/say]")
        saynn("You head back to the depot. The vendor takes the creds without comment and hands over the bag.")
        saynn("[say=tavi]Disguises, IDs, keychip. We're set.[/say]")
        GM.main.setFlag("BDCC2.hasDisguises", true)
        GM.main.setFlag("BDCC2.hasKeychip", true)
        GM.main.setFlag("BDCC2.hasFakeIDs", true)
        addButton("Head to the ship", "Get changed and debrief", "changed")

    if state == "changed":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("Back on the stolen transport, you peel off the prison-issue clothes for the first time in what feels like forever. The AlphaCorp replica uniform is stiff, clean, and smells like industrial dye — but it fits.")
        saynn("Tavi emerges from the back in her own disguise, adjusting the collar. The uniform does little to hide her figure, but the insignia and cut are convincing enough at a distance.")
        saynn("[say=tavi]Well? How do I look?[/say]")
        saynn("She strikes a pose, tail poking out from under the jacket.")
        saynn("[say=tavi]Professional. Trustworthy. Definitely not a wanted fugitive.[/say]")
        saynn("She laughs at her own joke, then tosses you a datapad with your cover identity loaded on it.")
        saynn("[say=tavi]You're technician third-class Andrea Vos. Assigned to Themis for a routine systems audit. I'm your supervisor. Don't talk to anyone who outranks us.[/say]")
        addButton("Ready when you are", "Finalize preparations", "show_prep_end")

    if state == "end_scene":
        saynn("You take a steadying breath. The uniform feels foreign, but it's a good kind of foreign. The kind that means forward momentum.")
        saynn("[say=tavi]Next stop. Themis.[/say]")
        addButton("Let's roll", "Begin the approach to Themis", "end_scene")

func _react(_action, _args):
    if _action == "show_prep_end":
        setState("end_scene")
        return
    if _action == "end_scene":
        endScene()
        return
    setState(_action)
