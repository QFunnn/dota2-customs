--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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
function k.prototype.EventListener(self)
	return {
		damage_event = function(l, m)
			if
				m.attacker == self:GetCaster()
				and m.health_before_damage >= m.target:GetMaxHealth()
				and not m.target:IsElite()
				and not m.target:IsBoss()
				and not m.target:IsBreakable()
				and not m.target:IsSummoned()
				and self:PRD(self.chance)
			then
				local n = ParticleManager:CreateParticle(
					"particles/items2_fx/hand_of_midas.vpcf",
					PATTACH_ABSORIGIN,
					m.target
				)
				ParticleManager:SetParticleControlEnt(
					n,
					1,
					m.attacker,
					PATTACH_POINT_FOLLOW,
					"attach_hitloc",
					m.attacker:GetAbsOrigin(),
					true
				)
				m.attacker:DealDamage(
					m.target,
					self,
					m.target:GetHealth(),
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
					EOM_DAMAGE_FLAGS.NO_CRIT
						+ EOM_DAMAGE_FLAGS.NO_DAMAGE_AMPLIFY
						+ EOM_DAMAGE_FLAGS.NO_INCOMING_ADJUST
						+ EOM_DAMAGE_FLAGS.NO_OUTGOING_ADJUST
						+ EOM_DAMAGE_FLAGS.NO_SOURCE_AMPLIFY
				)
				Player:ModifyGold(m.attacker:GetPlayerOwnerID(), self.gold)
				m.attacker:EmitSound("DOTA_Item.Hand_Of_Midas")
				Notification:CombatToPlayer(
					m.attacker:GetPlayerOwnerID(),
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