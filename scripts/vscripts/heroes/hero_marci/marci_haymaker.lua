--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_marci_haymaker", "heroes/hero_marci/marci_haymaker.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_marci_haymaker_shield", "heroes/hero_marci/marci_haymaker.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_marci_haymaker_delay", "heroes/hero_marci/marci_haymaker.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_marci_haymaker_damage", "heroes/hero_marci/marci_haymaker.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if marci_haymaker == nil then
	marci_haymaker = class({})
end
function marci_haymaker:GetIntrinsicModifierName()
	return "modifier_marci_haymaker"
end
function marci_haymaker:GetAbilityTextureName()
	local hCaster = self:GetCaster()
	return Wearable_System:CustomGetTextureReplacement(hCaster, "marci_haymaker")
end
function marci_haymaker:OnProjectileHit_ExtraData(hTarget, vLocation, ExtraData)
	local iHashIndex = ExtraData.iHashIndex
	if IsValid(hTarget) then
		local hCaster = self:GetCaster()
		local iStack = ExtraData.iStack or 1
		ExtraData = ExtraData or {}
		local vStartPos = Vector(ExtraData.StartPos_x or 0, ExtraData.StartPos_y or 0, ExtraData.StartPos_z or 0)
		local vEndPos = Vector(ExtraData.EndPos_x or 0, ExtraData.EndPos_y or 0, ExtraData.EndPos_z or 0)

		local pure_width = self:GetSpecialValueFor("pure_width")
		local start_width = self:GetSpecialValueFor("start_width")
		local end_width = self:GetSpecialValueFor("end_width")
		local base_damage = self:GetSpecialValueFor("base_damage")
		local damage_pct = self:GetSpecialValueFor("damage_pct")
		local creep_multiple = self:GetSpecialValueFor("creep_multiple")
		local cooldown_reduction_unleash = self:GetSpecialValueFor("cooldown_reduction_unleash")
		local fDamage = base_damage + damage_pct * iStack * 0.01
		if hTarget:GetTeamNumber() == DOTA_TEAM_NEUTRALS then
			fDamage = fDamage * creep_multiple
		end

		local tCenterHit = {}
		if iHashIndex ~= nil then
			tCenterHit = GetHashtableByIndex(iHashIndex)
		end



		local vDirEnd = vStartPos - vEndPos
		local vDir = vDirEnd:Normalized()
		local v = Rotation2D(vDir, math.rad(90))

		local lu = vStartPos + v * start_width
		local ru = vStartPos - v * start_width
		local ld = vEndPos + v * end_width
		local rd = vEndPos - v * end_width
		-- local tPolygon = {
		-- 	ru,
		-- 	rd,
		-- 	ld,
		-- 	lu,
		-- }
		-- DebugDrawLine(tPolygon[1], tPolygon[2], 255, 255, 255, true, hCaster:GetSecondsPerAttack(false))
		-- DebugDrawLine(tPolygon[2], tPolygon[3], 255, 255, 255, true, hCaster:GetSecondsPerAttack(false))
		-- DebugDrawLine(tPolygon[3], tPolygon[4], 255, 255, 255, true, hCaster:GetSecondsPerAttack(false))
		-- DebugDrawLine(tPolygon[4], tPolygon[1], 255, 255, 255, true, hCaster:GetSecondsPerAttack(false))

		if Util:IsPointInsideRectangle(hTarget:GetAbsOrigin(), lu, ru, ld, rd) then
			local vHitPos = hTarget:GetAbsOrigin()
			local vDirTarget = vHitPos - vStartPos
			vDirEnd.z = 0
			vDirTarget.z = 0
			local cos = Util:GetDotProduct(vDirTarget, vDirEnd) / (vDirTarget:Length2D() * vDirEnd:Length2D())
			local sin = math.sqrt(math.abs(1 - cos * cos))
			local fOffset = vDirTarget:Length2D() * sin
			local iDamageType = DAMAGE_TYPE_PHYSICAL
			if fOffset <= pure_width then
				-- 被中央区域击中
				iDamageType = DAMAGE_TYPE_PURE
				if not tCenterHit.bCenterHit then
					tCenterHit.bCenterHit = true
					local hUnleash = hCaster:FindAbilityByName("marci_unleash")
					if IsValid(hUnleash) then
						local fCooldown = hUnleash:GetCooldownTimeRemaining()
						hUnleash:EndCooldown()
						hUnleash:StartCooldown(math.max(0, fCooldown - cooldown_reduction_unleash))
					end
				end
			end
			ApplyDamage({
				attacker = hCaster,
				victim = hTarget,
				damage_type = iDamageType,
				damage = fDamage,
				ability = self,
				damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
			})
		end
	else
		RemoveHashtable(iHashIndex)
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_marci_haymaker == nil then
	modifier_marci_haymaker = class({})
