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
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____item_0409_shared = require("abilities.items.item_0409_shared")
local FindEnemies = ____item_0409_shared.FindEnemies
local GetAgility = ____item_0409_shared.GetAgility
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local KEZ_AFTERIMAGE_CAST_PARTICLE = "particles/item/kez_sai_afterimage_cast.vpcf"
local KEZ_AFTERIMAGE_TRACKING_PARTICLE = "particles/item/kez_sai_afterimage_tracking.vpcf"
local KEZ_TOSS_IMPACT_PARTICLE = "particles/units/heroes/hero_kez/kez_sai_toss_impact.vpcf"
local KEZ_AFTERIMAGE_DASH_SOUND = "Hero_Kez.EchoSlash.Katana.Start"
local KEZ_AFTERIMAGE_IMPACT_SOUND = "Hero_Kez.Katana.Impale.Start"
local THINK_INTERVAL = 0.1
local MAX_COUNTED_DISTANCE_PER_THINK = 1000
local AFTERIMAGE_RING_RADIUS = 450
____exports.item_0523 = __TS__Class()
local item_0523 = ____exports.item_0523
item_0523.name = "item_0523"
__TS__ClassExtends(item_0523, BaseItem_CS)
function item_0523.prototype.Precache(self, context)
	PrecacheResource("particle", KEZ_AFTERIMAGE_CAST_PARTICLE, context)
	PrecacheResource("particle", KEZ_AFTERIMAGE_TRACKING_PARTICLE, context)
	PrecacheResource("particle", KEZ_TOSS_IMPACT_PARTICLE, context)
end
function item_0523.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0523_afterimage.name
end
item_0523 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0523)
____exports.item_0523 = item_0523
____exports.modifier_item_0523_afterimage = __TS__Class()
local modifier_item_0523_afterimage = ____exports.modifier_item_0523_afterimage
modifier_item_0523_afterimage.name = "modifier_item_0523_afterimage"
__TS__ClassExtends(modifier_item_0523_afterimage, BaseModifier_CS)
function modifier_item_0523_afterimage.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.storedDistance = 0
end
function modifier_item_0523_afterimage.GetLocalizationCN(self)
	return {
		name = "残影突袭",
		description = "移动累积距离后召唤残影袭击敌人脚下的固定位置。",
	}
end
function modifier_item_0523_afterimage.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self.lastPosition = self:GetParent():GetAbsOrigin()
	self.storedDistance = 0
	self:StartIntervalThink(THINK_INTERVAL)
end
function modifier_item_0523_afterimage.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
end
function modifier_item_0523_afterimage.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return
	end
	local currentPosition = parent:GetAbsOrigin()
	if not self.lastPosition then
		self.lastPosition = currentPosition
		return
	end
	local ability_distance_per_stack = math.max(1, ability:GetSpecialValueFor("ability_value_c_distance_per_stack"))
	local stepDistance = GetDistance(nil, self.lastPosition, currentPosition)
	self.lastPosition = currentPosition
	if stepDistance <= 0 then
		return
	end
	local countedDistance = math.min(stepDistance, MAX_COUNTED_DISTANCE_PER_THINK)
	self.storedDistance = self.storedDistance + countedDistance
	while self.storedDistance >= ability_distance_per_stack do
		self.storedDistance = self.storedDistance - ability_distance_per_stack
		self:TriggerAfterimage(parent, ability)
	end
	self:SetStackCount(math.floor(self.storedDistance))
end
function modifier_item_0523_afterimage.prototype.TriggerAfterimage(self, parent, ability)
	local ability_search_radius = math.max(0, ability:GetSpecialValueFor("ability_search_radius"))
	local target = self:FindNearestEnemy(parent, ability_search_radius)
	if not target then
		return
	end
	local ability_impact_delay = math.max(0, ability:GetSpecialValueFor("ability_impact_delay"))
	local impactPosition = self:GetPredictedImpactPosition(target, ability_impact_delay)
	local anchorDuration = ability_impact_delay + 1.2
	local anchor = CreateModifierThinker(
		parent,
		ability,
		____exports.modifier_item_0523_impact_anchor.name,
		{ duration = anchorDuration },
		impactPosition,
		parent:GetTeamNumber(),
		false
	)
	if not anchor or anchor:IsNull() then
		return
	end
	self:PlayEffects1(parent, anchor, ability_impact_delay)
	local currentTarget = target
	Timers:CreateTimer(ability_impact_delay, function()
		if not IsValidAlive(nil, parent) then
			self:RemoveAnchor(anchor)
			return
		end
		if not IsValid(nil, anchor) or anchor:IsNull() then
			self:RemoveAnchor(anchor)
			return
		end
		self:UpdateImpactAnchor(parent, currentTarget, anchor)
		self:PerformImpact(parent, ability, anchor)
		self:RemoveAnchor(anchor)
	end)
