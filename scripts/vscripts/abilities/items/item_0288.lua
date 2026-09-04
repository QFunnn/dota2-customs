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
local __TS__StringTrim = ____lualib.__TS__StringTrim
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ITEM_0288_DEFAULT_SUMMON_UNIT = "monster_10080"
local ITEM_0288_OWNER_ATTACK_RANGE = 800
local ITEM_0288_OWNER_DISENGAGE_RANGE = 1200
local ITEM_0288_SUMMON_TELEPORT_RANGE = 1500
local ITEM_0288_PATROL_MIN_RADIUS = 180
local ITEM_0288_PATROL_MAX_RADIUS = 420
local ITEM_0288_INHERIT_HEALTH_PCT = 0.5
local ITEM_0288_INHERIT_ATTACK_PCT = 0.5
____exports.item_0288 = __TS__Class()
local item_0288 = ____exports.item_0288
item_0288.name = "item_0288"
__TS__ClassExtends(item_0288, BaseItem_CS)
function item_0288.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0288_necromancy.name
end
item_0288 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0288)
____exports.item_0288 = item_0288
____exports.modifier_item_0288_necromancy = __TS__Class()
local modifier_item_0288_necromancy = ____exports.modifier_item_0288_necromancy
modifier_item_0288_necromancy.name = "modifier_item_0288_necromancy"
__TS__ClassExtends(modifier_item_0288_necromancy, BaseModifier_CS)
function modifier_item_0288_necromancy.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH, target = { scope = "global" } } }
end
function modifier_item_0288_necromancy.prototype.IsHidden(self)
	return true
end
function modifier_item_0288_necromancy.prototype.OnUnitDeath_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local ____event_entindex_attacker_0
	if event.entindex_attacker then
		____event_entindex_attacker_0 = EntIndexToHScript(event.entindex_attacker)
	else
		____event_entindex_attacker_0 = nil
	end
	local attacker = ____event_entindex_attacker_0
	local ____event_entindex_killed_1
	if event.entindex_killed then
		____event_entindex_killed_1 = EntIndexToHScript(event.entindex_killed)
	else
		____event_entindex_killed_1 = nil
	end
	local victim = ____event_entindex_killed_1
	if not attacker or not IsValid(nil, attacker) or attacker:IsNull() then
		return
	end
	if not self:IsOwnedByParentPlayer(attacker, parent) then
		return
	end
	if not victim or not IsValid(nil, victim) then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local chance = ability:GetSpecialValueFor("ability_summon_chance_pct")
	if not RollPercentage(chance) then
		return
	end
	local summonUnitName = ITEM_0288_DEFAULT_SUMMON_UNIT
	if not summonUnitName or __TS__StringTrim(summonUnitName) == "" then
		return
	end
	local maxSummons = math.max(1, math.floor(ability:GetSpecialValueFor("ability_max_summons")))
	local duration = math.max(0.1, ability:GetSpecialValueFor("ability_duration"))
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = summonUnitName,
		position = victim:GetAbsOrigin(),
		summoner = parent,
		maxSummons = maxSummons,
		summonTag = ability:GetAbilityName(),
		onSpawn = function(____, unit)
			if not unit or not IsValid(nil, unit) or unit:IsNull() then
				return
			end
			unit:SetOwner(parent)
			unit:AddNewModifier(parent, ability, "modifier_kill", { duration = duration })
			unit:AddNewModifier(
				parent,
				ability,
				____exports.modifier_item_0288_summon_auto_combat.name,
				{ duration = duration }
			)
		end,
	})
	parent:EmitSound("Hero_Visage.SummonFamiliars.Cast")
end
function modifier_item_0288_necromancy.prototype.IsOwnedByParentPlayer(self, attacker, parent)
	local parentPlayerId = parent:GetPlayerOwnerID()
	if parentPlayerId >= 0 then
		local attackerPlayerId = attacker:GetPlayerOwnerID()
		if attackerPlayerId == parentPlayerId then
			return true
		end
	end
	if attacker == parent then
		return true
	end
	local attackerOwner = attacker:GetOwner()
	if attackerOwner and IsValid(nil, attackerOwner) and not attackerOwner:IsNull() and attackerOwner == parent then
		return true
	end
	return false
