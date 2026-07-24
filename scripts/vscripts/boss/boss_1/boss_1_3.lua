--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_1\\boss_1_3"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["12"] = 5,["13"] = 6,["14"] = 7,["15"] = 5,["16"] = 9,["17"] = 10,["18"] = 9,["19"] = 12,["20"] = 13,["21"] = 14,["22"] = 15,["23"] = 12,["24"] = 17,["25"] = 18,["26"] = 19,["27"] = 20,["28"] = 21,["29"] = 22,["30"] = 23,["31"] = 33,["32"] = 33,["33"] = 33,["34"] = 33,["35"] = 33,["36"] = 33,["37"] = 33,["38"] = 33,["39"] = 33,["40"] = 33,["41"] = 33,["42"] = 33,["43"] = 17,["44"] = 49,["45"] = 50,["46"] = 51,["47"] = 52,["48"] = 52,["49"] = 52,["50"] = 52,["51"] = 52,["52"] = 52,["53"] = 52,["56"] = 49,["57"] = 3,["58"] = 2,["59"] = 3,["61"] = 70,["62"] = 70,["63"] = 71,["64"] = 79,["65"] = 80,["66"] = 81,["67"] = 82,["68"] = 83,["69"] = 84,["70"] = 85,["71"] = 86,["72"] = 87,["73"] = 88,["74"] = 89,["75"] = 90,["77"] = 79,["78"] = 93,["79"] = 94,["80"] = 95,["81"] = 96,["82"] = 97,["83"] = 98,["84"] = 93,["85"] = 100,["86"] = 101,["87"] = 102,["88"] = 103,["90"] = 100,["91"] = 106,["92"] = 107,["93"] = 108,["95"] = 106,["96"] = 111,["97"] = 112,["98"] = 113,["99"] = 114,["100"] = 115,["101"] = 116,["102"] = 116,["103"] = 116,["104"] = 117,["105"] = 118,["106"] = 119,["107"] = 119,["108"] = 119,["109"] = 119,["110"] = 120,["112"] = 121,["113"] = 121,["114"] = 122,["115"] = 123,["116"] = 124,["117"] = 124,["118"] = 125,["119"] = 126,["120"] = 127,["121"] = 128,["122"] = 128,["123"] = 128,["124"] = 128,["125"] = 128,["126"] = 129,["127"] = 130,["128"] = 131,["129"] = 124,["130"] = 124,["131"] = 124,["132"] = 135,["133"] = 136,["134"] = 136,["135"] = 136,["136"] = 137,["137"] = 138,["138"] = 138,["139"] = 138,["140"] = 138,["141"] = 138,["142"] = 138,["143"] = 138,["144"] = 138,["145"] = 138,["146"] = 138,["147"] = 148,["148"] = 149,["149"] = 149,["150"] = 149,["151"] = 149,["152"] = 149,["153"] = 149,["154"] = 149,["155"] = 156,["156"] = 156,["157"] = 156,["158"] = 156,["159"] = 156,["160"] = 157,["161"] = 157,["162"] = 158,["163"] = 159,["164"] = 160,["165"] = 160,["166"] = 160,["167"] = 160,["168"] = 160,["169"] = 161,["170"] = 157,["171"] = 157,["172"] = 157,["173"] = 166,["174"] = 167,["177"] = 136,["178"] = 136,["179"] = 121,["183"] = 116,["184"] = 116,["185"] = 111,["186"] = 175,["187"] = 176,["188"] = 175,["189"] = 71,["190"] = 70,["191"] = 71});
boss_1_3 = __TS__Class()
boss_1_3.name = "boss_1_3"
__TS__ClassExtends(boss_1_3, BaseAbility)
function boss_1_3.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/econ/items/elder_titan/elder_titan_2021/elder_titan_2021_earth_splitter.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_elder_titan/elder_titan_earth_splitter_move.vpcf", context)
end
function boss_1_3.prototype.GetChannelTime(self)
    return self.Values:duration()
end
function boss_1_3.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local duration = self.Values:duration()
    hCaster:AddNewModifier(hCaster, self, "modifier_boss_1_3_buff", {duration = duration})
end
function boss_1_3.prototype.OnLine(self, vStartPosition, vDirection, fDamage)
    local hCaster = self:GetCaster()
    local fSpeed = self.Values:speed()
    local crack_width = self.Values:crack_width()
    local crack_distance = self.Values:crack_distance()
    local crack_time = self.Values:crack_time()
    local vPosition = vStartPosition + vDirection * crack_distance
    ProjectileManager:CreateLinearProjectile({
        Ability = self,
        Source = hCaster,
        vSpawnOrigin = vStartPosition,
        vVelocity = fSpeed * vDirection,
        fDistance = crack_distance,
        fStartRadius = crack_width,
        fEndRadius = crack_width,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        ExtraData = {fDamage = fDamage}
    })
end
function boss_1_3.prototype.OnProjectileHit_ExtraData(self, target, location, extraData)
    if IsValid(target) then
        local hCaster = self:GetCaster()
        ApplyDamage({
            ability = self,
            attacker = hCaster,
            victim = target,
            damage = extraData.fDamage,
            damage_type = DAMAGE_TYPE_PHYSICAL
        })
    else
    end
