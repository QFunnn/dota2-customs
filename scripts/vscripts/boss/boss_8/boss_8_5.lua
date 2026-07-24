--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


__FILE_PATH__ = "boss\\boss_8\\boss_8_5"
require("lib/lualib")
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ArrayIndexOf = ____lualib.__TS__ArrayIndexOf
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__SourceMapTraceBack = ____lualib.__TS__SourceMapTraceBack
__TS__SourceMapTraceBack('scripts\\vscripts\\'..__FILE_PATH__..'.lua', {["1"] = 2,["2"] = 2,["12"] = 2,["13"] = 2,["14"] = 3,["16"] = 3,["17"] = 5,["18"] = 2,["19"] = 6,["20"] = 7,["21"] = 8,["22"] = 9,["23"] = 10,["24"] = 11,["25"] = 12,["26"] = 13,["27"] = 14,["28"] = 6,["29"] = 16,["30"] = 17,["31"] = 16,["32"] = 19,["33"] = 20,["34"] = 21,["35"] = 23,["36"] = 23,["37"] = 23,["38"] = 24,["39"] = 25,["40"] = 25,["41"] = 26,["42"] = 27,["43"] = 27,["44"] = 27,["45"] = 27,["46"] = 27,["47"] = 28,["48"] = 25,["49"] = 25,["50"] = 25,["51"] = 32,["52"] = 33,["53"] = 34,["54"] = 34,["55"] = 35,["56"] = 36,["57"] = 37,["58"] = 34,["59"] = 34,["60"] = 34,["61"] = 41,["62"] = 42,["63"] = 43,["64"] = 44,["65"] = 45,["66"] = 46,["67"] = 47,["68"] = 48,["69"] = 48,["70"] = 48,["71"] = 49,["72"] = 50,["73"] = 51,["74"] = 52,["75"] = 53,["76"] = 53,["77"] = 53,["78"] = 54,["79"] = 54,["80"] = 55,["81"] = 56,["82"] = 57,["83"] = 57,["84"] = 57,["85"] = 57,["86"] = 57,["87"] = 58,["88"] = 59,["89"] = 54,["90"] = 54,["91"] = 54,["92"] = 63,["93"] = 53,["94"] = 53,["95"] = 65,["96"] = 66,["97"] = 67,["99"] = 48,["100"] = 48,["101"] = 23,["102"] = 23,["103"] = 71,["104"] = 19,["105"] = 73,["106"] = 74,["107"] = 75,["108"] = 76,["109"] = 77,["110"] = 73,["111"] = 79,["112"] = 80,["113"] = 79,["114"] = 82,["115"] = 83,["116"] = 85,["117"] = 82,["118"] = 87,["119"] = 88,["120"] = 87,["121"] = 90,["122"] = 91,["123"] = 92,["124"] = 93,["125"] = 94,["126"] = 95,["127"] = 96,["128"] = 97,["129"] = 98,["132"] = 90,["133"] = 102,["134"] = 103,["135"] = 104,["136"] = 105,["137"] = 106,["138"] = 107,["139"] = 108,["140"] = 108,["141"] = 108,["142"] = 108,["143"] = 108,["144"] = 108,["145"] = 108,["146"] = 108,["147"] = 109,["148"] = 110,["149"] = 110,["150"] = 111,["151"] = 112,["152"] = 113,["153"] = 114,["154"] = 114,["155"] = 114,["156"] = 114,["157"] = 114,["158"] = 115,["159"] = 115,["160"] = 115,["161"] = 115,["162"] = 115,["163"] = 116,["164"] = 117,["165"] = 118,["166"] = 119,["167"] = 120,["168"] = 121,["170"] = 102,["171"] = 124,["172"] = 125,["173"] = 126,["174"] = 127,["175"] = 129,["178"] = 133,["179"] = 124,["180"] = 135,["181"] = 136,["182"] = 135,["183"] = 3,["184"] = 2,["185"] = 3,["187"] = 139,["188"] = 139,["189"] = 140,["190"] = 141,["191"] = 142,["192"] = 141,["193"] = 144,["194"] = 145,["195"] = 146,["196"] = 147,["197"] = 148,["198"] = 148,["199"] = 148,["200"] = 148,["201"] = 148,["202"] = 148,["203"] = 148,["204"] = 148,["206"] = 144,["207"] = 151,["208"] = 152,["209"] = 151,["210"] = 154,["211"] = 155,["212"] = 154,["213"] = 157,["214"] = 158,["215"] = 157,["216"] = 140,["217"] = 139,["218"] = 140,["220"] = 166,["221"] = 166,["222"] = 167,["223"] = 168,["224"] = 169,["225"] = 168,["226"] = 171,["227"] = 172,["228"] = 173,["229"] = 174,["230"] = 175,["231"] = 175,["232"] = 175,["233"] = 175,["234"] = 175,["235"] = 176,["236"] = 176,["237"] = 176,["238"] = 176,["239"] = 176,["240"] = 177,["241"] = 177,["242"] = 177,["243"] = 177,["244"] = 177,["245"] = 177,["246"] = 177,["247"] = 177,["249"] = 171,["250"] = 180,["251"] = 181,["252"] = 180,["253"] = 185,["254"] = 186,["255"] = 187,["256"] = 188,["257"] = 189,["258"] = 189,["259"] = 189,["260"] = 189,["261"] = 190,["262"] = 190,["263"] = 190,["264"] = 190,["265"] = 190,["266"] = 190,["267"] = 190,["270"] = 185,["271"] = 194,["272"] = 195,["273"] = 194,["274"] = 167,["275"] = 166,["276"] = 167,["278"] = 201,["279"] = 201,["280"] = 202,["281"] = 204,["282"] = 205,["283"] = 204,["284"] = 207,["285"] = 208,["286"] = 209,["287"] = 210,["288"] = 211,["289"] = 212,["291"] = 214,["292"] = 215,["293"] = 215,["294"] = 215,["295"] = 215,["296"] = 215,["297"] = 215,["298"] = 215,["299"] = 215,["300"] = 215,["301"] = 216,["302"] = 216,["303"] = 216,["304"] = 216,["305"] = 216,["306"] = 216,["307"] = 216,["308"] = 216,["309"] = 216,["310"] = 217,["311"] = 217,["312"] = 217,["313"] = 217,["314"] = 217,["315"] = 217,["316"] = 217,["317"] = 217,["319"] = 207,["320"] = 220,["321"] = 221,["322"] = 222,["323"] = 223,["324"] = 224,["325"] = 225,["326"] = 226,["329"] = 229,["330"] = 230,["331"] = 220,["332"] = 232,["333"] = 233,["334"] = 232,["335"] = 237,["336"] = 238,["337"] = 237,["338"] = 202,["339"] = 201,["340"] = 202,["342"] = 241,["343"] = 241,["344"] = 242,["345"] = 247,["346"] = 248,["347"] = 247,["348"] = 250,["349"] = 251,["350"] = 252,["351"] = 253,["352"] = 254,["353"] = 255,["354"] = 255,["355"] = 256,["356"] = 257,["357"] = 257,["358"] = 257,["359"] = 257,["360"] = 257,["361"] = 258,["362"] = 258,["363"] = 258,["364"] = 258,["365"] = 258,["366"] = 258,["367"] = 258,["368"] = 258,["369"] = 258,["370"] = 255,["371"] = 255,["372"] = 255,["373"] = 262,["374"] = 262,["375"] = 263,["376"] = 264,["377"] = 264,["378"] = 264,["379"] = 264,["380"] = 264,["381"] = 265,["382"] = 265,["383"] = 265,["384"] = 265,["385"] = 265,["386"] = 266,["387"] = 266,["388"] = 266,["389"] = 266,["390"] = 266,["391"] = 267,["392"] = 267,["393"] = 267,["394"] = 267,["395"] = 267,["396"] = 267,["397"] = 267,["398"] = 267,["399"] = 262,["400"] = 262,["401"] = 262,["403"] = 250,["404"] = 273,["405"] = 274,["406"] = 275,["407"] = 276,["408"] = 277,["409"] = 278,["410"] = 279,["411"] = 280,["413"] = 282,["414"] = 282,["415"] = 283,["416"] = 284,["417"] = 284,["418"] = 284,["419"] = 284,["420"] = 284,["421"] = 285,["422"] = 285,["423"] = 285,["424"] = 285,["425"] = 285,["426"] = 286,["427"] = 282,["428"] = 282,["429"] = 282,["430"] = 290,["431"] = 290,["432"] = 291,["433"] = 292,["434"] = 292,["435"] = 292,["436"] = 292,["437"] = 292,["438"] = 293,["439"] = 293,["440"] = 293,["441"] = 293,["442"] = 293,["443"] = 294,["444"] = 295,["445"] = 295,["446"] = 295,["447"] = 295,["448"] = 290,["449"] = 290,["450"] = 290,["451"] = 299,["452"] = 299,["453"] = 300,["454"] = 301,["455"] = 302,["456"] = 302,["457"] = 302,["458"] = 302,["459"] = 302,["460"] = 303,["461"] = 303,["462"] = 303,["463"] = 303,["464"] = 303,["465"] = 304,["466"] = 299,["467"] = 299,["468"] = 299,["469"] = 308,["470"] = 308,["471"] = 308,["472"] = 308,["473"] = 308,["474"] = 308,["475"] = 308,["476"] = 309,["477"] = 310,["478"] = 310,["479"] = 310,["480"] = 310,["481"] = 310,["482"] = 310,["483"] = 310,["486"] = 318,["487"] = 318,["488"] = 319,["489"] = 320,["490"] = 320,["491"] = 320,["492"] = 320,["493"] = 320,["494"] = 320,["495"] = 320,["496"] = 320,["497"] = 320,["498"] = 318,["502"] = 273,["503"] = 242,["504"] = 241,["505"] = 242,["507"] = 325,["508"] = 325,["509"] = 326,["510"] = 327,["511"] = 328,["512"] = 327,["513"] = 330,["514"] = 331,["515"] = 332,["516"] = 333,["517"] = 334,["518"] = 334,["519"] = 334,["520"] = 334,["521"] = 334,["522"] = 334,["523"] = 334,["524"] = 334,["526"] = 330,["527"] = 337,["528"] = 338,["529"] = 337,["530"] = 326,["531"] = 325,["532"] = 326,["534"] = 346,["535"] = 346,["536"] = 347,["537"] = 352,["538"] = 353,["539"] = 354,["540"] = 355,["541"] = 356,["542"] = 357,["543"] = 358,["544"] = 359,["545"] = 360,["547"] = 362,["548"] = 363,["549"] = 363,["550"] = 363,["551"] = 363,["552"] = 363,["553"] = 364,["554"] = 364,["555"] = 364,["556"] = 364,["557"] = 364,["558"] = 364,["559"] = 364,["560"] = 364,["562"] = 352,["563"] = 367,["564"] = 368,["565"] = 369,["566"] = 370,["567"] = 371,["568"] = 372,["569"] = 373,["572"] = 376,["573"] = 376,["574"] = 376,["575"] = 376,["576"] = 376,["577"] = 376,["578"] = 376,["579"] = 377,["580"] = 377,["581"] = 378,["582"] = 379,["583"] = 379,["584"] = 379,["585"] = 379,["586"] = 379,["587"] = 380,["588"] = 380,["589"] = 380,["590"] = 380,["591"] = 380,["592"] = 381,["593"] = 377,["594"] = 377,["595"] = 377,["596"] = 385,["597"] = 386,["598"] = 386,["599"] = 386,["600"] = 386,["601"] = 386,["602"] = 386,["603"] = 386,["605"] = 367,["606"] = 395,["607"] = 396,["608"] = 396,["609"] = 396,["610"] = 396,["611"] = 396,["612"] = 396,["613"] = 396,["614"] = 396,["615"] = 396,["616"] = 396,["617"] = 396,["618"] = 395,["619"] = 347,["620"] = 346,["621"] = 347,["623"] = 409,["624"] = 409,["625"] = 410,["626"] = 411,["627"] = 412,["628"] = 411,["629"] = 414,["630"] = 415,["631"] = 415,["632"] = 415,["633"] = 415,["634"] = 414,["635"] = 420,["636"] = 421,["637"] = 422,["639"] = 424,["641"] = 420,["642"] = 410,["643"] = 409,["644"] = 410});
boss_8_5 = __TS__Class()
boss_8_5.name = "boss_8_5"
__TS__ClassExtends(boss_8_5, BossAbility)
function boss_8_5.prototype.____constructor(self, ...)
    BossAbility.prototype.____constructor(self, ...)
    self.tSummonIndex = {}
