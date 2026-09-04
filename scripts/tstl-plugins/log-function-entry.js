--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


/** @type {import("typescript-to-lua").Plugin} */
const path = require('path');
let SourceMapConsumer;
try {
    ({ SourceMapConsumer } = require('source-map'));
} catch {
    ({ SourceMapConsumer } = require(path.resolve(process.cwd(), 'node_modules/source-map')));
}

const plugin = {
    afterPrint(program, options, emitHost, result) {
        const pluginFlag = process.env.AK_DEBUG_PLUGIN_ENABLED ?? process.env.AK_TRACE_PLUGIN_ENABLED ?? '';
        const debugPluginEnabled = !['0', 'false', 'off'].includes(String(pluginFlag).toLowerCase());
        if (!debugPluginEnabled) {
            return result;
        }

        const traceBootstrap = `_G.__AK_TRACE_BUFFER = _G.__AK_TRACE_BUFFER or ({})
_G.__AK_TRACE_MAX = _G.__AK_TRACE_MAX or 300
_G.__AK_TRACE_TAIL = _G.__AK_TRACE_TAIL or 15
_G.__AK_TRACE_SCOPE_ID = _G.__AK_TRACE_SCOPE_ID or 0
_G.__AK_TRACE_HEAD = _G.__AK_TRACE_HEAD or 0
_G.__AK_TRACE_SIZE = _G.__AK_TRACE_SIZE or 0
_G.__AK_TRACE_COLLECT_ENABLED = _G.__AK_TRACE_COLLECT_ENABLED or false
_G.__AK_ENCRYPT_LINE_OFFSET = _G.__AK_ENCRYPT_LINE_OFFSET or 1
if _G.__AK_TRACE_PRINT_ENABLED == nil then
    _G.__AK_TRACE_PRINT_ENABLED = true
end
_G.__AK_TRACE_REPORTING_ERROR = _G.__AK_TRACE_REPORTING_ERROR or false
_G.__AK_SOURCEMAP = _G.__AK_SOURCEMAP or ({})
_G.__AK_SourceMapRegister = function(luaFile, defaultSource, map, lineOffset)
    if luaFile == nil or map == nil then
        return
    end
    _G.__AK_SOURCEMAP[tostring(luaFile)] = {
        defaultSource = tostring(defaultSource or ""),
        map = map,
        lineOffset = tonumber(lineOffset) or 0
    }
end
_G.__AK_SourceMapLookup = function(luaFile, lineStr, extraOffset)
    local key = tostring(luaFile)
    local reg = _G.__AK_SOURCEMAP and _G.__AK_SOURCEMAP[key]
    if reg == nil and _G.__AK_SOURCEMAP ~= nil then
        local norm = string.gsub(key, "\\\\", "/")
        local marker = "vscripts/"
        local s, _ = string.find(norm, marker, 1, true)
        local suffix = nil
        if s ~= nil then
            suffix = string.sub(norm, s)
        end
        if suffix ~= nil then
            for k, v in pairs(_G.__AK_SOURCEMAP) do
                local kk = string.gsub(tostring(k), "\\\\", "/")
                if string.sub(kk, -string.len(suffix)) == suffix then
                    reg = v
                    break
                end
            end
        end
    end
    if reg == nil or reg.map == nil then
        return nil
    end
    local line = tonumber(lineStr)
    if line == nil then
        return nil
    end
    local shiftedLine = line - (tonumber(reg.lineOffset) or 0) - (tonumber(extraOffset) or 0)
    local entry = reg.map[shiftedLine] or reg.map[tostring(shiftedLine)] or reg.map[line] or reg.map[tostring(line)]
    if entry == nil then
        local i = shiftedLine - 1
        while i >= 1 do
            entry = reg.map[i] or reg.map[tostring(i)]
            if entry ~= nil then
                break
            end
            i = i - 1
        end
    end
    if entry == nil then
        return nil
    end
    if type(entry) == "number" then
        if reg.defaultSource == nil or reg.defaultSource == "" then
            return nil
        end
        return reg.defaultSource .. ":" .. tostring(entry)
    end
    if type(entry) == "table" and entry.line ~= nil then
        local src = entry.file or reg.defaultSource
        if src == nil or src == "" then
            return nil
        end
        return tostring(src) .. ":" .. tostring(entry.line)
    end
    return nil
end
_G.__AK_MapLuaErrorText = function(text)
    if type(text) ~= "string" then
        return text
    end
    local function mapFileAndLine(file, line, extraOffset)
        local normalized = string.gsub(tostring(file), "\\\\", "/")
        local tsLoc = nil
        if _G.__AK_SourceMapLookup ~= nil then
            tsLoc = _G.__AK_SourceMapLookup(normalized, line, extraOffset)
        end
        if tsLoc ~= nil then
            return tsLoc
        end
        return tostring(file) .. ":" .. tostring(line)
    end

    local mapped = string.gsub(text, "([^:%s]+%.lua):(%d+)", function(file, line)
        return mapFileAndLine(file, line, 0)
    end)

    -- 兼容 [string ...]:<line> 这类 chunk 报错（常见于加密/加载后的脚本块）
    mapped = string.gsub(mapped, "(%[string [^%]]+%]):(%d+)", function(chunk, line)
        local chunkBody = string.gsub(tostring(chunk), "^%[string ", "")
        chunkBody = string.gsub(chunkBody, "%]$", "")
        chunkBody = string.gsub(chunkBody, '^"', "")
        chunkBody = string.gsub(chunkBody, '"$', "")
        local normalizedChunk = string.gsub(chunkBody, "\\\\", "/")
        -- 去掉常见的注释前缀：-- path/to/file.lua...
        normalizedChunk = string.gsub(normalizedChunk, "^%s*%-%-%s*", "")
        -- 尝试从 chunk 文本中提取 lua 文件路径
        local fileFromChunk = string.match(normalizedChunk, "([%w%._%-%/]+%.lua)")
        if fileFromChunk ~= nil then
            return mapFileAndLine(fileFromChunk, line, _G.__AK_ENCRYPT_LINE_OFFSET)
        end
        -- 无法提取路径时保持原样，避免误改
        return tostring(chunk) .. ":" .. tostring(line)
    end)

    return mapped
end
_G.__AK_TRACE_ENTER = function(name)
    if _G.__AK_TRACE_COLLECT_ENABLED ~= true then
        return
    end
    local buf = _G.__AK_TRACE_BUFFER or ({})
    _G.__AK_TRACE_BUFFER = buf
    local cap = tonumber(_G.__AK_TRACE_MAX) or 300
    if cap < 1 then
        cap = 1
    end
    local head = tonumber(_G.__AK_TRACE_HEAD) or 0
    local size = tonumber(_G.__AK_TRACE_SIZE) or 0
    head = (head % cap) + 1
    _G.__AK_TRACE_HEAD = head
    if size < cap then
        size = size + 1
        _G.__AK_TRACE_SIZE = size
    end
    if type(name) == "string" then
        buf[head] = name
    else
        buf[head] = tostring(name)
    end
end
_G.__AK_TRACE_BEGIN_SCOPE = function(tag)
    _G.__AK_TRACE_SCOPE_ID = (_G.__AK_TRACE_SCOPE_ID or 0) + 1
    local marker = "__AK_SCOPE_BEGIN__[" .. tostring(_G.__AK_TRACE_SCOPE_ID) .. "]:" .. tostring(tag or "")
    _G.__AK_TRACE_ENTER(marker)
    return marker
end
_G.__AK_TRACE_COLLECT_FRAMES = function(startMarker, tail)
    local frames = {}
    local buf = _G.__AK_TRACE_BUFFER or ({})
    local cap = tonumber(_G.__AK_TRACE_MAX) or 300
    if cap < 1 then
        cap = 1
    end
    local head = tonumber(_G.__AK_TRACE_HEAD) or 0
    local size = tonumber(_G.__AK_TRACE_SIZE) or 0
    if size <= 0 or head <= 0 then
        return frames
    end
    local maxLines = tonumber(tail) or tonumber(_G.__AK_TRACE_TAIL) or 15
    local printed = 0
    for step = 0, size - 1 do
        local idx = ((head - step - 1) % cap) + 1
        local frame = tostring(buf[idx])
        if frame ~= "DeepPrintToString" and frame ~= "DeepDebugPrint" then
            frames[#frames + 1] = frame
            printed = printed + 1
        end
        if startMarker ~= nil and frame == tostring(startMarker) then
            break
        end
        if printed >= maxLines then
            break
        end
    end
    return frames
end
_G.__AK_TRACE_FORMAT = function(err, startMarker, tail)
    local lines = {}
    lines[#lines + 1] = "[AK_TRACE_ERROR] " .. tostring(err)
    local frames = {}
    if _G.__AK_TRACE_COLLECT_FRAMES ~= nil then
        local okFrames, collected = pcall(_G.__AK_TRACE_COLLECT_FRAMES, startMarker, tail)
        if okFrames and collected ~= nil then
            frames = collected
        end
    end
    for i = 1, #frames do
        lines[#lines + 1] = "[AK_TRACE] " .. tostring(frames[i])
    end
    return table.concat(lines, "\\n")
end
_G.__AK_TRACE_DUMP = function(err, startMarker, tail)
    if _G.__AK_TRACE_PRINT_ENABLED ~= true then
        return tostring(err)
    end
    local ok, text = pcall(_G.__AK_TRACE_FORMAT, err, startMarker, tail)
    local finalText = ok and text or ("[AK_TRACE_ERROR] " .. tostring(err))
    for line in string.gmatch(tostring(finalText), "[^\\n]+") do
        print(line)
    end
    return finalText
end

if _G.__AK_RAW_XPCALL == nil then
    _G.__AK_RAW_XPCALL = xpcall
end
xpcall = function(func, msgh, ...)
    if _G.__AK_TRACE_COLLECT_ENABLED ~= true then
        local argc = select("#", ...)
        if argc > 0 then
            local args = {...}
            return _G.__AK_RAW_XPCALL(function()
                return func(unpack(args, 1, argc))
            end, msgh)
        end
        return _G.__AK_RAW_XPCALL(func, msgh)
    end
    local marker = nil
    if _G.__AK_TRACE_BEGIN_SCOPE ~= nil then
        marker = _G.__AK_TRACE_BEGIN_SCOPE("xpcall")
    end
    local function wrappedHandler(err)
        local rawErr = err
        local finalErr = err
        if msgh ~= nil then
            local okMsgh, handled = pcall(msgh, err)
            if okMsgh and handled ~= nil then
                finalErr = handled
            end
        end
        if _G.__AK_MapLuaErrorText ~= nil then
            local okMap, mappedErr = pcall(_G.__AK_MapLuaErrorText, finalErr)
            if okMap and mappedErr ~= nil then
                finalErr = mappedErr
            end
        end
        if _G.MyGameLogger ~= nil and _G.MyGameLogger.error ~= nil and _G.__AK_TRACE_REPORTING_ERROR ~= true then
            _G.__AK_TRACE_REPORTING_ERROR = true
            pcall(function()
                local traceFrames = ({})
                if _G.__AK_TRACE_COLLECT_FRAMES ~= nil then
                    local okFrames, collected = pcall(_G.__AK_TRACE_COLLECT_FRAMES, marker, _G.__AK_TRACE_TAIL)
                    if okFrames and collected ~= nil then
                        traceFrames = collected
                    end
                end
                _G.MyGameLogger:error(
                    "[AK_TRACE_ERROR]",
                    {
                        rawError = tostring(rawErr),
                        error = tostring(finalErr),
                        topFrame = traceFrames[1],
                        frames = traceFrames
                    }
                )
            end)
            _G.__AK_TRACE_REPORTING_ERROR = false
        end
        local dumped = false
        if _G.__AK_TRACE_DUMP ~= nil then
            local okDump = pcall(_G.__AK_TRACE_DUMP, finalErr, marker, _G.__AK_TRACE_TAIL)
            dumped = okDump == true
        end
        if not dumped and _G.__AK_TRACE_PRINT_ENABLED == true then
            print("[AK_TRACE_FALLBACK] " .. tostring(finalErr))
        end
        return finalErr
    end
    local argc = select("#", ...)
    if argc > 0 then
        local args = {...}
        return _G.__AK_RAW_XPCALL(function()
            return func(unpack(args, 1, argc))
        end, wrappedHandler)
    end
    return _G.__AK_RAW_XPCALL(func, wrappedHandler)
end
`;

        const makeTraceInline = name => ` if _G.__AK_TRACE_ENTER ~= nil then _G.__AK_TRACE_ENTER(${JSON.stringify(name)}) end\n`;
        const getLine = (source, offset) => source.slice(0, offset).split('\n').length;
        const countPrependedLines = text => (String(text).match(/\n/g) || []).length;
        const luaQuote = value => `"${String(value).replace(/\\/g, '\\\\').replace(/"/g, '\\"')}"`;
        const toLuaNumberOrQuotedKey = key => (/^\d+$/.test(String(key)) ? String(key) : luaQuote(String(key)));
        const toLuaTable = obj => {
            const entries = Object.entries(obj).map(([k, v]) => {
                if (v && typeof v === 'object' && !Array.isArray(v)) {
                    const inner = Object.entries(v)
                        .map(([ik, iv]) => `[${toLuaNumberOrQuotedKey(ik)}] = ${typeof iv === 'number' ? iv : luaQuote(iv)}`)
                        .join(', ');
                    return `[${toLuaNumberOrQuotedKey(k)}] = {${inner}}`;
                }
                return `[${toLuaNumberOrQuotedKey(k)}] = ${typeof v === 'number' ? v : luaQuote(v)}`;
            });
            return `{${entries.join(', ')}}`;
        };
        const normalizeDisplayPath = absOrRelPath => {
            const raw = String(absOrRelPath).replace(/\\/g, '/');
            const gameScriptsSrcMarker = '/game/scripts/src/';
            const markerIdx = raw.lastIndexOf(gameScriptsSrcMarker);
            if (markerIdx >= 0) {
                return `game/scripts/src/${raw.slice(markerIdx + gameScriptsSrcMarker.length)}`;
            }
            const relativeSrcMatch = raw.match(/^(?:\.\/)?(?:\.\.\/)*src\/(.+)$/);
            if (relativeSrcMatch) {
                return `game/scripts/src/${relativeSrcMatch[1]}`;
            }
            const rootSrcMatch = raw.match(/^src\/(.+)$/);
            if (rootSrcMatch) {
                return `game/scripts/src/${rootSrcMatch[1]}`;
            }
            const absolute = path.isAbsolute(absOrRelPath) ? absOrRelPath : path.resolve(projectRoot, absOrRelPath);
            return path.relative(process.cwd(), absolute).replace(/\\/g, '/');
        };
        const trimExtension = file => file.replace(/\.[^/.\\]+$/, '');
        const projectRoot = options.configFilePath ? path.dirname(options.configFilePath) : program.getCommonSourceDirectory();
        const sourceDir =
            options.rootDir && options.rootDir.length > 0
                ? path.isAbsolute(options.rootDir)
                    ? options.rootDir
                    : path.resolve(projectRoot, options.rootDir)
                : projectRoot;
        const outDir =
            options.outDir && options.outDir.length > 0
                ? path.isAbsolute(options.outDir)
                    ? options.outDir
                    : path.resolve(projectRoot, options.outDir)
                : projectRoot;
        const extension = (options.extension || 'lua').trim().replace(/^\./, '');
        const getLuaOutputPathForSource = sourceFileName => {
            let parts = path
                .relative(sourceDir, sourceFileName)
                .split(path.sep)
                .filter(part => part !== '..');
            if (parts.length === 0) {
                parts = [path.basename(sourceFileName)];
            }
            if (parts[0] === 'node_modules') {
                parts[0] = 'lua_modules';
            }
            parts[parts.length - 1] = `${trimExtension(parts[parts.length - 1])}.${extension}`;
            return path.join(outDir, ...parts);
        };
        const buildSourceMapper = (sourceMap, fallbackLuaPath) => {
            if (!sourceMap) {
                return {
                    resolve: line => ({ file: fallbackLuaPath, line }),
                    defaultSource: fallbackLuaPath,
                    lineMap: {},
                };
            }

            let consumer;
            try {
                consumer = new SourceMapConsumer(JSON.parse(sourceMap));
            } catch {
                return {
                    resolve: line => ({ file: fallbackLuaPath, line }),
                    defaultSource: fallbackLuaPath,
                    lineMap: {},
                };
            }

            const lineMap = {};
            const fileCount = {};
            const ensureInit = () => {
                try {
                    if (lineMap.__inited !== true) {
                        lineMap.__inited = true;
                        consumer.eachMapping(mapping => {
                            if (!mapping || !mapping.generatedLine || !mapping.source || !mapping.originalLine) {
                                return;
                            }
                            const mappedFile = normalizeDisplayPath(mapping.source);
                            if (lineMap[mapping.generatedLine] == null) {
                                lineMap[mapping.generatedLine] = {
                                    source: mappedFile,
                                    line: mapping.originalLine,
                                };
                                fileCount[mappedFile] = (fileCount[mappedFile] || 0) + 1;
                            } else {
                                const prev = lineMap[mapping.generatedLine];
                                if (prev.source === mappedFile) {
                                    if (mapping.originalLine < prev.line) {
                                        prev.line = mapping.originalLine;
                                    }
                                } else if (mapping.originalLine < prev.line) {
                                    lineMap[mapping.generatedLine] = {
                                        source: mappedFile,
                                        line: mapping.originalLine,
                                    };
                                }
                            }
                        });
                    }
                } catch {
                    return false;
                }
                return true;
            };

            const resolve = line => {
                if (!ensureInit()) {
                    return { file: fallbackLuaPath, line };
                }

                let mapped = lineMap[line];
                if (mapped == null) {
                    for (let i = line - 1; i >= 1; i--) {
                        if (lineMap[i] != null) {
                            mapped = lineMap[i];
                            break;
                        }
                    }
                }
                if (!mapped || !mapped.source || mapped.line == null) {
                    return { file: fallbackLuaPath, line };
                }

                return {
                    file: mapped.source,
                    line: mapped.line,
                };
            };

            const getDefaultSource = () => {
                if (!ensureInit()) {
                    return fallbackLuaPath;
                }
                let bestFile = fallbackLuaPath;
                let bestCount = -1;
                for (const [file, count] of Object.entries(fileCount)) {
                    if (count > bestCount) {
                        bestCount = count;
                        bestFile = file;
                    }
                }
                return bestFile;
            };

            const getLuaRegistrationMap = () => {
                const map = {};
                const defaultSource = getDefaultSource();
                for (const [luaLine, mapped] of Object.entries(lineMap)) {
                    if (luaLine === '__inited') continue;
                    if (!mapped || !mapped.source || mapped.line == null) continue;
                    if (mapped.source === defaultSource) {
                        map[luaLine] = mapped.line;
                    } else {
                        map[luaLine] = { file: mapped.source, line: mapped.line };
                    }
                }
                return { defaultSource, map };
            };

            return { resolve, getLuaRegistrationMap };
        };

        for (const file of result) {
            const sourceFileName = file.fileName || '';
            if (typeof sourceFileName !== 'string' || !sourceFileName.endsWith('.ts')) continue;

            const luaOutputPath = getLuaOutputPathForSource(sourceFileName);
            if (luaOutputPath.includes('lualib_bundle.lua')) continue;
            const luaDisplayPath = normalizeDisplayPath(luaOutputPath);
            const sourceMapper = buildSourceMapper(file.sourceMap, luaDisplayPath);
            const getSourceLocation = sourceMapper.resolve;
            let registrationCall = '';
            if (sourceMapper.getLuaRegistrationMap) {
                const registration = sourceMapper.getLuaRegistrationMap();
                const lineOffset = countPrependedLines(traceBootstrap) + 1;
                registrationCall = `_G.__AK_SourceMapRegister(${luaQuote(luaDisplayPath)}, ${luaQuote(
                    registration.defaultSource || ''
                )}, ${toLuaTable(registration.map || {})}, ${lineOffset})\n`;
            }

            file.code = file.code.replace(
                /(^|\n)([ \t]*)local function ([A-Za-z0-9_:.]+)\s*\(([^)]*)\)\s*\n/g,
                (m, p, indent, fnName, args, offset, source) => {
                    const line = getLine(source, offset);
                    const mapped = getSourceLocation(line);
                    const label = `${fnName} [${mapped.file}:${mapped.line}]`;
                    return `${p}${indent}local function ${fnName}(${args})` + makeTraceInline(label);
                }
            );

            file.code = file.code.replace(
                /(^|\n)([ \t]*)function ([A-Za-z0-9_:.]+)\s*\(([^)]*)\)\s*\n/g,
                (m, p, indent, fnName, args, offset, source) => {
                    const line = getLine(source, offset);
                    const mapped = getSourceLocation(line);
                    const label = `${fnName} [${mapped.file}:${mapped.line}]`;
                    return `${p}${indent}function ${fnName}(${args})` + makeTraceInline(label);
                }
            );

            file.code = file.code.replace(
                /(^|\n)([ \t]*)([A-Za-z0-9_.:\[\]"']+)\s*=\s*function\s*\(([^)]*)\)\s*\n/g,
                (m, p, indent, lhs, args, offset, source) => {
                    const line = getLine(source, offset);
                    const mapped = getSourceLocation(line);
                    const label = `${lhs} [${mapped.file}:${mapped.line}]`;
                    return `${p}${indent}${lhs} = function(${args})` + makeTraceInline(label);
                }
            );

            file.code = traceBootstrap + registrationCall + file.code;
        }
    },
};

module.exports = plugin;