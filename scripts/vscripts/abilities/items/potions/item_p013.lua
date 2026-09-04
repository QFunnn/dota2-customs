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
local item_P013 = __TS__Class()
item_P013.name = "item_P013"
__TS__ClassExtends(item_P013, BaseItem_CS)
function item_P013.prototype.Precache(self, context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_blast_off_fire.vpcf", context)
end
function item_P013.prototype.GetItemConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE,
		castAnimation = -1,
		onSuccess = function()
			self:OnSpellStart()
		end,
		onInterrupted = function() end,
	}
end
function item_P013.prototype.GetAOERadius(self)
	return 500
end
function item_P013.prototype.GetBehavior(self)
	return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end
function item_P013.prototype.OnSpellStart(self)
	local caster = self:GetCaster()
	local target_point = self:GetCursorPosition()
	self:PlayCastAnimation()
	local particle_cast = "particles/econ/items/monkey_king/arcana/fire/monkey_king_spring_arcana_fire.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect_cast, 0, target_point)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(500, 0, 0))
	ParticleManager:SetParticleControl(effect_cast, 2, Vector(500, 0, 0))
	ParticleManager:SetParticleControl(effect_cast, 3, Vector(500, 0, 0))
	ParticleManager:SetParticleControl(effect_cast, 4, Vector(500, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOnLocationWithCaster(target_point, "Hero_Techies.Suicide", caster)
	self:ExplodeBomb(target_point)
	self:SpendCharge(1)
end
function item_P013.prototype.PlayCastAnimation(self)
	local caster = self:GetCaster()
	caster:StartGesture(ACT_DOTA_ATTACK)
	local pfx = ParticleManager:CreateParticle(
		"particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step_dmg_flash.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		caster
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function item_P013.prototype.ExplodeBomb(self, position)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		500,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, unit in ipairs(enemies) do
		local damage = unit:GetMaxHealth() * 0.05 + 1000
		Damage:ApplyDamage({
			victim = unit,
			attacker = caster,
			damage = damage,
			damage_type = 4,
			damage_flag = ApplyDamageFlag.HP_LOSS,
			ability = self,
		})
	end
	ScreenShake(position, 8, 8, 1, 2000, 0, true)
	GridNav:DestroyTreesAroundPoint(position, 200, false)
	self:CostItemCharge(1)
end
item_P013 = __TS__DecorateLegacy({ registerAbility(nil) }, item_P013)
return ____exports