end
function boss_8_5.prototype.Precache(self, context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_5/blink/start.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_5/blink/end.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_5/bar_avatar/bar_avatar.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_5/circular/circular.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_5/drain/drain.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_5/flower/flower.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_5/flower_fire/flower_fire.vpcf", context)
    PrecacheResource("particle", "particles/boss/boss_8/boss_8_5/flower_boom/flower_boom.vpcf", context)
end
function boss_8_5.prototype.GetCastPoint(self)
    return 3.04
end
function boss_8_5.prototype.OnAbilityPhaseStart(self)
    local hCaster = self:GetCaster()
    hCaster:StopFacing()
    hCaster:GameTimer(
        0,
        function()
            local vPosition = Vector(0, 0, 0)
            ParticleManager_s2c:ToClient(
                function()
                    local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_5/blink/start.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
                    ParticleManager_s2c:SetParticleControl(
                        iParticleID,
                        0,
                        hCaster:GetAbsOrigin()
                    )
                    ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                end,
                {weight = 0}
            )
            hCaster:SetAbsOrigin(vPosition)
            hCaster:SetForwardVector(Vector(0, -1, 0))
            ParticleManager_s2c:ToClient(
                function()
                    local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_5/blink/end.vpcf", PATTACH_CUSTOMORIGIN, hCaster)
                    ParticleManager_s2c:SetParticleControl(iParticleID, 0, vPosition)
                    ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                end,
                {weight = 0}
            )
            hCaster:AddNewModifier(hCaster, self, "modifier_boss_8_5", nil)
            local vStartPosition = hCaster:GetAbsOrigin()
            local count = self.Values:count()
            local distance = self.Values:distance()
            local radius = self.Values:radius_1()
            local vDirection = Vector(1, 0, 0)
            local i = 0
            self.sTimeName = hCaster:GameTimer(
                0,
                function()
                    local vTempDirection = Rotation2D(vDirection, 360 / count * i)
                    local vEndPosition = vStartPosition + vTempDirection:Normalized() * distance
                    hCaster:SetForwardVector(vTempDirection)
                    hCaster:StartGesture(ACT_DOTA_RAZE_2)
                    hCaster:GameTimer(
                        0.5,
                        function()
                            ParticleManager_s2c:ToClient(
                                function()
                                    local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_1/shadowraze/shadowraze.vpcf", PATTACH_CUSTOMORIGIN, nil)
                                    ParticleManager_s2c:SetParticleControl(iParticleID, 0, vEndPosition)
                                    ParticleManager_s2c:SetParticleControl(
                                        iParticleID,
                                        1,
                                        Vector(radius, radius, radius)
                                    )
                                    ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                                    ParticleManager_s2c:StartSoundEventFromPosition("Hero_Nevermore.Shadowraze.Arcana", vEndPosition)
                                end,
                                {weight = 0}
                            )
                            self:CreateSummon(vEndPosition)
                        end
                    )
                    i = i + 1
                    if i <= count - 1 then
                        return 0.76
                    end
                end
            )
        end
    )
    return true
end
function boss_8_5.prototype.OnAbilityPhaseInterrupted(self)
    local hCaster = self:GetCaster()
    self:ClearSummon()
    hCaster:RemoveModifierByName("modifier_boss_8_5")
    hCaster:StopTimer(self.sTimeName)
end
function boss_8_5.prototype.GetChannelTime(self)
    return self.Values:duration()
end
function boss_8_5.prototype.OnChannelFinish(self, interrupted)
    local hCaster = self:GetCaster()
    hCaster:RemoveModifierByName("modifier_boss_8_5")
end
function boss_8_5.prototype.GetChannelAnimation(self)
    return ACT_DOTA_GENERIC_CHANNEL_1
end
function boss_8_5.prototype.OnSpellStart(self)
    local hCaster = self:GetCaster()
    local duration = self.Values:duration()
    hCaster:AddNewModifier(hCaster, self, "modifier_boss_8_5_buff", {duration = duration})
    for _, index in pairs(self.tSummonIndex) do
        local hSummon = EntIndexToHScript(index)
        if IsValid(hSummon) then
            hSummon:RemoveModifierByName("modifier_boss_8_5_summon_invincible")
            hSummon:AddNewModifier(hCaster, self, "modifier_boss_8_5_summon_buff", nil)
        end
    end
end
function boss_8_5.prototype.CreateSummon(self, vEndPosition)
    local hCaster = self:GetCaster()
    local vStartPosition = hCaster:GetAbsOrigin()
    local hp = self.Values:hp_inherit_pct()
    local armor = self.Values:armor_inherit_pct()
    local duration = self.Values:duration()
    local hSummon = CreateUnitByName(
        "boss_8_3_summon",
        vEndPosition,
        true,
        hCaster,
        hCaster,
        hCaster:GetTeamNumber()
    )
    if IsValid(hSummon) then
        local ____self_tSummonIndex_0 = self.tSummonIndex
        ____self_tSummonIndex_0[#____self_tSummonIndex_0 + 1] = hSummon:entindex()
        hSummon:Hold()
        hSummon:SetModelScale(1.98)
        hSummon:AddAbility("attribute")
        AttributeKind.HpLimit.BONUS:Set(
            hSummon,
            AttributeKind.HpLimit:Get(hCaster) * hp * 0.01,
            "BONUS"
        )
        AttributeKind.Armor.BONUS:Set(
            hSummon,
            AttributeKind.Armor:Get(hCaster) * armor * 0.01,
            "BASE"
        )
        AttributeKind.HpLimit.BONUS:UpdateClient(hSummon, "BONUS")
        AttributeKind.Armor.BONUS:UpdateClient(hSummon, "BASE")
        local vForwardVector = (vStartPosition - vEndPosition):Normalized()
        hSummon:SetForwardVector(vForwardVector)
        hSummon:AddNewModifier(hCaster, self, "modifier_boss_8_5_summon", nil)
        hSummon:AddNewModifier(hCaster, self, "modifier_boss_8_5_summon_invincible", nil)
    end
end
function boss_8_5.prototype.ClearSummon(self)
    for _, index in pairs(self.tSummonIndex) do
        local hSummon = EntIndexToHScript(index)
        if IsValid(hSummon) then
            hSummon:ForceKill(true)
        end
    end
    self.tSummonIndex = {}
end
function boss_8_5.prototype.OnOwnerDied(self)
    self:ClearSummon()
end
boss_8_5 = __TS__DecorateLegacy(
    {register(_G)},
    boss_8_5
)
modifier_boss_8_5 = __TS__Class()
modifier_boss_8_5.name = "modifier_boss_8_5"
__TS__ClassExtends(modifier_boss_8_5, BaseModifier)
function modifier_boss_8_5.prototype.IsHidden(self)
    return true
end
function modifier_boss_8_5.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsClient() then
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/boss_8_5/bar_avatar/bar_avatar.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
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
function modifier_boss_8_5.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_MODEL_SCALE}
end
function modifier_boss_8_5.prototype.GetModifierModelScale(self)
    return 30
end
function modifier_boss_8_5.prototype.CheckState(self)
    return {[MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_UNSELECTABLE] = true}
end
modifier_boss_8_5 = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_8_5
)
modifier_boss_8_5_summon = __TS__Class()
modifier_boss_8_5_summon.name = "modifier_boss_8_5_summon"
__TS__ClassExtends(modifier_boss_8_5_summon, DiyModifier)
function modifier_boss_8_5_summon.prototype.IsHidden(self)
    return true
