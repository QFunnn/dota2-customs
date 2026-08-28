--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_hand_of_midas_custom"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.AbilityValue
local i = g.EOMItem
local j = g.registerEOMAbility
local k = c()
k.name = "item_hand_of_midas_custom"
d(k, i)
function k.prototype.IsGemEnemy(self, l)
	local m = KeyValues:GetUnitData(l, "Filter")
	return m == "gem"
end
function k.prototype.EventListener(self)
	return {
		damage_event = function(n, o)
			if
				o.attacker == self:GetCaster()
				and not self:IsGemEnemy(o.target)
				and o.health_before_damage >= o.target:GetMaxHealth()
				and not o.target:IsElite()
				and not o.target:IsBoss()
				and not o.target:IsBreakable()
				and not o.target:IsSummoned()
				and self:PRD(self.chance)
			then
				local p = ParticleManager:CreateParticle(
					"particles/items2_fx/hand_of_midas.vpcf",
					PATTACH_ABSORIGIN,
					o.target
				)
				ParticleManager:SetParticleControlEnt(
					p,
					1,
					o.attacker,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					o.attacker:GetAbsOrigin(),
					true
				)
				o.attacker:DealDamage(
					o.target,
					self,
					o.target:GetHealth(),
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
					EOM_DAMAGE_FLAGS.NO_CRIT
						+ EOM_DAMAGE_FLAGS.NO_DAMAGE_AMPLIFY
						+ EOM_DAMAGE_FLAGS.NO_INCOMING_ADJUST
						+ EOM_DAMAGE_FLAGS.NO_OUTGOING_ADJUST
						+ EOM_DAMAGE_FLAGS.NO_SOURCE_AMPLIFY
				)
				Player:ModifyGold(o.attacker:GetPlayerOwnerID(), self.gold)
				o.attacker:EmitSound("DOTA_Item.Hand_Of_Midas")
				Notification:CombatToPlayer(
					o.attacker:GetPlayerOwnerID(),
					{
						message = "Notify_item_ofrenda_shovel_custom",
						item_name = "item_hand_of_midas_custom",
						int_value = self.gold,
					}
				)
			end
		end,
	}
end
e({ h(nil) }, k.prototype, "chance", nil)
e({ h(nil) }, k.prototype, "gold", nil)
k = e({ j(nil) }, k)
return f