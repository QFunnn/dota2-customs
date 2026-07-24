--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_7\\boss_7_6"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 1,["2"] = 1,["9"] = 1,["10"] = 1,["11"] = 2,["12"] = 3,["13"] = 4,["14"] = 5,["15"] = 6,["16"] = 7,["17"] = 8,["18"] = 9,["19"] = 3,["20"] = 11,["21"] = 12,["22"] = 11,["23"] = 14,["24"] = 15,["25"] = 16,["26"] = 17,["27"] = 14,["28"] = 19,["29"] = 20,["30"] = 21,["31"] = 22,["32"] = 24,["33"] = 25,["34"] = 25,["35"] = 26,["36"] = 27,["37"] = 27,["38"] = 27,["39"] = 27,["40"] = 27,["41"] = 28,["42"] = 29,["43"] = 25,["44"] = 25,["45"] = 25,["46"] = 33,["47"] = 33,["48"] = 33,["49"] = 34,["50"] = 35,["51"] = 33,["52"] = 33,["53"] = 38,["54"] = 39,["55"] = 39,["56"] = 39,["57"] = 40,["58"] = 41,["59"] = 42,["61"] = 39,["62"] = 39,["63"] = 45,["64"] = 46,["65"] = 19,["66"] = 48,["67"] = 49,["68"] = 50,["69"] = 48,["70"] = 52,["71"] = 53,["72"] = 54,["73"] = 55,["74"] = 52,["75"] = 2,["76"] = 1,["77"] = 2,["79"] = 58,["80"] = 58,["81"] = 59,["82"] = 60,["83"] = 61,["84"] = 60,["85"] = 59,["86"] = 58,["87"] = 59,["89"] = 70,["90"] = 70,["91"] = 71,["92"] = 76,["93"] = 77,["94"] = 78,["95"] = 79,["96"] = 80,["97"] = 81,["98"] = 82,["100"] = 84,["101"] = 84,["102"] = 84,["103"] = 84,["104"] = 84,["105"] = 85,["106"] = 85,["107"] = 85,["108"] = 85,["109"] = 85,["110"] = 85,["111"] = 85,["112"] = 85,["114"] = 76,["115"] = 88,["116"] = 89,["117"] = 90,["118"] = 91,["120"] = 92,["121"] = 92,["122"] = 93,["123"] = 92,["126"] = 88,["127"] = 96,["128"] = 97,["129"] = 98,["130"] = 99,["131"] = 100,["132"] = 101,["133"] = 102,["136"] = 104,["137"] = 104,["138"] = 104,["139"] = 104,["140"] = 105,["141"] = 106,["142"] = 107,["143"] = 108,["144"] = 109,["147"] = 112,["148"] = 113,["152"] = 116,["153"] = 117,["154"] = 117,["155"] = 117,["156"] = 117,["157"] = 117,["158"] = 117,["159"] = 117,["160"] = 117,["161"] = 117,["162"] = 96,["163"] = 119,["164"] = 120,["165"] = 121,["166"] = 122,["167"] = 122,["168"] = 122,["169"] = 122,["170"] = 123,["171"] = 124,["173"] = 119,["174"] = 127,["175"] = 128,["176"] = 127,["177"] = 133,["178"] = 134,["179"] = 135,["180"] = 136,["181"] = 137,["183"] = 133,["184"] = 71,["185"] = 70,["186"] = 71,["188"] = 141,["189"] = 141,["190"] = 142,["191"] = 148,["192"] = 149,["193"] = 150,["194"] = 151,["195"] = 152,["196"] = 153,["197"] = 154,["198"] = 155,["199"] = 156,["201"] = 158,["202"] = 159,["203"] = 159,["204"] = 159,["205"] = 159,["206"] = 159,["207"] = 160,["208"] = 160,["209"] = 160,["210"] = 160,["211"] = 160,["212"] = 161,["214"] = 148,["215"] = 164,["216"] = 165,["217"] = 166,["218"] = 167,["219"] = 168,["220"] = 169,["221"] = 170,["222"] = 170,["223"] = 170,["224"] = 170,["225"] = 170,["226"] = 171,["227"] = 171,["228"] = 171,["229"] = 171,["230"] = 171,["231"] = 172,["232"] = 172,["233"] = 172,["234"] = 172,["235"] = 172,["236"] = 172,["237"] = 172,["238"] = 172,["239"] = 173,["240"] = 174,["241"] = 174,["242"] = 174,["243"] = 174,["244"] = 174,["245"] = 175,["246"] = 175,["247"] = 175,["248"] = 175,["249"] = 175,["250"] = 176,["251"] = 176,["252"] = 176,["253"] = 176,["254"] = 176,["255"] = 176,["256"] = 176,["257"] = 176,["258"] = 168,["259"] = 179,["260"] = 180,["262"] = 182,["263"] = 183,["264"] = 184,["265"] = 185,["266"] = 186,["269"] = 189,["270"] = 190,["271"] = 191,["272"] = 191,["273"] = 191,["274"] = 191,["275"] = 191,["276"] = 191,["277"] = 191,["278"] = 192,["279"] = 193,["280"] = 194,["281"] = 194,["282"] = 194,["283"] = 194,["284"] = 194,["285"] = 194,["286"] = 194,["287"] = 202,["288"] = 203,["289"] = 204,["294"] = 164,["295"] = 210,["296"] = 211,["297"] = 212,["299"] = 210,["300"] = 142,["301"] = 141,["302"] = 142,["304"] = 216,["305"] = 216,["306"] = 217,["307"] = 218,["308"] = 219,["310"] = 222,["311"] = 223,["312"] = 223,["313"] = 223,["314"] = 223,["315"] = 223,["316"] = 223,["317"] = 223,["318"] = 223,["319"] = 224,["320"] = 224,["321"] = 224,["322"] = 224,["323"] = 224,["324"] = 225,["325"] = 225,["326"] = 225,["327"] = 225,["328"] = 225,["329"] = 225,["330"] = 225,["331"] = 225,["333"] = 218,["334"] = 228,["335"] = 229,["336"] = 229,["337"] = 229,["338"] = 229,["339"] = 229,["340"] = 228,["341"] = 217,["342"] = 216,["343"] = 217,["345"] = 236,["346"] = 236,["347"] = 237,["348"] = 238,["349"] = 239,["350"] = 238,["351"] = 241,["352"] = 242,["353"] = 243,["355"] = 241,["356"] = 246,["357"] = 247,["358"] = 248,["360"] = 246,["361"] = 237,["362"] = 236,["363"] = 237,["365"] = 253,["366"] = 253,["367"] = 254,["368"] = 255,["369"] = 256,["370"] = 255,["371"] = 258,["372"] = 259,["373"] = 259,["374"] = 259,["375"] = 259,["376"] = 258,["377"] = 264,["378"] = 265,["379"] = 266,["381"] = 268,["383"] = 264,["384"] = 254,["385"] = 253,["386"] = 254});
boss_7_6 = __TS__Class()
boss_7_6.name = "boss_7_6"
__TS__ClassExtends(boss_7_6, BossAbility)
function boss_7_6.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_3/blink_start/blink_start.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_6/takeoff/takeoff.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_6/sun_strike/sun_strike.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_6/immortal/immortal.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_6/web_screen/web_screen.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_7/boss_7_6/web_root/web_root.vpcf", context)
end
function boss_7_6.prototype.GetChannelTime(self)
    return self.Values:duration()
