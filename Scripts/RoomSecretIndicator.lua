ModUtil.RegisterMod("RoomSecretIndicator")

local config = {
    gate = true,
    fishingPoint = true,
    infernalTrove = true,
    showTroveReward = true,
    wellShop = true,
    wellSell = true,
}
RoomSecretIndicator.config = config

local textScale = "30"

local baseDoUnlockRoomExits = DoUnlockRoomExits
function DoUnlockRoomExits ( run, room )
    baseDoUnlockRoomExits( run, room )
    thread( checkRoomSecrets ) 
end

function checkRoomSecrets ()
    wait(0.5)
    local finalMessage = ""

    currentRoom = CurrentRun.CurrentRoom

    if config.infernalTrove then
        if currentRoom.ChallengeSwitch ~= nil then
            secretName = "Inferal Trove"
            if config.showTroveReward then
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
            finalMessage = concatToFinalMessage( finalMessage, secretName )
        end
    end

    if config.wellShop then
        -- Skip if in room after boss, you should be able to find the shops there ;)
        if string.find( currentRoom.Name, "PostBoss" ) then return end
        if currentRoom.WellShop ~= nil then
            finalMessage = concatToFinalMessage( finalMessage, "Well of Charon" )
        end
    end

    if config.wellSell then
        if currentRoom.SellTraitShop ~= nil then
            finalMessage = concatToFinalMessage( finalMessage, "Sell trait Shop" )
        end
    end

    if config.fishingPoint then
        if currentRoom.ForceFishing and currentRoom.FishingPointId and IsUseable({ Id = currentRoom.FishingPointId }) then
            finalMessage = concatToFinalMessage( finalMessage, "Fishing Point" )
        end
    end

    if config.gate then
        if currentRoom.ForceSecretDoor then
            finalMessage = concatToFinalMessage( finalMessage, "Chaos Gate" )
        end
        if currentRoom.ForceShrinePointDoor then
            finalMessage = concatToFinalMessage( finalMessage, "Erebus Gate" )
        end
    end

    showIndicatorText( finalMessage )
end

function concatToFinalMessage ( currentMessage, secretName )
    if currentMessage ~= "" then
        return currentMessage .. "," .. secretName
    elseif currentMessage == "" then
        return secretName
    end
end

function showIndicatorText( text )
    if string.len(text) >= 25 then
        textScale = "20"
    end

    local customTextIndicatorId = CreateScreenObstacle({ Name = "BlankObstacle", X = ScreenCewdsnterX, Y = ScreenCenterY + 450 }) 
    CreateTextBox({ Id = customTextIndicatorId, Text = text, Justification="Center", ShadowColor = {0, 0, 0, 128}, ShadowOffset = {0, 2}, ShadowBlur = 0, 
    OutlineThickness = 1, OutlineColor = {1, 1, 1, 1}, 
    Font = "SpectralSCLightTitling", FontSize = textScale, Color = {255,255,255,255},}) 
    wait(0.5)
	ModifyTextBox({ Id = customTextIndicatorId, FadeTarget = 0.0, FadeDuration = 3.0, AutoSetDataProperties = false })
	wait(3.0)
	DestroyTextBox({ Id = customTextIndicatorId })
end