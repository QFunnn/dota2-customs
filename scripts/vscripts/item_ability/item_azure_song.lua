--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_azure_song", "item_ability/item_azure_song.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_azure_song_slow", "item_ability/item_azure_song.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if item_azure_song == nil then
	item_azure_song = class({}) ---@class CDOTA_Item_Lua
end
function item_azure_song:GetIntrinsicModifierName()
	return "modifier_item_azure_song"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_azure_song == nil then
	modifier_item_azure_song = class({})
end
function modifier_item_azure_song:IsHidden()
	return self.total_spell_amp_threshold == 0
end
function modifier_item_azure_song:IsDebuff()
	return false
end
function modifier_item_azure_song:IsPurgable()
	return false
end
function modifier_item_azure_song:IsPurgeException()
	return false
end
function modifier_item_azure_song:OnCreated(params)
	self.bonus_dmg = self:GetAbilitySpecialValueFor("bonus_dmg")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.slow_duration = self:GetAbilitySpecialValueFor("slow_duration")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.bonus_health = self:GetAbilitySpecialValueFor("bonus_health")
	self.bonus_mana = self:GetAbilitySpecialValueFor("bonus_mana")
	self.bonus_mana_regen = self:GetAbilitySpecialValueFor("bonus_mana_regen")
	self.bonus_spell_amp = self:GetAbilitySpecialValueFor("bonus_spell_amp")
	self.mana_regen_multiplier = self:GetAbilitySpecialValueFor("mana_regen_multiplier")
	self.spell_lifesteal_amp = self:GetAbilitySpecialValueFor("spell_lifesteal_amp")
	self.spell_amp_per_int = self:GetAbilitySpecialValueFor("spell_amp_per_int")
	self.spell_amp_per_other = self:GetAbilitySpecialValueFor("spell_amp_per_other")
	self.magical_armor_pen = self:GetAbilitySpecialValueFor("magical_armor_pen")
	self.hero_pct = self:GetAbilitySpecialValueFor("hero_pct")
	self.total_spell_amp_threshold = self:GetAbilitySpecialValueFor("total_spell_amp_threshold")
	self.total_spell_amp_pct_day = self:GetAbilitySpecialValueFor("total_spell_amp_pct_day")
	self.total_spell_amp_pct_night = self:GetAbilitySpecialValueFor("total_spell_amp_pct_night")
	if IsServer() then
		local hParent = self:GetParent()
		if not hParent:IsIllusion() then
			self:StartIntervalThink(1)
		end
		if self.total_spell_amp_pct_day > 0 then
			self.total_bonus_spell_amp = 0
			self:SetHasCustomTransmitterData(true)
			--local iParticleID = ParticleManager:CreateParticle("particles/items/star_design.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hParent)
			--ParticleManager:SetParticleControlEnt(iParticleID, 0, hParent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
			--self:AddParticle(iParticleID, false, false, -1, false, false)
		end
	end
end
function modifier_item_azure_song:OnRefresh(params)
	self.bonus_dmg = self:GetAbilitySpecialValueFor("bonus_dmg")
	self.radius = self:GetAbilitySpecialValueFor("radius")
	self.slow_duration = self:GetAbilitySpecialValueFor("slow_duration")
	self.bonus_agi = self:GetAbilitySpecialValueFor("bonus_agi")
	self.bonus_int = self:GetAbilitySpecialValueFor("bonus_int")
	self.bonus_str = self:GetAbilitySpecialValueFor("bonus_str")
	self.bonus_health = self:GetAbilitySpecialValueFor("bonus_health")
	self.bonus_mana = self:GetAbilitySpecialValueFor("bonus_mana")
	self.bonus_mana_regen = self:GetAbilitySpecialValueFor("bonus_mana_regen")
	self.bonus_spell_amp = self:GetAbilitySpecialValueFor("bonus_spell_amp")
	self.mana_regen_multiplier = self:GetAbilitySpecialValueFor("mana_regen_multiplier")
	self.spell_lifesteal_amp = self:GetAbilitySpecialValueFor("spell_lifesteal_amp")
	self.spell_amp_per_int = self:GetAbilitySpecialValueFor("spell_amp_per_int")
	self.spell_amp_per_other = self:GetAbilitySpecialValueFor("spell_amp_per_other")
	self.magical_armor_pen = self:GetAbilitySpecialValueFor("magical_armor_pen")
	self.hero_pct = self:GetAbilitySpecialValueFor("hero_pct")
	self.total_spell_amp_threshold = self:GetAbilitySpecialValueFor("total_spell_amp_threshold")
	self.total_spell_amp_pct_day = self:GetAbilitySpecialValueFor("total_spell_amp_pct_day")
	self.total_spell_amp_pct_night = self:GetAbilitySpecialValueFor("total_spell_amp_pct_night")
	if IsServer() then
	end
end
function modifier_item_azure_song:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_azure_song:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_DRAIN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_LIFESTEAL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_TOOLTIP,
	}
end
function modifier_item_azure_song:OnIntervalThink()
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	if IsValid(hParent) and IsValid(hAbility) then
		local iCharge = math.floor(hParent:GetIntellect(true) * self.spell_amp_per_int + (hParent:GetAgility() + hParent:GetStrength()) * self.spell_amp_per_other)
		hAbility:SetCurrentCharges(iCharge)
		if self.total_spell_amp_threshold > 0 then
			local iTotalBonusPct = math.floor(iCharge / self.total_spell_amp_threshold)
			if GameRulesCustom:IsDaytime() then
				iTotalBonusPct = iTotalBonusPct * self.total_spell_amp_pct_day
				self.sAbilityTexture = "item_star_design"
				hAbility.sAbilityTexture = "item_star_design"
			else
				iTotalBonusPct = iTotalBonusPct * self.total_spell_amp_pct_night
				self.sAbilityTexture = "item_star_design_night"
				hAbility.sAbilityTexture = "item_star_design_night"
			end
			self:SetStackCount(iTotalBonusPct)
			self.total_bonus_spell_amp = math.floor(hParent:GetSpellAmplification(false) * 100 - (self.total_bonus_spell_amp or 0)) * iTotalBonusPct * 0.01
		end
	end
end
function modifier_item_azure_song:AddCustomTransmitterData()
	return {
		total_bonus_spell_amp = self.total_bonus_spell_amp,
		sAbilityTexture = self.sAbilityTexture,
	}
end
function modifier_item_azure_song:HandleCustomTransmitterData(t)
	self.total_bonus_spell_amp = t.total_bonus_spell_amp
	local hAbility = self:GetAbility()
	if IsValid(hAbility) then
		hAbility.sAbilityTexture = t.sAbilityTexture
	end
end
function modifier_item_azure_song:GetModifierBonusStats_Agility()
	return self.bonus_agi
end
function modifier_item_azure_song:GetModifierBonusStats_Intellect()
	return self.bonus_int
end
function modifier_item_azure_song:GetModifierBonusStats_Strength()
	return self.bonus_str
end
function modifier_item_azure_song:GetModifierHealthBonus()
	return self.bonus_health
end
function modifier_item_azure_song:GetModifierManaBonus()
	return self.bonus_mana
end
function modifier_item_azure_song:GetModifierConstantManaRegen()
	return self.bonus_mana_regen
end
function modifier_item_azure_song:GetModifierManaDrainAmplify_Percentage()
	return self.mana_regen_multiplier
end
function modifier_item_azure_song:GetModifierSpellLifestealRegenAmplify_Percentage()
	return self.spell_lifesteal_amp
end
function modifier_item_azure_song:OnTooltip()
	return self:GetStackCount()
end
function modifier_item_azure_song:GetModifierSpellAmplify_Percentage(params)
	local hAbility = self:GetAbility()
	local hParent = self:GetParent()
	local hInflictor = params.inflictor
	local hTarget = params.target
	local fSpellAmp = hAbility:GetCurrentCharges()
	local fTotalBonusSpellAmp = self.total_bonus_spell_amp or 0
	if IsServer() then
		if IsValid(hInflictor) and IsValid(hParent) then
			local sAbilityName = hInflictor:GetAbilityName()
			if PERCENTAGE_ABILITIES and PERCENTAGE_ABILITIES[sAbilityName] then
				return 0
			end
		end
		if IsValid(hTarget) and hTarget:IsRealHero() then
			fTotalBonusSpellAmp = fTotalBonusSpellAmp - fSpellAmp * (100 - self.hero_pct) * 0.01 * self:GetStackCount() * 0.01
			fSpellAmp = fSpellAmp * self.hero_pct * 0.01
		end
		return fSpellAmp + self.bonus_spell_amp + fTotalBonusSpellAmp
	end
	return fSpellAmp + self.bonus_spell_amp + fTotalBonusSpellAmp
end
function modifier_item_azure_song:GetModifierTotalDamageOutgoing_Percentage(params)
	local hParent = self:GetParent()
	local hTarget = params.target
	local hAbility = self:GetAbility()
	local hInflictor = params.inflictor

	if IsValid(hParent) and IsValid(hTarget) and IsValid(hInflictor) and not hInflictor:IsPassive() and IsValid(hAbility) and hTarget:IsAlive() and hTarget:GetTeamNumber() ~= hParent:GetTeamNumber() then
		if hAbility:IsCooldownReady() and hInflictor ~= hAbility and self.bonus_dmg > 0 then
			hAbility:UseResources(false, false, false, true)
			local units = FindUnitsInRadius(hParent:GetTeamNumber(), hTarget:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			for _, unit in pairs(units) do
				if IsValid(unit) and unit:IsAlive() and not unit:IsDebuffImmune() then
					unit:AddNewModifier(hParent, hAbility, "modifier_item_azure_song_slow", { duration = self.slow_duration * unit:GetStatusResistanceFactor(hParent) })
					local iParticleID = ParticleManager:CreateParticle("particles/items/azure_song.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, hParent)
					-- ParticleManager:SetParticleControl(iParticleID, 0, hParent:GetAbsOrigin())
					ParticleManager:SetParticleControlEnt(iParticleID, 0, hParent, PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0, 0, 0), false)
					ParticleManager:SetParticleControlEnt(iParticleID, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), false)
					ParticleManager:ReleaseParticleIndex(iParticleID)
					ApplyDamage({
						victim = unit,
						attacker = hParent,
						damage = self.bonus_dmg,
						damage_type = DAMAGE_TYPE_MAGICAL,
						ability = hAbility,
					})
					SendOverheadEventMessage(unit:GetPlayerOwner(), OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, unit, self.bonus_dmg, unit:GetPlayerOwner())
				end
			end
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_azure_song_slow == nil then
	modifier_item_azure_song_slow = class({})
end
function modifier_item_azure_song_slow:IsHidden()
	return false
end
function modifier_item_azure_song_slow:IsDebuff()
	return true
end
function modifier_item_azure_song_slow:IsPurgable()
	return true
end
function modifier_item_azure_song_slow:IsPurgeException()
	return true
end
function modifier_item_azure_song_slow:OnCreated(params)
	self.movement_slow = self:GetAbilitySpecialValueFor("movement_slow")
	if IsServer() then
	end
end
function modifier_item_azure_song_slow:OnRefresh(params)
	self.movement_slow = self:GetAbilitySpecialValueFor("movement_slow")
	if IsServer() then
	end
end
function modifier_item_azure_song_slow:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_azure_song_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end
function modifier_item_azure_song_slow:GetModifierMoveSpeedBonus_Percentage(params)
	return -self.movement_slow
end