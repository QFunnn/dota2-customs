--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_5\\boss_5_6"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["9"] = 2,["10"] = 2,["11"] = 3,["13"] = 3,["14"] = 4,["15"] = 2,["16"] = 5,["17"] = 6,["18"] = 7,["19"] = 8,["20"] = 9,["21"] = 10,["22"] = 11,["23"] = 12,["24"] = 13,["25"] = 5,["26"] = 15,["27"] = 16,["28"] = 15,["29"] = 18,["30"] = 19,["31"] = 18,["32"] = 21,["33"] = 22,["34"] = 23,["35"] = 24,["36"] = 25,["38"] = 26,["39"] = 26,["40"] = 27,["41"] = 28,["42"] = 28,["43"] = 28,["44"] = 29,["45"] = 30,["46"] = 30,["47"] = 30,["48"] = 30,["49"] = 31,["50"] = 32,["51"] = 32,["52"] = 33,["53"] = 34,["54"] = 35,["55"] = 36,["56"] = 37,["57"] = 37,["58"] = 37,["59"] = 37,["60"] = 37,["61"] = 37,["62"] = 37,["63"] = 37,["64"] = 37,["65"] = 38,["66"] = 39,["67"] = 39,["68"] = 32,["69"] = 32,["70"] = 32,["71"] = 28,["72"] = 28,["73"] = 26,["76"] = 45,["77"] = 45,["78"] = 45,["79"] = 46,["80"] = 45,["81"] = 45,["82"] = 48,["83"] = 49,["84"] = 21,["85"] = 52,["86"] = 53,["87"] = 54,["88"] = 55,["89"] = 56,["90"] = 57,["91"] = 58,["92"] = 59,["93"] = 59,["94"] = 59,["95"] = 59,["96"] = 59,["97"] = 59,["98"] = 59,["99"] = 59,["100"] = 59,["101"] = 60,["102"] = 60,["103"] = 60,["104"] = 60,["105"] = 60,["106"] = 60,["107"] = 60,["108"] = 60,["109"] = 60,["110"] = 61,["111"] = 62,["112"] = 63,["113"] = 63,["114"] = 63,["115"] = 64,["116"] = 65,["118"] = 66,["119"] = 66,["120"] = 67,["121"] = 67,["122"] = 67,["124"] = 67,["126"] = 67,["127"] = 68,["128"] = 69,["129"] = 69,["130"] = 70,["131"] = 71,["132"] = 72,["133"] = 69,["134"] = 69,["135"] = 69,["136"] = 66,["139"] = 77,["140"] = 78,["142"] = 63,["143"] = 63,["144"] = 52,["145"] = 82,["146"] = 83,["147"] = 84,["148"] = 84,["149"] = 85,["150"] = 86,["152"] = 84,["153"] = 84,["154"] = 84,["155"] = 91,["156"] = 82,["157"] = 93,["158"] = 94,["159"] = 95,["160"] = 96,["161"] = 96,["162"] = 96,["163"] = 97,["164"] = 98,["165"] = 96,["166"] = 96,["167"] = 100,["168"] = 100,["169"] = 101,["170"] = 102,["171"] = 102,["172"] = 102,["173"] = 102,["174"] = 102,["175"] = 103,["176"] = 103,["177"] = 103,["178"] = 103,["179"] = 103,["180"] = 104,["181"] = 105,["182"] = 100,["183"] = 100,["184"] = 100,["185"] = 109,["186"] = 93,["187"] = 111,["188"] = 112,["189"] = 111,["190"] = 114,["191"] = 115,["192"] = 115,["193"] = 116,["194"] = 117,["196"] = 115,["197"] = 115,["198"] = 115,["199"] = 114,["200"] = 3,["201"] = 2,["202"] = 3,["204"] = 125,["205"] = 125,["206"] = 126,["207"] = 127,["208"] = 128,["209"] = 127,["210"] = 126,["211"] = 125,["212"] = 126,["214"] = 135,["215"] = 135,["216"] = 136,["217"] = 137,["218"] = 138,["219"] = 137,["220"] = 140,["221"] = 141,["222"] = 140,["223"] = 145,["224"] = 146,["225"] = 145,["226"] = 136,["227"] = 135,["228"] = 136,["230"] = 149,["231"] = 149,["232"] = 150,["234"] = 150,["235"] = 159,["236"] = 149,["237"] = 160,["238"] = 161,["239"] = 160,["240"] = 163,["241"] = 164,["242"] = 165,["243"] = 166,["244"] = 167,["245"] = 168,["246"] = 169,["247"] = 170,["248"] = 171,["249"] = 172,["250"] = 173,["251"] = 174,["252"] = 175,["253"] = 176,["255"] = 163,["256"] = 179,["257"] = 180,["258"] = 181,["259"] = 182,["260"] = 183,["261"] = 184,["262"] = 186,["263"] = 187,["264"] = 188,["265"] = 189,["266"] = 190,["269"] = 194,["270"] = 195,["272"] = 196,["273"] = 196,["274"] = 197,["275"] = 197,["276"] = 197,["277"] = 197,["278"] = 197,["279"] = 196,["282"] = 202,["283"] = 203,["286"] = 179,["287"] = 207,["288"] = 208,["289"] = 209,["290"] = 210,["291"] = 211,["292"] = 212,["293"] = 213,["294"] = 214,["295"] = 215,["296"] = 215,["297"] = 215,["298"] = 215,["299"] = 215,["300"] = 215,["301"] = 215,["302"] = 215,["303"] = 215,["304"] = 216,["305"] = 216,["306"] = 216,["307"] = 216,["308"] = 216,["309"] = 216,["310"] = 216,["311"] = 216,["312"] = 216,["313"] = 217,["314"] = 218,["315"] = 218,["316"] = 219,["317"] = 220,["318"] = 221,["319"] = 221,["320"] = 221,["321"] = 221,["322"] = 221,["323"] = 222,["324"] = 218,["325"] = 218,["326"] = 218,["327"] = 226,["328"] = 227,["329"] = 227,["330"] = 227,["331"] = 228,["332"] = 228,["333"] = 229,["334"] = 230,["335"] = 231,["336"] = 231,["337"] = 231,["338"] = 231,["339"] = 231,["340"] = 232,["341"] = 233,["342"] = 228,["343"] = 228,["344"] = 228,["345"] = 237,["346"] = 237,["347"] = 237,["348"] = 237,["349"] = 237,["350"] = 237,["351"] = 237,["352"] = 238,["353"] = 239,["354"] = 240,["355"] = 242,["356"] = 243,["357"] = 244,["359"] = 246,["360"] = 247,["361"] = 248,["362"] = 249,["363"] = 249,["364"] = 249,["365"] = 249,["366"] = 249,["367"] = 249,["368"] = 249,["369"] = 256,["370"] = 257,["371"] = 257,["372"] = 257,["373"] = 257,["374"] = 257,["375"] = 257,["376"] = 257,["377"] = 257,["378"] = 257,["382"] = 227,["383"] = 227,["385"] = 207,["386"] = 272,["387"] = 273,["388"] = 274,["389"] = 275,["390"] = 276,["391"] = 277,["392"] = 277,["393"] = 278,["394"] = 279,["396"] = 277,["397"] = 277,["398"] = 277,["399"] = 284,["401"] = 272,["402"] = 287,["403"] = 288,["404"] = 289,["405"] = 290,["406"] = 291,["407"] = 292,["410"] = 295,["411"] = 287,["412"] = 297,["413"] = 298,["414"] = 299,["415"] = 300,["416"] = 301,["419"] = 304,["420"] = 297,["421"] = 150,["422"] = 149,["423"] = 150,["425"] = 308,["426"] = 308,["427"] = 309,["428"] = 310,["429"] = 311,["430"] = 310,["431"] = 313,["432"] = 314,["433"] = 314,["434"] = 314,["435"] = 314,["436"] = 313,["437"] = 319,["438"] = 320,["439"] = 321,["441"] = 323,["443"] = 319,["444"] = 309,["445"] = 308,["446"] = 309});
boss_5_6 = __TS__Class()
boss_5_6.name = "boss_5_6"
__TS__ClassExtends(boss_5_6, BaseAbility)
function boss_5_6.prototype.____constructor(self, ...)
    BaseAbility.prototype.____constructor(self, ...)
    self.tParticleID = {}
