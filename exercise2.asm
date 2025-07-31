include irvine32.inc

.data
    InitialRegs BYTE "Initial register before operation"
    step1 BYTE "Regs after adding 5"

.code
    main proc
        ;Initial Registera
        MOV EDX, OFFSET InitialRegs
        CALL WRITESTRING
        CALL CRLF
        MOV EAX, 10
        MOV EBX, 8
        MOV ECX, 15
        MOV EDX, 20
        CALL DumpRegs

        ;Adding 5
        MOV EDX, OFFSET step1
        CALL WRITESTRING
        CALL CRLF
        ADD EAX, 5
        CALL DumpRegs
        CALL CRLF
    exit
    main endp
    end main