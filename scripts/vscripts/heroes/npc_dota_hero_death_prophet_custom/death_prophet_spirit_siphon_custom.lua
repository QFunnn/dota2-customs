--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_death_prophet_spirit_siphon_custom", "heroes/npc_dota_hero_death_prophet_custom/death_prophet_spirit_siphon_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_death_prophet_spirit_siphon_counter", "heroes/npc_dota_hero_death_prophet_custom/death_prophet_spirit_siphon_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_death_prophet_spirit_siphon_custom_debuff", "heroes/npc_dota_hero_death_prophet_custom/death_prophet_spirit_siphon_custom", LUA_MODIFIER_MOTION_NONE )

death_prophet_spirit_siphon_custom = class({})

death_prophet_spirit_siphon_custom.modifier_death_prophet_18 = {0.5,1,1.5}
death_prophet_spirit_siphon_custom.modifier_death_prophet_8 = {1,2,3}
death_prophet_spirit_siphon_custom.modifier_death_prophet_8_radius = 600

function death_prophet_spirit_siphon_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_death_prophet/death_prophet_spiritsiphon.vpcf', context )
end

function death_prophet_spirit_siphon_custom:CastFilterResultTarget( target )

	if target:HasModifier("modifier_death_prophet_spirit_siphon_custom_debuff") then
		return UF_FAIL_CUSTOM
	end

	local nResult = UnitFilter( target, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, self:GetCaster():GetTeamNumber() )

	if nResult ~= UF_SUCCESS then
		return nResult
	end

	return UF_SUCCESS
end

function death_prophet_spirit_siphon_custom:GetCustomCastErrorTarget(target)
    if target:HasModifier("modifier_death_prophet_spirit_siphon_custom_debuff") then
        return "#dota_hud_error_spirit_siphon_already_haunting"
    end
end

function death_prophet_spirit_siphon_custom:GetAbilityChargeRestoreTime(level)
    return self.BaseClass.GetAbilityChargeRestoreTime( self, level )
end

function death_prophet_spirit_siphon_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("haunt_duration")
	self:GetCaster():EmitSound("Hero_DeathProphet.SpiritSiphon.Cast")
	target:AddNewModifier(self:GetCaster(), self, "modifier_death_prophet_spirit_siphon_custom_debuff", {duration = duration})
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_death_prophet_spirit_siphon_custom", {duration = duration, target = target:entindex()})
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_death_prophet_spirit_siphon_counter", {duration = duration})

	if self:GetCaster():HasModifier("modifier_death_prophet_8") then
		local count = 0

		local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), nil, self.modifier_death_prophet_8_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, 0, false )
		for _, enemy in pairs(enemies) do
			if enemy ~= target and not enemy:HasModifier("modifier_death_prophet_spirit_siphon_custom_debuff") then
				self:GetCaster():EmitSound("Hero_DeathProphet.SpiritSiphon.Cast")
				enemy:AddNewModifier(self:GetCaster(), self, "modifier_death_prophet_spirit_siphon_custom_debuff", {duration = duration})
				self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_death_prophet_spirit_siphon_custom", {duration = duration, target = enemy:entindex()})
				self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_death_prophet_spirit_siphon_counter", {duration = duration})
				count = count + 1
				if count >= self.modifier_death_prophet_8[self:GetCaster():GetTalentLevel("modifier_death_prophet_8")] then break end
			end
		end
	end
end

modifier_death_prophet_spirit_siphon_counter = class({})

function modifier_death_prophet_spirit_siphon_counter:IsPurgable() return false end

