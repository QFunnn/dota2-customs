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
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
____exports.item_M207 = __TS__Class()
local item_M207 = ____exports.item_M207
item_M207.name = "item_M207"
__TS__ClassExtends(item_M207, BaseItem_CS)
function item_M207.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		duration = 1,
		castAnimation = ACT_DOTA_GENERIC_CHANNEL_1,
		onSuccess = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			caster:AddNewModifier(
				caster,
				self,
				____exports.modifier_item_M207.name,
				{ duration = self:GetBuffDuration() }
			)
			caster:CustomHeal(caster:GetMaxHealth(), { ability = self, source = "item" })
			caster:GiveMana(caster:GetMaxMana())
			local healEffect = ParticleManager:CreateParticle(
				"particles/items3_fx/fish_bones_active.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				caster
			)
			ParticleManager:ReleaseParticleIndex(healEffect)
			local manaEffect = ParticleManager:CreateParticle(
				"particles/items3_fx/mango_active.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				caster
			)
			ParticleManager:ReleaseParticleIndex(manaEffect)
			caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
			self:CostItemCharge(1)
		end,
		onInterrupted = function() end,
	}
end
function item_M207.prototype.GetBuffDuration(self)
	return 600
end
function item_M207.prototype.GetTextureName(self)
	return "item_use_mushroom_brown_glow"
end
item_M207 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M207)
____exports.item_M207 = item_M207
____exports.modifier_item_M207 = __TS__Class()
local modifier_item_M207 = ____exports.modifier_item_M207
modifier_item_M207.name = "modifier_item_M207"
__TS__ClassExtends(modifier_item_M207, BaseModifier_CS)
function modifier_item_M207.prototype.GetAttributeBonus(self)
	return { bonus_all_stats = 10 }
end
function modifier_item_M207.prototype.GetEffectName(self)
	return "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_halo_buff.vpcf"
end
modifier_item_M207 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_M207)
____exports.modifier_item_M207 = modifier_item_M207
return ____exports