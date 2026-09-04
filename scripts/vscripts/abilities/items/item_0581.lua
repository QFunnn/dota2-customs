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
local VERDICT_CUSTOM_TAG = "item_0581_verdict"
____exports.item_0581 = __TS__Class()
local item_0581 = ____exports.item_0581
item_0581.name = "item_0581"
__TS__ClassExtends(item_0581, BaseItem_CS)
function item_0581.prototype.GetIntrinsicModifierName(self)
	return ____exports.modifier_item_0581.name
end
item_0581 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0581)
____exports.item_0581 = item_0581
--- 固有被动「审厄」：按目标身上负面状态数量，放大对其造成的伤害（直伤乘区 + DOT 追加）。
____exports.modifier_item_0581 = __TS__Class()
local modifier_item_0581 = ____exports.modifier_item_0581
modifier_item_0581.name = "modifier_item_0581"
__TS__ClassExtends(modifier_item_0581, BaseModifier_CS)
function modifier_item_0581.GetLocalizationCN(self)
	return { name = "审厄", description = "目标身上每有一个负面状态，对其造成的伤害越高。" }
end
function modifier_item_0581.prototype.DeclareEvents(self)
	return {
		BusinessEvents.ON_DAMAGE_PRE_APPLY_ATTACKER,
		{ event = BusinessEvents.ON_HP_LOSS, target = { scope = "global" } },
	}
end
function modifier_item_0581.prototype.IsHidden(self)
	return true
end
function modifier_item_0581.prototype.IsPurgable(self)
	return false
end
function modifier_item_0581.prototype.OnDamagePreApplyAttacker_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not ability or event.ctx.spec.attacker ~= parent then
		return
	end
	if CheckTag(nil, event.ctx.spec.damage_flag, ApplyDamageFlag.HP_LOSS) then
		return
	end
	local ____opt_0 = event.ctx.spec.source
	if (____opt_0 and ____opt_0.custom_tag) == VERDICT_CUSTOM_TAG then
		return
	end
	local victim = event.ctx.spec.victim
	if not victim or not IsValidAlive(nil, victim) or victim:IsBuilding() then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ampPct = self:GetVerdictAmpPct(victim, ability)
	if ampPct <= 0 then
		return
	end
	local ____event_final_2, ____mul_3 = event.final, "mul"
	if ____event_final_2[____mul_3] == nil then
		____event_final_2[____mul_3] = {}
	end
	local ____event_final_mul_4 = event.final.mul
	____event_final_mul_4[#____event_final_mul_4 + 1] = { value = 1 + ampPct / 100, source = "item_0581:审厄" }
end
function modifier_item_0581.prototype.OnHpLoss_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	local victim = event.victim
	if not victim or victim == parent or not IsValidAlive(nil, victim) then
		return
	end
	if victim:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	if victim:IsBuilding() then
		return
	end
	local source = event.source
	local isDotDamage = (source and source.debuff_status) == DebuffStatusType.BLEED
		or (source and source.debuff_status) == DebuffStatusType.POISON
		or (source and source.debuff_status) == DebuffStatusType.BURN
		or CheckTag(nil, source and source.damage_tags, DamageTag.DOT)
	if not isDotDamage then
		return
	end
	local dotDamage = math.max(0, event.final_damage or 0)
	if dotDamage <= 0 then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ampPct = self:GetVerdictAmpPct(victim, ability)
	if ampPct <= 0 then
		return
	end
	Damage:ApplyDamage({
		victim = victim,
		attacker = parent,
		damage = dotDamage * (ampPct / 100),
		damage_type = 4,
		ability = ability,
		extra_data = {
			damage_tags = DamageTag.NO_PROC,
			custom_tag = VERDICT_CUSTOM_TAG,
			source_name = "item_0581:审厄",
		},
	})
end
function modifier_item_0581.prototype.GetVerdictAmpPct(self, victim, ability)
	local perDebuff = math.max(0, ability:GetSpecialValueFor("ability_value_dmg_per_debuff"))
	if perDebuff <= 0 then
		return 0
	end
	local mods = victim:FindAllModifiers() or {}
	local count = 0
	for ____, m in ipairs(mods) do
		if m.IsDebuff and m:IsDebuff() then
			count = count + 1
		end
	end
	return count * perDebuff
end
modifier_item_0581 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0581)
____exports.modifier_item_0581 = modifier_item_0581
return ____exports