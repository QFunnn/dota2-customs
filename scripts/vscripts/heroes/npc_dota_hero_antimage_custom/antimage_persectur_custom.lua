--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_antimage_persectur_custom", "heroes/npc_dota_hero_antimage_custom/antimage_persectur_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_antimage_persectur_custom_slow", "heroes/npc_dota_hero_antimage_custom/antimage_persectur_custom", LUA_MODIFIER_MOTION_NONE )

antimage_persectur_custom = class({})
antimage_persectur_custom.modifier_antimage_4 = {10,20,30}
antimage_persectur_custom.modifier_antimage_4_minmax = {2,4,6}

function antimage_persectur_custom:GetIntrinsicModifierName()
	return "modifier_antimage_persectur_custom"
end

modifier_antimage_persectur_custom = class({})
function modifier_antimage_persectur_custom:IsHidden() return true end
function modifier_antimage_persectur_custom:IsPurgable() return false end
function modifier_antimage_persectur_custom:RemoveOnDeath() return false end

function modifier_antimage_persectur_custom:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if self:GetParent():PassivesDisabled() then return end
	local target = params.target
	if not target then return end
	if target:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
	if target:IsBuilding() or target:IsOther() then return end
	if target:IsDebuffImmune() then return end
	if target:GetMaxMana() <= 0 then return end
    local mana_threshold = self:GetAbility():GetSpecialValueFor("mana_threshold")
    if self:GetCaster():HasModifier("modifier_antimage_4") then
        mana_threshold = mana_threshold + self:GetAbility().modifier_antimage_4[self:GetCaster():GetTalentLevel("modifier_antimage_4")]
    end
    local max_mana = target:GetMaxMana()
    local current_mana_pct = target:GetMana() / max_mana * 100
    if current_mana_pct > mana_threshold then return end
	local duration = self:GetAbility():GetSpecialValueFor("slow_duration")
	target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_antimage_persectur_custom_slow", { duration = duration * (1 - target:GetStatusResistance()) })
end

modifier_antimage_persectur_custom_slow = class({})
function modifier_antimage_persectur_custom_slow:IsPurgable() return true end
function modifier_antimage_persectur_custom_slow:IsDebuff() return true end

function modifier_antimage_persectur_custom_slow:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_antimage_persectur_custom_slow:GetModifierMoveSpeedBonus_Percentage()
	local ability = self:GetAbility()
	if not ability then return 0 end
	local parent = self:GetParent()
	local max_mana = parent:GetMaxMana()
	if max_mana <= 0 then return 0 end
	local min_slow = ability:GetSpecialValueFor("move_slow_min")
	local max_slow = ability:GetSpecialValueFor("move_slow_max")
	local mana_threshold = ability:GetSpecialValueFor("mana_threshold")
    if self:GetCaster():HasModifier("modifier_antimage_4") then
        min_slow = min_slow + self:GetAbility().modifier_antimage_4_minmax[self:GetCaster():GetTalentLevel("modifier_antimage_4")]
        max_slow = max_slow + self:GetAbility().modifier_antimage_4_minmax[self:GetCaster():GetTalentLevel("modifier_antimage_4")]
        mana_threshold = mana_threshold + self:GetAbility().modifier_antimage_4[self:GetCaster():GetTalentLevel("modifier_antimage_4")]
    end
	local current_mana_pct = parent:GetMana() / max_mana * 100
	if current_mana_pct >= mana_threshold then
		return -min_slow
	end
	local missing_below_threshold = mana_threshold - current_mana_pct
	local slow_pct = min_slow + (max_slow - min_slow) * (missing_below_threshold / mana_threshold)
	return -slow_pct
end