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
local registerAbility = ____dota_ts_adapter.registerAbility
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_thunder_grass = require("abilities.items.potions.item_thunder_grass")
local HasNearbyThunderPower = ____item_thunder_grass.HasNearbyThunderPower
local THUNDERIZED_MODIFIER = ____item_thunder_grass.THUNDERIZED_MODIFIER
local THUNDERIZED_STATUS_EFFECT = ____item_thunder_grass.THUNDERIZED_STATUS_EFFECT
local THUNDERIZED_AMBIENT_EFFECT = ____item_thunder_grass.THUNDERIZED_AMBIENT_EFFECT
local THUNDERIZED_STATIC_STORM_EFFECT = ____item_thunder_grass.THUNDERIZED_STATIC_STORM_EFFECT
local ____dark_domain_lightning_flash = require("my_game_axe.room.dark_domain_lightning_flash")
local TriggerDarkDomainLightningFlash = ____dark_domain_lightning_flash.TriggerDarkDomainLightningFlash
local THUNDERIZED_LIGHTNING_PARTICLE = "particles/map/m_014/ak_thunder_hit.vpcf"
local THUNDERIZED_LIGHTNING_RADIUS = 800
local THUNDERIZED_LIGHTNING_DAMAGE_CURRENT_HEALTH_PCT = 5
local THUNDERIZED_LIGHTNING_SKY_HEIGHT = 1555
____exports.item_0471 = __TS__Class()
local item_0471 = ____exports.item_0471
item_0471.name = "item_0471"
__TS__ClassExtends(item_0471, BaseItem_CS)
function item_0471.prototype.Precache(self, context)
	PrecacheResource("particle", THUNDERIZED_STATUS_EFFECT, context)
	PrecacheResource("particle", THUNDERIZED_AMBIENT_EFFECT, context)
	PrecacheResource("particle", THUNDERIZED_STATIC_STORM_EFFECT, context)
	PrecacheResource("particle", THUNDERIZED_LIGHTNING_PARTICLE, context)
end
function item_0471.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "direct",
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			if HasNearbyThunderPower(nil, caster) then
				local ability_duration = self:GetSpecialValueFor("ability_duration")
				caster:AddNewModifier(caster, self, THUNDERIZED_MODIFIER, {
					duration = ability_duration,
					play_loop_sound = 1,
					allow_attack_counter_break = 0,
					allow_perfect_timing = 0,
					consume_on_attack = 0,
				})
				TriggerDarkDomainLightningFlash(nil, caster)
				self:StrikeNearbyBlueCastMonsters(caster)
				local ability_level = math.max(self:GetLevel() - 1, 0)
				self:StartCooldown(self:GetCooldown(ability_level))
			else
				ErrorMsg(nil, caster:GetPlayerId(), "附近没有足够的雷电力量，什么都没发生...")
			end
		end,
		onInterrupted = function() end,
	}
end
function item_0471.prototype.StrikeNearbyBlueCastMonsters(self, caster)
	local targets = self:FindThunderizedLightningTargets(caster)
	for ____, target in ipairs(targets) do
		self:PlayEffects1(caster, target)
		self:ApplyThunderizedLightningDamage(caster, target)
		TriggerDarkDomainLightningFlash(nil, caster, target)
		self:TryInterruptBlueCast(caster, target)
	end
end
function item_0471.prototype.FindThunderizedLightningTargets(self, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		THUNDERIZED_LIGHTNING_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local targets = {}
	for ____, enemy in ipairs(enemies) do
		do
			if not self:IsValidBlueCastMonster(caster, enemy) then
				goto __continue13
			end
			targets[#targets + 1] = enemy
		end
		::__continue13::
	end
	return targets
end
function item_0471.prototype.IsValidBlueCastMonster(self, caster, target)
	if not target or not IsValidAlive(nil, target) or target:IsBuilding() then
		return false
	end
	if target:GetTeamNumber() == caster:GetTeamNumber() then
		return false
	end
	if not self:IsMonsterTarget(target) then
		return false
	end
	if not target:HasModifier("modifier_monster_cast_pre_progress") then
		return false
	end
	local ability = self:GetCurrentMonsterAbility(target)
	local ____opt_0 = ability and ability.GetMosnterAbilityConfig
	local cfg = ____opt_0 and ____opt_0(ability)
	return (cfg and cfg.castProgressBarColor) == "blue" and (cfg and cfg.thunderizedCounterBreak) == true
end
function item_0471.prototype.IsMonsterTarget(self, target)
	local ____this_9
	____this_9 = target
	local ____opt_8 = ____this_9.GetUnitType
	local unitType = ____opt_8 and ____opt_8(____this_9)
	return unitType == UnitType.MONSTER_NORMAL
		or unitType == UnitType.MONSTER_ELITE
		or unitType == UnitType.MONSTER_MINIBOSS
		or unitType == UnitType.MONSTER_BOSS
end
function item_0471.prototype.GetCurrentMonsterAbility(self, target)
	local precastModifier = target:FindModifierByName("modifier_monster_cast_pre_progress")
	local ____opt_10 = precastModifier and precastModifier.GetAbility
	return ____opt_10 and ____opt_10(precastModifier)
end
function item_0471.prototype.ApplyThunderizedLightningDamage(self, caster, target)
	local currentHealth = math.max(target:GetHealth(), 0)
	local damage =
		math.min(currentHealth * THUNDERIZED_LIGHTNING_DAMAGE_CURRENT_HEALTH_PCT / 100, math.max(currentHealth - 1, 0))
	if damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		ability = self,
		damage = damage,
		damage_type = 4,
		extra_data = {
			custom_tag = "item_0471_thunderized_lightning",
			source_name = self:GetAbilityName(),
		},
	})
end
function item_0471.prototype.TryInterruptBlueCast(self, caster, target)
	local ability = self:GetCurrentMonsterAbility(target)
	local ____opt_14 = ability and ability.TryTriggerThunderizedCounterBreak
	if ____opt_14 ~= nil then
		____opt_14(ability, caster)
	end
end
function item_0471.prototype.PlayEffects1(self, caster, target)
	local point = GetGroundPosition(target:GetAbsOrigin(), target)
	local particlePoint = point:__add(Vector(0, 0, 50))
	local pfx =
		MyGameHeroParticleManager:CreateParticle(THUNDERIZED_LIGHTNING_PARTICLE, PATTACH_WORLDORIGIN, nil, caster)
	MyGameHeroParticleManager:SetParticleShouldCheckFoW(pfx, false)
	MyGameHeroParticleManager:SetParticleControl(pfx, 0, particlePoint)
	MyGameHeroParticleManager:SetParticleControl(pfx, 1, particlePoint)
	MyGameHeroParticleManager:SetParticleControl(
		pfx,
		2,
		particlePoint:__add(Vector(0, 0, THUNDERIZED_LIGHTNING_SKY_HEIGHT))
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(point, "Hero_Zuus.LightningBolt", caster)
end
item_0471 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0471)
____exports.item_0471 = item_0471
return ____exports