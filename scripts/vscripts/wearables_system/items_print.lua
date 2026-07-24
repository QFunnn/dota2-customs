--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function PrintTable(t, indent, done)
    --print ( string.format ('PrintTable type %s', type(keys)) )
    if type(t) ~= "table" then return end

    done = done or {}
    done[t] = true
    indent = indent or 0

    local l = {}
    for k, v in pairs(t) do
        table.insert(l, k)
    end

    table.sort(l)
    for k, v in pairs(l) do
        -- Ignore FDesc
        if v ~= 'FDesc' then
            local value = t[v]

            if type(value) == "table" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..":")
                PrintTable (value, indent + 2, done)
            elseif type(value) == "userdata" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
            else
                if t.FDesc and t.FDesc[v] then
                    print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
                else
                    print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                end
            end
        end
    end
end

function IsItemInListCustom(model_player, item_slot, hero_name)
    local table_items = require("wearables_system/donate_items/"..hero_name.."_slots")
    if table_items == nil then return false end
    for slot_name, items_list in pairs(table_items) do
        for _, item_name_list in pairs(items_list) do
            if item_name_list == model_player then
                return true
            end
        end
    end
    return false
end

function HasItemAverageInList(table, name)
    for k, v in pairs(table) do
        if v == name then
            return true
        end
    end
    return false
end

function GetHeroItems(hero_name, full_info)
    local all_items = LoadKeyValues("scripts/items/items_game.txt")
    local npc_heroes = LoadKeyValues("scripts/npc/npc_heroes.txt")
    local hero_slots = {}
    local all_models_in_this_slot = {}
    for heroname, hero in pairs(npc_heroes) do
        if heroname ~= "Version" and hero["ItemSlots"] then
            for _, slot_info in pairs(hero["ItemSlots"]) do
                table.insert(hero_slots, slot_info["SlotName"])
            end
        end
    end

    for itemDef, item in pairs(all_items.items) do
        if type(item) == "table" then
            local used_by_heroes = item.used_by_heroes
            local item_slot = item.item_slot
            if not item_slot then
                item_slot = "weapon"
            end
            local for_this_hero = false
            if (item.prefab == "wearable" or item.prefab == "default_item") and used_by_heroes then
                for heroname, activated in pairs(used_by_heroes) do
                    if activated == 1 and heroname == hero_name then
                        for_this_hero = true
                    end
                end
            end
            if for_this_hero then
                if all_models_in_this_slot[item_slot] == nil then
                    all_models_in_this_slot[item_slot] = {}
                end

                if full_info and item.model_player ~= nil then
                    ---------------------------------------
                    print( '[' .. itemDef .. '] = {' )
                    print("['item_id'] =" .. itemDef .. ",")
                    print("['name'] =" .. "'" .. item.name .. "',")
                    if item.image_inventory then
                        print("['icon'] =" .. "'" .. item.image_inventory .. "',")
                    end
                    print("['price'] = 1,")
                    print("['HeroModel'] = nil,")
                    print("['ArcanaAnim'] = nil,")
                    print("['MaterialGroup'] = nil,")
                    print("['ItemModel'] =" .. "'" .. item.model_player .. "',")
                    ---------------------------------------

                    ---------------------------------------
                    print("['SetItems'] = nil,")
                    print("['hide'] = 0,")
                    print("['OtherItemsBundle'] = nil,")
                    print("['SlotType'] = " .. "'" .. item_slot .. "',")
                    print("['RemoveDefaultItemsList'] = nil,")
                    print("['Modifier'] = nil,")
                    print("['sets'] = " .. "'" .. item_slot .. "',")
                    print("},")
                end
            end
        end
    end

    if not full_info then
        PrintTable(all_models_in_this_slot)
    end
end

------------------------------------------------

--GetHeroItems("npc_dota_hero_drow_ranger", true)

function GetBaseItems()
local all_items = LoadKeyValues("scripts/items/items_game.txt")
local npc_heroes = LoadKeyValues("scripts/npc/npc_heroes.txt")