end
function boss_5_6.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_6/fan/fan1.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_6/fan/fan2.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_6/fan/fan3.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_6/fan/fan4.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_6/fire/fire.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_6/aoe/aoe.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/boss_5_6/light/light.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_5/b_5_6/boom/boom.vpcf", context)
end
function boss_5_6.prototype.GetCastPoint(self)
    return 2.33 + 1
end
function boss_5_6.prototype.GetCastAnimation(self)
    return ACT_DOTA_VICTORY
end
function boss_5_6.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    local vStartPosition = hCaster:GetAbsOrigin()
    local fDis = self.Values:distance()
    self.tParticleID = {}
    do
        local i = 1
        while i <= 4 do
            local index = i
            self:GameTimer(
                2.33 / 4 * i,
                function()
                    self:_A(index)
                    local vDir = Rotation2D(
                        Vector(1, 0, 0),
                        90 * index
                    )
                    local vEndPosition = vStartPosition + vDir * fDis
                    ParticleManager_s2c:ToClient(
                        function()
                            local sEffectName = ("particles/boss/boss_5/boss_5_6/fan/fan" .. tostring(index)) .. ".vpcf"
                            local iParticleID = ParticleManager_s2c:CreateParticle(sEffectName, PATTACH_CUSTOMORIGIN, nil)
                            ParticleManager_s2c:SetParticleControl(iParticleID, 0, vStartPosition)
                            ParticleManager_s2c:SetParticleControl(iParticleID, 1, vEndPosition)
                            ParticleManager_s2c:SetParticleControl(
                                iParticleID,
                                2,
                                Vector(
                                    (fDis - 600) / math.sin(math.rad(45)),
                                    0,
                                    0
                                )
                            )
                            ParticleManager_s2c:SetParticleControl(iParticleID, 5, vStartPosition + vDir * 1100)
                            local ____self_tParticleID_0 = self.tParticleID
                            ____self_tParticleID_0[#____self_tParticleID_0 + 1] = iParticleID
                        end,
                        {weight = 0}
                    )
                end
            )
            i = i + 1
        end
    end
    self:GameTimer(
        2.33,
        function()
            hCaster:StartGestureWithPlaybackRate(ACT_DOTA_TAUNT, 2)
        end
    )
    hCaster:AddNewModifier(hCaster, self, "modifier_boss_5_6_invulnerable", nil)
    return true
end
function boss_5_6.prototype._A(self, index)
    local hCaster = self:GetCaster()
    local vStartPosition = hCaster:GetAbsOrigin()
    local fDis = self.Values:distance()
    local vDir = Vector(1, 0, 0)
    local vRightDir = Rotation2D(vDir, index * 90 + 45)
    local vLeftDir = Rotation2D(vRightDir, -90)
    DebugDrawLine(
        vStartPosition,
        vStartPosition + vRightDir * fDis,
        255,
        0,
        0,
        true,
        1
    )
    DebugDrawLine(
        vStartPosition,
        vStartPosition + vLeftDir * fDis,
        255,
        255,
        255,
        true,
        1
    )
    local iCount = 1
    local iMaxCount = 5
    self:GameTimer(
        0.1,
        function()
            if iCount <= iMaxCount then
                local radius = (iCount - 1) * 500
                do
                    local i = 1
                    while i <= 2 * iCount - 1 do
                        local ____temp_1
                        if i ~= 1 then
                            ____temp_1 = (i - 1) * 90 / (2 * iCount - 2)
                        else
                            ____temp_1 = 0
                        end
                        local fAngle = ____temp_1
                        local vPosition = vStartPosition + Rotation2D(vLeftDir, fAngle) * radius
                        ParticleManager_s2c:ToClient(
                            function()
                                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/boss_5_6/fire/fire.vpcf", PATTACH_CUSTOMORIGIN, nil)
                                ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPosition)
                                hCaster:EmitSound("Hero_OgreMagi.Fireblast.Target")
                            end,
                            {weight = 0}
                        )
                        i = i + 1
                    end
                end
                iCount = iCount + 1
                return 0.1
            end
        end
    )
