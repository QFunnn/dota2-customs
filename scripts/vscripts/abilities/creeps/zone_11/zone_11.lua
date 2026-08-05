--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_black_hole_lua_thinker", "abilities/creeps/zone_11/zone_11", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_creep_black_hole_lua_pull",
	"abilities/creeps/zone_11/zone_11",
	LUA_MODIFIER_MOTION_HORIZONTAL
)

creep_black_hole_lua = class({})

function creep_black_hole_lua:Precache(context)
	PrecacheResource("particle", "particles/econ/items/enigma/enigma_world_chasm/enigma_blackhole_ti5.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/blink_dagger_start.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/blink_dagger_end.vpcf", context)
end

function creep_black_hole_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_black_hole_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")

	local blink_start_fx =
		ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(blink_start_fx, 0, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(blink_start_fx)
	EmitSoundOn("Blink_Dagger.Start", caster)

	caster:SetAbsOrigin(point)
	FindClearSpaceForUnit(caster, point, true)

	local blink_end_fx =
		ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(blink_end_fx, 0, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(blink_end_fx)
	EmitSoundOn("Blink_Dagger.End", caster)

	caster:Stop()

	local final_point = caster:GetAbsOrigin()

	CreateModifierThinker(
		caster,
		self,
		"modifier_creep_black_hole_lua_thinker",
		{ duration = duration },
		final_point,
		caster:GetTeamNumber(),
		false
	)
end

--------------------------------------------------------------------------------

modifier_creep_black_hole_lua_thinker = class({})

function modifier_creep_black_hole_lua_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	self:GetParent():EmitSound("Hero_Enigma.Black_Hole")

	local pfx = ParticleManager:CreateParticle(
		"particles/econ/items/enigma/enigma_world_chasm/enigma_blackhole_ti5.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetOrigin())
	self:AddParticle(pfx, false, false, -1, false, false)

	self:StartIntervalThink(0.1)
end

function modifier_creep_black_hole_lua_thinker:OnIntervalThink()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster or caster:IsNull() or not caster:IsAlive() or caster:IsStunned() or caster:IsSilenced() then
		self:Destroy()
	end
end

function modifier_creep_black_hole_lua_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():StopSound("Hero_Enigma.Black_Hole")
	self:GetParent():EmitSound("Hero_Enigma.Black_Hole.Stop")
end

function modifier_creep_black_hole_lua_thinker:IsAura()
	return true
end
function modifier_creep_black_hole_lua_thinker:GetModifierAura()
	return "modifier_creep_black_hole_lua_pull"
end
function modifier_creep_black_hole_lua_thinker:GetAuraRadius()
	return self.radius
end
function modifier_creep_black_hole_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_creep_black_hole_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_creep_black_hole_lua_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

--------------------------------------------------------------------------------

modifier_creep_black_hole_lua_pull = class({})

function modifier_creep_black_hole_lua_pull:IsHidden()
	return false
end
function modifier_creep_black_hole_lua_pull:IsStunDebuff()
	return true
end

function modifier_creep_black_hole_lua_pull:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
end

function modifier_creep_black_hole_lua_pull:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_creep_black_hole_lua_pull:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_creep_black_hole_lua_pull:OnCreated()
	if not IsServer() then
		return
	end
	self.pull_speed = 60
	self:StartIntervalThink(0.03)
end

function modifier_creep_black_hole_lua_pull:OnIntervalThink()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()

	if parent:IsMagicImmune() then
		self:Destroy()
		return
	end

	local thinker = self:GetAuraOwner()
	if not thinker then
		return
	end

	local center = thinker:GetOrigin()
	local parent_pos = parent:GetOrigin()

	local direction = center - parent_pos
	local distance = direction:Length2D()
	direction = direction:Normalized()

	if distance > 20 then
		parent:SetOrigin(parent_pos + direction * self.pull_speed * 0.03)
	end

	local ability = self:GetAbility()
	local damage_base = ability:GetSpecialValueFor("damage_per_tick")
	local damage_boost = ability:GetSpecialValueFor("diff_boost_damage")
	local total_damage = (damage_base + damage_boost) * 0.03

	ApplyDamage({
		victim = parent,
		attacker = caster,
		damage = total_damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = ability,
	})
end

------------------------------------------------------------------
------------------------------------------------------------------

LinkLuaModifier("modifier_creep_sun_nova_lua_passive", "abilities/creeps/zone_11/zone_11", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_sun_nova_lua_move", "abilities/creeps/zone_11/zone_11", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_creep_sun_nova_lua_sun", "abilities/creeps/zone_11/zone_11", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_sun_nova_lua_reborn", "abilities/creeps/zone_11/zone_11", LUA_MODIFIER_MOTION_NONE)

creep_sun_nova_lua = class({})

function creep_sun_nova_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_phoenix/phoenix_icarus_dive.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf", context)
end

function creep_sun_nova_lua:GetIntrinsicModifierName()
	return "modifier_creep_sun_nova_lua_passive"
end

function creep_sun_nova_lua:TriggerDive()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local caster_height = origin.z

	local distance = self:GetSpecialValueFor("cast_range")
	if distance <= 0 then
		distance = 900
	end
	local speed = 800
	local target_point = nil

	for i = 1, 20 do
		local random_angle = RandomFloat(0, 2 * math.pi)
		local direction = Vector(math.cos(random_angle), math.sin(random_angle), 0)
		local potential_point = origin + direction * distance
		local ground_height = GetGroundHeight(potential_point, caster)

		if math.abs(ground_height - caster_height) <= 35 and GridNav:IsTraversable(potential_point) then
			target_point = potential_point
			target_point.z = ground_height
			break
		end
	end

	if not target_point then
		target_point = origin + caster:GetForwardVector() * distance
		target_point = GetGroundPosition(target_point, caster)
	end

	-- обрезаем дистанцию по пути: идём от старта к цели шагами и останавливаемся
	-- на первой непроходимой клетке или резком перепаде высот (ныряем ДО стены, не сквозь)
	do
		local dir2 = target_point - origin
		dir2.z = 0
		local total = dir2:Length2D()
		if total > 1 then
			dir2 = dir2:Normalized()
			local step = 64
			local d = step
			while d < total do
				local p = origin + dir2 * d
				local gh = GetGroundHeight(p, caster)
				if (not GridNav:IsTraversable(p)) or math.abs(gh - caster_height) > 35 then
					-- останавливаемся на шаг до препятствия
					local safe = origin + dir2 * math.max(d - step, 0)
					safe.z = GetGroundHeight(safe, caster)
					target_point = safe
					break
				end
				d = d + step
			end
		end
	end

	local direction_to_target = (target_point - origin):Normalized()
	caster:SetForwardVector(direction_to_target)
	caster:FaceTowards(target_point)

	local duration = (target_point - origin):Length2D() / speed

	self:UseResources(false, false, false, true)

	Timers:CreateTimer(0.1, function()
		if not caster:IsAlive() then
			return
		end
		caster:Stop()
		caster:AddNewModifier(caster, self, "modifier_creep_sun_nova_lua_move", {
			x = target_point.x,
			y = target_point.y,
			z = target_point.z,
			duration = duration,
		})
		caster:EmitSound("Hero_Phoenix.IcarusDive.Cast")
	end)
end

function creep_sun_nova_lua:SpawnEgg(position)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()

	local ground_location = GetGroundPosition(position, self:GetCaster())

	local egg = CreateUnitByName(
		"npc_dota_zone_11_unit_5",
		ground_location,
		false,
		self:GetCaster(),
		self:GetCaster():GetOwner(),
		self:GetCaster():GetTeamNumber()
	)

	if self:GetCaster().solo_event_player_id then
		egg.solo_event_player_id = self:GetCaster().solo_event_player_id
	end

	egg:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_creep_sun_nova_lua_sun",
		{ duration = self:GetSpecialValueFor("duration_sun") }
	)
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_creep_sun_nova_lua_reborn",
		{ duration = self:GetSpecialValueFor("duration_sun") }
	)
end

--------------------------------------------------------------------------------

modifier_creep_sun_nova_lua_passive = class({})

function modifier_creep_sun_nova_lua_passive:IsHidden()
	return true
end

function modifier_creep_sun_nova_lua_passive:IsPurgable()
	return false
end

function modifier_creep_sun_nova_lua_passive:OnCreated()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end
end

function modifier_creep_sun_nova_lua_passive:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
end

if IsServer() then
	function modifier_creep_sun_nova_lua_passive:OnTakeDamage(params)
		if params.unit ~= self:GetParent() then
			return
		end

		local parent = self:GetParent()
		local ability = self:GetAbility()

		if
			parent:IsAlive()
			and ability:IsCooldownReady()
			and parent:GetHealthPercent() <= ability:GetSpecialValueFor("hp_start")
		then
			if not parent:HasModifier("modifier_creep_sun_nova_lua_move") then
				ability:TriggerDive()
			end
		end
	end
end

--------------------------------------------------------------------------------

modifier_creep_sun_nova_lua_move = class({})

function modifier_creep_sun_nova_lua_move:IsHidden()
	return true
end
function modifier_creep_sun_nova_lua_move:IsPurgable()
	return false
end
function modifier_creep_sun_nova_lua_move:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_creep_sun_nova_lua_move:GetMotionPriority()
	return DOTA_MOTION_CONTROLLER_PRIORITY_HIGHEST
end

function modifier_creep_sun_nova_lua_move:OnCreated(kv)
	if not IsServer() then
		return
	end

	self.ability = self:GetAbility()
	self.parent = self:GetParent()

	self.start_pos = self.parent:GetAbsOrigin()
	self.target_pos = Vector(kv.x, kv.y, kv.z)

	self.speed = 800

	local diff = self.target_pos - self.start_pos
	self.total_dist = diff:Length2D()
	self.direction = diff:Normalized()

	self.right_vec = Vector(self.direction.y, -self.direction.x, 0)

	self.total_duration = self:GetDuration()
	self.elapsed_time = 0

	self.pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phoenix/phoenix_icarus_dive.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	self.parent:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_1)

	if not self:ApplyHorizontalMotionController() then
		self:Destroy()
	end
end

function modifier_creep_sun_nova_lua_move:UpdateHorizontalMotion(me, dt)
	if not IsServer() then
		return
	end
	self.elapsed_time = self.elapsed_time + dt
	local progress = math.min(self.elapsed_time / self.total_duration, 1.0)

	local forward_dist = progress * self.total_dist
	local arc_offset = math.sin(math.pi * progress) * (self.total_dist * 0.35)

	local next_pos = self.start_pos + (self.direction * forward_dist) - (self.right_vec * arc_offset)
	next_pos.z = GetGroundHeight(next_pos, me)

	me:SetOrigin(next_pos)

	local look_ahead = math.min(progress + 0.05, 1.0)
	local ahead_pos = self.start_pos
		+ (self.direction * (look_ahead * self.total_dist))
		- (self.right_vec * math.sin(math.pi * look_ahead) * (self.total_dist * 0.35))
	me:FaceTowards(ahead_pos)

	if self.pfx then
		ParticleManager:SetParticleControl(self.pfx, 1, (ahead_pos - next_pos):Normalized() * self.speed)
	end

	if progress >= 1.0 then
		self:Destroy()
	end
end

function modifier_creep_sun_nova_lua_move:OnDestroy()
	if not IsServer() then
		return
	end

	if self.parent and not self.parent:IsNull() and self.parent:IsAlive() then
		self.parent:RemoveHorizontalMotionController(self)
		FindClearSpaceForUnit(self.parent, self.parent:GetOrigin(), true)
	end

	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end

	if self.ability and not self.ability:IsNull() then
		self.ability:SpawnEgg(self.parent:GetAbsOrigin())
	end
end

function modifier_creep_sun_nova_lua_move:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end

function modifier_creep_sun_nova_lua_move:OnHorizontalMotionInterrupted()
	self:Destroy()
end

--------------------------------------------------------------------------------

modifier_creep_sun_nova_lua_reborn = class({})

function modifier_creep_sun_nova_lua_reborn:IsHidden()
	return true
end

function modifier_creep_sun_nova_lua_reborn:IsPurgable()
	return false
end

function modifier_creep_sun_nova_lua_reborn:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
	}
