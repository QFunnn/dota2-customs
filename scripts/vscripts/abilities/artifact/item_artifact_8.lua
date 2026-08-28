--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_8"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 20,
		["28"] = 11,
		["29"] = 20,
		["30"] = 22,
		["31"] = 23,
		["32"] = 22,
		["33"] = 25,
		["34"] = 26,
		["35"] = 25,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 36,
		["42"] = 38,
		["43"] = 39,
		["44"] = 39,
		["45"] = 39,
		["46"] = 39,
		["47"] = 39,
		["48"] = 40,
		["49"] = 40,
		["50"] = 40,
		["51"] = 40,
		["52"] = 40,
		["53"] = 40,
		["54"] = 40,
		["55"] = 42,
		["56"] = 42,
		["57"] = 42,
		["58"] = 42,
		["59"] = 43,
		["60"] = 43,
		["61"] = 43,
		["62"] = 43,
		["63"] = 43,
		["64"] = 44,
		["66"] = 31,
		["67"] = 20,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 11,
		["72"] = 11,
		["73"] = 11,
		["74"] = 11,
		["75"] = 11,
		["76"] = 11,
		["77"] = 20,
		["79"] = 20,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_8 = c()
local n = g.item_artifact_8
n.name = "item_artifact_8"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_8"
end
n = e({ j(nil) }, n)
g.item_artifact_8 = n
g.modifier_item_artifact_8 = c()
local o = g.modifier_item_artifact_8
o.name = "modifier_item_artifact_8"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.hp_regen = self:GetAbilitySpecialValueFor("hp_regen")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_TAKEDAMAGE] = { -1, -1 } }
end
function o.prototype.OnPlayerTakeDamage(self, p)
	local q = self:GetParent():GetPlayerOwnerID()
	if p.victimID == q then
		self:SetStackCount(1)
	elseif p.attackerID == q and self:GetStackCount() == 1 then
		self:SetStackCount(0)
		PlayerData:modifyHealth(q, self.hp_regen)
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID())
			:modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.hp_regen)
		SendOverheadEventMessage(
			nil,
			OVERHEAD_ALERT_HEAL,
			self:GetParent(),
			self.hp_regen,
			self:GetParent():GetPlayerOwner()
		)
		EmitSoundOn("DOTA_Item.Hand_Of_Midas", self:GetParent())
		local r = ParticleManager:CreateParticle(
			"particles/units/heroes/hero_omniknight/omniknight_shard_hammer_of_purity_heal_pluses.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:ReleaseParticleIndex(r)
	end
end
o = e(
	{
		m(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	o
)
g.modifier_item_artifact_8 = o
return g