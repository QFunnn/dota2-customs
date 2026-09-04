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
local ITEM_0336_MANA_THRESHOLD = 100
local ITEM_0336_MANA_PER_MAGIC_DAMAGE_PCT = 5
local ITEM_0336_REFRESH_INTERVAL = 0.2
____exports.item_0334 = __TS__Class()
local item_0334 = ____exports.item_0334
item_0334.name = "item_0334"
__TS__ClassExtends(item_0334, BaseItem_CS)
function item_0334.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0334_thorn_shield.name
end
item_0334 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0334)
____exports.item_0334 = item_0334
____exports.modifier_item_0334_thorn_shield = __TS__Class()
local modifier_item_0334_thorn_shield = ____exports.modifier_item_0334_thorn_shield
modifier_item_0334_thorn_shield.name = "modifier_item_0334_thorn_shield"
__TS__ClassExtends(modifier_item_0334_thorn_shield, BaseModifier_CS)
function modifier_item_0334_thorn_shield.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.cachedCurrentMana = -1
	self.cachedMagicalDamageAddPct = -1
	self.cachedMaxMana = -1
	self.cachedBonusHealth = -1
end
function modifier_item_0334_thorn_shield.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEAL_DAMAGE }
end
function modifier_item_0334_thorn_shield.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function modifier_item_0334_thorn_shield.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	if not self:IsDynamicSageItem() then
		return
	end
	self:RecalculateDynamicBonus(true)
	self:StartIntervalThink(ITEM_0336_REFRESH_INTERVAL)
end
function modifier_item_0334_thorn_shield.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	if not self:IsDynamicSageItem() then
		self:StartIntervalThink(-1)
		return
	end
	self:RecalculateDynamicBonus(false)
end
function modifier_item_0334_thorn_shield.prototype.GetAttributeBonus(self)
	if self:IsSageBoots() then
		return { magical_damage_add_pct = self.cachedMagicalDamageAddPct }
	end
	if self:IsSageCloak() then
		return { bonus_health = self.cachedBonusHealth }
	end
	return {}
end
function modifier_item_0334_thorn_shield.prototype.IsHidden(self)
	return true
end
function modifier_item_0334_thorn_shield.prototype.IsPurgable(self)
	return false
end
function modifier_item_0334_thorn_shield.prototype.OnDealDamage_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability then
		return
	end
	if self:IsDynamicSageItem() then
		return
	end
	if event.victim ~= parent then
		return
	end
	local shieldAbsorbedValue = math.max(0, event.shield_absorbed_value or 0)
	if shieldAbsorbedValue <= 0 then
		return
	end
	local ability_shield_damage_pct = ability:GetSpecialValueFor("ability_shield_damage_pct")
	if ability_shield_damage_pct <= 0 then
		return
	end
	local ability_radius = ability:GetSpecialValueFor("ability_radius")
	if ability_radius <= 0 then
		return
	end
	local damage = shieldAbsorbedValue * (ability_shield_damage_pct / 100)
	if damage <= 0 then
		return
	end
	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		parent:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	if #enemies <= 0 then
		return
	end
	self:PlayEffects(parent, ability_radius)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or enemy:IsBuilding() then
				goto __continue26
			end
			Damage:ApplyDamage({
				victim = enemy,
				attacker = parent,
				damage = damage,
				damage_type = 1,
				ability = ability,
			})
		end
		::__continue26::
	end
end
function modifier_item_0334_thorn_shield.prototype.PlayEffects(self, parent, radius)
	parent:EmitSound("Item.Lotus.Heal")
	local particle = MyGameHeroParticleManager:CreateParticle(
		"particles/neutral_fx/miniboss_dire_shield_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(particle, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
	MyGameHeroParticleManager:ReleaseParticleIndex(particle)
end
function modifier_item_0334_thorn_shield.prototype.IsSageBoots(self)
	local ____opt_0 = self:GetAbility()
	return (____opt_0 and ____opt_0:GetAbilityName()) == "item_0336"
end
function modifier_item_0334_thorn_shield.prototype.IsSageCloak(self)
	local ____opt_2 = self:GetAbility()
	return (____opt_2 and ____opt_2:GetAbilityName()) == "item_0335"
end
function modifier_item_0334_thorn_shield.prototype.IsDynamicSageItem(self)
	return self:IsSageBoots() or self:IsSageCloak()
end
function modifier_item_0334_thorn_shield.prototype.RecalculateDynamicBonus(self, forceRefresh)
	if self:IsSageBoots() then
		self:RecalculateMysticBonus(forceRefresh)
		return
	end
	if self:IsSageCloak() then
		self:RecalculateSageHealthBonus(forceRefresh)
	end
end
function modifier_item_0334_thorn_shield.prototype.RecalculateMysticBonus(self, forceRefresh)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local currentMana = math.max(0, parent:GetMana())
	local extraMana = math.max(0, currentMana - ITEM_0336_MANA_THRESHOLD)
	local magicalDamageAddPct = math.floor(extraMana / ITEM_0336_MANA_PER_MAGIC_DAMAGE_PCT)
	local manaChanged = math.abs(currentMana - self.cachedCurrentMana) > 0.01
	local bonusChanged = magicalDamageAddPct ~= self.cachedMagicalDamageAddPct
	if not forceRefresh and not manaChanged and not bonusChanged then
		return
	end
	self.cachedCurrentMana = currentMana
	self.cachedMagicalDamageAddPct = magicalDamageAddPct
	self:RefreshAttributes()
end
function modifier_item_0334_thorn_shield.prototype.RecalculateSageHealthBonus(self, forceRefresh)
	local parent = self:GetParent()
	if not IsValid(nil, parent) then
		return
	end
	local maxMana = math.max(0, MyGameAttribute:GetAttribute(parent, "total_mana") or parent:GetMaxMana())
	local bonusHealth = math.floor(maxMana)
	local manaChanged = math.abs(maxMana - self.cachedMaxMana) > 0.01
	local bonusChanged = bonusHealth ~= self.cachedBonusHealth
	if not forceRefresh and not manaChanged and not bonusChanged then
		return
	end
	self.cachedMaxMana = maxMana
	self.cachedBonusHealth = bonusHealth
	self:RefreshAttributes()
end
modifier_item_0334_thorn_shield = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0334_thorn_shield)
____exports.modifier_item_0334_thorn_shield = modifier_item_0334_thorn_shield
return ____exports