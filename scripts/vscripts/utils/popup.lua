--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local ____exports = {}
____exports.Popup = __TS__Class()
local Popup = ____exports.Popup
Popup.name = "Popup"
function Popup.prototype.____constructor(self) end
function Popup.resolvePlayerId(self, target, player)
	local pid = -1
	if player and player.GetPlayerID then
		pid = player:GetPlayerID()
	elseif target.GetPlayerOwnerID then
		pid = target:GetPlayerOwnerID()
	end
	return pid
end
function Popup.sendPopup(self, data)
	local pid = self:resolvePlayerId(data.target, data.player)
	MyGameFEBridge:SendClientSyncEvent("popup", {
		ent_index = data.target:entindex(),
		player_id = pid,
		kind = data.kind,
		amount = data.amount,
		color_r = data.color_r,
		color_g = data.color_g,
		color_b = data.color_b,
		show_amount = data.show_amount,
		damage_type = data.damage_type or "none",
		hit_impact_amount = data.hit_impact_amount,
	})
end
function Popup.healing(self, target, amount, player)
	self:sendPopup({
		target = target,
		player = player,
		kind = "heal",
		amount = amount,
		color_r = 0,
		color_g = 255,
		color_b = 0,
	})
end
function Popup.lifestealAttack(self, target, amount, player)
	self:sendPopup({
		target = target,
		player = player,
		kind = "attack_lifesteal",
		amount = amount,
		color_r = 0,
		color_g = 255,
		color_b = 0,
		show_amount = true,
	})
end
function Popup.lifestealSpell(self, target, amount, player)
	self:sendPopup({
		target = target,
		player = player,
		kind = "spell_lifesteal",
		amount = amount,
		color_r = 0,
		color_g = 255,
		color_b = 0,
		show_amount = true,
	})
end
function Popup.damage(self, target, amount, player, damageType, hitImpactAmount, showAmount)
	if damageType == nil then
		damageType = "none"
	end
	if hitImpactAmount == nil then
		hitImpactAmount = amount
	end
	if showAmount == nil then
		showAmount = true
	end
	self:sendPopup({
		target = target,
		player = player,
		kind = "damage",
		amount = amount,
		hit_impact_amount = hitImpactAmount,
		show_amount = showAmount,
		color_r = 255,
		color_g = 0,
		color_b = 0,
		damage_type = damageType,
	})
end
function Popup.damageBig(self, target, amount, player, damageType)
	if damageType == nil then
		damageType = "none"
	end
	self:sendPopup({
		target = target,
		player = player,
		kind = "damage_big",
		amount = amount,
		color_r = 255,
		color_g = 0,
		color_b = 0,
		damage_type = damageType,
	})
end
function Popup.damageColored(self, target, amount, color, player, damageType)
	if damageType == nil then
		damageType = "none"
	end
	self:sendPopup({
		target = target,
		player = player,
		kind = "damage_colored",
		amount = amount,
		color_r = color.x or 255,
		color_g = color.y or 255,
		color_b = color.z or 255,
		damage_type = damageType,
	})
end
function Popup.crit(self, target, amount, player, damageType, hitImpactAmount)
	if damageType == nil then
		damageType = "none"
	end
	if hitImpactAmount == nil then
		hitImpactAmount = amount
	end
	self:sendPopup({
		target = target,
		player = player,
		kind = "crit",
		amount = amount,
		hit_impact_amount = hitImpactAmount,
		color_r = 255,
		color_g = 0,
		color_b = 0,
		damage_type = damageType,
	})
end
function Popup.critColored(self, target, amount, color, player, damageType)
	if damageType == nil then
		damageType = "none"
	end
	self:sendPopup({
		target = target,
		player = player,
		kind = "crit_colored",
		amount = amount,
		color_r = color.x or 255,
		color_g = color.y or 255,
		color_b = color.z or 255,
		damage_type = damageType,
	})
end
function Popup.damageOverTime(self, target, amount, player, damageType)
	if damageType == nil then
		damageType = "none"
	end
	self:sendPopup({
		target = target,
		player = player,
		kind = "dot",
		amount = amount,
		color_r = 215,
		color_g = 50,
		color_b = 248,
		damage_type = damageType,
	})
end
function Popup.damageBlock(self, target, amount, player)
	self:sendPopup({
		target = target,
		player = player,
		kind = "block",
		amount = amount,
		color_r = 255,
		color_g = 255,
		color_b = 255,
	})
end
function Popup.goldGain(self, target, amount, player)
	self:sendPopup({
		target = target,
		player = player,
		kind = "gold",
		amount = amount,
		color_r = 255,
		color_g = 200,
		color_b = 33,
	})
end
function Popup.addGold(self, target, amount, player)
	self:sendPopup({
		target = target,
		player = player,
		kind = "add_gold",
		amount = amount,
		color_r = 255,
		color_g = 200,
		color_b = 33,
	})
end
function Popup.manaGain(self, target, amount, player)
	self:sendPopup({
		target = target,
		player = player,
		kind = "mana",
		amount = amount,
		color_r = 33,
		color_g = 200,
		color_b = 255,
	})
end
function Popup.miss(self, target, player)
	self:sendPopup({
		target = target,
		player = player,
		kind = "miss",
		amount = nil,
		color_r = 255,
		color_g = 0,
		color_b = 0,
	})
end
return ____exports