extends SceneBase

func _init():
    sceneID = "BDCC2_Ch1_Arrival"

func _run():
    if state == "":
        GM.pc.setLocation("bdcc2_syndiship")
        aimCameraAndSetLocName("bdcc2_syndiship")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("The third day breaks with a chime from the ship's console. A planet fills the viewport — warm blues and greens, wispy cloud bands, the glitter of orbital platforms catching the local star.")

        saynn("Azure Cove.")

        saynn("Tavi stands at the controls, her ears perked forward as she scans the approach data.")

        saynn("[say=tavi]There she is. Resort colony, population two hundred thousand. AlphaCorp nominal presence — a small consulate, nothing more. The Syndicate keeps a few agents here too, but they're subtle. It's neutral ground, more or less.[/say]")

        saynn("She zooms in on the surface. A coastal city sprawls along the edge of a turquoise sea.")

        saynn("[say=tavi]Nova's farm is on the outskirts. Dawfort Creamery. She bought a biodome with the creds AlphaCorp gave her and turned it into a retreat.[/say]")

        saynn("[say=pc]You think she'll help us?[/say]")

        saynn("Tavi considers the question carefully.")

        saynn("[say=tavi]Nova's.. practical. She's not the type to join a lost cause out of sentiment. But she owes me, and she's got no love for AlphaCorp anymore. If we can show her this is worth her while, she'll listen.[/say]")

        saynn("She turns to face you.")

        saynn("[say=tavi]We'll need more than a sob story though. We need leverage. A plan. Something that makes helping us better than ignoring us.[/say]")

        addButton("We'll figure it out", "Trust that you can convince her", "convince")
        addButton("What does she owe you?", "Ask about Nova and Tavi's history", "history")

    if state == "history":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("Tavi's ears flick back. She's quiet for a moment.")

        saynn("[say=tavi]She covered for me. Back in the prison. More than once. I was doing things I shouldn't have been — sneaking into restricted areas, hacking the systems. Nova knew. She could have turned me in, but she didn't.[/say]")

        saynn("[say=pc]Why not?[/say]")

        saynn("Tavi shrugs.")

        saynn("[say=tavi]Maybe she saw something worth protecting. Maybe she just didn't like the captain. Either way, I owe her. And Nova's the type who keeps track of debts.[/say]")

        saynn("She offers a wry smile.")

        saynn("[say=tavi]Good news is, she's not the type to hold it over you either. If we sit down and talk to her straight, she'll hear us out.[/say]")

        addButton("Alright. Let's do this.", "Prepare to land", "prepare_landing")

    if state == "convince":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("Tavi nods slowly.")

        saynn("[say=tavi]Yeah. We will.[/say]")

        saynn("She taps the console and the ship begins its descent sequence. The sky shifts from black to blue as Azure Cove's atmosphere embraces the hull.")

        saynn("[say=tavi]One thing at a time. First, we find Nova. Then we figure out the rest.[/say]")

        addButton("Let's land", "Begin the approach", "prepare_landing")

    if state == "prepare_landing":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="tavi"})
        saynn("The ship shudders gently as it cuts through the upper atmosphere. Below, the resort colony unfolds — white buildings clustered along the shoreline, green terraces climbing the hills, the bright blue dome of Nova's farm visible on the northern edge.")

        saynn("Tavi's hands move across the controls with practiced ease.")

        saynn("[say=tavi]Dropping a request for a landing pad now. Using our stolen Syndicate transponder — they'll flag it as a civilian transport. Should be enough to get us down.[/say]")

        saynn("The comms crackle. A cheerful automated voice grants clearance for landing zone Delta-3.")

        saynn("Tavi glances at you, a spark of anticipation in her eyes.")

        saynn("[say=tavi]Welcome to Azure Cove. Try not to start any riots.[/say]")

        saynn("She grins.")

        saynn("[say=tavi]At least, not until I tell you to.[/say]")

        addButton("End Chapter 1", "Touch down on Azure Cove", "end_chapter")

    if state == "end_chapter":
        saynn("The landing gear engages with a solid thud. The engines wind down. Through the viewport, you can see the colony stretching out in the afternoon sun — palm-like trees, pastel buildings, the glint of a synthetic ocean.")

        saynn("Somewhere out there, Nova is waiting. And your next move begins.")

        saynn("[b]End of Chapter 1.[/b]")

        GM.main.setFlag("BDCC2.Ch1_ArrivalDone", true)
        GM.main.setFlag("BDCC2.Ch1Complete", true)
        addButton("Continue", "Step onto Azure Cove", "end_scene")

func _react(_action, _args):
    if _action == "end_scene":
        endScene()
        return
    setState(_action)
