--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_legion_commander_moment_of_courage_custom", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_moment_of_courage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_moment_of_courage_custom_speed", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_moment_of_courage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_moment_of_courage_custom_heal", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_moment_of_courage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_moment_of_courage_custom_heal_mark", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_moment_of_courage_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_legion_commander_moment_of_courage_custom_no_trigger", "heroes/npc_dota_hero_legion_commander_custom/legion_commander_moment_of_courage_custom", LUA_MODIFIER_MOTION_NONE)

legion_commander_moment_of_courage_custom = class({})

function legion_commander_moment_of_courage_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/lc_hit.vpcf", context )
end

legion_commander_moment_of_courage_custom.modifier_legion_commander_3 = {10, 20}

function legion_commander_moment_of_courage_custom:GetIntrinsicModifierName() 
	return "modifier_legion_commander_moment_of_courage_custom" 
end 

function legion_commander_moment_of_courage_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_legion_commander_7") then
		return "legion_commander_7"
	end
	return "legion_commander_moment_of_courage"
end

modifier_legion_commander_moment_of_courage_custom = class({})

function modifier_legion_commander_moment_of_courage_custom:IsPurgable() return false end

function modifier_legion_commander_moment_of_courage_custom:OnCreated()
    if not IsServer() then return end
    self.trigger_attacks = self:GetAbility():GetSpecialValueFor("trigger_attacks")
    self:SetStackCount(self.trigger_attacks)
end

function modifier_legion_commander_moment_of_courage_custom:OnRefresh()
    if not IsServer() then return end
    self.trigger_attacks = self:GetAbility():GetSpecialValueFor("trigger_attacks")
end

