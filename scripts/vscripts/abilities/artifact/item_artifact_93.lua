--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_93"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 9,
		["22"] = 7,
		["23"] = 12,
		["24"] = 13,
		["25"] = 12,
		["26"] = 15,
		["27"] = 16,
		["28"] = 17,
		["29"] = 18,
		["30"] = 18,
		["31"] = 18,
		["32"] = 22,
		["33"] = 24,
		["34"] = 25,
		["35"] = 26,
		["36"] = 26,
		["37"] = 26,
		["38"] = 26,
		["39"] = 18,
		["40"] = 18,
		["41"] = 29,
		["42"] = 15,
		["43"] = 31,
		["44"] = 32,
		["45"] = 33,
		["46"] = 34,
		["48"] = 36,
		["49"] = 31,
		["50"] = 38,
		["51"] = 39,
		["52"] = 38,
		["53"] = 6,
		["54"] = 5,
		["55"] = 6,
		["57"] = 6,
		["58"] = 43,
		["59"] = 52,
		["60"] = 43,
		["61"] = 52,
		["62"] = 54,
		["63"] = 55,
		["64"] = 54,
		["65"] = 57,
		["66"] = 58,
		["67"] = 59,
		["68"] = 59,
		["69"] = 58,
		["70"] = 57,
		["71"] = 62,
		["72"] = 64,
		["73"] = 65,
		["74"] = 66,
		["75"] = 67,
		["76"] = 67,
		["77"] = 67,
		["78"] = 67,
		["79"] = 67,
		["80"] = 68,
		["81"] = 68,
		["82"] = 68,
		["83"] = 68,
		["84"] = 69,
		["85"] = 69,
		["86"] = 69,
		["87"] = 69,
		["88"] = 69,
		["89"] = 70,
		["90"] = 70,
		["91"] = 70,
		["92"] = 70,
		["93"] = 70,
		["94"] = 70,
		["95"] = 70,
		["96"] = 70,
		["97"] = 70,
		["98"] = 71,
		["100"] = 62,
		["101"] = 52,
		["102"] = 43,
		["103"] = 43,
		["104"] = 43,
		["105"] = 43,
		["106"] = 43,
		["107"] = 43,
		["108"] = 43,
		["109"] = 43,
		["110"] = 43,
		["111"] = 52,
		["113"] = 52,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_93 = c()
local n = g.item_artifact_93
n.name = "item_artifact_93"
d(n, i)
function n.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(1)
	end
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_93"
end
function n.prototype.OnSpellStart(self)
	local o = self:GetCaster()
	local p = o:GetPlayerOwnerID()
	PlayerData:requestSectSelection(
		p,
		{ title = "选择幸运流派", sects = AbilityShop.pickList, ability_name = "item_artifact_93" },
		function(q, p, r)
			PlayerData.playerData[p].luckySect = r
			PlayerData:getHero(p):removeSectModifiers(self:GetName())
			PlayerData:getHero(p):addSectModifier(r, self:GetName())
		end
	)
	self:SpendCharge()
end
function n.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() == 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function n.prototype.GetCustomCastError(self)
	return self.error
end
n = e({ j(nil) }, n)
g.item_artifact_93 = n
g.modifier_item_artifact_93 = c()
local s = g.modifier_item_artifact_93
s.name = "modifier_item_artifact_93"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.gold_bonus = self:GetAbilitySpecialValueFor("gold_bonus")
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_LEARN] = { self:GetParent(), -1 } }
end
function s.prototype.OnAbilityLearn(self, t)
	local p = self:GetParent():GetPlayerOwnerID()
	if
		PlayerData.playerData[p].luckySect
		and (string.find(t.abilityUpgradeInfo.sect, PlayerData.playerData[p].luckySect, nil, true) or 0) - 1 ~= -1
	then
		PlayerData:modifyGold(p, self.gold_bonus)
		PlayerData:getplayerData(p):modifyArtifactExtraData(self:GetAbility():entindex(), "bonus_gold", self.gold_bonus)
		EmitSoundOn("DOTA_Item.Hand_Of_Midas", self:GetParent())
		local u = ParticleManager:CreateParticle(
			"particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			self:GetParent()
		)
		ParticleManager:SetParticleControlEnt(
			u,
			1,
			self:GetParent(),
			PATTACH_ABSORIGIN_FOLLOW,
			nil,
			vec3_invalid,
			false
		)
		ParticleManager:ReleaseParticleIndex(u)
	end
end
s = e(
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
	s
)
g.modifier_item_artifact_93 = s
return g