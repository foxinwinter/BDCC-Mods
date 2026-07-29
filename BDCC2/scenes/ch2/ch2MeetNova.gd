extends SceneBase

func _init():
    sceneID = "PhoenixRising_Ch2_MeetNova"

func _run():
    if state == "":
        addCharacter("nova")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="nova", npcAction="stand"})
        saynn("Inside, the biodome is a small paradise. Rows of vegetables grow in raised beds. A few dairy goats mill about in a fenced paddock. Fruit trees bend under their load along the curved walls. The air smells of earth, grass, and something sweet baking.")
        saynn("A figure kneels by one of the beds, gloved hands working the soil. Gray fur, a familiar husky build, her curly tail wagging absently as she hums to herself.")
        saynn("She looks up at the sound of footsteps. Her ears swivel forward.")
        saynn("[say=nova]Help you? We're not open for tours right now, but if you're here about the cream order—[/say]")
        saynn("She stops. Blinks. Stares.")
        saynn("Tavi gives a small, uncertain wave.")
        saynn("[say=tavi]Hey, Nova~.[/say]")
        saynn("For a long moment, Nova doesn't move. Then she pulls off her gloves, stands up slowly, and walks over.")
        saynn("[say=nova]Tavi?[/say]")
        saynn("[say=tavi]Yeah~. It's me. In the flesh.. All of me~.[/say]")
        saynn("Nova's tail goes stiff. Her ears shoot up.")
        saynn("[say=nova]Tavi![/say]")
        saynn("She tackles Tavi in a hug that nearly knocks her over, laughing.")
        saynn("[say=nova]You're alive! You crazy bitch, you're alive! I saw the news — the prison, the lockdown — they said most of the inmates didn't make it! I thought—[/say]")
        saynn("She pulls back, holding Tavi at arm's length, beaming.")
        saynn("[say=nova]Look at you! You look like shit, but you're alive![/say]")
        saynn("Tavi laughs, rubbing the back of her neck.")
        saynn("[say=tavi]Nice to see you too~. Missed having someone to tease~.[/say]")
        addButton("Let them catch up", "Give them a moment", "catch_up")

    if state == "catch_up":
        addCharacter("nova")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="nova", npcAction="stand"})
        saynn("Nova's attention shifts to you, her head tilting curiously.")
        saynn("[say=nova]And who's this? New girlfriend?[/say]")
        saynn("Tavi's ears turn pink.")
        saynn("[say=tavi]Nova! No! This is— this is the person I told you about. From the prison~. The one who helped me with— y'know.. everything.. including my needs~.[/say]")
        saynn("Nova's eyebrows rise. She looks you over with renewed interest.")
        saynn("[say=nova]Ohh. The troublemaker. Tavi's mentioned you. More than a few times, actually~.[/say]")
        saynn("She offers a hand, still grinning.")
        saynn("[say=nova]Nova. Former head of yard security, current professional goat milker. Welcome to my little slice of heaven.[/say]")
        addButton("Introduce yourself", "Shake her hand", "introduce")

    if state == "introduce":
        addCharacter("nova")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="nova", npcAction="stand"})
        saynn("You shake Nova's hand. Her grip is firm, warm.")
        saynn("She gestures toward a small patio with a table and chairs under a vine-covered trellis.")
        saynn("[say=nova]Sit. I'll get drinks. You two look like you've got a story to tell.[/say]")
        saynn("She disappears into a small cottage attached to the dome. Tavi sinks into one of the chairs with a sigh.")
        saynn("[say=tavi]She's taking this well~. Maybe I should take notes~.[/say]")
        addButton("Too well?", "Ask Tavi what she thinks", "too_well")

    if state == "too_well":
        addCharacter("nova")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="tavi", npcAction="sit"})
        saynn("Tavi shakes her head.")
        saynn("[say=tavi]Nova's always been like this, owner~. She rolls with things. It's one of the reasons she survived the prison without turning into an asshole.. Unlike me~.[/say]")
        saynn("Nova returns with three glasses of cold milk and a plate of pastries. She sets them down and takes a seat.")
        saynn("[say=nova]Alright. Spill. How the hell did you get out, and what are you doing on my doorstep?[/say]")
        addButton("Tell the story", "Let Tavi explain", "explain")

    if state == "explain":
        addCharacter("nova")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="nova", npcAction="sit"})
        saynn("Tavi summarizes: the escape, the stolen Syndicate ship, the plan to fight back against what AlphaCorp has become — and what they need from Nova.")
        saynn("Nova listens without interrupting, her tail curling slowly as she processes. When Tavi finishes, there's a long silence.")
        saynn("Nova picks up a pastry, examines it, then takes a bite.")
        saynn("[say=nova]So you stole a Syndicate ship, broke out of the most secure prison in the sector, and now you want to start a war.[/say]")
        saynn("[say=tavi]When you put it like that it sounds insane~. But hey, the best things usually are~.[/say]")
        saynn("Nova snorts.")
        saynn("[say=nova]It is insane.[/say]")
        saynn("She chews thoughtfully.")
        saynn("[say=nova]I'm in.[/say]")
        addButton("Just like that?", "Ask why she's agreeing so fast", "why_agree")

    if state == "why_agree":
        addCharacter("nova")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="nova", npcAction="sit"})
        saynn("Nova grins at your expression.")
        saynn("[say=nova]What, you thought I'd say no? Please. I've been sitting on this rock for six months milking goats and selling cheese to tourists. It's nice, but it's not..[/say]")
        saynn("She gestures vaguely.")
        saynn("[say=nova]..enough. I didn't leave AlphaCorp because I wanted a quiet life. I left because they were turning into something I couldn't stomach. If there's a chance to actually do something about it? Sign me up.[/say]")
        saynn("She points a pastry at Tavi.")
        saynn("[say=nova]Besides, you saved my ass more than once back in that hellhole. I owe you. And I always pay my debts.[/say]")
        saynn("Tavi's ears flick. She looks genuinely touched.")
        saynn("[say=tavi]Thanks, Nova~. Really.. I owe you one.. or ten~.[/say]")
        saynn("Nova waves a hand dismissively.")
        saynn("[say=nova]Don't thank me yet. We've got a war to plan.[/say]")
        addButton("Welcome to the crew", "Toast with your glass of milk", "end_scene")

func _react(_action, _args):
    if _action == "end_scene":
        GM.main.setFlag("PhoenixRising.Ch2_MeetNovaDone", true)
        endScene()
        return
    setState(_action)
