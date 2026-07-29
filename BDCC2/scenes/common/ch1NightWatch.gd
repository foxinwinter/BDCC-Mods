extends SceneBase

func _init():
    sceneID = "BDCC2_Ch1_NightWatch"

func _run():
    if state == "":
        GM.pc.setLocation("bdcc2_syndiship")
        aimCameraAndSetLocName("bdcc2_syndiship")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="tavi", npcAction="sit"})
        saynn("The ship's internal clock says 02:00. You couldn't sleep. When you pad into the cockpit, you find Tavi already there, curled in the pilot's seat with a cup of something steaming, watching the stars.")

        saynn("The lights are dimmed. The only glow comes from the console displays and the distant light of a nebula bleeding across the viewport.")

        saynn("She doesn't turn when you enter.")

        saynn("[say=tavi]Can't sleep either?[/say]")

        saynn("[say=pc]Too much on my mind.[/say]")

        saynn("She nods slowly. Her tail curls and uncurls in her lap.")

        saynn("[say=tavi]It's weird, isn't it? Being free. I keep waiting for someone to tap my shoulder and tell me it's time for count.[/say]")

        addButton("Join her", "Sit beside her and talk", "sit_talk")

    if state == "sit_talk":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="tavi", npcAction="sit"})
        saynn("You grab a seat beside her. The ship hums around you. For a long moment, neither of you speaks.")

        saynn("Then Tavi's voice comes, softer than you've heard it.")

        saynn("[say=tavi]I never thought I'd make it out. Not really. I told myself I would, I planned for it, but.. deep down I figured that place was where I'd end. One way or another.[/say]")

        saynn("She takes a sip of her drink.")

        saynn("[say=tavi]And now I'm here. In space. On a stolen ship. With someone who actually gives a shit whether I live or die.[/say]")

        saynn("Her ears flatten slightly.")

        saynn("[say=tavi]Don't know what to do with that.[/say]")

        addButton("That's what partners are for", "Reassure her", "partners")
        addButton("I always give a shit", "A lighter response", "tease")

    if state == "partners":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="tavi", npcAction="sit"})
        saynn("Tavi looks at you. Really looks. Her red-green eyes catch the starlight.")

        saynn("[say=tavi]Partners, huh?[/say]")

        saynn("[say=pc]That's what we've been this whole time, isn't it?[/say]")

        saynn("A pause. Then her tail wraps loosely around your wrist.")

        saynn("[say=tavi]Yeah. I guess it is.[/say]")

        saynn("She doesn't pull away. Neither do you.")

        addButton("Stay a while", "Sit with her until the stars blur", "end_scene")

    if state == "tease":
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="tavi", npcAction="sit"})
        saynn("Tavi snorts, nearly choking on her drink.")

        saynn("[say=tavi]Careful. Someone might think you've got a heart under all that attitude.[/say]")

        saynn("She nudges you with her elbow, but there's a softness in her expression.")

        saynn("[say=tavi]Seriously though.. thanks. For being here. For not running when you had the chance.[/say]")

        saynn("[say=pc]Where would I even go?[/say]")

        saynn("She chuckles, shaking her head.")

        saynn("[say=tavi]Fair point.[/say]")

        saynn("The silence that follows is comfortable. Two fugitives, watching the galaxy drift by.")

        addButton("Stay a while", "Sit with her until the stars blur", "end_scene")

func _react(_action, _args):
    if _action == "end_scene":
        GM.main.setFlag("BDCC2.Ch1_NightWatchDone", true)
        endScene()
        return
    setState(_action)
