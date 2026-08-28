--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_138"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArraySlice
local f = b.__TS__ObjectKeys
local g = b.__TS__DecorateLegacy
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 4,
		["17"] = 5,
		["18"] = 4,
		["19"] = 5,
		["21"] = 5,
		["22"] = 6,
		["23"] = 7,
		["24"] = 4,
		["25"] = 8,
		["26"] = 8,
		["27"] = 8,
		["29"] = 8,
		["30"] = 9,
		["31"] = 9,
		["32"] = 9,
		["33"] = 10,
		["34"] = 11,
		["35"] = 12,
		["36"] = 13,
		["39"] = 14,
		["40"] = 15,
		["41"] = 15,
		["42"] = 16,
		["43"] = 16,
		["45"] = 17,
		["46"] = 18,
		["47"] = 19,
		["49"] = 21,
		["51"] = 22,
		["52"] = 22,
		["53"] = 23,
		["54"] = 24,
		["57"] = 25,
		["58"] = 26,
		["59"] = 22,
		["62"] = 28,
		["65"] = 30,
		["66"] = 31,
		["67"] = 32,
		["68"] = 33,
		["69"] = 34,
		["70"] = 35,
		["71"] = 35,
		["72"] = 35,
		["73"] = 35,
		["74"] = 35,
		["75"] = 35,
		["76"] = 35,
		["77"] = 35,
		["78"] = 40,
		["79"] = 40,
		["80"] = 40,
		["81"] = 40,
		["82"] = 40,
		["83"] = 41,
		["84"] = 32,
		["85"] = 43,
		["86"] = 44,
		["89"] = 47,
		["90"] = 47,
		["91"] = 47,
		["92"] = 47,
		["93"] = 51,
		["94"] = 52,
		["95"] = 53,
		["96"] = 47,
		["97"] = 47,
		["98"] = 47,
		["99"] = 47,
		["100"] = 47,
		["101"] = 10,
		["102"] = 60,
		["103"] = 61,
		["104"] = 61,
		["105"] = 61,
		["107"] = 62,
		["108"] = 62,
		["109"] = 62,
		["111"] = 63,
		["112"] = 60,
		["113"] = 65,
		["114"] = 65,
		["115"] = 65,
		["116"] = 5,
		["117"] = 4,
		["118"] = 5,
		["120"] = 5,
		["121"] = 68,
		["122"] = 76,
		["123"] = 68,
		["124"] = 76,
		["125"] = 78,
		["126"] = 79,
		["127"] = 78,
		["128"] = 81,
		["129"] = 82,
		["130"] = 81,
		["131"] = 86,
		["132"] = 87,
		["133"] = 88,
		["136"] = 91,
		["137"] = 92,
		["138"] = 92,
		["139"] = 92,
		["140"] = 92,
		["141"] = 92,
		["142"] = 92,
		["143"] = 92,
		["144"] = 93,
		["145"] = 94,
		["147"] = 96,
		["148"] = 86,
		["149"] = 76,
		["150"] = 68,
		["151"] = 68,
		["152"] = 68,
		["153"] = 68,
		["154"] = 68,
		["155"] = 68,
		["156"] = 68,
		["157"] = 68,
		["158"] = 76,
		["160"] = 76,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseItem
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.item_artifact_138 = c()
local p = i.item_artifact_138
p.name = "item_artifact_138"
d(p, k)
function p.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.debtRounds = 0
	self.selecting = false
end
function p.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("charges"))
	end
end
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_138"
end
function p.prototype.OnSpellStart(self)
	local q = self:GetCaster():GetPlayerOwnerID()
	local r = PlayerData:getHero(q)
	if not r then
		return
	end
	local s = e(AbilityShop.banList)
	local t = PlayerData:getplayerData(q)
	local u = t and t.bannedSect
	if u then
		s[#s + 1] = u
	end
	local v = AbilityShop:getAbilityPoolNew("sr", nil, s, false)
	for w, x in ipairs(f(r:getAbilityUpgradeData())) do
		v:remove(x)
	end
	local y = {}
	do
		local z = 0
		while z < 3 do
			local x = v:random()
			if not x then
				break
			end
			v:remove(x)
			y[#y + 1] = x
			z = z + 1
		end
	end
	if #y == 0 then
		return
	end
	self.selecting = true
	self:SpendCharge()
	local function A(w, x)
		self.selecting = false
		r:learnAbility(x, true)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_artifact_ability_sr",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x,
			}
		)
		PlayerData:getplayerData(q):addArtifactAbilities(self:entindex(), x, true)
		self.debtRounds = self:GetSpecialValueFor("round")
	end
	if r:IsBotData() then
		A(nil, y[1])
		return
	end
	Selection:AddSpecialSelection(q, "ability_card", y, function(w, B)
		A(nil, B)
		return true
	end, nil, 0, true)
end
function p.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() <= 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	if self.selecting then
		self.error = "error_selection_in_progress"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function p.prototype.GetCustomCastError(self)
	return self.error
end
p = g({ l(nil) }, p)
i.item_artifact_138 = p
i.modifier_item_artifact_138 = c()
local C = i.modifier_item_artifact_138
C.name = "modifier_item_artifact_138"
d(C, n)
function C.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function C.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function C.prototype.OnRoundStart(self)
	local D = self:GetAbility()
	if not IsValid(D) or D.debtRounds <= 0 then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	local E = math.min(self.gold, math.max(0, PlayerData:getGold(q)))
	if E > 0 then
		PlayerData:modifyGold(q, -E)
	end
	D.debtRounds = D.debtRounds - 1
end
C = g(
	{
		o(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	C
)
i.modifier_item_artifact_138 = C
return i