--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



LinkLuaModifier( "modifier_monkey_king_jingu_mastery_lua", "heroes/hero_monkey_king/monkey_king_jingu_mastery_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_monkey_king_jingu_mastery_lua_buff", "heroes/hero_monkey_king/monkey_king_jingu_mastery_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_monkey_king_jingu_mastery_lua_count_debuff", "heroes/hero_monkey_king/monkey_king_jingu_mastery_lua", LUA_MODIFIER_MOTION_NONE )

monkey_king_jingu_mastery_lua = monkey_king_jingu_mastery_lua or class({})

function monkey_king_jingu_mastery_lua:IsHiddenWhenStolen() return false end
function monkey_king_jingu_mastery_lua:IsRefreshable() return false end
function monkey_king_jingu_mastery_lua:IsStealable() return false end
function monkey_king_jingu_mastery_lua:IsNetherWardStealable() return false end

function monkey_king_jingu_mastery_lua:GetAbilityTextureName()
   return "monkey_king_jingu_mastery"
end

function monkey_king_jingu_mastery_lua:GetIntrinsicModifierName()
	--this is a quick hack for the tempest double getting "modifier_monkey_king_jingu_mastery_lua" without leveling the spell
	local level = self:GetLevel()
	if level == 0 then return nil end
	return "modifier_monkey_king_jingu_mastery_lua"
end



modifier_monkey_king_jingu_mastery_lua = modifier_monkey_king_jingu_mastery_lua or class({})

function modifier_monkey_king_jingu_mastery_lua:IsHidden() return true end
function modifier_monkey_king_jingu_mastery_lua:IsDebuff()
	return false
end
function modifier_monkey_king_jingu_mastery_lua:IsPurgable()
	return false
end
function modifier_monkey_king_jingu_mastery_lua:IsPurgeException()
	return false
end
function modifier_monkey_king_jingu_mastery_lua:AllowIllusionDuplicate()
	return false
end
function modifier_monkey_king_jingu_mastery_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function modifier_monkey_king_jingu_mastery_lua:OnCreated(  )
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	
	self.required_hit = self.ability:GetSpecialValueFor("required_hits")
	self.counter_duration = self.ability:GetSpecialValueFor("counter_duration")
	self.max_duration = self.ability:GetSpecialValueFor("max_duration")

end


function modifier_monkey_king_jingu_mastery_lua:OnRefresh(  )
	self:OnCreated()
end

function modifier_monkey_king_jingu_mastery_lua:OnAttackLanded( keys )
	
	local ability = keys.ability
	local target = keys.target
	local attacker = keys.attacker
	local damage = keys.damage

	if attacker ~= self.parent and self.caster ~= attacker then return end

	if target:IsBuilding() or self.caster:PassivesDisabled() or not (self.caster:IsRealHero() or self.caster:IsTempestDouble()) or self.caster:IsIllusion() then return end

	if target:IsIllusion() or target:IsOther() then return end

	-- if caster has already buff do nothing
	if self.caster:HasModifier("modifier_monkey_king_jingu_mastery_lua_buff") then return end	
	
	-- prevent monkey ulti to get buffed
	if attacker:HasModifier("modifier_monkey_king_fur_army_soldier") then return end
		
	-- when enemy get hit
	local jinguMasteryStack_debuff = target:FindModifierByName("modifier_monkey_king_jingu_mastery_lua_count_debuff")
	if not jinguMasteryStack_debuff then
		jinguMasteryStack_debuff = target:AddNewModifier(self.caster, self.ability, "modifier_monkey_king_jingu_mastery_lua_count_debuff", {duration = self.counter_duration})
		if not jinguMasteryStack_debuff then return end -- error log tells me that newly created modifier is missing
														-- probably stacked with teleportation to base or whatever
		jinguMasteryStack_debuff:SetStackCount(0)
	end

	-- if we got all 4 hits then remove particle and give monkey 4 charges
	if jinguMasteryStack_debuff:GetStackCount() + 1 >= self.required_hit then
		jinguMasteryStack_debuff:Destroy()
			
		local jinguBuffStack = self.caster:AddNewModifier(self.caster, self.ability, "modifier_monkey_king_jingu_mastery_lua_buff", {duration = self.max_duration})
		if not jinguBuffStack then return end
		
		jinguBuffStack:SetStackCount(self.ability:GetSpecialValueFor("charges"))
		self:GetAbility().jingu_mastery_buff_modifier = jinguBuffStack
		
		local jingu_start_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, self.caster)
		ParticleManager:SetParticleControl(jingu_start_particle, 0, self.caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(jingu_start_particle)
			
		EmitSoundOn("Hero_MonkeyKing.IronCudgel", self.caster)
		
	else
			jinguMasteryStack_debuff:IncrementStackCount()
			jinguMasteryStack_debuff:SetDuration(jinguMasteryStack_debuff:GetDuration(), true)
	-- debuff circle over the targets head
		if not target.jingu_overhead_particle then
			target.jingu_overhead_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_stack.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
		end
		
		ParticleManager:SetParticleControl(target.jingu_overhead_particle, 0, target:GetAbsOrigin())
		ParticleManager:SetParticleControl(target.jingu_overhead_particle, 1, Vector(0, jinguMasteryStack_debuff:GetStackCount(), 0))
	end
		
	return 0
end

modifier_monkey_king_jingu_mastery_lua_count_debuff = class({})
function modifier_monkey_king_jingu_mastery_lua_count_debuff:OnCreated( )
	
end

function modifier_monkey_king_jingu_mastery_lua_count_debuff:OnRefresh( )

end

function modifier_monkey_king_jingu_mastery_lua_count_debuff:OnDestroy( )

		local target = self:GetParent()
		if target.jingu_overhead_particle then
			ParticleManager:DestroyParticle(target.jingu_overhead_particle, false)
			ParticleManager:ReleaseParticleIndex(target.jingu_overhead_particle)
			target.jingu_overhead_particle = nil
		end
		
end

modifier_monkey_king_jingu_mastery_lua_buff = class({})

function modifier_monkey_king_jingu_mastery_lua_buff:DeclareFunctions()

	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}

	return funcs

