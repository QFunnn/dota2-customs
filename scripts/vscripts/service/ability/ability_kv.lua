--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("utils.keyvalues")
require("service.ability.ability_pool")

local special_keys = {
	var_type = false,
	LinkedSpecialBonus = true,
	LinkedSpecialBonusField = true,
	LinkedSpecialBonusOperation = true,
	DamageTypeTooltip = true,
	CalculateSpellDamageTooltip = true,
	RequiresScepter = true,
	RequiresShard = true,
	levelkey = true,
	ad_linked_abilities = true,
}

local networked_values = {
	AbilityUnitDamageType = true,
	AbilityValues = true,
	AbilityDraftExtraAbilities = true,
	MaxLevel = true,
	HasShardUpgrade = true,
	HasScepterUpgrade = true,
	AbilityDamageCategory = true,
	AbilityDamageFlags = true,
	IsPassive = true, -- custom key
	ID = true,
}

local convert_to_array = {
	value = true,
	special_bonus_shard = true,
	special_bonus_scepter = true,
}

local merge_into_ability_values = {
	AbilityDuration = true,
	AbilityCooldown = true,
	AbilityManaCost = true,
	AbilityCastRange = true,
	AbilityChannelTime = true,
	AbilityCastPoint = true,
	AbilityCharges = true,
	AbilityChargeRestoreTime = true,
}

AbilityKVService = AbilityKVService or {}

local abilities_items_kv = {}
function AbilityKVService:Init()
	AbilityPool:Init()

	local ability_list = AbilityKVService:MakeAbilityList()

	for ability, _ in pairs(ability_list) do
		local kv = GetAbilityKeyValuesByName(ability)
		if kv then
			local formatted_kv = AbilityKVService:FormatKV(kv) or {}
			local linked = AbilityPool:GetLinkedAbilities(ability)
			if linked then
				formatted_kv.linked_abilities = linked
			end
			abilities_items_kv[ability] = formatted_kv
		end
	end

    GameListener:SubscribeProtected("get_abilities_items_kv", function (event)
		self:SendAbilitiesItemsKV(event)
	end)
end

function AbilityKVService:SendAbilitiesItemsKV(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayer(player_id) then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not player or player:IsNull() or (player.kv_sended and not IsInToolsMode()) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "set_abilities_items_kv", abilities_items_kv)
	player.kv_sended = true
end

function AbilityKVService:ConvertAbilitySpecialToValues(specials)
	local values = {}

	for _, special in pairs(specials) do
		local value = {}
		local value_name
		local only_value = true

		for k,v in pairs(special) do
			if special_keys[k] ~= false then
				if special_keys[k] == true then
					value[k] = v
					only_value = false
				else
					value_name = k
					value["value"] = v
				end
			end
		end

		if only_value then
			value = value.value
		end

		values[value_name] = value
	end

	return values
end

local function shrink_array(arr)
	local last_value = arr[#arr]

	for i = #arr - 1, 1, -1 do
		if last_value == arr[i] then 
			arr[i + 1] = nil 
		end
	end

	if #arr == 1 and arr[1] == 0 then return nil end

	return arr
end

function AbilityKVService:ValueToArray(value)
	if not value or value == "" then return nil end

	if type(value) == "number" then
		return { value }
	end

	local arr = string.split(value)

	if #arr == 0 then return nil end

	for k,v in ipairs(arr) do
		arr[k] = tonumber(v) or v
	end

	arr = shrink_array(arr)

	return arr
end

function AbilityKVService:MakeAbilityList()
	local ability_list = {}

	-- Все имена драфт-листа (draft + linked) — из AbilityPool.
	for name, _ in pairs(AbilityPool:GetAllReferencedAbilities()) do
		ability_list[name] = true
	end

	local shard_scepter_ability_list = {}

	for ability_name, _ in pairs(ability_list) do
		local extra_abilities = GetAbilityKV(ability_name, "AbilityDraftExtraAbilities")
		if type(extra_abilities) == "table" then
			for extra_ability_name, extra_ability_type in pairs(extra_abilities) do
				if type(extra_ability_name) == "string" and type(extra_ability_type) == "string" then
					if extra_ability_type == "shard" or extra_ability_type == "scepter" then
						shard_scepter_ability_list[extra_ability_name] = true
					end
				end
			end
		end
	end

	table.merge(ability_list, shard_scepter_ability_list)
	return ability_list
end

local function contains_key(t, key)
	if type(t) ~="table" then return false end

	for k,v in pairs(t) do
		if type(k) == "string" and k:lower():find(key) then return true end

		if type(v) == "table" then
			local is_v_contain_key = contains_key(v, key)
			if is_v_contain_key then return true end
		end
	end

	return false
end

function AbilityKVService:FormatKV(kv)
	if kv.AbilitySpecial then
		local converted_values = AbilityKVService:ConvertAbilitySpecialToValues(kv.AbilitySpecial)

		if kv.AbilityValues then
			table.deepmerge(converted_values, kv.AbilityValues)
		end

		kv.AbilityValues = converted_values
		kv.AbilitySpecial = nil
	end

	if kv.AbilityValues then
		for value_name, _ in pairs(merge_into_ability_values) do
			if kv[value_name] and not kv.AbilityValues[value_name] then
				kv.AbilityValues[value_name] = kv[value_name]
			end
		end

		local lowercase_ability_values = {}
		for k,v in pairs(kv.AbilityValues) do
			lowercase_ability_values[type(k) == "string" and k:lower() or k] = v
		end
		kv.AbilityValues = lowercase_ability_values

		-- Send AbilityValues only if ability have shard or scepter
		kv.AbilityValues = table.filter(kv.AbilityValues, function(v,k) 
			return kv.HasScepterUpgrade == 1 or kv.HasShardUpgrade == 1
				or k:lower():find("scepter") or k:lower():find("shard") 
				or contains_key(v, "shard") or contains_key(v, "scepter")
		end)

		for k,v in pairs(kv.AbilityValues) do
			if type(v) == "table" then
				for field_name, field_value in pairs(v) do
					if convert_to_array[field_name] and type(field_value) == "string" then
						v[field_name] = AbilityKVService:ValueToArray(field_value)
					end
				end
			elseif type(v) == "string" then
				kv.AbilityValues[k] = AbilityKVService:ValueToArray(v)
			end
		end
	end

	if kv.AbilityBehavior and string.find(kv.AbilityBehavior, "DOTA_ABILITY_BEHAVIOR_PASSIVE") then
		kv.IsPassive = true
	end

	kv = table.filter(kv, function(v,k)
		if networked_values[k] then
			if v == "" or v == 0 then return false 
			elseif type(v) == "table" and next(v) == nil then return false
			else return true end
		end

		return false
	end)

	return next(kv) and kv or nil
end

AbilityKVService:Init()