end
function boss_5_6.prototype.OnAbilityPhaseInterrupted(self)
    local hCaster = self:GetCaster()
    ParticleManager_s2c:ToClient(
        function()
            for _, iParticleID in pairs(self.tParticleID) do
                ParticleManager_s2c:DestroyParticle(iParticleID, false)
            end
        end,
        {weight = 0}
    )
    hCaster:RemoveModifierByName("modifier_boss_5_6_invulnerable")
end
function boss_5_6.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local distance = self.Values:distance()
    self:GameTimer(
        1,
        function()
            hCaster:RemoveModifierByName("modifier_boss_5_6_invulnerable")
            hCaster:RemoveGesture(ACT_DOTA_TAUNT)
        end
    )
    ParticleManager_s2c:ToClient(
        function()
            local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/boss_5_6/aoe/aoe.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                0,
                hCaster:GetAbsOrigin()
            )
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                1,
                Vector(distance, 0, 0)
            )
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            hCaster:EmitSound("Ability.LightStrikeArray")
        end,
        {weight = 0}
    )
    hCaster:AddNewModifier(hCaster, self, "modifier_boss_5_6_buff", nil)
end
function boss_5_6.prototype.GetIntrinsicModifierName(self)
    return "modifier_boss_5_6"
end
function boss_5_6.prototype.OnOwnerDied(self)
    ParticleManager_s2c:ToClient(
        function()
            for _, iParticleID in pairs(self.tParticleID or ({})) do
                ParticleManager_s2c:DestroyParticle(iParticleID, false)
            end
        end,
        {weight = 0}
    )
