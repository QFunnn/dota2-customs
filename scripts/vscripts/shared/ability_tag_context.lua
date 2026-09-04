--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Number = ____lualib.__TS__Number
local __TS__ArrayIsArray = ____lualib.__TS__ArrayIsArray
local __TS__StringTrim = ____lualib.__TS__StringTrim
local ____exports = {}
local resolveTagsFromAbilityKv, parseDeclaredTags, resolveOneTagLabel, ABILITY_TAG_KEY, TAG_TOKEN_MAP
function resolveTagsFromAbilityKv(self, abilityKv)
    return parseDeclaredTags(nil, abilityKv[ABILITY_TAG_KEY])
end
function parseDeclaredTags(self, raw)
    if raw == nil or raw == nil then
        return 0
    end
    if type(raw) == "string" then
        return resolveOneTagLabel(nil, raw)
    end
    if __TS__ArrayIsArray(raw) then
        local mask = 0
        for ____, item in ipairs(raw) do
            do
                if type(item) ~= "string" then
                    goto __continue9
                end
                mask = bit.bor(
                    mask,
                    resolveOneTagLabel(nil, item)
                )
            end
            ::__continue9::
        end
        return mask
    end
    return 0
end
function resolveOneTagLabel(self, raw)
    local key = __TS__StringTrim(raw)
    if not key then
        return 0
    end
    local token = string.lower(key)
    return TAG_TOKEN_MAP[token] or 0
end
ABILITY_TAG_KEY = "AbilityTags"
TAG_TOKEN_MAP = {
    active = 1,
    passive = 2,
    movement = 4,
    moverment = 4,
    damage = 8,
    buff = 16,
    charge = 32,
    主动 = 1,
    被动 = 2,
    位移 = 4,
    伤害 = 8,
    增益 = 16
}
--- 解析已由调用端路由好的技能或物品 KV 行，不依赖任何运行时实例。
function ____exports.ResolveAbilityTags(self, abilityKv)
    return resolveTagsFromAbilityKv(nil, abilityKv or ({}))
end
--- 组装结算上下文标签：KV 标签 + 额外标签（位或）。
function ____exports.BuildTagContextFromAbilityKv(self, abilityKv, extraTagContext)
    local kvTags = ____exports.ResolveAbilityTags(nil, abilityKv)
    local extraTags = __TS__Number(extraTagContext and extraTagContext.tags or 0)
    local merged = bit.bor(kvTags, extraTags)
    local ____temp_2
    if merged ~= 0 then
        ____temp_2 = {tags = merged}
    else
        ____temp_2 = nil
    end
    return ____temp_2
end
return ____exports