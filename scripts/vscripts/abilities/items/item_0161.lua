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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
--- 凝视：周期性对周围随机敌人进行一次触手打击，造成全属性魔法伤害。
____exports.item_0161 = __TS__Class()
local item_0161 = ____exports.item_0161
item_0161.name = "item_0161"
__TS__ClassExtends(item_0161, BaseItem_CS)
function item_0161.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/boss_tidehunter/tidehunter_spell_ravage.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context)
end
function item_0161.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0161.name
end
item_0161 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0161)
____exports.item_0161 = item_0161
____exports.modifier_item_0161 = __TS__Class()
local modifier_item_0161 = ____exports.modifier_item_0161
modifier_item_0161.name = "modifier_item_0161"
__TS__ClassExtends(modifier_item_0161, BaseModifier_CS)
function modifier_item_0161.prototype.IsHidden(self)
	return true
end
function modifier_item_0161.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartGazeInterval()
end
function modifier_item_0161.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:StartGazeInterval()
end
function modifier_item_0161.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local target = self:SelectRandomTarget(caster)
	if not target then
		self:StartGazeInterval(0.5)
		return
	end
	local damage = self:GetGazeDamage(caster)
	if damage <= 0 then
		self:StartGazeInterval()
		return
	end
	self:PlayEffects1(target)
	self:ApplyGazeDamage(caster, ability, target, damage)
	self:StartGazeCooldown(ability)
end
function modifier_item_0161.prototype.StartGazeInterval(self, delay)
	local interval = delay or self:GetGazeInterval()
	self:StartIntervalThink(math.max(0.1, interval))
end
function modifier_item_0161.prototype.GetGazeInterval(self)
	local ability = self:GetAbility()
	if not ability then
		return 3
	end
	local ability_level = math.max(0, ability:GetLevel() - 1)
	local ability_cooldown = ability:GetCooldown(ability_level)
	local ____temp_0
	if ability_cooldown > 0 then
		____temp_0 = ability_cooldown
	else
		____temp_0 = 3
	end
	return ____temp_0
end
function modifier_item_0161.prototype.SelectRandomTarget(self, caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		800,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	local targets = {}
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue18
			end
			targets[#targets + 1] = enemy
		end
		::__continue18::
	end
	if #targets <= 0 then
		return nil
	end
	return targets[RandomInt(0, #targets - 1) + 1]
end
function modifier_item_0161.prototype.GetGazeDamage(self, caster)
	local strength = MyGameAttribute:GetAttribute(caster, "total_strength") or 0
	local agility = MyGameAttribute:GetAttribute(caster, "total_agility") or 0
	local intelligence = MyGameAttribute:GetAttribute(caster, "total_intelligence") or 0
	local rate = self:GetAbility():GetSpecialValueFor("ability_damage")
	return (strength + agility + intelligence) * rate * 0.01
end
function modifier_item_0161.prototype.ApplyGazeDamage(self, caster, ability, target, damage)
	Damage:ApplyDamage({
		attacker = caster,
		victim = target,
		ability = ability,
		damage = damage,
		damage_type = 2,
	})
end
function modifier_item_0161.prototype.StartGazeCooldown(self, ability)
	local ability_cooldown = self:GetGazeInterval()
	ability:StartCooldown(ability_cooldown)
	self:StartGazeInterval(ability_cooldown)
end
function modifier_item_0161.prototype.PlayEffects1(self, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/boss_tidehunter/tidehunter_spell_ravage.vpcf",
		PATTACH_CUSTOMORIGIN,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	self:GetAbility():EmitSoundParams("Ability.Ravage", 1, 0.3, 0)
end
modifier_item_0161 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0161)
____exports.modifier_item_0161 = modifier_item_0161
return ____exports