--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


muerta_gunslinger_lua = class({})
LinkLuaModifier(
	"modifier_muerta_gunslinger_lua",
	"heroes/hero_muerta/muerta_gunslinger_lua/muerta_gunslinger_lua",
	LUA_MODIFIER_MOTION_NONE
)

function muerta_gunslinger_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_muerta/muerta_ultimate_projectile.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_muerta/muerta_ultimate_projectile_alternate.vpcf",
		context
	)
	PrecacheResource("particle", "particles/units/heroes/hero_muerta/muerta_gunslinger.vpcf", context)
end

function muerta_gunslinger_lua:GetIntrinsicModifierName()
	return "modifier_muerta_gunslinger_lua"
end

function muerta_gunslinger_lua:OnUpgrade()
	self.OnUpgrade = function() end

	if not IsServer() then
		return
	end

	self:ToggleAutoCast()
end

-------------------------------------------------------------

modifier_muerta_gunslinger_lua = class({})

function modifier_muerta_gunslinger_lua:IsHidden()
	return true
end

function modifier_muerta_gunslinger_lua:OnCreated(kv)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.chance = self:GetAbility():GetSpecialValueFor("double_shot_chance")
	self.bonus_range = self:GetAbility():GetSpecialValueFor("target_search_bonus_range")

	if not IsServer() then
		return
	end

	self.main_target = nil
	self.proc_target = nil
	self.double_shot = false
end

function modifier_muerta_gunslinger_lua:OnRefresh(kv)
	self.chance = self:GetAbility():GetSpecialValueFor("double_shot_chance")
	self.bonus_range = self:GetAbility():GetSpecialValueFor("target_search_bonus_range")
end

function modifier_muerta_gunslinger_lua:OnRemoved() end

function modifier_muerta_gunslinger_lua:OnDestroy() end

function modifier_muerta_gunslinger_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
	}
	return funcs
end

function modifier_muerta_gunslinger_lua:OnAttackStart(params)
	if params.attacker ~= self.parent then
		return
	end

	if params.target:GetTeamNumber() == params.attacker:GetTeamNumber() then
		return
	end

	if self.parent:PassivesDisabled() then
		return
	end

	local ability = self:GetAbility()
	if not ability:GetAutoCastState() then
		return
	end

	if not RollPseudoRandomPercentage(self.chance, DOTA_PSEUDO_RANDOM_MUERTA_GUNSLINGER, self.parent) then
		return
	end

	self.main_target = params.target
	self.proc_target = params.target

	local enemies = FindUnitsInRadius(
		self.parent:GetTeamNumber(), -- int, your team number
		self.parent:GetOrigin(), -- point, center point
		self.parent, -- handle, cacheUnit. (not known)
		self.parent:Script_GetAttackRange() + self.bonus_range, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_COURIER, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	for _, enemy in pairs(enemies) do
		if enemy ~= self.main_target then
			self.proc_target = enemy
			break
		end
	end

	self:PlayEffects()
end

function modifier_muerta_gunslinger_lua:OnAttack(params)
	if params.attacker ~= self.parent then
		return
	end
	if params.target ~= self.main_target then
		return
	end

	if params.no_attack_cooldown then
		return
	end

	local target = self.proc_target
	self.proc_target = nil
	self.main_target = nil
	self.double_shot = true
	self.parent:PerformAttack(target, true, true, true, false, true, false, false)
	self.double_shot = false

	EmitSoundOn("Hero_Muerta.Attack.DoubleShot", self.parent)
end

function modifier_muerta_gunslinger_lua:GetModifierProjectileName()
	if not IsServer() then
		return
	end

	if not self.parent:HasModifier("modifier_muerta_pierce_the_veil_lua") then
		return
	end
	if not self.double_shot then
		return "particles/units/heroes/hero_muerta/muerta_ultimate_projectile.vpcf"
	else
		return "particles/units/heroes/hero_muerta/muerta_ultimate_projectile_alternate.vpcf"
	end
end

function modifier_muerta_gunslinger_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_muerta/muerta_gunslinger.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end