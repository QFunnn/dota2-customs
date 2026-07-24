--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_thunder_caller", "item_ability/item_thunder_caller.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_thunder_caller_debuff", "item_ability/item_thunder_caller.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_thunder_caller == nil then
	item_thunder_caller = class({})
end
function item_thunder_caller:GetIntrinsicModifierName()
	return "modifier_item_thunder_caller"
end
function item_thunder_caller:Jump(hCaster, hTarget, radius, jump_count, fDamage, tUnits)
	if IsValid(hCaster) and IsValid(hTarget) then
		local hNewTarget = Util:GetBounceTarget(hTarget, hCaster:GetTeamNumber(), hTarget:GetAbsOrigin(), radius, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags() + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, tUnits, false)
		if IsValid(hNewTarget) then
			EmitSoundOnLocationWithCaster(hNewTarget:GetAbsOrigin(), "Item.Maelstrom.Chain_Lightning.Jump", hCaster)
			
			local iParticleID = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControlEnt(iParticleID, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetAbsOrigin(), true)
			ParticleManager:SetParticleControlEnt(iParticleID, 0, hNewTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hNewTarget:GetAbsOrigin(), true)
			ParticleManager:ReleaseParticleIndex(iParticleID)

			local fDamageOriginal = fDamage
			local slow_duration = self:GetSpecialValueFor("slow_duration")
			local crit_damage = self:GetSpecialValueFor("crit_damage")
			local crit_chance = self:GetSpecialValueFor("crit_chance")
			hNewTarget:AddNewModifier(hCaster, self, "modifier_item_thunder_caller_debuff", { duration = slow_duration })

			if PRD(hCaster, crit_chance, "item_thunder_caller") then
				fDamage = fDamage * crit_damage * 0.01
				SendOverheadEventMessage(hCaster, OVERHEAD_ALERT_CRITICAL, hNewTarget, fDamage, hCaster)
			end

			local tDamageTable = {
				ability = self,
				attacker = hCaster,
				victim = hNewTarget,
				damage = fDamage,
				damage_type = self:GetAbilityDamageType()
			}
			ApplyDamage(tDamageTable)

			table.insert(tUnits, hNewTarget)

			if #tUnits < jump_count then
				self:Jump(hCaster, hNewTarget, radius, jump_count, fDamageOriginal, tUnits)
			end
		end
	end