function modifier_death_prophet_spirit_siphon_counter:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_death_prophet_spirit_siphon_counter:OnIntervalThink()
	if not IsServer() then return end
	local mod = self:GetCaster():FindAllModifiersByName("modifier_death_prophet_spirit_siphon_custom")
	if #mod <= 0 then self:Destroy() return end
	self:SetStackCount(#mod)
end

modifier_death_prophet_spirit_siphon_custom = class({})

function modifier_death_prophet_spirit_siphon_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_death_prophet_spirit_siphon_custom:IsHidden() return true end
function modifier_death_prophet_spirit_siphon_custom:IsPurgable() return false end

function modifier_death_prophet_spirit_siphon_custom:OnCreated(kv)
	if not IsServer() then return end
	self.target = EntIndexToHScript(kv.target)
	self:StartIntervalThink(FrameTime())
end

function modifier_death_prophet_spirit_siphon_custom:OnIntervalThink()
	if not IsServer() then return end

	if self.target == nil then self:Destroy() return end

	if self.target and not self.target:IsNull() and (not self.target:IsAlive() or not self.target:HasModifier("modifier_death_prophet_spirit_siphon_custom_debuff")) then
		self:Destroy()
		return
	end

	local distance = (self.target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D()

	local max_distance = self:GetAbility():GetCastRange(self:GetCaster():GetAbsOrigin(), self:GetCaster()) + self:GetCaster():GetCastRangeBonus() + self:GetAbility():GetSpecialValueFor("siphon_buffer")

	if distance > max_distance then
		self:Destroy()
		return
	end
end

function modifier_death_prophet_spirit_siphon_custom:OnDestroy()
	if not IsServer() then return end
	if self.target then
		self.target:RemoveModifierByName("modifier_death_prophet_spirit_siphon_custom_debuff")
	end
end

modifier_death_prophet_spirit_siphon_custom_debuff = class({})

function modifier_death_prophet_spirit_siphon_custom_debuff:IsPurgable() return false end

function modifier_death_prophet_spirit_siphon_custom_debuff:OnCreated()
	if not IsServer() then return end
	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_death_prophet/death_prophet_spiritsiphon.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true )
	ParticleManager:SetParticleControlEnt( nFXIndex, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true )
	ParticleManager:SetParticleControl( nFXIndex, 5, Vector( 999, 0, 0 ) ) 
	self:AddParticle( nFXIndex, false, false, -1, false, true )
	self.fear = 0
	self.fear_active = true
	self:GetParent():EmitSound("Hero_DeathProphet.SpiritSiphon.Target")
	self:StartIntervalThink(0.25)
	local death_prophet_exorcism_custom = self:GetCaster():FindAbilityByName("death_prophet_exorcism_custom")
    if death_prophet_exorcism_custom and death_prophet_exorcism_custom:GetLevel() > 0 then
    	if self:GetCaster():HasModifier("modifier_death_prophet_11") then
        	death_prophet_exorcism_custom:CastGhostToTarget(self:GetParent(),death_prophet_exorcism_custom.modifier_death_prophet_13[self:GetCaster():GetTalentLevel("modifier_death_prophet_11")])
        end
    end
end

function modifier_death_prophet_spirit_siphon_custom_debuff:OnDestroy()
	if not IsServer() then return end
	self:GetParent():StopSound("Hero_DeathProphet.SpiritSiphon.Target")
end

function modifier_death_prophet_spirit_siphon_custom_debuff:OnIntervalThink()
	if not IsServer() then return end

	if self:GetCaster():HasModifier("modifier_death_prophet_18") and self.fear_active and not self:GetParent():IsMagicImmune() then
		self.fear = self.fear + 0.25
		if self.fear >= 3 then
			self.fear = 0
			self.fear_active = false
			self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_death_prophet_spirit_siphon_fear", {duration = self:GetAbility().modifier_death_prophet_18[self:GetCaster():GetTalentLevel("modifier_death_prophet_18")] * (1 - self:GetParent():GetStatusResistance())})
		end
	end

	local damage = self:GetAbility():GetSpecialValueFor("damage") * 0.25

	local damage_table = 
	{
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility()
	}

	self:GetCaster():Heal(damage, self:GetAbility())
	
	ApplyDamage( damage_table )
end