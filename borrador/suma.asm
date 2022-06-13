extern printf

section.data

msg: db 'El resultado de la suma de 8 bits es:', 10, 0
section.text

sumaEImprime:
    push rbp
    mov rbp, rsp

    
    
    mov rdi, msg
    ;mov sil, al

    call printf

    pop rbp
    ret