end

function modifier_creep_sun_nova_lua_reborn:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_CHANGE,
	}
end

function modifier_creep_sun_nova_lua_reborn:GetModifierModelChange()
	return "models/development/invisiblebox.vmdl"
end

--------------------------------------------------------------------------------

modifier_creep_sun_nova_lua_sun = class({})

function modifier_creep_sun_nova_lua_sun:IsHidden()
	return true
end
function modifier_creep_sun_nova_lua_sun:IsPurgable()
	return false
end

function modifier_creep_sun_nova_lua_sun:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACKED,
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_creep_sun_nova_lua_sun:CheckState()
	return {
		[MODIFIER_STATE_FLYING] = true,
	}
end

function modifier_creep_sun_nova_lua_sun:GetModifierIncomingDamage_Percentage()
	return -100
end

function modifier_creep_sun_nova_lua_sun:OnCreated()
	self.aura_radius = self:GetAbility():GetSpecialValueFor("aura_radius")
	self.damage_per_sec = self:GetAbility():GetSpecialValueFor("damage_per_sec")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self.max_attack = self:GetAbility():GetSpecialValueFor("max_attack")
	self.current_attack = 0

	if not IsServer() then
		return
	end
	self.death = true
	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phoenix/phoenix_supernova_egg.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
	StartSoundEvent("Hero_Phoenix.SuperNova.Begin", self:GetParent())
	StartSoundEvent("Hero_Phoenix.SuperNova.Cast", self:GetParent())
	self:StartIntervalThink(1.0)
