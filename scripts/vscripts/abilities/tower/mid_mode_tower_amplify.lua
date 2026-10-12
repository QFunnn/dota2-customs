--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/tower/mid_mode_tower_amplify.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/tower/mid_mode_tower_amplify.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "2:27",
		["15"] = "2:40",
		["16"] = "4:1",
		["17"] = "5:14",
		["18"] = "4:1",
		["19"] = "5:37",
		["20"] = "6:5",
		["21"] = "7:15",
		["22"] = "8:13",
		["23"] = "9:13",
		["25"] = "6:5",
		["26"] = "5:14",
		["27"] = "4:2",
		["28"] = "4:2",
		["29"] = "4:2",
		["31"] = "4:2",
		["32"] = "5:14",
		["34"] = "5:14",
		["35"] = "13:1",
		["36"] = "14:14",
		["37"] = "13:1",
		["38"] = "14:46",
		["39"] = "15:5",
		["40"] = "16:9",
		["41"] = "15:5",
		["42"] = "19:5",
		["43"] = "20:9",
		["44"] = "20:16",
		["45"] = "20:16",
		["46"] = "20:16",
		["47"] = "20:16",
		["48"] = "20:16",
		["49"] = "20:16",
		["50"] = "20:16",
		["52"] = "20:16",
		["53"] = "19:5",
		["54"] = "34:5",
		["55"] = "35:9",
		["56"] = "34:5",
		["57"] = "42:5",
		["58"] = "43:9",
		["59"] = "44:9",
		["60"] = "45:14",
		["63"] = "46:15",
		["64"] = "47:14",
		["67"] = "48:9",
		["68"] = "48:33",
		["69"] = "48:62",
		["71"] = "48:62",
		["73"] = "48:9",
		["74"] = "42:5",
		["75"] = "55:5",
		["76"] = "56:14",
		["79"] = "57:15",
		["80"] = "58:15",
		["81"] = "59:15",
		["82"] = "60:13",
		["83"] = "61:17",
		["84"] = "62:23",
		["85"] = "63:22",
		["88"] = "64:23",
		["89"] = "65:17",
		["92"] = "55:5",
		["93"] = "70:5",
		["94"] = "71:14",
		["97"] = "72:15",
		["98"] = "73:15",
		["99"] = "75:13",
		["100"] = "76:19",
		["101"] = "77:19",
		["102"] = "78:17",
		["104"] = "79:21",
		["105"] = "80:22",
		["107"] = "81:21",
		["110"] = "83:22",
		["112"] = "84:21",
		["119"] = "89:17",
		["120"] = "90:17",
		["121"] = "90:36",
		["122"] = "90:43",
		["123"] = "91:21",
		["124"] = "90:43",
		["125"] = "90:17",
		["128"] = "70:5",
		["129"] = "101:5",
		["130"] = "102:14",
		["131"] = "102:50",
		["133"] = "103:15",
		["134"] = "104:13",
		["135"] = "104:43",
		["137"] = "105:15",
		["138"] = "106:9",
		["139"] = "101:5",
		["140"] = "109:5",
		["141"] = "110:9",
		["142"] = "109:5",
		["143"] = "113:5",
		["144"] = "114:16",
		["146"] = "114:16",
		["148"] = "114:9",
		["149"] = "113:5",
		["150"] = "117:5",
		["151"] = "118:16",
		["153"] = "118:16",
		["155"] = "118:9",
		["156"] = "117:5",
		["157"] = "121:5",
		["158"] = "122:16",
		["160"] = "122:16",
		["162"] = "122:9",
		["163"] = "121:5",
		["164"] = "125:5",
		["165"] = "126:16",
		["167"] = "126:16",
		["169"] = "126:9",
		["170"] = "125:5",
		["171"] = "14:14",
		["172"] = "13:2",
		["173"] = "13:2",
		["174"] = "13:19",
		["175"] = "13:2",
		["177"] = "13:2",
		["178"] = "14:14",
		["180"] = "14:14",
	}
)
local ____exports = {}
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.mid_mode_tower_amplify = __TS__Class()
local mid_mode_tower_amplify = ____exports.mid_mode_tower_amplify
mid_mode_tower_amplify.name = "mid_mode_tower_amplify"
__TS__ClassExtends(mid_mode_tower_amplify, BaseAbility)
function mid_mode_tower_amplify.prototype.GetIntrinsicModifierName(self)
	local level = self:GetLevel()
	if level >= 1 then
		return ____exports.modifier_mid_mode_tower_amplify.name
	end