end
boss_1_3 = __TS__DecorateLegacy(
    {register(_G)},
    boss_1_3
)
modifier_boss_1_3_buff = __TS__Class()
modifier_boss_1_3_buff.name = "modifier_boss_1_3_buff"
__TS__ClassExtends(modifier_boss_1_3_buff, BaseModifier)
function modifier_boss_1_3_buff.prototype.OnCreated(self, params)
    self.crack_distance = self.Values:crack_distance()
    self.crack_time = self.Values:crack_time()
    self.min_count = self.Values:min_count()
    self.max_count = self.Values:max_count()
    self.crack_width = self.Values:crack_width()
    self.dmg_factor = self.Values:dmg_factor()
    if IsServer() then
        local hParent = self:GetParent()
        local hAbility = self:GetAbility()
        self.fDamage = AttributeKind.Atk:Get(hParent) * self.dmg_factor
        self:OnFire()
    end
end
function modifier_boss_1_3_buff.prototype.GetCenterPos(self, p1, p2, p3)
    local dx = p1.x - p2.x
    local dy = p1.y - p2.y
    local u = (p3.x - p1.x) * dx + (p3.y - p1.y) * dy
    u = u / (dx * dx + dy * dy)
    return Vector(p1.x + u * dx, p1.y + u * dy, p1.z)
end
function modifier_boss_1_3_buff.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        hParent:RemoveGesture(ACT_DOTA_DEFEAT)
    end
end
function modifier_boss_1_3_buff.prototype.OnIntervalThink(self)
    if IsServer() then
        self:OnFire()
    end
end
function modifier_boss_1_3_buff.prototype.OnFire(self)
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    hParent:StartGestureWithPlaybackRate(ACT_DOTA_DEFEAT, 1)
    self:StartIntervalThink(2.3)
    hParent:GameTimer(
        1.6,
        function()
            if IsValid(hParent) and hParent:IsAlive() and IsValid(self) and IsValid(hAbility) then
                local vDirection = RandomVector(1)
                local vStartPosition = GetGroundPosition(
                    hParent:GetAttachmentOrigin(hParent:ScriptLookupAttachment("attach_mouth")),
                    hParent
                )
                local count = RandomInt(self.min_count, self.max_count)
                do
                    local i = 0
                    while i < count - 1 do
                        local vTempDirection = Rotation2D(vDirection, 360 / count * i)
                        local vPostion = vStartPosition + vTempDirection * (self.crack_distance + self.crack_width)
                        ParticleManager_s2c:ToClient(
                            function()
                                local iParticleID = ParticleManager_s2c:CreateParticle("particles/econ/items/elder_titan/elder_titan_2021/elder_titan_2021_earth_splitter.vpcf", PATTACH_CUSTOMORIGIN, nil)
                                ParticleManager_s2c:SetParticleControl(iParticleID, 0, vStartPosition)
                                ParticleManager_s2c:SetParticleControl(iParticleID, 1, vPostion)
                                ParticleManager_s2c:SetParticleControl(
                                    iParticleID,
                                    3,
                                    Vector(0, self.crack_time, 0)
                                )
                                ParticleManager_s2c:SetParticleControl(iParticleID, 11, vPostion)
                                ParticleManager_s2c:SetParticleControl(iParticleID, 12, vPostion)
                                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                            end,
                            {weight = 0}
                        )
                        hAbility:OnLine(vStartPosition, vTempDirection, self.fDamage)
                        hParent:GameTimer(
                            self.crack_time,
                            function()
                                if IsValid(hParent) and hParent:IsAlive() and IsValid(hAbility) and IsValid(self) then
                                    local tTargets = FindUnitsInLine(
                                        hParent:GetTeamNumber(),
                                        vStartPosition,
                                        vPostion,
                                        nil,
                                        self.crack_width + 100,
                                        DOTA_UNIT_TARGET_TEAM_ENEMY,
                                        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                                        DOTA_UNIT_TARGET_FLAG_NONE
                                    )
                                    for _, hTarget in ipairs(tTargets) do
                                        ApplyDamage({
                                            ability = hAbility,
                                            attacker = hParent,
                                            victim = hTarget,
                                            damage = self.fDamage,
                                            damage_type = DAMAGE_TYPE_PHYSICAL
                                        })
                                        local vCenterPosition = self:GetCenterPos(
                                            vStartPosition,
                                            vPostion,
                                            hTarget:GetAbsOrigin()
                                        )
                                        ParticleManager_s2c:ToClient(
                                            function()
                                                local iParticleID = ParticleManager_s2c:CreateParticle("particles/units/heroes/hero_elder_titan/elder_titan_earth_splitter_move.vpcf", PATTACH_ABSORIGIN_FOLLOW, hTarget)
                                                ParticleManager_s2c:SetParticleControl(iParticleID, 0, vCenterPosition)
                                                ParticleManager_s2c:SetParticleControl(
                                                    iParticleID,
                                                    1,
                                                    hTarget:GetAbsOrigin()
                                                )
                                                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                                            end,
                                            {weight = 0}
                                        )
                                        hTarget:InterruptChannel()
                                        FindClearSpaceForUnit(hTarget, vCenterPosition, true)
                                    end
                                end
                            end
                        )
                        i = i + 1
                    end
                end
            end
        end
    )
end
function modifier_boss_1_3_buff.prototype.CheckState(self)
    return {[MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true, [MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true}
end
modifier_boss_1_3_buff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_1_3_buff
)