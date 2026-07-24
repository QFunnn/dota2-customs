--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_lucky_shot_lua", "heroes/hero_pangolier/pangolier_lucky_shot_lua.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_lucky_shot_lua_debuff", "heroes/hero_pangolier/pangolier_lucky_shot_lua.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if pangolier_lucky_shot_lua == nil then
	pangolier_lucky_shot_lua = class({})
end
function pangolier_lucky_shot_lua:GetIntrinsicModifierName()
	return "modifier_pangolier_lucky_shot_lua"
end
---------------------------------------------------------------------
--Modifiers
if modifier_pangolier_lucky_shot_lua == nil then
	modifier_pangolier_lucky_shot_lua = class({})
end
function modifier_pangolier_lucky_shot_lua:IsHidden()
	return true
end
function modifier_pangolier_lucky_shot_lua:IsDebuff()
	return false
end
function modifier_pangolier_lucky_shot_lua:IsPurgable()
	return false
end
function modifier_pangolier_lucky_shot_lua:IsPurgeException()
	return false
end
function modifier_pangolier_lucky_shot_lua:OnCreated(params)
	self.chance_pct = self:GetAbilitySpecialValueFor("chance_pct")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	if IsServer() then
	end
end
function modifier_pangolier_lucky_shot_lua:OnRefresh(params)
	self.chance_pct = self:GetAbilitySpecialValueFor("chance_pct")
	self.duration = self:GetAbilitySpecialValueFor("duration")
	if IsServer() then
	end
end
function modifier_pangolier_lucky_shot_lua:OnDestroy()
	if IsServer() then
	end
end
function modifier_pangolier_lucky_shot_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end
function modifier_pangolier_lucky_shot_lua:GetModifierProcAttack_Feedback(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = self:GetAbility()

	if IsValid(hParent) and not hParent:IsIllusion() and not hParent:PassivesDisabled() and IsValid(hTarget) and hTarget:IsAlive() and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() and IsValid(hAbility) then
		if PRD(hParent, self.chance_pct, "pangolier_lucky_shot_lua") then
			local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
			ParticleManager:SetParticleControlTransformForward(iParticleID, 0, hParent:GetAbsOrigin(), (hTarget:GetAbsOrigin() - hParent:GetAbsOrigin()):Normalized())
			ParticleManager:ReleaseParticleIndex(iParticleID)

			EmitSoundOn("Hero_Pangolier.LuckyShot.Proc", hTarget)

			hTarget:AddNewModifier(hParent, hAbility, "modifier_pangolier_lucky_shot_lua_debuff", { duration = self.duration * hTarget:GetStatusResistanceFactor(hParent) })
		end
	end
end
function modifier_pangolier_lucky_shot_lua:GetModifierTotalDamageOutgoing_Percentage(params)
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	local hTarget = params.target
	local hInflictor = params.inflictor
	local iCategory = params.damage_category

	if IsValid(hParent) and not hParent:IsIllusion() and hInflictor and iCategory == DOTA_DAMAGE_CATEGORY_SPELL and not hParent:PassivesDisabled() and IsValid(hTarget) and hTarget:IsAlive() and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() and IsValid(hAbility) and hAbility:IsCooldownReady() then
		if not hInflictor:IsItem() then
			if PRD(hParent, self.chance_pct, "pangolier_lucky_shot_lua") then
				local iParticleID = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
				ParticleManager:SetParticleControlTransformForward(iParticleID, 0, hParent:GetAbsOrigin(), (hTarget:GetAbsOrigin() - hParent:GetAbsOrigin()):Normalized())
				ParticleManager:ReleaseParticleIndex(iParticleID)

				EmitSoundOn("Hero_Pangolier.LuckyShot.Proc", hTarget)

				hTarget:AddNewModifier(hParent, hAbility, "modifier_pangolier_lucky_shot_lua_debuff", { duration = self.duration * hTarget:GetStatusResistanceFactor(hParent) })
				hAbility:UseResources(true, false, false, true)
			end
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_pangolier_lucky_shot_lua_debuff == nil then
	modifier_pangolier_lucky_shot_lua_debuff = class({})
end
function modifier_pangolier_lucky_shot_lua_debuff:IsHidden()
	return false
end
function modifier_pangolier_lucky_shot_lua_debuff:IsDebuff()
	return true
end
function modifier_pangolier_lucky_shot_lua_debuff:IsPurgable()
	return true
end
function modifier_pangolier_lucky_shot_lua_debuff:IsPurgeException()
	return true
end
function modifier_pangolier_lucky_shot_lua_debuff:OnCreated(params)
	self.armor = self:GetAbilitySpecialValueFor("armor")
	if IsServer() then
	end
end
function modifier_pangolier_lucky_shot_lua_debuff:OnRefresh(params)
	self.armor = self:GetAbilitySpecialValueFor("armor")
	if IsServer() then
	end
end
function modifier_pangolier_lucky_shot_lua_debuff:OnDestroy()
	if IsServer() then
	end
end
function modifier_pangolier_lucky_shot_lua_debuff:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
	}
end
function modifier_pangolier_lucky_shot_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end
function modifier_pangolier_lucky_shot_lua_debuff:GetModifierPhysicalArmorBonus()
	return -self.armor
end
function modifier_pangolier_lucky_shot_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_pangolier/pangolier_luckyshot_disarm_debuff.vpcf"
end
function modifier_pangolier_lucky_shot_lua_debuff:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end