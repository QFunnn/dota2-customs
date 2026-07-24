--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_terrorblade_reflection_custom", "heroes/npc_dota_hero_terrorblade_custom/terrorblade_reflection_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_terrorblade_reflection_custom_debuff", "heroes/npc_dota_hero_terrorblade_custom/terrorblade_reflection_custom", LUA_MODIFIER_MOTION_NONE)

terrorblade_reflection_custom = class({})

terrorblade_reflection_custom.modifier_terrorblade_10 = {1,2,3}
terrorblade_reflection_custom.modifier_terrorblade_11 = {-2,-4,-6}

function terrorblade_reflection_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_terrorblade_reflection.vpcf", context )
end

function terrorblade_reflection_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function terrorblade_reflection_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_terrorblade_11") then
        return 0
    else 
        return self.BaseClass.GetCastPoint( self )
    end
end

function terrorblade_reflection_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_terrorblade_11") then
		bonus = self.modifier_terrorblade_11[self:GetCaster():GetTalentLevel("modifier_terrorblade_11")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function terrorblade_reflection_custom:OnSpellStart()
	if not IsServer() then return end
	local illusion_duration = self:GetSpecialValueFor("illusion_duration")
	local illusion_outgoing_damage = self:GetSpecialValueFor("illusion_outgoing_damage") - 100
	local radius = self:GetSpecialValueFor("radius")

	if self:GetCaster():HasModifier("modifier_terrorblade_10") then
		illusion_duration = illusion_duration + self.modifier_terrorblade_10[self:GetCaster():GetTalentLevel("modifier_terrorblade_10")]
	end

	local flag = DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NO_INVIS

	if self:GetCaster():HasModifier("modifier_terrorblade_14") then
		flag = DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
	end

	local point = self:GetCursorPosition()

	local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, flag, FIND_ANY_ORDER, false)
	local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, flag, FIND_ANY_ORDER, false)

	if self:GetCaster():HasModifier("modifier_terrorblade_14") then
		for _, enemy in pairs(enemies) do
            if not enemy:IsDebuffImmune() then
                enemy:EmitSound("Hero_Terrorblade.Reflection")
                enemy:AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_reflection_custom_debuff", {duration = illusion_duration * (1 - enemy:GetStatusResistance())})
                local illusions = CreateIllusions(self:GetCaster(), self:GetCaster(), { outgoing_damage = illusion_outgoing_damage, bounty_base = 0, bounty_growth = nil, duration	= illusion_duration * (1 - enemy:GetStatusResistance())}, 1, 108, false, true)
                for _, illusion in pairs(illusions) do
                    FindClearSpaceForUnit(illusion, enemy:GetAbsOrigin()+RandomVector(108), true)
                    illusion:AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_reflection_custom", { duration = illusion_duration * (1 - enemy:GetStatusResistance()), enemy_entindex = enemy:entindex()})
                end
            end
		end
	else
		for _, enemy in pairs(enemies) do
            if not enemy:IsDebuffImmune() then
                enemy:EmitSound("Hero_Terrorblade.Reflection")
                enemy:AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_reflection_custom_debuff", {duration = illusion_duration * (1 - enemy:GetStatusResistance())})
                local illusions = CreateIllusions(self:GetCaster(), enemy, { outgoing_damage = illusion_outgoing_damage, bounty_base = 0, bounty_growth = nil, duration	= illusion_duration * (1 - enemy:GetStatusResistance())}, 1, 108, false, true)
                for _, illusion in pairs(illusions) do
                    illusion:AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_reflection_custom", { duration = illusion_duration * (1 - enemy:GetStatusResistance()), enemy_entindex = enemy:entindex()})
                end
            end
		end
	end

    if self:GetCaster():HasModifier("modifier_terrorblade_10") then
        if #units > 0 then
            if not units[1]:IsDebuffImmune() then
                units[1]:EmitSound("Hero_Terrorblade.Reflection")
                units[1]:AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_reflection_custom_debuff", {duration = illusion_duration * (1 - units[1]:GetStatusResistance())})
                local illusions = CreateIllusions(self:GetCaster(), self:GetCaster(), { outgoing_damage = illusion_outgoing_damage, bounty_base = 0, bounty_growth = nil, duration	= illusion_duration * (1 - units[1]:GetStatusResistance())}, 1, 108, false, true)
                for _, illusion in pairs(illusions) do
                    FindClearSpaceForUnit(illusion, units[1]:GetAbsOrigin()+RandomVector(108), true)
                    illusion:AddNewModifier(self:GetCaster(), self, "modifier_terrorblade_reflection_custom", { duration = illusion_duration * (1 - units[1]:GetStatusResistance()), enemy_entindex = units[1]:entindex()})
                end
            end
        end
    end
end	

modifier_terrorblade_reflection_custom_debuff	= class({})

function modifier_terrorblade_reflection_custom_debuff:IsPurgable()
	return true 
end

function modifier_terrorblade_reflection_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_terrorblade/terrorblade_reflection_slow.vpcf"
end

function modifier_terrorblade_reflection_custom_debuff:OnCreated()
	if not self:GetAbility() then self:Destroy() return end
	self.move_slow	= self:GetAbility():GetSpecialValueFor("move_slow")
	self.attack_slow	= self:GetAbility():GetSpecialValueFor("attack_slow")
end

function modifier_terrorblade_reflection_custom_debuff:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_terrorblade_reflection_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
	return self.move_slow 
end

function modifier_terrorblade_reflection_custom_debuff:GetModifierAttackSpeedBonus_Constant()
	return self.attack_slow 
end

modifier_terrorblade_reflection_custom = class({})

function modifier_terrorblade_reflection_custom:IsPurgable() return false end
function modifier_terrorblade_reflection_custom:IsHidden() return true end
function modifier_terrorblade_reflection_custom:GetStatusEffectName() return "particles/status_fx/status_effect_terrorblade_reflection.vpcf" end
function modifier_terrorblade_reflection_custom:StatusEffectPriority() return 10000000 end
function modifier_terrorblade_reflection_custom:GetModifierModelScale() return 30 end
function modifier_terrorblade_reflection_custom:GetModelScale() return 2 end

function modifier_terrorblade_reflection_custom:CheckState()
	return
	{
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNTARGETABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true
	}
end

function modifier_terrorblade_reflection_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_terrorblade_reflection_custom:OnCreated(keys)
	if not IsServer() then return end
	self.target = EntIndexToHScript( keys.enemy_entindex )
	self:StartIntervalThink(0.1)
end

function modifier_terrorblade_reflection_custom:OnIntervalThink()
	if self.target and not self.target:IsNull() and self:GetParent():IsAlive() and self.target:IsAlive() and self.target:HasModifier("modifier_terrorblade_reflection_custom_debuff") then
		if not self:GetParent():IsDisarmed() then 
		  	self:GetParent():SetForceAttackTarget(self.target)
	  		self:GetParent():MoveToTargetToAttack(self.target)
	 	end
	else
		self:DestroyIllusion()
	end
end

function modifier_terrorblade_reflection_custom:DestroyIllusion()
	if not IsServer() then return end
	for _,mod in ipairs(self:GetParent():FindAllModifiers()) do 
        mod:Destroy()
    end
	self:GetParent():SetForceAttackTarget(nil)
	self:GetParent():ForceKill(false)
end

function modifier_terrorblade_reflection_custom:OnDestroy()
	if not IsServer() then return end
	self:DestroyIllusion()
end