provide-module dynamic-matching %!

    declare-option str-list backup_matching_pairs

    # Main Functions
    def dmatching-forward-select -hidden -params 2 -docstring %{
        dmatching-forward-select: Select next matching of %arg{1} and %arg{2}
    } %{
        set window backup_matching_pairs %opt{matching_pairs}
        set current matching_pairs %arg{1} %arg{2}
        try %{ eval -itersel %{ exec "<a-:>lm" } }
        set current matching_pairs %opt{backup_matching_pairs}
    }

    def dmatching-forward-extend -hidden -params 2 -docstring %{
        dmatching-forward-extend: Extend to next matching of %arg{1} and %arg{2}
    } %{
        set window backup_matching_pairs %opt{matching_pairs}
        set current matching_pairs %arg{1} %arg{2}
        try %{ exec -itersel -draft "Z<a-:>lm<a-z>u" ; exec "Z<a-:>lm<a-z>u" } 
        set current matching_pairs %opt{backup_matching_pairs}
    }

    def dmatching-backward-select -hidden -params 2 -docstring %{
        dmatching-backward-select: Select previous matching of %arg{1} and %arg{2}
    } %{
        set window backup_matching_pairs %opt{matching_pairs}
        set current matching_pairs %arg{1} %arg{2}
        try %{ exec -itersel "<a-:><a-;>h<a-m>" }
        set current matching_pairs %opt{backup_matching_pairs}
    }

    def dmatching-backward-extend -hidden -params 2 -docstring %{
        dmatching-backward-extend: Extend to previous matching of %arg{1} and %arg{2}
    } %{
        set window backup_matching_pairs %opt{matching_pairs}
        set current matching_pairs %arg{1} %arg{2}
        try %{
            exec -itersel -draft "Z<a-:><a-;>h<a-m><a-z>u" ;
            exec "Z<a-:><a-;>h<a-m><a-z>u"
        }
        set current matching_pairs %opt{backup_matching_pairs}
    }

    # Some nice functionality functions
    def selecting-f -docstring %{
        selecting-f: Typical f key from kakoune but only selecting character.
    } %{
        on-key %{ exec "f%val{key};" }
    }

    def extending-p -docstring %{
        extending-p: Extends selection to the current/next whole paragraph.
    } %{
        exec Z<a-a>p<a-z>u
    }



    alias global dmfs dmatching-forward-select
    alias global dmfe dmatching-forward-extend
    alias global dmbs dmatching-backward-select
    alias global dmbe dmatching-backward-extend

    def dynamic-matching-dmatch-conf -docstring %{
        dynamic-matching-dmatch-conf: default mappings using modes dmatch and Dmatch
    } %!!
        declare-user-mode dmatch
        declare-user-mode Dmatch
        map global dmatch } ': dmfs { }<ret>'              -docstring "block"
        map global dmatch ) ': dmfs ( )<ret>'              -docstring "block"
        map global dmatch ] ': dmfs [ ]<ret>'              -docstring "block"
        map global dmatch > ': dmfs <lt> <gt><ret>'        -docstring "block"
        map global dmatch { ': dmbs { }<ret>'              -docstring "block"
        map global dmatch ( ': dmbs ( )<ret>'              -docstring "block"
        map global dmatch [ ': dmbs [ ]<ret>'              -docstring "block"
        map global dmatch < ': dmbs <lt> <gt><ret>'        -docstring "block"

        map global Dmatch } ': dmfe { }<ret>'              -docstring "block"
        map global Dmatch ) ': dmfe ( )<ret>'              -docstring "block"
        map global Dmatch ] ': dmfe [ ]<ret>'              -docstring "block"
        map global Dmatch > ': dmfe <lt> <gt><ret>'        -docstring "block"
        map global Dmatch { ': dmbe { }<ret>'              -docstring "block"
        map global Dmatch ( ': dmbe ( )<ret>'              -docstring "block"
        map global Dmatch [ ': dmbe [ ]<ret>'              -docstring "block"
        map global Dmatch < ': dmbe <lt> <gt><ret>'        -docstring "block"

        map global dmatch c ': selecting-f<ret>'           -docstring "character"
        map global dmatch w ': word-select-next-word<ret>' -docstring "word"
        map global dmatch l x                              -docstring "line"
        map global dmatch p <a-a>p                         -docstring "paragraph"
        map global dmatch b '%'                            -docstring "buffer"

        map global Dmatch C F                              -docstring "character"
        map global Dmatch W W                              -docstring "word"
        map global Dmatch L X                              -docstring "line"
        map global Dmatch P ': extending-p<ret>'           -docstring "paragraph"
        map global Dmatch B '%'                            -docstring "buffer"
    !!

!

require-module dynamic-matching