end
boss_5_6 = __TS__DecorateLegacy(
    {register(_G)},
    boss_5_6
)
modifier_boss_5_6_invulnerable = __TS__Class()
modifier_boss_5_6_invulnerable.name = "modifier_boss_5_6_invulnerable"
__TS__ClassExtends(modifier_boss_5_6_invulnerable, BaseModifier)
function modifier_boss_5_6_invulnerable.prototype.CheckState(self)
    return {[MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true}
end
modifier_boss_5_6_invulnerable = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_5_6_invulnerable
)
modifier_boss_5_6 = __TS__Class()
modifier_boss_5_6.name = "modifier_boss_5_6"
__TS__ClassExtends(modifier_boss_5_6, BaseModifier)
function modifier_boss_5_6.prototype.IsHidden(self)
    return true
end
function modifier_boss_5_6.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS}
end
function modifier_boss_5_6.prototype.GetActivityTranslationModifiers(self)
    return "get_burned"
end
modifier_boss_5_6 = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_5_6
)
modifier_boss_5_6_buff = __TS__Class()
modifier_boss_5_6_buff.name = "modifier_boss_5_6_buff"
__TS__ClassExtends(modifier_boss_5_6_buff, BaseModifier)
function modifier_boss_5_6_buff.prototype.____constructor(self, ...)
    BaseModifier.prototype.____constructor(self, ...)
    self.t = {}
end
function modifier_boss_5_6_buff.prototype.IsHidden(self)
    return true
end
function modifier_boss_5_6_buff.prototype.OnCreated(self, params)
    local hCaster = self:GetCaster()
    local hAbility = self:GetAbility()
    if IsServer() then
        self.interval = self.Values:interval()
        self.min_count = self.Values:min_count()
        self.max_count = self.Values:max_count()
        self.boom_interval = self.Values:boom_interval()
        self.dmg_factor = self.Values:dmg_factor()
        self.knockback_duration = self.Values:knockback_duration()
        self.knockback_height = self.Values:knockback_height()
        self.distance = self.Values:distance()
        self:StartIntervalThink(self.interval)
        self:OnIntervalThink()
    end
end
function modifier_boss_5_6_buff.prototype.OnIntervalThink(self)
    if IsServer() then
        local hParent = self:GetParent()
        local hAbility = self:GetAbility()
        local index = self:GetBoomZi()
        if index then
            self:BoomDamage(index)
            NetEventData:SetTableValue("ability", "boss_5_6", self.t)
            if not self:HasBoomZi() then
                NetEventData:SetTableValue("ability", "boss_5_6", {})
                self:StartIntervalThink(self.interval)
            end
        else
            self.t = {}
            local iCount = RandomInt(self.min_count, self.max_count)
            do
                local i = 0
                while i < iCount do
                    local ____self_t_2 = self.t
                    ____self_t_2[#____self_t_2 + 1] = {
                        index = RandomInt(1, 4),
                        bUse = false
                    }
                    i = i + 1
                end
            end
            self:StartIntervalThink(self.boom_interval)
            NetEventData:SetTableValue("ability", "boss_5_6", self.t)
        end
    end
