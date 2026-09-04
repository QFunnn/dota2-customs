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
local IsValidFriendUnit = ____item_0409_shared.IsValidFriendUnit
local battleStandardUnitName = "npc_dota_unit_roshans_banner"
local battleStandardModel = "models/props_gameplay/roshans_banner.vmdl"
local battleStandardRadiusParticle = "particles/aoe/aura/ak_aura_assault.vpcf"
local battleStandardDieAnimationDuration = 1.4
____exports.item_0422 = __TS__Class()
local item_0422 = ____exports.item_0422
item_0422.name = "item_0422"
__TS__ClassExtends(item_0422, BaseItem_CS)
function item_0422.prototype.Precache(self, context)
	PrecacheUnitByNameSync(battleStandardUnitName, context)
	PrecacheResource("model", battleStandardModel, context)
	PrecacheResource("particle", battleStandardRadiusParticle, context)
end
function item_0422.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
	}
end
function item_0422.prototype.GetCastRange(self, _location, _target)
	return self:GetSpecialValueFor("ability_radius")
end
function item_0422.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("ability_radius")
end
function item_0422.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_duration = math.max(0, self:GetSpecialValueFor("ability_duration"))
	local targetPoint = GetGroundPosition(self:GetCursorPosition(), caster)
	self:CreateBattleStandard(caster, targetPoint, ability_duration)
	self:PlayEffects1(caster, targetPoint)
end
function item_0422.prototype.CreateBattleStandard(self, caster, targetPoint, ability_duration)
	MyGameUnit:CreateUnitAsync({
		unitName = battleStandardUnitName,
		unitType = UnitType.NPC,
		position = targetPoint,
		findClearSpace = false,
		owner = caster,
		entityOwner = caster,
		team = caster:GetTeamNumber(),
		onSpawn = function(____, battleStandard)
			if not battleStandard or battleStandard:IsNull() then
				return
			end
			if not IsValidAlive(nil, caster) then
				MyGameUnit:DestroyUnit(battleStandard)
				return
			end
			battleStandard:SetOwner(caster)
			battleStandard:SetAbsOrigin(targetPoint)
			battleStandard:SetForwardVector(caster:GetForwardVector())
			battleStandard:SetDayTimeVisionRange(0)
			battleStandard:SetNightTimeVisionRange(0)
			battleStandard:AddNewModifier(
				caster,
				self,
				____exports.modifier_item_0422_battle_standard_thinker.name,
				{ duration = ability_duration }
			)
		end,
	})
end
function item_0422.prototype.PlayEffects1(self, caster, targetPoint)
	EmitSoundOnLocationWithCaster(targetPoint, "DOTA_Item.DoE.Activate", caster)
end
item_0422 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0422)
____exports.item_0422 = item_0422
____exports.modifier_item_0422_battle_standard_thinker = __TS__Class()
local modifier_item_0422_battle_standard_thinker = ____exports.modifier_item_0422_battle_standard_thinker
modifier_item_0422_battle_standard_thinker.name = "modifier_item_0422_battle_standard_thinker"
__TS__ClassExtends(modifier_item_0422_battle_standard_thinker, BaseModifier_CS)
function modifier_item_0422_battle_standard_thinker.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValid(nil, parent) then
		return
	end
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	parent:SetModelScale(0.5)
	Timers:CreateTimer(FrameTime(), function()
		if not IsValid(nil, parent) or parent:IsNull() then
			return
		end
		parent:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 1)
	end)
	self:PlayEffects1(parent, ability_radius)
end
function modifier_item_0422_battle_standard_thinker.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:DestroyRadiusParticle()
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	self:PlayEffects2(parent)
	parent:AddNewModifier(
		parent,
		self:GetAbility(),
		"modifier_invulnerable_and_hide_health_bar",
		{ duration = battleStandardDieAnimationDuration }
	)
	Timers:CreateTimer(battleStandardDieAnimationDuration, function()
		if not IsValid(nil, parent) or parent:IsNull() then
			return
		end
		parent:RemoveSelf()
	end)
end
function modifier_item_0422_battle_standard_thinker.prototype.GetModifierAura(self)
	return ____exports.modifier_item_0422_battle_standard_buff.name
