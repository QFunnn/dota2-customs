--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_vengefulspirit_7=class({})

function modifier_vengefulspirit_7:IsHidden() return true end
function modifier_vengefulspirit_7:IsPurgable() return false end
function modifier_vengefulspirit_7:IsPurgeException() return false end
function modifier_vengefulspirit_7:RemoveOnDeath() return false end

function modifier_vengefulspirit_7:OnCreated()
	if not IsServer() then return end
    self.damage = 0
	self:SetStackCount(1)
end

function modifier_vengefulspirit_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_vengefulspirit_7:DeclareFunctions()
	return 
    {
		 
	}
end

function modifier_vengefulspirit_7:OnTakeDamage(params)
	if not IsServer() then return end
	if params.unit ~= self:GetParent() then return end
	if not self:GetParent():IsAlive() then return end
    self.damage = self.damage + params.damage
	if self.damage >= self:GetParent():GetMaxHealth() / 100 * 40 then
		local point = self:GetCaster():GetAbsOrigin() + RandomVector(RandomInt(100, 600))
        local ill = CreateIllusions(self:GetCaster(), self:GetCaster(), {duration=7,outgoing_damage=-50,incoming_damage=100}, 1, 1, false, false)
        FindClearSpaceForUnit(ill[1], point, true)
        ill[1]:SetHealth(ill[1]:GetMaxHealth())
        self.damage = 0
	end
end