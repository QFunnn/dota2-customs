--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pudge_dismember_custom", "heroes/npc_dota_hero_pudge_custom/pudge_dismember_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pudge_dismember_custom_pull", "heroes/npc_dota_hero_pudge_custom/pudge_dismember_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_pudge_dismember_custom_channel", "heroes/npc_dota_hero_pudge_custom/pudge_dismember_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pudge_dismember_custom_break", "heroes/npc_dota_hero_pudge_custom/pudge_dismember_custom", LUA_MODIFIER_MOTION_NONE)

pudge_dismember_custom = class({})

function pudge_dismember_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_pudge/pudge_dismember.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_default.vpcf", context )
    PrecacheResource( "particle", "particles/generic_gameplay/generic_break.vpcf" , context )
end

pudge_dismember_custom.modifier_pudge_7 = 1
pudge_dismember_custom.modifier_pudge_7_cd = {-5}


function pudge_dismember_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_pudge_7") then
        bonus = self.modifier_pudge_7_cd[self:GetCaster():GetTalentLevel("modifier_pudge_7")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function pudge_dismember_custom:GetChannelAnimation()
	return ACT_DOTA_CHANNEL_ABILITY_4
end

function pudge_dismember_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_pudge_11") then
		return "pudge_11"
	end
	return "pudge_dismember"
end

function pudge_dismember_custom:GetCastRange(location, target)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_pudge_11") then
		bonus = 500
	end
    return self.BaseClass.GetCastRange(self, location, target) + bonus
end


function pudge_dismember_custom:GetIntrinsicModifierName()
	if not self:GetCaster():HasModifier("modifier_pudge_dismember_custom_channel") then 
		return "modifier_pudge_dismember_custom_channel"
	end 
	return 
end

function pudge_dismember_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_pudge_11") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_CHANNELLED + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function pudge_dismember_custom:GetChannelTime()
	if self:GetCaster():HasModifier("modifier_pudge_11") then return 0 end
	return self:GetCaster():GetModifierStackCount("modifier_pudge_dismember_custom_channel", self:GetCaster()) * 0.01
end

function pudge_dismember_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb(self) then self:GetCaster():Interrupt() return end

	if self:GetCaster():HasModifier("modifier_pudge_11") then
		local duration = self:GetSpecialValueFor("duration") * (1 - target:GetStatusResistance())
		if not target:IsHero() then
			duration = self:GetSpecialValueFor("creep_duration") * (1 - target:GetStatusResistance())
		end
		if self:GetCaster():HasModifier("modifier_pudge_7") then
			duration = duration + self.modifier_pudge_7
		end
		target:AddNewModifier(self:GetCaster(), self, "modifier_pudge_dismember_custom", {duration = duration})
		return
	end

	self.target = target
	target:AddNewModifier(self:GetCaster(), self, "modifier_pudge_dismember_custom", {duration = self:GetChannelTime()  })
end

function pudge_dismember_custom:OnChannelFinish(bInterrupted)
	if self:GetCaster():HasModifier("modifier_pudge_11") then return end
	if self.target then
		local target_buff = self.target:FindModifierByName("modifier_pudge_dismember_custom")
		if target_buff then
			target_buff:Destroy()
		end
	end
end

function pudge_dismember_custom:DealDamage(caster, target, tick, agility)
	if not IsServer() then return end
	self.dismember_damage	= self:GetSpecialValueFor("dismember_damage")
	self.strength_damage	= (self:GetSpecialValueFor("strength_damage"))

	if agility then
		self.strength_damage =  self.strength_damage * caster:GetAgility()
	else
		self.strength_damage =  self.strength_damage * caster:GetStrength()
	end

	self.damage = (self.dismember_damage + self.strength_damage)*tick
	local damageTable = { victim = target, attacker = caster, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, damage_flags = DOTA_DAMAGE_FLAG_NONE, ability = self}
	ApplyDamage(damageTable)
	target:EmitSound("Hero_Pudge.Dismember")
	caster:Heal(self.damage, self)
 	SendOverheadEventMessage(caster, 10, caster, self.damage, nil)
end

modifier_pudge_dismember_custom = class({})
function modifier_pudge_dismember_custom:IsDebuff() return true end
function modifier_pudge_dismember_custom:CheckState()
	if self.agility_damage then 
        return {[MODIFIER_STATE_ROOTED] = true}
    end
	return {[MODIFIER_STATE_STUNNED] = true}
end

function modifier_pudge_dismember_custom:DeclareFunctions()
	if self.agility_damage then return end
	return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION}
end

function modifier_pudge_dismember_custom:GetOverrideAnimation()
	if self.agility_damage then return end
	return ACT_DOTA_FLAIL
end