end
function modifier_item_0422_battle_standard_thinker.prototype.GetAuraRadius(self)
	local ability = self:GetAbility()
	local ____ability_0
	if ability then
		____ability_0 = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	else
		____ability_0 = 0
	end
	return ____ability_0
end
function modifier_item_0422_battle_standard_thinker.prototype.GetAuraDuration(self)
	local ability = self:GetAbility()
	local ____ability_1
	if ability then
		____ability_1 = math.max(0.1, ability:GetSpecialValueFor("ability_refresh_interval") * 2)
	else
		____ability_1 = 0.5
	end
	return ____ability_1
end
function modifier_item_0422_battle_standard_thinker.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_item_0422_battle_standard_thinker.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function modifier_item_0422_battle_standard_thinker.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_item_0422_battle_standard_thinker.prototype.GetAuraEntityReject(self, target)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return true
	end
	return not IsValidFriendUnit(nil, caster, target)
end
function modifier_item_0422_battle_standard_thinker.prototype.IsAura(self)
	return true
end
function modifier_item_0422_battle_standard_thinker.prototype.IsHidden(self)
	return true
end
function modifier_item_0422_battle_standard_thinker.prototype.IsPurgable(self)
	return false
end
function modifier_item_0422_battle_standard_thinker.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end
function modifier_item_0422_battle_standard_thinker.prototype.PlayEffects1(self, parent, ability_radius)
	self:DestroyRadiusParticle()
	local caster = self:GetCaster()
	local ____IsValidAlive_result_2
	if IsValidAlive(nil, caster) then
		____IsValidAlive_result_2 = caster:GetTeamNumber()
	else
		____IsValidAlive_result_2 = parent:GetTeamNumber()
	end
	local teamNumber = ____IsValidAlive_result_2
	self.radiusParticle =
		ParticleManager:CreateParticleForTeam(battleStandardRadiusParticle, PATTACH_WORLDORIGIN, parent, teamNumber)
	ParticleManager:SetParticleShouldCheckFoW(self.radiusParticle, false)
	ParticleManager:SetParticleControl(self.radiusParticle, 0, parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(self.radiusParticle, 3, Vector(ability_radius, 0, 0))
	ParticleManager:SetParticleControl(self.radiusParticle, 6, Vector(96, 255, 120))
end
function modifier_item_0422_battle_standard_thinker.prototype.DestroyRadiusParticle(self)
	if self.radiusParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.radiusParticle, false)
	ParticleManager:ReleaseParticleIndex(self.radiusParticle)
	self.radiusParticle = nil
end
function modifier_item_0422_battle_standard_thinker.prototype.PlayEffects2(self, parent)
	parent:FadeGesture(ACT_DOTA_SPAWN)
	parent:Stop()
	parent:StartGestureWithPlaybackRate(ACT_DOTA_DIE, 1.5)
end
modifier_item_0422_battle_standard_thinker =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0422_battle_standard_thinker)
____exports.modifier_item_0422_battle_standard_thinker = modifier_item_0422_battle_standard_thinker
____exports.modifier_item_0422_battle_standard_buff = __TS__Class()
local modifier_item_0422_battle_standard_buff = ____exports.modifier_item_0422_battle_standard_buff
modifier_item_0422_battle_standard_buff.name = "modifier_item_0422_battle_standard_buff"
__TS__ClassExtends(modifier_item_0422_battle_standard_buff, BaseModifier_CS)
function modifier_item_0422_battle_standard_buff.GetLocalizationCN(self)
	return { name = "王庭战旗", description = "提高战旗周围友军的物理伤害。" }
end
function modifier_item_0422_battle_standard_buff.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	local ability_value_physical_damage_add_pct = ability:GetSpecialValueFor("ability_value_physical_damage_add_pct")
	return { physical_damage_add_pct = ability_value_physical_damage_add_pct }
end
function modifier_item_0422_battle_standard_buff.prototype.IsPurgable(self)
	return true
end
modifier_item_0422_battle_standard_buff =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0422_battle_standard_buff)
____exports.modifier_item_0422_battle_standard_buff = modifier_item_0422_battle_standard_buff
return ____exports