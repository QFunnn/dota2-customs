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
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local INTERVAL = 15
local WARNING_DURATION = 1.5
local HERO_SEARCH_RADIUS = 1500
local PROJECTILE_SPRAY_RADIUS = 1300
local PROJECTILE_COUNT = 5
local TRAVEL_TIME = 0.5
local PROJECTILE_DAMAGE_RATE = 20
local LAND_AOE_RADIUS = 280
local LAND_EFFECT_DURATION = 5
local PROJECTILE_EFFECT = "particles/units/heroes/hero_viper/viper_poison_attack.vpcf"
local LAND_EFFECT = "particles/units/heroes/hero_viper/viper_nethertoxin.vpcf"
local WARNING_RING_EFFECT = "particles/monster/ability_warning_ring.vpcf"
--- 资源点技能 - 喷毒：每10秒搜索附近英雄，2秒预警后在500范围内随机释放8个投射物
____exports.tree_001 = __TS__Class()
local tree_001 = ____exports.tree_001
tree_001.name = "tree_001"
__TS__ClassExtends(tree_001, BaseAbility)
function tree_001.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_EFFECT, context)
	PrecacheResource("particle", LAND_EFFECT, context)
	PrecacheResource("particle", WARNING_RING_EFFECT, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_viper.vsndevts", context)
end
function tree_001.prototype.GetIntrinsicModifierName(self)
	return "tree_001_modifier"
end
tree_001 = __TS__DecorateLegacy({ registerAbility(nil) }, tree_001)
____exports.tree_001 = tree_001
____exports.tree_001_modifier = __TS__Class()
local tree_001_modifier = ____exports.tree_001_modifier
tree_001_modifier.name = "tree_001_modifier"
__TS__ClassExtends(tree_001_modifier, MonsterModifier_CS)
function tree_001_modifier.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(INTERVAL)
end
function tree_001_modifier.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local tree = self:GetParent()
	if not IsValidAlive(nil, tree) then
		return
	end
	local treePos = tree:GetAbsOrigin()
	local enemiesInRange = self:FindHeroesInRadius(HERO_SEARCH_RADIUS, treePos)
	if #enemiesInRange == 0 then
		return
	end
	tree:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
	local endPoints = GetRandomPointsInCircle(nil, treePos, PROJECTILE_SPRAY_RADIUS, PROJECTILE_COUNT, 80)
	for ____, endPoint in ipairs(endPoints) do
		self:WarningRingEffect(endPoint, LAND_AOE_RADIUS, WARNING_DURATION + 0.3)
	end
	local ability = self:GetAbility()
	local index = 0
	local function fireNext()
		if not IsValidAlive(nil, tree) then
			return nil
		end
		if index >= #endPoints then
			return nil
		end
		local endPoint = endPoints[index + 1]
		local distance = treePos:__sub(endPoint):Length2D()
		local speed = distance / TRAVEL_TIME
		tree:EmitSound("hero_viper.poisonAttack.Cast")
		CreateProjectile(nil, {
			ability = ability,
			caster = tree,
			effect_name = PROJECTILE_EFFECT,
			target = endPoint,
			start_point = treePos + Vector(0, 0, 175),
			projectile_type = "collideground",
			projectile_speed = speed,
			on_hit = function(____, target, location, extraData)
				if not IsValidAlive(nil, tree) then
					return true
				end
				local landPos = endPoint
				ScreenShake(endPoint, 5, 5, 0.1, 3000, 0, true)
				tree:EmitSound("hero_viper.PoisonAttack.Target.ti7")
				local enemies = self:FindHeroesInRadius(LAND_AOE_RADIUS, location)
				for ____, enemy in ipairs(enemies) do
					tree:MonsterDamage({ victim = enemy, damage_rate = PROJECTILE_DAMAGE_RATE, ability = self._ability })
				end
				local pfx = ParticleManager:CreateParticle(LAND_EFFECT, PATTACH_WORLDORIGIN, nil)
				ParticleManager:SetParticleControl(pfx, 0, landPos)
				ParticleManager:SetParticleControl(pfx, 1, Vector(LAND_AOE_RADIUS * 0.8, 1, 1))
				local time = 0
				Timers:CreateTimer(0.3, function()
					time = time + 0.3
					if time > LAND_EFFECT_DURATION then
						return
					end
					local enemies = self:FindHeroesInRadius(LAND_AOE_RADIUS, location)
					for ____, enemy in ipairs(enemies) do
						do
							if not IsValidAlive(nil, tree) then
								goto __continue21
							end
							tree:MonsterDamage({
								victim = enemy,
								damage_rate = PROJECTILE_DAMAGE_RATE * 0.2,
								ability = self._ability,
							})
						end
						::__continue21::
					end
					return 0.3
				end)
				Timers:CreateTimer(LAND_EFFECT_DURATION, function()
					ParticleManager:DestroyParticle(pfx, false)
					ParticleManager:ReleaseParticleIndex(pfx)
					return nil
				end)
				return true
			end,
		})
		index = index + 1
		return index < #endPoints and 0 or nil
	end
	Timers:CreateTimer(WARNING_DURATION - 0.3, fireNext)
end
tree_001_modifier = __TS__DecorateLegacy({ registerModifier(nil) }, tree_001_modifier)
____exports.tree_001_modifier = tree_001_modifier
return ____exports