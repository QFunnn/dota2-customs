--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_slark_essence_shift_custom", "heroes/npc_dota_hero_slark_custom/slark_essence_shift_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_essence_shift_custom_debuff", "heroes/npc_dota_hero_slark_custom/slark_essence_shift_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_essence_shift_custom_debuff_stack", "heroes/npc_dota_hero_slark_custom/slark_essence_shift_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_essence_shift_custom_stack", "heroes/npc_dota_hero_slark_custom/slark_essence_shift_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_essence_shift_custom_buff", "heroes/npc_dota_hero_slark_custom/slark_essence_shift_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_essence_shift_custom_permanent_debuff", "heroes/npc_dota_hero_slark_custom/slark_essence_shift_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_essence_shift_custom_stack_strength", "heroes/npc_dota_hero_slark_custom/slark_essence_shift_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_slark_essence_shift_custom_buff_strength", "heroes/npc_dota_hero_slark_custom/slark_essence_shift_custom", LUA_MODIFIER_MOTION_NONE )

slark_essence_shift_custom = class({})

function slark_essence_shift_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_slark/slark_essence_shift.vpcf", context )
end

slark_essence_shift_custom.modifier_slark_3 = {0.5,1}
slark_essence_shift_custom.modifier_slark_11_creep_duration = 3
slark_essence_shift_custom.modifier_slark_11 = {0.5,1}

function slark_essence_shift_custom:GetCastRange(vLocation, hTarget)
	return 1
end

function slark_essence_shift_custom:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
end

function slark_essence_shift_custom:GetIntrinsicModifierName()
	return "modifier_slark_essence_shift_custom"
end

modifier_slark_essence_shift_custom = class({})

function modifier_slark_essence_shift_custom:IsHidden() return self:GetStackCount() == 0 or self:GetParent():HasModifier("modifier_slark_3") end
function modifier_slark_essence_shift_custom:IsPurgable() return false end
function modifier_slark_essence_shift_custom:IsPurgeException() return false end
function modifier_slark_essence_shift_custom:RemoveOnDeath() return false end

function modifier_slark_essence_shift_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}
	return funcs
end

