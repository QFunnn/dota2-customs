--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("game/upgrades/generic_upgrades/modifier_base_generic_upgrade")
modifier_generic_auto_rune_upgrade = class(modifier_base_generic_upgrade)

modifier_generic_auto_rune_upgrade.rune_cycle = {
	"modifier_rune_arcane",
	"modifier_rune_doubledamage",
	"modifier_rune_haste",
	"modifier_rune_regen",
	"modifier_rune_shield",
}

modifier_generic_auto_rune_upgrade.rune_sound_map = {
	modifier_rune_arcane = "Rune.Arcane",
	modifier_rune_doubledamage = "Rune.DD",
	modifier_rune_haste = "Rune.Haste",
	modifier_rune_regen = "Rune.Regen",
	modifier_rune_shield = "Rune.Shield",
}

function modifier_generic_auto_rune_upgrade:AllowIllusionDuplicate() return false end

function modifier_generic_auto_rune_upgrade:OnCreated()
	-- GetUpgradeValueFor takes value from Specials array in generics.txt
	-- defined at both client and server
	self.rune_buff_interval = self:GetUpgradeValueFor("interval")
	self.rune_duration = self:GetUpgradeValueFor("rune_duration")

	local parent = self:GetParent()

	if IsServer() and IsValidEntity(parent) and not (parent:IsIllusion() or parent:IsMonkeyKingSoldier()) then
		self.rune_index = 1
		self:StartIntervalThink(self.rune_buff_interval)
		self:OnIntervalThink()
	end
end


function modifier_generic_auto_rune_upgrade:OnIntervalThink()
	-- they can't use runes when they're dead, right?
	if not self:GetParent():IsAlive() then
		self:StartIntervalThink(1)
		return
	end

	local rune_name = self.rune_cycle[self.rune_index]
	self:GetParent():AddNewModifier(self:GetParent(), nil, rune_name, {duration = self.rune_duration})
	EmitSoundOn(self.rune_sound_map[rune_name], self:GetParent())

	self.rune_index = self.rune_index % #self.rune_cycle + 1
	self:StartIntervalThink(self.rune_buff_interval)
end