end

function modifier_creep_sun_nova_lua_sun:OnDestroy()
	if not IsServer() then
		return
	end
	if self.death then
		StopSoundEvent("Hero_Phoenix.SuperNova.Begin", self:GetParent())
		StopSoundEvent("Hero_Phoenix.SuperNova.Cast", self:GetParent())
		StartSoundEvent("Hero_Phoenix.SuperNova.Explode", self:GetParent())
		local pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phoenix/phoenix_supernova_reborn.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetCaster()
		)
		ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
		ParticleManager:SetParticleControl(pfx, 1, Vector(1.5, 1.5, 1.5))
		ParticleManager:SetParticleControl(pfx, 3, self:GetParent():GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(pfx)

		local enemies = FindUnitsInRadius(
			self:GetCaster():GetTeamNumber(),
			self:GetParent():GetAbsOrigin(),
			self:GetParent(),
			self:GetAbility():GetSpecialValueFor("aura_radius"),
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_ANY_ORDER,
			false
		)
		for _, enemy in pairs(enemies) do
			enemy:AddNewModifier(
				self:GetCaster(),
				self:GetAbility(),
				"modifier_stunned",
				{ duration = self:GetAbility():GetSpecialValueFor("stun_duration") }
			)
		end
		self:GetCaster():RemoveModifierByName("modifier_creep_sun_nova_lua_reborn")
		self:GetCaster():SetHealth(self:GetCaster():GetMaxHealth())
		UTIL_Remove(self:GetParent())
	end
end

function modifier_creep_sun_nova_lua_sun:OnIntervalThink()
	if not IsServer() then
		return
	end
	if not self:GetParent():IsAlive() then
		return
	end

	AddFOWViewer(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetAbsOrigin(),
		self.aura_radius,
		math.min(1, self:GetRemainingTime()),
		false
	)

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		self:GetParent():GetAbsOrigin(),
		self:GetParent(),
		self:GetAbility():GetSpecialValueFor("aura_radius"),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, enemy in pairs(enemies) do
		local damageTable = {
			victim = enemy,
			attacker = self:GetCaster(),
			damage = self.damage_per_sec,
			damage_type = DAMAGE_TYPE_MAGICAL,
		}
		ApplyDamage(damageTable)
	end
end

function modifier_creep_sun_nova_lua_sun:OnAttacked(keys)
	if not IsServer() then
		return
	end
	local attacker = keys.attacker
	if keys.target ~= self:GetParent() then
		return
	end

	self.current_attack = self.current_attack + 1

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_phoenix/phoenix_supernova_hit.vpcf",
		PATTACH_POINT_FOLLOW,
		self:GetParent()
	)
	local attach_point = self:GetParent():ScriptLookupAttachment("attach_hitloc")
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAttachmentOrigin(attach_point),
		true
	)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		self:GetParent(),
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAttachmentOrigin(attach_point),
		true
	)

	if self.current_attack == self.max_attack then
		self.death = false

		StopSoundEvent("Hero_Phoenix.SuperNova.Begin", self:GetParent())
		StopSoundEvent("Hero_Phoenix.SuperNova.Cast", self:GetParent())

		-- StartSoundEventFromPosition( "Hero_Phoenix.SuperNova.Death", self:GetParent():GetAbsOrigin())
		EmitSoundOn("Hero_Phoenix.SuperNova.Death", self:GetParent())

		local pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phoenix/phoenix_supernova_death.vpcf",
			PATTACH_WORLDORIGIN,
			nil
		)
		local attach_point = self:GetCaster():ScriptLookupAttachment("attach_hitloc")
		ParticleManager:SetParticleControl(pfx, 0, self:GetCaster():GetAttachmentOrigin(attach_point))
		ParticleManager:SetParticleControl(pfx, 1, self:GetCaster():GetAttachmentOrigin(attach_point))
		ParticleManager:SetParticleControl(pfx, 3, self:GetCaster():GetAttachmentOrigin(attach_point))
		ParticleManager:ReleaseParticleIndex(pfx)

		self:GetParent():Kill(nil, attacker)
		self:GetCaster():Kill(nil, attacker)

		Timers:CreateTimer(0.03, function()
			UTIL_Remove(self:GetParent())
		end)
	else
		self:GetParent()
			:SetHealth((self:GetParent():GetMaxHealth() * ((self.max_attack - self.current_attack) / self.max_attack)))
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

