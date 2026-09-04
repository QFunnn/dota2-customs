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
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ROOT_DURATION = 2
local PROJECTILE_SPEED = 1100
local MUZZLE_FORWARD = 60
local MUZZLE_HEIGHT = 90
local NET_PROJECTILE = "particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net_projectile.vpcf"
local NET_ROOT_PARTICLE = "particles/units/heroes/hero_troll_warlord/troll_warlord_bersekers_net.vpcf"
--- 掷网：neutral troll_cast_net
local NET_CAST_SOUND = "n_creep_TrollWarlord.Ensnare"
--- 网缠身命中：naga ensnare_target，贴合定身
local NET_HIT_SOUND = "Hero_NagaSiren.Ensnare.Target"
--- 普通技能16 - 被动：攻击时掷网（内置冷却），命中束缚目标
____exports.normal_016 = __TS__Class()
local normal_016 = ____exports.normal_016
normal_016.name = "normal_016"
__TS__ClassExtends(normal_016, MonsterAbility_CS)
function normal_016.prototype.Precache(self, context)
	PrecacheResource("particle", NET_PROJECTILE, context)
	PrecacheResource("particle", NET_ROOT_PARTICLE, context)
end
function normal_016.prototype.GetMosnterAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE, castPoint = 0, castDuration = 0 }
end
function normal_016.prototype.GetIntrinsicModifierName(self)
	return "modifier_normal_016"
end
normal_016 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_016)
____exports.normal_016 = normal_016
local modifier_normal_016 = __TS__Class()
modifier_normal_016.name = "modifier_normal_016"
__TS__ClassExtends(modifier_normal_016, MonsterModifier_CS)
function modifier_normal_016.prototype.DeclareEvents(self)
	return { BusinessEvents.ON_ATTACK }
end
function modifier_normal_016.prototype.OnAttack_CS(self, event)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if event.attacker ~= parent then
		return
	end
	if event.is_sub_attack then
		return
	end
	local target = event.target
	if not target or not IsValidAlive(nil, target) then
		return
	end
	local ____opt_0 = target.GetUnitType
	local unitType = ____opt_0 and ____opt_0(target)
	if unitType == UnitType.BUILDING or unitType == UnitType.DESTRUCTIBLE then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end
	if not ability:IsCooldownReady() then
		return
	end
	local cd = ability:GetCooldown(ability:GetLevel())
	if cd <= 0 then
		return
	end
	ability:StartCooldown(cd)
	local startPoint =
		parent:GetAbsOrigin():__add(parent:GetForwardVector():__mul(MUZZLE_FORWARD)):__add(Vector(0, 0, MUZZLE_HEIGHT))
	EmitSoundOn(NET_CAST_SOUND, parent)
	CreateProjectile(nil, {
		ability = ability,
		caster = parent,
		effect_name = NET_PROJECTILE,
		projectile_type = "tracking",
		target = target,
		projectile_speed = PROJECTILE_SPEED,
		start_point = startPoint,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, parent) then
				return true
			end
			if hitTarget:GetTeamNumber() == parent:GetTeamNumber() then
				return true
			end
			EmitSoundOn(NET_HIT_SOUND, hitTarget)
			hitTarget:AddNewModifier(parent, ability, "modifier_normal_016_net", { duration = ROOT_DURATION })
			return true
		end,
	})
end
function modifier_normal_016.prototype.IsHidden(self)
	return true
end
function modifier_normal_016.prototype.IsPurgable(self)
	return false
end
modifier_normal_016 = __TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_016") }, modifier_normal_016)
local modifier_normal_016_net = __TS__Class()
modifier_normal_016_net.name = "modifier_normal_016_net"
__TS__ClassExtends(modifier_normal_016_net, MonsterModifier_CS)
function modifier_normal_016_net.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	self._rootPfx = ParticleManager:CreateParticle(NET_ROOT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControl(self._rootPfx, 0, parent:GetAbsOrigin())
end
function modifier_normal_016_net.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	if self._rootPfx ~= nil then
		ParticleManager:DestroyParticle(self._rootPfx, false)
		ParticleManager:ReleaseParticleIndex(self._rootPfx)
		self._rootPfx = nil
	end
end
function modifier_normal_016_net.prototype.CheckState(self)
	return { [MODIFIER_STATE_ROOTED] = true }
end
function modifier_normal_016_net.prototype.IsHidden(self)
	return false
end
function modifier_normal_016_net.prototype.IsDebuff(self)
	return true
end
function modifier_normal_016_net.prototype.IsPurgable(self)
	return true
end
modifier_normal_016_net =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_normal_016_net") }, modifier_normal_016_net)
return ____exports