end
function modifier_boss_5_6_buff.prototype.BoomDamage(self, index)
    if IsServer() then
        local hParent = self:GetParent()
        local hAbility = self:GetAbility()
        local vStartPosition = hParent:GetAbsOrigin()
        local vDir = Vector(1, 0, 0)
        local vRighDir = Rotation2D(vDir, index * 90 + 45)
        local vLeftDir = Rotation2D(vRighDir, -90)
        DebugDrawLine(
            vStartPosition,
            vStartPosition + vRighDir * self.distance,
            255,
            255,
            255,
            true,
            1
        )
        DebugDrawLine(
            vStartPosition,
            vStartPosition + vLeftDir * self.distance,
            255,
            255,
            255,
            true,
            1
        )
        local vEndPosition = vStartPosition + Rotation2D(vRighDir, -45) * 1100
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/boss_5_6/light/light.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(iParticleID, 0, vEndPosition)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    1,
                    Vector(500, 1, 1)
                )
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            end,
            {weight = 0}
        )
        local fDamage = AttributeKind.Atk:Get(hParent) * self.dmg_factor
        hAbility:GameTimer(
            1,
            function()
                ParticleManager_s2c:ToClient(
                    function()
                        local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_5/b_5_6/boom/boom.vpcf", PATTACH_CUSTOMORIGIN, nil)
                        ParticleManager_s2c:SetParticleControl(iParticleID, 0, vEndPosition)
                        ParticleManager_s2c:SetParticleControl(
                            iParticleID,
                            1,
                            Vector(1000, 0, 0)
                        )
                        ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                        hParent:EmitSound("Ability.LightStrikeArray")
                    end,
                    {weight = 0}
                )
                local tTargets = FindUnitsInRadiusWithAbility(
                    _G,
                    hParent,
                    hAbility,
                    vStartPosition,
                    self.distance
                )
                for _, hTarget in pairs(tTargets) do
                    local vTarget = hTarget:GetAbsOrigin()
                    local vDir2 = (vTarget - vStartPosition):Normalized()
                    local fAngle = AngleBetween(vDir, vDir2)
                    if fAngle < 0 then
                        fAngle = 360 + fAngle
                    end
                    local fMinAngle = (index - 1) * 90 + 45
                    local fMaxAngle = index * 90 + 45
                    if index == 4 and fAngle > fMinAngle or fAngle >= 0 and fAngle <= fMaxAngle - 360 or fAngle > fMinAngle and fAngle <= fMaxAngle then
                        ApplyDamage({
                            ability = hAbility,
                            attacker = hParent,
                            victim = hTarget,
                            damage = fDamage,
                            damage_type = hAbility:GetAbilityDamageType()
                        })
                        if IsValid(hTarget) and hTarget:IsAlive() then
                            hTarget:AddNewModifier(hParent, hAbility, "modifier_knockback", {
                                duration = self.knockback_duration,
                                knockback_duration = self.knockback_duration,
                                knockback_distance = 0,
                                knockback_height = self.knockback_height,
                                center_x = vTarget.x,
                                center_y = vTarget.y,
                                center_z = vTarget.z
                            })
                        end
                    end
                end
            end
        )
    end
end
function modifier_boss_5_6_buff.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        local hAbility = self:GetAbility()
        hParent:RemoveGesture(ACT_DOTA_TAUNT)
        ParticleManager_s2c:ToClient(
            function()
                for _, iParticleID in pairs(hAbility.tParticleID) do
                    ParticleManager_s2c:DestroyParticle(iParticleID, false)
                end
            end,
            {weight = 0}
        )
        NetEventData:SetTableValue("ability", "boss_5_6", {})
    end
end
function modifier_boss_5_6_buff.prototype.GetBoomZi(self)
    local index = nil
    for ____, t in ipairs(self.t) do
        if not t.bUse then
            t.bUse = true
            return t.index
        end
    end
    return index
end
function modifier_boss_5_6_buff.prototype.HasBoomZi(self)
    local b = false
    for ____, t in ipairs(self.t) do
        if not t.bUse then
            b = true
        end
    end
    return b
end
modifier_boss_5_6_buff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_5_6_buff
)
modifier_boss_5_6_ai = __TS__Class()
modifier_boss_5_6_ai.name = "modifier_boss_5_6_ai"
__TS__ClassExtends(modifier_boss_5_6_ai, DiyModifier)
function modifier_boss_5_6_ai.prototype.IsHidden(self)
    return true
end
function modifier_boss_5_6_ai.prototype.DDeclareFunctions(self)
    return {
        [AttributeKind.HpMin] = function() return self:GetParent():GetMaxHealth() * 0.5 end,
        [MODIFIER_PROPERTY_MIN_HEALTH] = self.GetHpMin
    }
end
function modifier_boss_5_6_ai.prototype.GetHpMin(self)
    if IsServer() then
        return CBaseEntity.GetMaxHealth(self:GetParent()) * 0.5
    else
        return C_BaseEntity.GetMaxHealth(self:GetParent()) * 0.5
    end
end
modifier_boss_5_6_ai = __TS__DecorateLegacy(
    {diy(_G)},
    modifier_boss_5_6_ai
)