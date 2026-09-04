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
____exports.item_0279 = __TS__Class()
local item_0279 = ____exports.item_0279
item_0279.name = "item_0279"
__TS__ClassExtends(item_0279, BaseItem_CS)
function item_0279.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0279_blood_sacrifice.name
end
item_0279 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0279)
____exports.item_0279 = item_0279
____exports.modifier_item_0279_blood_sacrifice = __TS__Class()
local modifier_item_0279_blood_sacrifice = ____exports.modifier_item_0279_blood_sacrifice
modifier_item_0279_blood_sacrifice.name = "modifier_item_0279_blood_sacrifice"
__TS__ClassExtends(modifier_item_0279_blood_sacrifice, BaseModifier_CS)
function modifier_item_0279_blood_sacrifice.prototype.IsHidden(self)
	return true
end
function modifier_item_0279_blood_sacrifice.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH_INTERCEPT, priority = DeathRevivePriority.EQUIPMENT } }
end
function modifier_item_0279_blood_sacrifice.prototype.OnUnitDeathIntercept_CS(self, event)
	if not IsServer() then
		return
	end
	if event.prevented then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not ability then
		return
	end
	if event.victim ~= parent then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	if parent:HasModifier("modifier_generic_fake_death") then
		return
	end
	local ability_revive_delay = ability:GetSpecialValue("item_0279", "ability_revive_delay")
	local ability_value_restore_pct = ability:GetSpecialValue("item_0279", "ability_value_restore_pct")
	local ability_cooldown = ability:GetSpecialValue("item_0279", "ability_cooldown")
	event.prevented = true
	event.handled_by = self:GetName()
	event.intercept_type = "fake_death"
	event.set_health = 1
	if ability_cooldown > 0 then
		ability:StartCooldown(ability_cooldown)
	end
	parent:AddNewModifier(
		parent,
		ability,
		"modifier_generic_fake_death",
		{ duration = math.max(0.1, ability_revive_delay) }
	)
	local effect = MyGameHeroParticleManager:CreateParticle(
		"particles/econ/items/wraith_king/wraith_king_arcana/wk_arc_style2_reincarn_tombstone.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent,
		parent
	)
	MyGameHeroParticleManager:SetParticleControl(effect, 0, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(effect, 1, parent:GetAbsOrigin())
	MyGameHeroParticleManager:SetParticleControl(effect, 2, parent:GetAbsOrigin())
	Timers:CreateTimer(math.max(0.1, ability_revive_delay + FrameTime()), function()
		MyGameHeroParticleManager:DestroyParticle(effect, false)
		MyGameHeroParticleManager:ReleaseParticleIndex(effect)
		if not IsValid(nil, parent) then
			return
		end
		local maxHp = parent:GetMaxHealth()
		local maxMana = parent:GetMaxMana()
		local hp = math.max(1, maxHp * (ability_value_restore_pct / 100))
		local mana = math.max(0, maxMana * (ability_value_restore_pct / 100))
		parent:SetHealth(hp)
		parent:SetMana(mana)
		local effect2 = MyGameHeroParticleManager:CreateParticle(
			"particles/items_fx/aegis_respawn.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			parent,
			parent
		)
		MyGameHeroParticleManager:SetParticleControl(effect2, 0, parent:GetAbsOrigin())
		MyGameHeroParticleManager:SetParticleControl(effect2, 1, parent:GetAbsOrigin())
		MyGameHeroParticleManager:SetParticleControl(effect2, 2, parent:GetAbsOrigin())
		MyGameHeroParticleManager:ReleaseParticleIndex(effect2)
	end)
end
modifier_item_0279_blood_sacrifice = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0279_blood_sacrifice)
____exports.modifier_item_0279_blood_sacrifice = modifier_item_0279_blood_sacrifice
return ____exports