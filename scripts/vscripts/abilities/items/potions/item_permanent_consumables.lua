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
local getPermanentItemMaxUses, ITEM_P220_BUFF_DURATION, ITEM_P220_BONUS_MOVESPEED_PCT, ITEM_P220_SUCCESS_MESSAGE, ITEM_P220_REPEAT_SUCCESS_MESSAGE, ITEM_P221_BUFF_DURATION, ITEM_P221_BUFF_PARTICLE, ITEM_P221_SUCCESS_MESSAGE, ITEM_P221_REPEAT_SUCCESS_MESSAGE, ITEM_P222_BUFF_DURATION, ITEM_P222_EVASION_PCT, ITEM_P222_SUCCESS_MESSAGE, ITEM_P222_REPEAT_SUCCESS_MESSAGE, ITEM_P223_BUFF_DURATION, ITEM_P223_BASE_ATTACK_DAMAGE_PERCENT, ITEM_P223_SUCCESS_MESSAGE, ITEM_P223_REPEAT_SUCCESS_MESSAGE
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
function getPermanentItemMaxUses(self, itemId)
	local rulesetItem = MyGameRulesetManager and MyGameRulesetManager:GetPotionConfig(itemId)
		or MyGameRulesetManager and MyGameRulesetManager:GetCommonItemConfig(itemId)
	local ____tonumber_70 = tonumber
	local ____rulesetItem_69
	if rulesetItem then
		____rulesetItem_69 = rulesetItem.use_max
	else
		local ____opt_67 = GetAbilityKeyValuesByName(itemId)
		____rulesetItem_69 = ____opt_67 and ____opt_67.use_max
	end
	local rawMaxUses = ____tonumber_70(____rulesetItem_69) or 0
	return math.max(1, math.floor(rawMaxUses))
end
local BasePermanentConsumableItem_CS = __TS__Class()
BasePermanentConsumableItem_CS.name = "BasePermanentConsumableItem_CS"
__TS__ClassExtends(BasePermanentConsumableItem_CS, BaseItem_CS)
function BasePermanentConsumableItem_CS.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		allowContinuousUse = true,
		duration = 1.6,
		castAnimation = -1,
		canCast = function()
			local ____opt_0 = self:getPermanentItemSystem()
			local result = ____opt_0 and ____opt_0:canConsumeItem(self.permanentItemId)
			local ____result_ok_4
			if result and result.ok then
				____result_ok_4 = UF_SUCCESS
			else
				____result_ok_4 = UF_FAIL_CUSTOM
			end
			return ____result_ok_4
		end,
		castError = function()
			local ____opt_5 = self:getPermanentItemSystem()
			return ____opt_5 and ____opt_5:canConsumeItem(self.permanentItemId).reason or "当前无法使用"
		end,
		onSuccess = function()
			self:onPermanentItemConsumed()
		end,
		onInterrupted = function() end,
	}