end
function item_thunder_caller:ArcLightning(hTarget, fDamage)
	local hCaster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local jump_count = self:GetSpecialValueFor("jump_count")
	local damage_pct = self:GetSpecialValueFor("damage_pct")
	local fDamageOriginal = fDamage * damage_pct * 0.01

	local iParticleID = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControlEnt(iParticleID, 1, hCaster, PATTACH_POINT_FOLLOW, "attach_attack1", hCaster:GetAbsOrigin(), true)
	ParticleManager:SetParticleControlEnt(iParticleID, 0, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(iParticleID)

	local slow_duration = self:GetSpecialValueFor("slow_duration")
	local crit_damage = self:GetSpecialValueFor("crit_damage")
	local crit_chance = self:GetSpecialValueFor("crit_chance")
	hTarget:AddNewModifier(hCaster, self, "modifier_item_thunder_caller_debuff", { duration = slow_duration })

	if PRD(hCaster, crit_chance, "item_thunder_caller") then
		fDamage = fDamage * crit_damage * 0.01
		SendOverheadEventMessage(hCaster, OVERHEAD_ALERT_CRITICAL, hTarget, fDamage, hCaster)
	end

	local tDamageTable = {
		ability = self,
		attacker = hCaster,
		victim = hTarget,
		damage = fDamage,
		damage_type = self:GetAbilityDamageType()
	}
	ApplyDamage(tDamageTable)

	self:Jump(hCaster, hTarget, radius, jump_count, fDamageOriginal, { hTarget })

	hCaster:EmitSound("Item.Maelstrom.Chain_Lightning")
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_thunder_caller == nil then
	modifier_item_thunder_caller = class({})
end
function modifier_item_thunder_caller:IsHidden()
	return true
end
function modifier_item_thunder_caller:IsDebuff()
	return false
end
function modifier_item_thunder_caller:IsPurgable()
	return false
end
function modifier_item_thunder_caller:IsPurgeException()
	return false
end
function modifier_item_thunder_caller:OnCreated(params)
	self.bonus_attack_speed_pct = self:GetAbilitySpecialValueFor("bonus_attack_speed_pct")
	self.bonus_evasion = self:GetAbilitySpecialValueFor("bonus_evasion")
	self.bonus_movespeed = self:GetAbilitySpecialValueFor("bonus_movespeed")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
	self.crit_damage = self:GetAbilitySpecialValueFor("crit_damage")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	if IsServer() then
	end
end
function modifier_item_thunder_caller:OnRefresh(params)
	self.bonus_attack_speed_pct = self:GetAbilitySpecialValueFor("bonus_attack_speed_pct")
	self.bonus_evasion = self:GetAbilitySpecialValueFor("bonus_evasion")
	self.bonus_movespeed = self:GetAbilitySpecialValueFor("bonus_movespeed")
	self.bonus_attack_speed = self:GetAbilitySpecialValueFor("bonus_attack_speed")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.crit_chance = self:GetAbilitySpecialValueFor("crit_chance")
	self.crit_damage = self:GetAbilitySpecialValueFor("crit_damage")
	self.chance = self:GetAbilitySpecialValueFor("chance")
	if IsServer() then
	end
end
function modifier_item_thunder_caller:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_thunder_caller:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
end
function modifier_item_thunder_caller:GetModifierPreAttack_CriticalStrike()
	local hParent = self:GetParent()
	if PRD(hParent, self.crit_chance, "modifier_item_thunder_caller") then
		return self.crit_damage
	end
end
function modifier_item_thunder_caller:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	local hTarget = params.target
	local fDamage = params.damage

	if IsValid(hParent) and IsValid(hAbility) and IsValid(hTarget) then
		hAbility:ArcLightning(hTarget, fDamage)
	end
end
function modifier_item_thunder_caller:GetModifierAttackSpeedPercentage()
	local hParent = self:GetParent()
	if not hParent:IsRangedAttacker() then
		return self.bonus_attack_speed_pct
	end
end
function modifier_item_thunder_caller:GetModifierEvasion_Constant()
	return self.bonus_evasion
end
function modifier_item_thunder_caller:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_movespeed
end
function modifier_item_thunder_caller:GetModifierAttackSpeedBonus_Constant()
	return self.bonus_attack_speed
end
function modifier_item_thunder_caller:GetModifierBonusStats_Agility()
	return self.bonus_agi
end
function modifier_item_thunder_caller:GetModifierBonusStats_Strength()
	return self.bonus_str
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_thunder_caller_debuff == nil then
	modifier_item_thunder_caller_debuff = class({})
end
function modifier_item_thunder_caller_debuff:IsHidden()
	return false
end
function modifier_item_thunder_caller_debuff:IsDebuff()
	return true
end
function modifier_item_thunder_caller_debuff:IsPurgable()
	return false
end
function modifier_item_thunder_caller_debuff:IsPurgeException()
	return false
end
function modifier_item_thunder_caller_debuff:OnCreated(params)
	self.attack_slow = self:GetAbilitySpecialValueFor("attack_slow")
	self.movement_slow = self:GetAbilitySpecialValueFor("movement_slow")
	self.cast_slow = self:GetAbilitySpecialValueFor("cast_slow")
	self.bonus_damage_pct = self:GetAbilitySpecialValueFor("bonus_damage_pct")
	if IsServer() then
	end
end
function modifier_item_thunder_caller_debuff:OnRefresh(params)
	self.attack_slow = self:GetAbilitySpecialValueFor("attack_slow")
	self.movement_slow = self:GetAbilitySpecialValueFor("movement_slow")
	self.cast_slow = self:GetAbilitySpecialValueFor("cast_slow")
	self.bonus_damage_pct = self:GetAbilitySpecialValueFor("bonus_damage_pct")
	if IsServer() then
	end
end
function modifier_item_thunder_caller_debuff:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_thunder_caller_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_PERCENTAGE,
	}
end
function modifier_item_thunder_caller_debuff:CheckState()
	return {
		[MODIFIER_STATE_CANNOT_MISS] = false,
	}
end
function modifier_item_thunder_caller_debuff:GetModifierAttackSpeedBonus_Constant()
	return -self.attack_slow
end
function modifier_item_thunder_caller_debuff:GetModifierMoveSpeedBonus_Percentage()
	return -self.movement_slow
end
function modifier_item_thunder_caller_debuff:GetModifierPercentageCasttime()
	return -self.cast_slow
end
function modifier_item_thunder_caller_debuff:GetModifierIncomingPhysicalDamage_Percentage(params)
	return self.bonus_damage_pct
end