function modifier_legion_commander_moment_of_courage_custom:OnAttackStart(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if self:GetParent():PassivesDisabled() then return end
    if self:GetStackCount() > 0 then
        self:DecrementStackCount()
    end
end

function modifier_legion_commander_moment_of_courage_custom:DeclareFunctions()
	return
	{
		MODIFIER_EVENT_ON_ATTACK_RECORD,
        MODIFIER_EVENT_ON_ATTACK_START,
        MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL,
	}
end

function modifier_legion_commander_moment_of_courage_custom:GetModifierProperty_PhysicalLifesteal( params )
    if not IsServer() then return end
    if params.target:HasModifier("modifier_legion_commander_moment_of_courage_custom_heal_mark") then
        params.target:RemoveModifierByName("modifier_legion_commander_moment_of_courage_custom_heal_mark")
        local bonus = 0
        if self:GetCaster():HasModifier("modifier_legion_commander_3") then
            bonus = self:GetAbility().modifier_legion_commander_3[self:GetCaster():GetTalentLevel("modifier_legion_commander_3")]
        end
        return self:GetAbility():GetSpecialValueFor("hp_leech_percent") + bonus
    end
end

function modifier_legion_commander_moment_of_courage_custom:OnAttackRecord(params)
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_legion_commander_5") then
		if params.attacker == self:GetParent() then
			if not self:GetAbility():IsFullyCastable() then return end
			if self:GetParent():HasModifier("modifier_legion_commander_moment_of_courage_custom_no_trigger") then return end
			if self:GetParent():PassivesDisabled() then return end
			self:TriggerAttack()
			return
		end
	end

	if params.target ~= self:GetParent() then return end
	if not self:GetAbility():IsFullyCastable() then return end
	if self:GetParent():PassivesDisabled() then return end
    if params.no_attack_cooldown then return end
	self:TriggerAttack()
end

function modifier_legion_commander_moment_of_courage_custom:OnAttackLanded(params)
	if not IsServer() then return end
	if self:GetCaster():HasModifier("modifier_legion_commander_5") then
		if params.attacker == self:GetParent() then
			if self:GetParent():HasModifier("modifier_legion_commander_moment_of_courage_custom_no_trigger") then return end
			if self:GetParent():PassivesDisabled() then return end
            self:DecrementStackCount()
			self:TriggerAttack()
			return
		end
	end
	if params.target ~= self:GetParent() then return end
	if self:GetParent():HasModifier("modifier_legion_commander_moment_of_courage_custom_no_trigger") then return end
	if self:GetParent():PassivesDisabled() then return end
    if params.no_attack_cooldown then return end
	self:TriggerAttack()
end

function modifier_legion_commander_moment_of_courage_custom:TriggerAttack()
	if not IsServer() then return end
	if self:GetStackCount() <= 0 and self:GetAbility():IsFullyCastable() then
		self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_legion_commander_moment_of_courage_custom_speed", {duration = self:GetAbility():GetSpecialValueFor("buff_duration")})
	end
end

modifier_legion_commander_moment_of_courage_custom_speed = class({})

function modifier_legion_commander_moment_of_courage_custom_speed:IsHidden() return true end
function modifier_legion_commander_moment_of_courage_custom_speed:IsPurgable() return false end

function modifier_legion_commander_moment_of_courage_custom_speed:OnCreated(table)
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_legion_commander_moment_of_courage_custom_speed:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetParent():GetAttackTarget() then return end
	local target = self:GetParent():GetAttackTarget()
	if not target or target:IsNull() or not target:IsAlive() then self:Destroy() return end
	self:GetParent():EmitSound("Hero_LegionCommander.Courage")
	local mod = self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_legion_commander_moment_of_courage_custom_heal", {})
	self:GetParent():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 2)

	local particle = ParticleManager:CreateParticle( "particles/lc_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
   	ParticleManager:SetParticleControl( particle, 0, self:GetParent():GetAbsOrigin() )
   	ParticleManager:SetParticleControl( particle, 1, self:GetParent():GetAbsOrigin() )
   	ParticleManager:SetParticleControl( particle, 2, Vector(1,1,1) )
	ParticleManager:SetParticleControlForward( particle, 5, (target:GetOrigin() - self:GetParent():GetOrigin() ):Normalized() )

	local no_trigger = self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_legion_commander_moment_of_courage_custom_no_trigger", {})
	self:GetParent():PerformAttack(target, true, true, true, false, true, false, false)

	if no_trigger then 
		no_trigger:Destroy()
	end

    local modifier_legion_commander_moment_of_courage_custom = self:GetParent():FindModifierByName("modifier_legion_commander_moment_of_courage_custom")
    local cooldown = self:GetAbility().BaseClass.GetCooldown(self:GetAbility(), self:GetAbility():GetLevel())
	self:GetAbility():StartCooldown(cooldown)
    modifier_legion_commander_moment_of_courage_custom:SetStackCount(modifier_legion_commander_moment_of_courage_custom.trigger_attacks)

	self:Destroy()
end

modifier_legion_commander_moment_of_courage_custom_heal = class({})
function modifier_legion_commander_moment_of_courage_custom_heal:IsHidden() return true end
function modifier_legion_commander_moment_of_courage_custom_heal:IsPurgable() return false end

function modifier_legion_commander_moment_of_courage_custom_heal:DeclareFunctions()
	return
	{
		 
	}
end

function modifier_legion_commander_moment_of_courage_custom_heal:OnAttackLanded(params)
	if not IsServer() then return end
	if self:GetParent() ~= params.attacker then return end
	params.target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_legion_commander_moment_of_courage_custom_heal_mark", {})
	self:Destroy()
end

modifier_legion_commander_moment_of_courage_custom_heal_mark = class({})
function modifier_legion_commander_moment_of_courage_custom_heal_mark:IsHidden() return true end
function modifier_legion_commander_moment_of_courage_custom_heal_mark:IsPurgable() return false end
function modifier_legion_commander_moment_of_courage_custom_heal_mark:RemoveOnDeath() return false end

modifier_legion_commander_moment_of_courage_custom_no_trigger = class({})
function modifier_legion_commander_moment_of_courage_custom_no_trigger:IsHidden() return true end
function modifier_legion_commander_moment_of_courage_custom_no_trigger:IsPurgable() return false end