end
function BasePermanentConsumableItem_CS.prototype.onPermanentItemConsumed(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____opt_7 = self:getPermanentItemSystem()
	local result = ____opt_7 and ____opt_7:consumeItem(self.permanentItemId)
	if not (result and result.ok) then
		ErrorMsg(nil, caster:GetPlayerId(), result and result.reason or "当前无法使用")
		return
	end
	local particle =
		ParticleManager:CreateParticle("particles/items3_fx/fish_bones_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle)
	caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
	SuccessMsg(nil, caster:GetPlayerId(), result.successMessage or "使用成功")
	self:consumeCurrentItem()
end
function BasePermanentConsumableItem_CS.prototype.getPermanentItemSystem(self)
	local ____opt_13 = self:GetCaster()
	local playerId = ____opt_13 and ____opt_13:GetPlayerId()
	if playerId == nil or playerId < 0 then
		return nil
	end
	local ____opt_15 = MyGamePlayers:getPlayer(playerId)
	return ____opt_15 and ____opt_15.permanentItems
end
function BasePermanentConsumableItem_CS.prototype.consumeCurrentItem(self)
	local caster = self:GetCaster()
	local playerId = caster and caster:GetPlayerId()
	if playerId ~= nil and playerId >= 0 then
		local player = MyGamePlayers:getPlayer(playerId)
		if player and player:CostItemToIndex(self:entindex(), 1) then
			return
		end
	end
	self:CostItemCharge(1)
end
____exports.item_M500 = __TS__Class()
local item_M500 = ____exports.item_M500
item_M500.name = "item_M500"
__TS__ClassExtends(item_M500, BasePermanentConsumableItem_CS)
function item_M500.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_M500"
end
item_M500 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M500)
____exports.item_M500 = item_M500
____exports.item_M505 = __TS__Class()
local item_M505 = ____exports.item_M505
item_M505.name = "item_M505"
__TS__ClassExtends(item_M505, BasePermanentConsumableItem_CS)
function item_M505.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_M505"
end
item_M505 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M505)
____exports.item_M505 = item_M505
____exports.item_M506 = __TS__Class()
local item_M506 = ____exports.item_M506
item_M506.name = "item_M506"
__TS__ClassExtends(item_M506, BasePermanentConsumableItem_CS)
function item_M506.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_M506"
end
item_M506 = __TS__DecorateLegacy({ registerAbility(nil) }, item_M506)
____exports.item_M506 = item_M506
____exports.item_P150 = __TS__Class()
local item_P150 = ____exports.item_P150
item_P150.name = "item_P150"
__TS__ClassExtends(item_P150, BasePermanentConsumableItem_CS)
function item_P150.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P150"
end
item_P150 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P150)
____exports.item_P150 = item_P150
____exports.item_P151 = __TS__Class()
local item_P151 = ____exports.item_P151
item_P151.name = "item_P151"
__TS__ClassExtends(item_P151, BasePermanentConsumableItem_CS)
function item_P151.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P151"
end
item_P151 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P151)
____exports.item_P151 = item_P151
____exports.item_P152 = __TS__Class()
local item_P152 = ____exports.item_P152
item_P152.name = "item_P152"
__TS__ClassExtends(item_P152, BasePermanentConsumableItem_CS)
function item_P152.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P152"
end
item_P152 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P152)
____exports.item_P152 = item_P152
____exports.item_P153 = __TS__Class()
local item_P153 = ____exports.item_P153
item_P153.name = "item_P153"
__TS__ClassExtends(item_P153, BasePermanentConsumableItem_CS)
function item_P153.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P153"
end
item_P153 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P153)
____exports.item_P153 = item_P153
____exports.item_P154 = __TS__Class()
local item_P154 = ____exports.item_P154
item_P154.name = "item_P154"
__TS__ClassExtends(item_P154, BasePermanentConsumableItem_CS)
function item_P154.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P154"
end
item_P154 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P154)
____exports.item_P154 = item_P154
____exports.item_P155 = __TS__Class()
local item_P155 = ____exports.item_P155
item_P155.name = "item_P155"
__TS__ClassExtends(item_P155, BasePermanentConsumableItem_CS)
function item_P155.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P155"
end
item_P155 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P155)
____exports.item_P155 = item_P155
____exports.item_P156 = __TS__Class()
local item_P156 = ____exports.item_P156
item_P156.name = "item_P156"
__TS__ClassExtends(item_P156, BasePermanentConsumableItem_CS)
function item_P156.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P156"
end
item_P156 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P156)
____exports.item_P156 = item_P156
____exports.item_P157 = __TS__Class()
local item_P157 = ____exports.item_P157
item_P157.name = "item_P157"
__TS__ClassExtends(item_P157, BasePermanentConsumableItem_CS)
function item_P157.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P157"
end
item_P157 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P157)
____exports.item_P157 = item_P157
____exports.item_P158 = __TS__Class()
local item_P158 = ____exports.item_P158
item_P158.name = "item_P158"
__TS__ClassExtends(item_P158, BasePermanentConsumableItem_CS)
function item_P158.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P158"
end
item_P158 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P158)
____exports.item_P158 = item_P158
____exports.item_P159 = __TS__Class()
local item_P159 = ____exports.item_P159
item_P159.name = "item_P159"
__TS__ClassExtends(item_P159, BasePermanentConsumableItem_CS)
function item_P159.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P159"
end
item_P159 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P159)
____exports.item_P159 = item_P159
____exports.item_P160 = __TS__Class()
local item_P160 = ____exports.item_P160
item_P160.name = "item_P160"
__TS__ClassExtends(item_P160, BasePermanentConsumableItem_CS)
function item_P160.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P160"
end
item_P160 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P160)
____exports.item_P160 = item_P160
____exports.item_P200 = __TS__Class()
local item_P200 = ____exports.item_P200
item_P200.name = "item_P200"
__TS__ClassExtends(item_P200, BasePermanentConsumableItem_CS)
function item_P200.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P200"
end
item_P200 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P200)
____exports.item_P200 = item_P200
____exports.item_P201 = __TS__Class()
local item_P201 = ____exports.item_P201
item_P201.name = "item_P201"
__TS__ClassExtends(item_P201, BasePermanentConsumableItem_CS)
function item_P201.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P201"
end
item_P201 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P201)
____exports.item_P201 = item_P201
____exports.item_P202 = __TS__Class()
local item_P202 = ____exports.item_P202
item_P202.name = "item_P202"
__TS__ClassExtends(item_P202, BasePermanentConsumableItem_CS)
function item_P202.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P202"
end
item_P202 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P202)
____exports.item_P202 = item_P202
____exports.item_P203 = __TS__Class()
local item_P203 = ____exports.item_P203
item_P203.name = "item_P203"
__TS__ClassExtends(item_P203, BasePermanentConsumableItem_CS)
function item_P203.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P203"
end
item_P203 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P203)
____exports.item_P203 = item_P203
____exports.item_P204 = __TS__Class()
local item_P204 = ____exports.item_P204
item_P204.name = "item_P204"
__TS__ClassExtends(item_P204, BasePermanentConsumableItem_CS)
function item_P204.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P204"
end
item_P204 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P204)
____exports.item_P204 = item_P204
____exports.item_P205 = __TS__Class()
local item_P205 = ____exports.item_P205
item_P205.name = "item_P205"
__TS__ClassExtends(item_P205, BasePermanentConsumableItem_CS)
function item_P205.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P205"
end
item_P205 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P205)
____exports.item_P205 = item_P205
____exports.item_P206 = __TS__Class()
local item_P206 = ____exports.item_P206
item_P206.name = "item_P206"
__TS__ClassExtends(item_P206, BasePermanentConsumableItem_CS)
function item_P206.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P206"
end
item_P206 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P206)
____exports.item_P206 = item_P206
____exports.item_P207 = __TS__Class()
local item_P207 = ____exports.item_P207
item_P207.name = "item_P207"
__TS__ClassExtends(item_P207, BasePermanentConsumableItem_CS)
function item_P207.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P207"
end
item_P207 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P207)
____exports.item_P207 = item_P207
____exports.item_P208 = __TS__Class()
local item_P208 = ____exports.item_P208
item_P208.name = "item_P208"
__TS__ClassExtends(item_P208, BasePermanentConsumableItem_CS)
function item_P208.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P208"
end
item_P208 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P208)
____exports.item_P208 = item_P208
____exports.item_P220 = __TS__Class()
local item_P220 = ____exports.item_P220
item_P220.name = "item_P220"
__TS__ClassExtends(item_P220, BaseItem_CS)
function item_P220.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		allowContinuousUse = true,
		duration = 1.6,
		castAnimation = -1,
		canCast = function()
			local ____table_canUseCocktail_result_ok_21
			if self:canUseCocktail().ok then
				____table_canUseCocktail_result_ok_21 = UF_SUCCESS
			else
				____table_canUseCocktail_result_ok_21 = UF_FAIL_CUSTOM
			end
			return ____table_canUseCocktail_result_ok_21
		end,
		castError = function()
			return self:canUseCocktail().reason or "当前无法使用"
		end,
		onSuccess = function()
			self:onCocktailConsumed()
		end,
		onInterrupted = function() end,
	}
