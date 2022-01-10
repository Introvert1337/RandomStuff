-- Made by ComoEsteban on v3rm

return function(Data)
    if type(Data) ~=  "table" then
        return error("The first argument must be a table")
    end
    local Table = Data.Table or Data
    local Indent = Data.Indent or 4
    local ShowKeys = true
    local LastIndent = Data.LastBracketIndent or 0
    if Data.ShowKeys ~= nil then
        ShowKeys = Data.ShowKeys
    end
    local function ConvertValue(Value)
        if type(Value) == "table" then
            return converttable({
                ["Table"] = Value,
                ["Indent"] = (Indent + (Data.LastBracketIndent or Indent)),
                ["ShowKeys"] = Data.ShowKeys,
                ["LastBracketIndent"] = Indent
            })
        end
        if type(Value) == "string" then
            return '"'..Value..'"'
        end
        if typeof(Value) == "Instance" then
            Origin = "game."
            if not Value:FindFirstAncestorOfClass("game") then
                Origin = ""
            end
            return Origin..Value:GetFullName()
        end
        if typeof(Value) == "CFrame" then
            return "CFrame.new("..tostring(Value)..")"
        end  
        if typeof(Value) == "Vector3" then
            return "Vector3.new("..tostring(Value)..")"
        end    
        if typeof(Value) == "Vector2" then
             return "Vector2.new("..tostring(Value)..")"
        end 
        if typeof(Value) == "Color3" then
            return "Color3.new("..tostring(Value)..")"
        end
        if typeof(Value) == "BrickColor" then
            return "BrickColor.new("..tostring(Value)..")"
        end
        return tostring(Value)
    end
    local Indent = Data.Indent or 4
    local Result = "{\n"
    for Key,Value in pairs(Table) do
        KeyString = "[\""..tostring(Key).."\"] = "
        if type(Key) == "number" then
            KeyString = "["..tostring(Key).."] = "
        end
        if not ShowKeys then
            KeyString = ""
        end
        Result = Result..string.rep(" ",Indent)..KeyString..ConvertValue(Value)..",\n"
    end
    Result = Result..string.rep(" ",LastIndent).."}"
    return Result
end
