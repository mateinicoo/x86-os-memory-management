.data
    v: .space 1044480
    n: .space 4
    op: .space 4
    ok: .space 4
    start: .space 4
    end: .space 4
    cnt: .space 4
    mem: .space 4
    id: .space 4
    y1: .space 4
    y2: .space 4
    x: .space 4
    cpy: .space 4
    k: .space 4
    citire: .asciz "%ld"
    afisare: .asciz "%ld: ((%ld, %ld), (%ld, %ld))\n"
    afisare1: .asciz "((%ld, %ld), (%ld, %ld))\n"
.text

.global main
main:

    lea v, %edi
    movl $0, %ecx

etinit:
    cmp $261120, %ecx
    je etinitend

    movl $0, (%edi, %ecx, 4)

    incl %ecx
    jmp etinit

etinitend:

    pushl $n
    pushl $citire
    call scanf
    popl %ebx
    popl %ebx



etloop:
    cmpl $0, n
    je etexit

    pushl $op
    pushl $citire
    call scanf
    popl %ebx
    popl %ebx


    cmpl $1, op
    je add
    cmpl $2, op
    je get
    cmpl $3, op
    je delete
    cmpl $4, op
    je defrag

add:

    pushl $op
    pushl $citire
    call scanf
    popl %ebx
    popl %ebx


foradd1:

    cmpl $0, op
    je foradd1end

    pushl $id
    pushl $citire
    call scanf
    popl %ebx
    popl %ebx
    
    pushl $mem
    pushl $citire
    call scanf
    popl %ebx
    popl %ebx

    movl mem, %eax
    addl $7, %eax
    movl $0, %edx
    movl $8, %ebx
    divl %ebx
    movl %eax, mem

    movl $0, ok
    movl $0, start
    movl $0, cnt

foradd2:

    cmpl $255, cnt
    jge foradd2end

    movl cnt, %eax
    movl $1024, %ebx
    mull %ebx
    movl %eax, start


whileadd1:

    cmpl $0, ok
    jne whileadd1end
    movl cnt, %eax
    movl $1024, %ebx
    mull %ebx
    addl $1023, %eax
    cmpl %eax, start
    jge whileadd1end

whileadd2:

    movl cnt, %eax
    movl $1024, %ebx
    mull %ebx
    addl $1023, %eax
    cmpl %eax, start
    jge whileadd2end
    movl start, %ecx
    movl $0, %eax
    cmpl %eax, (%edi, %ecx, 4)
    je whileadd2end

    incl start

    jmp whileadd2

whileadd2end:

    movl start, %eax
    movl %eax, end


whileadd3:

    movl cnt, %eax
    movl $1024, %ebx
    mull %ebx
    addl $1023, %eax
    cmpl %eax, end
    jge whileadd3end
    movl end, %eax
    subl start, %eax
    incl %eax
    cmpl %eax, mem
    je whileadd3end

    incl end

    movl end, %ecx
    movl $0, %eax
    cmpl %eax, (%edi, %ecx, 4)
    jne whileadd3end

    jmp whileadd3

whileadd3end:


    movl end, %eax
    subl start, %eax
    incl %eax
    cmpl %eax, mem
    jne ifadd1
    movl end, %ecx
    cmpl $0, (%edi, %ecx, 4)
    jne ifadd1

    movl $1, %eax
    movl %eax, ok

    movl start, %ecx

foradd3:

    cmpl %ecx, end
    jl foradd3end

    movl id, %eax
    movl %eax, (%edi, %ecx, 4)

    incl %ecx
    jmp foradd3

foradd3end:

    movl $0, %edx
    movl $1024, %ebx
    movl end, %eax
    divl %ebx
    pushl %edx
    pushl cnt
    movl $0, %edx
    movl $1024, %ebx
    movl start, %eax
    divl %ebx
    pushl %edx
    pushl cnt
    pushl id
    pushl $afisare
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

    jmp ifadd1end

ifadd1:

    movl end, %eax
    movl %eax, start

ifadd1end:

    jmp whileadd1

whileadd1end:

    cmpl $0, ok
    jne foradd2end

    incl cnt
    jmp foradd2


foradd2end:



    cmpl $0, ok
    jne ifadd2

    movl $0, %eax
    pushl %eax
    pushl %eax
    pushl %eax
    pushl %eax
    pushl id
    pushl $afisare
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

ifadd2:


    decl op
    jmp foradd1

foradd1end:


    jmp finalloop


get:

    movl $0, start
    movl $0, end
    movl $0, ok

    pushl $id
    pushl $citire
    call scanf
    popl %ebx
    popl %ebx

    movl $0, %ecx

forget1:

    cmpl $261120, %ecx
    jge forget1end

    movl id, %eax
    cmpl %eax, (%edi, %ecx, 4)
    jne ifget1

    cmpl $0, ok
    jne ifget2

    movl %ecx, start
    movl $1, ok

ifget2:

    movl %ecx, end

ifget1:

    incl %ecx
    jmp forget1

forget1end:


    movl $0, %edx
    movl $1024, %ebx
    movl end, %eax
    divl %ebx
    pushl %edx
    pushl %eax
    movl $0, %edx
    movl $1024, %ebx
    movl start, %eax
    divl %ebx
    pushl %edx
    pushl %eax
    pushl $afisare1
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

jmp finalloop



delete:


    #delete


    pushl $id
    pushl $citire
    call scanf
    popl %ebx
    popl %ebx

    movl $0, %ecx

fordelete1:

    cmpl $261120, %ecx
    jge fordelete1end

    movl id, %eax
    cmpl %eax, (%edi, %ecx, 4)
    jne ifdelete1

    movl $0, (%edi, %ecx, 4)

ifdelete1:

    incl %ecx
    jmp fordelete1