function modifier_slark_essence_shift_custom:GetModifierProcAttack_Feedback( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
		local target = params.target

		if not target:IsHero() and self:GetParent():HasModifier("modifier_slark_11") then
			if self:GetParent():HasModifier("modifier_slark_17") then return end
			self:AttackTargetCreep(params.target)
			if not params.no_attack_cooldown then
				self:PlayEffects( params.target )
			end
			return
		end

		if (not target:IsHero()) or target:IsIllusion() then return end
		if self:GetParent():HasModifier("modifier_slark_17") then return end
		self:AttackTarget(params.target)
		if not params.no_attack_cooldown then
			self:PlayEffects( params.target )
		end
	end
end

function modifier_slark_essence_shift_custom:AttackTarget(target, pounce)
	if not IsServer() then return end
	if self:GetParent():HasModifier("modifier_slark_17") then return end
	local duration = self:GetAbility():GetSpecialValueFor("duration")
	target:AddNewModifier( self:GetParent(),self:GetAbility(), "modifier_slark_essence_shift_custom_permanent_debuff", {})
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_essence_shift_custom_stack", {duration = duration })
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_essence_shift_custom_buff", {duration = duration })
	target:AddNewModifier( self:GetParent(),self:GetAbility(), "modifier_slark_essence_shift_custom_debuff_stack", { duration = duration })
	target:AddNewModifier( self:GetParent(),self:GetAbility(), "modifier_slark_essence_shift_custom_debuff", { duration = duration })
	if self:GetCaster():HasModifier("modifier_slark_3") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_essence_shift_custom_stack_strength", {duration = duration })
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_essence_shift_custom_buff_strength", {duration = duration })
	end
	target:CalculateStatBonus(true)
end

function modifier_slark_essence_shift_custom:AttackTargetCreep(target, pounce)
	if not IsServer() then return end
	if self:GetParent():HasModifier("modifier_slark_17") then return end
	local duration = self:GetAbility().modifier_slark_11_creep_duration
	self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_essence_shift_custom_stack", {duration = duration })
	if self:GetCaster():HasModifier("modifier_slark_essence_shift_custom_buff") then
		local modifier_slark_essence_shift_custom_buff = self:GetCaster():FindModifierByName("modifier_slark_essence_shift_custom_buff")
		if modifier_slark_essence_shift_custom_buff then
			modifier_slark_essence_shift_custom_buff:SetDuration(math.max(modifier_slark_essence_shift_custom_buff:GetRemainingTime(), duration), true)
		end
	else
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_essence_shift_custom_buff", {duration = duration })
	end
	if self:GetCaster():HasModifier("modifier_slark_3") then
		self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_essence_shift_custom_stack_strength", {duration = duration })
		if self:GetCaster():HasModifier("modifier_slark_essence_shift_custom_buff_strength") then
			local modifier_slark_essence_shift_custom_buff_strength = self:GetCaster():FindModifierByName("modifier_slark_essence_shift_custom_buff_strength")
			if modifier_slark_essence_shift_custom_buff_strength then
				modifier_slark_essence_shift_custom_buff_strength:SetDuration(math.max(modifier_slark_essence_shift_custom_buff_strength:GetRemainingTime(), duration), true)
			end
		else
			self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_essence_shift_custom_buff_strength", {duration = duration })
		end
	end
end

function modifier_slark_essence_shift_custom:GetModifierBonusStats_Agility()
    if self:GetParent():HasModifier("modifier_slark_3") then return end
	return self:GetStackCount()
end

function modifier_slark_essence_shift_custom:GetModifierBonusStats_Strength()
    if not self:GetParent():HasModifier("modifier_slark_3") then return end
    return self:GetStackCount()
end

function modifier_slark_essence_shift_custom:PlayEffects( target )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_slark/slark_essence_shift.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, self:GetParent():GetOrigin() + Vector( 0, 0, 64 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_slark_essence_shift_custom_debuff_stack = class({})
function modifier_slark_essence_shift_custom_debuff_stack:IsPurgable() return false end
function modifier_slark_essence_shift_custom_debuff_stack:IsPurgeException() return false end
function modifier_slark_essence_shift_custom_debuff_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_slark_essence_shift_custom_debuff_stack:IsHidden() return true end

modifier_slark_essence_shift_custom_stack = class({})
function modifier_slark_essence_shift_custom_stack:IsPurgable() return false end
function modifier_slark_essence_shift_custom_stack:IsPurgeException() return false end
function modifier_slark_essence_shift_custom_stack:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_slark_essence_shift_custom_stack:IsHidden() return true end

modifier_slark_essence_shift_custom_debuff = class({})
function modifier_slark_essence_shift_custom_debuff:IsPurgable() return false end
function modifier_slark_essence_shift_custom_debuff:IsPurgeException() return false end

function modifier_slark_essence_shift_custom_debuff:OnCreated()
    self.stat_loss = self:GetAbility():GetSpecialValueFor("stat_loss")
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_slark_essence_shift_custom_debuff:OnIntervalThink()
	if not IsServer() then return end
	local modifier_slark_essence_shift_custom_debuff_stack = self:GetParent():FindAllModifiersByName("modifier_slark_essence_shift_custom_debuff_stack")
	self:SetStackCount(#modifier_slark_essence_shift_custom_debuff_stack)
end

function modifier_slark_essence_shift_custom_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_EVENT_ON_DEATH
	}
end

function modifier_slark_essence_shift_custom_debuff:GetModifierBonusStats_Strength()
	return self:GetStackCount() * (-self.stat_loss)
end

function modifier_slark_essence_shift_custom_debuff:GetModifierBonusStats_Agility()
	return self:GetStackCount() * (-self.stat_loss)
end

function modifier_slark_essence_shift_custom_debuff:GetModifierBonusStats_Intellect()
	return self:GetStackCount() * (-self.stat_loss)
end

function modifier_slark_essence_shift_custom_debuff:OnDeath(params)
	local target = params.unit
	if self:GetCaster():GetTeamNumber() == target:GetTeamNumber() then return end
    if target ~= self:GetParent() then return end
	if target:IsReincarnating() then return end
	if not self:GetCaster():IsRealHero() then return end
	if not target:IsRealHero() then return end
	if self:GetCaster():HasModifier("modifier_wodarelax") then return end
	if not target:HasModifier("modifier_slark_essence_shift_custom_debuff") then return end
	if self:GetParent():HasModifier("modifier_slark_17") then return end
	if ((self:GetCaster():GetAbsOrigin() - target:GetAbsOrigin()):Length2D() <= self:GetAbility():GetSpecialValueFor("steal_radius")) or (params.attacker and params.attacker == self:GetCaster()) then
		local modifier_slark_essence_shift_custom = self:GetCaster():FindModifierByName("modifier_slark_essence_shift_custom")
		if modifier_slark_essence_shift_custom then
			modifier_slark_essence_shift_custom:IncrementStackCount()
            local modifier_slark_3_fx = self:GetCaster():FindModifierByName("modifier_slark_3_fx")
            if modifier_slark_3_fx then
                modifier_slark_3_fx:SetStackCount(modifier_slark_essence_shift_custom:GetStackCount())
            end
		end
		local modifier_slark_essence_shift_custom_permanent_debuff = target:FindModifierByName("modifier_slark_essence_shift_custom_permanent_debuff")
		if modifier_slark_essence_shift_custom_permanent_debuff then
			modifier_slark_essence_shift_custom_permanent_debuff:IncrementStackCount()
		end
	end
end

modifier_slark_essence_shift_custom_buff = class({})
function modifier_slark_essence_shift_custom_buff:IsPurgable() return false end
function modifier_slark_essence_shift_custom_buff:IsPurgeException() return false end

function modifier_slark_essence_shift_custom_buff:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_slark_essence_shift_custom_buff:OnIntervalThink()
	if not IsServer() then return end
	local modifier_slark_essence_shift_custom_stack = self:GetParent():FindAllModifiersByName("modifier_slark_essence_shift_custom_stack")
	self:SetStackCount(#modifier_slark_essence_shift_custom_stack)
end

function modifier_slark_essence_shift_custom_buff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
end

function modifier_slark_essence_shift_custom_buff:GetModifierBonusStats_Agility()
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_slark_11") then
		bonus = self:GetAbility().modifier_slark_11[self:GetCaster():GetTalentLevel("modifier_slark_11")]
	end
	return self:GetStackCount() * (self:GetAbility():GetSpecialValueFor("agi_gain") + bonus)
end

modifier_slark_essence_shift_custom_permanent_debuff = class({})
function modifier_slark_essence_shift_custom_permanent_debuff:IsPurgable() return false end
function modifier_slark_essence_shift_custom_permanent_debuff:IsPurgeException() return false end
function modifier_slark_essence_shift_custom_permanent_debuff:IsHidden() return true end
function modifier_slark_essence_shift_custom_permanent_debuff:RemoveOnDeath() return false end

function modifier_slark_essence_shift_custom_permanent_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	}
end

function modifier_slark_essence_shift_custom_permanent_debuff:GetModifierBonusStats_Agility()
	if self:GetStackCount() == 0 then return end
	return self:GetStackCount() * -1
end

modifier_slark_essence_shift_custom_stack_strength = class({})
function modifier_slark_essence_shift_custom_stack_strength:IsPurgable() return false end
function modifier_slark_essence_shift_custom_stack_strength:IsPurgeException() return false end
function modifier_slark_essence_shift_custom_stack_strength:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_slark_essence_shift_custom_stack_strength:IsHidden() return true end

modifier_slark_essence_shift_custom_buff_strength = class({})
function modifier_slark_essence_shift_custom_buff_strength:IsPurgable() return false end
function modifier_slark_essence_shift_custom_buff_strength:IsPurgeException() return false end
function modifier_slark_essence_shift_custom_buff_strength:GetTexture() return "slark_3" end

function modifier_slark_essence_shift_custom_buff_strength:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(FrameTime())
end

function modifier_slark_essence_shift_custom_buff_strength:OnIntervalThink()
	if not IsServer() then return end
	local modifier_slark_essence_shift_custom_stack_strength = self:GetParent():FindAllModifiersByName("modifier_slark_essence_shift_custom_stack_strength")
	self:SetStackCount(#modifier_slark_essence_shift_custom_stack_strength)
end

function modifier_slark_essence_shift_custom_buff_strength:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_slark_essence_shift_custom_buff_strength:GetModifierBonusStats_Strength()
	return self:GetStackCount() * self:GetAbility().modifier_slark_3[self:GetCaster():GetTalentLevel("modifier_slark_3")]
end