end
function modifier_marci_haymaker:IsHidden()
	return true
end
function modifier_marci_haymaker:IsDebuff()
	return false
end
function modifier_marci_haymaker:IsPurgable()
	return false
end
function modifier_marci_haymaker:IsPurgeException()
	return false
end
function modifier_marci_haymaker:OnCreated(params)
	self.delay = self:GetAbilitySpecialValueFor("delay")
	self.shield_duration = self:GetAbilitySpecialValueFor("shield_duration")
	self.cooldown_reduction_self = self:GetAbilitySpecialValueFor("cooldown_reduction_self")
	self.cooldown_reduction_unleash = self:GetAbilitySpecialValueFor("cooldown_reduction_unleash")
	self.store_duration = self:GetAbilitySpecialValueFor("store_duration")
	self.unleash_damage_pct = self:GetAbilitySpecialValueFor("unleash_damage_pct")
	if IsServer() then
	end
end
function modifier_marci_haymaker:OnRefresh(params)
	self.delay = self:GetAbilitySpecialValueFor("delay")
	self.shield_duration = self:GetAbilitySpecialValueFor("shield_duration")
	self.cooldown_reduction_self = self:GetAbilitySpecialValueFor("cooldown_reduction_self")
	self.cooldown_reduction_unleash = self:GetAbilitySpecialValueFor("cooldown_reduction_unleash")
	self.store_duration = self:GetAbilitySpecialValueFor("store_duration")
	self.unleash_damage_pct = self:GetAbilitySpecialValueFor("unleash_damage_pct")
	if IsServer() then
	end
end
function modifier_marci_haymaker:OnDestroy()
	if IsServer() then
	end
end
function modifier_marci_haymaker:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function modifier_marci_haymaker:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = self:GetAbility()
	if IsValid(hParent) and IsValid(hTarget) then
		if IsValid(hAbility) then
			local tFlurryBuff = hParent:FindModifierByName("modifier_marci_unleash_flurry")
			local tDamageBuff = hParent:FindModifierByName("modifier_marci_haymaker_damage")
			local bBash = false
			local bUnleashPunch = false
			local iStack = 0
			if tFlurryBuff and tFlurryBuff:GetStackCount() == 1 then
				bBash = true
				bUnleashPunch = true
			end
			if hAbility:IsCooldownReady() and not hParent:PassivesDisabled() then
				bBash = true
			end

			if bBash then
				if tDamageBuff then
					iStack = tDamageBuff:GetStackCount()
				end
				if bUnleashPunch then
					iStack = iStack * self.unleash_damage_pct * 0.01
				end
				if iStack > 0 then
					hParent:AddNewModifier(hParent, hAbility, "modifier_marci_haymaker_shield", { duration = self.shield_duration, stack = iStack })
					hParent:AddNewModifier(hParent, hAbility, "modifier_marci_haymaker_delay", { duration = self.delay, target_index = hTarget:entindex(), stack = iStack })
					if not bUnleashPunch then
						if tDamageBuff then
							tDamageBuff:Destroy()
						end
						hAbility:UseResources(false, false, false, true)
					end
				end
			end
		end
	end
end
function modifier_marci_haymaker:GetModifierIncomingDamage_Percentage(params)
	local hAttacker = params.attacker
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	local fDamage = params.original_damage or 0

	if IsValid(hAttacker) and IsValid(hParent) and IsValid(hAbility) and hParent ~= hAttacker and fDamage > 0 then
		hParent:AddNewModifier(hParent, hAbility, "modifier_marci_haymaker_damage", { duration = self.store_duration, stack = math.floor(fDamage) })
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_marci_haymaker_shield == nil then
	modifier_marci_haymaker_shield = class({})
end
function modifier_marci_haymaker_shield:IsHidden()
	return false