end
function modifier_boss_8_5_summon.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsClient() then
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/boss_8_5/circular/circular.vpcf", PATTACH_CUSTOMORIGIN, nil)
        ParticleManager:SetParticleControl(
            iParticleID,
            0,
            hParent:GetAbsOrigin()
        )
        ParticleManager:SetParticleControl(
            iParticleID,
            2,
            Vector(500, 0, 0)
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
function modifier_boss_8_5_summon.prototype.DDeclareFunctions(self)
    return {[MODIFIER_EVENT_ON_DEATH] = {source = self:GetParent()}}
end
function modifier_boss_8_5_summon.prototype.OnDeath(self, event)
    if IsServer() then
        local hParent = self:GetParent()
        local hAbility = self:GetAbility()
        if __TS__ArrayIncludes(
            hAbility.tSummonIndex,
            event.unit:entindex()
        ) then
            __TS__ArraySplice(
                hAbility.tSummonIndex,
                __TS__ArrayIndexOf(
                    hAbility.tSummonIndex,
                    event.unit:entindex()
                )
            )
        end
    end
end
function modifier_boss_8_5_summon.prototype.CheckState(self)
    return {[MODIFIER_STATE_ROOTED] = true, [MODIFIER_STATE_DISARMED] = true}
end
modifier_boss_8_5_summon = __TS__DecorateLegacy(
    {diy(_G)},
    modifier_boss_8_5_summon
)
modifier_boss_8_5_summon_buff = __TS__Class()
modifier_boss_8_5_summon_buff.name = "modifier_boss_8_5_summon_buff"
__TS__ClassExtends(modifier_boss_8_5_summon_buff, BaseModifier)
function modifier_boss_8_5_summon_buff.prototype.IsHidden(self)
    return true
end
function modifier_boss_8_5_summon_buff.prototype.OnCreated(self, params)
    local hCaster = self:GetCaster()
    local hParent = self:GetParent()
    if IsServer() then
        self.hp_regen_pct = self.Values:hp_regen_pct()
        self:StartIntervalThink(self.Values:regen_interval())
    else
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/boss_8_5/drain/drain.vpcf", PATTACH_CUSTOMORIGIN, nil)
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            0,
            hCaster,
            PATTACH_POINT_FOLLOW,
            "attach_hitloc",
            hCaster:GetAbsOrigin(),
            false
        )
        ParticleManager:SetParticleControlEnt(
            iParticleID,
            1,
            hParent,
            PATTACH_POINT_FOLLOW,
            "attach_hitloc",
            hParent:GetAbsOrigin(),
            false
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
function modifier_boss_8_5_summon_buff.prototype.OnIntervalThink(self)
    local hCaster = self:GetCaster()
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    if not IsValid(hCaster) or not hCaster:IsAlive() or not IsValid(hAbility) then
        self:StartIntervalThink(-1)
        self:Destroy()
        return
    end
    local fHpRegen = hCaster:GetMaxHealth() * self.hp_regen_pct * 0.01
    hCaster:SetHealth(hCaster:GetHealth() + fHpRegen)
end
function modifier_boss_8_5_summon_buff.prototype.DeclareFunctions(self)
    return {MODIFIER_PROPERTY_OVERRIDE_ANIMATION}
end
function modifier_boss_8_5_summon_buff.prototype.GetOverrideAnimation(self)
    return ACT_DOTA_GENERIC_CHANNEL_1
end
modifier_boss_8_5_summon_buff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_8_5_summon_buff
)
modifier_boss_8_5_buff = __TS__Class()
modifier_boss_8_5_buff.name = "modifier_boss_8_5_buff"
__TS__ClassExtends(modifier_boss_8_5_buff, BaseModifier)
function modifier_boss_8_5_buff.prototype.IsHidden(self)
    return true
