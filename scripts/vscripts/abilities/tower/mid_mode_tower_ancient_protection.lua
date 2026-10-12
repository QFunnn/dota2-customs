--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- abilities/tower/mid_mode_tower_ancient_protection.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"abilities/tower/mid_mode_tower_ancient_protection.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "2:27",
		["15"] = "2:40",
		["16"] = "4:1",
		["17"] = "5:14",
		["18"] = "4:1",
		["19"] = "5:48",
		["20"] = "6:5",
		["21"] = "7:15",
		["22"] = "8:13",
		["23"] = "9:13",
		["25"] = "6:5",
		["26"] = "5:14",
		["27"] = "4:2",
		["28"] = "4:2",
		["29"] = "4:2",
		["31"] = "4:2",
		["32"] = "5:14",
		["34"] = "5:14",
		["35"] = "18:1",
		["36"] = "19:14",
		["37"] = "18:1",
		["38"] = "19:57",
		["39"] = "20:5",
		["40"] = "21:9",
		["41"] = "20:5",
		["42"] = "24:5",
		["43"] = "25:9",
		["44"] = "24:5",
		["45"] = "28:5",
		["46"] = "29:14",
		["49"] = "30:15",
		["50"] = "31:15",
		["51"] = "32:13",
		["52"] = "33:19",
		["53"] = "34:13",
		["54"] = "36:21",
		["55"] = "37:21",
		["57"] = "40:22",
		["58"] = "41:21",
		["62"] = "28:5",
		["63"] = "47:5",
		["64"] = "48:13",
		["67"] = "50:15",
		["68"] = "51:15",
		["69"] = "52:9",
		["70"] = "52:48",
		["71"] = "52:53",
		["72"] = "52:56",
		["73"] = "52:9",
		["74"] = "52:95",
		["75"] = "52:112",
		["76"] = "52:122",
		["77"] = "52:9",
		["78"] = "53:9",
		["79"] = "53:48",
		["80"] = "53:53",
		["81"] = "53:56",
		["82"] = "53:9",
		["83"] = "53:99",
		["84"] = "53:105",
		["85"] = "53:115",
		["86"] = "53:9",
		["87"] = "54:9",
		["88"] = "56:9",
		["89"] = "56:37",
		["90"] = "56:52",
		["91"] = "56:9",
		["92"] = "57:9",
		["93"] = "47:5",
		["94"] = "62:5",
		["95"] = "63:14",
		["98"] = "65:15",
		["99"] = "66:15",
		["100"] = "67:9",
		["101"] = "67:48",
		["102"] = "67:53",
		["103"] = "67:56",
		["104"] = "67:9",
		["105"] = "67:95",
		["106"] = "67:112",
		["107"] = "67:122",
		["108"] = "67:9",
		["109"] = "68:9",
		["110"] = "68:48",
		["111"] = "68:53",
		["112"] = "68:56",
		["113"] = "68:9",
		["114"] = "68:99",
		["115"] = "68:105",
		["116"] = "68:115",
		["117"] = "68:9",
		["118"] = "69:9",
		["119"] = "70:9",
		["120"] = "70:45",
		["121"] = "70:51",
		["122"] = "70:98",
		["123"] = "70:9",
		["124"] = "72:9",
		["125"] = "72:37",
		["126"] = "72:49",
		["127"] = "72:9",
		["128"] = "73:9",
		["129"] = "73:37",
		["130"] = "73:51",
		["131"] = "73:9",
		["132"] = "75:9",
		["133"] = "75:28",
		["134"] = "75:9",
		["135"] = "75:100",
		["136"] = "75:107",
		["137"] = "75:113",
		["138"] = "75:9",
		["139"] = "76:9",
		["140"] = "76:33",
		["141"] = "76:80",
		["143"] = "76:9",
		["144"] = "62:5",
		["145"] = "19:14",
		["146"] = "18:2",
		["147"] = "18:2",
		["148"] = "18:19",
		["149"] = "18:2",
		["151"] = "18:2",
		["152"] = "19:14",
		["154"] = "19:14",
	}
)
local ____exports = {}
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerModifier = ____dota_ts_adapter.registerModifier
____exports.mid_mode_tower_ancient_protection = __TS__Class()
local mid_mode_tower_ancient_protection = ____exports.mid_mode_tower_ancient_protection
mid_mode_tower_ancient_protection.name = "mid_mode_tower_ancient_protection"
__TS__ClassExtends(mid_mode_tower_ancient_protection, BaseAbility)
function mid_mode_tower_ancient_protection.prototype.GetIntrinsicModifierName(self)
	local level = self:GetLevel()
	if level >= 1 then
		return ____exports.modifier_mid_mode_tower_ancient_protection.name
	end
