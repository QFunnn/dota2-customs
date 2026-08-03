--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


levelup_upgrade_artifacts = class({})

local LEVELUP_UPGRADE_ARTIFACTS_BASE_COOLDOWN = 120

local function GetBaseCooldown(ability, level)
	if ability and ability.BaseClass and ability.BaseClass.GetCooldown then
		return tonumber(ability.BaseClass.GetCooldown(ability, level)) or LEVELUP_UPGRADE_ARTIFACTS_BASE_COOLDOWN
	end
	return LEVELUP_UPGRADE_ARTIFACTS_BASE_COOLDOWN
end

function levelup_upgrade_artifacts:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
	self:SetActivated(false)
end

function levelup_upgrade_artifacts:GetCooldown(level)
	local cooldown = GetBaseCooldown(self, level)
	local caster = self:GetCaster()
	local hero_handler = IsValid(caster)
			and caster.GetLevelUpHeroHandlerModifier
			and caster:GetLevelUpHeroHandlerModifier()
		or nil
	local cooldown_reduction = hero_handler
			and hero_handler.GetCustomPassiveArtefactCooldownReduction
			and hero_handler:GetCustomPassiveArtefactCooldownReduction()
		or 0
	return cooldown * math.max(0, 1 - cooldown_reduction * 0.01)
end

function levelup_upgrade_artifacts:OnSpellStart()
	if not IsServer() then
		return
	end
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		self:EndCooldown()
		return
	end
	if wave_manager and wave_manager.IsPostStageActive and wave_manager:IsPostStageActive() then
		self:EndCooldown()
		return
	end

	local caster = self:GetCaster()
	if not IsValid(caster) then
		return
	end
	if not passive_artefacts_system then
		self:EndCooldown()
		return
	end

	local started = passive_artefacts_system:TryStartMainArtefactTrial(caster)
	if not started then
		self:EndCooldown()
	elseif tutorial_system then
		tutorial_system:CompleteStep(caster:GetPlayerOwnerID(), "upgrade_artifacts")
	end
end