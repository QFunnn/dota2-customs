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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
--- 大牛-2连跳砸 (boss_elder_titan_1)
local px7 = "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_attack_hit_flash.vpcf"
____exports.boss_elder_titan_1 = __TS__Class()
local boss_elder_titan_1 = ____exports.boss_elder_titan_1
boss_elder_titan_1.name = "boss_elder_titan_1"
__TS__ClassExtends(boss_elder_titan_1, MonsterAbility_CS)
function boss_elder_titan_1.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.damage = 1.2
end
function boss_elder_titan_1.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1700,
		castPoint = 1.1,
		castDuration = 2,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_SPAWN,
		animationPlaybackRate = 0.75,
		isNotMove = true,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_ElderTitan.EchoStomp.Channel")
			caster:LockTargetForSpeed(caster:GetMinDistanceUnit(2500), 0.8, 5)
			local pfx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_sandking/sandking_sandstorm_start.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				caster
			)
			ParticleManager:ReleaseParticleIndex(pfx)
			self:Timer(0.1, function()
				caster:Mover(caster:GetAbsOrigin():__sub(caster:GetForwardVector():__mul(150)), 0.4)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			self:PlayStep()
			self:Timer(0.8, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:PlayStep2()
			end)
		end,
	}
end
function boss_elder_titan_1.prototype.PlayStep(self)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(2500)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 0.7)
	local dis = caster:AiDistance(target, 450, 750, -50, 50)
	local p = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(dis - 80))
	caster:AddNewModifier(caster, self, "modifier_boss_elder_titan_1_pre", { duration = 0.4 })
	caster:Mover(p, 0.3)
	____exports.modifier_boss_elder_titan_1_land:applys(caster, caster, self, { duration = 0.6 })
end
function boss_elder_titan_1.prototype.PlayStep2(self)
	local caster = self:GetCaster()
	local target = caster:GetMinDistanceUnit(2000)
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_5, 0.9)
	local dis = caster:AiDistance(target, 100, 350, -50, 50)
	local p = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(dis - 50))
	caster:Mover(p, 0.4)
	____exports.modifier_boss_elder_titan_1_land:applys(caster, caster, self, { duration = 0.6 })
end
boss_elder_titan_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_elder_titan_1)
____exports.boss_elder_titan_1 = boss_elder_titan_1
____exports.modifier_boss_elder_titan_1_land = __TS__Class()
local modifier_boss_elder_titan_1_land = ____exports.modifier_boss_elder_titan_1_land
modifier_boss_elder_titan_1_land.name = "modifier_boss_elder_titan_1_land"
__TS__ClassExtends(modifier_boss_elder_titan_1_land, BaseModifier_CS)
function modifier_boss_elder_titan_1_land.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
end
function modifier_boss_elder_titan_1_land.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local pfx_name = "particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf"
	local p = parent:GetAbsOrigin():__add(parent:GetForwardVector():__mul(300))
	local pfx = ParticleManager:CreateParticle(pfx_name, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, p)
	ParticleManager:SetParticleControl(pfx, 1, Vector(400, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)
	ScreenShake(parent:GetAbsOrigin(), 5, 2, 1, 2300, 0, true)
	parent:EmitSound("Hero_ElderTitan.EchoStomp")
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		p,
		nil,
		450,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, target)
		caster:MonsterDamage({
			victim = target,
			damage_rate = 25,
			ability = self:GetAbility(),
		})
		target:KnockBack(caster, self:GetAbility(), {
			origin_pos = parent:GetOrigin(),
			duration = 0.2,
			stun = true,
			distance = 0,
			height = 200,
			stunDuration = 1,
		})
	end)
end
modifier_boss_elder_titan_1_land = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_elder_titan_1_land)
____exports.modifier_boss_elder_titan_1_land = modifier_boss_elder_titan_1_land
____exports.modifier_boss_elder_titan_1_pre = __TS__Class()
local modifier_boss_elder_titan_1_pre = ____exports.modifier_boss_elder_titan_1_pre
modifier_boss_elder_titan_1_pre.name = "modifier_boss_elder_titan_1_pre"
__TS__ClassExtends(modifier_boss_elder_titan_1_pre, BaseModifier_CS)
function modifier_boss_elder_titan_1_pre.prototype.GetEffectName(self)
	return "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test3.vpcf"
end
modifier_boss_elder_titan_1_pre = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_elder_titan_1_pre)
____exports.modifier_boss_elder_titan_1_pre = modifier_boss_elder_titan_1_pre
return ____exports