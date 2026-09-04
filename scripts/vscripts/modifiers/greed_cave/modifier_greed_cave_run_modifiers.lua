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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local PLAYER_POISON_TICK_INTERVAL = 1
local PLAYER_POISON_MAX_HEALTH_PCT_PER_STACK = 1.2
local HEALING_DOWN_PCT_PER_STACK = 50
local HEALING_DOWN_PCT_MAX = 80
local MONSTER_BERSERK_DAMAGE_PCT_PER_STACK = 18
local MONSTER_BERSERK_ATTACK_SPEED_PER_STACK = 25
local MONSTER_TOUGH_RESISTANCE_PCT_PER_STACK = 15
local MONSTER_TOUGH_RESISTANCE_PCT_MAX = 80
local function readStackCount(self, params, fallback)
	if fallback == nil then
		fallback = 1
	end
	return math.max(1, math.floor(tonumber(params and params.stack_count) or fallback or 1))
end
____exports.modifier_greed_cave_player_poison = __TS__Class()
local modifier_greed_cave_player_poison = ____exports.modifier_greed_cave_player_poison
modifier_greed_cave_player_poison.name = "modifier_greed_cave_player_poison"
__TS__ClassExtends(modifier_greed_cave_player_poison, BaseModifier_CS)
function modifier_greed_cave_player_poison.GetLocalizationCN(self)
	return { name = "秘境剧毒", description = "倾天秘境词条：战斗中周期性流失生命值。" }
end
function modifier_greed_cave_player_poison.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:RefreshStackCount(params)
	self:StartIntervalThink(PLAYER_POISON_TICK_INTERVAL)
end
function modifier_greed_cave_player_poison.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:RefreshStackCount(params)
end
function modifier_greed_cave_player_poison.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValidAlive(nil, parent) then
		return
	end
	local rawDamage = parent:GetMaxHealth() * PLAYER_POISON_MAX_HEALTH_PCT_PER_STACK * self:GetStackCount() / 100
	local damage = math.min(rawDamage, math.max(parent:GetHealth() - 1, 0))
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = parent,
		victim = parent,
		damage = damage,
		damage_type = 4,
		damage_flag = ApplyDamageFlag.HP_LOSS,
		extra_data = {
			damage_tags = DamageTag.DOT,
			debuff_status = DebuffStatusType.POISON,
			source_name = self:GetName(),
		},
	})
end
function modifier_greed_cave_player_poison.prototype.RefreshStackCount(self, params)
	self:SetStackCount(readStackCount(nil, params, self:GetStackCount()))
	self:SetDuration(-1, false)
end
function modifier_greed_cave_player_poison.prototype.RemoveOnDeath(self)
	return false
end
function modifier_greed_cave_player_poison.prototype.IsDebuff(self)
	return true
end
function modifier_greed_cave_player_poison.prototype.IsPurgable(self)
	return false
end
function modifier_greed_cave_player_poison.prototype.GetTexture(self)
	return "viper_poison_attack"
end
modifier_greed_cave_player_poison = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_greed_cave_player_poison)
____exports.modifier_greed_cave_player_poison = modifier_greed_cave_player_poison
____exports.modifier_greed_cave_healing_down = __TS__Class()
local modifier_greed_cave_healing_down = ____exports.modifier_greed_cave_healing_down
modifier_greed_cave_healing_down.name = "modifier_greed_cave_healing_down"
__TS__ClassExtends(modifier_greed_cave_healing_down, BaseModifier_CS)
function modifier_greed_cave_healing_down.GetLocalizationCN(self)
	return { name = "恢复衰减", description = "倾天秘境词条：受到的治疗与恢复效果降低。" }
end
function modifier_greed_cave_healing_down.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:RefreshStackCount(params)
end
function modifier_greed_cave_healing_down.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:RefreshStackCount(params)
end
function modifier_greed_cave_healing_down.prototype.GetAttributeBonus(self)
	return {
		regen_amp_pct = -math.min(HEALING_DOWN_PCT_MAX, HEALING_DOWN_PCT_PER_STACK * self:GetStackCount()),
	}
end
function modifier_greed_cave_healing_down.prototype.RefreshStackCount(self, params)
	self:SetStackCount(readStackCount(nil, params, self:GetStackCount()))
	self:SetDuration(-1, false)