creep_lighting_bolt_lua = class({})

function creep_lighting_bolt_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_lighting_bolt_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf", context)
end

function creep_lighting_bolt_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local caster_pos = caster:GetAbsOrigin()
	local forward_vec = caster:GetForwardVector()
	local right_vec = caster:GetRightVector()
	local count = self:GetSpecialValueFor("bolt_count")
	local range_step = self:GetSpecialValueFor("range_step")
	local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
	local stun = self:GetSpecialValueFor("stun_duration")
	local bolt_radius = self:GetSpecialValueFor("radius_per_bolt")

	caster:EmitSound("Hero_Zuus.LightningBolt")

	for i = 1, count do
		Timers:CreateTimer(i * 0.1, function()
			if not caster or caster:IsNull() then
				return
			end

			local distance_forward = i * range_step
			local random_side_offset = RandomFloat(-range_step, range_step)

			local target_point = caster_pos + (forward_vec * distance_forward) + (right_vec * random_side_offset)
			target_point = GetGroundPosition(target_point, caster)
			self:CreateLightningEffect(target_point, caster)

			local enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				target_point,
				nil,
				bolt_radius,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_CLOSEST,
				false
			)

			for _, enemy in ipairs(enemies) do
				ApplyDamage({
					victim = enemy,
					attacker = caster,
					damage = damage,
					damage_type = DAMAGE_TYPE_MAGICAL,
					ability = self,
				})
				enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = stun })
			end
		end)
	end
end

function creep_lighting_bolt_lua:CreateLightningEffect(target_point, caster)
	local sound_cast = "Hero_Zuus.LightningBolt"
	-- EmitSoundOnLocationWithCaster(target_point, sound_cast, caster)
	EmitSoundOn(sound_cast, caster)
	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_zuus/zuus_lightning_bolt.vpcf",
		PATTACH_WORLDORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(particle, 0, target_point)
	ParticleManager:SetParticleControl(particle, 1, target_point + Vector(0, 0, 1000))
	ParticleManager:SetParticleControl(particle, 2, target_point)
	ParticleManager:ReleaseParticleIndex(particle)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

creep_thundergods_wrath_lua = class({})

function creep_thundergods_wrath_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf", context)
end

