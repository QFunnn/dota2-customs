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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 大牛-裂地斩 (boss_elder_titan_3)
local px1 = "particles/econ/items/elder_titan/elder_titan_2021/elder_titan_2021_earth_splitter.vpcf"
____exports.boss_elder_titan_3 = __TS__Class()
local boss_elder_titan_3 = ____exports.boss_elder_titan_3
boss_elder_titan_3.name = "boss_elder_titan_3"
__TS__ClassExtends(boss_elder_titan_3, MonsterAbility_CS)
function boss_elder_titan_3.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.speed = 0.8
	self.damage = 1.2
end
function boss_elder_titan_3.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1700,
		castPoint = 0.1,
		castDuration = 4.5 / 0.8,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		OnStart = function()
			local caster = self:GetCaster()
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 0.6 * self.speed)
			caster:Mover(caster:GetAbsOrigin():__sub(caster:GetForwardVector():__mul(350)), 0.4 / self.speed)
			local target = caster:GetMinDistanceUnit(2500)
			caster:LockTargetForSpeed(target, 0.5 / self.speed, 3)
			self:Timer(0.6 / self.speed, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:EmitSound("Hero_ElderTitan.EarthSplitter.Projectile")
				local fows = GetRotateVectors(nil, caster:GetForwardVector(), 5, 30)
				self:PlayCastEffects(caster)
				local dis = 4500
				__TS__ArrayForEach(fows, function(____, fow)
					local px = ParticleManager:CreateParticle(px1, PATTACH_WORLDORIGIN, nil)
					ParticleManager:SetParticleControl(px, 0, caster:GetAbsOrigin():__add(fow:__mul(150)))
					ParticleManager:SetParticleControl(px, 1, caster:GetAbsOrigin():__add(fow:__mul(dis)))
					ParticleManager:SetParticleControl(px, 2, Vector(200, 0, 0))
					ParticleManager:SetParticleControl(px, 3, Vector(0, 2.5 / self.speed, 0))
					ParticleManager:ReleaseParticleIndex(px)
				end)
				local currentDis = 500
				self:Timer(0.5, function()
					if not IsValidAlive(nil, caster) then
						return
					end
					currentDis = currentDis + 500
					__TS__ArrayForEach(fows, function(____, fow)
						local enemies = FindUnitsInLine(
							caster:GetTeamNumber(),
							caster:GetAbsOrigin():__add(fow:__mul(150)),
							caster:GetAbsOrigin():__add(fow:__mul(currentDis)),
							nil,
							200,
							DOTA_UNIT_TARGET_TEAM_ENEMY,
							DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
							DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
						)
						__TS__ArrayForEach(enemies, function(____, enemy)
							caster:MonsterDamage({ victim = enemy, damage_rate = 10, ability = self })
							____exports.modifier_boss_elder_titan_3_slow:applys(enemy, caster, self, { duration = 1.5 })
						end)
					end)
					if currentDis < 3400 then
						return 0.5
					end
				end)
				self:Timer(1.8 / self.speed, function()
					if not IsValidAlive(nil, caster) then
						return
					end
					____exports.modifier_boss_elder_titan_3_channel:applys(
						caster,
						caster,
						self,
						{ duration = 1.2 / self.speed }
					)
					self:Timer(0.9, function()
						if not IsValidAlive(nil, caster) then
							return
						end
						caster:EmitSound("Hero_ElderTitan.EarthSplitter.Destroy")
						caster:StopSound("Hero_ElderTitan.EarthSplitter.Projectile")
						__TS__ArrayForEach(fows, function(____, fow)
							local enemies = FindUnitsInLine(
								caster:GetTeamNumber(),
								caster:GetAbsOrigin():__add(fow:__mul(150)),
								caster:GetAbsOrigin():__add(fow:__mul(dis)),
								nil,
								200,
								DOTA_UNIT_TARGET_TEAM_ENEMY,
								DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
								DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
							)
							__TS__ArrayForEach(enemies, function(____, enemy)
								if not IsValidAlive(nil, enemy) then
									return
								end
								caster:MonsterDamage({ victim = enemy, damage_rate = 40, ability = self })
								enemy:KnockBack(caster, self, {
									origin_pos = caster:GetOrigin(),
									duration = 0.3,
									stunDuration = 3,
									stun = true,
									distance = 0,
									height = 300,
								})
							end)
						end)
					end)
				end)
			end)
		end,
	}
end
function boss_elder_titan_3.prototype.PlayCastEffects(self, caster)
	local pfx1 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_sandking/sandking_sandstorm_start.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(pfx1)
	local pfx2 = ParticleManager:CreateParticle(
		"particles/econ/items/elder_titan/elder_titan_ti7/elder_titan_echo_stomp_ti7_end.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(pfx2)
end
boss_elder_titan_3 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_elder_titan_3)
____exports.boss_elder_titan_3 = boss_elder_titan_3
____exports.modifier_boss_elder_titan_3_channel = __TS__Class()
local modifier_boss_elder_titan_3_channel = ____exports.modifier_boss_elder_titan_3_channel
modifier_boss_elder_titan_3_channel.name = "modifier_boss_elder_titan_3_channel"
__TS__ClassExtends(modifier_boss_elder_titan_3_channel, BaseModifier_CS)
function modifier_boss_elder_titan_3_channel.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION, MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE }
end
function modifier_boss_elder_titan_3_channel.prototype.GetOverrideAnimation(self)
	return ACT_DOTA_GENERIC_CHANNEL_1
end
function modifier_boss_elder_titan_3_channel.prototype.GetOverrideAnimationRate(self)
	return 0.7
end
modifier_boss_elder_titan_3_channel =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_elder_titan_3_channel)
____exports.modifier_boss_elder_titan_3_channel = modifier_boss_elder_titan_3_channel
____exports.modifier_boss_elder_titan_3_slow = __TS__Class()
local modifier_boss_elder_titan_3_slow = ____exports.modifier_boss_elder_titan_3_slow
modifier_boss_elder_titan_3_slow.name = "modifier_boss_elder_titan_3_slow"
__TS__ClassExtends(modifier_boss_elder_titan_3_slow, BaseModifier_CS)
function modifier_boss_elder_titan_3_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -80 }
end
function modifier_boss_elder_titan_3_slow.prototype.GetEffectName(self)
	return "particles/void_spirit_astral_step_debuff_ember_blue.vpcf"
end
function modifier_boss_elder_titan_3_slow.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_boss_elder_titan_3_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_elder_titan_3_slow)
____exports.modifier_boss_elder_titan_3_slow = modifier_boss_elder_titan_3_slow
return ____exports