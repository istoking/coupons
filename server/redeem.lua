local VorpCore = {}

TriggerEvent("getCore", function(core)
  VorpCore = core
end)

local VorpInv = exports.vorp_inventory:vorp_inventoryApi()
local allowedrole = Config.AllowedRole
local stringlength = Config.Length

RegisterCommand('redeem', function(source, args, rawCommand)
    local Character = VorpCore.getUser(source).getUsedCharacter
    local target = source
    exports.oxmysql:execute('SELECT * FROM codes WHERE code = @playerCode', {['@playerCode'] = args[1]}, function(result)
        if (result[1]) ~= nil then
            local code = result[1].code
            local type = result[1].type
            local amount = result[1].amount
            local status = result[1].status

            if status == 0 then

                if type == 'money' then
                    Character.addCurrency(Config.MoneyType, amount)
                    TriggerClientEvent("vorp:TipBottom", target, "Successfully Redeemed A Code", 5000)
                    exports.oxmysql:execute('UPDATE codes SET status=@status, usedby=@usedby WHERE code=@code', {
                        ['@status'] = 1,
                        ['@usedby'] = Character.firstname,
                        ['@code'] = code
                    })
                else
                    VorpInv.addItem(target, type, amount)
                    TriggerClientEvent("vorp:TipBottom", target, "Successfully Redeemed A Code", 5000)
                    exports.oxmysql:execute('UPDATE codes SET status=@status, usedby=@usedby WHERE code=@code', {
                        ['@status'] = 1,
                        ['@usedby'] = Character.firstname,
                        ['@code'] = code
                    })
                end
            else
                TriggerClientEvent("vorp:TipBottom", target, "Code has been already Redeemed!", 5000)
            end
        else
            TriggerClientEvent("vorp:TipBottom", target, "Code is not valid! - Codes are case Sensitive!", 5000)       
        end
    end)
end)

RegisterCommand('redeemw', function(source, args, rawCommand)
    local Character = VorpCore.getUser(source).getUsedCharacter
    local target = source
    exports.oxmysql:execute('SELECT * FROM codes WHERE code = @playerCode', {['@playerCode'] = args[1]}, function(result)
        if (result[1]) ~= nil then
            local code = result[1].code
            local type = result[1].type
            local amount = result[1].amount
            local status = result[1].status

            if status == 0 then
                TriggerEvent("vorpCore:canCarryWeapons", tonumber(target), 1, function(canCarry)
                if canCarry then
                    VorpInv.createWeapon(target, type)
                    TriggerClientEvent("vorp:TipBottom", target, "Successfully Redeemed A Code", 5000)
                    exports.oxmysql:execute('UPDATE codes SET status=@status, usedby=@usedby WHERE code=@code', {
                        ['@status'] = 1,
                        ['@usedby'] = Character.firstname,
                        ['@code'] = code
                    })
                else
                    TriggerClientEvent("vorp:TipBottom", target, "You can't carry any more WEAPONS", 5000)
                end
            end)
            
            else
                TriggerClientEvent("vorp:TipBottom", target, "Code has been already Redeemed!", 5000)
            end
        else
            TriggerClientEvent("vorp:TipBottom", target, "Code is not valid! - Codes are case Sensitive!", 5000)          
        end
    end)
end)

RegisterCommand('createcode', function(source, args, rawCommand)
    local Character = VorpCore.getUser(source).getUsedCharacter
    local type = tostring(args[1]):lower()
    local amount = tonumber(args[2])
    local group = Character.group

    if group == allowedrole and type ~= nil and amount ~= nil then
        local upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        local lowerCase = "abcdefghijklmnopqrstuvwxyz"
        local numbers = "0123456789"
        local symbols = ".@$#()"
        local characterSet = upperCase .. lowerCase .. numbers .. symbols
        local keyLength = stringlength
        local output = ""

        for i = 1, keyLength do
            local rand = math.random(#characterSet)
            output = output .. string.sub(characterSet, rand, rand)
        end

        Citizen.Wait(100)

        local message = 'Code Generated - '..output..''
	TriggerClientEvent('chatMessage', source, message)
        exports.oxmysql:execute('INSERT INTO codes (code, type, amount, status, madeby) VALUES (@output, @type, @amount, @status, @madeby)', {
            ['@output'] = output,
            ['@type'] = type,
            ['@amount'] = amount,
            ['@status'] = 0,
            ['@madeby'] = Character.firstname,
        })
    else
        TriggerClientEvent("vorp:TipBottom", source, "You do not have permission to type this command!", 5000)
    end
end)

RegisterCommand('createcodew', function(source, args, rawCommand)
    local Character = VorpCore.getUser(source).getUsedCharacter
    local type = tostring(args[1]):lower()
    local amount = tonumber(args[2])
    local group = Character.group

    if group == allowedrole and type ~= nil and amount ~= nil then
        local upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        local lowerCase = "abcdefghijklmnopqrstuvwxyz"
        local numbers = "0123456789"
        local symbols = ".@$#()"
        local characterSet = upperCase .. lowerCase .. numbers .. symbols
        local keyLength = stringlength
        local output = ""

        for i = 1, keyLength do
            local rand = math.random(#characterSet)
            output = output .. string.sub(characterSet, rand, rand)
        end

        Citizen.Wait(100)

        local message = 'Code Generated - '..output..''
	TriggerClientEvent('chatMessage', source, message)
        exports.oxmysql:execute('INSERT INTO codes (code, type, amount, status, madeby) VALUES (@output, @type, @amount, @status, @madeby)', {
            ['@output'] = output,
            ['@type'] = type,
            ['@amount'] = amount,
            ['@status'] = 0,
            ['@madeby'] = Character.firstname,
        })
    else
        TriggerClientEvent("vorp:TipBottom", source, "You do not have permission to type this command!", 5000)
    end
end)