function creep_thundergods_wrath_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_thundergods_wrath_lua:OnAbilityPhaseStart()
	self:GetCaster():EmitSound("Hero_Zuus.GodsWrath.PreCast")
	local attack_lock = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_attack1"))
	self.thundergod_spell_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_zuus/zuus_thundergods_wrath_start.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(
		self.thundergod_spell_cast,
		0,
		Vector(attack_lock.x, attack_lock.y, attack_lock.z)
	)
	ParticleManager:SetParticleControl(
		self.thundergod_spell_cast,
		1,
		Vector(attack_lock.x, attack_lock.y, attack_lock.z)
	)
	ParticleManager:SetParticleControl(
		self.thundergod_spell_cast,
		2,
		Vector(attack_lock.x, attack_lock.y, attack_lock.z)
	)
	return true
end

function creep_thundergods_wrath_lua:OnAbilityPhaseInterrupted()
	if self.thundergod_spell_cast then
		ParticleManager:DestroyParticle(self.thundergod_spell_cast, true)
		ParticleManager:ReleaseParticleIndex(self.thundergod_spell_cast)
	end
end

function creep_thundergods_wrath_lua:OnSpellStart()
	if IsServer() then
		local caster = self:GetCaster()
		local damage = self:GetSpecialValueFor("damage") + self:GetSpecialValueFor("diff_boost_damage")
		local position = self:GetCaster():GetAbsOrigin()
		local range = self:GetSpecialValueFor("radius")

		if self.thundergod_spell_cast then
			ParticleManager:ReleaseParticleIndex(self.thundergod_spell_cast)
		end
		local sound_cast = "Hero_Zuus.GodsWrath"
		-- EmitSoundOnLocationForAllies(self:GetCaster():GetAbsOrigin(), "Hero_Zuus.GodsWrath", self:GetCaster())
		EmitSoundOn(sound_cast, self:GetCaster())

		local damage_table = {}
		damage_table.attacker = self:GetCaster()
		damage_table.ability = self
		damage_table.damage_type = self:GetAbilityDamageType()
		damage_table.damage_flags = DOTA_DAMAGE_FLAG_NONE
		damage_table.damage = damage

		local hEnemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			position,
			nil,
			range,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		for _, enemy in pairs(hEnemies) do
			if enemy:IsAlive() then
				local target_point = enemy:GetAbsOrigin()
				local thundergod_strike_particle = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_zuus/zuus_thundergods_wrath.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					enemy
				)
				ParticleManager:SetParticleControl(
					thundergod_strike_particle,
					0,
					Vector(target_point.x, target_point.y, target_point.z + enemy:GetBoundingMaxs().z)
				)
				ParticleManager:SetParticleControl(
					thundergod_strike_particle,
					1,
					Vector(target_point.x, target_point.y, 2000)
				)
				ParticleManager:SetParticleControl(
					thundergod_strike_particle,
					2,
					Vector(target_point.x, target_point.y, target_point.z + enemy:GetBoundingMaxs().z)
				)
				ParticleManager:ReleaseParticleIndex(thundergod_strike_particle)

				if not enemy:IsMagicImmune() and not enemy:IsInvisible() then
					damage_table.victim = enemy
					ApplyDamage(damage_table)
				end
				enemy:EmitSound("Hero_Zuus.GodsWrath.Target")
			end
		end
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_telekines_lua", "abilities/creeps/zone_11/zone_11", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_creep_telekines_lua_stun", "abilities/creeps/zone_11/zone_11", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_telekines_lua_root", "abilities/creeps/zone_11/zone_11", LUA_MODIFIER_MOTION_NONE)

creep_telekines_lua = class({})

function creep_telekines_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_rubick/rubick_telekinesis.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_phoenix/phoenix_sunray.vpcf", context)
end

function creep_telekines_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_telekines_lua:IsHiddenWhenStolen()
	return false
end
function creep_telekines_lua:IsRefreshable()
	return true
end
function creep_telekines_lua:IsStealable()
	return true
end
function creep_telekines_lua:IsNetherWardStealable()
	return true
end

--------------------------------------------------------------------------------

function creep_telekines_lua:OnSpellStart(params)
	local caster = self:GetCaster()

	self.target = self:GetCursorTarget()
	self.target_origin = self.target:GetAbsOrigin()

	if self.target:GetName() == "npc_invoker_boss" then
		return
	end

	if self.target:TriggerSpellAbsorb(self) then
		return nil
	end

	local duration = self:GetSpecialValueFor("duration")

	self.target:AddNewModifier(
		caster,
		self,
		"modifier_creep_telekines_lua_root",
		{ duration = 3 * (1 - self.target:GetStatusResistance()) }
	)
	self.target_modifier = self.target:AddNewModifier(
		caster,
		self,
		"modifier_creep_telekines_lua",
		{ duration = 3 * (1 - self.target:GetStatusResistance()) }
	)

	self.target_modifier.tele_pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_rubick/rubick_telekinesis.vpcf",
		PATTACH_CUSTOMORIGIN,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		self.target_modifier.tele_pfx,
		0,
		self.target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.target_modifier.tele_pfx,
		1,
		self.target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.target_modifier.tele_pfx, 2, Vector(3, 0, 0))
	self.target_modifier:AddParticle(self.target_modifier.tele_pfx, false, false, 1, false, false)
	caster:EmitSound("Hero_Rubick.Telekinesis.Cast")
	self.target:EmitSound("Hero_Rubick.Telekinesis.Target")

	self.target_modifier.final_loc = self.target_origin
	self.target_modifier.changed_target = false
