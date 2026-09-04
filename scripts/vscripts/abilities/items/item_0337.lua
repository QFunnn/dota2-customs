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
____exports.item_0337 = __TS__Class()
local item_0337 = ____exports.item_0337
item_0337.name = "item_0337"
__TS__ClassExtends(item_0337, BaseItem_CS)
function item_0337.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/generic_gameplay/rune_arcane_owner.vpcf", context)
	PrecacheResource("particle", "particles/items2_fx/veil_of_discord.vpcf", context)
end
function item_0337.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0337_archmage_mask.name
end
item_0337 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0337)
____exports.item_0337 = item_0337
____exports.modifier_item_0337_archmage_mask = __TS__Class()
local modifier_item_0337_archmage_mask = ____exports.modifier_item_0337_archmage_mask
modifier_item_0337_archmage_mask.name = "modifier_item_0337_archmage_mask"
__TS__ClassExtends(modifier_item_0337_archmage_mask, BaseModifier_CS)
function modifier_item_0337_archmage_mask.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_AFTER_ABILITY_FULLY_CAST }
end
function modifier_item_0337_archmage_mask.prototype.IsHidden(self)
	return true
end
function modifier_item_0337_archmage_mask.prototype.IsPurgable(self)
	return false
end
function modifier_item_0337_archmage_mask.prototype.OnAfterAbilityFullyCast_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	if event.caster ~= parent:GetEntityIndex() then
		return
	end
	local castAbility = EntIndexToHScript(event.ability_index)
	if not castAbility or not IsValid(nil, castAbility) or castAbility:IsNull() then
		return
	end
	local ____opt_0 = castAbility.IsItem
	if ____opt_0 and ____opt_0(castAbility) then
		return
	end
	local ____opt_2 = castAbility.IsToggle
	if ____opt_2 and ____opt_2(castAbility) then
		return
	end
	local ability_duration = ability:GetSpecialValueFor("ability_duration")
	if ability_duration <= 0 then
		return
	end
	parent:AddNewModifier(
		parent,
		ability,
		____exports.modifier_item_0337_archmage_focus.name,
		{ duration = ability_duration }
	)
end
modifier_item_0337_archmage_mask = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0337_archmage_mask)
____exports.modifier_item_0337_archmage_mask = modifier_item_0337_archmage_mask
____exports.modifier_item_0337_archmage_focus = __TS__Class()
local modifier_item_0337_archmage_focus = ____exports.modifier_item_0337_archmage_focus
modifier_item_0337_archmage_focus.name = "modifier_item_0337_archmage_focus"
__TS__ClassExtends(modifier_item_0337_archmage_focus, BaseModifier_CS)
function modifier_item_0337_archmage_focus.GetLocalizationCN(self)
	return { name = "大魔导", description = "技能伤害提升，叠满后释放奥术爆发。" }
end
function modifier_item_0337_archmage_focus.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:RefreshAttributes()
	self:PlayEffects1(self:GetParent())
end
function modifier_item_0337_archmage_focus.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local ability_max_stacks = math.floor(ability:GetSpecialValueFor("ability_max_stacks"))
	if ability_max_stacks <= 0 then
		return
	end
	local nextStacks = self:GetStackCount() + 1
	if nextStacks >= ability_max_stacks then
		self:SetStackCount(0)
		self:RefreshAttributes()
		self:TriggerArchmageBurst(parent, ability)
		self:Destroy()
		return
	end
	self:SetStackCount(nextStacks)
	self:RefreshAttributes()
	self:PlayEffects1(parent)
end
function modifier_item_0337_archmage_focus.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0337_archmage_focus.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, ability) then
		return {}
	end
	local ability_spell_amplify_pct_per_stack = ability:GetSpecialValueFor("ability_value_spell_amplify_pct_per_stack")
	return { spell_amplify_pct = self:GetStackCount() * ability_spell_amplify_pct_per_stack }
end
function modifier_item_0337_archmage_focus.prototype.IsHidden(self)
	return self:GetStackCount() <= 0
end
function modifier_item_0337_archmage_focus.prototype.IsDebuff(self)
	return false
end
function modifier_item_0337_archmage_focus.prototype.IsPurgable(self)
	return false
end
function modifier_item_0337_archmage_focus.prototype.GetTexture(self)
	return "item_icon_34"
end
function modifier_item_0337_archmage_focus.prototype.TriggerArchmageBurst(self, parent, ability)
	local ability_radius = ability:GetSpecialValueFor("ability_radius")
	local ability_burst_int_damage_pct = ability:GetSpecialValueFor("ability_value_burst_int_damage_pct")
	if ability_radius <= 0 or ability_burst_int_damage_pct <= 0 then
		return
	end
	local intelligence = MyGameAttribute:GetAttribute(parent, "total_intelligence") or 0
	local damage = intelligence * ability_burst_int_damage_pct / 100
	if damage <= 0 then
		return
	end
	self:PlayEffects2(parent, ability_radius)
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue34
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = damage,
				damage_type = 2,
				ability = ability,
			})
		end
		::__continue34::
	end
end
function modifier_item_0337_archmage_focus.prototype.PlayEffects1(self, parent)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/generic_gameplay/rune_arcane_owner.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:DestroyParticle(particle, false)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	parent:EmitSound("DOTA_Item.ArcaneBoots.Activate")
end
function modifier_item_0337_archmage_focus.prototype.GetEffectName(self)
	return "particles/generic_gameplay/rune_arcane_owner.vpcf"
end
function modifier_item_0337_archmage_focus.prototype.PlayEffects2(self, parent, radius)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/items2_fx/veil_of_discord.vpcf",
		PATTACH_WORLDORIGIN,
		nil,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	parent:EmitSound("DOTA_Item.Dagon.Activate")
end
modifier_item_0337_archmage_focus = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0337_archmage_focus)
____exports.modifier_item_0337_archmage_focus = modifier_item_0337_archmage_focus
return ____exports