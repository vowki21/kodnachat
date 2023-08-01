ESX    = exports['es_extended']:getSharedObject()

function random_string(length)
    local str = ""
    for i = 1, length do
        local choice = math.random(1, 2)
        if choice == 1 then
            str = str .. string.char(math.random(97, 122)) 
        else
            str = str .. string.char(math.random(48, 57))
        end
    end
    return str
end

local listaitemkow = {
    "crimowa4",
    "weaponchest4",
    "carchest4",
    "premiumchest69",
}

local kodzik = nil
local itemek = nil
local otwarto = false
local aktualnyczas = 0
local czasoczekiwania = 30 -- minutes

CreateThread(function()
    while true do
        itemek = math.random(1, #listaitemkow)
        kodzik = random_string(10)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.4vw; left: 1px; margin: 0.4vw; background-color: rgba(0, 0, 0, 0.4); border-radius: 4px; border-left:2px solid #03A9F4"; font-weight:700;><i class="fas fa-sharp fa-light fa-money-bill-1-wave"></i> <font color="#3279a8">CloudRP</font> {0}</div>',
            args = { "^0Aby wygrać randomowy itemek wpisz /kod " .. kodzik }
        })
        otwarto = true
        aktualnyczas = os.time() + czasoczekiwania * 60

        Citizen.Wait(czasoczekiwania * 60000)
    end
end)

local tanczetango = nil 

RegisterCommand('kod', function(src, args, raw)
    if otwarto then
        if args[1] == kodzik then
            otwarto = false
            -- if listaitemkow[itemek] == "skrzyniaogg4" then
            --     tanczetango = "Skrzynka OG"
            if listaitemkow[itemek] == "crimowa4" then
                tanczetango = "Skrzynka Crimowa"
            -- elseif listaitemkow[itemek] == "weaponchestbetter4" then
            --     tanczetango = "Skrzynka Broń Długa"
            elseif listaitemkow[itemek] == "weaponchest4" then
                tanczetango = "Skrzynka Z bronią"
            elseif listaitemkow[itemek] == "carchest4" then
                tanczetango = "Skrzynka Z Autami"
            -- elseif listaitemkow[itemek] == "carchestindrop4" then
            --     tanczetango = "Skrzynka Car Limited"
            elseif listaitemkow[itemek] == "premiumchest69" then
                tanczetango = "Skrzynka Premium"
            -- elseif listaitemkow[itemek] == "animatedcar4" then
            --     tanczetango = "Skrzynka Animated Car"
            -- elseif listaitemkow[itemek] == "skrzynkalatajaceautafajna4" then
            --     tanczetango = "Skrzynka Latających Aut"
            -- elseif listaitemkow[itemek] == "skrzynkaminicars4" then
            --     tanczetango = "Skrzynka Z Mini Autami"
            -- elseif listaitemkow[itemek] == "trialsupport4" then
            --     tanczetango = "Skrzynka 50/50"
                
            end
            TriggerClientEvent('esx:showNotification', src, "Wygrałeś skrzynke o nazwie: " .. tanczetango)
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.4vw; margin: 0.4vw; background-color: rgba(0, 0, 0, 0.4); border-radius: 4px;  border-left:2px solid #03A9F4"; font-weight:700;><i class="fas fa-sharp fa-light fa-money-bill-1-wave"></i> <font color="#3279a8">CloudRP</font> {0}</div>',
                args = { "^0Gracz " .. GetPlayerName(src) .. " wpisał kod i wygrał: " .. tanczetango .."" }
            })
            local xPlayer = ESX.GetPlayerFromId(src)
            xPlayer.addInventoryItem(listaitemkow[itemek], 1)
        else
            TriggerClientEvent('esx:showNotification', src, "Zły kodzik!")
        end
    else
        TriggerClientEvent('esx:showNotification', src, "Poczekaj na konkurs!")
    end
end)

RegisterCommand('kiedykod', function(src, args, raw)
    local czasdo = aktualnyczas - os.time()
    local minuty = math.floor(czasdo / 60)
    local sekundy = czasdo % 60
    TriggerClientEvent('esx:showNotification', src, "Następny kod pojawi się za: " .. minuty .. " minut i " .. sekundy .. " sekund.")
end)