end
function modifier_item_0523_afterimage.prototype.UpdateImpactAnchor(self, parent, target, anchor)
	if not IsValidAlive(nil, target) or not IsValidEnemyUnit(nil, parent, target) or target:IsBuilding() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ability_search_radius = math.max(0, ability:GetSpecialValueFor("ability_search_radius"))
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_max_tracking_distance = ability_search_radius + ability_radius
	if GetDistance(nil, parent:GetAbsOrigin(), target:GetAbsOrigin()) > ability_max_tracking_distance then
		return
	end
	anchor:SetAbsOrigin(GetGroundPosition(target:GetAbsOrigin(), target))
end
function modifier_item_0523_afterimage.prototype.FindNearestEnemy(self, parent, radius)
	if radius <= 0 then
		return nil
	end
	local candidates = __TS__ArrayFilter(FindEnemies(nil, parent, parent:GetAbsOrigin(), radius), function(____, enemy)
		return IsValidEnemyUnit(nil, parent, enemy) and not enemy:IsBuilding()
	end)
	if #candidates <= 0 then
		return nil
	end
	local nearest = candidates[1]
	local nearestDistance = GetDistance(nil, parent:GetAbsOrigin(), nearest:GetAbsOrigin())
	do
		local i = 1
		while i < #candidates do
			local candidate = candidates[i + 1]
			local distance = GetDistance(nil, parent:GetAbsOrigin(), candidate:GetAbsOrigin())
			if distance < nearestDistance then
				nearest = candidate
				nearestDistance = distance
			end
			i = i + 1
		end
	end
	return nearest
end
function modifier_item_0523_afterimage.prototype.GetPredictedImpactPosition(self, target, ability_impact_delay)
	local targetPos = target:GetAbsOrigin()
	local targetForward = target:GetForwardVector()
	local targetMovespeed = MyGameAttribute:GetAttribute(target, "total_movespeed") or target:GetIdealSpeed()
	local predictedFlat = targetPos:__add(targetForward:__mul(math.max(0, targetMovespeed) * ability_impact_delay))
	return GetGroundPosition(predictedFlat, target)
end
function modifier_item_0523_afterimage.prototype.PerformImpact(self, parent, ability, anchor)
	local impactPosition = anchor:GetAbsOrigin()
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_agility_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_value_agility_damage_pct"))
	local ability_movespeed_threshold = math.max(0, ability:GetSpecialValueFor("ability_movespeed_threshold"))
	local ability_bonus_movespeed_per_damage_pct =
		math.max(1, ability:GetSpecialValueFor("ability_bonus_movespeed_per_damage_pct"))
	local ability_damage_amp_per_step_pct = math.max(1, ability:GetSpecialValueFor("ability_damage_amp_per_step_pct"))
	local damage = self:CalculateDamage(
		parent,
		ability_agility_damage_pct,
		ability_movespeed_threshold,
		ability_bonus_movespeed_per_damage_pct,
		ability_damage_amp_per_step_pct
	)
	if damage <= 0 or ability_radius <= 0 then
		self:PlayEffects2(parent, anchor)
		return
	end
	self:PlayEffects2(parent, anchor)
	for ____, enemy in ipairs(FindEnemies(nil, parent, impactPosition, ability_radius)) do
		do
			if not IsValidEnemyUnit(nil, parent, enemy) or enemy:IsBuilding() then
				goto __continue34
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = damage,
				damage_type = 2,
				ability = ability,
				extra_data = {
					damage_tags = DamageTag.NO_PROC,
					custom_tag = "item_0523_afterimage",
					source_name = self:GetName(),
				},
			})
		end
		::__continue34::
	end
end
function modifier_item_0523_afterimage.prototype.CalculateDamage(
	self,
	parent,
	ability_agility_damage_pct,
	ability_movespeed_threshold,
	ability_bonus_movespeed_per_damage_pct,
	ability_damage_amp_per_step_pct
)
	local agilityDamage = GetAgility(nil, parent) * (ability_agility_damage_pct / 100)
	local totalMovespeed = MyGameAttribute:GetAttribute(parent, "total_movespeed") or parent:GetIdealSpeed()
	local movespeedAboveThreshold = math.max(0, totalMovespeed - ability_movespeed_threshold)
	local damageAmpPct = math.floor(movespeedAboveThreshold / ability_bonus_movespeed_per_damage_pct)
		* ability_damage_amp_per_step_pct
	return agilityDamage * (1 + damageAmpPct / 100)