end
function item_P220.prototype.canUseCocktail(self)
	local player = self:getCustomPlayer()
	if not (player and player:IsSaveLoadedComplete()) then
		return { ok = false, reason = "存档尚未加载完成" }
	end
	if not player:GetHero() then
		return { ok = false, reason = "英雄未就绪" }
	end
	return { ok = true }
end
function item_P220.prototype.onCocktailConsumed(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local permanentItemSystem = self:getPermanentItemSystem()
	local usedCount = permanentItemSystem and permanentItemSystem:getUsedCount("item_P220") or 0
	local successMessage = ITEM_P220_REPEAT_SUCCESS_MESSAGE
	if usedCount < getPermanentItemMaxUses(nil, "item_P220") then
		local consumeResult = permanentItemSystem and permanentItemSystem:consumeItem("item_P220")
		if not (consumeResult and consumeResult.ok) then
			ErrorMsg(nil, caster:GetPlayerId(), consumeResult and consumeResult.reason or "当前无法使用")
			return
		end
		successMessage = consumeResult.successMessage or ITEM_P220_SUCCESS_MESSAGE
	end
	____exports.modifier_item_P220_cocktail:applys(
		caster,
		caster,
		self,
		{ duration = ITEM_P220_BUFF_DURATION, bonus_movespeed_pct = ITEM_P220_BONUS_MOVESPEED_PCT }
	)
	local particle =
		ParticleManager:CreateParticle("particles/items3_fx/fish_bones_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle)
	caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
	SuccessMsg(nil, caster:GetPlayerId(), successMessage)
	self:consumeCurrentItem()
end
function item_P220.prototype.getPermanentItemSystem(self)
	local ____opt_32 = self:GetCaster()
	local playerId = ____opt_32 and ____opt_32:GetPlayerId()
	if playerId == nil or playerId < 0 then
		return nil
	end
	local ____opt_34 = MyGamePlayers:getPlayer(playerId)
	return ____opt_34 and ____opt_34.permanentItems
end
function item_P220.prototype.getCustomPlayer(self)
	local ____opt_36 = self:GetCaster()
	local playerId = ____opt_36 and ____opt_36:GetPlayerId()
	if playerId == nil or playerId < 0 then
		return nil
	end
	return MyGamePlayers:getPlayer(playerId)
end
function item_P220.prototype.consumeCurrentItem(self)
	local caster = self:GetCaster()
	local playerId = caster and caster:GetPlayerId()
	if playerId ~= nil and playerId >= 0 then
		local player = MyGamePlayers:getPlayer(playerId)
		if player and player:CostItemToIndex(self:entindex(), 1) then
			return
		end
	end
	self:CostItemCharge(1)
end
item_P220 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P220)
____exports.item_P220 = item_P220
ITEM_P220_BUFF_DURATION = 600
ITEM_P220_BONUS_MOVESPEED_PCT = 25
ITEM_P220_SUCCESS_MESSAGE = "生命值永久增加 5 点，并获得 10 分钟 25% 移动速度"
ITEM_P220_REPEAT_SUCCESS_MESSAGE = "获得 10 分钟 25% 移动速度"
____exports.modifier_item_P220_cocktail = __TS__Class()
local modifier_item_P220_cocktail = ____exports.modifier_item_P220_cocktail
modifier_item_P220_cocktail.name = "modifier_item_P220_cocktail"
__TS__ClassExtends(modifier_item_P220_cocktail, BaseModifier_CS)
function modifier_item_P220_cocktail.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.bonusMovespeedPct = ITEM_P220_BONUS_MOVESPEED_PCT
end
function modifier_item_P220_cocktail.prototype.OnCreated(self, params)
	self.bonusMovespeedPct = tonumber(params.bonus_movespeed_pct or ITEM_P220_BONUS_MOVESPEED_PCT)
		or ITEM_P220_BONUS_MOVESPEED_PCT
end
function modifier_item_P220_cocktail.prototype.OnRefresh(self, params)
	self.bonusMovespeedPct = tonumber(params.bonus_movespeed_pct or ITEM_P220_BONUS_MOVESPEED_PCT)
		or ITEM_P220_BONUS_MOVESPEED_PCT
end
function modifier_item_P220_cocktail.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = self.bonusMovespeedPct }
end
modifier_item_P220_cocktail = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P220_cocktail)
____exports.modifier_item_P220_cocktail = modifier_item_P220_cocktail
____exports.item_P221 = __TS__Class()
local item_P221 = ____exports.item_P221
item_P221.name = "item_P221"
__TS__ClassExtends(item_P221, BaseItem_CS)
function item_P221.prototype.Precache(self, context)
	PrecacheResource("particle", ITEM_P221_BUFF_PARTICLE, context)