end
modifier_item_0288_necromancy = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0288_necromancy)
____exports.modifier_item_0288_necromancy = modifier_item_0288_necromancy
____exports.modifier_item_0288_summon_auto_combat = __TS__Class()
local modifier_item_0288_summon_auto_combat = ____exports.modifier_item_0288_summon_auto_combat
modifier_item_0288_summon_auto_combat.name = "modifier_item_0288_summon_auto_combat"
__TS__ClassExtends(modifier_item_0288_summon_auto_combat, BaseModifier_CS)
function modifier_item_0288_summon_auto_combat.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.nextPatrolAt = 0
	self.inheritedBonusHealth = 0
	self.inheritedBonusAttackDamage = 0
end
function modifier_item_0288_summon_auto_combat.prototype.OnCreated(self)
	local owner = self:GetCaster()
	if owner and IsValid(nil, owner) and not owner:IsNull() then
		self.inheritedBonusHealth = math.floor(math.max(0, owner:GetMaxHealth()) * ITEM_0288_INHERIT_HEALTH_PCT)
		self.inheritedBonusAttackDamage = math.floor(
			math.max(0, MyGameAttribute:GetAttribute(owner, "total_attack_damage") or 0) * ITEM_0288_INHERIT_ATTACK_PCT
		)
	end
	if not IsServer() then
		return
	end
	self:StartIntervalThink(0.3)
end
function modifier_item_0288_summon_auto_combat.prototype.GetAttributeBonus(self)
	return { bonus_health = self.inheritedBonusHealth, bonus_attack_damage = self.inheritedBonusAttackDamage }
end
function modifier_item_0288_summon_auto_combat.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local summon = self:GetParent()
	local owner = self:GetCaster()
	if not IsValidAlive(nil, summon) or not owner or not IsValidAlive(nil, owner) then
		self:Destroy()
		return
	end
	local ownerPos = owner:GetAbsOrigin()
	local summonPos = summon:GetAbsOrigin()
	if GetDistance(nil, ownerPos, summonPos) > ITEM_0288_SUMMON_TELEPORT_RANGE then
		FindClearSpaceForUnit(summon, ownerPos, true)
		summon:Stop()
	end
	if
		self.currentTarget
		and (not IsValidAlive(nil, self.currentTarget) or self.currentTarget:GetTeamNumber() == summon:GetTeamNumber())
	then
		self.currentTarget = nil
	end
	if self.currentTarget then
		local targetPos = self.currentTarget:GetAbsOrigin()
		if GetDistance(nil, ownerPos, targetPos) > ITEM_0288_OWNER_DISENGAGE_RANGE then
			self.currentTarget = nil
			summon:Stop()
			self:MoveNearOwner(summon, owner)
			return
		end
		summon:MoveToTargetToAttack(self.currentTarget)
		return
	end
	local enemies = FindUnitsInRadius(
		owner:GetTeamNumber(),
		ownerPos,
		nil,
		ITEM_0288_OWNER_ATTACK_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	local attackTarget
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue32
			end
			attackTarget = enemy
			break
		end
		::__continue32::
	end
	if attackTarget then
		self.currentTarget = attackTarget
		summon:MoveToTargetToAttack(attackTarget)
		return
	end
	local now = GameRules:GetGameTime()
	if now >= self.nextPatrolAt then
		self:PatrolAroundOwner(summon, owner)
		self.nextPatrolAt = now + 1.2
	end
end
function modifier_item_0288_summon_auto_combat.prototype.MoveNearOwner(self, summon, owner)
	local ownerPos = owner:GetAbsOrigin()
	local angle = RandomFloat(0, math.pi * 2)
	local radius = RandomFloat(ITEM_0288_PATROL_MIN_RADIUS, ITEM_0288_PATROL_MAX_RADIUS)
	local destination = ownerPos:__add(Vector(math.cos(angle) * radius, math.sin(angle) * radius, 0))
	destination.z = GetGroundHeight(destination, summon)
	summon:MoveToPosition(destination)
end
function modifier_item_0288_summon_auto_combat.prototype.PatrolAroundOwner(self, summon, owner)
	self:MoveNearOwner(summon, owner)
end
function modifier_item_0288_summon_auto_combat.prototype.CheckState(self)
	return { [MODIFIER_STATE_UNSELECTABLE] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_item_0288_summon_auto_combat.prototype.IsHidden(self)
	return false
end
function modifier_item_0288_summon_auto_combat.prototype.IsPurgable(self)
	return false
end
function modifier_item_0288_summon_auto_combat.prototype.RemoveOnDeath(self)
	return true
end
modifier_item_0288_summon_auto_combat =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0288_summon_auto_combat)
____exports.modifier_item_0288_summon_auto_combat = modifier_item_0288_summon_auto_combat
return ____exports