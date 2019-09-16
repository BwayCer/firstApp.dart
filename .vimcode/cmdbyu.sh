#!/bin/bash
# cmdByU.vim 執行腳本

# # 參數說明：
# #   * 方法
# #     * syntax      觸發格式化和提示訊息功能。
# #     * syntaxRun   運行該文件或專案。
# #     * syntaxDev   開發模式下運行該文件或專案。
# [[USAGE]] <方法 (syntax|*)>
#           <文件路徑> <文件副檔名> <專案目錄路徑> <執行文件目錄路徑>
#           <使用容器資訊 (inDocker|unDocker)>


##shStyle 共享變數


method="$1"
filePath="$2"
fileExt="$3"
projectDir="$4"
vimcodeDir="$5"
useDockerMsg="$6"

# 約定通訊文件
chanBufferContentPath="$vimcodeDir/chanBufferContent.cmdbyu.tmp"
chanFormatCodePath="$vimcodeDir/chanFormat.cmdbyu.tmp"
chanSyntaxInfoPath="$vimcodeDir/chanSyntax.cmdbyu.tmp"

# 暫存文件空間
sameFilePath="$filePath.cmdbyu.$fileExt"
stdoutTmpPath="$filePath.stdout.cmdbyu.tmp"


##shStyle 介面函式


fnMain() {
    local execFnName="fnMain_$method"
    if type "$execFnName" &> /dev/null ; then
        local tmpRtnCode

        cd "$projectDir"
        "$execFnName"
        tmpRtnCode=$?

        # 復原環境
        [ ! -f "$sameFilePath"  ] || rm "$sameFilePath"
        [ ! -f "$stdoutTmpPath" ] || rm "$stdoutTmpPath"

        if [ $tmpRtnCode -ne 0 ]; then
            echo "\"$method\" 方法無法處理 \"$fileExt\" 副檔名。"
            exit 1
        fi
    else
        echo "找不到 \"$method\" 方法。"
        exit 1
    fi
}
fnMain_syntax() {
    case "$fileExt" in
        dart )
            local tmpRtnCode regexTxt

            cat "$chanBufferContentPath" > "$sameFilePath"

            # 命令執行
            dartfmt "$sameFilePath" 2>&1 | tee "$stdoutTmpPath"
            tmpRtnCode=${PIPESTATUS[0]}

            # 命令處理
            regexTxt+="^line \([0-9]\+\), column \([0-9]\+\)"
            regexTxt+=" of .\+\.cmdbyu\.$fileExt: \([A-Z].\+\)"
            if [ $tmpRtnCode -eq 0 ]; then
                mv "$stdoutTmpPath" "$chanFormatCodePath"
            else
                cat "$stdoutTmpPath" |
                    grep "$regexTxt" |
                    sed "s/$regexTxt/\1:\2::\3/" |
                    awk "{print \"$filePath:\"\$0}" \
                    > "$chanSyntaxInfoPath"
            fi
            ;;
        * ) return 1 ;;
    esac
}
fnMain_syntaxDev() {
    case "$fileExt" in
        dart )
            local tmpRtnCode regexTxt

            cat "$chanBufferContentPath" > "$sameFilePath"

            # 命令執行
            dart --enable-asserts "$sameFilePath" 2>&1 | tee "$stdoutTmpPath"
            tmpRtnCode=${PIPESTATUS[0]}

            # 命令處理
            regexTxt+="^.\+\.cmdbyu\.$fileExt:\([0-9]\+\):\([0-9]\+\):"
            regexTxt+=" \(\(E\|W\)\(rror\|arning\): \)\?\(.\+\)"
            if [ $tmpRtnCode -ne 0 ]; then
                cat "$stdoutTmpPath" |
                    grep "$regexTxt" |
                    sed "s/$regexTxt/\1:\2:\4:\6/" |
                    awk "{print \"$filePath:\"\$0}" \
                    > "$chanSyntaxInfoPath"
            fi
            ;;
        * ) return 1 ;;
    esac
}


##shStyle ###


fnMain "$@"