end
function item_P221.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		allowContinuousUse = true,
		duration = 1.6,
		castAnimation = -1,
		canCast = function()
			local ____table_canUseBlessing_result_ok_42
			if self:canUseBlessing().ok then
				____table_canUseBlessing_result_ok_42 = UF_SUCCESS
			else
				____table_canUseBlessing_result_ok_42 = UF_FAIL_CUSTOM
			end
			return ____table_canUseBlessing_result_ok_42
		end,
		castError = function()
			return self:canUseBlessing().reason or "当前无法使用"
		end,
		onSuccess = function()
			self:onBlessingConsumed()
		end,
		onInterrupted = function() end,
	}
end
function item_P221.prototype.canUseBlessing(self)
	local player = self:getCustomPlayer()
	if not (player and player:IsSaveLoadedComplete()) then
		return { ok = false, reason = "存档尚未加载完成" }
	end
	if not player:GetHero() then
		return { ok = false, reason = "英雄未就绪" }
	end
	return { ok = true }
end
function item_P221.prototype.onBlessingConsumed(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local permanentItemSystem = self:getPermanentItemSystem()
	local usedCount = permanentItemSystem and permanentItemSystem:getUsedCount("item_P221") or 0
	local successMessage = ITEM_P221_REPEAT_SUCCESS_MESSAGE
	if usedCount < getPermanentItemMaxUses(nil, "item_P221") then
		local consumeResult = permanentItemSystem and permanentItemSystem:consumeItem("item_P221")
		if not (consumeResult and consumeResult.ok) then
			ErrorMsg(nil, caster:GetPlayerId(), consumeResult and consumeResult.reason or "当前无法使用")
			return
		end
		successMessage = consumeResult.successMessage or ITEM_P221_SUCCESS_MESSAGE
	end
	____exports.modifier_item_P221_winner_blessing:applys(caster, caster, self, { duration = ITEM_P221_BUFF_DURATION })
	local particle =
		ParticleManager:CreateParticle("particles/items3_fx/fish_bones_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle)
	caster:EmitSound("ui.treasure_01")
	SuccessMsg(nil, caster:GetPlayerId(), successMessage)
	self:consumeCurrentItem()
end
function item_P221.prototype.getPermanentItemSystem(self)
	local ____opt_53 = self:GetCaster()
	local playerId = ____opt_53 and ____opt_53:GetPlayerId()
	if playerId == nil or playerId < 0 then
		return nil
	end
	local ____opt_55 = MyGamePlayers:getPlayer(playerId)
	return ____opt_55 and ____opt_55.permanentItems
end
function item_P221.prototype.getCustomPlayer(self)
	local ____opt_57 = self:GetCaster()
	local playerId = ____opt_57 and ____opt_57:GetPlayerId()
	if playerId == nil or playerId < 0 then
		return nil
	end
	return MyGamePlayers:getPlayer(playerId)
end
function item_P221.prototype.consumeCurrentItem(self)
	local caster = self:GetCaster()
	local playerId = caster and caster:GetPlayerId()
	if playerId ~= nil and playerId >= 0 then
		local player = MyGamePlayers:getPlayer(playerId)
		if player and player:CostItemToIndex(self:entindex(), 1) then
			return
		end
	end
	self:CostItemCharge(1)
end
item_P221 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P221)
____exports.item_P221 = item_P221
ITEM_P221_BUFF_DURATION = 600
local ITEM_P221_DOUBLE_COUNT_CHANCE_MULTIPLIER = 2
ITEM_P221_BUFF_PARTICLE = "particles/econ/courier/courier_golden_roshan/golden_roshan_ambient.vpcf"
ITEM_P221_SUCCESS_MESSAGE =
	"全属性永久增加 1 点，幸运值永久增加 1 点，并获得 10 分钟双倍数量触发概率提升"
ITEM_P221_REPEAT_SUCCESS_MESSAGE = "获得 10 分钟双倍数量触发概率提升"
____exports.modifier_item_P221_winner_blessing = __TS__Class()
local modifier_item_P221_winner_blessing = ____exports.modifier_item_P221_winner_blessing
modifier_item_P221_winner_blessing.name = "modifier_item_P221_winner_blessing"
__TS__ClassExtends(modifier_item_P221_winner_blessing, BaseModifier_CS)
function modifier_item_P221_winner_blessing.GetLocalizationCN(self)
	return { name = "胜者赐福", description = "掉落命中后进行双倍掉落概率判定。" }
end
function modifier_item_P221_winner_blessing.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:registerDoubleDropFilter()
	self:createBuffParticle()
end
function modifier_item_P221_winner_blessing.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	self:registerDoubleDropFilter()
end
function modifier_item_P221_winner_blessing.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	local ____opt_71 = self.unregisterDropFilter
	if ____opt_71 ~= nil then
		____opt_71(self)
	end
	self.unregisterDropFilter = nil
end
function modifier_item_P221_winner_blessing.prototype.IsDebuff(self)
	return false
end
function modifier_item_P221_winner_blessing.prototype.IsPurgable(self)
	return false
end
function modifier_item_P221_winner_blessing.prototype.registerDoubleDropFilter(self)
	local ____opt_73 = self.unregisterDropFilter
	if ____opt_73 ~= nil then
		____opt_73(self)
	end
	self.unregisterDropFilter = nil
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local playerId = parent:GetPlayerOwnerID()
	if playerId == nil or playerId < 0 then
		return
	end
	local filterId = "item_P221_double_drop_" .. tostring(parent:entindex())
	self.unregisterDropFilter = MyGameDropManager:RegisterDropFilter(filterId, function(____, ctx, pipe)
		if ctx.playerId ~= playerId then
			return
		end
		local ____opt_75 = MyGamePlayers:getPlayer(playerId)
		local hero = ____opt_75 and ____opt_75:GetHero()
		if hero ~= parent then
			return
		end
		pipe.doubleCountChanceMultiplier =
			math.max(pipe.doubleCountChanceMultiplier or 1, ITEM_P221_DOUBLE_COUNT_CHANCE_MULTIPLIER)
	end)
end
function modifier_item_P221_winner_blessing.prototype.createBuffParticle(self)
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	local pfx = ParticleManager:CreateParticle(ITEM_P221_BUFF_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	self:AddParticle(pfx, false, false, -1, false, false)
end
modifier_item_P221_winner_blessing = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P221_winner_blessing)
____exports.modifier_item_P221_winner_blessing = modifier_item_P221_winner_blessing
____exports.item_P222 = __TS__Class()
local item_P222 = ____exports.item_P222
item_P222.name = "item_P222"
__TS__ClassExtends(item_P222, BaseItem_CS)
function item_P222.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		allowContinuousUse = true,
		duration = 1.6,
		castAnimation = -1,
		canCast = function()
			local ____table_canUseEnderSpecial_result_ok_77
			if self:canUseEnderSpecial().ok then
				____table_canUseEnderSpecial_result_ok_77 = UF_SUCCESS
			else
				____table_canUseEnderSpecial_result_ok_77 = UF_FAIL_CUSTOM
			end
			return ____table_canUseEnderSpecial_result_ok_77
		end,
		castError = function()
			return self:canUseEnderSpecial().reason or "当前无法使用"
		end,
		onSuccess = function()
			self:onEnderSpecialConsumed()
		end,
		onInterrupted = function() end,
	}
