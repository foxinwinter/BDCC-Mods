extends "res://Scenes/SceneBase.gd"

func _init():
    sceneID = "BDCC2_ShipRestScene"

func _run():
    if state == "":
        playAnimation(StageScene.Sleeping, "sleep")

        saynn("You lie down on the thin military-issue mattress. It's not your cell bunk, but after everything, it'll do.")

        saynn("What do you wanna do?")

        addButton("Stand up", "No time for resting", "endthescene")

        addButton("Sleep", "Sleep until the next day and recover your stamina", "gosleep")

        var currentTime = GM.main.getTime()
        for t in [8, 10, 12, 14, 16, 18, 20, 22]:
            if(currentTime < t*60*60):
                addButton("Rest %02d:00" % [t], "Wake up when the time becomes %02d:00" % [t], "restuntil", [t])
            else:
                addDisabledButton("Rest %02d:00" % [t], "Too late for that today")

    if state == "rested":
        saynn("You rest for a while on the bunk, listening to the hum of the ship's engines. You feel less tired.")

        addButton("Continue", "Time to get up", "endthescene")

    if state == "slept":
        playAnimation(StageScene.Sleeping, "sleep", {bodyState={naked=true}})

        saynn("You slept in the crew quarters. The constant drone of the engines took some getting used to, but you managed to recover your energy.")

        saynn("You wake up as the ship's internal lighting cycles back on.")

        addButton("Continue", "Time to get up", "endthesceneandtriggerevents")

        GM.ES.triggerRun(Trigger.WakeUpInCell)

func _react(_action: String, _args):
    if _action == "restuntil":
        var newt = _args[0]

        var timePassed = GM.main.processTimeUntil(newt * 60 * 60)
        GM.pc.afterRestingInBed(timePassed)

        if(GM.ES.triggerReact(Trigger.Waiting, [timePassed])):
            endScene()
            return

        setState("rested")
        return

    if _action == "gosleep":
        if(GM.ES.triggerReact(Trigger.AboutToSleepInCell)):
            endScene()
            return

        GM.main.startNewDay()
        GM.pc.afterSleepingInBed()

        if(GM.ES.triggerReact(Trigger.SleepInCell)):
            pass

        setState("slept")
        return

    if _action == "endthescene":
        endScene()
        return

    if _action == "endthesceneandtriggerevents":
        GM.pc.updateAppearance()

        if(GM.ES.triggerReact(Trigger.WakeUpInCell)):
            GM.main.showLog()
            endScene()
            return
        GM.main.showLog()

        endScene()
        return

    setState(_action)
