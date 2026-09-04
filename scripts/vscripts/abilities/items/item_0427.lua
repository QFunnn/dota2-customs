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
local _____base_item = require("abilities.items._base_item")
local BaseItem_CS = _____base_item.BaseItem_CS
local particleName = "particles/items_fx/arcane_boots.vpcf"
local particleName2 = "particles/items_fx/arcane_boots_recipient.vpcf"
local soundName = "DOTA_Item.ArcaneBoots.Activate"
____exports.item_0427 = __TS__Class()
local item_0427 = ____exports.item_0427
item_0427.name = "item_0427"
__TS__ClassExtends(item_0427, BaseItem_CS)
function item_0427.prototype.Precache(self, context)
	PrecacheResource("particle", particleName, context)
	PrecacheResource("particle", particleName2, context)
end
function item_0427.prototype.GetItemConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE }
end
function item_0427.prototype.OnSpellStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ability_radius = math.max(0, self:GetSpecialValueFor("ability_radius"))
	local ability_mana_restore = math.max(0, self:GetSpecialValueFor("ability_mana_restore"))
	if ability_radius <= 0 or ability_mana_restore <= 0 then
		return
	end
	self:PlayEffects1(caster)
	local heroes = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		ability_radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, hero in ipairs(heroes) do
		do
			if not IsValidAlive(nil, hero) then
				goto __continue8
			end
			hero:GiveMana(ability_mana_restore)
			self:PlayEffects2(caster, hero)
		end
		::__continue8::
	end
end
function item_0427.prototype.PlayEffects1(self, caster)
	local particle_cast =
		MyGameHeroParticleManager:CreateParticle(particleName, PATTACH_ABSORIGIN_FOLLOW, caster, caster)
	MyGameHeroParticleManager:SetParticleControl(particle_cast, 0, caster:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(particle_cast)
	caster:EmitSound(soundName)
end
function item_0427.prototype.PlayEffects2(self, caster, target)
	local particle_recipient =
		MyGameHeroParticleManager:CreateParticle(particleName2, PATTACH_ABSORIGIN_FOLLOW, target, caster)
	MyGameHeroParticleManager:SetParticleControl(particle_recipient, 0, target:GetAbsOrigin())
	MyGameHeroParticleManager:ReleaseParticleIndex(particle_recipient)
end
item_0427 = __TS__DecorateLegacy({ registerAbility(nil) }, item_0427)
____exports.item_0427 = item_0427
return ____exports