end
function item_P222.prototype.canUseEnderSpecial(self)
	local player = self:getCustomPlayer()
	if not (player and player:IsSaveLoadedComplete()) then
		return { ok = false, reason = "存档尚未加载完成" }
	end
	if not player:GetHero() then
		return { ok = false, reason = "英雄未就绪" }
	end
	return { ok = true }
end
function item_P222.prototype.onEnderSpecialConsumed(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local permanentItemSystem = self:getPermanentItemSystem()
	local usedCount = permanentItemSystem and permanentItemSystem:getUsedCount("item_P222") or 0
	local successMessage = ITEM_P222_REPEAT_SUCCESS_MESSAGE
	if usedCount < getPermanentItemMaxUses(nil, "item_P222") then
		local consumeResult = permanentItemSystem and permanentItemSystem:consumeItem("item_P222")
		if not (consumeResult and consumeResult.ok) then
			ErrorMsg(nil, caster:GetPlayerId(), consumeResult and consumeResult.reason or "当前无法使用")
			return
		end
		successMessage = consumeResult.successMessage or ITEM_P222_SUCCESS_MESSAGE
	end
	____exports.modifier_item_P222_ender_special:applys(
		caster,
		caster,
		self,
		{ duration = ITEM_P222_BUFF_DURATION, evasion_pct = ITEM_P222_EVASION_PCT }
	)
	local particle =
		ParticleManager:CreateParticle("particles/items3_fx/fish_bones_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle)
	caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
	SuccessMsg(nil, caster:GetPlayerId(), successMessage)
	self:consumeCurrentItem()
end
function item_P222.prototype.getPermanentItemSystem(self)
	local ____opt_88 = self:GetCaster()
	local playerId = ____opt_88 and ____opt_88:GetPlayerId()
	if playerId == nil or playerId < 0 then
		return nil
	end
	local ____opt_90 = MyGamePlayers:getPlayer(playerId)
	return ____opt_90 and ____opt_90.permanentItems
end
function item_P222.prototype.getCustomPlayer(self)
	local ____opt_92 = self:GetCaster()
	local playerId = ____opt_92 and ____opt_92:GetPlayerId()
	if playerId == nil or playerId < 0 then
		return nil
	end
	return MyGamePlayers:getPlayer(playerId)
end
function item_P222.prototype.consumeCurrentItem(self)
	local caster = self:GetCaster()
	local playerId = caster and caster:GetPlayerId()
	if playerId ~= nil and playerId >= 0 then
		local player = MyGamePlayers:getPlayer(playerId)
		if player and player:CostItemToIndex(self:entindex(), 1) then
			return
		end
	end
	self:CostItemCharge(1)
end
item_P222 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P222)
____exports.item_P222 = item_P222
ITEM_P222_BUFF_DURATION = 600
ITEM_P222_EVASION_PCT = 20
ITEM_P222_SUCCESS_MESSAGE = "伤害抵抗永久增加 1%，幸运值永久增加 1 点，并获得 10 分钟 20% 闪避"
ITEM_P222_REPEAT_SUCCESS_MESSAGE = "获得 10 分钟 20% 闪避"
____exports.modifier_item_P222_ender_special = __TS__Class()
local modifier_item_P222_ender_special = ____exports.modifier_item_P222_ender_special
modifier_item_P222_ender_special.name = "modifier_item_P222_ender_special"
__TS__ClassExtends(modifier_item_P222_ender_special, BaseModifier_CS)
function modifier_item_P222_ender_special.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.evasionPct = ITEM_P222_EVASION_PCT
end
function modifier_item_P222_ender_special.GetLocalizationCN(self)
	return { name = "末影特调", description = "闪避提升。" }
end
function modifier_item_P222_ender_special.prototype.OnCreated(self, params)
	self.evasionPct = tonumber(params.evasion_pct or ITEM_P222_EVASION_PCT) or ITEM_P222_EVASION_PCT
end
function modifier_item_P222_ender_special.prototype.OnRefresh(self, params)
	self.evasionPct = tonumber(params.evasion_pct or ITEM_P222_EVASION_PCT) or ITEM_P222_EVASION_PCT
end
function modifier_item_P222_ender_special.prototype.GetAttributeBonus(self)
	return { evasion_pct = self.evasionPct }
end
function modifier_item_P222_ender_special.prototype.GetTexture(self)
	return "item_icon_js2_26"
end
modifier_item_P222_ender_special = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P222_ender_special)
____exports.modifier_item_P222_ender_special = modifier_item_P222_ender_special
____exports.item_P223 = __TS__Class()
local item_P223 = ____exports.item_P223
item_P223.name = "item_P223"
__TS__ClassExtends(item_P223, BaseItem_CS)
function item_P223.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		useType = "slow",
		allowContinuousUse = true,
		duration = 1.6,
		castAnimation = -1,
		canCast = function()
			local ____table_canUseHuntingBlood_result_ok_98
			if self:canUseHuntingBlood().ok then
				____table_canUseHuntingBlood_result_ok_98 = UF_SUCCESS
			else
				____table_canUseHuntingBlood_result_ok_98 = UF_FAIL_CUSTOM
			end
			return ____table_canUseHuntingBlood_result_ok_98
		end,
		castError = function()
			return self:canUseHuntingBlood().reason or "当前无法使用"
		end,
		onSuccess = function()
			self:onHuntingBloodConsumed()
		end,
		onInterrupted = function() end,
	}
