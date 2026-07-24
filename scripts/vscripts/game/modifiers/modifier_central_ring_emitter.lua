--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_central_ring_emitter = class({})
LinkLuaModifier("modifier_central_ring", "game/modifiers/modifier_central_ring_emitter", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_central_ring_truesight", "game/modifiers/modifier_central_ring_emitter", LUA_MODIFIER_MOTION_NONE)

function modifier_central_ring_emitter:IsHidden() return true end
function modifier_central_ring_emitter:IsPurgable() return false end
function modifier_central_ring_emitter:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_central_ring_emitter:IsAura() return true end
function modifier_central_ring_emitter:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD end
function modifier_central_ring_emitter:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_BOTH end
function modifier_central_ring_emitter:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_central_ring_emitter:GetModifierAura() return "modifier_central_ring" end
function modifier_central_ring_emitter:GetAuraRadius()
	if not IsServer() then return 0 end

	return GameLoop.current_layout.ring_radius or 1000
end


modifier_central_ring = class({})

function modifier_central_ring:IsHidden() return false end
function modifier_central_ring:IsDebuff() return false end
function modifier_central_ring:IsPurgable() return false end
function modifier_central_ring:GetTexture() return "xp_coin" end
function modifier_central_ring:GetPriority() return MODIFIER_PRIORITY_HIGH end


function modifier_central_ring:OnCreated()
	if not IsServer() then return end

	local parent = self:GetParent()
	if IsValidEntity(parent) then
		parent:AddNewModifier(parent, nil, "modifier_central_ring_truesight", {duration = -1})
	end
end


function modifier_central_ring:OnDestroy()
	if not IsServer() then return end

	local parent = self:GetParent()
	if IsValidEntity(parent) then
		parent:RemoveModifierByName("modifier_central_ring_truesight")
	end
end


function modifier_central_ring:GetEffectName() return "particles/items2_fx/true_sight_debuff.vpcf" end
function modifier_central_ring:GetEffectAttachType() return PATTACH_OVERHEAD_FOLLOW end

modifier_central_ring_truesight = modifier_central_ring_truesight or class({})

function modifier_central_ring_truesight:GetTexture() return "item_gem" end
function modifier_central_ring_truesight:IsHidden() return false end
function modifier_central_ring_truesight:IsPurgable() return false end
function modifier_central_ring_truesight:GetAttributes() return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end
function modifier_central_ring_truesight:GetPriority() return MODIFIER_PRIORITY_HIGH end

function modifier_central_ring_truesight:CheckState()
	return {
		[MODIFIER_STATE_INVISIBLE] = false,
	}
end