end
function modifier_item_0523_afterimage.prototype.PlayEffects1(self, parent, anchor, ability_impact_delay)
	local casterPos = parent:GetAbsOrigin()
	local impactPos = anchor:GetAbsOrigin()
	local forward = parent:GetForwardVector()
	local backAngle = math.atan2(-forward.y, -forward.x)
	local theta = backAngle + RandomFloat(-math.pi / 2, math.pi / 2)
	local ringFlat =
		casterPos:__add(Vector(AFTERIMAGE_RING_RADIUS * math.cos(theta), AFTERIMAGE_RING_RADIUS * math.sin(theta), 0))
	local ringPoint = GetGroundPosition(ringFlat, parent)
	local ringDir = impactPos:__sub(ringPoint):Normalized()
	local castPfx =
		MyGameHeroParticleManager:CreateParticle(KEZ_AFTERIMAGE_CAST_PARTICLE, PATTACH_ABSORIGIN, parent, parent)
	MyGameHeroParticleManager:SetParticleControl(castPfx, 0, casterPos)
	MyGameHeroParticleManager:SetParticleControl(castPfx, 1, casterPos)
	MyGameHeroParticleManager:SetParticleControl(castPfx, 2, ringPoint)
	MyGameHeroParticleManager:SetParticleControl(castPfx, 3, casterPos)
	MyGameHeroParticleManager:SetParticleControl(castPfx, 5, Vector(1, 0, 0))
	MyGameHeroParticleManager:SetParticleControlEnt(
		castPfx,
		7,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0),
		true
	)
	local ability_tracking_duration = math.min(0.3, ability_impact_delay)
	local ability_cast_delay = math.max(0, ability_impact_delay - ability_tracking_duration)
	Timers:CreateTimer(ability_cast_delay, function()
		MyGameHeroParticleManager:DestroyParticle(castPfx, false)
		MyGameHeroParticleManager:ReleaseParticleIndex(castPfx)
		if not IsValidAlive(nil, parent) or not IsValid(nil, anchor) or anchor:IsNull() then
			return
		end
		EmitSoundOnLocationWithCaster(ringPoint, KEZ_AFTERIMAGE_DASH_SOUND, parent)
		local trackPfx = MyGameHeroParticleManager:CreateParticle(
			KEZ_AFTERIMAGE_TRACKING_PARTICLE,
			PATTACH_ABSORIGIN_FOLLOW,
			parent,
			parent
		)
		MyGameHeroParticleManager:SetParticleControl(trackPfx, 4, ringPoint)
		MyGameHeroParticleManager:SetParticleControl(trackPfx, 1, anchor:GetAbsOrigin())
		MyGameHeroParticleManager:SetParticleControlTransformForward(trackPfx, 4, ringPoint, ringDir)
		MyGameHeroParticleManager:SetParticleControl(trackPfx, 5, Vector(1, 0, 0))
		MyGameHeroParticleManager:SetParticleControlEnt(
			trackPfx,
			7,
			parent,
			PATTACH_ABSORIGIN_FOLLOW,
			"attach_attack1",
			Vector(0, 0, 0),
			true
		)
		Timers:CreateTimer(ability_tracking_duration, function()
			MyGameHeroParticleManager:DestroyParticle(trackPfx, false)
			MyGameHeroParticleManager:ReleaseParticleIndex(trackPfx)
		end)
	end)
end
function modifier_item_0523_afterimage.prototype.PlayEffects2(self, parent, anchor)
	local impactPos = anchor:GetAbsOrigin()
	local direction = impactPos:__sub(parent:GetAbsOrigin()):Normalized()
	local impactPfx =
		MyGameHeroParticleManager:CreateParticle(KEZ_TOSS_IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil, parent)
	MyGameHeroParticleManager:SetParticleControl(impactPfx, 0, impactPos)
	MyGameHeroParticleManager:SetParticleControl(impactPfx, 1, impactPos)
	MyGameHeroParticleManager:SetParticleControlTransformForward(impactPfx, 1, impactPos, direction)
	MyGameHeroParticleManager:ReleaseParticleIndex(impactPfx)
	EmitSoundOnLocationWithCaster(impactPos, KEZ_AFTERIMAGE_IMPACT_SOUND, parent)
end
function modifier_item_0523_afterimage.prototype.RemoveAnchor(self, anchor)
	if IsValid(nil, anchor) and not anchor:IsNull() then
		anchor:RemoveSelf()
	end
end
function modifier_item_0523_afterimage.prototype.IsHidden(self)
	return true
end
function modifier_item_0523_afterimage.prototype.IsPurgable(self)
	return false
end
function modifier_item_0523_afterimage.prototype.GetTexture(self)
	return "item_icon_m50_05"
end
modifier_item_0523_afterimage = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0523_afterimage)
____exports.modifier_item_0523_afterimage = modifier_item_0523_afterimage
--- 残影落点锚点：用于把需要实体绑定的 Kez 特效固定在空地。
____exports.modifier_item_0523_impact_anchor = __TS__Class()
local modifier_item_0523_impact_anchor = ____exports.modifier_item_0523_impact_anchor
modifier_item_0523_impact_anchor.name = "modifier_item_0523_impact_anchor"
__TS__ClassExtends(modifier_item_0523_impact_anchor, BaseModifier_CS)
function modifier_item_0523_impact_anchor.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
	}
end
function modifier_item_0523_impact_anchor.prototype.IsHidden(self)
	return true
end
function modifier_item_0523_impact_anchor.prototype.IsPurgable(self)
	return false
end
modifier_item_0523_impact_anchor = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0523_impact_anchor)
____exports.modifier_item_0523_impact_anchor = modifier_item_0523_impact_anchor
return ____exports