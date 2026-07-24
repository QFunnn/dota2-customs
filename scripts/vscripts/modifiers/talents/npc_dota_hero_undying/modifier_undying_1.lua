--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_undying_1_aura", "modifiers/talents/npc_dota_hero_undying/modifier_undying_1", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_undying_1_aura_damage", "modifiers/talents/npc_dota_hero_undying/modifier_undying_1", LUA_MODIFIER_MOTION_NONE)

modifier_undying_1=class({})

function modifier_undying_1:IsHidden() return true end
function modifier_undying_1:IsPurgable() return false end
function modifier_undying_1:IsPurgeException() return false end
function modifier_undying_1:RemoveOnDeath() return false end

function modifier_undying_1:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local undying_soul_rip_custom = self:GetParent():FindAbilityByName("undying_soul_rip_custom")
	if undying_soul_rip_custom then
		undying_soul_rip_custom:SetLevel(0)
		undying_soul_rip_custom:SetActivated(false)
		undying_soul_rip_custom:SetHidden(true)
	end
	self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_undying_1_aura", {})
end

function modifier_undying_1:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_undying_1:GetEffectName()
	return "particles/undying_debuff_1.vpcf"
end

function modifier_undying_1:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_undying_1_aura = class({})

function modifier_undying_1_aura:IsAura() return true end
function modifier_undying_1_aura:IsAuraActiveOnDeath() return false end
function modifier_undying_1_aura:GetAuraDuration() return 0 end
function modifier_undying_1_aura:RemoveOnDeath() return false end

function modifier_undying_1_aura:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY 
end

function modifier_undying_1_aura:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_undying_1_aura:GetModifierAura()
    return "modifier_undying_1_aura_damage"
end

function modifier_undying_1_aura:GetTexture() return "undying_1" end

function modifier_undying_1_aura:GetAuraRadius()
    return 400
end

modifier_undying_1_aura_damage = class({})

function modifier_undying_1_aura_damage:GetTexture() return "undying_1" end

function modifier_undying_1_aura_damage:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(1)
end

function modifier_undying_1_aura_damage:OnIntervalThink()
	if not IsServer() then return end
	local bonus = {12,24,36}
	local damage = self:GetCaster():GetStrength() / 100 * bonus[self:GetCaster():GetTalentLevel("modifier_undying_1")]
	local undying_soul_rip_custom = self:GetCaster():FindAbilityByName("undying_soul_rip_custom")
	if undying_soul_rip_custom then
		ApplyDamage({ victim = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK, attacker = self:GetCaster(), ability = undying_soul_rip_custom})
	end
end