end
function boss_7_6.prototype.OnChannelFinish(self, interrupted)
    local hCaster = self:GetCaster()
    hCaster:RemoveModifierByName("modifier_boss_7_6")
    hCaster:RemoveModifierByName("modifier_boss_7_6_buff")
end
function boss_7_6.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local fCastPoint = self:GetCastPoint()
    local fTotalDuration = fCastPoint + self.Values:duration()
    local vPosition = Vector(0, 0, 0)
    ParticleManager_s2c:ToClient(
        function()
            local iParticleID = ParticleManager_s2c:CreateParticle("particles/ablts_boss/boss_2/boss_2_3/blink_start.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                0,
                hCaster:GetAbsOrigin()
            )
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            FindClearSpaceForUnit(hCaster, vPosition, true)
        end,
        {weight = 0}
    )
    hCaster:GameTimer(
        0,
        function()
            hCaster:SetAbsOrigin(hCaster:GetAbsOrigin() + Vector(0, 0, 700))
            hCaster:SetForwardVector(Vector(0, -1, -1))
        end
    )
    GameRules:BeginNightstalkerNight(fTotalDuration)
    EachPlayer(
        _G,
        function(____, iPlayerID)
            local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
            if IsValid(hHero) then
                hHero:AddNewModifier(hCaster, self, "modifier_boss_7_6_black_debuff", {duration = fTotalDuration})
            end
        end
    )
    hCaster:AddNewModifier(hCaster, self, "modifier_boss_7_6", nil)
    return true
end
function boss_7_6.prototype.OnAbilityPhaseInterrupted(self)
    local hCaster = self:GetCaster()
    hCaster:RemoveModifierByName("modifier_boss_7_6")
end
function boss_7_6.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local duration = self.Values:duration()
    hCaster:AddNewModifier(hCaster, self, "modifier_boss_7_6_buff", {duration = duration})
end
boss_7_6 = __TS__DecorateLegacy(
    {register(_G)},
    boss_7_6
)
modifier_boss_7_6 = __TS__Class()
modifier_boss_7_6.name = "modifier_boss_7_6"
__TS__ClassExtends(modifier_boss_7_6, BaseModifier)
function modifier_boss_7_6.prototype.CheckState(self)
    return {[MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_UNSELECTABLE] = true}
