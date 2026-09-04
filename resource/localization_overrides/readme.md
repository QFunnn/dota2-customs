--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


# 本地化覆盖层

`professional.csv` 保存经过人工审校的英文、俄文和越南文全局译文。`addon_schinese.txt` 是唯一有效 Token 目录；其他语言只能覆盖这些 Token 的文本，不能新增运行时 Token。生成外语 `addon_*.txt` 时不会读取旧外语文件作为底表，因此不要直接维护生成后的外语文件。

## 日常生成流程

1. `yarn dev`、`predev`、`build` 和 `prod` 只实时生成 `addon_schinese.txt`，不会改写其他语言文件。
2. 需要补齐新 Token 时，手动运行 `npm run localization:placeholders`，从当前简中目录无状态生成英文、俄文和越南文初译 TXT。
3. 运行 `npm run translate:localization` 调用 LLM，将通过校验的译文写入 `localization_overrides/*_<language>.csv`；此步骤不会修改任何 `addon_*.txt`。如果部分译文缺失或校验失败，命令会保留已成功译文并以失败状态退出，再次运行即可续翻剩余 Token。
4. 翻译完成后，运行 VS Code 任务“国际化-将翻译CSV合成到addon TXT”或 `npm run localization:build`，将普通覆盖、LLM 译文和专业译文汇总到多语言 addon 文件。
5. 将当前简中和三份完整外语 TXT 交给专业翻译人员。返稿后运行“国际化-导入专业翻译TXT”，再运行“国际化-生成并校验最终多语言TXT”。

非中文最终优先级为：当前简中基线对应的专业译文（审核状态为空或 `approved`）→ 对应语言覆盖 → 源 CSV 对应语言 → 英文覆盖/源英文 → 实时简中。简中始终以实时生成的 Token 和文本为准。专业译文的 `SChineseBaseline` 与当前简中不一致时不会参与生成，并会重新进入缺失翻译队列。

## 导入专业译稿

```powershell
npm run import:professional-localization -- --english="<addon_english.txt>" --russian="<addon_russian.txt>" --vietnamese="<addon_vietnamese.txt>" --review-batch="<批次>" --refresh-baseline
```

导入脚本会校验语言、重复 Token、大小写冲突、三种译稿与当前简中的完整 Token 集合、占位符与富文本标签，并使用原子写入更新 `professional.csv`。格式不一致的单语言译文会标记为 `needs_review`，在修复并改为 `approved` 前不会参与生成。

`SChineseBaseline` 是译文审校时对应的简体中文原文。重复导入默认保留既有基线；只有译者已经根据当前原文重新审校后，才使用 `--refresh-baseline` 更新：

```powershell
npm run import:professional-localization -- --english="<addon_english.txt>" --russian="<addon_russian.txt>" --vietnamese="<addon_vietnamese.txt>" --review-batch="<批次>" --refresh-baseline
```

如果后续开发修改了某个 Token 的简体中文原文，生成任务会输出复核提示并暂停该 Token 的旧专业覆盖。复核完成后应及时更新译文，并使用 `--refresh-baseline` 更新审校基线。

如果返稿只包含英文或俄文子集，可以分别导入。子集允许缺少当前新增 Token，但不能包含当前简中目录之外的失效 Token；未包含的 Token 和其他语言译文会保留不变：

```powershell
npm run import:professional-localization -- --partial-english --english="<addon_english.txt>" --review-batch="<批次>"
npm run import:professional-localization -- --partial-russian --russian="<addon_russian.txt>" --review-batch="<批次>"
```

当子集返稿对应的简中基线发生变化时，导入器会更新本语言译文，并将没有随本批次复核的其他语言标记为 `needs_review`。

## 审计与清理

- `npm run localization:audit-orphans`：只读检查覆盖 CSV 和外语 addon 中是否存在简中目录之外的 Token；发现孤儿时返回失败。
- `npm run localization:prune-orphans`：显式删除覆盖 CSV 中的孤儿行；外语 addon 的孤儿会在下一次无状态构建时消失。
- `npm run localization:final`：重建多语言 TXT 后执行孤儿审计。