end

--------------------------------------------------------------------------------

modifier_creep_telekines_lua = class({})

function modifier_creep_telekines_lua:IsDebuff()
	if self:GetParent():GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
		return true
	end
	return false
end
function modifier_creep_telekines_lua:IsHidden()
	return false
end
function modifier_creep_telekines_lua:IsPurgable()
	return false
end
function modifier_creep_telekines_lua:IsPurgeException()
	return false
end
function modifier_creep_telekines_lua:IsStunDebuff()
	return false
end
function modifier_creep_telekines_lua:IgnoreTenacity()
	return true
end
function modifier_creep_telekines_lua:IsMotionController()
	return true
end
function modifier_creep_telekines_lua:GetMotionControllerPriority()
	return DOTA_MOTION_CONTROLLER_PRIORITY_MEDIUM
end

function modifier_creep_telekines_lua:OnCreated(params)
	if IsServer() then
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		self.parent = self:GetParent()
		self.z_height = 0
		self.duration = params.duration
		self.lift_animation = ability:GetSpecialValueFor("lift_animation")
		self.fall_animation = ability:GetSpecialValueFor("fall_animation")
		self.current_time = 0

		self.frametime = FrameTime()
		self:StartIntervalThink(FrameTime())

		self.pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_phoenix/phoenix_sunray.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			self.pfx,
			0,
			self:GetCaster(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetCaster():GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControlEnt(
			self.pfx,
			1,
			self:GetParent(),
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			self:GetParent():GetAbsOrigin(),
			true
		)
		StartSoundEvent("Hero_Phoenix.SunRay.Beam", caster)
	end
end

function modifier_creep_telekines_lua:OnIntervalThink()
	if IsServer() then
		self:VerticalMotion(self.parent, self.frametime)
		self:HorizontalMotion(self.parent, self.frametime)
	end
end

function SetUnitOnClearGround(self)
	Timers:CreateTimer(FrameTime(), function()
		self:SetAbsOrigin(
			Vector(self:GetAbsOrigin().x, self:GetAbsOrigin().y, GetGroundPosition(self:GetAbsOrigin(), self).z)
		)
		FindClearSpaceForUnit(self, self:GetAbsOrigin(), true)
		ResolveNPCPositions(self:GetAbsOrigin(), 64)
	end)
end

function modifier_creep_telekines_lua:EndTransition()
	if IsServer() then
		if self.transition_end_commenced then
			return nil
		end

		self.transition_end_commenced = true

		local caster = self:GetCaster()
		local parent = self:GetParent()

		SetUnitOnClearGround(parent)

		parent:RemoveModifierByName("modifier_creep_telekines_lua_stun")
		parent:RemoveModifierByName("modifier_creep_telekines_lua_root")

		local parent_pos = parent:GetAbsOrigin()

		parent:StopSound("Hero_Rubick.Telekinesis.Target")
		parent:EmitSound("Hero_Rubick.Telekinesis.Target.Land")
		ParticleManager:ReleaseParticleIndex(self.tele_pfx)

		local landing_pfx = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_rubick/rubick_telekinesis_land.vpcf",
			PATTACH_CUSTOMORIGIN,
			self:GetCaster()
		)
		ParticleManager:SetParticleControl(landing_pfx, 0, parent_pos)
		ParticleManager:SetParticleControl(landing_pfx, 1, parent_pos)
		ParticleManager:ReleaseParticleIndex(landing_pfx)

		parent:EmitSound("Hero_Rubick.Telekinesis.Target.Stun")
	end
end

function modifier_creep_telekines_lua:VerticalMotion(unit, dt)
	if IsServer() then
		self.current_time = self.current_time + dt

		local max_height = self:GetAbility():GetSpecialValueFor("max_height")
		if self.current_time <= self.lift_animation then
			self.z_height = self.z_height + ((dt / self.lift_animation) * max_height)
			unit:SetAbsOrigin(GetGroundPosition(unit:GetAbsOrigin(), unit) + Vector(0, 0, self.z_height))
		elseif self.current_time > (self.duration - self.fall_animation) then
			self.z_height = self.z_height - ((dt / self.fall_animation) * max_height)
			if self.z_height < 0 then
				self.z_height = 0
			end
			unit:SetAbsOrigin(GetGroundPosition(unit:GetAbsOrigin(), unit) + Vector(0, 0, self.z_height))
		else
			max_height = self.z_height
		end

		if self.current_time >= self.duration then
			self:EndTransition()
			self:Destroy()
		end
	end
end

