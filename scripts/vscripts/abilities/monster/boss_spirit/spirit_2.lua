--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__ArrayEvery = ____lualib.__TS__ArrayEvery
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local modifier_spirit_2_hit_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local SPIRIT_2_DURATION = 9
local SPIRIT_2_HIT_SLOW_DURATION = 3
local SPIRIT_2_HIT_SLOW_PCT = 50
local spirit_2 = __TS__Class()
spirit_2.name = "spirit_2"
__TS__ClassExtends(spirit_2, MonsterAbility_CS)
function spirit_2.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.8,
		castDuration = SPIRIT_2_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		OnPhaseStart = function()
			local unit = self._caster
			local pfx_name =
				"particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8_dark_swirl.vpcf"
			local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControl(pfx, 0, unit:GetAbsOrigin():__add(Vector(0, 0, 30)))
			local phaseSwirlDone = false
			Timers:CreateTimer(2.5, function()
				if phaseSwirlDone then
					return nil
				end
				phaseSwirlDone = true
				ParticleManager:DestroyParticle(pfx, false)
				ParticleManager:ReleaseParticleIndex(pfx)
				return nil
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:AddNewModifier(caster, self, "deep_echo_modifier", { duration = SPIRIT_2_DURATION })
		end,
	}
end
spirit_2 = __TS__DecorateLegacy({ registerAbility(nil) }, spirit_2)
local deep_echo_modifier = __TS__Class()
deep_echo_modifier.name = "deep_echo_modifier"
__TS__ClassExtends(deep_echo_modifier, BaseModifier_CS)
function deep_echo_modifier.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.damage = 1
end
function deep_echo_modifier.prototype.OnCreated(self, _params)
	if not IsServer() then
		return
	end
	self:OnIntervalThink()
	self:StartIntervalThink(2)
end
function deep_echo_modifier.prototype.circlesOverlap(self, circle1, circle2)
	local dx = circle1.x - circle2.x
	local dy = circle1.y - circle2.y
	local distance = math.sqrt(dx * dx + dy * dy)
	return distance < circle1.radius + circle2.radius
end
function deep_echo_modifier.prototype.generateRandomCoordinates(self, centerX, centerY, range)
	local angle = math.random() * 2 * math.pi
	local radius = math.random() * range
	local x = centerX + math.cos(angle) * radius
	local y = centerY + math.sin(angle) * radius
	return { x, y }
end
function deep_echo_modifier.prototype.generateNonOverlappingCircles(self, centerX, centerY, range, circleRadius)
	local circles = {}
	while #circles < 15 do
		local x, y = unpack(self:generateRandomCoordinates(centerX, centerY, range))
		local newCircle = { x = x, y = y, radius = circleRadius }
		if
			__TS__ArrayEvery(circles, function(____, circle)
				return not self:circlesOverlap(circle, newCircle)
			end)
		then
			circles[#circles + 1] = newCircle
		end
	end
	return circles
end
function deep_echo_modifier.prototype.OnIntervalThink(self)
	if self:GetStackCount() == 6 then
		self:Destroy()
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
	local caster = self._caster
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:SetAnimation("vs_attack_agg_alt_spin_effigy")
	local pos = caster:GetAbsOrigin()
	local circles = self:generateNonOverlappingCircles(pos.x, pos.y, 1500, 200)
	self:Timer(1, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		ScreenShake(pos, 5, 2, 1, 1300, 0, true)
		EmitSoundOn("Hero_Shared.WaterFootsteps", caster)
	end)
	__TS__ArrayForEach(circles, function(____, item)
		self:PlayEffects_pre(Vector(item.x, item.y, pos.z))
	end)
end
function deep_echo_modifier.prototype.PlayEffects_pre(self, target)
	local caster = self._caster
	local particle_cast = "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate.vpcf"
	local sound_cast = "Hero_VoidSpirit.Dissimilate.Portals"
	local point = target
	local radius = 200
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, target)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius * 1.3, 0, 1))
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(1, 0, 0))
	local effect_cast2 = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast2, 0, point)
	ParticleManager:SetParticleControl(effect_cast2, 1, Vector(radius * 1.3, 0, 1))
	EmitSoundOnLocationWithCaster(point, sound_cast, caster)
	self:Timer(0.7, function()
		self:PlayEffects_pre2(point, 1)
	end)
	Timers:CreateTimer(0.7, function()
		ParticleManager:DestroyParticle(effect_cast, false)
		ParticleManager:ReleaseParticleIndex(effect_cast)
		ParticleManager:DestroyParticle(effect_cast2, false)
		ParticleManager:ReleaseParticleIndex(effect_cast2)
		return nil
	end)
end
function deep_echo_modifier.prototype.PlayEffects_pre2(self, point, hit)
	local particle_cast = "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_dmg.vpcf"
	local particle_cast2 = "particles/units/heroes/hero_void_spirit/dissimilate/void_spirit_dissimilate_exit.vpcf"
	local sound_cast = "Hero_VoidSpirit.Dissimilate.TeleportIn"
	local sound_hit = "Hero_VoidSpirit.Dissimilate.Stun"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, self._caster)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(160, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local effect_cast2 = ParticleManager:CreateParticle(particle_cast2, PATTACH_ABSORIGIN_FOLLOW, self._caster)
	ParticleManager:ReleaseParticleIndex(effect_cast2)
	self._caster:EmitSound(sound_cast)
	if hit > 0 then
		self._caster:EmitSound(sound_hit)
	end
	self:DamageArea(point, 200, 20)
end
function deep_echo_modifier.prototype.PlayeEffect1(self, pos)
	if not IsValidAlive(nil, self._caster) then
		return
	end
	EmitSoundOn("Hero_Nevermore.Shadowraze", self._caster)
	local unit = self._caster
	local pfx_name = "particles/econ/items/lion/fish_stick/fish_stick_spell_fish_b.vpcf"
	local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_CUSTOMORIGIN, unit)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	local pfx_name2 = "particles/econ/items/lion/fish_stick/fish_stick_splash.vpcf"
	local pfx2 = ParticleManager:CreateParticle(pfx_name2, PATTACH_CUSTOMORIGIN, unit)
	ParticleManager:SetParticleControl(pfx2, 0, pos)
	local fishDone = false
	Timers:CreateTimer(0.55, function()
		if fishDone then
			return nil
		end
		fishDone = true
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		ParticleManager:DestroyParticle(pfx2, false)
		ParticleManager:ReleaseParticleIndex(pfx2)
		return nil
	end)
	self:DamageArea(pos, 200, 20)
end
function deep_echo_modifier.prototype.DamageArea(self, origin, radius, damage)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NOT_MAGIC_IMMUNE_ALLIES,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		caster:MonsterDamage({
			victim = enemy,
			damage_rate = damage,
			ability = self:GetAbility(),
		})
		modifier_spirit_2_hit_slow:applys(enemy, caster, self:GetAbility(), { duration = SPIRIT_2_HIT_SLOW_DURATION })
	end)
end
deep_echo_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, deep_echo_modifier)
modifier_spirit_2_hit_slow = __TS__Class()
modifier_spirit_2_hit_slow.name = "modifier_spirit_2_hit_slow"
__TS__ClassExtends(modifier_spirit_2_hit_slow, BaseModifier_CS)
function modifier_spirit_2_hit_slow.prototype.GetModifierConfig(self)
	return { isDebuff = true, isPurgable = true }
end
function modifier_spirit_2_hit_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -SPIRIT_2_HIT_SLOW_PCT }
end
modifier_spirit_2_hit_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_spirit_2_hit_slow)
return ____exports