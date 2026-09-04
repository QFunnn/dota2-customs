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
____exports.item_0156 = __TS__Class()
local item_0156 = ____exports.item_0156
item_0156.name = "item_0156"
__TS__ClassExtends(item_0156, BaseItem_CS)
function item_0156.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_0156"
end
item_0156 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0156)
____exports.item_0156 = item_0156
____exports.modifier_item_0156 = __TS__Class()
local modifier_item_0156 = ____exports.modifier_item_0156
modifier_item_0156.name = "modifier_item_0156"
__TS__ClassExtends(modifier_item_0156, BaseModifier_CS)
function modifier_item_0156.prototype.DeclareEvents(self)
	return { { event = BusinessEvents.ON_UNIT_DEATH, target = { scope = "global" } } }
end
function modifier_item_0156.prototype.OnUnitDeath_CS(self, event)
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	if not ability then
		return
	end
	local ____event_entindex_attacker_0
	if event.entindex_attacker then
		____event_entindex_attacker_0 = EntIndexToHScript(event.entindex_attacker)
	else
		____event_entindex_attacker_0 = nil
	end
	local attacker = ____event_entindex_attacker_0
	local ____event_entindex_killed_1
	if event.entindex_killed then
		____event_entindex_killed_1 = EntIndexToHScript(event.entindex_killed)
	else
		____event_entindex_killed_1 = nil
	end
	local victim = ____event_entindex_killed_1
	if attacker ~= self:GetParent() then
		return
	end
	if not victim or not victim:IsBaseNPC() or victim:IsHero() or victim:IsBuilding() or victim:IsSummoned() then
		return
	end
	local ability_trigger_chance_pct = ability:GetSpecialValueFor("ability_trigger_chance_pct")
	local ability_bonus_gold = ability:GetSpecialValueFor("ability_bonus_gold")
	if RollPercentage(ability_trigger_chance_pct) then
		local player = MyGamePlayers:getPlayer(self:GetPlayerId())
		if player then
			player.knapsack:AddItemByName("item_gold", ability_bonus_gold)
			self:PlayEffects1(victim)
			Popups:addGold(victim, ability_bonus_gold)
		end
	end
end
function modifier_item_0156.prototype.PlayEffects1(self, victim)
	EmitSoundOn("DOTA_Item.Hand_Of_Midas", victim)
	local pfx = MyGameHeroParticleManager:CreateParticle(
		"particles/generic_gameplay/lasthit_coins.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		victim,
		self:GetParent()
	)
	MyGameHeroParticleManager:SetParticleControl(pfx, 1, victim:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(pfx)
end
modifier_item_0156 = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_0156)
____exports.modifier_item_0156 = modifier_item_0156
return ____exports