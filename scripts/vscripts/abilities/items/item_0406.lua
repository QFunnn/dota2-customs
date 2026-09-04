--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
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
local ITEM_0406_DARK_ROOM_IDS = __TS__New(Set, { "M010", "M012" })
____exports.item_0406 = __TS__Class()
local item_0406 = ____exports.item_0406
item_0406.name = "item_0406"
__TS__ClassExtends(item_0406, BaseItem_CS)
function item_0406.prototype.Precache(self, context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
		context
	)
end
function item_0406.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0406_eternal_night.name
end
item_0406 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0406)
____exports.item_0406 = item_0406
____exports.modifier_item_0406_eternal_night = __TS__Class()
local modifier_item_0406_eternal_night = ____exports.modifier_item_0406_eternal_night
modifier_item_0406_eternal_night.name = "modifier_item_0406_eternal_night"
__TS__ClassExtends(modifier_item_0406_eternal_night, BaseModifier_CS)
function modifier_item_0406_eternal_night.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.consecutiveAttackCount = 0
	self.hasDarkEnvironment = false
end
function modifier_item_0406_eternal_night.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0406_eternal_night.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.hasDarkEnvironment = self:IsInDarkEnvironment()
	self:StartIntervalThink(0.2)
	self:RefreshAttributes()
end
function modifier_item_0406_eternal_night.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self.hasDarkEnvironment = self:IsInDarkEnvironment()
	self:RefreshAttributes()
end
function modifier_item_0406_eternal_night.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local hasDarkEnvironment = self:IsInDarkEnvironment()
	if self.hasDarkEnvironment == hasDarkEnvironment then
		return
	end
	self.hasDarkEnvironment = hasDarkEnvironment
	self:RefreshAttributes()
end
function modifier_item_0406_eternal_night.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0406_eternal_night.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if parent:HasModifier(____exports.modifier_item_0406_storm_ready.name) then
		return
	end
	local targetIndex = target:GetEntityIndex()
	if self.lastTargetIndex == targetIndex then
		self.consecutiveAttackCount = self.consecutiveAttackCount + 1
	else
		self.lastTargetIndex = targetIndex
		self.consecutiveAttackCount = 1
	end
	local ability_required_attack_count =
		math.max(1, math.floor(ability:GetSpecialValueFor("ability_value_c_required_attack_count")))
	if self.consecutiveAttackCount < ability_required_attack_count then
		return
	end
	parent:AddNewModifier(parent, ability, ____exports.modifier_item_0406_storm_ready.name, {})
	self:ResetCombo()
end
function modifier_item_0406_eternal_night.prototype.GetAttributeBonus(self)
	if not self.hasDarkEnvironment then
		return {}
	end
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return {
		outgoing_damage_pct = ability:GetSpecialValueFor("ability_value_dark_outgoing_damage_pct"),
		incoming_damage_decrease_pct = ability:GetSpecialValueFor("ability_value_dark_incoming_damage_decrease_pct"),
	}
end
function modifier_item_0406_eternal_night.prototype.IsHidden(self)
	return true
end
function modifier_item_0406_eternal_night.prototype.IsPurgable(self)
	return false
end
function modifier_item_0406_eternal_night.prototype.IsInDarkEnvironment(self)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return false
	end
	local playerId = parent:GetPlayerOwnerID()
	if playerId ~= nil and playerId >= 0 then
		local room = MyGameRoomManager:GetPlayerRoom(playerId)
		if room then
			return ITEM_0406_DARK_ROOM_IDS:has(room:GetRoomId())
		end
	end
	local ____opt_0 = parent.GetRoomId
	local roomId = ____opt_0 and ____opt_0(parent)
	return roomId ~= nil and ITEM_0406_DARK_ROOM_IDS:has(roomId)
end
function modifier_item_0406_eternal_night.prototype.ResetCombo(self)
	self.lastTargetIndex = nil
	self.consecutiveAttackCount = 0
end
modifier_item_0406_eternal_night = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0406_eternal_night)
____exports.modifier_item_0406_eternal_night = modifier_item_0406_eternal_night
____exports.modifier_item_0406_storm_ready = __TS__Class()
local modifier_item_0406_storm_ready = ____exports.modifier_item_0406_storm_ready
modifier_item_0406_storm_ready.name = "modifier_item_0406_storm_ready"
__TS__ClassExtends(modifier_item_0406_storm_ready, BaseModifier_CS)
function modifier_item_0406_storm_ready.GetLocalizationCN(self)
	return { name = "风暴连打", description = "下一次普通攻击附加高额物理伤害。" }
end
function modifier_item_0406_storm_ready.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK, BusinessEvents.ON_ATTACK_LANDED }
end
function modifier_item_0406_storm_ready.prototype.OnAttack_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	local target = event.target
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, target) or target:IsBuilding() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	self.pendingTargetIndex = target:GetEntityIndex()
end
function modifier_item_0406_storm_ready.prototype.OnAttackLanded_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.attacker ~= parent or event.is_sub_attack or event.is_base_attack == false then
		return
	end
	local target = event.target
	if
		not IsValidAlive(nil, parent)
		or not IsValid(nil, target)
		or target:GetEntityIndex() ~= self.pendingTargetIndex
	then
		return
	end
	local ability_damage_multiplier = math.max(0, ability:GetSpecialValueFor("ability_value_damage_multiplier") / 100)
	local ability_attack_damage = event.attack_damage or self:GetAllAttackDamage(parent)
	local ability_damage = ability_attack_damage * ability_damage_multiplier
	self:Destroy()
	if not IsValidAlive(nil, target) or ability_damage <= 0 then
		return
	end
	Damage:ApplyDamage({
		attacker = parent,
		victim = target,
		damage = ability_damage,
		damage_type = 1,
		ability = ability,
		extra_data = { custom_tag = "item_0406_storm_combo", source_name = "item_0406:风暴连打" },
	})
	self:PlayEffects1(target)
end
function modifier_item_0406_storm_ready.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self.pendingTargetIndex = nil
end
function modifier_item_0406_storm_ready.prototype.IsHidden(self)
	return false
end
function modifier_item_0406_storm_ready.prototype.IsDebuff(self)
	return false
end
function modifier_item_0406_storm_ready.prototype.IsPurgable(self)
	return false
end
function modifier_item_0406_storm_ready.prototype.GetTexture(self)
	return "item_icon_eq01_22"
end
function modifier_item_0406_storm_ready.prototype.PlayEffects1(self, target)
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		0,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		particle,
		1,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
	EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", target)
end
modifier_item_0406_storm_ready = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0406_storm_ready)
____exports.modifier_item_0406_storm_ready = modifier_item_0406_storm_ready
return ____exports