end
function modifier_greed_cave_healing_down.prototype.RemoveOnDeath(self)
	return false
end
function modifier_greed_cave_healing_down.prototype.IsDebuff(self)
	return true
end
function modifier_greed_cave_healing_down.prototype.IsPurgable(self)
	return false
end
function modifier_greed_cave_healing_down.prototype.GetTexture(self)
	return "item_desolator_2"
end
modifier_greed_cave_healing_down = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_greed_cave_healing_down)
____exports.modifier_greed_cave_healing_down = modifier_greed_cave_healing_down
____exports.modifier_greed_cave_monster_berserk = __TS__Class()
local modifier_greed_cave_monster_berserk = ____exports.modifier_greed_cave_monster_berserk
modifier_greed_cave_monster_berserk.name = "modifier_greed_cave_monster_berserk"
__TS__ClassExtends(modifier_greed_cave_monster_berserk, BaseModifier_CS)
function modifier_greed_cave_monster_berserk.GetLocalizationCN(self)
	return { name = "秘境狂暴", description = "倾天秘境词条：怪物造成伤害和攻击速度提高。" }
end
function modifier_greed_cave_monster_berserk.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:RefreshStackCount(params)
end
function modifier_greed_cave_monster_berserk.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:RefreshStackCount(params)
end
function modifier_greed_cave_monster_berserk.prototype.GetAttributeBonus(self)
	local stacks = self:GetStackCount()
	return {
		outgoing_damage_pct = MONSTER_BERSERK_DAMAGE_PCT_PER_STACK * stacks,
		attack_speed = MONSTER_BERSERK_ATTACK_SPEED_PER_STACK * stacks,
	}
end
function modifier_greed_cave_monster_berserk.prototype.RefreshStackCount(self, params)
	self:SetStackCount(readStackCount(nil, params, self:GetStackCount()))
	self:SetDuration(-1, false)
end
function modifier_greed_cave_monster_berserk.prototype.IsDebuff(self)
	return false
end
function modifier_greed_cave_monster_berserk.prototype.IsPurgable(self)
	return false
end
function modifier_greed_cave_monster_berserk.prototype.GetTexture(self)
	return "life_stealer_rage"
end
modifier_greed_cave_monster_berserk =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_greed_cave_monster_berserk)
____exports.modifier_greed_cave_monster_berserk = modifier_greed_cave_monster_berserk
____exports.modifier_greed_cave_monster_tough = __TS__Class()
local modifier_greed_cave_monster_tough = ____exports.modifier_greed_cave_monster_tough
modifier_greed_cave_monster_tough.name = "modifier_greed_cave_monster_tough"
__TS__ClassExtends(modifier_greed_cave_monster_tough, BaseModifier_CS)
function modifier_greed_cave_monster_tough.GetLocalizationCN(self)
	return { name = "秘境硬化", description = "倾天秘境词条：怪物获得额外伤害抵抗。" }
end
function modifier_greed_cave_monster_tough.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:RefreshStackCount(params)
end
function modifier_greed_cave_monster_tough.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:RefreshStackCount(params)
end
function modifier_greed_cave_monster_tough.prototype.GetAttributeBonus(self)
	return {
		damage_resistance_pct = math.min(
			MONSTER_TOUGH_RESISTANCE_PCT_MAX,
			MONSTER_TOUGH_RESISTANCE_PCT_PER_STACK * self:GetStackCount()
		),
	}
end
function modifier_greed_cave_monster_tough.prototype.RefreshStackCount(self, params)
	self:SetStackCount(readStackCount(nil, params, self:GetStackCount()))
	self:SetDuration(-1, false)
end
function modifier_greed_cave_monster_tough.prototype.IsDebuff(self)
	return false
end
function modifier_greed_cave_monster_tough.prototype.IsPurgable(self)
	return false
end
function modifier_greed_cave_monster_tough.prototype.GetTexture(self)
	return "dragon_knight_dragon_blood"
end
modifier_greed_cave_monster_tough = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_greed_cave_monster_tough)
____exports.modifier_greed_cave_monster_tough = modifier_greed_cave_monster_tough
return ____exports