local replace_table =
{
    ["particles/units/heroes/hero_razor/razor_ambient.vpcf"] = "particles/razor_custom/razor_ambient.vpcf",
    ["particles/units/heroes/hero_razor/razor_ambient_main.vpcf"] = "particles/razor_custom/razor_ambient_main.vpcf",
    ["particles/units/heroes/hero_razor/razor_whip.vpcf"] = "particles/razor_custom/razor_whip.vpcf",

    ["particles/units/heroes/hero_terrorblade/terrorblade_feet_effects.vpcf"] = "particles/terrorblade_custom/terrorblade_feet_effects.vpcf",
}
 

local hero_table = {}

for hero_name, hero_data in pairs(npc_heroes) do
    if type(hero_data) == "table" then
        if hero_data["HeroID"] and hero_data["Model"] and not hero_table[hero_name] then
            hero_table[hero_name] = {}
            hero_table[hero_name]["model"] = hero_data["Model"]
        end
    end
end

for name,data in pairs(all_items) do
    if name == "items" then
        for item_id, item_data in pairs(data) do

            local is_effect = item_data["item_slot"] and item_data["item_slot"] == "ambient_effects" and item_data["visuals"] and type(item_data["visuals"] == "table")
            local is_item = not item_data["item_slot"] or item_data["item_slot"]:match("persona") == nil

            if item_data["prefab"] and item_data["used_by_heroes"] and item_data["model_player"] and item_data["prefab"] == "default_item" 
                and is_item or is_effect then

                for param_name, param_data in pairs(item_data) do
                    if param_name == "used_by_heroes" and type(param_data) == "table" then
                        for hero_name, is_using in pairs(param_data) do
                            if is_using == 1 and hero_table[hero_name] then

                                if is_effect then
                                    if not hero_table[hero_name]["effects"] then
                                        hero_table[hero_name]["effects"] = {}
                                    end

                                    for effect_name, effect_data in pairs(item_data["visuals"]) do
                                        if effect_data["type"] and effect_data["type"] == "particle_create" then
                                            local effect_name = effect_data["modifier"]
                                            local custom_effect_name = replace_table[effect_name] and replace_table[effect_name] or effect_name

                                            for effect_id, effect_data in pairs(all_items["attribute_controlled_attached_particles"]) do
                                                if effect_data["system"] and effect_data["system"] == effect_name and effect_data["attach_type"] and effect_data["attach_entity"] then

                                                    hero_table[hero_name]["effects"][custom_effect_name] = {}
                                                    hero_table[hero_name]["effects"][custom_effect_name]["attach_type"] = effect_data["attach_type"]
                                                    hero_table[hero_name]["effects"][custom_effect_name]["attach_entity"] = effect_data["attach_entity"]

                                                    if effect_data["control_points"] then
                                                        hero_table[hero_name]["effects"][custom_effect_name]["control_points"] = effect_data["control_points"]
                                                    end
                                                end
                                            end 
                                        end
                                    end
                                else
                                    if not hero_table[hero_name]["items"] then
                                        hero_table[hero_name]["items"] = {}
                                    end

                                    if not hero_table[hero_name]["items"][item_data["model_player"]] then
                                        hero_table[hero_name]["items"][item_data["model_player"]] = "true"
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


if true then return end
CustomPrintTable(hero_table, 0)
end

function CustomPrintTable(data_table, count)

print(string.rep(" ", count*3).."{")

for name, data in pairs(data_table) do
    if type(data) == "table" then
        print(string.rep(" ", (count + 1)*3)..'["'..name..'"] = ')
        CustomPrintTable(data, count + 1)
    else
        print(string.rep(" ", (count + 1)*3)..'["'..name..'"] = '..'"'..data..'",')
    end
end

print(string.rep(" ", count*3).."},")
end


function CustomPrintTable2(data_table, count)

print(string.rep(" ", count*3).."{")

for name, data in pairs(data_table) do
    if type(data) == "table" then
        print(string.rep(" ", (count + 1)*3)..'"'..name..'" ')
        CustomPrintTable2(data, count + 1)
    else
        print(string.rep(" ", (count + 1)*3)..'"'..name..'" '..'"'..data..'"')
    end
end

print(string.rep(" ", count*3).."}")

end
