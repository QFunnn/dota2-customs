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
____exports.item_0373 = __TS__Class()
local item_0373 = ____exports.item_0373
item_0373.name = "item_0373"
__TS__ClassExtends(item_0373, BaseItem_CS)
function item_0373.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0373_blood_blade.name
end
item_0373 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0373)
____exports.item_0373 = item_0373
____exports.modifier_item_0373_blood_blade = __TS__Class()
local modifier_item_0373_blood_blade = ____exports.modifier_item_0373_blood_blade
modifier_item_0373_blood_blade.name = "modifier_item_0373_blood_blade"
__TS__ClassExtends(modifier_item_0373_blood_blade, BaseModifier_CS)
function modifier_item_0373_blood_blade.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0373_blood_blade.prototype.OnTakeDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent then
		return
	end
	if not event.is_crit or (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____CheckTag_2 = CheckTag
	local ____opt_0 = event.source
	if ____CheckTag_2(nil, ____opt_0 and ____opt_0.damage_tags, DamageTag.DOT) then
		return
	end
	local target = event.victim
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability_restore_max_health_pct = math.max(0, ability:GetSpecialValueFor("ability_restore_max_health_pct"))
	local healAmount = parent:GetMaxHealth() * (ability_restore_max_health_pct / 100)
	if healAmount <= 0 then
		return
	end
	parent:CustomHeal(healAmount, { ability = ability, source = "item" })
	self:PlayEffects1(parent)
end
function modifier_item_0373_blood_blade.prototype.IsHidden(self)
	return true
end
function modifier_item_0373_blood_blade.prototype.IsPurgable(self)
	return false
end
function modifier_item_0373_blood_blade.prototype.PlayEffects1(self, parent)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/items3_fx/octarine_core_lifesteal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		parent:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("DOTA_Item.Satanic.Activate", parent)
end
modifier_item_0373_blood_blade = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0373_blood_blade)
____exports.modifier_item_0373_blood_blade = modifier_item_0373_blood_blade
return ____exports