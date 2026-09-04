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
local warningEffectRing = ____monster_base.warningEffectRing
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 践踏伤害与预警半径（与 FindUnitsInRadius 一致）
local BOSS_ELDER_TITAN_2_STOMP_RADIUS = 430
____exports.boss_elder_titan_2 = __TS__Class()
local boss_elder_titan_2 = ____exports.boss_elder_titan_2
boss_elder_titan_2.name = "boss_elder_titan_2"
__TS__ClassExtends(boss_elder_titan_2, MonsterAbility_CS)
function boss_elder_titan_2.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1700,
		castPoint = 0.3,
		castDuration = 2.1,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
		end,
		OnStart = function()
			if not self:IsAbilityValid() then
				return
			end
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			____exports.modifier_boss_elder_titan_2_main_effect:applys(caster, caster, self, { duration = 0.7 })
			____exports.modifier_boss_elder_titan_2_spirit_stomp:applys(caster, caster, self, { duration = 1.8 })
			self:PlayCastEffect(caster)
			self:Timer(0.2, function()
				if not self:IsAbilityValid() or not IsValidAlive(nil, caster) then
					return
				end
				self:PlaySpiritEffect(caster:GetAbsOrigin())
				local fows = GetRotateVectors(nil, caster:GetForwardVector(), 6, 60)
				__TS__ArrayForEach(fows, function(____, fow)
					local currentFow = fow
					local targetPos = caster:GetAbsOrigin():__add(currentFow:__mul(900))
					MyGameUnit:CreateSummonedUnitAsync({
						unitName = "elder_titan_mj",
						position = caster:GetAbsOrigin(),
						summoner = caster,
						team = caster:GetTeamNumber(),
						findClearSpace = true,
						summonTag = "boss_elder_titan_2_spirit",
						onSpawn = function(____, unit)
							if not unit or not IsValid(nil, unit) or unit:IsNull() then
								return
							end
							if not self:IsAbilityValid() then
								unit:SelfRemoveSelf()
								return
							end
							unit:SetModelScale(1.2)
							local time = math.random() * 0.3 + 0.6
							unit:AddNewModifier(unit, nil, "modifier_invulnerable", { duration = 5 })
							unit:AddNewModifier(unit, nil, "modifier_pause_actions", { duration = 5 })
							unit:StartGestureWithPlaybackRate(ACT_DOTA_FLAIL, 1)
							unit:SetForwardVector(currentFow)
							unit:Mover(targetPos, time)
							self:Timer(time - 0.4, function()
								if
									not self:IsAbilityValid()
									or not IsValidAlive(nil, unit)
									or not IsValidAlive(nil, caster)
								then
									return
								end
								unit:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.2)
								____exports.modifier_boss_elder_titan_2_spirit_stomp:applys(
									unit,
									caster,
									self,
									{ duration = 1.5 }
								)
							end)
							Timers:CreateTimer(time + 1.6, function()
								if not IsValid(nil, unit) or unit:IsNull() then
									return
								end
								if self:IsAbilityValid() and IsValidAlive(nil, unit) then
									self:PlaySpiritEffect(unit:GetAbsOrigin())
								end
								unit:AddNoDraw()
								unit:SelfRemoveSelf()
							end)
						end,
					})
				end)
			end)
		end,
	}
end
function boss_elder_titan_2.prototype.IsAbilityValid(self)
	return IsValid(nil, self) and IsValidEntity(self) and not self:IsNull()
end
function boss_elder_titan_2.prototype.PlaySpiritEffect(self, pos)
	if not self:IsAbilityValid() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local px_name = "particles/units/heroes/hero_elder_titan/elder_titan_ancestral_spirit_cast.vpcf"
	local pfx = ParticleManager:CreateParticle(px_name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, pos)
	ParticleManager:SetParticleControl(pfx, 2, pos)
	ParticleManager:ReleaseParticleIndex(pfx)
	caster:EmitSound("Hero_ElderTitan.AncestralSpirit.Spawn")
end
function boss_elder_titan_2.prototype.PlayCastEffect(self, target)
	if not IsValidAlive(nil, target) then
		return
	end
	local pfx_name = "particles/econ/items/tiny/tiny_prestige/tiny_prestige_tree_spawn_form.vpcf"
	local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(pfx)
	target:EmitSound("Hero_ElderTitan.EchoStomp.Channel")
end
boss_elder_titan_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_elder_titan_2)
____exports.boss_elder_titan_2 = boss_elder_titan_2
____exports.modifier_boss_elder_titan_2_main_effect = __TS__Class()
local modifier_boss_elder_titan_2_main_effect = ____exports.modifier_boss_elder_titan_2_main_effect
modifier_boss_elder_titan_2_main_effect.name = "modifier_boss_elder_titan_2_main_effect"
__TS__ClassExtends(modifier_boss_elder_titan_2_main_effect, BaseModifier_CS)
function modifier_boss_elder_titan_2_main_effect.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or not IsValidEntity(parent) or parent:IsNull() then
		return
	end
	local pfx_name = "particles/econ/items/elder_titan/elder_titan_ti7/elder_titan_echo_stomp_cast_combined_ti7.vpcf"
	local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:ReleaseParticleIndex(pfx)
end
modifier_boss_elder_titan_2_main_effect =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_elder_titan_2_main_effect)
____exports.modifier_boss_elder_titan_2_main_effect = modifier_boss_elder_titan_2_main_effect
____exports.modifier_boss_elder_titan_2_spirit_stomp = __TS__Class()
local modifier_boss_elder_titan_2_spirit_stomp = ____exports.modifier_boss_elder_titan_2_spirit_stomp
modifier_boss_elder_titan_2_spirit_stomp.name = "modifier_boss_elder_titan_2_spirit_stomp"
__TS__ClassExtends(modifier_boss_elder_titan_2_spirit_stomp, BaseModifier_CS)
function modifier_boss_elder_titan_2_spirit_stomp.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) or not IsValidAlive(nil, parent) then
		return
	end
	local function playRing()
		local remain = self:GetRemainingTime()
		if remain <= 0 or not IsValidAlive(nil, parent) then
			return
		end
		warningEffectRing(nil, caster, parent:GetAbsOrigin(), BOSS_ELDER_TITAN_2_STOMP_RADIUS, remain)
	end
	if parent:GetUnitName() == "elder_titan_mj" then
		self:Timer(0.4, playRing)
	else
		playRing(nil)
	end
end
function modifier_boss_elder_titan_2_spirit_stomp.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not IsValid(nil, parent) or not IsValidEntity(parent) or parent:IsNull() then
		return
	end
	local pfx_name = "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf"
	local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(pfx, 1, Vector(300, 0, 0))
	ParticleManager:SetParticleControl(pfx, 2, Vector(300, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
	caster:EmitSound("Hero_ElderTitan.EchoStomp")
	ScreenShake(parent:GetAbsOrigin(), 5, 2, 1, 2300, 0, true)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		BOSS_ELDER_TITAN_2_STOMP_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, target)
		caster:MonsterDamage({ victim = target, damage_rate = 30, ability = ability })
		target:KnockBack(caster, self:GetAbility(), {
			origin_pos = parent:GetOrigin(),
			duration = 0.3,
			stunDuration = 2,
			stun = true,
			distance = 0,
			height = 200,
		})
	end)
end
modifier_boss_elder_titan_2_spirit_stomp =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_elder_titan_2_spirit_stomp)
____exports.modifier_boss_elder_titan_2_spirit_stomp = modifier_boss_elder_titan_2_spirit_stomp
return ____exports