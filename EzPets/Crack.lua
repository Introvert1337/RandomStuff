--// automatically go through loading ui

local messageFrame = game:GetService("Players").LocalPlayer.PlayerGui.Message.Frame

local titleConnection
titleConnection = messageFrame.Title:GetPropertyChangedSignal("Text"):Connect(function()
    if messageFrame.Title.Text:find("EzPets") then
        titleConnection:Disconnect()
		
        messageFrame.Title.Text = "" -- so if they re execute it will still work
		
        task.wait()
        firesignal(messageFrame.Ok.MouseButton1Click)
    end
end)

local coreGuiAddedConnection
coreGuiAddedConnection = game:GetService("CoreGui").ChildAdded:Connect(function(child)
    if child.Name:find("EzPets") then
        coreGuiAddedConnection:Disconnect()
		
        local keyUiContainer = child:WaitForChild("Main"):WaitForChild("Key"):WaitForChild("Get your Key on https://ezhub.club/getkey"):WaitForChild("Container")

        keyUiContainer.Textbox.Button.Textbox.Text = "trolled"
        firesignal(keyUiContainer:GetChildren()[5].MouseButton1Click)
    end
end)

--// crack

local urlReplacements = {
    ["https://raw.githubusercontent.com/TurfuGoldy/GoldenScripts/main/VenyxUI.lua"] = game:HttpGet("https://raw.githubusercontent.com/Introvert1337/RandomStuff/main/EzPets/UILibrary.lua"),
    ["https://raw.githubusercontent.com/TurfuGoldy/GoldenScripts/main/versions.txt"] = "EzPets - v2.3.5",
    ["https://raw.githubusercontent.com/TurfuGoldy/GoldenScripts/main/AkaliNotif.lua"]  = game:HttpGet("https://raw.githubusercontent.com/Introvert1337/RandomStuff/main/EzPets/Notifications.lua")
}

local oldHttpGet
oldHttpGet = replaceclosure(game.HttpGet, function(self, url, cache)
    if urlReplacements[url] then
        return urlReplacements[url]
    end

    if url:match("https://ezhub.club/verifykey/key=%w+&time=%d+") then
        local time = os.time()

        return tostring((time * 2 + 154784767) * math.max(string.sub(time, -1), 1))
    end
    
    return oldHttpGet(self, url, cache)
end)

--// load script

loadstring(game:HttpGet("https://raw.githubusercontent.com/Introvert1337/RandomStuff/main/EzPets/ScriptBackup.lua"))()