end

function modifier_monkey_king_jingu_mastery_lua_buff:OnCreated( )
	self.bonus_damage 			= self:GetAbility():GetSpecialValueFor("bonus_damage") 
	self.lifesteal 				= self:GetAbility():GetSpecialValueFor("lifesteal")
	
	local caster = self:GetCaster()

	if caster.jingubuff_overhead_particle == nil then
		caster.jingubuff_overhead_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_overhead.vpcf", PATTACH_OVERHEAD_FOLLOW, caster)
	end
	
	if caster.jingubuff_weapon_glow_particle == nil then
		caster.jingubuff_weapon_glow_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_tap_buff.vpcf", PATTACH_ROOTBONE_FOLLOW, caster)
		ParticleManager:SetParticleControlEnt(caster.jingubuff_weapon_glow_particle, 0, caster, PATTACH_ROOTBONE_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(caster.jingubuff_weapon_glow_particle, 2, caster, PATTACH_POINT_FOLLOW, "attach_weapon_top", caster:GetAbsOrigin(), true)
		ParticleManager:SetParticleControlEnt(caster.jingubuff_weapon_glow_particle, 3, caster, PATTACH_POINT_FOLLOW, "attach_weapon_bot", caster:GetAbsOrigin(), true)
	end

	if IsClient() then return end

	-- Talent handling
end

function modifier_monkey_king_jingu_mastery_lua_buff:OnRefresh( )
		self:OnCreated( )
end

function modifier_monkey_king_jingu_mastery_lua_buff:OnDestroy( )
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then return end
	ability.jingu_mastery_buff_modifier = nil
	
	local caster = self:GetCaster()


	if caster.jingubuff_overhead_particle then
		ParticleManager:DestroyParticle(caster.jingubuff_overhead_particle, false)
		ParticleManager:ReleaseParticleIndex(caster.jingubuff_overhead_particle)
		caster.jingubuff_overhead_particle = nil
	end
	
	if caster.jingubuff_weapon_glow_particle  then
		ParticleManager:DestroyParticle(caster.jingubuff_weapon_glow_particle, false)
		ParticleManager:ReleaseParticleIndex(caster.jingubuff_weapon_glow_particle)
		caster.jingubuff_weapon_glow_particle = nil
	end
	
end

function modifier_monkey_king_jingu_mastery_lua_buff:OnAbilityExecuted(keys)
    if not IsServer() then return end

    local parent = self:GetParent()
    if keys.unit ~= parent then return end
    if parent:PassivesDisabled() then return end
    if keys.ability:GetName() ~= "monkey_king_boundless_strike" then return end

    self:GetParent():SetContextThink(DoUniqueString("jingu_decay"), function()
        if not self or self:IsNull() then return nil end

        self:DecrementStackCount()
        if self:GetStackCount() <= 0 then
            self:Destroy()
        end

        return nil
    end, 0.03)
end


function modifier_monkey_king_jingu_mastery_lua_buff:GetModifierPreAttack_BonusDamage(params)
	if not self:GetParent() or self:GetParent():IsNull() then return end
	return self.bonus_damage
end


function modifier_monkey_king_jingu_mastery_lua_buff:OnAttackLanded( keys )
	local attacker 		= keys.attacker
	local caster 				= self:GetCaster()
	local target 				= keys.target
	local ability 				= keys.ability
	local damage 			= keys.damage
	
	if attacker ~= caster then return end

	if not (attacker:IsRealHero() or attacker:IsTempestDouble()) or attacker:IsIllusion() then return end
	if caster:PassivesDisabled() then
		return 0
	end
	
	-- lifesteal pfx and heal
	local lifePfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf", PATTACH_OVERHEAD_FOLLOW, caster)
--	ParticleManager:SetParticleControl(lifePfx, 0, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(lifePfx)

	-- jingu hit pfx
	local hitPfx = ParticleManager:CreateParticle("particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_hit.vpcf", PATTACH_ROOTBONE_FOLLOW, target)
	ParticleManager:SetParticleControl(hitPfx, 1, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(hitPfx)
	
    local healAmount = damage *  self.lifesteal * 0.01
	attacker:Heal(healAmount, attacker)

	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self:Destroy()
	end
	
end