#!/bin/bash
# Cygwin (Window bash) 環境運行命令

# [[SUBCMD]]
#   unixType        dos to unix, chmod 644 格式化文件。
#   rsync           同步更新。
#   flutterFormat   以 \`flutter\` 命令格式化程式碼。


##shStyle 介面函式


fnMain() {
    local method="$1"
    shift

    local execFnName="fnMain_$method"
    if type "$execFnName" &> /dev/null ; then
        fnThrow_method=$method
        "$execFnName" "$@"
    else
        echo "找不到 \"$method\" 方法。"
        exit 1
    fi
}
fnMain_unixType() {
    find . -not -path "./.git/*"                      -type f -exec dos2unix {} \;
    find . -not -path "./.git/*" -not -path "*/bin/*" -type f -exec chmod 644 {} \;
}
# 同步更新
# [[USAGE]] <轉發方向 (L|R))> <遠端位置>
# [[OPT]]
#   -*, --*   攜帶選項旗標。
fnMain_rsync() {
    local opt_carryOpt=()

    while [ -n "y" ]
    do
        case "$1" in
            -- ) shift && break ;;
            -* )
                opt_carryOpt+=($1) && shift
                [ -z "$1" ] || [[ "$1" =~ ^- ]] || { opt_carryOpt+=($1) && shift; }
                ;;
            * ) break ;;
        esac
    done

    local method="$1"
    local remotePath="$2"

    # 尾端有無 "/" 對 \`rsync\` 命令來說有不同意思
    local localPath="`realpath "$_dirsh/.."`/"

    local cmdList=(
        "rsync"
        # "-av" "--delete"
        "${opt_carryOpt[@]}"
        "--exclude" ".git"
    )

    if [ "$method" == "L" ]; then
        cmdList+=("$localPath" "$remotePath")
    elif [ "$method" == "R" ]; then
        cmdList+=("$remotePath" "$localPath")
    else
         fnThrow "未指定轉發方向。"
    fi

    echo "\$ ${cmdList[@]}<ENTER>"
    exec "${cmdList[@]}"
}
fnMain_flutterFormat() {
    wbbash flutter format "$(cygpath -w "$sameFilePath")"
}
fnMain_vimcodeSyntax() {
    local method="$1"
    local filePath="$2"
    local fileExt="$3"
    local projectDir="$4"
    local vimcodeDir="$5"
    local useDockerMsg="$6"

    local chanBufferContentPath="$vimcodeDir/chanBufferContent.cmdbyu.tmp"
    local chanFormatCodePath="$vimcodeDir/chanFormat.cmdbyu.tmp"
    local chanSyntaxInfoPath="$vimcodeDir/chanSyntax.cmdbyu.tmp"

    case "$fileExt" in
        dart )
            local tmpRtnCode regexTxt

            cat "$chanBufferContentPath" > "$sameFilePath"

            # 命令執行
            wbbash flutter format "$(cygpath -w "$sameFilePath")" 2>&1 |
                tee "$stdoutTmpPath"
            tmpRtnCode=${PIPESTATUS[0]}

            # 命令處理
            regexTxt+="^line \([0-9]\+\), column \([0-9]\+\)"
            regexTxt+=" of .\+\.cmdbyu\.$fileExt: \([A-Z].\+\)"
            if [ $tmpRtnCode -eq 0 ]; then
                mv "$sameFilePath" "$chanFormatCodePath"
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


##shStyle 函式庫


fnThrow() {
    local msg="$1"
    local formatArgus="[$_fileName#$fnThrow_method]: %s$_br"
    printf "$formatArgus" "$msg" >&2
    exit 1
}
fnThrow_method=""


##shStyle ###


[ -n "$_br" ] || _br="
"

__filename=`realpath "$0"`
_dirsh=`dirname "$__filename"`
_fileName=`basename "$__filename"`


fnMain "$@"

