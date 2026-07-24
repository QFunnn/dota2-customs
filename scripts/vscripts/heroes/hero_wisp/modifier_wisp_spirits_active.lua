--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wisp_spirits_active = class({})

function modifier_wisp_spirits_active:RemoveOnDeath() return true end
function modifier_wisp_spirits_active:IsPurgable() return false end

function modifier_wisp_spirits_active:OnCreated()
	if not IsServer() then return end

	--幻象无效
    if self:GetParent():IsIllusion() then
       return
    end

	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self:SetVariables()
	--[[
		(360 / revolution_time / 30) * 3.14 / 180
	]]
	self.current_range = self.max_range
	self.revolution_step = ((360 / self.revolution_time) / 30) * 0.0174  -- in radians
	self.range_step = self.spirit_movement_rate / 30
	self.active_spirits = {}
	self.summoned_spirits_count = 0

	self.spawn_delay = self.revolution_time / self.spirits_count

	Timers:CreateTimer("wisp_spirits_control_" .. self.parent:GetEntityIndex(), {
		callback = function()
			return self:AddSpirit()
		end
	})

	self:StartIntervalThink(1/30)

	self.parent:EmitSound("Hero_Wisp.Spirits.Loop")
end


function modifier_wisp_spirits_active:OnRefresh()
	if not IsServer() then return end

	--幻象无效
    if self:GetParent():IsIllusion() then
       return
    end
    
	self:SetVariables()
end


function modifier_wisp_spirits_active:SetVariables()
	self.spirits_count = self.ability:GetSpecialValueFor("spirits_count")
	self.revolution_time = self.ability:GetSpecialValueFor("revolution_time")
	self.creep_damage = self.ability:GetSpecialValueFor("creep_damage")
	self.hero_damage = self.ability:GetSpecialValueFor("hero_damage")
	self.min_range = self.ability:GetSpecialValueFor("min_range")
	self.max_range = self.ability:GetSpecialValueFor("max_range")
	self.explode_radius = self.ability:GetSpecialValueFor("explode_radius")
	self.hit_radius = self.ability:GetSpecialValueFor("hit_radius")
	self.spirit_movement_rate = self.ability:GetSpecialValueFor("spirit_movement_rate")

	
	local hero_damage_talent = self.parent:FindAbilityByName("special_bonus_unique_wisp")
	if hero_damage_talent and hero_damage_talent:GetLevel() ~= 0 then
		self.hero_damage = self.hero_damage + hero_damage_talent:GetSpecialValueFor("value")
	end
	
	local max_range_talent = self.parent:FindAbilityByName("special_bonus_unique_wisp_3")
	if max_range_talent and max_range_talent:GetLevel() ~= 0 then
		self.max_range = self.max_range + max_range_talent:GetSpecialValueFor("value")
	end
	
	self.damage_table_creep = {
		damage = self.creep_damage,
		attacker = self.parent,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability,
	}

	self.damage_table_hero = {
		damage = self.hero_damage,
		attacker = self.parent,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability,
	}
end

function modifier_wisp_spirits_active:AddSpirit()
	local starting_vec = Vector(self.current_range, 0, 0)

	if self.summoned_spirits_count >= self.spirits_count then 
		-- "ressurect" disabled spirits with scepter
		if IsValid(self.parent) and self.parent:HasScepter() then
			local inactive_spirit = self:GetInactiveSpiritIndex()
			if inactive_spirit then
				metadata = self.active_spirits[inactive_spirit]
				metadata.active = true
				metadata.particle = self:GetSpiritParticle(starting_vec)
				self:ProcessSpiritMovement(inactive_spirit, metadata, self.parent:GetAbsOrigin())
			end
		end
		return self.spawn_delay
	end
	self.active_spirits[self.summoned_spirits_count] = {
		particle = self:GetSpiritParticle(starting_vec),
		last_pos = starting_vec,
		angle = 0,
		active = true
	}
	self.summoned_spirits_count = self.summoned_spirits_count + 1

	return self.spawn_delay
end


