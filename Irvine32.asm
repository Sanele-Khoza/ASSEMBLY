.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode:dword
include Irvine32.inc

.data
result sdword ?  ; Memory variable to store the final result

.code
main proc
    ; Part 1: Load -10 and 20, add them, and display result
    mov eax, -10      ; Load -10 into EAX (signed value)
    mov ebx, 20       ; Load 20 into EBX
    add eax, ebx      ; Add EBX to EAX (-10 + 20 = 10)
                      ; Flags affected: 
                      ;   SF=0 (positive result)
                      ;   ZF=0 (result not zero)
                      ;   CF=0 (no unsigned overflow)
                      ;   OF=0 (no signed overflow)
    call DumpRegs     ; Display registers (should show EAX=10)

    ; Part 2: Subtract 50 and display registers
    sub eax, 50       ; Subtract 50 from EAX (10 - 50 = -40)
                      ; Flags affected:
                      ;   SF=1 (negative result)
                      ;   ZF=0 (result not zero)
                      ;   CF=1 (unsigned underflow occurred)
                      ;   OF=0 (no signed overflow)
    call DumpRegs     ; Display registers (should show EAX=-40)

    ; Part 3: Load 0xFFFFFFFE, increment twice to show wrap-around
    mov ecx, 0FFFFFFFEh  ; Load ECX with -2 (signed) or 4,294,967,294 (unsigned)
    inc ecx            ; First increment (0xFFFFFFFE + 1 = 0xFFFFFFFF)
                       ; Flags affected:
                       ;   SF=1 (result is negative if interpreted as signed)
                       ;   ZF=0 (result not zero)
                       ;   OF=0 (no signed overflow)
                       ;   AF=1 (carry out from bit 3)
    inc ecx            ; Second increment (0xFFFFFFFF + 1 = 0x00000000)
                       ; Flags affected:
                       ;   SF=0 (result is zero/positive)
                       ;   ZF=1 (result is zero)
                       ;   OF=0 (no signed overflow)
                       ;   AF=1 (carry out from bit 3)
    call DumpRegs     ; Display registers (should show ECX=0)

    ; Part 4: Initialize register to 0, decrement to show underflow
    mov edx, 0        ; Load EDX with 0
    dec edx           ; Decrement EDX (0 - 1 = -1 or 0xFFFFFFFF)
                      ; Flags affected:
                      ;   SF=1 (result is negative if interpreted as signed)
                      ;   ZF=0 (result not zero)
                      ;   OF=0 (no signed overflow)
                      ;   AF=1 (carry out from bit 3)
    call DumpRegs     ; Display registers (should show EDX=0xFFFFFFFF)

    ; Part 5: Store final value of EAX into memory variable
    mov result, eax   ; Store EAX (-40) into memory variable 'result'

    invoke ExitProcess, 0
main endp
end main