end
function item_P223.prototype.canUseHuntingBlood(self)
	local player = self:getCustomPlayer()
	if not (player and player:IsSaveLoadedComplete()) then
		return { ok = false, reason = "存档尚未加载完成" }
	end
	if not player:GetHero() then
		return { ok = false, reason = "英雄未就绪" }
	end
	return { ok = true }
end
function item_P223.prototype.onHuntingBloodConsumed(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local permanentItemSystem = self:getPermanentItemSystem()
	local usedCount = permanentItemSystem and permanentItemSystem:getUsedCount("item_P223") or 0
	local successMessage = ITEM_P223_REPEAT_SUCCESS_MESSAGE
	if usedCount < getPermanentItemMaxUses(nil, "item_P223") then
		local consumeResult = permanentItemSystem and permanentItemSystem:consumeItem("item_P223")
		if not (consumeResult and consumeResult.ok) then
			ErrorMsg(nil, caster:GetPlayerId(), consumeResult and consumeResult.reason or "当前无法使用")
			return
		end
		successMessage = consumeResult.successMessage or ITEM_P223_SUCCESS_MESSAGE
	end
	____exports.modifier_item_P223_hunting_blood:applys(
		caster,
		caster,
		self,
		{ duration = ITEM_P223_BUFF_DURATION, base_attack_damage_percent = ITEM_P223_BASE_ATTACK_DAMAGE_PERCENT }
	)
	local particle =
		ParticleManager:CreateParticle("particles/items3_fx/fish_bones_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:ReleaseParticleIndex(particle)
	caster:EmitSound("DOTA_Item.FaerieSpark.Activate")
	SuccessMsg(nil, caster:GetPlayerId(), successMessage)
	self:consumeCurrentItem()
end
function item_P223.prototype.getPermanentItemSystem(self)
	local ____opt_109 = self:GetCaster()
	local playerId = ____opt_109 and ____opt_109:GetPlayerId()
	if playerId == nil or playerId < 0 then
		return nil
	end
	local ____opt_111 = MyGamePlayers:getPlayer(playerId)
	return ____opt_111 and ____opt_111.permanentItems
end
function item_P223.prototype.getCustomPlayer(self)
	local ____opt_113 = self:GetCaster()
	local playerId = ____opt_113 and ____opt_113:GetPlayerId()
	if playerId == nil or playerId < 0 then
		return nil
	end
	return MyGamePlayers:getPlayer(playerId)
end
function item_P223.prototype.consumeCurrentItem(self)
	local caster = self:GetCaster()
	local playerId = caster and caster:GetPlayerId()
	if playerId ~= nil and playerId >= 0 then
		local player = MyGamePlayers:getPlayer(playerId)
		if player and player:CostItemToIndex(self:entindex(), 1) then
			return
		end
	end
	self:CostItemCharge(1)
end
item_P223 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P223)
____exports.item_P223 = item_P223
ITEM_P223_BUFF_DURATION = 600
ITEM_P223_BASE_ATTACK_DAMAGE_PERCENT = 50
ITEM_P223_SUCCESS_MESSAGE = "基础攻击力永久增加 2 点，并获得 10 分钟 50% 攻击力"
ITEM_P223_REPEAT_SUCCESS_MESSAGE = "获得 10 分钟 50% 攻击力"
____exports.modifier_item_P223_hunting_blood = __TS__Class()
local modifier_item_P223_hunting_blood = ____exports.modifier_item_P223_hunting_blood
modifier_item_P223_hunting_blood.name = "modifier_item_P223_hunting_blood"
__TS__ClassExtends(modifier_item_P223_hunting_blood, BaseModifier_CS)
function modifier_item_P223_hunting_blood.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.baseAttackDamagePercent = ITEM_P223_BASE_ATTACK_DAMAGE_PERCENT
end
function modifier_item_P223_hunting_blood.GetLocalizationCN(self)
	return { name = "狩猎之血", description = "攻击力提升。" }
end
function modifier_item_P223_hunting_blood.prototype.OnCreated(self, params)
	self.baseAttackDamagePercent = tonumber(params.base_attack_damage_percent or ITEM_P223_BASE_ATTACK_DAMAGE_PERCENT)
		or ITEM_P223_BASE_ATTACK_DAMAGE_PERCENT
end
function modifier_item_P223_hunting_blood.prototype.OnRefresh(self, params)
	self.baseAttackDamagePercent = tonumber(params.base_attack_damage_percent or ITEM_P223_BASE_ATTACK_DAMAGE_PERCENT)
		or ITEM_P223_BASE_ATTACK_DAMAGE_PERCENT
end
function modifier_item_P223_hunting_blood.prototype.GetAttributeBonus(self)
	return { base_attack_damage_percent = self.baseAttackDamagePercent }
end
function modifier_item_P223_hunting_blood.prototype.GetTexture(self)
	return "item_icon_js2_15"
end
modifier_item_P223_hunting_blood = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_item_P223_hunting_blood)
____exports.modifier_item_P223_hunting_blood = modifier_item_P223_hunting_blood
____exports.item_P250 = __TS__Class()
local item_P250 = ____exports.item_P250
item_P250.name = "item_P250"
__TS__ClassExtends(item_P250, BasePermanentConsumableItem_CS)
function item_P250.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P250"
end
item_P250 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P250)
____exports.item_P250 = item_P250
____exports.item_P251 = __TS__Class()
local item_P251 = ____exports.item_P251
item_P251.name = "item_P251"
__TS__ClassExtends(item_P251, BasePermanentConsumableItem_CS)
function item_P251.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P251"
end
item_P251 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P251)
____exports.item_P251 = item_P251
____exports.item_P252 = __TS__Class()
local item_P252 = ____exports.item_P252
item_P252.name = "item_P252"
__TS__ClassExtends(item_P252, BasePermanentConsumableItem_CS)
function item_P252.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P252"
end
item_P252 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P252)
____exports.item_P252 = item_P252
____exports.item_P256 = __TS__Class()
local item_P256 = ____exports.item_P256
item_P256.name = "item_P256"
__TS__ClassExtends(item_P256, BasePermanentConsumableItem_CS)
function item_P256.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P256"
end
item_P256 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P256)
____exports.item_P256 = item_P256
____exports.item_P257 = __TS__Class()
local item_P257 = ____exports.item_P257
item_P257.name = "item_P257"
__TS__ClassExtends(item_P257, BasePermanentConsumableItem_CS)
function item_P257.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P257"
end
item_P257 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P257)
____exports.item_P257 = item_P257
____exports.item_P258 = __TS__Class()
local item_P258 = ____exports.item_P258
item_P258.name = "item_P258"
__TS__ClassExtends(item_P258, BasePermanentConsumableItem_CS)
function item_P258.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P258"
end
item_P258 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P258)
____exports.item_P258 = item_P258
____exports.item_P259 = __TS__Class()
local item_P259 = ____exports.item_P259
item_P259.name = "item_P259"
__TS__ClassExtends(item_P259, BasePermanentConsumableItem_CS)
function item_P259.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P259"
end
item_P259 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P259)
____exports.item_P259 = item_P259
____exports.item_P261 = __TS__Class()
local item_P261 = ____exports.item_P261
item_P261.name = "item_P261"
__TS__ClassExtends(item_P261, BasePermanentConsumableItem_CS)
function item_P261.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P261"
end
item_P261 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P261)
____exports.item_P261 = item_P261
____exports.item_P262 = __TS__Class()
local item_P262 = ____exports.item_P262
item_P262.name = "item_P262"
__TS__ClassExtends(item_P262, BasePermanentConsumableItem_CS)
function item_P262.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P262"
end
item_P262 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P262)
____exports.item_P262 = item_P262
____exports.item_P263 = __TS__Class()
local item_P263 = ____exports.item_P263
item_P263.name = "item_P263"
__TS__ClassExtends(item_P263, BasePermanentConsumableItem_CS)
function item_P263.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P263"
end
item_P263 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P263)
____exports.item_P263 = item_P263
____exports.item_P264 = __TS__Class()
local item_P264 = ____exports.item_P264
item_P264.name = "item_P264"
__TS__ClassExtends(item_P264, BasePermanentConsumableItem_CS)
function item_P264.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P264"
end
item_P264 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P264)
____exports.item_P264 = item_P264
____exports.item_P265 = __TS__Class()
local item_P265 = ____exports.item_P265
item_P265.name = "item_P265"
__TS__ClassExtends(item_P265, BasePermanentConsumableItem_CS)
function item_P265.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P265"
end
item_P265 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P265)
____exports.item_P265 = item_P265
____exports.item_P266 = __TS__Class()
local item_P266 = ____exports.item_P266
item_P266.name = "item_P266"
__TS__ClassExtends(item_P266, BasePermanentConsumableItem_CS)
function item_P266.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P266"
end
item_P266 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P266)
____exports.item_P266 = item_P266
____exports.item_P267 = __TS__Class()
local item_P267 = ____exports.item_P267
item_P267.name = "item_P267"
__TS__ClassExtends(item_P267, BasePermanentConsumableItem_CS)
function item_P267.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P267"
end
item_P267 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P267)
____exports.item_P267 = item_P267
____exports.item_P268 = __TS__Class()
local item_P268 = ____exports.item_P268
item_P268.name = "item_P268"
__TS__ClassExtends(item_P268, BasePermanentConsumableItem_CS)
function item_P268.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P268"
end
item_P268 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P268)
____exports.item_P268 = item_P268
____exports.item_P269 = __TS__Class()
local item_P269 = ____exports.item_P269
item_P269.name = "item_P269"
__TS__ClassExtends(item_P269, BasePermanentConsumableItem_CS)
function item_P269.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P269"
end
item_P269 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P269)
____exports.item_P269 = item_P269
____exports.item_P270 = __TS__Class()
local item_P270 = ____exports.item_P270
item_P270.name = "item_P270"
__TS__ClassExtends(item_P270, BasePermanentConsumableItem_CS)
function item_P270.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P270"
end
item_P270 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P270)
____exports.item_P270 = item_P270
____exports.item_P271 = __TS__Class()
local item_P271 = ____exports.item_P271
item_P271.name = "item_P271"
__TS__ClassExtends(item_P271, BasePermanentConsumableItem_CS)
function item_P271.prototype.____constructor(self, ...)
	BasePermanentConsumableItem_CS.prototype.____constructor(self, ...)
	self.permanentItemId = "item_P271"
end
item_P271 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P271)
____exports.item_P271 = item_P271
return ____exports