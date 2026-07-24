--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier( "modifier_naga_siren_rip_tide_lua", "heroes/hero_naga_siren/naga_siren_rip_tide_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_rip_tide_lua_debuff", "heroes/hero_naga_siren/naga_siren_rip_tide_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_naga_siren_rip_tide_lua_effect", "heroes/hero_naga_siren/naga_siren_rip_tide_lua", LUA_MODIFIER_MOTION_NONE )

naga_siren_rip_tide_lua = naga_siren_rip_tide_lua or class({})

function naga_siren_rip_tide_lua:IsHiddenWhenStolen() return false end
function naga_siren_rip_tide_lua:IsRefreshable() return false end
function naga_siren_rip_tide_lua:IsStealable() return false end
function naga_siren_rip_tide_lua:IsNetherWardStealable() return false end

function naga_siren_rip_tide_lua:GetAbilityTextureName()
   return "naga_siren_rip_tide"
end

function naga_siren_rip_tide_lua:GetIntrinsicModifierName()
	local level = self:GetLevel()
	if level == 0 then return nil end
    return "modifier_naga_siren_rip_tide_lua"
end
function naga_siren_rip_tide_lua:wave(hUnit)
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")
	local duration = self:GetSpecialValueFor("duration")
	if IsValid(hUnit) and hUnit:IsAlive() then
		local units = FindUnitsInRadius(hUnit:GetTeamNumber(), hUnit:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _, unit in pairs(units) do
			if IsValid(unit) and unit:IsAlive() then
				local buff = unit:FindModifierByNameAndCaster("modifier_naga_siren_rip_tide_lua_debuff", hUnit)
				if buff then
					buff:SetDuration(duration, true)
				else
					unit:AddNewModifier(hUnit, self, "modifier_naga_siren_rip_tide_lua_debuff", {duration = duration})
				end

				ApplyDamage({
					victim = unit,
					attacker = hUnit,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self,
				})
			end
		end
		local particle_cast = "particles/units/heroes/hero_siren/naga_siren_riptide.vpcf"
		local sound_cast = "Hero_NagaSiren.Riptide.Cast"

		-- Create Particle
		local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, hUnit )
		-- ParticleManager:SetParticleControlEnt(effect_cast, 0, hParent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", hParent:GetAbsOrigin(), true)
		ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
		ParticleManager:SetParticleControl( effect_cast, 3, Vector( radius, radius, radius ) )
		ParticleManager:ReleaseParticleIndex( effect_cast )
		-- Create Sound
		EmitSoundOn( sound_cast, hUnit )
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_naga_siren_rip_tide_lua == nil then
	modifier_naga_siren_rip_tide_lua = class({})
end
function modifier_naga_siren_rip_tide_lua:IsHidden()
	return false
end
function modifier_naga_siren_rip_tide_lua:IsDebuff() return false end
function modifier_naga_siren_rip_tide_lua:IsPurgable() return false end
function modifier_naga_siren_rip_tide_lua:AllowIllusionDuplicate()
	return false
end
function modifier_naga_siren_rip_tide_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end
function modifier_naga_siren_rip_tide_lua:IsAura()
    return true
end
function modifier_naga_siren_rip_tide_lua:GetAuraRadius()
    return self.aura_radius
end
function modifier_naga_siren_rip_tide_lua:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end
function modifier_naga_siren_rip_tide_lua:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_naga_siren_rip_tide_lua:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_naga_siren_rip_tide_lua:GetModifierAura()
    return "modifier_naga_siren_rip_tide_lua_effect"
end
function modifier_naga_siren_rip_tide_lua:OnCreated(  )
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.hits = self:GetAbilitySpecialValueFor("hits")
	self.aura_radius = self:GetAbilitySpecialValueFor("aura_radius")
	if IsServer() then
		self.units = {}
		self.LastTime = GameRules:GetGameTime()
		self:StartIntervalThink(FrameTime())
	end
end
function modifier_naga_siren_rip_tide_lua:OnRefresh(  )
	self.duration = self:GetAbilitySpecialValueFor("duration")
	self.hits = self:GetAbilitySpecialValueFor("hits")
	self.aura_radius = self:GetAbilitySpecialValueFor("aura_radius")
end
function modifier_naga_siren_rip_tide_lua:OnIntervalThink()
	local hParent = self:GetParent()
	local hAbility = self:GetAbility()
	local wave_done = false
	if hParent:HasModifier("modifier_hero_refreshing") then
		self.units = {}
	else
		for i = #self.units, 1, -1 do
			local unit = self.units[i]
			if IsValid(unit) and unit:IsAlive() then
				if not wave_done then
					hAbility:wave(unit)
					wave_done = true
					table.remove(self.units, i)
				end
			else
				table.remove(self.units, i)
			end
		end
	end

end
function modifier_naga_siren_rip_tide_lua:OnAttackLanded( keys )
	local hAbility = self:GetAbility()
	local hParent = self:GetParent()
	local hTarget = keys.target
	local hAttacker = keys.attacker

	if IsServer() then
		if IsValid(hAbility) and IsValid(hTarget) and IsValid(hParent) and IsValid(hAttacker) and not hTarget:IsOther() and not hParent:PassivesDisabled() then
			if hAttacker:GetTeamNumber() == hParent:GetTeamNumber() and hParent:GetTeamNumber() ~= hTarget:GetTeamNumber() then
				if hAttacker:HasModifier("modifier_naga_siren_rip_tide_lua_effect") then
					if self:GetStackCount() < self.hits then
						self:IncrementStackCount()
					end
					if self:GetStackCount() >= self.hits and GameRules:GetGameTime() > self.LastTime + 0.5 then
						local units = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, self.aura_radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
						for _, unit in pairs(units) do
							if IsValid(unit) and unit:IsAlive() then
								table.insert(self.units, unit)
							end
						end
						self:SetStackCount(0)
					end
				end
			end
		end
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_naga_siren_rip_tide_lua_effect == nil then
	modifier_naga_siren_rip_tide_lua_effect = class({})
end

function modifier_naga_siren_rip_tide_lua_effect:IsHidden()
	local hParent = self:GetParent()
	local hCaster = self:GetCaster()
	if hCaster == hParent then
		return true
	else
		return false
	end
 end
function modifier_naga_siren_rip_tide_lua_effect:IsDebuff() return false end
function modifier_naga_siren_rip_tide_lua_effect:IsPurgable() return false end
---------------------------------------------------------------------
--Modifiers
modifier_naga_siren_rip_tide_lua_debuff = class({})
--------------------------------------------------------------------------------
-- Classifications
function modifier_naga_siren_rip_tide_lua_debuff:IsHidden()
	return false
end

function modifier_naga_siren_rip_tide_lua_debuff:IsDebuff()
	return true
end

function modifier_naga_siren_rip_tide_lua_debuff:IsStunDebuff()
	return false
end

function modifier_naga_siren_rip_tide_lua_debuff:IsPurgable()
	return true
end
--------------------------------------------------------------------------------
-- Initializations
function modifier_naga_siren_rip_tide_lua_debuff:OnCreated( kv )
	self.armor_reduction = self:GetAbilitySpecialValueFor("armor_reduction")
	if IsServer() then
		-- self:SetStackCount(1)
	end
end
function modifier_naga_siren_rip_tide_lua_debuff:OnRefresh( kv )
	self.armor_reduction = self:GetAbilitySpecialValueFor("armor_reduction")
	if IsServer() then
		-- self:IncrementStackCount()
	end
end
function modifier_naga_siren_rip_tide_lua_debuff:OnRemoved()
end
function modifier_naga_siren_rip_tide_lua_debuff:OnDestroy()
end
--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_naga_siren_rip_tide_lua_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end
function modifier_naga_siren_rip_tide_lua_debuff:GetModifierPhysicalArmorBonus()
	return self.armor_reduction
end
--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_naga_siren_rip_tide_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_siren/naga_siren_riptide_debuff.vpcf"
end
function modifier_naga_siren_rip_tide_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_naga_siren_rip_tide_lua_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_naga_riptide.vpcf"
end
function modifier_naga_siren_rip_tide_lua_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end
function modifier_naga_siren_rip_tide_lua_debuff:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end