end
mid_mode_tower_ancient_protection =
	__TS__Decorate({ registerAbility(nil, nil, getfenv()) }, mid_mode_tower_ancient_protection)
____exports.mid_mode_tower_ancient_protection = mid_mode_tower_ancient_protection
____exports.modifier_mid_mode_tower_ancient_protection = __TS__Class()
local modifier_mid_mode_tower_ancient_protection = ____exports.modifier_mid_mode_tower_ancient_protection
modifier_mid_mode_tower_ancient_protection.name = "modifier_mid_mode_tower_ancient_protection"
__TS__ClassExtends(modifier_mid_mode_tower_ancient_protection, SLModifierBase)
function modifier_mid_mode_tower_ancient_protection.prototype.AllowIllusionDuplicate(self)
	return false
end
function modifier_mid_mode_tower_ancient_protection.prototype.DeclareFunctions(self)
	return { MODIFIER_EVENT_ON_DEATH }
end
function modifier_mid_mode_tower_ancient_protection.prototype.OnDeath(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local unit = event.unit
	if IsValid(parent) and IsValid(unit) and parent == unit then
		local team = parent:GetTeam()
		for ____, hero in ipairs(HeroList:GetAllRealHeroes()) do
			if hero:GetTeam() ~= team and hero:HasShard() and not hero:IsMonkeyArmy() and not IsTempstDouble(hero) then
				self:GiveBonus(hero)
			end
			if not hero:HasShard() and not hero:IsMonkeyArmy() and not IsTempstDouble(hero) then
				self:GiveShard(hero)
			end
		end
	end
end
function modifier_mid_mode_tower_ancient_protection.prototype.GiveShard(self, hero)
	if hero:HasShard() then
		return
	end
	local hero_pos = hero:GetAbsOrigin()
	local pid = SParticleManager:CreateGenericParticle(
		GENERIC_PARTICLES.mid_tower_reward_shard,
		PATTACH_CUSTOMORIGIN_FOLLOW,
		hero
	)
	SParticleManager:SetParticleControlEnt(pid, 0, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero_pos, false)
	SParticleManager:SetParticleControlEnt(pid, 1, hero, PATTACH_ABSORIGIN_FOLLOW, nil, hero_pos, false)
	SParticleManager:ReleaseParticleIndex(pid)
	EmitAnnouncerSoundForPlayer("tower_shard", hero:GetPlayerOwnerID())
	hero:AddSLModifier("modifier_item_aghanims_shard", { caster = hero })
end
function modifier_mid_mode_tower_ancient_protection.prototype.GiveBonus(self, hero)
	if not hero:HasShard() then
		return
	end
	local pid = SParticleManager:CreateGenericParticle(
		GENERIC_PARTICLES.mid_tower_reward_resource,
		PATTACH_CUSTOMORIGIN_FOLLOW,
		hero
	)
	local hero_pos = hero:GetAbsOrigin()
	SParticleManager:SetParticleControlEnt(pid, 0, hero, PATTACH_POINT_FOLLOW, "attach_hitloc", hero_pos, false)
	SParticleManager:SetParticleControlEnt(pid, 1, hero, PATTACH_ABSORIGIN_FOLLOW, nil, hero_pos, false)
	SParticleManager:ReleaseParticleIndex(pid)
	SLModules.ClientData:PushNumberData(hero, self:GetAbilitySpecialValueFor("gold_bounus"), 4)
	EmitAnnouncerSoundForPlayer("tower_xp", hero:GetPlayerOwnerID())
	EmitAnnouncerSoundForPlayer("tower_gold", hero:GetPlayerOwnerID())
	hero:AddExperience(self:GetAbilitySpecialValueFor("xp_bonus"), DOTA_ModifyXP_Unspecified, false, true, 0)
	hero:ModifyGoldFiltered(self:GetAbilitySpecialValueFor("gold_bounus"), false, DOTA_ModifyGold_Unspecified)
end
modifier_mid_mode_tower_ancient_protection = __TS__Decorate(
	{ registerModifier(nil, "abilities/tower/mid_mode_tower_ancient_protection", nil, getfenv()) },
	modifier_mid_mode_tower_ancient_protection
)
____exports.modifier_mid_mode_tower_ancient_protection = modifier_mid_mode_tower_ancient_protection
return ____exports