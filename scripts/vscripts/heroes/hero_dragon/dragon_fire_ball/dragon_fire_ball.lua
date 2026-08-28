--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_dragon_fire_ball_lua_thinker",
	"heroes/hero_dragon/dragon_fire_ball/dragon_fire_ball",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_dragon_fire_ball_lua_slow",
	"heroes/hero_dragon/dragon_fire_ball/dragon_fire_ball",
	LUA_MODIFIER_MOTION_NONE
)

dragon_fire_ball_lua = class({})

function dragon_fire_ball_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_macropyre.vpcf", context)
end

function dragon_fire_ball_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		caster, -- player source
		self, -- ability source
		"modifier_dragon_fire_ball_lua_thinker", -- modifier name
		{ duration = duration }, -- kv
		point,
		caster:GetTeamNumber(),
		false
	)
end

------------------------------------------------------------------\

modifier_dragon_fire_ball_lua_thinker = class({})

function modifier_dragon_fire_ball_lua_thinker:IsHidden()
	return true
end

function modifier_dragon_fire_ball_lua_thinker:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.burn_interval = self:GetAbility():GetSpecialValueFor("burn_interval")

	local talent = self:GetCaster():FindAbilityByName("special_bonus_dragon_knight_6")
	if talent and talent:GetLevel() > 0 then
		self.damage = self.damage + 60
	end

	if IsServer() then
		GridNav:DestroyTreesAroundPoint(self:GetParent():GetOrigin(), self.radius, true)

		self.damageTable = {
			attacker = self:GetCaster(),
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(), --Optional.
		}

		self:StartIntervalThink(self.burn_interval)
		self:PlayEffects()
	end
end

function modifier_dragon_fire_ball_lua_thinker:OnDestroy()
	if IsServer() then
		UTIL_Remove(self:GetParent())
	end
end

function modifier_dragon_fire_ball_lua_thinker:OnIntervalThink()
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(), -- int, your team number
		self:GetParent():GetOrigin(), -- point, center point
		self:GetParent(), -- handle, cacheUnit. (not known)
		self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)
	for _, enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		self.damageTable.damage = self.damage / 2
		ApplyDamage(self.damageTable)

		local talent = self:GetCaster():FindAbilityByName("special_bonus_dragon_knight_4")
		if talent and talent:GetLevel() > 0 then
			enemy:AddNewModifier(
				self:GetCaster(), -- player source
				self:GetAbility(), -- ability source
				"modifier_dragon_fire_ball_lua_slow", -- modifier name
				{ duration = 1 } -- kv
			)
		end
	end
end

function modifier_dragon_fire_ball_lua_thinker:PlayEffects()
	self.pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_jakiro/jakiro_macropyre.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(self.pfx, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(
		self.pfx,
		1,
		self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector()
	)
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(self:GetDuration(), 0, 0))
	self:AddParticle(self.pfx, false, false, -1, false, false)
	EmitSoundOn("hero_jakiro.macropyre", self:GetParent())
end

------------------------------------------------------------------------------

modifier_dragon_fire_ball_lua_slow = class({})

function modifier_dragon_fire_ball_lua_slow:IsHidden()
	return false
end

function modifier_dragon_fire_ball_lua_slow:IsDebuff()
	return false
end

function modifier_dragon_fire_ball_lua_slow:IsPurgable()
	return true
end

function modifier_dragon_fire_ball_lua_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_dragon_fire_ball_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return -15
end