end
function modifier_boss_8_5_buff.prototype.OnCreated(self, params)
    self.radius = self.Values:radius()
    if IsServer() then
        local hParent = self:GetParent()
        self.flower_count = self.Values:flower_count()
        ParticleManager_s2c:ToClient(
            function()
                self.iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_5/circular/circular.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(
                    self.iParticleID,
                    0,
                    hParent:GetAbsOrigin()
                )
                ParticleManager_s2c:SetParticleControl(
                    self.iParticleID,
                    2,
                    Vector(
                        self.radius,
                        self:GetDuration(),
                        0
                    )
                )
            end,
            {weight = 0}
        )
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_5/flower/flower.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    0,
                    hParent:GetAbsOrigin()
                )
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    1,
                    hParent:GetAbsOrigin() + Vector(0, 0, 600)
                )
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    2,
                    hParent:GetAbsOrigin() + Vector(0, 0, -50)
                )
                self:AddParticle_s2c(
                    iParticleID,
                    false,
                    false,
                    -1,
                    false,
                    false
                )
            end,
            {weight = 0}
        )
    end
end
function modifier_boss_8_5_buff.prototype.OnDestroy(self)
    if IsServer() then
        local hParent = self:GetParent()
        local hAbility = self:GetAbility()
        local vPosition = hParent:GetAbsOrigin()
        self.fDamage = AttributeKind.Atk:Get(hParent) * (#hAbility.tSummonIndex + 1) * self.Values:dmg_factor()
        if hAbility.ClearSummon then
            hAbility:ClearSummon()
        end
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_1/shadowraze/shadowraze.vpcf", PATTACH_CUSTOMORIGIN, nil)
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
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            end,
            {weight = 0}
        )
        ParticleManager_s2c:ToClient(
            function()
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_1/shadowraze/shadowraze1.vpcf", PATTACH_CUSTOMORIGIN, nil)
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
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
                ParticleManager_s2c:StartSoundEventFromPosition(
                    "Hero_Nevermore.Shadowraze.Arcana",
                    hParent:GetAbsOrigin()
                )
            end,
            {weight = 0}
        )
        ParticleManager_s2c:ToClient(
            function()
                ParticleManager_s2c:DestroyParticle(self.iParticleID, false)
                local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_1/aoe/aoe.vpcf", PATTACH_CUSTOMORIGIN, nil)
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    0,
                    hParent:GetAbsOrigin()
                )
                ParticleManager_s2c:SetParticleControl(
                    iParticleID,
                    1,
                    Vector(self.radius, 0, 0)
                )
                ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
            end,
            {weight = 0}
        )
        local tTargets = FindUnitsInRadiusWithAbility(
            _G,
            hParent,
            hAbility,
            vPosition,
            self.radius
        )
        for _, hTarget in pairs(tTargets) do
            ApplyDamage({
                ability = hAbility,
                attacker = hParent,
                victim = hTarget,
                damage = self.fDamage,
                damage_type = hAbility:GetAbilityDamageType()
            })
        end
        do
            local i = 0
            while i < self.flower_count do
                local vPosition = hParent:GetAbsOrigin() + RandomVector(RandomInt(0, self.radius))
                CreateModifierThinker(
                    hParent,
                    hAbility,
                    "modifier_boss_8_5_flower_thinker",
                    {},
                    vPosition,
                    hParent:GetTeamNumber(),
                    true
                )
                i = i + 1
            end
        end
    end