end
modifier_boss_7_6 = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_7_6
)
modifier_boss_7_6_buff = __TS__Class()
modifier_boss_7_6_buff.name = "modifier_boss_7_6_buff"
__TS__ClassExtends(modifier_boss_7_6_buff, DiyModifier)
function modifier_boss_7_6_buff.prototype.OnCreated(self, params)
    if IsServer() then
        self.interval = self.Values:interval()
        self.dmg_duration = self.Values:dmg_duration()
        self.waring_time = self.Values:waring_time()
        self.count = self.Values:count()
        self:StartIntervalThink(self.interval)
    else
        local iParticleID = ParticleManager:CreateParticle(
            "particles/boss/boss_7/boss_7_6/takeoff/takeoff.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            self:GetParent()
        )
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
    end
end
function modifier_boss_7_6_buff.prototype.OnIntervalThink(self)
    local hCaster = self:GetCaster()
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    do
        local i = 0
        while i < self.count do
            self:CreatePoison()
            i = i + 1
        end
    end
end
function modifier_boss_7_6_buff.prototype.CreatePoison(self)
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    local nMaxAttempts = 10
    local nAttempts = 0
    local vPosition
    local hOverlappingThinker = {}
    repeat
        do
            vPosition = GetGroundPosition(
                hParent:GetAbsOrigin(),
                hParent
            ) + RandomVector(RandomInt(500, 3000))
            local hThinkerNearby = Entities:FindAllByClassnameWithin("npc_dota_thinker", vPosition, 600)
            hOverlappingThinker = {}
            for _, hThinker in pairs(hThinkerNearby) do
                if hThinker:HasModifier("modifier_boss_7_6_thinker") then
                    hOverlappingThinker[#hOverlappingThinker + 1] = hThinker
                end
            end
            nAttempts = nAttempts + 1
            if nAttempts >= nMaxAttempts then
                break
            end
        end
    until not (#hOverlappingThinker ~= 0)
    CreateModifierThinker(
        hParent,
        hAbility,
        "modifier_boss_7_6_thinker",
        {duration = self.dmg_duration + self.waring_time},
        vPosition,
        hParent:GetTeamNumber(),
        false
    )
end
function modifier_boss_7_6_buff.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        local vPosition = GetGroundPosition(
            hParent:GetAbsOrigin(),
            hParent
        )
        hParent:SetForwardVector(Vector(1, 0, 0))
        hParent:SetAbsOrigin(vPosition)
    end
end
function modifier_boss_7_6_buff.prototype.DDeclareFunctions(self)
    return {[MODIFIER_EVENT_ON_DEATH] = {}, [MODIFIER_PROPERTY_OVERRIDE_ANIMATION] = ACT_DOTA_GENERIC_CHANNEL_1}
end
function modifier_boss_7_6_buff.prototype.OnDeath(self, event)
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    if event.unit:IsHero() then
        hParent:AddNewModifier(hParent, hAbility, "modifier_boss_7_6_stack", {})
    end
end
modifier_boss_7_6_buff = __TS__DecorateLegacy(
    {diy(_G)},
    modifier_boss_7_6_buff
)
modifier_boss_7_6_thinker = __TS__Class()
modifier_boss_7_6_thinker.name = "modifier_boss_7_6_thinker"
__TS__ClassExtends(modifier_boss_7_6_thinker, BaseModifier)
function modifier_boss_7_6_thinker.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    self.radius = self.Values:radius()
    self.dmg_interval = self.Values:dmg_interval()
    self.dmg_factor = self.Values:dmg_factor()
    self.count = self.Values:count_1()
    self.waring_time = self.Values:waring_time()
    if IsServer() then
        self:StartIntervalThink(self.waring_time)
    else
        local iParticleID = ParticleManager:CreateParticle("particles/warning/circular.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(
            iParticleID,
            0,
            hParent:GetAbsOrigin()
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            2,
            Vector(self.radius, self.waring_time, 1 / self.waring_time)
        )
        ParticleManager:ReleaseParticleIndex(iParticleID)
    end
end
function modifier_boss_7_6_thinker.prototype.OnIntervalThink(self)
    if IsServer() then
        local hParent = self:GetParent()
        if self:GetStackCount() == 0 then
            ParticleManager_s2c:ToClient(function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_7/boss_7_6/sun_strike/sun_strike.vpcf", PATTACH_WORLDORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    0,
                    hParent:GetAbsOrigin()
                )
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    2,
                    Vector(self.radius, 0, 0)
                )
                self:AddParticle_s2c(
                    iParticleID,
                    false,
                    false,
                    -1,
                    false,
                    false
                )
                iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_7/boss_7_6/immortal/immortal.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    0,
                    hParent:GetAbsOrigin()
                )
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    1,
                    Vector(self.radius, self.radius, self.radius)
                )
                self:AddParticle_s2c(
                    iParticleID,
                    false,
                    false,
                    -1,
                    false,
                    false
                )
            end)
            self:IncrementStackCount()
            self:StartIntervalThink(self.dmg_interval)
        end
        if self:GetStackCount() == 1 then
            local hCaster = self:GetCaster()
            if not IsValid(hCaster) or not hCaster:IsAlive() then
                self:StartIntervalThink(-1)
                self:Destroy()
                return
            end
            local hAbility = self:GetAbility()
            local vPosition = hParent:GetAbsOrigin()
            local tTargets = FindUnitsInRadiusWithAbility(
                _G,
                hParent,
                hAbility,
                hParent:GetAbsOrigin(),
                self.radius
            )
            local fDamage = AttributeKind.Atk:Get(hCaster) * self.dmg_factor * self.dmg_interval
            for _, hTargets in pairs(tTargets) do
                ApplyDamage({
                    ability = hAbility,
                    attacker = hCaster,
                    victim = hTargets,
                    damage = fDamage,
                    damage_type = hAbility:GetAbilityDamageType()
                })
                local hAbility1 = hCaster:FindAbilityByName("boss_7_1")
                if IsValid(hAbility1) and hAbility1.CreateSpiderling then
                    hAbility1.CreateSpiderling(hAbility1, vPosition, self.count)
                end
            end
        end
    end
