--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__StringSubstring = ____lualib.__TS__StringSubstring
local __TS__StringTrim = ____lualib.__TS__StringTrim
local ____exports = {}
local decodeCameraLock, decodePopup, DELIM_FIELD, HIT_BLOOD_BASE_INTENSITY_PERCENT, ClientSyncHandlers
local ____player_setting = require("client.player_setting")
local getPlayerSettingBoolean = ____player_setting.getPlayerSettingBoolean
function decodeCameraLock(self, payload)
	local enabledText = string.lower(__TS__StringTrim(payload))
	local enabled = enabledText == "1" or enabledText == "true"
	Convars:SetBool("dota_camera_lock", enabled)
end
function decodePopup(self, payload)
	local entStr, playerIdStr, kind, amountStr, rStr, gStr, bStr, showAmountStr, damageTypeStr, hitImpactAmountStr =
		unpack(__TS__StringSplit(payload, DELIM_FIELD))
	local entityIndexRaw = tonumber(entStr)
	if entityIndexRaw == nil then
		return
	end
	local entity_index = entityIndexRaw
	local amount = tonumber(amountStr or 0) or 0
	local hitImpactAmount = tonumber(hitImpactAmountStr or amount) or 0
	local r = tonumber(rStr)
	local g = tonumber(gStr)
	local b = tonumber(bStr)
	local showAmount = tonumber(showAmountStr or 1) ~= 0
	local entity = EntIndexToHScript(entity_index)
	if not IsValidEntity(entity) then
		return
	end
	local pos = entity:GetAbsOrigin()
	local kindStr = kind
	local damageType = damageTypeStr or "none"
	local pfx = "particles/msg_fx/msg_damage.vpcf"
	local color = Vector(255, 255, 255)
	local lifetime = 1
	local preSymbol
	local postSymbol
	local ____temp_0
	if amount ~= nil then
		____temp_0 = math.floor(amount)
	else
		____temp_0 = nil
	end
	local number = ____temp_0
	local attachment = PATTACH_OVERHEAD_FOLLOW
	if r ~= nil and g ~= nil and b ~= nil and r >= 0 and g >= 0 and b >= 0 then
		color = Vector(r, g, b)
	end
	repeat
		local ____switch15 = kindStr
		local ____cond15 = ____switch15 == "heal"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_heal.vpcf"
			color = Vector(0, 255, 0)
			preSymbol = 0
			break
		end
		____cond15 = ____cond15 or (____switch15 == "attack_lifesteal" or ____switch15 == "spell_lifesteal")
		if ____cond15 then
			break
		end
		____cond15 = ____cond15 or ____switch15 == "damage"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_damage_numbers_incoming.vpcf"
			color = Vector(255, 255, 255)
			lifetime = 0.75
			break
		end
		____cond15 = ____cond15 or ____switch15 == "damage_colored"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_damage.vpcf"
			postSymbol = 3
			break
		end
		____cond15 = ____cond15 or ____switch15 == "crit"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_crit.vpcf"
			postSymbol = 4
			if damageType == "magical" then
				color = Vector(180, 80, 255)
			end
			break
		end
		____cond15 = ____cond15 or ____switch15 == "crit_colored"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_crit.vpcf"
			postSymbol = 4
			break
		end
		____cond15 = ____cond15 or ____switch15 == "dot"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_poison.vpcf"
			postSymbol = 6
			break
		end
		____cond15 = ____cond15 or ____switch15 == "block"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_block.vpcf"
			postSymbol = 7
			color = Vector(255, 150, 0)
			attachment = PATTACH_CENTER_FOLLOW
			break
		end
		____cond15 = ____cond15 or ____switch15 == "gold"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_gold.vpcf"
			color = Vector(255, 200, 33)
			preSymbol = 0
			break
		end
		____cond15 = ____cond15 or ____switch15 == "mana"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_gold.vpcf"
			color = Vector(33, 200, 255)
			preSymbol = 0
			break
		end
		____cond15 = ____cond15 or ____switch15 == "miss"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_miss_2.vpcf"
			color = Vector(255, 0, 0)
			preSymbol = 5
			number = nil
			break
		end
		____cond15 = ____cond15 or ____switch15 == "damage_big"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_damage.vpcf"
			color = Vector(255, 0, 0)
			lifetime = 2
			postSymbol = 3
			break
		end
		____cond15 = ____cond15 or ____switch15 == "add_gold"
		if ____cond15 then
			pfx = "particles/msg_fx/msg_damage.vpcf"
			color = Vector(255, 200, 33)
			lifetime = 2
			preSymbol = 0
			break
		end
	until true
	if kindStr == "attack_lifesteal" or kindStr == "spell_lifesteal" then
		local lifestealPfx = kindStr == "attack_lifesteal"
				and "particles/generic_gameplay/generic_lifesteal_lanecreeps.vpcf"
			or "particles/items3_fx/octarine_core_lifesteal.vpcf"
		local lifestealPid = ParticleManager:CreateParticle(lifestealPfx, PATTACH_CENTER_FOLLOW, entity)
		ParticleManager:ReleaseParticleIndex(lifestealPid)
		if not showAmount then
			return
		end
		pfx = "particles/msg_fx/msg_heal.vpcf"
		color = Vector(0, 255, 0)
		preSymbol = 0
	end
	if kindStr == "damage" or kindStr == "crit" or kindStr == "damage_big" then
		local maxHealth = entity:GetMaxHealth()
		local ____temp_1
		if maxHealth > 0 then
			____temp_1 = math.max(0, hitImpactAmount / maxHealth * 100)
		else
			____temp_1 = 0
		end
		local hitIntensity = HIT_BLOOD_BASE_INTENSITY_PERCENT + ____temp_1
		local hitParticleId = ParticleManager:CreateParticle(
			"particles/generic_gameplay/generic_hit_blood_lv.vpcf",
			PATTACH_CENTER_FOLLOW,
			entity
		)
		ParticleManager:SetParticleControl(hitParticleId, 0, pos)
		ParticleManager:SetParticleControl(hitParticleId, 1, Vector(hitIntensity, 0, 0))
		ParticleManager:ReleaseParticleIndex(hitParticleId)
	end
	if
		kindStr == "damage" and (not showAmount or not getPlayerSettingBoolean(nil, "showNormalDamageNumbers", true))
	then
		return
	end
	if number ~= nil and number <= 0 then
		return
	end
	local pid = ParticleManager:CreateParticle(pfx, attachment, entity)
	local digits = 0
	if number ~= nil then
		digits = #tostring(math.floor(number))
	end
	if preSymbol ~= nil then
		digits = digits + 1
	end
	if postSymbol ~= nil then
		digits = digits + 1
	end
	local ____ParticleManager_SetParticleControl_5 = ParticleManager.SetParticleControl
	local ____temp_2
	if preSymbol ~= nil then
		____temp_2 = preSymbol
	else
		____temp_2 = -1
	end
	local ____temp_3
	if number ~= nil then
		____temp_3 = number
	else
		____temp_3 = -1
	end
	local ____temp_4
	if postSymbol ~= nil then
		____temp_4 = postSymbol
	else
		____temp_4 = -1
	end
	____ParticleManager_SetParticleControl_5(ParticleManager, pid, 1, Vector(____temp_2, ____temp_3, ____temp_4))
	ParticleManager:SetParticleControl(pid, 2, Vector(lifetime, digits, 0))
	ParticleManager:SetParticleControl(pid, 3, color)
	ParticleManager:ReleaseParticleIndex(pid)
