--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/items/item_flame_cloak.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/items/item_flame_cloak.lua",
	{
		["10"] = "36:7",
		["11"] = "1:1",
		["12"] = "1:10",
		["13"] = "1:52",
		["14"] = "3:1",
		["15"] = "3:10",
		["16"] = "3:27",
		["17"] = "4:1",
		["18"] = "4:10",
		["21"] = "10:1",
		["22"] = "11:14",
		["23"] = "10:1",
		["24"] = "11:31",
		["26"] = "11:39",
		["27"] = "20:5",
		["28"] = "10:1",
		["29"] = "12:5",
		["30"] = "13:9",
		["31"] = "12:5",
		["32"] = "16:5",
		["33"] = "17:9",
		["34"] = "16:5",
		["35"] = "22:5",
		["36"] = "23:9",
		["37"] = "24:9",
		["38"] = "22:5",
		["39"] = "27:5",
		["40"] = "28:13",
		["41"] = "29:13",
		["43"] = "31:9",
		["44"] = "27:5",
		["45"] = "11:14",
		["46"] = "10:2",
		["47"] = "10:2",
		["48"] = "10:2",
		["50"] = "10:2",
		["51"] = "11:14",
		["53"] = "11:14",
		["54"] = "36:7",
		["55"] = "35:1",
		["56"] = "36:36",
		["57"] = "37:5",
		["58"] = "38:9",
		["59"] = "37:5",
		["60"] = "41:5",
		["61"] = "42:9",
		["62"] = "41:5",
		["63"] = "45:5",
		["64"] = "46:9",
		["65"] = "45:5",
		["66"] = "49:5",
		["67"] = "50:9",
		["68"] = "49:5",
		["69"] = "53:5",
		["70"] = "54:9",
		["71"] = "53:5",
		["72"] = "57:5",
		["73"] = "58:14",
		["74"] = "58:37",
		["76"] = "59:9",
		["77"] = "57:5",
		["78"] = "62:5",
		["79"] = "63:9",
		["80"] = "62:5",
		["81"] = "66:5",
		["82"] = "67:9",
		["83"] = "66:5",
		["84"] = "70:5",
		["85"] = "71:9",
		["86"] = "70:5",
		["87"] = "74:5",
		["88"] = "75:9",
		["89"] = "74:5",
		["90"] = "78:5",
		["91"] = "79:9",
		["92"] = "78:5",
		["93"] = "82:5",
		["94"] = "83:9",
		["95"] = "82:5",
		["96"] = "36:7",
		["97"] = "35:2",
		["98"] = "35:2",
		["99"] = "35:19",
		["100"] = "35:2",
		["102"] = "35:2",
		["103"] = "36:7",
		["105"] = "88:7",
		["106"] = "87:1",
		["107"] = "88:42",
		["108"] = "89:5",
		["109"] = "90:9",
		["110"] = "89:5",
		["111"] = "93:5",
		["112"] = "94:16",
		["113"] = "94:16",
		["114"] = "94:16",
		["116"] = "94:9",
		["117"] = "93:5",
		["118"] = "99:5",
		["119"] = "100:9",
		["120"] = "99:5",
		["121"] = "105:5",
		["122"] = "107:14",
		["125"] = "108:9",
		["126"] = "109:9",
		["127"] = "105:5",
		["128"] = "112:5",
		["129"] = "113:9",
		["130"] = "112:5",
		["131"] = "118:5",
		["132"] = "119:15",
		["133"] = "120:13",
		["134"] = "121:13",
		["135"] = "123:13",
		["136"] = "124:13",
		["137"] = "125:13",
		["139"] = "127:13",
		["140"] = "128:13",
		["142"] = "131:15",
		["143"] = "132:13",
		["144"] = "133:15",
		["145"] = "134:13",
		["146"] = "135:19",
		["147"] = "136:13",
		["149"] = "138:9",
		["150"] = "139:26",
		["151"] = "139:27",
		["156"] = "139:9",
		["157"] = "118:5",
		["158"] = "142:5",
		["159"] = "143:14",
		["162"] = "144:9",
		["163"] = "145:15",
		["164"] = "146:15",
		["165"] = "147:13",
		["166"] = "148:13",
		["167"] = "149:17",
		["168"] = "150:17",
		["169"] = "151:17",
		["170"] = "152:17",
		["171"] = "153:17",
		["172"] = "148:25",
		["174"] = "142:5",
		["175"] = "88:7",
		["176"] = "87:2",
		["177"] = "87:2",
		["178"] = "87:19",
		["179"] = "87:2",
		["181"] = "87:2",
		["182"] = "88:7",
	}
)
local ____exports = {}
local sl_modifier_item_flame_cloak, sl_modifier_item_flame_burn_debuff
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifier_ItemIntrinsic = ____sl_modifier_base.SLModifier_ItemIntrinsic
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_item_base = require("abilities.items._sl_item_base")
local SLItemBase = _____sl_item_base.SLItemBase
--- 火焰斗篷
-- <h1>被动：生命之火</h1>每秒对敌军造成%damage%+%damage_hp_pct%%%装备者最大生命值的魔法伤害，并且使他们的物理攻击有%blind_pct%%%的几率不会命中。对幻象造成%illusion_hurted_pct%%%伤害。<br><br>如果装备者是幻象，则每秒造成%illusion_damage%+%illusion_damage_hp_pct%%%最大生命值的魔法伤害。<br><br>作用范围：%radius%
____exports.item_flame_cloak = __TS__Class()
local item_flame_cloak = ____exports.item_flame_cloak
item_flame_cloak.name = "item_flame_cloak"
__TS__ClassExtends(item_flame_cloak, SLItemBase)
function item_flame_cloak.prototype.____constructor(self, ...)
	SLItemBase.prototype.____constructor(self, ...)
	self._manual_toggle_state = false