end
function modifier_boss_7_6_thinker.prototype.OnDestroy(self)
    if IsServer() then
        self:GetParent():RemoveSelf()
    end
end
modifier_boss_7_6_thinker = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_7_6_thinker
)
modifier_boss_7_6_black_debuff = __TS__Class()
modifier_boss_7_6_black_debuff.name = "modifier_boss_7_6_black_debuff"
__TS__ClassExtends(modifier_boss_7_6_black_debuff, DiyModifier)
function modifier_boss_7_6_black_debuff.prototype.OnCreated(self, params)
    if IsServer() then
    else
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_7/boss_7_6/web_screen/web_screen.vpcf", PATTACH_CUSTOMORIGIN, nil)
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
        iParticleID = ParticleManager:CreateParticle(
            "particles/boss/boss_7/boss_7_6/web_root/web_root.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            self:GetParent()
        )
        self:AddParticle(
            iParticleID,
            false,
            false,
            -1,
            false,
            false
        )
    end
end
function modifier_boss_7_6_black_debuff.prototype.DDeclareFunctions(self)
    return {
        [AttributeKind.Vision.DAY.OVERRIDE] = self.Values:vision_radius(),
        [AttributeKind.Vision.NIGHT.OVERRIDE] = self.Values:vision_radius(),
        [AttributeKind.MoveSpd.PCT] = -self.Values:reduce_move_speed_pct()
    }
end
modifier_boss_7_6_black_debuff = __TS__DecorateLegacy(
    {diy(_G)},
    modifier_boss_7_6_black_debuff
)
modifier_boss_7_6_stack = __TS__Class()
modifier_boss_7_6_stack.name = "modifier_boss_7_6_stack"
__TS__ClassExtends(modifier_boss_7_6_stack, BaseModifier)
function modifier_boss_7_6_stack.prototype.RemoveOnDeath(self)
    return false
end
function modifier_boss_7_6_stack.prototype.OnCreated(self, params)
    if IsServer() then
        self:IncrementStackCount()
    end
end
function modifier_boss_7_6_stack.prototype.OnRefresh(self, params)
    if IsServer() then
        self:IncrementStackCount()
    end
end
modifier_boss_7_6_stack = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_7_6_stack
)
modifier_boss_7_6_ai = __TS__Class()
modifier_boss_7_6_ai.name = "modifier_boss_7_6_ai"
__TS__ClassExtends(modifier_boss_7_6_ai, DiyModifier)
function modifier_boss_7_6_ai.prototype.IsHidden(self)
    return true
end
function modifier_boss_7_6_ai.prototype.DDeclareFunctions(self)
    return {
        [AttributeKind.HpMin] = function() return self:GetParent():GetMaxHealth() * 0.5 end,
        [MODIFIER_PROPERTY_MIN_HEALTH] = self.GetHpMin
    }
end
function modifier_boss_7_6_ai.prototype.GetHpMin(self)
    if IsServer() then
        return CBaseEntity.GetMaxHealth(self:GetParent()) * 0.5
    else
        return C_BaseEntity.GetMaxHealth(self:GetParent()) * 0.5
    end
end
modifier_boss_7_6_ai = __TS__DecorateLegacy(
    {diy(_G)},
    modifier_boss_7_6_ai
)