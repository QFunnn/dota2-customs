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
local FindEnemies = ____item_0409_shared.FindEnemies
local IsValidEnemyUnit = ____item_0409_shared.IsValidEnemyUnit
local StartAbilityCooldown = ____item_0409_shared.StartAbilityCooldown
____exports.item_0424 = __TS__Class()
local item_0424 = ____exports.item_0424
item_0424.name = "item_0424"
__TS__ClassExtends(item_0424, BaseItem_CS)
function item_0424.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/items3_fx/lotus_orb_reflect.vpcf", context)
	PrecacheResource("particle", "particles/neutral_fx/miniboss_dire_shield_hit.vpcf", context)
end
function item_0424.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		canCast = function()
			local caster = self:GetCaster()
			local modifier = caster and caster:FindModifierByName(____exports.modifier_item_0424_thorn_energy.name)
			local ____temp_2
			if modifier and modifier:GetStoredEnergy() > 0 then
				____temp_2 = UF_SUCCESS
			else
				____temp_2 = UF_FAIL_CUSTOM
			end
			return ____temp_2
		end,
		castError = function()
			return "#dota_hud_error_ability_inactive"
		end,
	}
end
function item_0424.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0424_thorn_energy.name
end
function item_0424.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local modifier = caster:FindModifierByName(____exports.modifier_item_0424_thorn_energy.name)
	if modifier and modifier:ReleaseStoredEnergy() then
		StartAbilityCooldown(nil, self, 4)
	end
end
item_0424 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0424)
____exports.item_0424 = item_0424
____exports.modifier_item_0424_thorn_energy = __TS__Class()
local modifier_item_0424_thorn_energy = ____exports.modifier_item_0424_thorn_energy
modifier_item_0424_thorn_energy.name = "modifier_item_0424_thorn_energy"
__TS__ClassExtends(modifier_item_0424_thorn_energy, BaseModifier_CS)
function modifier_item_0424_thorn_energy.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.storedEnergy = 0
end
function modifier_item_0424_thorn_energy.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_DEAL_DAMAGE, BusinessEvents.ON_TAKE_DAMAGE }
end
function modifier_item_0424_thorn_energy.prototype.IsPurgable(self)
	return false
end
function modifier_item_0424_thorn_energy.prototype.IsHidden(self)
	return self:GetStoredEnergy() <= 0
end
function modifier_item_0424_thorn_energy.GetLocalizationCN(self)
	return { name = "棘冠", description = "护盾吸收伤害时存储棘能。" }
end
function modifier_item_0424_thorn_energy.prototype.GetStoredEnergy(self)
	return math.max(self.storedEnergy, self:GetStackCount())
end
function modifier_item_0424_thorn_energy.prototype.OnDealDamage_CS(self, event)
	self:TryStoreThornEnergy(event)
end
function modifier_item_0424_thorn_energy.prototype.OnTakeDamage_CS(self, event)
	self:TryStoreThornEnergy(event)
end
function modifier_item_0424_thorn_energy.prototype.TryStoreThornEnergy(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or event.victim ~= parent then
		return
	end
	local shieldAbsorbed = math.max(0, event.shield_absorbed_value or 0)
	if shieldAbsorbed <= 0 then
		return
	end
	local ability_value_store_pct = math.max(0, ability:GetSpecialValueFor("ability_value_store_pct"))
	self:StoreEnergy(shieldAbsorbed * (ability_value_store_pct / 100))
end
function modifier_item_0424_thorn_energy.prototype.StoreEnergy(self, amount)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) or amount <= 0 then
		return
	end
	local cap = self:GetEnergyCap(parent, ability)
	if cap <= 0 then
		return
	end
	self.storedEnergy = math.min(cap, self:GetStoredEnergy() + amount)
	self:SetStackCount(math.floor(self.storedEnergy))