end
function item_flame_cloak.prototype.GetIntrinsicModifierName(self)
	return sl_modifier_item_flame_cloak.name
end
function item_flame_cloak.prototype.GetAOERadius(self)
	return self:GetSpecialValueFor("radius")
end
function item_flame_cloak.prototype.OnSpellStart(self)
	self._manual_toggle_state = not self._manual_toggle_state
	self:SetSecondaryCharges(self._manual_toggle_state and 1 or 0)
end
function item_flame_cloak.prototype.GetAbilityTextureName(self)
	if self:GetSecondaryCharges() == 1 then
		return "item_flame_cloak_magic"
	end
	return "item_flame_cloak"
end
item_flame_cloak = __TS__Decorate({ registerAbility(nil, nil, getfenv()) }, item_flame_cloak)
____exports.item_flame_cloak = item_flame_cloak
sl_modifier_item_flame_cloak = __TS__Class()
sl_modifier_item_flame_cloak.name = "sl_modifier_item_flame_cloak"
__TS__ClassExtends(sl_modifier_item_flame_cloak, SLModifier_ItemIntrinsic)
function sl_modifier_item_flame_cloak.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end
function sl_modifier_item_flame_cloak.prototype.GetModifierBonusStats_Strength(self)
	return self:GetAbilitySpecialValueFor("bonus_strength")
end
function sl_modifier_item_flame_cloak.prototype.GetModifierPhysicalArmorBonus(self, event)
	return self:GetAbilitySpecialValueFor("bonus_armor")
end
function sl_modifier_item_flame_cloak.prototype.GetModifierConstantHealthRegen(self)
	return self:GetAbilitySpecialValueFor("bonus_regen")
end
function sl_modifier_item_flame_cloak.prototype.IsAura(self)
	return true
end
function sl_modifier_item_flame_cloak.prototype.GetAuraEntityReject(self, entity)
	if not self:IsLatestSource() then
		return true
	end
	return false
end
function sl_modifier_item_flame_cloak.prototype.GetAuraRadius(self)
	return self:GetAbilitySpecialValueFor("radius")
