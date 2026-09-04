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
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.modifier_axe_tag_001 = __TS__Class()
local modifier_axe_tag_001 = ____exports.modifier_axe_tag_001
modifier_axe_tag_001.name = "modifier_axe_tag_001"
__TS__ClassExtends(modifier_axe_tag_001, BaseHeroModifier)
function modifier_axe_tag_001.prototype.IsHidden(self)
	return false
end
function modifier_axe_tag_001.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	DebugPrint(nil, "modifier_axe_tag_001 OnCreated")
end
function modifier_axe_tag_001.prototype.GetTagModifierRules(self)
	return {
		{
			id = "axe_tag_001",
			statKey = 13,
			op = 2,
			value = 5,
			requireAbilityName = "lina_001",
		},
	}
end
modifier_axe_tag_001 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_axe_tag_001)
____exports.modifier_axe_tag_001 = modifier_axe_tag_001
return ____exports