function modifier_creep_telekines_lua:HorizontalMotion(unit, dt)
	if IsServer() then
		self.distance = self.distance or 0
		if self.current_time > (self.duration - self.fall_animation) then
			if self.changed_target then
				local frames_to_end = math.ceil((self.duration - self.current_time) / dt)
				self.distance = (unit:GetAbsOrigin() - self.final_loc):Length2D() / frames_to_end
				self.changed_target = false
			end
			if (self.current_time + dt) >= self.duration then
				unit:SetAbsOrigin(self.final_loc)
				self:EndTransition()
			else
				unit:SetAbsOrigin(
					unit:GetAbsOrigin() + ((self.final_loc - unit:GetAbsOrigin()):Normalized() * self.distance)
				)
			end
		end
	end
end

function modifier_creep_telekines_lua:GetTexture()
	return "rubick_telekinesis"
end

function modifier_creep_telekines_lua:OnDestroy()
	if IsServer() then
		if not self.parent:IsAlive() then
			SetUnitOnClearGround(self.parent)
		end
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end
	StopSoundEvent("Hero_Phoenix.SunRay.Beam", self:GetCaster())
end

--------------------------------------------------------------------------------

modifier_creep_telekines_lua_stun = class({})

function modifier_creep_telekines_lua_stun:IsDebuff()
	return true
end
function modifier_creep_telekines_lua_stun:IsHidden()
	return false
end
function modifier_creep_telekines_lua_stun:IsPurgable()
	return false
end
function modifier_creep_telekines_lua_stun:IsPurgeException()
	return false
end
function modifier_creep_telekines_lua_stun:IsStunDebuff()
	return true
end

function modifier_creep_telekines_lua_stun:DeclareFunctions()
	local decFuns = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
	}
	return decFuns
end

function modifier_creep_telekines_lua_stun:GetOverrideAnimation()
	return ACT_DOTA_FLAIL
end

function modifier_creep_telekines_lua_stun:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = true,
	}
	return state
end

modifier_creep_telekines_lua_root = class({})
function modifier_creep_telekines_lua_root:IsDebuff()
	return false
end
function modifier_creep_telekines_lua_root:IsHidden()
	return true
end
function modifier_creep_telekines_lua_root:IsPurgable()
	return false
end
function modifier_creep_telekines_lua_root:IsPurgeException()
	return false
end
function modifier_creep_telekines_lua_root:OnCreated()
	self:StartIntervalThink(0.2)
end

function modifier_creep_telekines_lua_root:OnIntervalThink()
	if IsServer() then
		ApplyDamage({
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = (self:GetAbility():GetSpecialValueFor("damage") + self:GetAbility()
				:GetSpecialValueFor("diff_boost_damage")) / 5,
			damage_type = DAMAGE_TYPE_PURE,
			damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		})
	end
end

function modifier_creep_telekines_lua_root:CheckState()
	local state = {
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
	return state
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_thunder_strike_lua", "abilities/creeps/zone_11/zone_11", LUA_MODIFIER_MOTION_NONE)

creep_thunder_strike_lua = class({})

function creep_thunder_strike_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf", context)
end

function creep_thunder_strike_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_thunder_strike_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if target:TriggerSpellAbsorb(self) then
		return
	end

	local duration = self:GetSpecialValueFor("duration")
	target:AddNewModifier(caster, self, "modifier_creep_thunder_strike_lua", { duration = duration })

	target:EmitSound("Hero_Disruptor.ThunderStrike.Target")
end

--------------------------------------------------------------------------------

modifier_creep_thunder_strike_lua = class({})

function modifier_creep_thunder_strike_lua:IsHidden()
	return false
end
function modifier_creep_thunder_strike_lua:IsDebuff()
	return true
end
function modifier_creep_thunder_strike_lua:IsPurgable()
	return true
end
function modifier_creep_thunder_strike_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_creep_thunder_strike_lua:OnCreated()
	if not IsServer() then
		return
	end

	local ability = self:GetAbility()
	self.radius = ability:GetSpecialValueFor("radius")
	self.strike_damage = ability:GetSpecialValueFor("damage") + ability:GetSpecialValueFor("diff_boost_damage")
	self.strike_interval = ability:GetSpecialValueFor("strike_interval")

	self:StartIntervalThink(self.strike_interval)
	self:OnIntervalThink()
end

function modifier_creep_thunder_strike_lua:OnIntervalThink()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local caster = self:GetCaster()

	self.strike_particle_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_disruptor/disruptor_thunder_strike_bolt.vpcf",
		PATTACH_ABSORIGIN,
		parent
	)
	ParticleManager:SetParticleControl(self.strike_particle_fx, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.strike_particle_fx, 1, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.strike_particle_fx, 2, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(self.strike_particle_fx)

	self.aoe_particle_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_disruptor/disruptor_thunder_strike_aoe.vpcf",
		PATTACH_ABSORIGIN,
		parent
	)
	ParticleManager:SetParticleControl(self.aoe_particle_fx, 0, parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(self.aoe_particle_fx)

	parent:EmitSound("Hero_Disruptor.ThunderStrike.Damage")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		parent:GetOrigin(),
		parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)

	local damageTable = {
		attacker = caster,
		damage = self.strike_damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	}

	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
	end

	AddFOWViewer(caster:GetTeamNumber(), parent:GetOrigin(), self.radius, 1.0, false)
end

