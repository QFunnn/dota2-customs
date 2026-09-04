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
local ____modifier_generic_ignite = require("modifiers.debuff.modifier_generic_ignite")
local modifier_generic_ignite = ____modifier_generic_ignite.modifier_generic_ignite
local EXPLODE_PARTICLE = "particles/lina/huskar_inner_fire2.vpcf"
local CUSTOM_TAG = "item_0542_world_burn"
____exports.item_0542 = __TS__Class()
local item_0542 = ____exports.item_0542
item_0542.name = "item_0542"
__TS__ClassExtends(item_0542, BaseItem_CS)
function item_0542.prototype.Precache(self, context)
	PrecacheResource("particle", EXPLODE_PARTICLE, context)
end
function item_0542.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0542_detonator.name
end
item_0542 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0542)
____exports.item_0542 = item_0542
--- 固有被动「焚世」：对点燃满层敌人造成伤害时引爆，按最大魔法值造成魔法伤害并清空点燃。
____exports.modifier_item_0542_detonator = __TS__Class()
local modifier_item_0542_detonator = ____exports.modifier_item_0542_detonator
modifier_item_0542_detonator.name = "modifier_item_0542_detonator"
__TS__ClassExtends(modifier_item_0542_detonator, BaseModifier_CS)
function modifier_item_0542_detonator.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0542_detonator.prototype.IsHidden(self)
	return true
end
function modifier_item_0542_detonator.prototype.IsPurgable(self)
	return false
end
function modifier_item_0542_detonator.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not IsValidAlive(nil, parent) then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____opt_0 = event.source
	if (____opt_0 and ____opt_0.custom_tag) == CUSTOM_TAG then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ignite = target:FindModifierByName(modifier_generic_ignite.name)
	if not ignite then
		return
	end
	local requiredStacks = math.max(1, math.floor(ability:GetSpecialValueFor("ability_required_stacks")))
	if ignite:GetStackCount() < requiredStacks then
		return
	end
	ignite:Destroy()
	local maxMana = math.max(0, MyGameAttribute:GetAttribute(parent, "total_mana") or 0)
	local damagePct = math.max(0, ability:GetSpecialValueFor("ability_damage_pct_per_mana"))
	local damage = maxMana * (damagePct / 100)
	if damage <= 0 then
		return
	end
	self:PlayDetonateEffect(parent, target)
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = damage,
		damage_type = 2,
		ability = ability,
		extra_data = {
			damage_tags = DamageTag.NO_PROC,
			custom_tag = CUSTOM_TAG,
			source_name = self:GetName(),
		},
	})
end
function modifier_item_0542_detonator.prototype.PlayDetonateEffect(self, parent, target)
	local fx = MyGameHeroParticleManager:CreateParticle(EXPLODE_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target, parent)
	MyGameHeroParticleManager:ReleaseParticleIndex(fx)
	target:EmitSound("Hero_Huskar.Burning_Spear.Cast")
end
modifier_item_0542_detonator = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0542_detonator)
____exports.modifier_item_0542_detonator = modifier_item_0542_detonator
return ____exports