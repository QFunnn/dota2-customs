--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_weaver_the_swarm_custom_unit", "heroes/npc_dota_hero_weaver_custom/weaver_the_swarm_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_weaver_the_swarm_custom_debuff", "heroes/npc_dota_hero_weaver_custom/weaver_the_swarm_custom", LUA_MODIFIER_MOTION_NONE)

weaver_the_swarm_custom = class({})

weaver_the_swarm_custom.modifier_weaver_8 = {4,8,12}
weaver_the_swarm_custom.modifier_weaver_10 = {-3,-6,-9}
weaver_the_swarm_custom.modifier_weaver_11 = {40,80}
weaver_the_swarm_custom.modifier_weaver_12 = {1,2}
weaver_the_swarm_custom.modifier_weaver_13 = {0.25,0.5}
weaver_the_swarm_custom.modifier_weaver_14 = -0.15

function weaver_the_swarm_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_weaver_10") then
	    bonus = self.modifier_weaver_10[self:GetCaster():GetTalentLevel("modifier_weaver_10")]
	end
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function weaver_the_swarm_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_weaver.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_weaver.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_weaver.vpcf", context)
end

function weaver_the_swarm_custom:OnSpellStart()
	if not IsServer() then return end
    local point = self:GetCursorPosition()
	if point == self:GetCaster():GetAbsOrigin() then
		point = point + self:GetCaster():GetForwardVector()
	end
	self:GetCaster():EmitSound("Hero_Weaver.Swarm.Cast")
	local start_pos = nil
	local beetle_dummy = nil
	local projectile_table = nil
	local projectileID = nil
	
	for beetles = 1, self:GetSpecialValueFor("count") do
		start_pos = self:GetCaster():GetAbsOrigin() + RandomVector(RandomInt(0, self:GetSpecialValueFor("spawn_radius")))
		beetle_dummy = CreateModifierThinker(self:GetCaster(), self, nil, {}, self:GetCaster():GetAbsOrigin(), self:GetCaster():GetTeamNumber(), false)
		if beetles == 1 then
			beetle_dummy:EmitSound("Hero_Weaver.Swarm.Projectile")	
		end
		projectile_table = 
        {
			Ability				= self,
			EffectName			= "particles/units/heroes/hero_weaver/weaver_swarm_projectile.vpcf",
			vSpawnOrigin		= start_pos,
			fDistance			= self:GetSpecialValueFor("distance") + self:GetCaster():GetCastRangeBonus(),
			fStartRadius		= self:GetSpecialValueFor("radius"),
			fEndRadius			= self:GetSpecialValueFor("radius"),
			Source				= self:GetCaster(),
			bHasFrontalCone		= false,
			bReplaceExisting	= false,
			iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags	= DOTA_UNIT_TARGET_FLAG_NO_INVIS,
			iUnitTargetType		= DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			fExpireTime 		= GameRules:GetGameTime() + 10.0,
			bDeleteOnHit		= false,
			vVelocity			= (point - self:GetCaster():GetAbsOrigin()):Normalized() * self:GetSpecialValueFor("speed") * Vector(1, 1, 0),
			bProvidesVision		= true,
			iVisionRadius 		= 321,
			iVisionTeamNumber 	= self:GetCaster():GetTeamNumber(),
			ExtraData			= 
			{
				beetle_entindex	= beetle_dummy:entindex()
			}
		}
		projectileID = ProjectileManager:CreateLinearProjectile(projectile_table)
		beetle_dummy.projectileID = projectileID
	end
end

function weaver_the_swarm_custom:OnProjectileThink_ExtraData(location, data)
	if data.beetle_entindex and EntIndexToHScript(data.beetle_entindex) and not EntIndexToHScript(data.beetle_entindex):IsNull() then
		EntIndexToHScript(data.beetle_entindex):SetAbsOrigin(location)
	end
end

