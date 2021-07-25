
RegisterServerEvent("vRP:showHash")
AddEventHandler("vRP:showHash", function(x,y,z, heading, model)
    local user = vRP.users_by_source[source]
    if user ~= nil then
        user:prompt("Coordenadas de Hash:", "hash = "..model..", x = "..x..", y = "..y..", z = "..z..", heading = "..heading)
    end
end)
