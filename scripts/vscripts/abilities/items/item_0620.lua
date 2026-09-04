--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local GetAllStats = ____item_0409_shared.GetAllStats
local GetIceStacks = ____item_0409_shared.GetIceStacks
local ConsumeIceStacks = ____item_0409_shared.ConsumeIceStacks
local FROSTBITE_TAG = "item_0620_frostbite"
local FREEZE_DURATION = 4
local COLD_BOON_CHECK_INTERVAL = 0.25
local COLD_BOON_LINGER = 0.5
local FROSTBITE_TICK_INTERVAL = 1
--- 正向随机键双读：roll 键（ability_value_*）非零优先，回落固定键——CSV 被冲回旧键形态时不哑火。
local function ReadRolledPct(self, ability, key)
	local rolled = ability:GetSpecialValueFor("ability_value_" .. key)
	local ____math_max_1 = math.max
	local ____temp_0
	if rolled > 0 then
		____temp_0 = rolled
	else
		____temp_0 = ability:GetSpecialValueFor("ability_" .. key)
	end
	return ____math_max_1(0, ____temp_0)
end
____exports.item_0620 = __TS__Class()
local item_0620 = ____exports.item_0620
item_0620.name = "item_0620"
__TS__ClassExtends(item_0620, BaseItem_CS)
function item_0620.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0620_frost_main.name
end
item_0620 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0620)
____exports.item_0620 = item_0620
--- 固有被动「霜蚀/凛冽」：攻击叠冰冻、满层爆发冻伤；自身冰冻中获得减伤+攻速。
____exports.modifier_item_0620_frost_main = __TS__Class()
local modifier_item_0620_frost_main = ____exports.modifier_item_0620_frost_main
modifier_item_0620_frost_main.name = "modifier_item_0620_frost_main"
__TS__ClassExtends(modifier_item_0620_frost_main, BaseModifier_CS)
function modifier_item_0620_frost_main.GetLocalizationCN(self)
	return {
		name = "霜蚀",
		description = "直接攻击冰冻目标，目标冰冻层数达到上限时爆发冻伤；自身处于冰冻状态时获得减伤与攻速。",
	}
end
function modifier_item_0620_frost_main.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0620_frost_main.prototype.IsHidden(self)
	return true
end
function modifier_item_0620_frost_main.prototype.IsPurgable(self)
	return false
end
function modifier_item_0620_frost_main.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(COLD_BOON_CHECK_INTERVAL)
end
function modifier_item_0620_frost_main.prototype.OnIntervalThink(self)
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		return
	end
	if parent:HasModifier("modifier_generic_slow") then
		____exports.modifier_item_0620_cold_boon:applys(parent, parent, ability, { duration = COLD_BOON_LINGER })
	end
end
function modifier_item_0620_frost_main.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent or event.is_sub_attack then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	AddDeBuffStatus(nil, target, parent, ability, DebuffStatusType.ICE_SLOW, { stack = 1, duration = FREEZE_DURATION })
	local threshold = math.max(1, math.floor(ability:GetSpecialValueFor("ability_freeze_stack_threshold")))
	local iceStacks = GetIceStacks(nil, target)
	if iceStacks < threshold then
		return
	end
	ConsumeIceStacks(nil, target, iceStacks)
	local frostbiteDuration = math.max(0, ability:GetSpecialValueFor("ability_frostbite_duration"))
	if frostbiteDuration <= 0 then
		return
	end
	____exports.modifier_item_0620_frostbite:applys(target, parent, ability, { duration = frostbiteDuration })
end
modifier_item_0620_frost_main = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0620_frost_main)
____exports.modifier_item_0620_frost_main = modifier_item_0620_frost_main
--- 【冻伤】DOT：每秒受到盖戳者全属性×N% 的魔法伤害（挂戳时快照）。
____exports.modifier_item_0620_frostbite = __TS__Class()
local modifier_item_0620_frostbite = ____exports.modifier_item_0620_frostbite
modifier_item_0620_frostbite.name = "modifier_item_0620_frostbite"
__TS__ClassExtends(modifier_item_0620_frostbite, BaseModifier_CS)
function modifier_item_0620_frostbite.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.tickDamage = 0
end
function modifier_item_0620_frostbite.GetLocalizationCN(self)
	return { name = "冻伤", description = "每秒受到施加者全属性一定比例的魔法伤害。" }
