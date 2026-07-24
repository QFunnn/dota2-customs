--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sniper_take_aim_custom", "heroes/hero_sniper/sniper_take_aim_custom", LUA_MODIFIER_MOTION_NONE )

sniper_take_aim_custom = class({})

function sniper_take_aim_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():EmitSound("Hero_Sniper.TakeAim.Cast")
	local duration = self:GetSpecialValueFor("duration") + self:GetCaster():FindTalentValue("special_bonus_unique_sniper_4")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_sniper_take_aim_bonus", {duration = duration, slow = self:GetSpecialValueFor("slow"), headshot_chance = self:GetSpecialValueFor("headshot_chance")})
end

function sniper_take_aim_custom:GetIntrinsicModifierName()
	return "modifier_sniper_take_aim_custom"
end

modifier_sniper_take_aim_custom = class({})

function modifier_sniper_take_aim_custom:IsHidden()
	return true
end

function modifier_sniper_take_aim_custom:IsPurgable()
	return false
end

function modifier_sniper_take_aim_custom:RemoveOnDeath() return false end

function modifier_sniper_take_aim_custom:OnCreated( kv )
	self.bonus_attack_range = self:GetAbility():GetSpecialValueFor( "bonus_attack_range" )
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_sniper_headshot", {})
    self:StartIntervalThink(1)
end

function modifier_sniper_take_aim_custom:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetParent():HasModifier("modifier_sniper_headshot") then
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_sniper_headshot", {})
    end
end

function modifier_sniper_take_aim_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_sniper_headshot")
end

function modifier_sniper_take_aim_custom:OnRefresh( kv )
	self.bonus_attack_range = self:GetAbility():GetSpecialValueFor( "bonus_attack_range" )

	if not IsServer() then return end
	self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_sniper_headshot", {})
end

function modifier_sniper_take_aim_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
	return funcs
end

function modifier_sniper_take_aim_custom:GetModifierAttackRangeBonus()
	if self:GetParent():PassivesDisabled() then return end
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_sniper_take_aim_bonus") then
		bonus = self:GetAbility():GetSpecialValueFor("bonus_attack_range_active")
	end
	return self.bonus_attack_range + bonus + self:GetCaster():FindTalentValue("special_bonus_unique_sniper_6")
end