ModUtil.RegisterMod("RoomSecretIndicator")

local config = {
    ModName = "RoomSecretIndicator",
    showGates = true,
    showFishingPoint = true,
    showInfernalTrove = true,
    showSellShop = true,
    showWellShop = true,
    revealTroveReward = true,
}
RoomSecretIndicator.config = config

ModUtil.LoadOnce(function ()
    if ModConfigMenu then
        ModConfigMenu.Register( config )
    end
end)

local baseDoUnlockRoomExits = DoUnlockRoomExits
function DoUnlockRoomExits ( run, room )
    baseDoUnlockRoomExits( run, room )
    thread( CheckRoomSecrets )
end

function CheckRoomSecrets ()

    local finalMessage = ""

    local currentRoom = CurrentRun.CurrentRoom

    if config.showInfernalTrove then
        if currentRoom.ChallengeSwitch ~= nil then
            local secretName = "Inferal Trove"
            if config.revealTroveReward then
                local rewardType = ""
                if currentRoom.ChallengeSwitch.RewardType == "MetaPoints" then
                    rewardType = "Darkness"
                elseif currentRoom.ChallengeSwitch.RewardType == "Money" then
                    rewardType = "Obols"
                else
                    rewardType = currentRoom.ChallengeSwitch.RewardType
                end
                secretName = secretName .. "(" .. rewardType .. ")"
            end
            finalMessage = ConcatToFinalMessage( finalMessage, secretName )
        end
    end

    if config.showWellShop then
        if string.find( currentRoom.Name, "PostBoss" ) then return end
        if currentRoom.WellShop ~= nil then
            finalMessage = ConcatToFinalMessage( finalMessage, "Well of Charon" )
        end
    end

    if config.showSellShop then
        if currentRoom.SellTraitShop ~= nil then
            finalMessage = ConcatToFinalMessage( finalMessage, "Pool of Purging" )
        end
    end

    if config.showFishingPoint then
        if currentRoom.ForceFishing and currentRoom.FishingPointId and IsUseable({ Id = currentRoom.FishingPointId }) then
            finalMessage = ConcatToFinalMessage( finalMessage, "Fishing Point" )
        end
    end

    if config.showGates then
        if currentRoom.ForceSecretDoor then
            finalMessage = ConcatToFinalMessage( finalMessage, "Chaos Gate" )
        end
        if currentRoom.ForceShrinePointDoor then
            finalMessage = ConcatToFinalMessage( finalMessage, "Erebus Gate" )
        end
    end

    ShowIndicatorText( finalMessage )
end

function ConcatToFinalMessage ( currentMessage, secretName )

    if currentMessage ~= "" then
        return currentMessage .. "," .. secretName
    elseif currentMessage == "" then
        return secretName
    end
end

function ShowIndicatorText( text )

    local textScale = "30"
    if string.len( text ) >= 25 then
        textScale = "20"
    end

    local customTextIndicatorId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCenterX, Y = ScreenCenterY + 250 })
    CreateTextBox({ Id = customTextIndicatorId, Text = text, Justification="CENTER", ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0,
    OutlineThickness = 1, OutlineColor = {1, 1, 1, 1},
    Font = "SpectralSCLightTitling", FontSize = textScale, Color = {255,255,255,255},})
    wait(0.5)
	ModifyTextBox({ Id = customTextIndicatorId, FadeTarget = 0.0, FadeDuration = 3.0, AutoSetDataProperties = false })
	wait(3.0)
	DestroyTextBox({ Id = customTextIndicatorId })
end