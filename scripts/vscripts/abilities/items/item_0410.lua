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
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local GetTotalAttackDamage = ____item_0409_shared.GetTotalAttackDamage
local IsOwnedByParentPlayer = ____item_0409_shared.IsOwnedByParentPlayer
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
____exports.item_0410 = __TS__Class()
local item_0410 = ____exports.item_0410
item_0410.name = "item_0410"
__TS__ClassExtends(item_0410, BaseItem_CS)
function item_0410.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0410_soul_bell.name
end
item_0410 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0410)
____exports.item_0410 = item_0410
____exports.modifier_item_0410_soul_bell = __TS__Class()
local modifier_item_0410_soul_bell = ____exports.modifier_item_0410_soul_bell
modifier_item_0410_soul_bell.name = "modifier_item_0410_soul_bell"
__TS__ClassExtends(modifier_item_0410_soul_bell, BaseModifier_CS)
function modifier_item_0410_soul_bell.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH, target = { scope = "global" } } }
end
function modifier_item_0410_soul_bell.prototype.IsHidden(self)
	return false
end
function modifier_item_0410_soul_bell.prototype.IsPurgable(self)
	return false
end
function modifier_item_0410_soul_bell.prototype.OnUnitDeath_CS(self, event)
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
	if not IsOwnedByParentPlayer(nil, attacker, parent) then
		return
	end
	if not victim or not IsValid(nil, victim) or victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if not RollPercentage(ability:GetSpecialValueFor("ability_soul_chance_pct")) then
		return
	end
	local ability_required_souls = math.max(1, math.floor(ability:GetSpecialValueFor("ability_required_souls")))
	local nextSouls = self:GetStackCount() + 1
	if nextSouls < ability_required_souls then
		self:SetStackCount(nextSouls)
		return
	end
	self:SetStackCount(0)
	self:SummonSpirit(parent, ability, victim)
end
function modifier_item_0410_soul_bell.prototype.SummonSpirit(self, parent, ability, victim)
	local ability_max_summons = math.max(1, math.floor(ability:GetSpecialValueFor("ability_max_summons")))
	local ability_duration = math.max(0.1, ability:GetSpecialValueFor("ability_duration"))
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = "monster_10080",
		position = victim:GetAbsOrigin(),
		summoner = parent,
		maxSummons = ability_max_summons,
		summonTag = ability:GetAbilityName(),
		onSpawn = function(____, unit)
			if not unit or not IsValid(nil, unit) or unit:IsNull() then
				return
			end
			unit:SetOwner(parent)
			unit:AddNewModifier(parent, ability, "modifier_kill", { duration = ability_duration })
			unit:AddNewModifier(
				parent,
				ability,
				____exports.modifier_item_0410_soldier_spirit.name,
				{ duration = ability_duration }
			)
		end,
	})
	parent:EmitSound("Hero_Visage.SummonFamiliars.Cast")
end
modifier_item_0410_soul_bell = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0410_soul_bell)
____exports.modifier_item_0410_soul_bell = modifier_item_0410_soul_bell
____exports.modifier_item_0410_soldier_spirit = __TS__Class()
local modifier_item_0410_soldier_spirit = ____exports.modifier_item_0410_soldier_spirit
modifier_item_0410_soldier_spirit.name = "modifier_item_0410_soldier_spirit"
__TS__ClassExtends(modifier_item_0410_soldier_spirit, BaseModifier_CS)
function modifier_item_0410_soldier_spirit.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.nextPatrolAt = 0
	self.inheritedHealth = 0
	self.inheritedAttack = 0
end
function modifier_item_0410_soldier_spirit.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local owner = self:GetCaster()
	local ability = self:GetAbility()
	if owner and IsValid(nil, owner) and not owner:IsNull() and ability then
		self.inheritedHealth = math.floor(
			math.max(0, owner:GetMaxHealth()) * (ability:GetSpecialValueFor("ability_summon_health_pct") / 100)
		)
		self.inheritedAttack = math.floor(
			GetTotalAttackDamage(nil, owner) * (ability:GetSpecialValueFor("ability_summon_attack_pct") / 100)
		)
	end
	self:StartIntervalThink(0.3)
end
function modifier_item_0410_soldier_spirit.prototype.GetAttributeBonus(self)
	return { bonus_health = self.inheritedHealth, bonus_attack_damage = self.inheritedAttack }
end
function modifier_item_0410_soldier_spirit.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	self:UpdateSummonCombat()
end
function modifier_item_0410_soldier_spirit.prototype.CheckState(self)
	return { [MODIFIER_STATE_UNSELECTABLE] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_item_0410_soldier_spirit.prototype.IsPurgable(self)
	return false
end
function modifier_item_0410_soldier_spirit.prototype.UpdateSummonCombat(self)
	local summon = self:GetParent()
	local owner = self:GetCaster()
	if not IsValidAlive(nil, summon) or not owner or not IsValidAlive(nil, owner) then
		self:Destroy()
		return
	end
	local ownerPos = owner:GetAbsOrigin()
	if GetDistance(nil, ownerPos, summon:GetAbsOrigin()) > 1500 then
		FindClearSpaceForUnit(summon, ownerPos, true)
		summon:Stop()
	end
	if
		self.currentTarget
		and (
			not IsValidEnemyUnit(nil, owner, self.currentTarget)
			or GetDistance(nil, ownerPos, self.currentTarget:GetAbsOrigin()) > 1200
		)
	then
		self.currentTarget = nil
	end
	if not self.currentTarget then
		local enemies = FindUnitsInRadius(
			owner:GetTeamNumber(),
			ownerPos,
			nil,
			800,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_CLOSEST,
			false
		)
		self.currentTarget = nil
		for ____, enemy in ipairs(enemies) do
			if IsValidEnemyUnit(nil, owner, enemy) then
				self.currentTarget = enemy
				break
			end
		end
	end
	if self.currentTarget then
		summon:MoveToTargetToAttack(self.currentTarget)
		return
	end
	local now = GameRules:GetGameTime()
	if now < self.nextPatrolAt then
		return
	end
	local angle = RandomFloat(0, math.pi * 2)
	local radius = RandomFloat(180, 420)
	local destination = ownerPos:__add(Vector(math.cos(angle) * radius, math.sin(angle) * radius, 0))
	destination.z = GetGroundHeight(destination, summon)
	summon:MoveToPosition(destination)
	self.nextPatrolAt = now + 1.2
end
modifier_item_0410_soldier_spirit = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0410_soldier_spirit)
____exports.modifier_item_0410_soldier_spirit = modifier_item_0410_soldier_spirit
return ____exports