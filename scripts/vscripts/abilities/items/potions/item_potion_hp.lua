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
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local BaseModifier = ____dota_ts_adapter.BaseModifier
--- 仙灵之火
-- 消耗品：使用后立即恢复100点生命值
____exports.item_M004 = __TS__Class()
local item_M004 = ____exports.item_M004
item_M004.name = "item_M004"
__TS__ClassExtends(item_M004, BaseItem_CS)
function item_M004.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1.6,
		castAnimation = -1,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local healAmount = self:GetHealAmount()
			local maxHp = caster:GetMaxHealth()
			caster:CustomHeal(healAmount + maxHp * self:GetMaxHpAmount() * 0.01, { ability = self, source = "item" })
			local effect = ParticleManager:CreateParticle(
				"particles/items3_fx/fish_bones_active.vpcf",
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
function item_M004.prototype.GetHealAmount(self)
	if IsValid(nil, self) then
		return self:GetSpecialValueFor("heal_amount")
	end
	return 0
end
function item_M004.prototype.GetMaxHpAmount(self)
	return self:GetSpecialValueFor("heal_pct") or 0
end
item_M004 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M004)
____exports.item_M004 = item_M004
____exports.item_P000 = __TS__Class()
local item_P000 = ____exports.item_P000
item_P000.name = "item_P000"
__TS__ClassExtends(item_P000, BaseItem_CS)
function item_P000.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 0.8,
		castAnimation = -1,
		ambientEffect = "particles/item/item_heal.vpcf",
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local healAmount = self:GetHealAmount()
			local maxHp = caster:GetMaxHealth()
			caster:CustomHeal(healAmount + maxHp * self:GetMaxHpAmount() * 0.01, { ability = self, source = "item" })
			local effect = ParticleManager:CreateParticle(
				"particles/items3_fx/fish_bones_active.vpcf",
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
function item_P000.prototype.GetHealAmount(self)
	return self:GetSpecialValueFor("heal_amount")
end
function item_P000.prototype.GetMaxHpAmount(self)
	return self:GetSpecialValueFor("heal_pct") or 0
end
item_P000 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P000)
____exports.item_P000 = item_P000
____exports.item_P001 = __TS__Class()
local item_P001 = ____exports.item_P001
item_P001.name = "item_P001"
__TS__ClassExtends(item_P001, ____exports.item_P000)
item_P001 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P001)
____exports.item_P001 = item_P001
____exports.item_P002 = __TS__Class()
local item_P002 = ____exports.item_P002
item_P002.name = "item_P002"
__TS__ClassExtends(item_P002, ____exports.item_P000)
item_P002 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P002)
____exports.item_P002 = item_P002
____exports.item_P003 = __TS__Class()
local item_P003 = ____exports.item_P003
item_P003.name = "item_P003"
__TS__ClassExtends(item_P003, ____exports.item_P000)
item_P003 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P003)
____exports.item_P003 = item_P003
____exports.item_P102 = __TS__Class()
local item_P102 = ____exports.item_P102
item_P102.name = "item_P102"
__TS__ClassExtends(item_P102, ____exports.item_P000)
item_P102 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P102)
____exports.item_P102 = item_P102
____exports.item_M006 = __TS__Class()
local item_M006 = ____exports.item_M006
item_M006.name = "item_M006"
__TS__ClassExtends(item_M006, ____exports.item_M004)
item_M006 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M006)
____exports.item_M006 = item_M006
____exports.item_M014 = __TS__Class()
local item_M014 = ____exports.item_M014
item_M014.name = "item_M014"
__TS__ClassExtends(item_M014, ____exports.item_M004)
item_M014 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M014)
____exports.item_M014 = item_M014
____exports.item_M112 = __TS__Class()
local item_M112 = ____exports.item_M112
item_M112.name = "item_M112"
__TS__ClassExtends(item_M112, ____exports.item_M004)
function item_M112.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1.6,
		castAnimation = -1,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local healAmount = self:GetHealAmount()
			local maxHp = caster:GetMaxHealth()
			caster:CustomHeal(healAmount + maxHp * self:GetMaxHpAmount() * 0.01, { ability = self, source = "item" })
			local effect = ParticleManager:CreateParticle(
				"particles/items3_fx/fish_bones_active.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				caster
			)
			____exports.modifier_item_M112_buff:applys(caster, caster, self, { duration = 50 })
			ParticleManager:ReleaseParticleIndex(effect)
			caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
item_M112 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M112)
____exports.item_M112 = item_M112
____exports.item_M314 = __TS__Class()
local item_M314 = ____exports.item_M314
item_M314.name = "item_M314"
__TS__ClassExtends(item_M314, ____exports.item_M004)
item_M314 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M314)
____exports.item_M314 = item_M314
____exports.item_M225 = __TS__Class()
local item_M225 = ____exports.item_M225
item_M225.name = "item_M225"
__TS__ClassExtends(item_M225, ____exports.item_M004)
function item_M225.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 0.5,
		castAnimation = -1,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:RemovePoisonModifiers(caster)
			local healAmount = self:GetHealAmount()
			local maxHp = caster:GetMaxHealth()
			caster:CustomHeal(healAmount + maxHp * self:GetMaxHpAmount() * 0.01, { ability = self, source = "item" })
			local effect = ParticleManager:CreateParticle(
				"particles/items3_fx/fish_bones_active.vpcf",
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
function item_M225.prototype.RemovePoisonModifiers(self, caster)
	if not caster.FindAllModifiers then
		return
	end
	local modifiers = caster:FindAllModifiers()
	for ____, modifier in ipairs(modifiers) do
		do
			if modifier:GetName() ~= "modifier_generic_poison" then
				goto __continue25
			end
			modifier:Destroy()
		end
		::__continue25::
	end
end
item_M225 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M225)
____exports.item_M225 = item_M225
____exports.modifier_item_M112_buff = __TS__Class()
local modifier_item_M112_buff = ____exports.modifier_item_M112_buff
modifier_item_M112_buff.name = "modifier_item_M112_buff"
__TS__ClassExtends(modifier_item_M112_buff, BaseModifier)
function modifier_item_M112_buff.GetLocalizationCN(self)
	return { name = "发光", description = "在黑暗环境中身上会发光。" }
end
function modifier_item_M112_buff.prototype.GetTexture(self)
	return "item_material_m300_extract_flask"
end
modifier_item_M112_buff = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_M112_buff)
____exports.modifier_item_M112_buff = modifier_item_M112_buff
return ____exports