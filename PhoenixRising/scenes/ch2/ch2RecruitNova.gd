extends SceneBase

func _init():
    sceneID = "PhoenixRising_Ch2_RecruitNova"

func _run():
    if state == "":
        addCharacter("nova")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="nova", npcAction="sit"})
        saynn("The three of you sit around the patio table as the afternoon shadows lengthen. Nova has a datapad out, scrolling through something with a frown.")
        saynn("[say=nova]Okay, so. If you're serious about this, you're going to need more than a ship and a crew of three. You need intel. Resources. A plan that doesn't end with us getting spaced.[/say]")
        saynn("[say=tavi]That's why we came to you, Nova~. You know the corps better than anyone. You worked for them.. and we need all the help we can get to make our little dream come true~.[/say]")
        saynn("Nova snorts.")
        saynn("[say=nova]Worked for them. Got used by them. There's a difference.[/say]")
        saynn("She sets the datapad down and leans forward.")
        addButton("What do you know?", "Ask about her intel", "intel")
        addButton("What about the farm?", "Ask what happens to her place", "farm")

    if state == "intel":
        addCharacter("nova")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="nova", npcAction="sit"})
        saynn("Nova taps her datapad.")
        saynn("[say=nova]AlphaCorp has been restructuring since the prison fell. They're consolidating power, buying up colonies, pushing out independent settlers. Azure Cove is on their radar — they've been making noise about 'security assessments' that would let them station corporate enforcers here.[/say]")
        saynn("[say=tavi]How long until they move, cutie~? I'd hate to have our fun interrupted..[/say]")
        saynn("[say=nova]Months, maybe. A year if we're lucky. But they're not the only players. The Syndicate lost a ship and a lot of face when you escaped. They want it back. They want you. And they've got feelers out across the sector.[/say]")
        saynn("She looks between you and Tavi.")
        saynn("[say=nova]You two have made a lot of enemies. You're going to need allies. Real ones.[/say]")
        addButton("That's why we're here", "Nod and look to Tavi", "plan")

    if state == "farm":
        addCharacter("nova")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="nova", npcAction="sit"})
        saynn("Nova looks around the biodome. Her ears droop slightly.")
        saynn("[say=nova]The farm.. I built this place from nothing. It's mine. But it's not worth more than stopping what AlphaCorp is becoming.[/say]")
        saynn("She forces a grin.")
        saynn("[say=nova]Besides, goats are terrible conversationalists. I could use some proper company.[/say]")
        saynn("Tavi reaches over and squeezes Nova's hand briefly.")
        saynn("[say=tavi]When this is over, I'll help you build it back better~. Promise. And maybe I'll bring my owner to visit~.[/say]")
        saynn("Nova's tail wags once, despite herself.")
        addButton("We'll make it right", "Promise to help rebuild", "plan")

    if state == "plan":
        addCharacter("nova")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "sit", {npc="nova", npcAction="sit"})
        saynn("Nova stands and stretches, her joints popping.")
        saynn("[say=nova]Alright. If we're doing this, we need to move before AlphaCorp tightens the net. I've got contacts — other ex-corp, independent operators, people who might be willing to help if the price is right.[/say]")
        saynn("[say=tavi]We've got a Syndicate nav log full of supply caches, Nova~. That should cover expenses for a while.. and leave plenty for.. personal rewards~.[/say]")
        saynn("Nova's ears perk up.")
        saynn("[say=nova]Now that's useful. Where's the nearest one?[/say]")
        saynn("Tavi pulls up her datapad and shows her. Nova studies it, then nods.")
        saynn("[say=nova]Themis. It's a mining station in the outer belt. Syndicate cache there is big enough to fund our next few moves. We hit it, we've got operating capital.[/say]")
        saynn("She looks at you both with a glint in her eye.")
        saynn("[say=nova]You came to me for help. I'm in. But I'm not just a set of hands — I'm a partner. We do this together, or not at all.[/say]")
        addButton("Together", "Extend your hand", "together")
        addButton("Wouldn't have it any other way", "Nod firmly", "together")

    if state == "together":
        addCharacter("nova")
        addCharacter("tavi")
        playAnimation(StageScene.Duo, "stand", {npc="nova", npcAction="stand"})
        saynn("Nova takes your hand and shakes it firmly. Then she pulls Tavi into a quick hug.")
        saynn("[say=nova]Give me an hour to pack and secure the dome. There's a冷冻仓 for the goats — they'll be fine for a few weeks.[/say]")
        saynn("She heads toward the cottage, then pauses at the door.")
        saynn("[say=nova]Oh, and Tavi?[/say]")
        saynn("[say=tavi]Yeah~?[/say]")
        saynn("Nova grins.")
        saynn("[say=nova]It's really good to see you.[/say]")
        saynn("She disappears inside. Tavi stands there for a moment, a soft smile on her face.")
        saynn("[say=tavi]We actually did it, owner~. We got her.. One step closer to making all our dreams come true~. I can't wait to celebrate properly~.[/say]")
        addButton("One down", "Let the reality sink in", "end_scene")

func _react(_action, _args):
    if _action == "end_scene":
        GM.main.setFlag("PhoenixRising.Ch2_RecruitDone", true)
        GM.main.setFlag("PhoenixRising.Ch2Complete", true)
        endScene()
        return
    setState(_action)