function weaver_the_swarm_custom:OnProjectileHit_ExtraData(target, location, data)
	if target and not target:HasModifier("modifier_weaver_the_swarm_custom_debuff") and data.beetle_entindex and EntIndexToHScript(data.beetle_entindex) and not EntIndexToHScript(data.beetle_entindex):IsNull() then
		target:EmitSound("Hero_Weaver.SwarmAttach")
		local beetle = CreateUnitByName("npc_dota_weaver_swarm", self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * 64, false, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
		local destroy_attacks = self:GetSpecialValueFor("destroy_attacks")
        local duration = self:GetSpecialValueFor("duration")
        local damage = self:GetSpecialValueFor("damage")
        local attack_rate = self:GetSpecialValueFor("attack_rate")
        local armor_reduction = self:GetSpecialValueFor("armor_reduction")
        if self:GetCaster():HasModifier("modifier_weaver_8") then
            damage = damage + self.modifier_weaver_8[self:GetCaster():GetTalentLevel("modifier_weaver_8")]
        end
        if self:GetCaster():HasModifier("modifier_weaver_12") then
            destroy_attacks = destroy_attacks + self.modifier_weaver_12[self:GetCaster():GetTalentLevel("modifier_weaver_12")]
        end
        if self:GetCaster():HasModifier("modifier_weaver_13") then
            armor_reduction = armor_reduction + self.modifier_weaver_13[self:GetCaster():GetTalentLevel("modifier_weaver_13")]
        end
        if self:GetCaster():HasModifier("modifier_weaver_14") then
            attack_rate = attack_rate + self.modifier_weaver_14
        end
        
        beetle:AddNewModifier(self:GetCaster(), self, "modifier_weaver_the_swarm_custom_unit", 
		{
			destroy_attacks		= destroy_attacks,
			target_entindex		= target:entindex()
		})
		beetle:SetForwardVector((target:GetAbsOrigin() - beetle:GetAbsOrigin()):Normalized())
		target:AddNewModifier(self:GetCaster(), self, "modifier_weaver_the_swarm_custom_debuff",
		{
			duration 			= duration,
			damage				= damage,
			attack_rate			= attack_rate,
			armor_reduction		= armor_reduction,
			damage_type			= self:GetAbilityDamageType(),
			beetle_entindex		= beetle:entindex()
		})
		if data.beetle_entindex and EntIndexToHScript(data.beetle_entindex) and EntIndexToHScript(data.beetle_entindex).projectileID then
			ProjectileManager:DestroyLinearProjectile(EntIndexToHScript(data.beetle_entindex).projectileID)
			EntIndexToHScript(data.beetle_entindex):StopSound("Hero_Weaver.Swarm.Projectile")
			EntIndexToHScript(data.beetle_entindex):RemoveSelf()
		end
	elseif not target and data.beetle_entindex and EntIndexToHScript(data.beetle_entindex) and not EntIndexToHScript(data.beetle_entindex):IsNull() then
		EntIndexToHScript(data.beetle_entindex):StopSound("Hero_Weaver.Swarm.Projectile")
		EntIndexToHScript(data.beetle_entindex):RemoveSelf()
	end
end

modifier_weaver_the_swarm_custom_unit = class({})
function modifier_weaver_the_swarm_custom_unit:IsHidden() return true end
function modifier_weaver_the_swarm_custom_unit:IsPurgable()	return false end
function modifier_weaver_the_swarm_custom_unit:GetEffectName()
	return "particles/units/heroes/hero_weaver/weaver_swarm_debuff.vpcf"
end
function modifier_weaver_the_swarm_custom_unit:OnCreated(params)
	if not IsServer() then return end
	self.destroy_attacks = params.destroy_attacks
	self.target = EntIndexToHScript(params.target_entindex)
	self.hero_attack_multiplier = 2
	self.health_increments		= self:GetParent():GetMaxHealth() / self.destroy_attacks
	self:StartIntervalThink(FrameTime())
end

function modifier_weaver_the_swarm_custom_unit:OnIntervalThink()
	if self.target and not self.target:IsNull() then
		if (self.target:IsInvisible() and not self:GetParent():CanEntityBeSeenByMyTeam(self.target)) or self:GetParent():HasModifier("modifier_imba_faceless_void_chronosphere_handler") or not self.target:IsAlive() then
			self:GetParent():ForceKill(false)
			self:Destroy()
		elseif self.target:IsAlive() then
			self:GetParent():SetAbsOrigin(self.target:GetAbsOrigin() + self.target:GetForwardVector() * 64)
			self:GetParent():SetForwardVector((self.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized())
		end
	else
        self:GetParent():ForceKill(false)
		self:Destroy()
    end
end

function modifier_weaver_the_swarm_custom_unit:OnDestroy()
	if not IsServer() then return end
	if self.target and not self.target:IsNull() and self.target:HasModifier("modifier_weaver_the_swarm_custom_debuff") then
		self.target:RemoveModifierByName("modifier_weaver_the_swarm_custom_debuff")
	end
end

function modifier_weaver_the_swarm_custom_unit:CheckState()
	return
	{
		[MODIFIER_STATE_NO_UNIT_COLLISION]	= true,
		[MODIFIER_STATE_MAGIC_IMMUNE]		= true,
	}
end

function modifier_weaver_the_swarm_custom_unit:DeclareFunctions()
	local decFuncs = 
    {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
		MODIFIER_EVENT_ON_ATTACKED
    }
    return decFuncs
end

function modifier_weaver_the_swarm_custom_unit:GetOverrideAnimation()
	return ACT_DOTA_IDLE
end

function modifier_weaver_the_swarm_custom_unit:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_weaver_the_swarm_custom_unit:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_weaver_the_swarm_custom_unit:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_weaver_the_swarm_custom_unit:OnAttacked(params)
    if not IsServer() then return end
	if params.target == self:GetParent() then
		local new_health = self:GetParent():GetHealth() - self.health_increments
		if params.attacker:IsHero() and not params.attacker:HasModifier("modifier_lich_8") then
			new_health = self:GetParent():GetHealth() - (self.health_increments * self.hero_attack_multiplier)
        end
		if new_health <= 0 or new_health < 1 then
			self:GetParent():EmitSound("Hero_Grimstroke.InkCreature.Death")
			self:GetParent():Kill(nil, params.attacker)
			self:Destroy()
        else
            self:GetParent():SetHealth(new_health)
        end
	end
end

modifier_weaver_the_swarm_custom_debuff = class({})
function modifier_weaver_the_swarm_custom_debuff:IgnoreTenacity() return false end
function modifier_weaver_the_swarm_custom_debuff:IsPurgable() return false end
function modifier_weaver_the_swarm_custom_debuff:GetEffectName()
	return "particles/units/heroes/hero_weaver/weaver_swarm_infected_debuff.vpcf"
end
function modifier_weaver_the_swarm_custom_debuff:OnCreated(params)
	if not IsServer() then return end
	self.damage			= params.damage
	self.attack_rate	= params.attack_rate
	self.damage_type	= params.damage_type
    self.armor_reduction = params.armor_reduction
	self.beetle			= EntIndexToHScript(params.beetle_entindex)
	self.damage_table	= 
    {
		victim 			= self:GetParent(),
		damage 			= self.damage,
		damage_type		= self.damage_type,
		damage_flags 	= DOTA_DAMAGE_FLAG_NONE,
		attacker 		= self:GetCaster(),
		ability 		= self:GetAbility()
    }
	self:OnIntervalThink()
	self:StartIntervalThink(self.attack_rate)
    self:SetHasCustomTransmitterData(true)
    self:SendBuffRefreshToClients()
end

function modifier_weaver_the_swarm_custom_debuff:AddCustomTransmitterData()
    return 
    {
        armor_reduction = self.armor_reduction,
    }
end

function modifier_weaver_the_swarm_custom_debuff:HandleCustomTransmitterData( data )
    self.armor_reduction = data.armor_reduction
end

function modifier_weaver_the_swarm_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
	self:IncrementStackCount()
	ApplyDamage(self.damage_table)
    if self:GetCaster():HasModifier("modifier_weaver_11") and not self:GetParent():IsAttackImmune() and not self:GetParent():IsInvulnerable() then
        self:GetParent():Script_ReduceMana(self.damage / 100 * self:GetAbility().modifier_weaver_11[self:GetCaster():GetTalentLevel("modifier_weaver_11")], self:GetAbility())
    end
end

function modifier_weaver_the_swarm_custom_debuff:OnDestroy()
	if not IsServer() then return end
	if self.beetle and not self.beetle:IsNull() and self.beetle:IsAlive() then
		self.beetle:ForceKill(false)
	end
end

function modifier_weaver_the_swarm_custom_debuff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_weaver_the_swarm_custom_debuff:GetModifierPhysicalArmorBonus()
	return self.armor_reduction * self:GetStackCount() * (-1)
end