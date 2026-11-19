if not game:IsLoaded() then game.Loaded:Wait() end 

-- PATH BASE LU
local BASE = "https://raw.githubusercontent.com/GADEVAN/Gavin-Store/refs/heads/main/Gavin-store/games/"  
local DISCORD = "discord.gg/gavinstore" 

-- NAMA GAME (TANPA SPASI BIAR AMAN)
local GAMES = { 
    [10436530264] = "BuildAnAntEmpire", 
    [10418224975] = "TNTMining", 
    [10684750879] = "LootToForge", 
    [10765091041] = "OpenSeaForAnimals", 
    [66654135] = "MurderMystery2", 
    [1202096104] = "DrivingEmpire", 
    [9534705677] = "SniperArena", 
    [6739698191] = "ViolenceDistrict", 
    [10708913337] = "AnimeDice", -- UDAH GW UBAH JADI TANPA SPASI
    [10035204815] = "RideAPet",
    [10031505426] = "AirDropArena", 
    [7633926880] = "BloxStrike", 
    [10765298801] = "StoneSkipping", 
    [10765288803] = "BreakandStealanEgg", 
    [10765012427] = "BuildthePyramid", 
} 

local StarterGui = game:GetService("StarterGui") 

local function Notify(text, detail) 
    warn("[GAVIN STORE] " .. text, detail or "") 
    task.spawn(function() 
        for _ = 1, 20 do 
            local shown = pcall(StarterGui.SetCore, StarterGui, "SendNotification", { 
                Title = "GAVIN STORE", 
                Text = text, 
                Duration = 10, 
            }) 
            if shown then return end 
            task.wait(0.5) 
        end 
    end) 
end 

local function LooksLikeScript(body) 
    if type(body) ~= "string" or body == "" then return false end 
    local head = body:sub(1, 80) 
    return not (head:find("^%s*<") or head:find("^%d%d%d:")) 
end 

local function FetchOnce(url) 
    local ok, body = pcall(function() return game:HttpGet(url) end) 
    if ok and LooksLikeScript(body) then return body end 
    local send = request or http_request or (syn and syn.request) or (http and http.request) 
    if not send then return nil, ok and "bad reply from HttpGet" or tostring(body) end 
    local sent, reply = pcall(send, { Url = url, Method = "GET" }) 
    if not sent or type(reply) ~= "table" then return nil, tostring(reply) end 
    if reply.StatusCode ~= 200 then return nil, "HTTP " .. tostring(reply.StatusCode) end 
    if not LooksLikeScript(reply.Body) then return nil, "bad reply body" end 
    return reply.Body 
end 

local function Fetch(url) 
    local why 
    for attempt = 1, 3 do 
        local body, err = FetchOnce(url) 
        if body then return body end 
        why = err 
        if attempt < 3 then task.wait(1) end 
    end 
    return nil, why 
end 

local name = GAMES[game.GameId] 
if not name then 
    Notify("Game not supported. Join " .. DISCORD .. " for the list.") 
    return 
end 

-- KARENA UDAH TANPA SPASI, KITA LANGSUNG TEMPEL NAMANYA
local fileName = name .. ".lua" 
local source, why = Fetch(BASE .. fileName) 
if not source then 
    Notify("Failed to download " .. name .. ". Check net or join " .. DISCORD, why) 
    return 
end 

local chunk, compileErr = loadstring(source) 
if not chunk then 
    Notify(name .. " failed to compile: " .. tostring(compileErr) .. ". Ask in " .. DISCORD) 
    return 
end 

local ok, trace = xpcall(chunk, function(err) 
    return debug.traceback(tostring(err), 2) 
end) 
if not ok then 
    Notify(name .. " error: " .. tostring(trace):match("^[^\n]*") .. ". Ask in " .. DISCORD, "\n" .. tostring(trace)) 
end
