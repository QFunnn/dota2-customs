--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@class modifier_undying_tombstone_lua:CDOTA_Modifier_Lua
modifier_undying_tombstone_lua = class({})

function modifier_undying_tombstone_lua:IsHidden() return true end
function modifier_undying_tombstone_lua:IsPurgable() return false end


function modifier_undying_tombstone_lua:CheckState()
	return {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_undying_tombstone_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_AVOID_DAMAGE,
		MODIFIER_PROPERTY_HEALTHBAR_PIPS, -- GetModifierHealthBarPips
	}
end


function modifier_undying_tombstone_lua:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()

	if not IsServer() then return end

	self.radius 	= self.ability:GetSpecialValueFor("radius")
	self.interval 	= self.ability:GetSpecialValueFor("zombie_interval")

	self:StartIntervalThink(self.interval)

	--First attack immediately after spawn
	Timers:CreateTimer(0.01, function()
		self:OnIntervalThink()
	end)
end

function modifier_undying_tombstone_lua:OnDestroy()
	if IsClient() then return end

	for _, zombie in pairs(self.ability.zombies) do
		if IsValidEntity(zombie) and zombie:IsAlive() then
			local modifier = zombie:FindModifierByName("modifier_undying_tombstone_zombie")
			modifier:RemoveStacks(self.parent)
		end
	end
end

function modifier_undying_tombstone_lua:OnIntervalThink()
	if not self.ability then return end -- https://discord.com/channels/501306949434867713/997015568492281956/997015687501467738

	local targets = FindUnitsInRadius(self.parent:GetTeam(),
		self.parent:GetAbsOrigin(),
		nil,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
		FIND_ANY_ORDER,
		false)

	for _, target in pairs(targets) do
		self.ability:SpawnOrUpgradeZombie(target, self.parent)
	end

	local particle = ParticleManager:CreateParticle("particles/econ/items/undying/undying_pale_augur/undying_pale_augur_decay_smoke_swirl.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector( self.radius, 0, 0 ))
	ParticleManager:ReleaseParticleIndex(particle)

	self.parent:EmitSound("Tombstone.RaiseDead")
end

function modifier_undying_tombstone_lua:GetModifierAvoidDamage(params)
	local parent = self:GetParent()
	local health = parent:GetHealth()

	if params.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then
		return 1
	end

	local damage = params.attacker:IsRealHero() and 4 or 1

	if health > damage then
		parent:SetHealth(health - damage)
	else
		parent:Kill(nil, params.attacker)
	end

	return 1
end


function modifier_undying_tombstone_lua:GetModifierHealthBarPips()
	return math.ceil(self.parent:GetMaxHealth() / 4)
end