fordelete1end:


    #afisare


    movl $0, %ecx
    movl (%edi, %ecx, 4), %eax
    movl %eax, id
    movl $0, start

    movl $0, cnt

fordelete3:

    cmpl $261120, cnt
    jge fordelete3end

    movl cnt, %ecx
    movl id, %eax
    cmpl %eax, (%edi, %ecx, 4)
    je ifdelete2
    cmpl $0, %eax
    je ifdelete2

    
    movl $0, %edx
    movl $1024, %ebx
    movl end, %eax
    divl %ebx
    pushl %edx
    pushl %eax
    movl $0, %edx
    movl $1024, %ebx
    movl start, %eax
    divl %ebx
    pushl %edx
    pushl %eax
    pushl id
    pushl $afisare
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

    movl $0, id

ifdelete2:
    
    movl cnt, %ecx
    movl id, %eax
    cmpl %eax, (%edi, %ecx, 4)
    je ifdelete3
    cmpl $0, (%edi, %ecx, 4)
    je ifdelete3

    movl cnt, %eax
    movl %eax, start

    movl cnt, %ecx
    movl (%edi, %ecx, 4), %eax
    movl %eax, id


ifdelete3:

    movl cnt, %ecx
    movl id, %eax
    cmpl %eax, (%edi, %ecx, 4)
    jne ifdelete4

    movl cnt, %eax
    movl %eax, end

ifdelete4:

    incl cnt
    jmp fordelete3

fordelete3end:

    movl id, %eax
    cmpl $0, %eax
    je ifdelete5

    movl $0, %edx
    movl $1024, %ebx
    movl end, %eax
    divl %ebx
    pushl %edx
    pushl %eax
    movl $0, %edx
    movl $1024, %ebx
    movl start, %eax
    divl %ebx
    pushl %edx
    pushl %eax
    pushl id
    pushl $afisare
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

ifdelete5:

    jmp finalloop




defrag:


    #defragmentare

    movl $0, x
    movl $0, y1
    movl $0, y2
    movl $0, k

whiledefrag1:

    cmpl $261120, y1
    jge whiledefrag1end


whiledefrag2:

    cmpl $261120, y1
    jge whiledefrag2end
    movl y1, %ecx
    movl $0, %eax
    cmpl %eax, (%edi, %ecx, 4)
    jne whiledefrag2end

    incl y1

    jmp whiledefrag2

whiledefrag2end:

    movl y1, %ecx
    movl (%edi, %ecx, 4), %eax
    movl %eax, id
    movl y1, %eax
    movl %eax, y2


whiledefrag3:

    cmpl $261120, y2
    jge whiledefrag3end
    movl id, %eax
    movl y2, %ecx
    cmpl %eax, (%edi, %ecx, 4)
    jne whiledefrag3end

    incl y2

    jmp whiledefrag3

whiledefrag3end:

    movl k, %eax
    incl %eax
    movl $1024, %ebx
    mull %ebx
    subl x, %eax

    movl y2, %ebx
    subl y1, %ebx

    cmpl %eax, %ebx
    jle ifdefrag1

    incl k
    movl k, %eax
    movl $1024, %ebx
    mull %ebx
    movl %eax, x


ifdefrag1:


whiledefrag4:

    movl y1, %eax
    cmpl %eax, y2
    jle whiledefrag4end

    movl y1, %ecx
    movl (%edi, %ecx, 4), %eax
    movl %eax, cpy

    movl y1, %ecx
    movl $0, %eax
    movl %eax, (%edi, %ecx, 4)

    movl x, %ecx
    movl cpy, %eax
    movl %eax, (%edi, %ecx, 4)

    incl x
    incl y1

    jmp whiledefrag4

whiledefrag4end:

    jmp whiledefrag1

whiledefrag1end:




    #afisare





    movl $0, %ecx
    movl (%edi, %ecx, 4), %eax
    movl %eax, id
    movl $0, start

    movl $0, cnt

fordefrag1:

    cmpl $261120, cnt
    jge fordefrag1end

    movl cnt, %ecx
    movl id, %eax
    cmpl %eax, (%edi, %ecx, 4)
    je ifdefrag2
    cmpl $0, %eax
    je ifdefrag2

    
    movl $0, %edx
    movl $1024, %ebx
    movl end, %eax
    divl %ebx
    pushl %edx
    pushl %eax
    movl $0, %edx
    movl $1024, %ebx
    movl start, %eax
    divl %ebx
    pushl %edx
    pushl %eax
    pushl id
    pushl $afisare
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

    movl $0, id

ifdefrag2:
    
    movl cnt, %ecx
    movl id, %eax
    cmpl %eax, (%edi, %ecx, 4)
    je ifdefrag3
    cmpl $0, (%edi, %ecx, 4)
    je ifdefrag3

    movl cnt, %eax
    movl %eax, start

    movl cnt, %ecx
    movl (%edi, %ecx, 4), %eax
    movl %eax, id


ifdefrag3:

    movl cnt, %ecx
    movl id, %eax
    cmpl %eax, (%edi, %ecx, 4)
    jne ifdefrag4

    movl cnt, %eax
    movl %eax, end

ifdefrag4:

    incl cnt
    jmp fordefrag1

fordefrag1end:

    movl id, %eax
    cmpl $0, %eax
    je ifdefrag5

    movl $0, %edx
    movl $1024, %ebx
    movl end, %eax
    divl %ebx
    pushl %edx
    pushl %eax
    movl $0, %edx
    movl $1024, %ebx
    movl start, %eax
    divl %ebx
    pushl %edx
    pushl %eax
    pushl id
    pushl $afisare
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

ifdefrag5:

    jmp finalloop



finalloop:

    decl n
    jmp etloop


etexit:

    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80
