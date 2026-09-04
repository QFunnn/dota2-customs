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
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ITEM_0287_DAMAGE_MERGE_WINDOW = 0.1
local ITEM_0287_KNOCKBACK_DURATION = 0.3
____exports.item_0287 = __TS__Class()
local item_0287 = ____exports.item_0287
item_0287.name = "item_0287"
__TS__ClassExtends(item_0287, BaseItem_CS)
function item_0287.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0287_tracker.name
end
item_0287 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0287)
____exports.item_0287 = item_0287
____exports.modifier_item_0287_tracker = __TS__Class()
local modifier_item_0287_tracker = ____exports.modifier_item_0287_tracker
modifier_item_0287_tracker.name = "modifier_item_0287_tracker"
__TS__ClassExtends(modifier_item_0287_tracker, BaseModifier_CS)
function modifier_item_0287_tracker.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.damageRecords = {}
	self.damageSumInWindow = 0
	self.damageRecordHead = 0
end
function modifier_item_0287_tracker.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEAL_DAMAGE }
end
function modifier_item_0287_tracker.prototype.IsHidden(self)
	return true
end
function modifier_item_0287_tracker.prototype.OnDealDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if event.victim ~= parent then
		return
	end
	if (event.final_damage or 0) <= 0 then
		return
	end
	if CheckTag(nil, event.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local now = GameRules:GetGameTime()
	local windowStart = now - ITEM_0287_DAMAGE_MERGE_WINDOW
	while
		self.damageRecordHead < #self.damageRecords
		and self.damageRecords[self.damageRecordHead + 1].t < windowStart
	do
		self.damageSumInWindow = self.damageSumInWindow - self.damageRecords[self.damageRecordHead + 1].dmg
		self.damageRecordHead = self.damageRecordHead + 1
	end
	if self.damageRecordHead > 32 and self.damageRecordHead * 2 > #self.damageRecords then
		self.damageRecords = __TS__ArraySlice(self.damageRecords, self.damageRecordHead)
		self.damageRecordHead = 0
	end
	local sumBefore = self.damageSumInWindow
	local dmg = event.final_damage or 0
	local ____self_damageRecords_0 = self.damageRecords
	____self_damageRecords_0[#____self_damageRecords_0 + 1] = { t = now, dmg = dmg }
	self.damageSumInWindow = self.damageSumInWindow + dmg
	local sumAfter = self.damageSumInWindow
	local threshold = parent:GetMaxHealth() * (ability:GetSpecialValueFor("ability_threshold_pct") / 100)
	if sumBefore <= threshold and sumAfter > threshold then
		self:TriggerQuake(parent, ability)
	end
end
function modifier_item_0287_tracker.prototype.TriggerQuake(self, parent, ability)
	local radius = ability:GetSpecialValueFor("ability_radius")
	local knockbackDistance = ability:GetSpecialValueFor("ability_knockback_distance")
	local slowDuration = ability:GetSpecialValueFor("ability_slow_duration")
	local damage = ability:GetSpecialValueFor("ability_damage")
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue16
			end
			local direction = GetDirection(nil, enemy:GetAbsOrigin(), parent:GetAbsOrigin())
			enemy:KnockBack(parent, ability, {
				duration = ITEM_0287_KNOCKBACK_DURATION,
				distance = knockbackDistance,
				direction = direction,
				height = 75,
				stun = true,
				block = true,
			})
			enemy:AddNewModifier(
				parent,
				ability,
				____exports.modifier_item_0287_seismic_slow.name,
				{ duration = slowDuration }
			)
			if damage > 0 then
				Damage:ApplyDamage({
					victim = enemy,
					attacker = parent,
					damage = damage,
					damage_type = 2,
					ability = ability,
				})
			end
		end
		::__continue16::
	end
	ability:StartCooldown(math.max(0.1, ability:GetCooldown(ability:GetLevel())))
	parent:EmitSound("Hero_ElderTitan.EchoStomp")
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/units/heroes/hero_elder_titan/elder_titan_echo_stomp_magical.vpcf",
		PATTACH_ABSORIGIN,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(radius, 1, 1))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
end
modifier_item_0287_tracker = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0287_tracker)
____exports.modifier_item_0287_tracker = modifier_item_0287_tracker
____exports.modifier_item_0287_seismic_slow = __TS__Class()
local modifier_item_0287_seismic_slow = ____exports.modifier_item_0287_seismic_slow
modifier_item_0287_seismic_slow.name = "modifier_item_0287_seismic_slow"
__TS__ClassExtends(modifier_item_0287_seismic_slow, BaseModifier_CS)
function modifier_item_0287_seismic_slow.GetLocalizationCN(self)
	return { name = "地震迟滞", description = "移动速度降低。" }
end
function modifier_item_0287_seismic_slow.prototype.GetAttributeBonus(self)
	local ability = self:GetAbility()
	if not ability then
		return {}
	end
	return { bonus_movespeed_pct = -math.abs(ability:GetSpecialValueFor("ability_slow_pct")) }
end
function modifier_item_0287_seismic_slow.prototype.IsHidden(self)
	return false
end
function modifier_item_0287_seismic_slow.prototype.IsDebuff(self)
	return true
end
function modifier_item_0287_seismic_slow.prototype.IsPurgable(self)
	return true
end
function modifier_item_0287_seismic_slow.prototype.GetTexture(self)
	return "item_fallen_sky"
end
modifier_item_0287_seismic_slow = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0287_seismic_slow)
____exports.modifier_item_0287_seismic_slow = modifier_item_0287_seismic_slow
return ____exports