end
function modifier_marci_haymaker_shield:IsDebuff()
	return false
end
function modifier_marci_haymaker_shield:IsPurgable()
	return false
end
function modifier_marci_haymaker_shield:IsPurgeException()
	return false
end
function modifier_marci_haymaker_shield:OnCreated(params)
	if IsServer() then
		self.sheild_hp = params.stack or 1
		self:SetHasCustomTransmitterData(true)
	end
end
function modifier_marci_haymaker_shield:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_marci_haymaker_shield:OnDestroy()
	if IsServer() then
	end
end
function modifier_marci_haymaker_shield:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
end
function modifier_marci_haymaker_shield:AddCustomTransmitterData()
	return {
		sheild_hp = self.sheild_hp
	}
end
function modifier_marci_haymaker_shield:HandleCustomTransmitterData(t)
	self.sheild_hp = t.sheild_hp
end
function modifier_marci_haymaker_shield:GetModifierIncomingDamageConstant(params)
	local fDamage = params.damage or 1
	if IsServer() then
		local fBlock = 0
		if fDamage > self.sheild_hp then
			self:Destroy()
			fBlock = self.sheild_hp
		else
			self.sheild_hp = self.sheild_hp - fDamage
			fBlock = fDamage
			self:SendBuffRefreshToClients()
		end
		return -fBlock
	else
		return self.sheild_hp
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_marci_haymaker_delay == nil then
	modifier_marci_haymaker_delay = class({})
end
function modifier_marci_haymaker_delay:IsHidden()
	return true
end
function modifier_marci_haymaker_delay:IsDebuff()
	return false
end
function modifier_marci_haymaker_delay:IsPurgable()
	return false
end
function modifier_marci_haymaker_delay:IsPurgeException()
	return false
end
function modifier_marci_haymaker_delay:OnCreated(params)
	self.start_width = self:GetAbilitySpecialValueFor("start_width")
	self.end_width = self:GetAbilitySpecialValueFor("end_width")
	self.pure_width = self:GetAbilitySpecialValueFor("pure_width")
	self.range = self:GetAbilitySpecialValueFor("range")
	self.delay = self:GetAbilitySpecialValueFor("delay")
	if IsServer() then
		local hParent = self:GetParent()
		local iTargetIndex = params.target_index
		self:SetStackCount(params.stack or 1)
		if IsValid(hParent) and iTargetIndex then
			local hTarget = EntIndexToHScript(iTargetIndex)
			if IsValid(hTarget) then
				self.vStartPos = hParent:GetAbsOrigin()
				self.vStartPos.z = hTarget:GetAbsOrigin().z
				self.vDir = (hTarget:GetAbsOrigin() - self.vStartPos):Normalized()
				self.vPos = self.vStartPos + self.vDir * self.range

				local iParticleID = ParticleManager:CreateParticle(Wearable_System:CustomGetParticleReplacement(hParent:GetPlayerOwnerID(), "particles/units/heroes/hero_marci/marci_haymaker_charge.vpcf"), PATTACH_CUSTOMORIGIN, hParent)
				ParticleManager:SetParticleControlTransformForward(iParticleID, 0, self.vStartPos, self.vDir)
				ParticleManager:SetParticleControl(iParticleID, 1, self.vPos)
				ParticleManager:SetParticleControl(iParticleID, 2, Vector(self.start_width, self.end_width, self.delay))
				ParticleManager:SetParticleControl(iParticleID, 3, Vector(self.pure_width, 0, 0))
				ParticleManager:ReleaseParticleIndex(iParticleID)
				EmitSoundOn("Hero_ElderTitan.EchoStomp.Channel", hParent)
			end
		end
	end
end
function modifier_marci_haymaker_delay:OnRefresh(params)
	self.start_width = self:GetAbilitySpecialValueFor("start_width")
	self.end_width = self:GetAbilitySpecialValueFor("end_width")
	self.pure_width = self:GetAbilitySpecialValueFor("pure_width")
	self.range = self:GetAbilitySpecialValueFor("range")
	self.delay = self:GetAbilitySpecialValueFor("delay")
	if IsServer() then
	end
