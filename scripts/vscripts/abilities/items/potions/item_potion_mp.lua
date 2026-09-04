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
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
--- 魔法芒果
-- 消耗品：使用后立即恢复50点魔法值
____exports.item_M005 = __TS__Class()
local item_M005 = ____exports.item_M005
item_M005.name = "item_M005"
__TS__ClassExtends(item_M005, BaseItem_CS)
function item_M005.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1.6,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local manaAmount = self:GetManaAmount()
			local maxMana = caster:GetMaxMana()
			caster:GiveMana(manaAmount + maxMana * 0.1)
			local effect = ParticleManager:CreateParticle(
				"particles/items3_fx/mango_active.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				caster
			)
			ParticleManager:ReleaseParticleIndex(effect)
			caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function item_M005.prototype.GetManaAmount(self)
	return self:GetSpecialValueFor("mp_amount")
end
item_M005 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M005)
____exports.item_M005 = item_M005
____exports.item_P004 = __TS__Class()
local item_P004 = ____exports.item_P004
item_P004.name = "item_P004"
__TS__ClassExtends(item_P004, BaseItem_CS)
function item_P004.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 0.8,
		ambientEffect = "particles/item/item_mana.vpcf",
		onSuccess = function()
			local caster = self:GetCaster()
			DebugPrint(nil, caster:GetUnitName())
			if not IsValidAlive(nil, caster) then
				return
			end
			local manaAmount = self:GetManaAmount() + self:GetMaxManaAmount() * caster:GetMaxMana() * 0.01
			caster:GiveMana(manaAmount)
			local effect = ParticleManager:CreateParticle(
				"particles/items3_fx/mango_active.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				caster
			)
			ParticleManager:ReleaseParticleIndex(effect)
			caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function item_P004.prototype.GetManaAmount(self)
	if not IsServer() then
		return 0
	end
	if not self then
		return 0
	end
	return self:GetSpecialValueFor("mp_amount") or 0
end
function item_P004.prototype.GetMaxManaAmount(self)
	return self:GetSpecialValueFor("mp_pct") or 0
end
item_P004 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P004)
____exports.item_P004 = item_P004
____exports.item_P005 = __TS__Class()
local item_P005 = ____exports.item_P005
item_P005.name = "item_P005"
__TS__ClassExtends(item_P005, ____exports.item_P004)
item_P005 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P005)
____exports.item_P005 = item_P005
____exports.item_P048 = __TS__Class()
local item_P048 = ____exports.item_P048
item_P048.name = "item_P048"
__TS__ClassExtends(item_P048, ____exports.item_P004)
item_P048 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P048)
____exports.item_P048 = item_P048
____exports.item_P101 = __TS__Class()
local item_P101 = ____exports.item_P101
item_P101.name = "item_P101"
__TS__ClassExtends(item_P101, ____exports.item_P004)
item_P101 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P101)
____exports.item_P101 = item_P101
____exports.item_P103 = __TS__Class()
local item_P103 = ____exports.item_P103
item_P103.name = "item_P103"
__TS__ClassExtends(item_P103, ____exports.item_P004)
item_P103 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P103)
____exports.item_P103 = item_P103
____exports.item_M007 = __TS__Class()
local item_M007 = ____exports.item_M007
item_M007.name = "item_M007"
__TS__ClassExtends(item_M007, ____exports.item_M005)
item_M007 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M007)
____exports.item_M007 = item_M007
return ____exports