--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_minigames_mirana_leap", "abilities/minigames/leap.lua", LUA_MODIFIER_MOTION_NONE )

minigames_mirana_leap = class({})

function minigames_mirana_leap:OnSpellStart()
    local caster = self:GetCaster()

    caster:AddNewModifier(caster, self, "modifier_minigames_mirana_leap", {})
end

modifier_minigames_mirana_leap = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

    CheckState				= function(self)
		return {
			[MODIFIER_STATE_ROOTED] = true,
		}
	end,

    DeclareFunctions        = function(self)
        return {
            MODIFIER_PROPERTY_DISABLE_TURNING,
        }
    end,

    GetModifierDisableTurning   = function(self)
        return 1
    end,

    OnCreated               = function(self)
        local parent = self:GetParent()
        local ability = self:GetAbility()
        if ability then
            self.Distance = ability:GetSpecialValueFor("distance")
            self.Speed = ability:GetSpecialValueFor("speed") * 0.033
            self.ZSpeed = self.Distance * 0.033
        end

        if not IsServer() then return end

        parent:StartGesture(ACT_DOTA_OVERRIDE_ABILITY_3)

        self.Direction = parent:GetForwardVector()

        self.Travelled = 0
        self.ZTravelled = 0

        parent:EmitSound("Minigames.Leap")

        self:StartIntervalThink(0.033)
    end,

    OnDestroy               = function(self)
        if not IsServer() then return end

        local parent = self:GetParent()

        FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
        ResolveNPCPositions(parent:GetAbsOrigin(), 150)

        parent:StartGesture(ACT_MIRANA_LEAP_END)
    end,

    OnIntervalThink         = function(self)
        local parent = self:GetParent()
        if parent and not parent:IsNull() and parent:IsAlive() then
            if self.Travelled < self.Distance then
                local Pos = GetGroundPosition(parent:GetAbsOrigin(), parent)
                Pos = Pos + self.Direction * self.Speed
                
                local zSign = self.Travelled < self.Distance / 2 and 1 or -1
                self.ZTravelled = math.max(self.ZTravelled + (self.ZSpeed * zSign), 0)

                Pos.z = Pos.z + self.ZTravelled

                parent:SetAbsOrigin(Pos)

                self.Travelled = self.Travelled + self.Speed
            else
                self:Destroy()
            end
        else
            self:Destroy()
        end
    end,
})