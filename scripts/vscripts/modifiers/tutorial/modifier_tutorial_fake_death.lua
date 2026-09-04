--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_generic_fake_death = require("modifiers.modifier_generic_fake_death")
local modifier_generic_fake_death_coffin_presentation =
	____modifier_generic_fake_death.modifier_generic_fake_death_coffin_presentation
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local TUTORIAL_FAKE_DEATH_DOWNED_DURATION = 1.5
local TUTORIAL_FAKE_DEATH_TOMBSTONE_PARTICLE = "particles/death_tombstonereincarn_tombstone.vpcf"
--- 迟到玩家等待当前教程战斗结算时使用的不可操作状态。
____exports.modifier_tutorial_deferred_entry_waiting = __TS__Class()
local modifier_tutorial_deferred_entry_waiting = ____exports.modifier_tutorial_deferred_entry_waiting
modifier_tutorial_deferred_entry_waiting.name = "modifier_tutorial_deferred_entry_waiting"
__TS__ClassExtends(modifier_tutorial_deferred_entry_waiting, BaseModifier_CS)
function modifier_tutorial_deferred_entry_waiting.prototype.IsHidden(self)
	return true
end
function modifier_tutorial_deferred_entry_waiting.prototype.IsPurgable(self)
	return false
end
function modifier_tutorial_deferred_entry_waiting.prototype.IsPurgeException(self)
	return false
end
function modifier_tutorial_deferred_entry_waiting.prototype.IsPermanent(self)
	return true
end
function modifier_tutorial_deferred_entry_waiting.prototype.RemoveOnDeath(self)
	return false
end
function modifier_tutorial_deferred_entry_waiting.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:GetParent():Stop()
end
function modifier_tutorial_deferred_entry_waiting.prototype.OnRefresh(self)
	self:OnCreated()
end
function modifier_tutorial_deferred_entry_waiting.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}
end
modifier_tutorial_deferred_entry_waiting =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_tutorial_deferred_entry_waiting)
____exports.modifier_tutorial_deferred_entry_waiting = modifier_tutorial_deferred_entry_waiting
--- 教程专属倒地状态。
-- 该状态只限制教程战斗行为，不参与项目通用 IsAlive 逻辑死亡判断。
____exports.modifier_tutorial_fake_death = __TS__Class()
local modifier_tutorial_fake_death = ____exports.modifier_tutorial_fake_death
modifier_tutorial_fake_death.name = "modifier_tutorial_fake_death"
__TS__ClassExtends(modifier_tutorial_fake_death, BaseModifier_CS)
function modifier_tutorial_fake_death.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.rescuerIndices = {}
	self.movablePresentationStarted = false
end
function modifier_tutorial_fake_death.prototype.GetAttributeBonus(self)
	return { disable_heal = 1 }
end
function modifier_tutorial_fake_death.prototype.IsPurgable(self)
	return false
end
function modifier_tutorial_fake_death.prototype.IsPurgeException(self)
	return false
end
function modifier_tutorial_fake_death.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	parent:Purge(false, true, false, true, true)
	parent:SetHealth(1)
	parent:StartGestureWithPlaybackRate(ACT_DOTA_DIE, 1)
	self:PlayDownEffects()
	local playerId = parent:GetPlayerOwnerID()
	if not (MyGameTutorialManager and MyGameTutorialManager:HasLivingTutorialCombatTeammate(playerId, parent)) then
		self:PlayTombstoneEffect()
	end
	parent:AddNewModifier(
		parent,
		nil,
		"modifier_invulnerable_and_hide_health_bar",
		{ duration = TUTORIAL_FAKE_DEATH_DOWNED_DURATION }
	)
	self:Timer(0.1, function()
		SlowDownServerRate(nil, 0.35, 0.1)
	end)
	ScreenShake(parent:GetAbsOrigin(), 35, 35, 0.2, 1500, 0, true)
	self:StartIntervalThink(0.1)
	self:Timer(TUTORIAL_FAKE_DEATH_DOWNED_DURATION, function()
		if not IsValid(nil, self) or self:IsNull() then
			return
		end
		local currentParent = self:GetParent()
		if not currentParent or not IsValid(nil, currentParent) or currentParent:IsNull() then
			return
		end
		if currentParent:FindModifierByName("modifier_tutorial_fake_death") ~= self then
			return
		end
		local playerId = currentParent:GetPlayerOwnerID()
		if
			not (
				MyGameTutorialManager and MyGameTutorialManager:HasLivingTutorialCombatTeammate(playerId, currentParent)
			)
		then
			return
		end
		self.movablePresentationStarted = true
		currentParent:FadeGesture(ACT_DOTA_DIE)
		modifier_generic_fake_death_coffin_presentation:applys(currentParent, currentParent, self:GetAbility(), {})
		self:ForceRefresh()
	end)
	if MyGameTutorialManager ~= nil then
		MyGameTutorialManager:OnTutorialHeroDowned(playerId, parent)
	end
