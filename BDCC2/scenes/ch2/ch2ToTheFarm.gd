extends SceneBase

func _init():
    sceneID = "PhoenixRising_Ch2_ToTheFarm"

func _run():
    if state == "":
        GM.pc.setLocation("bdcc2_syndiship")
        aimCameraAndSetLocName("bdcc2_syndiship")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("The ramp lowers with a hydraulic hiss. Warm, salt-tinged air floods the cabin — a stark contrast to the recycled atmosphere of the ship. Beyond the opening, Azure Cove stretches under a golden afternoon sun.")
        saynn("White-and-pastel buildings cluster along a crescent shoreline. Palm-like trees with broad fronds sway in a gentle breeze. In the distance, terraced green hills rise behind the town, and the bright curve of a synthetic beach gleams at the water's edge.")
        saynn("Tavi steps past you onto the ramp, her ears perking as she takes it in.")
        saynn("[say=tavi]Huh~. Not bad for a corpo resort.. Almost makes me wanna find a private beach with you~.[/say]")
        saynn("She stretches, her tail curling behind her.")
        saynn("[say=tavi]Come on, owner~. Nova's place is on the north edge. Maybe twenty minutes on foot.. or we could take our time~.[/say]")
        addButton("Follow Tavi", "Head into the colony", "walk")

    if state == "walk":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("The two of you walk through the outskirts of the colony. The streets are clean, lined with flowering shrubs and decorative lighting. Locals pass on scooters and on foot — tourists in bright clothing, a few colonists with shopping bags, a pair of security drones humming overhead.")
        saynn("It feels surreal. After months in the prison — the grey walls, the constant tension — this place is almost aggressively peaceful.")
        saynn("Tavi seems to feel it too. She walks with her hands in her pockets, shoulders relaxed in a way you haven't seen before.")
        saynn("[say=tavi]Weird, right, cutie~? People out here just.. live. They wake up, go to work, eat dinner, go to sleep.. have sex~. No one's watching the clock for a guard to come by.. No one stopping us from doing whatever we want~.[/say]")
        addButton("It's nice", "Enjoy the moment", "nice")
        addButton("It won't last", "Stay focused", "wont_last")

    if state == "nice":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("Tavi glances at you, a soft look in her eyes.")
        saynn("[say=tavi]Yeah~. It is.. Almost makes me forget I've been dripping.. from wanting you~.[/say]")
        saynn("She bumps her shoulder against yours as you walk.")
        saynn("[say=tavi]Maybe we can have this, one day, owner~. When all the shit is over. A little place somewhere quiet. No AlphaCorp. No Syndicate. Just.. us.. and a big soft bed~.[/say]")
        addButton("I'd like that", "Smile and keep walking", "approach_farm")

    if state == "wont_last":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("Tavi's ears flatten slightly, but she doesn't argue.")
        saynn("[say=tavi]Yeah. I know.. Just let me pretend a little longer~.[/say]")
        saynn("She picks up the pace.")
        saynn("[say=tavi]Let's just.. get to Nova, cutie~. Figure out the next move before the universe reminds us we're not on vacation.. Then I can remind you what we really are~.[/say]")
        addButton("Right behind you", "Follow her toward the creamery", "approach_farm")

    if state == "approach_farm":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("The buildings thin out as you reach the northern edge of the colony. The road becomes a gravel path winding between terraced fields. Ahead, a large transparent dome catches the sunlight — a biodome, its interior lush and green.")
        saynn("A hand-painted sign hangs over the gate:")
        saynn("[center][b]Dawfort Creamery[/b][/center]")
        saynn("[center][i]Fresh milk, cheese, and cream. Ask about our petting zoo![/i][/center]")
        saynn("Tavi chuckles.")
        saynn("[say=tavi]She made a petting zoo~. Of course she did.. Maybe I should ask if she has a leash for me too~.[/say]")
        saynn("She pushes the gate open and steps inside.")
        addButton("Enter the creamery", "Follow Tavi inside", "end_scene")

func _react(_action, _args):
    if _action == "end_scene":
        GM.main.setFlag("PhoenixRising.Ch2_ToFarmDone", true)
        endScene()
        return
    setState(_action)