function modifier_wisp_spirits_active:DestroySpirit(index, final)
	local spirit = self.active_spirits[index]
	if not spirit then return end
	if not spirit.active then return false end

	spirit.active = false

	ParticleManager:DestroyParticle(spirit.particle, false)
	ParticleManager:ReleaseParticleIndex(spirit.particle)
	spirit.particle = nil

	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		spirit.last_pos,
		nil,
		self.explode_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		self.damage_table_hero.victim = enemy
		ApplyDamage(self.damage_table_hero)
	end

	if not self.parent:HasScepter() and not final then
		local active_spirit = self:GetActiveSpiritIndex()
		if not active_spirit then
			self:Destroy()
		end
	end

	local explosion = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_guardian_explosion.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(explosion, 0, spirit.last_pos)
	ParticleManager:ReleaseParticleIndex(explosion)

	EmitSoundOnLocationWithCaster(spirit.last_pos, "Hero_Wisp.Spirits.Target", self.parent)
end


function modifier_wisp_spirits_active:GetInactiveSpiritIndex()
	for index, metadata in pairs(self.active_spirits) do
		if not metadata.active then return index end
	end
	return nil
end


function modifier_wisp_spirits_active:GetActiveSpiritIndex()
	for index, metadata in pairs(self.active_spirits) do
		if metadata.active then return index end
	end
	return nil
end

function modifier_wisp_spirits_active:OnIntervalThink()
	if not self.ability or self.ability:IsNull() then self:Destroy() return end
	if not self.parent or self.parent:IsNull() then self:Destroy() return end

	local parent_origin = self.parent:GetAbsOrigin()

	if self.control_ability:GetToggleState() then
		if self.current_range > self.min_range then
			self.current_range = self.current_range - self.range_step
			if self.current_range < self.min_range then self.current_range = self.min_range end
		end
	else
		if self.current_range < self.max_range then
			self.current_range = self.current_range + self.range_step
			if self.current_range > self.max_range then self.current_range = self.max_range end
		end
	end

	for index, metadata in pairs(self.active_spirits) do
		-- rotating inactive spirits so when resummoned by scepter they still go in the right place
		metadata.angle = metadata.angle + self.revolution_step

		if metadata.active then
			self:ProcessSpiritMovement(index, metadata, parent_origin)
		end
	end
end


function modifier_wisp_spirits_active:ProcessSpiritMovement(index, metadata, parent_origin)
	local angle_sin = math.sin(metadata.angle)
	local angle_cos = math.cos(metadata.angle)

	local spirit_coord = Vector(
		parent_origin.x + self.current_range * angle_sin,
		parent_origin.y + self.current_range * angle_cos,
		0
	)
	spirit_coord.z = GetGroundHeight(spirit_coord, self.parent) + 32
	metadata.last_pos = spirit_coord
	ParticleManager:SetParticleControl(metadata.particle, 0, spirit_coord)

	
	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(),
		spirit_coord,
		nil,
		self.hit_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		if enemy:IsHero() then
			self:DestroySpirit(index)
		elseif not enemy:HasModifier("modifier_wisp_spirits_creep") then
			self.damage_table_creep.victim = enemy
			ApplyDamage(self.damage_table_creep)
			local explosion = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_guardian_explosion_small.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
			ParticleManager:SetParticleControl(explosion, 0, enemy:GetAbsOrigin())
			ParticleManager:ReleaseParticleIndex(explosion)
			-- block damage till next sprit comes (approximately)
			enemy:AddNewModifier(self.parent, self.ability, "modifier_wisp_spirits_creep", {
				duration = self.revolution_time / self.spirits_count
			})
			enemy:EmitSound("Hero_Wisp.Spirits.TargetCreep")
		end
	end
end


function modifier_wisp_spirits_active:OnRemoved()
	if not IsServer() then return end
	
	if self.active_spirits then
	  for index, metadata in pairs(self.active_spirits) do
		self:DestroySpirit(index, true)
	  end
	end

	if not self.control_ability:IsNull() and self.control_ability:GetToggleState() then
		self.control_ability:ToggleAbility()
	end
   
   if self.parent then 
	   if self.ability and not self.ability:IsNull() then
			self.parent:SwapAbilities(
				self.ability:GetAbilityName(),
				"wisp_spirits_in_lua",
				true,
				false
			)
	    end

		Timers:RemoveTimer("wisp_spirits_control_" .. self.parent:GetEntityIndex())

		self.parent:StopSound("Hero_Wisp.Spirits.Loop")
		self.parent:EmitSound("Hero_Wisp.Spirits.Destroy")
	end
	
end

function modifier_wisp_spirits_active:GetSpiritParticle(position)
	local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_wisp/wisp_guardian.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, position)
	return particle
end


modifier_wisp_spirits_creep = class({})

function modifier_wisp_spirits_creep:IsHidden() return true end
function modifier_wisp_spirits_creep:IsPurgable() return false end