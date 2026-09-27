--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_item_pirate_hat_custom",
	"abilities/items/neutral/item_pirate_hat_custom",
	LUA_MODIFIER_MOTION_NONE
)

local function PirateHatBonus(data, parent)
	if not data.rarity then
		return
	end
	if data.rarity ~= "gray" then
		return
	end
	if not parent:HasModifier("modifier_item_pirate_hat_custom") then
		return
	end

	return parent.pirate_hat_bonus
end

item_pirate_hat_custom = class({})

function item_pirate_hat_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end
	PrecacheResource("particle", "particles/econ/events/ti9/shovel_dig.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf", context)
end

function item_pirate_hat_custom:GetIntrinsicModifierName()
	return "modifier_item_pirate_hat_custom"
end

function item_pirate_hat_custom:Spawn()
	self.cd = self:GetSpecialValueFor("cd")
	self.bonus = self:GetSpecialValueFor("bonus")
	self.blue = self:GetSpecialValueFor("blue")
end

function item_pirate_hat_custom:OnAbilityPhaseStart()
	local caster = self:GetCaster()

	caster:StartGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	caster:EmitSound("SeasonalConsumable.TI9.Shovel.Dig")
	local position = self:GetCursorPosition()

	self.pfx = ParticleManager:CreateParticle("particles/econ/events/ti9/shovel_dig.vpcf", PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(self.pfx, 0, position)

	return treant_overgrowth
end

function item_pirate_hat_custom:OnAbilityPhaseInterrupted()
	local caster = self:GetCaster()

	caster:FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	caster:StopSound("SeasonalConsumable.TI9.Shovel.Dig")

	if not self.pfx then
		return
	end
	ParticleManager:Delete(self.pfx, 1)
	self.pfx = nil
end

function item_pirate_hat_custom:OnSpellStart()
	local caster = self:GetCaster()

	caster:FadeGesture(ACT_DOTA_GENERIC_CHANNEL_1)
	if self.pfx then
		ParticleManager:Delete(self.pfx, 1)
		self.pfx = nil
	end

	local position = self:GetCursorPosition()
	caster:StopSound("SeasonalConsumable.TI9.Shovel.Dig")
	caster:EmitSound("Alch.gold")
	self:StartCooldown(self.cd)

	dota1x6:CreateUpgradeOrb(caster, 1, position)

	caster:GenericParticle("particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf", nil, nil, { 1 })
end

modifier_item_pirate_hat_custom = class(mod_hidden)
function modifier_item_pirate_hat_custom:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.bonus = self.ability.bonus
	self.blue_bonus = self.ability.blue / 100

	self.parent.pirate_hat_bonus = self.bonus / 100
	self.parent:AddTalentIncreaseFunction("modifier_item_pirate_hat_custom", PirateHatBonus)
	self.parent:RefreshTalentIncrease()
end

function modifier_item_pirate_hat_custom:OnDestroy()
	if not IsValid(self.parent) then
		return
	end
	self.parent:RefreshTalentIncrease()
end