end
--- 客户端展示事件同步
-- 协议：服务器发一条长字符串，多条用 # 分隔，每条为 type|field1|field2|...
-- - popup：数字弹出类特效（原 popups.lua + 伤害展示）
local DELIM_MSG = "#"
DELIM_FIELD = "|"
HIT_BLOOD_BASE_INTENSITY_PERCENT = 10
ListenToGameEvent("c2c_server_client_event", function(data)
	local raw = data.data
	if not raw or #raw == 0 then
		return
	end
	local parts = __TS__StringSplit(raw, DELIM_MSG)
	for ____, part in ipairs(parts) do
		do
			if part == "" then
				goto __continue4
			end
			local sep = (string.find(part, DELIM_FIELD, nil, true) or 0) - 1
			if sep < 0 then
				goto __continue4
			end
			local ____type = __TS__StringSubstring(part, 0, sep)
			local payload = __TS__StringSubstring(part, sep + 1)
			if not payload then
				goto __continue4
			end
			local handler = ClientSyncHandlers[____type]
			if handler then
				handler(nil, payload)
			end
		end
		::__continue4::
	end
end, nil)
--- 按 type 统一分发，新增类型只需在此注册
ClientSyncHandlers = { popup = decodePopup, camera_lock = decodeCameraLock }
return ____exports