end
modifier_boss_8_5_buff = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_8_5_buff
)
modifier_boss_8_5_summon_invincible = __TS__Class()
modifier_boss_8_5_summon_invincible.name = "modifier_boss_8_5_summon_invincible"
__TS__ClassExtends(modifier_boss_8_5_summon_invincible, BaseModifier)
function modifier_boss_8_5_summon_invincible.prototype.IsHidden(self)
    return true
end
function modifier_boss_8_5_summon_invincible.prototype.OnCreated(self, params)
    local hParent = self:GetParent()
    if IsClient() then
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/boss_8_5/bar_avatar/bar_avatar.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
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
function modifier_boss_8_5_summon_invincible.prototype.CheckState(self)
    return {[MODIFIER_STATE_INVULNERABLE] = true, [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true, [MODIFIER_STATE_NO_UNIT_COLLISION] = true, [MODIFIER_STATE_UNSELECTABLE] = true}
end
modifier_boss_8_5_summon_invincible = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_8_5_summon_invincible
)
modifier_boss_8_5_flower_thinker = __TS__Class()
modifier_boss_8_5_flower_thinker.name = "modifier_boss_8_5_flower_thinker"
__TS__ClassExtends(modifier_boss_8_5_flower_thinker, BaseModifier)
function modifier_boss_8_5_flower_thinker.prototype.OnCreated(self, params)
    local hCaster = self:GetCaster()
    local hParent = self:GetParent()
    self.flower_dmg_factor = self.Values:flower_dmg_factor()
    self.flower_dmg_interval = self.Values:flower_dmg_interval()
    self.flower_dmg_radius = self.Values:flower_dmg_radius()
    if IsServer() then
        self.fDamage = AttributeKind.Atk:Get(hCaster) * self.flower_dmg_factor
        self:StartIntervalThink(self.flower_dmg_interval)
    else
        local iParticleID = ParticleManager:CreateParticle("particles/boss/boss_8/boss_8_5/flower_fire/flower_fire.vpcf", PATTACH_ABSORIGIN_FOLLOW, hParent)
        ParticleManager:SetParticleControl(
            iParticleID,
            1,
            Vector(self.flower_dmg_radius, 0, 0)
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
function modifier_boss_8_5_flower_thinker.prototype.OnIntervalThink(self)
    local hCaster = self:GetCaster()
    local hParent = self:GetParent()
    local hAbility = self:GetAbility()
    if not IsValid(hCaster) or not hCaster:IsAlive() or not IsValid(hAbility) then
        self:StartIntervalThink(-1)
        self:Destroy()
        return
    end
    local tTargets = FindUnitsInRadiusWithAbility(
        _G,
        hCaster,
        hAbility,
        hParent:GetAbsOrigin(),
        self.flower_dmg_radius
    )
    ParticleManager_s2c:ToClient(
        function()
            local iParticleID = ParticleManager_s2c:CreateParticle("particles/boss/boss_8/boss_8_5/flower_boom/flower_boom.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                0,
                hParent:GetAbsOrigin()
            )
            ParticleManager_s2c:SetParticleControl(
                iParticleID,
                1,
                Vector(self.flower_dmg_radius, self.flower_dmg_radius, self.flower_dmg_radius)
            )
            ParticleManager_s2c:ReleaseParticleIndex(iParticleID)
        end,
        {weight = 0}
    )
    for _, hTarget in pairs(tTargets) do
        ApplyDamage({
            ability = hAbility,
            attacker = hCaster,
            victim = hTarget,
            damage = self.fDamage,
            damage_type = hAbility:GetAbilityDamageType()
        })
    end
end
function modifier_boss_8_5_flower_thinker.prototype.CheckState(self)
    return {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NO_TEAM_MOVE_TO] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_UNTARGETABLE] = true
    }
end
modifier_boss_8_5_flower_thinker = __TS__DecorateLegacy(
    {register(_G)},
    modifier_boss_8_5_flower_thinker
)
modifier_boss_8_5_ai = __TS__Class()
modifier_boss_8_5_ai.name = "modifier_boss_8_5_ai"
__TS__ClassExtends(modifier_boss_8_5_ai, DiyModifier)
function modifier_boss_8_5_ai.prototype.IsHidden(self)
    return true
end
function modifier_boss_8_5_ai.prototype.DDeclareFunctions(self)
    return {
        [AttributeKind.HpMin] = function() return self:GetParent():GetMaxHealth() * 0.5 end,
        [MODIFIER_PROPERTY_MIN_HEALTH] = self.GetHpMin
    }
end
function modifier_boss_8_5_ai.prototype.GetHpMin(self)
    if IsServer() then
        return CBaseEntity.GetMaxHealth(self:GetParent()) * 0.5
    else
        return C_BaseEntity.GetMaxHealth(self:GetParent()) * 0.5
    end
end
modifier_boss_8_5_ai = __TS__DecorateLegacy(
    {diy(_G)},
    modifier_boss_8_5_ai
)