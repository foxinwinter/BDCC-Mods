extends QuestBase

func _init():
    id = "BDCC2Quest"

func getVisibleName():
    return "Broken Dreams 2"

func getProgress():
    var result = []

    if getFlag("BDCC2.Ch1Complete", false):
        result.append("Arrived at Azure Cove")
    else:
        if getFlag("BDCC2.Ch1_ArrivalDone", false):
            result.append("Touch down on Azure Cove")
        elif getFlag("BDCC2.Ch1_NightWatchDone", false):
            result.append("Finish the journey to Azure Cove")
        elif getFlag("BDCC2.Ch1_ShipLifeDone", false):
            result.append("Spend time with Tavi during the journey")
        elif getFlag("BDCC2.Ch1_MorningDone", false):
            result.append("Get to know your new ship and crew")
        else:
            result.append("Wake up and talk to Tavi about the plan")

    if getFlag("BDCC2.Ch2Complete", false):
        result.append("Recruited Nova")
    else:
        if getFlag("BDCC2.Ch2_RecruitDone", false):
            result.append("Recruit Nova to the crew")
        elif getFlag("BDCC2.Ch2_MeetNovaDone", false):
            result.append("Meet Nova at Dawfort Creamery")
        elif getFlag("BDCC2.Ch2_ToFarmDone", false):
            result.append("Walk to Dawfort Creamery through Azure Cove")
        else:
            result.append("Recruit Nova to your cause")

    result.append("Secure Syndicate backing for the Themis heist")
    result.append("Retrieve Tavi's ship from Themis and restore Elena's backup")
    result.append("Track down Director Cross and end his Project Phoenix")
    result.append("Find peace with Tavi and Nova")

    return result

func isVisible():
    var hasKillEnding = getFlag("TaviModule.Ch7KillEnding", false)
    var hasMaxCorruption = getFlag("TaviModule.Ch6CorruptionStage", 0) >= 4
    var hasCh7Done = getFlag("TaviModule.Ch7CaptainSceneHappened", false)
    return hasKillEnding and hasMaxCorruption and hasCh7Done

func isCompleted():
    return getFlag("BDCC2.Complete", false)

func isMainQuest():
    return true
