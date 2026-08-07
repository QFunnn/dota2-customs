--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_dragon_baby"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMItem
local l = j.registerEOMAbility
local m = c()
m.name = "item_dragon_baby"
d(m, k)
function m.prototype.OnCreated(self)
	self.wisp =
		self:GetCaster()
			:CreateWisp("baby_dragon", { attack = 0, attack_speed = 150, attack_ability_name = "baby_dragon_attack" })
	local n = self.wisp
	if n ~= nil then
		n:AddNewModifier(self:GetCaster(), self, "modifier_item_dragon_baby_wisp", nil)
	end
	self:SetStackCount(self:GetSpecialValueFor("kill"))
end
function m.prototype.OnDestroy(self)
	if IsValid(self.wisp) then
		self:GetCaster():RemoveWisp(self.wisp)
		self.wisp = nil
	end
end
function m.prototype.EventListener(self)
	return {
		entity_killed = function(o, p)
			if p.attacker == self:GetCaster() and self:GetStackCount() > 0 then
				self:DecrementStackCount()
				if self:GetStackCount() <= 0 then
					Notification:Combat({
						message = "Notify_item_artifact_upgrade",
						player_id = p.attacker:GetPlayerOwnerID(),
						item_name = "item_dragon_baby",
						item_name_rarity = 4,
						item_name2 = "item_super_dragon_baby",
						item_name2_rarity = 5,
					})
					self:GetCaster():AddItemByName("item_super_dragon_baby", 5)
					self:GetCaster():RemoveItem(self)
				end
			end
		end,
	}
end
m = e({ l(nil) }, m)
local q = c()
q.name = "modifier_item_dragon_baby_wisp"
d(q, h)
function q.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.attack = 0
	self.attackspeed = 0
end
function q.prototype.EventListener(self)
	return {
		attack_event = function(o, r)
			local s = self:GetCaster()
			if r.attacker == self:GetParent() and IsValid(s) then
				self.attack = s:GetAttackDamage() * 1
				self:RegisterStaticProperties()
			end
		end,
	}
end
function q.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACK] = self.attack }
end
q = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	q
)
return f