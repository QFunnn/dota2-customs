--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_chain_lightning", "neutrals/woda_neutral_chain_lightning", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_chain_lightning = class({})

function woda_neutral_chain_lightning:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/harpy_chain_lightning.vpcf", context )
end

function woda_neutral_chain_lightning:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})

	Timers:CreateTimer(0, function()
		if not self:GetCaster():IsAlive() then return end
		local head_particle = ParticleManager:CreateParticle("particles/neutral_fx/harpy_chain_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
		ParticleManager:SetParticleControlEnt(head_particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(head_particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
		ParticleManager:ReleaseParticleIndex(head_particle)
		target:AddNewModifier(self:GetCaster(), self, "modifier_woda_neutral_chain_lightning", { starting_unit_entindex = target:entindex() })
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

modifier_woda_neutral_chain_lightning = class({})

function modifier_woda_neutral_chain_lightning:IsHidden()		return true end
function modifier_woda_neutral_chain_lightning:IsPurgable()		return false end
function modifier_woda_neutral_chain_lightning:RemoveOnDeath()	return false end
function modifier_woda_neutral_chain_lightning:GetAttributes()	return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_woda_neutral_chain_lightning:OnCreated(keys)
	if not IsServer() or not self:GetAbility() then return end
	self.radius				= self:GetAbility():GetSpecialValueFor("radius")
	self.jump_delay			= self:GetAbility():GetSpecialValueFor("interval")
	self.jump_count			= self:GetAbility():GetSpecialValueFor("max_waves")
	self.buff_skill = false
	self.damage_type = DAMAGE_TYPE_MAGICAL
	self.starting_unit_entindex	= keys.starting_unit_entindex
	self.units_affected			= {}
	
	if self.starting_unit_entindex and EntIndexToHScript(self.starting_unit_entindex) then
		self.current_unit = EntIndexToHScript(self.starting_unit_entindex)
		self.units_affected[self.current_unit]	= 1
		self.current_unit:EmitSound("n_creep_HarpyStorm.ChainLighting")
		self.damage = self.current_unit:GetMana() / 100 * self:GetAbility():GetSpecialValueFor("damage_from_mana")
		if not self.current_unit:IsMagicImmune() then
			ApplyDamage({ victim = self.current_unit, damage = self.damage, damage_type	= self.damage_type, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self:GetAbility() })
		end
	else
		if not self:IsNull() then
            self:Destroy()
        end
		return
	end
	
	self.unit_counter = 0
	self:StartIntervalThink(self.jump_delay)
end

function modifier_woda_neutral_chain_lightning:OnIntervalThink()
	self.zapped = false
	
	if (self.unit_counter >= self.jump_count and self.jump_count > 0) or not self.zapped then
		for _, enemy in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self.current_unit:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)) do
			if not self.units_affected[enemy] and enemy ~= self.current_unit and enemy ~= self.previous_unit then
				self.lightning_particle = ParticleManager:CreateParticle("particles/neutral_fx/harpy_chain_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.current_unit)
				ParticleManager:SetParticleControlEnt(self.lightning_particle, 0, self.current_unit, PATTACH_POINT_FOLLOW, "attach_hitloc", self.current_unit:GetAbsOrigin(), true)
				ParticleManager:SetParticleControlEnt(self.lightning_particle, 1, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true)
				ParticleManager:ReleaseParticleIndex(self.lightning_particle)
				
				self.unit_counter						= self.unit_counter + 1
				self.previous_unit						= self.current_unit
				self.current_unit						= enemy
				
				if self.units_affected[self.current_unit] then
					self.units_affected[self.current_unit]	= self.units_affected[self.current_unit] + 1
				else
					self.units_affected[self.current_unit]	= 1
				end
				
				self.zapped								= true
				self.current_unit:EmitSound("n_creep_HarpyStorm.ChainLighting")
				self.damage = self.current_unit:GetMana() / 100 * self:GetAbility():GetSpecialValueFor("damage_from_mana")
				ApplyDamage({ victim = self.current_unit, damage = self.damage, damage_type	= self.damage_type, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self:GetAbility() })
				break
			end
		end
		
		if (self.unit_counter >= self.jump_count and self.jump_count > 0) or not self.zapped then
			self:StartIntervalThink(-1)
			if not self:IsNull() then
                self:Destroy()
            end
		end
	end
end