end
function modifier_tutorial_fake_death.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	modifier_generic_fake_death_coffin_presentation:remove(parent)
	parent:FadeGesture(ACT_DOTA_DIE)
	parent:Stop()
	parent:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 1)
	parent:AddNewModifier(parent, self:GetAbility(), "modifier_tutorial_recover_invulnerable", { duration = 3 })
	self:PlayRecoverEffect()
end
function modifier_tutorial_fake_death.prototype.AddRescuer(self, rescuerIndex)
	if not IsServer() or rescuerIndex <= 0 then
		return
	end
	if __TS__ArrayIndexOf(self.rescuerIndices, rescuerIndex) ~= -1 then
		return
	end
	local ____self_rescuerIndices_6 = self.rescuerIndices
	____self_rescuerIndices_6[#____self_rescuerIndices_6 + 1] = rescuerIndex
end
function modifier_tutorial_fake_death.prototype.RemoveRescuer(self, rescuerIndex)
	if not IsServer() or rescuerIndex <= 0 then
		return
	end
	local index = __TS__ArrayIndexOf(self.rescuerIndices, rescuerIndex)
	if index == -1 then
		return
	end
	__TS__ArraySplice(self.rescuerIndices, index, 1)
end
function modifier_tutorial_fake_death.prototype.PruneInvalidRescuers(self, parent)
	local validRescuerIndices = {}
	for ____, rescuerIndex in ipairs(self.rescuerIndices) do
		do
			local rescuer = EntIndexToHScript(rescuerIndex)
			if not rescuer or not IsValid(nil, rescuer) or rescuer:IsNull() or not IsValidAlive(nil, rescuer) then
				goto __continue33
			end
			if rescuer:HasModifier("modifier_tutorial_fake_death") then
				goto __continue33
			end
			if rescuer:GetTeamNumber() ~= parent:GetTeamNumber() then
				goto __continue33
			end
			local rescueModifier = rescuer:FindModifierByName("modifier_tutorial_rescue")
			if not rescueModifier or rescueModifier:GetCaster() ~= parent then
				goto __continue33
			end
			validRescuerIndices[#validRescuerIndices + 1] = rescuerIndex
		end
		::__continue33::
	end
	self.rescuerIndices = validRescuerIndices
	return #validRescuerIndices
end
function modifier_tutorial_fake_death.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	local rescuerCount = self:PruneInvalidRescuers(parent)
	if rescuerCount <= 0 then
		return
	end
	local maxHealth = parent:GetMaxHealth()
	local currentHealth = parent:GetHealth()
	local nextHealth = math.min(maxHealth, currentHealth + maxHealth * 0.02 * rescuerCount)
	parent:SetHealth(nextHealth)
	if nextHealth >= maxHealth then
		self:Destroy()
	end
end
function modifier_tutorial_fake_death.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_DISABLE_HEALING }
end
function modifier_tutorial_fake_death.prototype.GetDisableHealing(self)
	return 1
end
function modifier_tutorial_fake_death.prototype.GetOverrideAnimation(self)
	local ____table_movablePresentationStarted_7
	if self.movablePresentationStarted then
		____table_movablePresentationStarted_7 = ACT_DOTA_RUN
	else
		____table_movablePresentationStarted_7 = ACT_DOTA_DIE
	end
	return ____table_movablePresentationStarted_7
end
function modifier_tutorial_fake_death.prototype.CheckState(self)
	local isDownedPhase = not self.movablePresentationStarted
	return {
		[MODIFIER_STATE_STUNNED] = isDownedPhase,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_FROZEN] = isDownedPhase and self:GetElapsedTime() >= 1.1,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_tutorial_fake_death.prototype.IsHidden(self)
	return true
end
function modifier_tutorial_fake_death.prototype.IsDebuff(self)
	return false
end
function modifier_tutorial_fake_death.prototype.PlayDownEffects(self)
	local parent = self:GetParent()
	local worldEffect = ParticleManager:CreateParticle(
		"particles/econ/misc/kill_effects/default_kill_effect.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(worldEffect, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(worldEffect, 1, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(worldEffect, 2, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(worldEffect)
	local owner = parent:GetPlayerOwner()
	if owner then
		local screenEffect = ParticleManager:CreateParticleForPlayer(
			"particles/generic_gameplay/screen_death_indicator.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			parent,
			owner
		)
		ParticleManager:SetParticleControl(screenEffect, 0, parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(screenEffect, 1, parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(screenEffect, 2, parent:GetAbsOrigin())
		self:AddParticle(screenEffect, false, false, -1, false, false)
		local deathHoleEffect = ParticleManager:CreateParticleForPlayer(
			"particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_death_hole.vpcf",
			PATTACH_OVERHEAD_FOLLOW,
			parent,
			owner
		)
		ParticleManager:SetParticleControl(deathHoleEffect, 0, parent:GetAbsOrigin())
		self:AddParticle(deathHoleEffect, false, false, -1, false, false)
		EmitSoundOnClient("ui.death_stinger", owner)
	end
end
function modifier_tutorial_fake_death.prototype.PlayTombstoneEffect(self)
	local parent = self:GetParent()
	local effect = ParticleManager:CreateParticle(TUTORIAL_FAKE_DEATH_TOMBSTONE_PARTICLE, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleControl(effect, 0, GetGroundPosition(parent:GetAbsOrigin(), parent))
	self:AddParticle(effect, false, false, -1, false, false)
end
function modifier_tutorial_fake_death.prototype.PlayRecoverEffect(self)
	local parent = self:GetParent()
	local effect =
		ParticleManager:CreateParticle("particles/generic_hero_status/respawn.vpcf", PATTACH_CENTER_FOLLOW, parent)
	ParticleManager:SetParticleControl(effect, 0, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(effect)
end
modifier_tutorial_fake_death = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_tutorial_fake_death)
____exports.modifier_tutorial_fake_death = modifier_tutorial_fake_death
--- 教程营救成功后的短暂无敌，收到自身任意命令后提前结束。
____exports.modifier_tutorial_recover_invulnerable = __TS__Class()
local modifier_tutorial_recover_invulnerable = ____exports.modifier_tutorial_recover_invulnerable
modifier_tutorial_recover_invulnerable.name = "modifier_tutorial_recover_invulnerable"
__TS__ClassExtends(modifier_tutorial_recover_invulnerable, BaseModifier_CS)
function modifier_tutorial_recover_invulnerable.prototype.GetStatusEffectName(self)
	return "particles/status_fx/status_effect_dark_willow_shadow_realm.vpcf"
end
function modifier_tutorial_recover_invulnerable.prototype.CheckState(self)
	return { [MODIFIER_STATE_INVULNERABLE] = true }
end
function modifier_tutorial_recover_invulnerable.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_ORDER }
end
function modifier_tutorial_recover_invulnerable.prototype.OnOrder(self, event)
	if not IsServer() then
		return
	end
	if event.unit == self:GetParent() then
		self:Destroy()
	end
end
modifier_tutorial_recover_invulnerable =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_tutorial_recover_invulnerable)
____exports.modifier_tutorial_recover_invulnerable = modifier_tutorial_recover_invulnerable
--- 教程专属营救状态，施加在营救者身上。
____exports.modifier_tutorial_rescue = __TS__Class()
local modifier_tutorial_rescue = ____exports.modifier_tutorial_rescue
modifier_tutorial_rescue.name = "modifier_tutorial_rescue"
__TS__ClassExtends(modifier_tutorial_rescue, BaseModifier_CS)
function modifier_tutorial_rescue.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.target = self:GetCaster()
	local rescuer = self:GetParent()
	local target = self.target
	if
		not target
		or not IsValid(nil, target)
		or target:IsNull()
		or not IsValidAlive(nil, rescuer)
		or rescuer:HasModifier("modifier_tutorial_fake_death")
		or rescuer:GetTeamNumber() ~= target:GetTeamNumber()
	then
		self:Destroy()
		return
	end
	local direction = target:GetAbsOrigin():__sub(rescuer:GetAbsOrigin()):Normalized()
	rescuer:SetForwardVector(direction)
	rescuer:AddNewModifier(target, nil, "modifier_ations_ability1", {})
	local fakeDeath = target:FindModifierByName("modifier_tutorial_fake_death")
	if not fakeDeath then
		self:Destroy()
		return
	end
	fakeDeath:AddRescuer(rescuer:entindex())
	self:StartIntervalThink(0.1)
end
function modifier_tutorial_rescue.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local rescuer = self:GetParent()
	local target = self.target
	if
		not target
		or not IsValid(nil, target)
		or target:IsNull()
		or not IsValidAlive(nil, rescuer)
		or rescuer:HasModifier("modifier_tutorial_fake_death")
		or rescuer:GetTeamNumber() ~= target:GetTeamNumber()
		or GetDistance(nil, target:GetAbsOrigin(), rescuer:GetAbsOrigin()) > 250
		or not target:HasModifier("modifier_tutorial_fake_death")
	then
		self:Destroy()
	end
end
function modifier_tutorial_rescue.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local rescuer = self:GetParent()
	local target = self.target
	if target and IsValid(nil, target) and not target:IsNull() then
		local fakeDeath = target:FindModifierByName("modifier_tutorial_fake_death")
		if fakeDeath ~= nil then
			fakeDeath:RemoveRescuer(rescuer:entindex())
		end
	end
	if rescuer and IsValid(nil, rescuer) and not rescuer:IsNull() then
		rescuer:RemoveModifierByName("modifier_ations_ability1")
	end
end
function modifier_tutorial_rescue.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_tutorial_rescue.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_GENERIC_CHANNEL_1
end
function modifier_tutorial_rescue.prototype.GetOverrideAnimationRate(self)
	return 1
end
function modifier_tutorial_rescue.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_STUNNED] = true }
end
function modifier_tutorial_rescue.prototype.IsPurgable(self)
	return false
end
function modifier_tutorial_rescue.prototype.IsHidden(self)
	return true
end
modifier_tutorial_rescue = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_tutorial_rescue)
____exports.modifier_tutorial_rescue = modifier_tutorial_rescue
return ____exports