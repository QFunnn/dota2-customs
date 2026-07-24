--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Created by Elfansoer
--[[Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
storm_spirit_ball_lightning_lua = class({})
LinkLuaModifier("modifier_storm_spirit_ball_lightning_lua", "heroes/hero_storm_spirit/storm_spirit_ball_lightning_lua", LUA_MODIFIER_MOTION_HORIZONTAL)

--------------------------------------------------------------------------------
-- Init Abilities
function storm_spirit_ball_lightning_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_stormspirit.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_stormspirit/stormspirit_ball_lightning.vpcf", context)
end

--------------------------------------------------------------------------------
-- Custom KV
function storm_spirit_ball_lightning_lua:GetManaCost(level)
	local hCaster = self:GetCaster()
	-- references
	local flat = self:GetSpecialValueFor("ball_lightning_initial_mana_base")
	local pct = self:GetSpecialValueFor("ball_lightning_initial_mana_percentage")

	-- get data
	local mana = hCaster:GetMaxMana()

	if hCaster:HasModifier("modifier_storm_spirit_ball_lightning_lua") then
		flat = self:GetSpecialValueFor("ball_lightning_travel_cost_base")
		pct = self:GetSpecialValueFor("ball_lightning_travel_cost_percent")
	end

	return flat + mana * pct * 0.01
end

--------------------------------------------------------------------------------
-- Ability Start
function storm_spirit_ball_lightning_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	-- check if already in ball
	if caster:HasModifier("modifier_storm_spirit_ball_lightning_lua") then
		self:RefundManaCost()
		return
	end

	if Util:IsEscaping(caster, point) then
		-- local suppose_pos = Util:GetRoomCenter(Util:GetSupposeRoom(hParent))
		local dir = (caster:GetAbsOrigin() - point):Normalized()
		local new_pos = dir + point
		for i = 1, (point - caster:GetAbsOrigin()):Length2D(), 1 do
			new_pos = dir * i + point
			if not Util:IsEscaping(caster, new_pos) then
				point = new_pos
				break
			end
		end
	end

	-- caster:SetAbsOrigin(point)


	--add modifier
	caster:AddNewModifier(
	caster, -- player source
	self, -- ability source
	"modifier_storm_spirit_ball_lightning_lua", -- modifier name
	{
		x = point.x,
		y = point.y,
		duration = (point - caster:GetAbsOrigin()):Length2D() / self:GetSpecialValueFor("ball_lightning_move_speed")
	} -- kv
	)

end

-- Created by Elfansoer
--[[Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
modifier_storm_spirit_ball_lightning_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_storm_spirit_ball_lightning_lua:IsHidden()
	return true
end

function modifier_storm_spirit_ball_lightning_lua:IsDebuff()
	return false
end

function modifier_storm_spirit_ball_lightning_lua:IsStunDebuff()
	return false
end

function modifier_storm_spirit_ball_lightning_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_storm_spirit_ball_lightning_lua:OnCreated(kv)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.team = self.parent:GetTeamNumber()

	-- references
	self.mana_flat = self:GetAbility():GetSpecialValueFor("ball_lightning_travel_cost_base")
	self.mana_pct = self:GetAbility():GetSpecialValueFor("ball_lightning_travel_cost_percent")
	self.radius = self:GetAbility():GetSpecialValueFor("ball_lightning_aoe")
	self.vision = self:GetAbility():GetSpecialValueFor("ball_lightning_vision_radius")
	self.speed = self:GetAbility():GetSpecialValueFor("ball_lightning_move_speed")
	self.talent_remnant_interval = self:GetAbility():GetSpecialValueFor("talent_remnant_interval")

	if not IsServer() then return end
	-- ability properties
	self.damage = self:GetAbility():GetAbilityDamage()
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()

	-- get data
	self.center = Vector(kv.x, kv.y, 0)
	self.origin = self:GetParent():GetOrigin()

	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self.parent,
		-- damage = 500,
		damage_type = self.abilityDamageType,
		ability = self.ability, --Optional.
	}
	-- ApplyDamage(damageTable)

	-- init
	self.travel_total = 0
	self.tree = 100
	self.tick = 100
	self.enemies = {}
	self.talent_travel = 0

	-- apply motion
	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
		return
	end

	-- play effects
	self:PlayEffects()
end

function modifier_storm_spirit_ball_lightning_lua:OnRefresh(kv)

end

function modifier_storm_spirit_ball_lightning_lua:OnRemoved()
end

function modifier_storm_spirit_ball_lightning_lua:OnDestroy()
	local hParent = self:GetParent()
	if not IsServer() then return end
	if IsValid(hParent) then
		hParent:RemoveHorizontalMotionController(self)
		local sound_loop = "Hero_StormSpirit.BallLightning.Loop"
		StopSoundOn(sound_loop, hParent)
		if hParent:IsIllusion() then
			hParent:ForceKill(false)
		end
	end
end
function modifier_storm_spirit_ball_lightning_lua:GetMotionPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_storm_spirit_ball_lightning_lua:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
	}

	return state
end
function modifier_storm_spirit_ball_lightning_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
end
function modifier_storm_spirit_ball_lightning_lua:GetOverrideAnimation()
	return ACT_DOTA_CAST4_STATUE
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_storm_spirit_ball_lightning_lua:UpdateHorizontalMotion(me, dt)
	-- movement
	local origin = me:GetOrigin()
	local direction = self.center - origin
	local distance = direction:Length2D()
	direction.z = 0
	direction = direction:Normalized()

	local target = origin + direction * self.speed * dt
	me:SetOrigin(target)

	if self.talent_remnant_interval > 0 then
		self.talent_travel = self.talent_travel + self.speed * dt
		if self.talent_travel >= self.talent_remnant_interval then
			self.talent_travel = 0
			local remnant = me:FindAbilityByName("storm_spirit_static_remnant")
			if remnant ~= nil then
				-- remnant:OnSpellStart()
				print(remnant.OnSpellStart == nil)
				me:SetCursorCastTarget(me)
				me:SetCursorPosition(me:GetAbsOrigin())
				remnant:OnSpellStart()
			end
		end
	end

	-- damage
	local enemies = FindUnitsInRadius(
	self.team, -- int, your team number
	origin, -- point, center point
	nil, -- handle, cacheUnit. (not known)
	self.radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
	DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
	DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
	0, -- int, flag filter
	0, -- int, order filter
	false	-- bool, can grow cache
	)
	for _, enemy in pairs(enemies) do
		if not self.enemies[enemy] then
			-- only hit a unit once
			self.enemies[enemy] = true

			-- damage
			self.damageTable.victim = enemy
			self.damageTable.damage = self.travel_total / self.tick * self.damage
			ApplyDamage(self.damageTable)
		end
	end

	-- destroy trees
	GridNav:DestroyTreesAroundPoint(me:GetOrigin(), self.tree, false)

	-- view
	AddFOWViewer(self.team, origin, self.vision, 0.1, false)

	-- play effects
	ParticleManager:SetParticleControl(self.effect_cast, 1, origin)

	-- reached distance
	if distance < 200 then
		self:Destroy()
		return
	end

	-- check mana and damage for every self.tick units
	local travel = (self.origin - me:GetOrigin()):Length2D()
	if travel - self.travel_total < self.tick then return end
	self.travel_total = self.travel_total + self.tick

	-- check mana
	local mana = self:GetParent():GetMana()
	local maxmana = self:GetParent():GetMaxMana()
	local manacost = self.mana_flat + maxmana * 0.01

	if manacost > mana then
		self:Destroy()
		return
	end

	-- spend mana
	if self:GetAbility() and self:GetAbility().UseResources then
		self:GetAbility():UseResources(true, false, false, false)
	end
	-- me:SpendMana(manacost, hAbility)
end

function modifier_storm_spirit_ball_lightning_lua:OnHorizontalMotionInterrupted()
	self:Destroy()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_storm_spirit_ball_lightning_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_stormspirit/stormspirit_bal	l_lightning.vpcf"
	local sound_cast = "Hero_StormSpirit.BallLightning"
	local sound_loop = "Hero_StormSpirit.BallLightning.Loop"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControlEnt(
	effect_cast,
	0,
	self.parent,
	PATTACH_POINT_FOLLOW,
	"attach_hitloc",
	self.parent:GetOrigin(), -- unknown
	true -- unknown, true
	)
	ParticleManager:SetParticleControl(effect_cast, 1, self.parent:GetOrigin())
	-- ParticleManager:ReleaseParticleIndex( effect_cast )

	-- buff particle
	self:AddParticle(
	effect_cast,
	false, -- bDestroyImmediately
	false, -- bStatusEffect
	-1, -- iPriority
	false, -- bHeroEffect
	false -- bOverheadEffect
	)

	self.effect_cast = effect_cast

	-- Create Sound
	EmitSoundOn(sound_cast, self.parent)
	EmitSoundOn(sound_loop, self.parent)
end