end
function modifier_marci_haymaker_delay:OnDestroy()
	if IsServer() then
		local hParent = self:GetParent()
		local hAbility = self:GetAbility()
		if IsValid(hParent) and IsValid(hAbility) then
			local iParticleID2 = ParticleManager:CreateParticle(Wearable_System:CustomGetParticleReplacement(hParent:GetPlayerOwnerID(), "particles/units/heroes/hero_marci/marci_haymaker_bash.vpcf"), PATTACH_CUSTOMORIGIN, hParent)
			ParticleManager:SetParticleControlTransformForward(iParticleID2, 0, self.vStartPos, self.vDir)
			ParticleManager:SetParticleControl(iParticleID2, 1, Vector(self.start_width, self.end_width, self.range))
			ParticleManager:ReleaseParticleIndex(iParticleID2)
			StopSoundOn("Hero_ElderTitan.EchoStomp.Channel", hParent)
			EmitSoundOnLocationWithCaster(self.vStartPos, "Hero_ElderTitan.EchoStomp", hParent)

			local iParticleID3 = ParticleManager:CreateParticle(Wearable_System:CustomGetParticleReplacement(hParent:GetPlayerOwnerID(), "particles/units/heroes/hero_marci/marci_haymaker_attackquick_swipes.vpcf"), PATTACH_CUSTOMORIGIN, hParent)
			ParticleManager:SetParticleControlTransformForward(iParticleID3, 0, self.vStartPos + self.vDir * self.range * 0.5, self.vDir)
			ParticleManager:SetParticleControl(iParticleID3, 1, self.vStartPos)
			ParticleManager:ReleaseParticleIndex(iParticleID3)

			local t = CreateHashtable()
			local iHashIndex = GetHashtableIndex(t)

			local info = {
				Ability = hAbility,
				EffectName = "",
				vSpawnOrigin = self.vStartPos,
				fDistance = self.range,
				fStartRadius = self.start_width,
				fEndRadius = self.end_width,
				Source = hParent,
				bHasFrontalCone = false,
				bReplaceExisting = false,
				iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
				iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				bDeleteOnHit = false,
				vVelocity = self.vDir * 99999,
				bProvidesVision = false,
				-- iVisionRadius = self.vision,
				-- iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
				fExpireTime = GameRules:GetGameTime() + 10,
				ExtraData = {
					StartPos_x = self.vStartPos.x,
					StartPos_y = self.vStartPos.y,
					StartPos_z = self.vStartPos.z,
					EndPos_x = self.vPos.x,
					EndPos_y = self.vPos.y,
					EndPos_z = self.vPos.z,
					iStack = self:GetStackCount(),
					iHashIndex = iHashIndex,
				}
			}

			ProjectileManager:CreateLinearProjectile(info)
		end

	end
end
function modifier_marci_haymaker_delay:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
---------------------------------------------------------------------
--Modifiers
if modifier_marci_haymaker_damage == nil then
	modifier_marci_haymaker_damage = class({})
end
function modifier_marci_haymaker_damage:IsHidden()
	return false
end
function modifier_marci_haymaker_damage:IsDebuff()
	return false
end
function modifier_marci_haymaker_damage:IsPurgable()
	return false
end
function modifier_marci_haymaker_damage:IsPurgeException()
	return false
end
function modifier_marci_haymaker_damage:OnCreated(params)
	self.store_max_multiple = self:GetAbilitySpecialValueFor("store_max_multiple")
	if IsServer() then
		local hParent = self:GetParent()
		local iStack = params.stack or 0
		if IsValid(hParent) then
			local iMaxStack = hParent:GetAverageTrueAttackDamage(hParent) * self.store_max_multiple
			self:SetStackCount(math.min(iMaxStack, math.floor(iStack)))
		end
	end
end
function modifier_marci_haymaker_damage:OnRefresh(params)
	self.store_max_multiple = self:GetAbilitySpecialValueFor("store_max_multiple")
	if IsServer() then
		local hParent = self:GetParent()
		local iStack = self:GetStackCount() + (params.stack or 0)
		if IsValid(hParent) then
			local iMaxStack = hParent:GetAverageTrueAttackDamage(hParent) * self.store_max_multiple
			self:SetStackCount(math.min(iMaxStack, math.floor(iStack)))
		end
	end
end
function modifier_marci_haymaker_damage:OnDestroy()
	if IsServer() then
	end
end
function modifier_marci_haymaker_damage:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function modifier_marci_haymaker_damage:OnTooltip()
	return self:GetStackCount()
end