end
function sl_modifier_item_flame_cloak.prototype.GetAuraSearchTeam(self)
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end
function sl_modifier_item_flame_cloak.prototype.GetAuraSearchFlags(self)
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function sl_modifier_item_flame_cloak.prototype.GetAuraSearchType(self)
	return DOTA_UNIT_TARGET_HEROES_AND_CREEPS
end
function sl_modifier_item_flame_cloak.prototype.GetModifierAura(self)
	return sl_modifier_item_flame_burn_debuff.name
end
function sl_modifier_item_flame_cloak.prototype.GetAuraDuration(self)
	return 0.5
end
sl_modifier_item_flame_cloak = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_flame_cloak", nil, getfenv()) },
	sl_modifier_item_flame_cloak
)
sl_modifier_item_flame_burn_debuff = __TS__Class()
sl_modifier_item_flame_burn_debuff.name = "sl_modifier_item_flame_burn_debuff"
__TS__ClassExtends(sl_modifier_item_flame_burn_debuff, SLModifierBase_Debuff)
function sl_modifier_item_flame_burn_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_item_flame_burn_debuff.prototype.GetEffectName(self)
	local ____table_GetSecondaryCharges_result_0 = self:GetAbility()
	if ____table_GetSecondaryCharges_result_0 ~= nil then
		____table_GetSecondaryCharges_result_0 = ____table_GetSecondaryCharges_result_0:GetSecondaryCharges()
	end
	return ____table_GetSecondaryCharges_result_0 == 1 and ITEM_PARTICLES.item_flame_cloak_burn_magic_debuff
		or ITEM_PARTICLES.item_flame_cloak_burn_debuff
end
function sl_modifier_item_flame_burn_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_item_flame_burn_debuff.prototype.OnCreated(self, params)
	if not IsValid(self:GetAbility()) then
		return
	end
	self:_CalculateDamage()
	self:StartIntervalThink(1)
end
function sl_modifier_item_flame_burn_debuff.prototype.OnTooltip(self)
	return self._dmg
end
function sl_modifier_item_flame_burn_debuff.prototype._CalculateDamage(self)
	local caster = self:GetCaster()
	local dmg
	local dmg_hp_pct
	if caster:IsIllusion() then
		dmg = self:GetAbilitySpecialValueFor("illusion_damage")
		dmg_hp_pct = self:GetAbilitySpecialValueFor("illusion_damage_hp_pct")
	else
		dmg = self:GetAbilitySpecialValueFor("damage")
		dmg_hp_pct = self:GetAbilitySpecialValueFor("damage_hp_pct")
	end
	local caster_hp_max = caster:GetMaxHealth()
	local total_dmg = dmg + caster_hp_max * dmg_hp_pct * 0.01
	local parent = self:GetParent()
	if parent:IsIllusion() then
		local illusion_hurted_pct = self:GetAbilitySpecialValueFor("illusion_hurted_pct")
		total_dmg = total_dmg * (1 + illusion_hurted_pct * 0.01)
	end
	self._dmg = total_dmg
	local ____temp_2
	if self:GetAbility():GetSecondaryCharges() == 1 then
		____temp_2 = DAMAGE_TYPE_MAGICAL
	else
		____temp_2 = DAMAGE_TYPE_PHYSICAL
	end
	self._dmg_type = ____temp_2
end
function sl_modifier_item_flame_burn_debuff.prototype.OnIntervalThink(self)
	if not IsValid(self:GetAbility()) then
		return
	end
	self:_CalculateDamage()
	local caster = self:GetCaster()
	local parent = self:GetParent()
	if IsServer() then
		ApplyDamage({
			attacker = caster,
			victim = parent,
			damage = self._dmg,
			damage_type = self._dmg_type,
			ability = self:GetAbility(),
		})
	end
end
sl_modifier_item_flame_burn_debuff = __TS__Decorate(
	{ registerModifier(nil, "abilities/items/item_flame_cloak", nil, getfenv()) },
	sl_modifier_item_flame_burn_debuff
)
return ____exports