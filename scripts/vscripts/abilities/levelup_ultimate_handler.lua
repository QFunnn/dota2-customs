--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_levelup_ultimate_handler", "abilities/levelup_ultimate_handler", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_ultimate_luna_attack_speed",
	"modifiers/modifier_ultimate_luna_attack_speed",
	LUA_MODIFIER_MOTION_NONE
)

levelup_ultimate_handler = class({})

function levelup_ultimate_handler:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_ultimate_handler:GetIntrinsicModifierName()
	return "modifier_levelup_ultimate_handler"
end

function levelup_ultimate_handler:GetManaCost(level)
	return 0
end

function levelup_ultimate_handler:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return false
	end
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		return false
	end
	if not card_system then
		return false
	end
	return card_system:OnProjectileHit_ExtraData(self, target, location, extra_data)
end

modifier_levelup_ultimate_handler = class({})

function modifier_levelup_ultimate_handler:IsHidden()
	return true
end
function modifier_levelup_ultimate_handler:IsPurgable()
	return false
end
function modifier_levelup_ultimate_handler:RemoveOnDeath()
	return false
end

function modifier_levelup_ultimate_handler:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_levelup_ultimate_handler:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		return
	end
	if not card_system then
		return
	end

	local player_id = self.parent:GetPlayerOwnerID()
	local ultimate_data = card_system:GetUltimateData(player_id)
	if ultimate_data.current_ultimate_id then
		card_system:InitUltimatePlayer(self.parent)
	end
end

function modifier_levelup_ultimate_handler:OnAttack(params)
	if not IsServer() then
		return
	end
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		return
	end
	if not card_system then
		return
	end

	local parent = self.parent
	if params.attacker ~= parent then
		return
	end

	card_system:HandleRuntimeByTrigger(parent, "on_attack", params, self.ability)
end

function modifier_levelup_ultimate_handler:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		return
	end
	if not card_system then
		return
	end

	local parent = self.parent
	if params.attacker ~= parent then
		return
	end

	if params.levelup_skip_attack_damage ~= true then
		card_system:HandleRuntimeByTrigger(parent, "on_attack_landed", params, self.ability)
	end
	card_system:HandleRuntimeAuxOnAttackLanded(parent, params, self.ability)
end