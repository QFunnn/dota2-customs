--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_sven_gods_strength_custom_fly", "abilities/sven_gods_strength_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_infinite_form_mana_drain", "modifiers/modifier_infinite_form_mana_drain", LUA_MODIFIER_MOTION_NONE)

sven_gods_strength_custom = class({})

function sven_gods_strength_custom:OnToggle() 
	if not IsServer() then return end

	local modifier_sven_gods_strength = self:GetCaster():FindModifierByName("modifier_sven_gods_strength")

	if not self:GetToggleState() then
		if modifier_sven_gods_strength then
			modifier_sven_gods_strength:Destroy()
		end
	else
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sven_gods_strength", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sven_gods_strength_custom_fly", {})
		self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_infinite_form_mana_drain", {}) -- [MF-16] общий дрейн 3%/сек
	end

	self:EndCooldown()
	self:StartCooldown(1) 
end

function sven_gods_strength_custom:GetCooldown(iLevel)
	if self:GetCaster():HasScepter() then
		return 0
	end
	return self.BaseClass.GetCooldown(self, iLevel) 
end

function sven_gods_strength_custom:GetBehavior()
  	if self:GetCaster():HasScepter() then
    	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_TOGGLE + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
   	end
 	return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE 
end

function sven_gods_strength_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sven_gods_strength", {duration = self:GetSpecialValueFor("duration")})
end

modifier_sven_gods_strength_custom_fly = class({})

function modifier_sven_gods_strength_custom_fly:IsHidden() return true end
function modifier_sven_gods_strength_custom_fly:IsPurgable() return false end
function modifier_sven_gods_strength_custom_fly:IsPurgeException() return false end

function modifier_sven_gods_strength_custom_fly:OnCreated()
	if not IsServer() then return end
    self.caster = self:GetCaster()
	self:StartIntervalThink(0.5)
end

function modifier_sven_gods_strength_custom_fly:OnIntervalThink()
	if not IsServer() then return end
	if not self.caster:HasModifier("modifier_sven_gods_strength") then
		self:Destroy()
	end
    if not self.caster:HasScepter() then
        self.caster:RemoveModifierByName("modifier_sven_gods_strength")
    end
end

function modifier_sven_gods_strength_custom_fly:CheckState()
	if not self.caster:HasScepter() then return end
	return 
	{
		[MODIFIER_STATE_FLYING] = true,
		-- [A61] без NO_UNIT_COLLISION летающий блокирует наземного врага (коллизия на земле) → застакивание/ловушка в дуэли
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end