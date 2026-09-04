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
local ____dark_domain_lightning_flash = require("my_game_axe.room.dark_domain_lightning_flash")
local TriggerDarkDomainLightningFlash = ____dark_domain_lightning_flash.TriggerDarkDomainLightningFlash
local ITEM_0275_LIGHTNING_PFX = "particles/items_fx/chain_lightning.vpcf"
____exports.item_0275 = __TS__Class()
local item_0275 = ____exports.item_0275
item_0275.name = "item_0275"
__TS__ClassExtends(item_0275, BaseItem_CS)
function item_0275.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0275_stormcrafter.name
end
item_0275 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0275)
____exports.item_0275 = item_0275
____exports.modifier_item_0275_stormcrafter = __TS__Class()
local modifier_item_0275_stormcrafter = ____exports.modifier_item_0275_stormcrafter
modifier_item_0275_stormcrafter.name = "modifier_item_0275_stormcrafter"
__TS__ClassExtends(modifier_item_0275_stormcrafter, BaseModifier_CS)
function modifier_item_0275_stormcrafter.prototype.IsHidden(self)
	return true
end
function modifier_item_0275_stormcrafter.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.5)
end
function modifier_item_0275_stormcrafter.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local ability_radius = ability:GetSpecialValue("item_0275", "ability_radius")
	local ability_target_count = ability:GetSpecialValue("item_0275", "ability_target_count")
	local ability_damage = ability:GetSpecialValue("item_0275", "ability_damage")
	local ability_slow_pct = ability:GetSpecialValue("item_0275", "ability_slow_pct")
	local ability_slow_duration = ability:GetSpecialValue("item_0275", "ability_slow_duration")
	local ability_cooldown = ability:GetSpecialValue("item_0275", "ability_cooldown")
	if ability_radius <= 0 or ability_target_count <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	if not enemies or #enemies <= 0 then
		return
	end
	local hitCount = 0
	for ____, enemy in ipairs(enemies) do
		do
			if hitCount >= ability_target_count then
				break
			end
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue12
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = ability_damage,
				damage_type = 2,
				ability = ability,
			})
			if ability_slow_pct > 0 and ability_slow_duration > 0 then
				enemy:AddNewModifier(
					parent,
					ability,
					____exports.modifier_item_0275_shocked_slow.name,
					{ duration = ability_slow_duration, ability_slow_pct = ability_slow_pct }
				)
			end
			self:PlayEffects1(parent, enemy)
			TriggerDarkDomainLightningFlash(nil, parent, enemy)
			hitCount = hitCount + 1
		end
		::__continue12::
	end
	if hitCount > 0 and ability_cooldown > 0 then
		ability:StartCooldown(ability_cooldown)
	end
end
function modifier_item_0275_stormcrafter.prototype.PlayEffects1(self, caster, target)
	local particle =
		MyGameHeroParticleManager:CreateParticle(ITEM_0275_LIGHTNING_PFX, PATTACH_ABSORIGIN_FOLLOW, caster, caster)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	target:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")
end
modifier_item_0275_stormcrafter = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0275_stormcrafter)
____exports.modifier_item_0275_stormcrafter = modifier_item_0275_stormcrafter
____exports.modifier_item_0275_shocked_slow = __TS__Class()
local modifier_item_0275_shocked_slow = ____exports.modifier_item_0275_shocked_slow
modifier_item_0275_shocked_slow.name = "modifier_item_0275_shocked_slow"
__TS__ClassExtends(modifier_item_0275_shocked_slow, BaseModifier_CS)
function modifier_item_0275_shocked_slow.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.slowPct = 0
end
function modifier_item_0275_shocked_slow.GetLocalizationCN(self)
	return { name = "瓶装闪电", description = "移动速度降低。" }
end
function modifier_item_0275_shocked_slow.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.slowPct = math.max(0, tonumber(params.ability_slow_pct or 0))
	self:RefreshAttributes()
end
function modifier_item_0275_shocked_slow.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self.slowPct = math.max(0, tonumber(params.ability_slow_pct or self.slowPct))
	self:RefreshAttributes()
end
function modifier_item_0275_shocked_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -self.slowPct }
end
function modifier_item_0275_shocked_slow.prototype.IsHidden(self)
	return false
end
function modifier_item_0275_shocked_slow.prototype.IsDebuff(self)
	return true
end
function modifier_item_0275_shocked_slow.prototype.IsPurgable(self)
	return true
end
function modifier_item_0275_shocked_slow.prototype.GetTexture(self)
	return "item_stormcrafter"
end
modifier_item_0275_shocked_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0275_shocked_slow)
____exports.modifier_item_0275_shocked_slow = modifier_item_0275_shocked_slow
return ____exports