end
mid_mode_tower_amplify = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, mid_mode_tower_amplify)
____exports.mid_mode_tower_amplify = mid_mode_tower_amplify
____exports.modifier_mid_mode_tower_amplify = __TS__Class()
local modifier_mid_mode_tower_amplify = ____exports.modifier_mid_mode_tower_amplify
modifier_mid_mode_tower_amplify.name = "modifier_mid_mode_tower_amplify"
__TS__ClassExtends(modifier_mid_mode_tower_amplify, SLModifierBase)
function modifier_mid_mode_tower_amplify.prototype.AllowIllusionDuplicate(self)
	return false
end
function modifier_mid_mode_tower_amplify.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PURE,
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function modifier_mid_mode_tower_amplify.prototype.CheckState(self)
	return { [MODIFIER_STATE_CANNOT_MISS] = true }
end
function modifier_mid_mode_tower_amplify.prototype.OnCreated(self, params)
	self._weak_time = self:GetAbilitySpecialValueFor("weak_time") * 60
	self._weak_pct = self:GetAbilitySpecialValueFor("weak_pct")
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end
	local ____parent_SetBaseMaxHealth_2 = parent.SetBaseMaxHealth
	local ____temp_1 = parent:GetBaseMaxHealth()
	local ____temp_0 = self:GetAbilitySpecialValueFor("health_bonus")
	if ____temp_0 == nil then
		____temp_0 = 0
	end
	____parent_SetBaseMaxHealth_2(parent, ____temp_1 + ____temp_0)
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierProcAttack_BonusDamage_Pure(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local attacker = event.attacker
	local victim = event.target
	if IsValid(parent) and IsValid(attacker) and IsValid(victim) and victim:IsHero() then
		if parent == attacker and parent ~= victim then
			local bonus_pure_damage_pct = self:GetAbilitySpecialValueFor("bonus_pure_damage_pct")
			if not bonus_pure_damage_pct then
				return
			end
			local damage = victim:GetHealth() * (bonus_pure_damage_pct / 100)
			return damage
		end
	end
end
function modifier_mid_mode_tower_amplify.prototype.OnDeath(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local unit = event.unit
	if IsValid(parent) and IsValid(unit) and parent == unit then
		local delay = 4
		local name = parent:GetUnitName()
		local soundName
		repeat
			local ____switch18 = name
			local ____cond18 = ____switch18 == "npc_dota_goodguys_tower3_mid"
			if ____cond18 then
				soundName = "mid_super_bad"
				break
			end
			____cond18 = ____cond18 or ____switch18 == "npc_dota_badguys_tower3_mid"
			if ____cond18 then
				soundName = "mid_super_good"
				break
			end
			do
				break
			end
		until true
		if soundName then
			Timers:CreateTimer(delay, function()
				EmitGlobalSound(soundName)
			end)
		end
	end
end
function modifier_mid_mode_tower_amplify.prototype._GetWeakPct(self)
	if not self._weak_time or not self._weak_pct then
		return 0
	end
	local game_time = GameRules:GetDOTATime(false, false)
	if game_time <= self._weak_time then
		return 0
	end
	local minutes = math.floor((game_time - self._weak_time) / 60)
	return minutes * self._weak_pct
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierIncomingDamage_Percentage(self, event)
	return self:GetAbilitySpecialValueFor("dmg_res_pct") * -1 + self:_GetWeakPct()
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierAttackSpeedBonus_Constant(self)
	local ____temp_3 = self:GetAbilitySpecialValueFor("attack_speed_bonus")
	if ____temp_3 == nil then
		____temp_3 = 0
	end
	return ____temp_3
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierProjectileSpeedBonus(self)
	local ____temp_4 = self:GetAbilitySpecialValueFor("projectile_speed_bonus")
	if ____temp_4 == nil then
		____temp_4 = 0
	end
	return ____temp_4
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierPhysicalArmorBonus(self, event)
	local ____temp_5 = self:GetAbilitySpecialValueFor("armor_bonus")
	if ____temp_5 == nil then
		____temp_5 = 0
	end
	return ____temp_5
end
function modifier_mid_mode_tower_amplify.prototype.GetModifierMagicalResistanceBonus(self, event)
	local ____temp_6 = self:GetAbilitySpecialValueFor("magic_resist")
	if ____temp_6 == nil then
		____temp_6 = 0
	end
	return ____temp_6
end
modifier_mid_mode_tower_amplify = __TS__Decorate(
	{ registerModifier(nil, "abilities/tower/mid_mode_tower_amplify", nil, getfenv()) },
	modifier_mid_mode_tower_amplify
)
____exports.modifier_mid_mode_tower_amplify = modifier_mid_mode_tower_amplify
return ____exports