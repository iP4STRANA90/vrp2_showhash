-- (Re)set locals at start
local infoOn = false    -- Disables the info on restart.

-- Thread that makes everything happen.
Citizen.CreateThread(function()                             -- Create the thread.
    while true do                                           -- Loop it infinitely.
        local pause = 250                                   -- If infos are off, set loop to every 250ms. Eats less resources.
        if infoOn then                                      -- If the info is on then...
            pause = 5                                       -- Only loop every 5ms (equivalent of 200fps).
            local player = GetPlayerPed(-1)                 -- Get the player.
            if IsPlayerFreeAiming(PlayerId()) then          -- If the player is free-aiming (update texts)...
                local entity = getEntity(PlayerId())        -- Get what the player is aiming at. This isn't actually the function, that's below the thread.
                local coords = GetEntityCoords(entity)      -- Get the coordinates of the object.
                local heading = GetEntityHeading(entity)    -- Get the heading of the object.
                local model = GetEntityModel(entity)        -- Get the hash of the object.
                local x,y,z = coords.x, coords.y, coords.z
                
                if GetEntityType(entity) == 2 or 3 then
                    if aimCheck(GetPlayerPed(-1)) then
                        TriggerServerEvent("vRP:showHash", x,y,z, heading, model)
                    end
                end
            end
        end                                                 -- Info is off, don't need to do anything.
        Citizen.Wait(pause)                                 -- Now wait the specified time.
    end                                                     -- End (stop looping).
end)                                                        -- Endind the entire thread here.

function aimCheck(player) -- function to check config value onAim. If it's off, then
    if onAim == "true" then
        return true
    else
        return IsPedShooting(player)
    end
end

-- Function to get the object the player is actually aiming at.
function getEntity(player)                                          -- Create this function.
    local result, entity = GetEntityPlayerIsFreeAimingAt(player)    -- This time get the entity the player is aiming at.
    return entity                                                   -- Returns what the player is aiming at.
end                                                                 -- Ends the function.

-- Creating the function to toggle the info.
ToggleInfos = function()                -- "ToggleInfos" is a function
    infoOn = not infoOn                 -- Switch them around
end                                     -- Ending the function here.

-- Creating the command.
RegisterCommand("infohash", function()     -- Listen for this command.
    ToggleInfos()                       -- Heard it! Let's toggle the function above.
end)                                    -- Ending the function here.