--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_eye_of_thor", "items/item_eye_of_thor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_eye_of_thor_buff", "items/item_eye_of_thor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_eye_of_thor_chain", "items/item_eye_of_thor", LUA_MODIFIER_MOTION_NONE)

item_eye_of_thor = class({})

function item_eye_of_thor:GetIntrinsicModifierName()
	return "modifier_item_eye_of_thor"
end

function item_eye_of_thor:OnSpellStart()
	if not IsServer() then return end

	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	self:GetCaster():EmitSound("Item.SeerStone")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_item_eye_of_thor_buff", {duration = duration})

    local heroes = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO+DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE,FIND_ANY_ORDER, false)
    for _, enemy in pairs(heroes) do

    	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", PATTACH_WORLDORIGIN, enemy)
		ParticleManager:SetParticleControl(particle, 0, Vector(enemy:GetAbsOrigin().x, enemy:GetAbsOrigin().y, enemy:GetAbsOrigin().z))
		ParticleManager:SetParticleControl(particle, 1, Vector(enemy:GetAbsOrigin().x, enemy:GetAbsOrigin().y, 2000))
		ParticleManager:SetParticleControl(particle, 2, Vector(enemy:GetAbsOrigin().x, enemy:GetAbsOrigin().y, enemy:GetAbsOrigin().z))
		enemy:EmitSound("Hero_Zuus.LightningBolt")

    	enemy:AddNewModifier(self:GetCaster(), self, "modifier_item_eye_of_thor_chain", { starting_unit_entindex = enemy:entindex() })
    end
end

modifier_item_eye_of_thor_buff = class({})

function modifier_item_eye_of_thor_buff:IsPurgable() return false end

function modifier_item_eye_of_thor_buff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_item_eye_of_thor_buff:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetParent():GetDayTimeVisionRange(), 0.1, false)
end

function modifier_item_eye_of_thor_buff:CheckState()
	return {
		[MODIFIER_STATE_FORCED_FLYING_VISION] = true,
	}
end

function modifier_item_eye_of_thor_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_FIXED_DAY_VISION,
		MODIFIER_PROPERTY_FIXED_NIGHT_VISION
	}
end

function modifier_item_eye_of_thor_buff:GetFixedDayVision()
	return self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_item_eye_of_thor_buff:GetFixedNightVision()
	return self:GetAbility():GetSpecialValueFor("radius")
end

modifier_item_eye_of_thor = class({})

function modifier_item_eye_of_thor:IsHidden() return true end
function modifier_item_eye_of_thor:IsPurgable() return false end
function modifier_item_eye_of_thor:IsPurgeException() return false end
function modifier_item_eye_of_thor:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_item_eye_of_thor:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		 
        MODIFIER_EVENT_ON_ATTACK_RECORD
	}
end

function modifier_item_eye_of_thor:GetModifierPreAttack_BonusDamage()
	return self:GetAbility():GetSpecialValueFor("bonus_damage")
end

function modifier_item_eye_of_thor:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
end

function modifier_item_eye_of_thor:OnAttackRecord(keys)
	if keys.attacker == self:GetParent() then
		if keys.target:IsOther() then
            return nil
        end
		self.chance = self:GetAbility():GetSpecialValueFor("chain_chance")
        if RollPercentage(self.chance) then
        	self.critProc = true
        end
	end
end

function modifier_item_eye_of_thor:OnAttackLanded(keys)
    if keys.attacker == self:GetParent() then
        if self:GetParent():IsIllusion() then return end
        if self.critProc then
        	local target = keys.target
            if not target:HasModifier("modifier_item_eye_of_thor_chain") then
                target:EmitSound("Item.Maelstrom.Chain_Lightning")
                local head_particle = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
                ParticleManager:SetParticleControlEnt(head_particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
                ParticleManager:SetParticleControlEnt(head_particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
                ParticleManager:ReleaseParticleIndex(head_particle)
                target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_item_eye_of_thor_chain", { starting_unit_entindex = target:entindex() })
			end
            self.critProc = false
        end
    end
end

function modifier_item_eye_of_thor:CheckState()
	local state = {}
	if self.critProc then
		state = {[MODIFIER_STATE_CANNOT_MISS] = true}
	end
	return state
end


modifier_item_eye_of_thor_chain = class({})

function modifier_item_eye_of_thor_chain:IsHidden()		return true end
function modifier_item_eye_of_thor_chain:IsPurgable()		return false end
function modifier_item_eye_of_thor_chain:RemoveOnDeath()	return false end
function modifier_item_eye_of_thor_chain:GetAttributes()	return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_item_eye_of_thor_chain:OnCreated(keys)
	if not IsServer() or not self:GetAbility() then return end
	self.radius				= self:GetAbility():GetSpecialValueFor("chain_radius")
	self.jump_delay			= self:GetAbility():GetSpecialValueFor("chain_delay")
	self.jump_count			= self:GetAbility():GetSpecialValueFor("chain_strikes")
	self.buff_skill = false
	self.damage_type = DAMAGE_TYPE_MAGICAL
	self.starting_unit_entindex	= keys.starting_unit_entindex
	self.units_affected			= {}
	
	if self.starting_unit_entindex and EntIndexToHScript(self.starting_unit_entindex) then
		self.current_unit = EntIndexToHScript(self.starting_unit_entindex)
		self.units_affected[self.current_unit]	= 1
		self.current_unit:EmitSound("n_creep_HarpyStorm.ChainLighting")
		self.damage = self:GetAbility():GetSpecialValueFor("chain_damage")
		ApplyDamage({ victim = self.current_unit, damage = self.damage, damage_type	= self.damage_type, damage_flags = DOTA_DAMAGE_FLAG_NONE, attacker = self:GetCaster(), ability = self:GetAbility() })
	else
		if not self:IsNull() then
            self:Destroy()
        end
		return
	end
	
	self.unit_counter = 0
	self:StartIntervalThink(self.jump_delay)
end

function modifier_item_eye_of_thor_chain:OnIntervalThink()
	self.zapped = false
	
	if (self.unit_counter >= self.jump_count and self.jump_count > 0) or not self.zapped then
		for _, enemy in pairs(FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self.current_unit:GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)) do
			if not self.units_affected[enemy] and enemy ~= self.current_unit and enemy ~= self.previous_unit then
				self.lightning_particle = ParticleManager:CreateParticle("particles/items_fx/chain_lightning.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.current_unit)
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
				self.current_unit:EmitSound("Item.Maelstrom.Chain_Lightning.Jump")
				self.damage = self:GetAbility():GetSpecialValueFor("chain_damage")
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