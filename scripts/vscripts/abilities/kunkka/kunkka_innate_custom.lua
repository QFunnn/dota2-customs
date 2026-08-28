--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_kunkka_innate_custom_tracker",
	"abilities/kunkka/kunkka_innate_custom",
	LUA_MODIFIER_MOTION_NONE
)

kunkka_innate_custom = class({})
kunkka_innate_custom.talents = {}

function kunkka_innate_custom:Precache(context)
	if self:GetCaster() and self:GetCaster():IsIllusion() then
		return
	end

	PrecacheResource("soundfile", "soundevents/npc_dota_hero_kunkka.vsndevts", context)
	dota1x6:PrecacheShopItems("npc_dota_hero_kunkka", context)
end

function kunkka_innate_custom:UpdateTalents(name)
	local caster = self:GetCaster()
	if not self.init then
		self.init = true
		self.talents = {}
	end
end

function kunkka_innate_custom:GetIntrinsicModifierName()
	if not self:GetCaster():IsRealHero() then
		return
	end
	return "modifier_kunkka_innate_custom_tracker"
end

modifier_kunkka_innate_custom_tracker = class(mod_hidden)
function modifier_kunkka_innate_custom_tracker:OnCreated(table)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.ability.tracker = self
	self.ability:UpdateTalents()

	self.parent.kunkka_innate = self.ability
end