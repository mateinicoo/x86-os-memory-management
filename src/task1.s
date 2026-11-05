.data
    v: .space 4096
    n: .space 4
    op: .space 4
    id: .space 4
    mem: .space 4
    ok: .space 4
    start: .space 4
    end: .space 4
    cnt: .space 4
    x: .space 4
    y: .space 4
    cpy: .space 4
    citire: .asciz "%ld"
    afisare: .asciz "%ld: (%ld, %ld)\n"
    afisare1: .asciz "(%ld, %ld)\n"
    afisare2: .asciz "afis: %ld\n"
.text

.global main
main:
    lea v, %edi
    movl $0, %ecx



etinit:
    cmp $1024, %ecx
    je etinitend

    movl $0, (%edi, %ecx, 4)

    inc %ecx
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

    movl $0, ok
    movl $0, start

    movl $0, %edx
    movl mem, %eax
    addl $7, %eax
    movl $8, %ebx
    divl %ebx
    movl %eax, mem

whileadd1:

    cmpl $1, ok
    je whileadd1end
    cmpl $1023, start
    jge whileadd1end

whileadd2:

    cmpl $1023, start
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

    movl end, %ebx
    subl start, %ebx
    incl %ebx

whileadd3:

    cmpl $1023, end
    jge whileadd3end
    movl mem, %eax
    cmpl %eax, %ebx
    je whileadd3end

    incl end
    incl %ebx

    movl end, %ecx
    cmpl $0, (%edi, %ecx, 4)
    jne whileadd3end

    jmp whileadd3

whileadd3end:

    movl end, %ebx
    subl start, %ebx
    incl %ebx

    cmpl mem, %ebx
    jne ifadd1
    movl end, %ecx
    cmpl $0, (%edi, %ecx, 4)
    jne ifadd1

    movl $1, ok

    movl start, %ecx

foradd2:

    cmpl end, %ecx
    jg foradd2end

    movl id, %eax
    movl %eax, (%edi, %ecx, 4)

    incl %ecx
    jmp foradd2

foradd2end:


    pushl end
    pushl start
    pushl id
    pushl $afisare
    call printf
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
    jne ifadd2

    pushl $0
    pushl $0
    pushl id
    pushl $afisare
    call printf
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

    mov $0, %ecx

forget1:
    cmp $1024, %ecx
    je forget1end

    mov id, %ebx
    cmpl %ebx, (%edi, %ecx, 4)
    jne ifget1end

    cmpl $0, ok
    jne ifget2end

    movl %ecx, start
    movl $1, ok

ifget2end:

    movl %ecx, end


ifget1end:

    inc %ecx
    jmp forget1

forget1end:

    pushl end
    pushl start
    pushl $afisare1
    call printf
    popl %ebx
    popl %ebx
    popl %ebx

    pushl $0
    call fflush
    popl %ebx

    jmp finalloop





delete:

    #stergere

    pushl $id
    pushl $citire
    call scanf
    popl %ebx
    popl %ebx

    movl $0, cnt

fordelete1:
    cmpl $1024, cnt
    je fordelete1end

    movl id, %ebx
    movl cnt, %ecx
    cmpl %ebx, (%edi, %ecx, 4)
    jne ifdelete1

    movl cnt, %ecx
    movl $0, (%edi, %ecx, 4)

ifdelete1:

    incl cnt
    jmp fordelete1

fordelete1end:


    #afisare



    movl $0, cnt
    movl cnt, %ecx
    movl  (%edi, %ecx, 4), %ebx
    movl %ebx, id
    movl $0, start

    

fordelete2:

    cmpl $1024, cnt
    je fordelete2end

    movl id, %ebx
    movl cnt, %ecx
    cmpl %ebx,  (%edi, %ecx, 4)
    je ifdelete2
    cmpl $0, id
    je ifdelete2


    pushl end
    pushl start
    pushl id
    pushl $afisare
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx

    

    pushl $0
    call fflush
    popl %ebx

    movl $0, id

ifdelete2:

    movl id, %ebx
    movl cnt, %ecx
    cmpl %ebx, (%edi, %ecx, 4)
    je ifdelete3
    movl $0, %ebx
    movl cnt, %ecx
    cmpl %ebx, (%edi, %ecx, 4)
    je ifdelete3

    movl cnt, %ecx
    movl %ecx, start
    movl (%edi, %ecx, 4), %ebx
    movl %ebx, id

ifdelete3:

    movl id, %ebx
    movl cnt, %ecx
    cmpl %ebx, (%edi, %ecx, 4)
    jne ifdelete4

    movl cnt, %ecx
    movl %ecx, end


ifdelete4:

    incl cnt
    jmp fordelete2

fordelete2end:

    cmpl $0, id
    je ifdelete5
    
    pushl end
    pushl start
    pushl id
    pushl $afisare
    call printf
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
    movl $0, y

while1defrag:

    cmpl $1024, y
    jge while1defragend

    movl y, %ecx
    movl $0, %ebx

    cmpl (%edi, %ecx, 4), %ebx
    je if1defrag

    movl y, %ecx
    movl (%edi, %ecx, 4), %ebx
    movl %ebx, cpy

    movl $0, (%edi, %ecx, 4)

    movl x, %ecx
    movl cpy, %ebx
    movl %ebx, (%edi, %ecx, 4)
    
    incl x

if1defrag:

    incl y
    jmp while1defrag

while1defragend:


    #afisare



    movl $0, cnt
    movl cnt, %ecx
    movl  (%edi, %ecx, 4), %ebx
    movl %ebx, id
    movl $0, start

    

fordefrag2:

    cmpl $1024, cnt
    je fordefrag2end

    movl id, %ebx
    movl cnt, %ecx
    cmpl %ebx,  (%edi, %ecx, 4)
    je ifdefrag2
    cmpl $0, id
    je ifdefrag2


    pushl end
    pushl start
    pushl id
    pushl $afisare
    call printf
    popl %ebx
    popl %ebx
    popl %ebx
    popl %ebx

    

    pushl $0
    call fflush
    popl %ebx

    movl $0, id

ifdefrag2:

    movl id, %ebx
    movl cnt, %ecx
    cmpl %ebx, (%edi, %ecx, 4)
    je ifdefrag3
    movl $0, %ebx
    movl cnt, %ecx
    cmpl %ebx, (%edi, %ecx, 4)
    je ifdefrag3

    movl cnt, %ecx
    movl %ecx, start
    movl (%edi, %ecx, 4), %ebx
    movl %ebx, id

ifdefrag3:

    movl id, %ebx
    movl cnt, %ecx
    cmpl %ebx, (%edi, %ecx, 4)
    jne ifdefrag4

    movl cnt, %ecx
    movl %ecx, end


ifdefrag4:

    incl cnt
    jmp fordefrag2

fordefrag2end:

    cmpl $0, id
    je ifdefrag5
    
    pushl end
    pushl start
    pushl id
    pushl $afisare
    call printf
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
    mov $1, %eax
    xor %ebx, %ebx
    int $0x80