function modifier_pudge_dismember_custom:OnCreated()
	self.agility_damage = false
	if self:GetCaster():HasModifier("modifier_pudge_11") then
		self.agility_damage = true
	end
	if not IsServer() then return end
	
	if self:GetCaster():HasModifier("modifier_pudge_7") then
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_pudge_dismember_custom_break", {duration = self:GetRemainingTime()})
	end

	self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_pudge/pudge_dismember.vpcf", PATTACH_ABSORIGIN, self:GetParent())
	ParticleManager:SetParticleControlEnt(self.pfx, 0, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true)
	self:AddParticle(self.pfx, false, false, -1, false, false)

	if self:GetCaster():HasModifier("modifier_pudge_11") then
		self.agility_damage = true
		self.talent_particle = ParticleManager:CreateParticle("particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_default.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(self.talent_particle, 1, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(self.talent_particle, 14, Vector(1, 1, 1))
        ParticleManager:SetParticleControl(self.talent_particle, 15, Vector(0, 255, 0))
        self:AddParticle(self.talent_particle, false, false, -1, false, false)

		local tick = self:GetAbility():GetSpecialValueFor("ticks")
		self.max = tick
		self.count = 0
		self.standard_tick_interval	= self:GetDuration() / tick 
		self:StartIntervalThink(self.standard_tick_interval)
		self:OnIntervalThink()
		return
	end

	local tick = self:GetAbility():GetSpecialValueFor("ticks")
	self.max = tick
	self.count = 0
	self.standard_tick_interval	= self:GetAbility():GetChannelTime() / tick 
	self:StartIntervalThink(self.standard_tick_interval)
	self:OnIntervalThink()
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_pudge_dismember_custom_pull", {duration = self:GetAbility():GetChannelTime()})
end

function modifier_pudge_dismember_custom:OnIntervalThink()
	if not IsServer() then return end
	if self.count >= self.max then return end
	if self.talent_particle then
		ParticleManager:SetParticleControl(self.talent_particle, 1, self:GetParent():GetAbsOrigin())
	end
	self.count = self.count + 1
	self:GetAbility():DealDamage(self:GetCaster(), self:GetParent(), self.standard_tick_interval, self.agility_damage)
end

function modifier_pudge_dismember_custom:OnDestroy()
	if not IsServer() then return end
	self:GetParent():RemoveModifierByName("modifier_pudge_dismember_custom_break")
	if self:GetCaster():IsChanneling() then
		self:GetAbility():EndChannel(false)
		self:GetCaster():MoveToPositionAggressive(self:GetParent():GetAbsOrigin())
	end
end

modifier_pudge_dismember_custom_pull = class({})

function modifier_pudge_dismember_custom_pull:IsHidden() return true end

function modifier_pudge_dismember_custom_pull:OnCreated(params)
	if not IsServer() then return end
	self.ability = self:GetAbility()
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.pull_units_per_second = self.ability:GetSpecialValueFor("pull_units_per_second")
	self.pull_distance_limit = self.ability:GetSpecialValueFor("pull_distance_limit")
	if self:ApplyHorizontalMotionController() == false then 
		self:Destroy()
		return
	end
end

function modifier_pudge_dismember_custom_pull:UpdateHorizontalMotion( me, dt )
	if not IsServer() then return end
	local distance = self.caster:GetOrigin() - me:GetOrigin()
	if distance:Length2D() > self.pull_distance_limit and self.parent:HasModifier("modifier_pudge_dismember_custom") then
		me:SetOrigin( me:GetOrigin() + distance:Normalized() * self.pull_units_per_second * dt )
	else
		self:Destroy()
	end
end

function modifier_pudge_dismember_custom_pull:OnDestroy()
	if not IsServer() then return end
	self.parent:RemoveHorizontalMotionController( self )
end

modifier_pudge_dismember_custom_channel = class({})

function modifier_pudge_dismember_custom_channel:IsHidden()	return true end
function modifier_pudge_dismember_custom_channel:IsPurgable()	return false end
function modifier_pudge_dismember_custom_channel:GetAttributes()	return MODIFIER_ATTRIBUTE_MULTIPLE end

function modifier_pudge_dismember_custom_channel:DeclareFunctions()
	local decFuncs = {MODIFIER_EVENT_ON_ABILITY_EXECUTED}
	return decFuncs
end

function modifier_pudge_dismember_custom_channel:OnAbilityExecuted(params)
	if not IsServer() then return end
	if params.ability == self:GetAbility() then
		local duration = self:GetAbility():GetSpecialValueFor("duration")
		if not params.target:IsHero() then
			duration = self:GetAbility():GetSpecialValueFor("creep_duration")
		end
		if self:GetCaster():HasModifier("modifier_pudge_7") then
			duration = duration + self:GetAbility().modifier_pudge_7
		end
		self:GetCaster():SetModifierStackCount("modifier_pudge_dismember_custom_channel", self:GetCaster(), duration * (1 - params.target:GetStatusResistance()) * 100)
	end
end

modifier_pudge_dismember_custom_break = class({})

function modifier_pudge_dismember_custom_break:IsHidden() return true end
function modifier_pudge_dismember_custom_break:IsPurgable() return false end 

function modifier_pudge_dismember_custom_break:CheckState() 
	return 
	{
		[MODIFIER_STATE_PASSIVES_DISABLED] = true
	} 
end

function modifier_pudge_dismember_custom_break:GetEffectName() 
	return "particles/generic_gameplay/generic_break.vpcf" 
end
 
function modifier_pudge_dismember_custom_break:GetEffectAttachType() 
	return PATTACH_OVERHEAD_FOLLOW 
end