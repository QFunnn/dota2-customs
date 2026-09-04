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
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local phantome_ab7 = __TS__Class()
phantome_ab7.name = "phantome_ab7"
__TS__ClassExtends(phantome_ab7, MonsterAbility_CS)
function phantome_ab7.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.target = nil
end
function phantome_ab7.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.2,
		castDuration = 0,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:SetAnimation("attack_flip")
			local target = self:GetCaster():GetMinDistanceUnit(3500)
			local origin = caster:GetAbsOrigin()
			if target then
				local distance = GetDistance(nil, caster:GetAbsOrigin(), target:GetAbsOrigin())
				distance = math.max(400, math.min(1000, distance))
				local fow = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
				caster:Mover(origin:__add(fow:__mul(distance * 0.75)), 0.2)
				caster:SetForwardVector(fow)
			else
				caster:Mover(origin:__add(caster:GetForwardVector():__mul(400)), 0.2)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			caster:EmitSound("Hero_PhantomLancer.SpiritLance.Throw")
			self:DamageArea(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(50)), 300, 5)
		end,
	}
end
function phantome_ab7.prototype.DamageArea(self, origin, radius, damage)
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
		caster:PerformAttack(enemy, true, true, true, false, true, false, true)
		AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 0.3 })
	end)
end
phantome_ab7 = __TS__DecorateLegacy({ registerAbility(nil) }, phantome_ab7)
return ____exports