end
function modifier_item_0424_thorn_energy.prototype.ReleaseStoredEnergy(self)
	if not IsServer() then
		return false
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or not IsValidAlive(nil, parent) then
		return false
	end
	local damagePool = self:GetStoredEnergy()
	if damagePool <= 0 then
		return false
	end
	local ability_radius = math.max(0, ability:GetSpecialValueFor("ability_radius"))
	local ability_value_damage_pct = math.max(0, ability:GetSpecialValueFor("ability_value_damage_pct"))
	if ability_radius <= 0 or ability_value_damage_pct <= 0 then
		return false
	end
	local damage = damagePool * (ability_value_damage_pct / 100)
	self.storedEnergy = 0
	self:SetStackCount(0)
	local ability_shield_loss_duration = math.max(0, ability:GetSpecialValueFor("ability_shield_loss_duration"))
	if ability_shield_loss_duration > 0 then
		____exports.modifier_item_0424_shield_loss:applys(
			parent,
			parent,
			ability,
			{ duration = ability_shield_loss_duration }
		)
	end
	self:PlayEffects1(parent, ability_radius)
	for ____, enemy in ipairs(FindEnemies(nil, parent, parent:GetAbsOrigin(), ability_radius)) do
		do
			if not IsValidEnemyUnit(nil, parent, enemy) then
				goto __continue32
			end
			Damage:ApplyDamage({
				attacker = parent,
				victim = enemy,
				damage = damage,
				damage_type = 1,
				ability = ability,
				extra_data = {
					custom_tag = "item_0424_thorn_energy",
					source_name = self:GetName(),
				},
			})
		end
		::__continue32::
	end
	return true
end
function modifier_item_0424_thorn_energy.prototype.GetEnergyCap(self, parent, ability)
	local ability_value_charge_max_health_pct =
		math.max(0, ability:GetSpecialValueFor("ability_value_charge_max_health_pct"))
	local ability_max_health =
		math.max(0, MyGameAttribute:GetAttribute(parent, "total_health") or parent:GetMaxHealth())
	return ability_max_health * (ability_value_charge_max_health_pct / 100)
end
function modifier_item_0424_thorn_energy.prototype.PlayEffects1(self, parent, ability_radius)
	EmitSoundOn("DOTA_Item.BladeMail.Damage", parent)
	local reflectParticle = MyGameHeroParticleManager:CreateParticle(
		"particles/items3_fx/lotus_orb_reflect.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControlEnt(
		reflectParticle,
		0,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		nil,
		parent:GetAbsOrigin(),
		true
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(reflectParticle)
	local pulseParticle = MyGameHeroParticleManager:CreateParticle(
		"particles/neutral_fx/miniboss_dire_shield_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(pulseParticle, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(
		pulseParticle,
		1,
		Vector(ability_radius, ability_radius, ability_radius)
	)
	MyGameHeroParticleManager:ReleaseParticleIndex(pulseParticle)
end
modifier_item_0424_thorn_energy = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0424_thorn_energy)
____exports.modifier_item_0424_thorn_energy = modifier_item_0424_thorn_energy
--- 棘能释放的代价：每 0.5s 损失最大护盾值的 ability_shield_loss_pct%（属性直改，不产生伤害事件，不会回喂棘能）。
local SHIELD_LOSS_TICK_INTERVAL = 0.5
____exports.modifier_item_0424_shield_loss = __TS__Class()
local modifier_item_0424_shield_loss = ____exports.modifier_item_0424_shield_loss
modifier_item_0424_shield_loss.name = "modifier_item_0424_shield_loss"
__TS__ClassExtends(modifier_item_0424_shield_loss, BaseModifier_CS)
function modifier_item_0424_shield_loss.GetLocalizationCN(self)
	return { name = "棘能外泄", description = "每0.5秒损失最大护盾值的一部分。" }
end
function modifier_item_0424_shield_loss.prototype.GetModifierConfig(self)
	return { isHidden = false, isDebuff = true, isPurgable = false }
end
function modifier_item_0424_shield_loss.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(SHIELD_LOSS_TICK_INTERVAL)
end
function modifier_item_0424_shield_loss.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		self:Destroy()
		return
	end
	local ability_shield_loss_pct = math.max(0, ability:GetSpecialValueFor("ability_shield_loss_pct"))
	if ability_shield_loss_pct <= 0 then
		return
	end
	local totalShield = parent:GetTotalEnergyShield()
	if totalShield <= 0 then
		return
	end
	local shieldBefore = parent:GetCurrentEnergyShield()
	parent:AddCurrentEnergyShield(-totalShield * (ability_shield_loss_pct / 100))
	local actualLoss = math.max(0, shieldBefore - parent:GetCurrentEnergyShield())
	if actualLoss > 0 then
		local ability_value_store_pct = math.max(0, ability:GetSpecialValueFor("ability_value_store_pct"))
		local thorn = parent:FindModifierByName(____exports.modifier_item_0424_thorn_energy.name)
		if thorn ~= nil then
			thorn:StoreEnergy(actualLoss * (ability_value_store_pct / 100))
		end
	end
end
modifier_item_0424_shield_loss = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0424_shield_loss)
____exports.modifier_item_0424_shield_loss = modifier_item_0424_shield_loss
return ____exports