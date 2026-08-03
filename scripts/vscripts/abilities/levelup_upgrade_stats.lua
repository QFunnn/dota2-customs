--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_levelup_upgrade_stats_passive_artefact",
	"abilities/levelup_upgrade_stats",
	LUA_MODIFIER_MOTION_NONE
)

levelup_upgrade_stats = class({})

function levelup_upgrade_stats:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_upgrade_stats:GetIntrinsicModifierName()
	return "modifier_levelup_upgrade_stats_passive_artefact"
end

function levelup_upgrade_stats:OnSpellStart()
	if not IsServer() then
		return
	end
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		self:EndCooldown()
		return
	end

	local caster = self:GetCaster()
	if not IsValid(caster) then
		return
	end
	if not passive_artefacts_system then
		return
	end

	local upgraded = passive_artefacts_system:TryUpgradeCurrentPassiveArtefact(caster)
	if not upgraded then
		self:EndCooldown()
	else
		if services and services.OnEquipmentUpgradeSetProcs then
			services:OnEquipmentUpgradeSetProcs(caster:GetPlayerOwnerID(), caster)
		end
		if tutorial_system then
			tutorial_system:CompleteStep(caster:GetPlayerOwnerID(), "upgrade_stats")
		end
	end
end

function levelup_upgrade_stats:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end
	if not passive_artefacts_system then
		return true
	end
	return passive_artefacts_system:OnProjectileHit_ExtraData(self, target, location, extra_data)
end

modifier_levelup_upgrade_stats_passive_artefact = class({})

function modifier_levelup_upgrade_stats_passive_artefact:IsHidden()
	return true
end
function modifier_levelup_upgrade_stats_passive_artefact:IsPurgable()
	return false
end
function modifier_levelup_upgrade_stats_passive_artefact:RemoveOnDeath()
	return false
end

function modifier_levelup_upgrade_stats_passive_artefact:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.25)
end

function modifier_levelup_upgrade_stats_passive_artefact:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_levelup_upgrade_stats_passive_artefact:OnAttack(params)
	if not IsServer() then
		return
	end
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		return
	end

	local parent = self.parent
	if params.attacker ~= parent then
		return
	end
	if not parent:IsRealHero() then
		return
	end
	if (parent._levelup_extra_attack_depth or 0) > 0 then
		return
	end

	if not passive_artefacts_system then
		return
	end

	passive_artefacts_system:HandleOnAttack(parent, self.ability, params)
end

function modifier_levelup_upgrade_stats_passive_artefact:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		return
	end

	local parent = self.parent
	if params.attacker ~= parent then
		return
	end
	if not parent:IsRealHero() then
		return
	end
	if (parent._levelup_extra_attack_depth or 0) > 0 then
		return
	end

	if not passive_artefacts_system then
		return
	end

	passive_artefacts_system:HandleOnAttackLanded(parent, self.ability, params)
end

function modifier_levelup_upgrade_stats_passive_artefact:OnIntervalThink()
	if not IsServer() then
		return
	end
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		return
	end
	if not passive_artefacts_system then
		return
	end

	passive_artefacts_system:HandleIntervalThink(self.parent, self.ability)
end