function modifier_creep_thunder_strike_lua:CheckState()
	return {
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_creep_glimpse_to_caster_lua",
	"abilities/creeps/zone_11/zone_11",
	LUA_MODIFIER_MOTION_HORIZONTAL
)

creep_glimpse_to_caster_lua = class({})

function creep_glimpse_to_caster_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_glimpse_travel.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_glimpse_targetend.vpcf", context)
end

function creep_glimpse_to_caster_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	if not target or target:TriggerSpellAbsorb(self) then
		return
	end

	local vTargetLocation = target:GetOrigin()
	local vCastLocation = caster:GetOrigin()

	target:EmitSound("Hero_Disruptor.Glimpse.Target")
	caster:EmitSound("Hero_Disruptor.Glimpse.Cast")

	local vVelocity = (vCastLocation - vTargetLocation)
	vVelocity.z = 0.0
	local flDist = vVelocity:Length2D()
	local flDuration = math.max(0.05, math.min(1.7, flDist / 600))

	local nFXIndex = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_disruptor/disruptor_glimpse_travel.vpcf",
		PATTACH_CUSTOMORIGIN,
		nil
	)
	ParticleManager:SetParticleControlEnt(nFXIndex, 0, target, PATTACH_ABSORIGIN_FOLLOW, nil, target:GetOrigin(), true)
	ParticleManager:SetParticleControl(nFXIndex, 1, vCastLocation)
	ParticleManager:SetParticleControl(nFXIndex, 2, Vector(flDuration, flDuration, flDuration))
	ParticleManager:ReleaseParticleIndex(nFXIndex)

	local nFXIndex2 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_disruptor/disruptor_glimpse_targetend.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(nFXIndex2, 0, vCastLocation)
	ParticleManager:SetParticleControl(nFXIndex2, 1, vCastLocation)
	ParticleManager:SetParticleControl(nFXIndex2, 2, Vector(flDuration, flDuration, flDuration))
	ParticleManager:ReleaseParticleIndex(nFXIndex2)

	Timers:CreateTimer(flDuration, function()
		if target and target:IsAlive() and not target:IsMagicImmune() then
			target:EmitSound("Hero_Disruptor.Glimpse.End")

			target:SetAbsOrigin(vCastLocation)
			FindClearSpaceForUnit(target, vCastLocation, true)
		end
	end)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_static_storm_lua_thinker", "abilities/creeps/zone_11/zone_11", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_static_storm_lua_debuff", "abilities/creeps/zone_11/zone_11", LUA_MODIFIER_MOTION_NONE)

creep_static_storm_lua = class({})

function creep_static_storm_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_disruptor/disruptor_static_storm.vpcf", context)
end

function creep_static_storm_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_static_storm_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		caster,
		self,
		"modifier_creep_static_storm_lua_thinker",
		{ duration = duration },
		point,
		caster:GetTeamNumber(),
		false
	)
end

--------------------------------------------------------------------------------

modifier_creep_static_storm_lua_thinker = class({})

function modifier_creep_static_storm_lua_thinker:OnCreated()
	if not IsServer() then
		return
	end

	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.duration = self:GetDuration()

	self:GetParent():EmitSound("Hero_Disruptor.StaticStorm.Cast")
	self:GetParent():EmitSound("Hero_Disruptor.StaticStorm")

	local pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_disruptor/disruptor_static_storm.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(pfx, 1, Vector(self.radius, 0, 0))
	ParticleManager:SetParticleControl(pfx, 2, Vector(self.duration, 0, 0))
	self:AddParticle(pfx, false, false, -1, false, false)
end

function modifier_creep_static_storm_lua_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	self:GetParent():StopSound("Hero_Disruptor.StaticStorm")
	self:GetParent():EmitSound("Hero_Disruptor.StaticStorm.End")
end

function modifier_creep_static_storm_lua_thinker:IsAura()
	return true
end
function modifier_creep_static_storm_lua_thinker:GetModifierAura()
	return "modifier_creep_static_storm_lua_debuff"
end
function modifier_creep_static_storm_lua_thinker:GetAuraRadius()
	return self.radius
end
function modifier_creep_static_storm_lua_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function modifier_creep_static_storm_lua_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_creep_static_storm_lua_thinker:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end

--------------------------------------------------------------------------------

modifier_creep_static_storm_lua_debuff = class({})

function modifier_creep_static_storm_lua_debuff:IsHidden()
	return false
end
function modifier_creep_static_storm_lua_debuff:IsPurgable()
	return false
end

function modifier_creep_static_storm_lua_debuff:CheckState()
	return { [MODIFIER_STATE_SILENCED] = true }
end

function modifier_creep_static_storm_lua_debuff:OnCreated()
	if not IsServer() then
		return
	end
	self.interval = 0.25

	local ability = self:GetAbility()
	self.max_damage = ability:GetSpecialValueFor("damage_max") + ability:GetSpecialValueFor("diff_boost_damage")
	self:StartIntervalThink(self.interval)
end

function modifier_creep_static_storm_lua_debuff:OnIntervalThink()
	if not IsServer() then
		return
	end

	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.max_damage * self.interval,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self:GetAbility(),
	})
end