end
function modifier_item_0620_frostbite.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local ____ability_2
	if ability then
		____ability_2 = ReadRolledPct(nil, ability, "damage_all_stats_pct")
	else
		____ability_2 = 0
	end
	local pct = ____ability_2
	local ____temp_3
	if caster and IsValid(nil, caster) then
		____temp_3 = GetAllStats(nil, caster) * (pct / 100)
	else
		____temp_3 = 0
	end
	self.tickDamage = ____temp_3
	self:StartIntervalThink(FROSTBITE_TICK_INTERVAL)
end
function modifier_item_0620_frostbite.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local ____ability_4
	if ability then
		____ability_4 = ReadRolledPct(nil, ability, "damage_all_stats_pct")
	else
		____ability_4 = 0
	end
	local pct = ____ability_4
	local ____temp_5
	if caster and IsValid(nil, caster) then
		____temp_5 = GetAllStats(nil, caster) * (pct / 100)
	else
		____temp_5 = 0
	end
	local refreshed = ____temp_5
	self.tickDamage = math.max(self.tickDamage, refreshed)
end
function modifier_item_0620_frostbite.prototype.OnIntervalThink(self)
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not caster or not IsValid(nil, caster) or not IsValidAlive(nil, caster) then
		return
	end
	if self.tickDamage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = caster,
		victim = parent,
		damage = self.tickDamage,
		damage_type = 2,
		ability = self:GetAbility(),
		extra_data = { damage_tags = DamageTag.DOT, custom_tag = FROSTBITE_TAG, source_name = "item_0620_frostbite" },
	})
end
function modifier_item_0620_frostbite.prototype.IsHidden(self)
	return false
end
function modifier_item_0620_frostbite.prototype.IsDebuff(self)
	return true
end
function modifier_item_0620_frostbite.prototype.IsPurgable(self)
	return false
end
function modifier_item_0620_frostbite.prototype.GetTexture(self)
	return "winter_wyvern_splinter_blast"
end
modifier_item_0620_frostbite = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0620_frostbite)
____exports.modifier_item_0620_frostbite = modifier_item_0620_frostbite
--- 【凛冽】增益：自身冰冻期间的减伤+攻速（由主 modifier 轮询刷新）。
____exports.modifier_item_0620_cold_boon = __TS__Class()
local modifier_item_0620_cold_boon = ____exports.modifier_item_0620_cold_boon
modifier_item_0620_cold_boon.name = "modifier_item_0620_cold_boon"
__TS__ClassExtends(modifier_item_0620_cold_boon, BaseModifier_CS)
function modifier_item_0620_cold_boon.GetLocalizationCN(self)
	return { name = "凛冽", description = "处于冰冻状态：受到的伤害减少，攻击速度提高。" }
end
function modifier_item_0620_cold_boon.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	return {
		damage_resistance_pct = ReadRolledPct(nil, ability, "damage_resistance_pct"),
		attack_speed_pct = ReadRolledPct(nil, ability, "attack_speed_pct"),
	}
end
function modifier_item_0620_cold_boon.prototype.IsHidden(self)
	return false
end
function modifier_item_0620_cold_boon.prototype.IsDebuff(self)
	return false
end
function modifier_item_0620_cold_boon.prototype.IsPurgable(self)
	return false
end
function modifier_item_0620_cold_boon.prototype.GetTexture(self)
	return "ancient_apparition_chilling_touch"
end
modifier_item_0620_cold_boon = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0620_cold_boon)
____exports.modifier_item_0620_cold_boon = modifier_item_0620_cold_boon
return ____exports