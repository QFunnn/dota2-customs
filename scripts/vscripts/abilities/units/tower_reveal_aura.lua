--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tower_reveal_aura", "abilities/units/tower_reveal_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tower_reveal", "abilities/units/tower_reveal_aura", LUA_MODIFIER_MOTION_NONE)
tower_reveal_aura = class({})

function tower_reveal_aura:GetIntrinsicModifierName()
	return "modifier_tower_reveal_aura"
end

-------

modifier_tower_reveal_aura = class({})

function modifier_tower_reveal_aura:IsHidden() return true end
function modifier_tower_reveal_aura:IsAura() return true end
function modifier_tower_reveal_aura:GetAuraRadius() return self:GetParent():GetCurrentVisionRange() end
function modifier_tower_reveal_aura:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_tower_reveal_aura:GetAuraSearchType() return DOTA_UNIT_TARGET_ALL end
function modifier_tower_reveal_aura:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES end
function modifier_tower_reveal_aura:GetAuraDuration() return 0.1 end
function modifier_tower_reveal_aura:GetModifierAura() return "modifier_tower_reveal" end

function modifier_tower_reveal_aura:GetAuraEntityReject(entity)
	return entity.HasModifier and (entity:HasModifier("modifier_slark_depth_shroud") or entity:HasModifier("modifier_slark_shadow_dance") or entity:HasModifier("modifier_phantom_assassin_blur_active") or entity:HasModifier("modifier_smoke_of_deceit"))
end

function modifier_tower_reveal_aura:GetEffectName() return "particles/items_fx/necronomicon_true_sight.vpcf" end
function modifier_tower_reveal_aura:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

-------

modifier_tower_reveal = class({})

function modifier_tower_reveal:GetTexture() return "item_gem" end
function modifier_tower_reveal:IsPurgable() return false end
function modifier_tower_reveal:IsDebuff() return true end
function modifier_tower_reveal:GetPriority() return MODIFIER_PRIORITY_SUPER_ULTRA end

function modifier_tower_reveal:GetEffectName() return "particles/items2_fx/true_sight_debuff.vpcf" end
function modifier_tower_reveal:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

function modifier_tower_reveal:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = false
	}
end