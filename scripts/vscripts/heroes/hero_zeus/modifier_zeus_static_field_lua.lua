--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_zeus_static_field_lua = class({})

function modifier_zeus_static_field_lua:IsHidden() return true end
function modifier_zeus_static_field_lua:IsPurgable() return false end
function modifier_zeus_static_field_lua:AllowIllusionDuplicate()
	return false
end

if not IsServer() then return end

function modifier_zeus_static_field_lua:OnCreated() 
	self:SetStats()
end


function modifier_zeus_static_field_lua:OnRefresh()
	self:SetStats()
end


function modifier_zeus_static_field_lua:SetStats()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.damage_health_pct = self.ability:GetSpecialValueFor("damage_health_pct") + self.parent:FindTalentValue("special_bonus_unique_zeus")
	self.damage_health_pct = self.damage_health_pct / 100.0
	self.nonzeus_multiplier = self.ability:GetSpecialValueFor("nonzeus_multiplier") / 100.0
	self.shock_duration = self.ability:GetSpecialValueFor("shock_duration")
	self.radius = self.ability:GetSpecialValueFor("radius")

	self.damage_table = {
		attacker = self.parent,
		damage_type = DAMAGE_TYPE_MAGICAL,
		damage_flag = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_DAMAGE_MULTIPLIERS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		ability = self.ability,
	}

	self.zeus_abilities = {
		["zuus_arc_lightning"] = true,
		["zuus_lightning_bolt"] = true,
		["zuus_thundergods_wrath"] = true,
		["zuus_thundergods_vengeance"] = true,
	}
end


function modifier_zeus_static_field_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_SPENT_MANA
	}
end

function modifier_zeus_static_field_lua:OnSpentMana(params)
	if not IsServer() then return end

	if params.unit ~= self:GetParent() then
		return
	end

	if params.cost == nil or params.cost == 0 then
		return 
	end

	if self.parent:PassivesDisabled() then return end

	local hAbility = params.ability

	if not hAbility then return end

	if hAbility == self.ability then return end
	if hAbility:IsItem() then return end
	if hAbility:IsPassive() then return end
	if hAbility:HasBehavior(DOTA_ABILITY_BEHAVIOR_PASSIVE) 
	or hAbility:HasBehavior(DOTA_ABILITY_BEHAVIOR_TOGGLE) then return end

    --如果法力消耗过低(锯齿飞轮施法中)，不触发
    if params.cost< hAbility:GetManaCost(hAbility:GetLevel()-1)*0.2 then
       return
    end

	local bZeusAbility = self.zeus_abilities[hAbility:GetAbilityName()]

	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		self.parent:GetAbsOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
    
    for i, hEnemy in pairs(enemies) do
		if hEnemy and not hEnemy:IsNull() then
		   if not hEnemy:HasModifier("modifier_zeus_static_field_shock_lua") or bZeusAbility then
		      self:Shock(hEnemy, bZeusAbility)
		   end
		end
	end

	return 0
end


function modifier_zeus_static_field_lua:Shock(target, is_zeus_ability)
	if not is_zeus_ability and target and target:IsAlive() then
		target:AddNewModifier(self.parent, self.ability, "modifier_zeus_static_field_shock_lua", {duration = self.shock_duration})
	end
	
	self.damage_table.victim = target
	self.damage_table.damage = target:GetHealth() * self.damage_health_pct
	if not is_zeus_ability then self.damage_table.damage = self.damage_table.damage * self.nonzeus_multiplier end
	
	ApplyDamage(self.damage_table)
	target:EmitSound("Hero_Zuus.StaticField")

	local particle_cast = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_zuus/zuus_static_field.vpcf", self.parent)
	local particle = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
end