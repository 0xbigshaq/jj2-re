
; this is the subroutine that saves the game's state. 
; added some re-names to the subroutine so it will be less difficult to read.

.text:004593F0 ; =============== S U B R O U T I N E =======================================
.text:004593F0
.text:004593F0
.text:004593F0 JazzSaveFile    proc near               ; CODE XREF: sub_459BE0+22p
.text:004593F0                                         ; sub_45AD80+4B6p
.text:004593F0
.text:004593F0 var_2C          = dword ptr -2Ch
.text:004593F0 Buffer          = dword ptr -28h
.text:004593F0 var_24          = dword ptr -24h
.text:004593F0 FileName        = byte ptr -20h
.text:004593F0 var_1C          = dword ptr -1Ch
.text:004593F0 var_18          = dword ptr -18h
.text:004593F0 var_14          = byte ptr -14h
.text:004593F0 nNumberOfBytesToWrite= dword ptr  4
.text:004593F0
.text:004593F0                 sub     esp, 2Ch
.text:004593F3                 mov     eax, [esp+2Ch+nNumberOfBytesToWrite]
.text:004593F7                 push    ebx
.text:004593F8                 push    ebp
.text:004593F9                 push    esi
.text:004593FA                 test    eax, eax
.text:004593FC                 push    edi             ; char
.text:004593FD                 mov     [esp+3Ch+var_2C], 0
.text:00459405                 jge     short loc_45942F
.text:00459407                 mov     eax, dword_4D0810
.text:0045940C                 mov     ecx, dword_4D0814
.text:00459412                 mov     edx, dword_4D0818
.text:00459418                 mov     dword ptr [esp+3Ch+FileName], eax
.text:0045941C                 mov     al, byte_4D081C
.text:00459421                 mov     [esp+3Ch+var_1C], ecx
.text:00459425                 mov     [esp+3Ch+var_18], edx
.text:00459429                 mov     [esp+3Ch+var_14], al
.text:0045942D                 jmp     short loc_459442
.text:0045942F ; ---------------------------------------------------------------------------
.text:0045942F
.text:0045942F loc_45942F:                             ; CODE XREF: JazzSaveFile+15j
.text:0045942F                 push    eax
.text:00459430                 lea     ecx, [esp+40h+FileName]
.text:00459434                 push    offset aSavegame_03u ; "SAVEGAME.%03u"
.text:00459439                 push    ecx             ; char *
.text:0045943A                 call    _sprintf
.text:0045943F                 add     esp, 0Ch
.text:00459442
.text:00459442 loc_459442:                             ; CODE XREF: JazzSaveFile+3Dj
.text:00459442                 lea     edx, [esp+3Ch+FileName]
.text:00459446                 push    1
.text:00459448                 push    edx             ; lpFileName
.text:00459449                 call    OpenJazzFileWriteMode
.text:0045944E                 mov     esi, eax
.text:00459450                 add     esp, 8
.text:00459453                 test    esi, esi
.text:00459455                 jz      loc_4597D4
.text:0045945B                 mov     eax, off_4CD174
.text:00459460                 lea     edx, [esp+3Ch+Buffer]
.text:00459464                 push    4               ; nNumberOfBytesToWrite
.text:00459466                 push    edx             ; lpBuffer
.text:00459467                 mov     ecx, [eax+2]
.text:0045946A                 push    esi             ; NumberOfBytesWritten
.text:0045946B                 mov     [esp+48h+Buffer], ecx
.text:0045946F                 call    JazzWriteFile
.text:00459474                 mov     ebx, dword_5A4520
.text:0045947A                 add     esp, 0Ch
.text:0045947D                 mov     [esp+3Ch+nNumberOfBytesToWrite], 5E80h
.text:00459485                 push    5E80h
.text:0045948A                 call    sub_4987E0
.text:0045948F                 add     esp, 4
.text:00459492                 mov     edi, eax
.text:00459494                 lea     eax, [esp+3Ch+nNumberOfBytesToWrite]
.text:00459498                 push    3E80h
.text:0045949D                 push    ebx
.text:0045949E                 push    eax
.text:0045949F                 push    edi
.text:004594A0                 call    sub_49C880
.text:004594A5                 add     esp, 10h
.text:004594A8                 lea     ecx, [esp+3Ch+nNumberOfBytesToWrite]
.text:004594AC                 push    4               ; nNumberOfBytesToWrite
.text:004594AE                 push    ecx             ; lpBuffer
.text:004594AF                 push    esi             ; NumberOfBytesWritten
.text:004594B0                 call    JazzWriteFile
.text:004594B5                 mov     edx, [esp+48h+nNumberOfBytesToWrite]
.text:004594B9                 add     esp, 0Ch
.text:004594BC                 push    edx             ; nNumberOfBytesToWrite
.text:004594BD                 push    edi             ; lpBuffer
.text:004594BE                 push    esi             ; NumberOfBytesWritten
.text:004594BF                 call    JazzWriteFile
.text:004594C4                 add     esp, 0Ch
.text:004594C7                 push    edi
.text:004594C8                 call    sub_4987F0
.text:004594CD                 mov     eax, dword_5A4520
.text:004594D2                 add     esp, 4
.text:004594D5                 add     eax, 3E80h
.text:004594DA                 push    20h             ; nNumberOfBytesToWrite
.text:004594DC                 push    eax             ; lpBuffer
.text:004594DD                 push    esi             ; NumberOfBytesWritten
.text:004594DE                 call    JazzWriteFile
.text:004594E3                 add     esp, 0Ch
.text:004594E6                 push    20h             ; nNumberOfBytesToWrite
.text:004594E8                 push    offset SrcStr   ; lpBuffer
.text:004594ED                 push    esi             ; NumberOfBytesWritten
.text:004594EE                 call    JazzWriteFile
.text:004594F3                 add     esp, 0Ch
.text:004594F6                 push    20h             ; nNumberOfBytesToWrite
.text:004594F8                 push    offset byte_547313 ; lpBuffer
.text:004594FD                 push    esi             ; NumberOfBytesWritten
.text:004594FE                 call    JazzWriteFile
.text:00459503                 add     esp, 0Ch
.text:00459506                 push    4               ; nNumberOfBytesToWrite
.text:00459508                 push    offset dword_5DB7EC ; lpBuffer
.text:0045950D                 push    esi             ; NumberOfBytesWritten
.text:0045950E                 call    JazzWriteFile
.text:00459513                 add     esp, 0Ch
.text:00459516                 push    4               ; nNumberOfBytesToWrite
.text:00459518                 push    offset dword_5A4B68 ; lpBuffer
.text:0045951D                 push    esi             ; NumberOfBytesWritten
.text:0045951E                 call    JazzWriteFile
.text:00459523                 add     esp, 0Ch
.text:00459526                 push    4               ; nNumberOfBytesToWrite
.text:00459528                 push    offset dword_58A5A0 ; lpBuffer
.text:0045952D                 push    esi             ; NumberOfBytesWritten
.text:0045952E                 call    JazzWriteFile
.text:00459533                 add     esp, 0Ch
.text:00459536                 push    4               ; nNumberOfBytesToWrite
.text:00459538                 push    offset dword_55CA50 ; lpBuffer
.text:0045953D                 push    esi             ; NumberOfBytesWritten
.text:0045953E                 call    JazzWriteFile
.text:00459543                 add     esp, 0Ch
.text:00459546                 push    4               ; nNumberOfBytesToWrite
.text:00459548                 push    offset dword_59C30C ; lpBuffer
.text:0045954D                 push    esi             ; NumberOfBytesWritten
.text:0045954E                 call    JazzWriteFile
.text:00459553                 add     esp, 0Ch
.text:00459556                 push    40h             ; nNumberOfBytesToWrite
.text:00459558                 push    offset unk_5DB800 ; lpBuffer
.text:0045955D                 push    esi             ; NumberOfBytesWritten
.text:0045955E                 call    JazzWriteFile
.text:00459563                 mov     eax, dword_5DB7EC
.text:00459568                 add     esp, 0Ch
.text:0045956B                 lea     ecx, [eax+eax*4]
.text:0045956E                 lea     ecx, [ecx+ecx*8]
.text:00459571                 lea     edi, [eax+ecx*8]
.text:00459574                 shl     edi, 2
.text:00459577                 lea     eax, [edi+2000h]
.text:0045957D                 push    eax
.text:0045957E                 mov     [esp+40h+nNumberOfBytesToWrite], eax
.text:00459582                 call    sub_4987E0
.text:00459587                 add     esp, 4
.text:0045958A                 lea     edx, [esp+3Ch+nNumberOfBytesToWrite]
.text:0045958E                 mov     ebx, eax
.text:00459590                 push    edi
.text:00459591                 push    offset unk_5A4EE0
.text:00459596                 push    edx
.text:00459597                 push    ebx
.text:00459598                 call    sub_49C880
.text:0045959D                 add     esp, 10h
.text:004595A0                 lea     eax, [esp+3Ch+nNumberOfBytesToWrite]
.text:004595A4                 push    4               ; nNumberOfBytesToWrite
.text:004595A6                 push    eax             ; lpBuffer
.text:004595A7                 push    esi             ; NumberOfBytesWritten
.text:004595A8                 call    JazzWriteFile
.text:004595AD                 mov     ecx, [esp+48h+nNumberOfBytesToWrite]
.text:004595B1                 add     esp, 0Ch
.text:004595B4                 push    ecx             ; nNumberOfBytesToWrite
.text:004595B5                 push    ebx             ; lpBuffer
.text:004595B6                 push    esi             ; NumberOfBytesWritten
.text:004595B7                 call    JazzWriteFile
.text:004595BC                 add     esp, 0Ch
.text:004595BF                 push    ebx
.text:004595C0                 call    sub_4987F0
.text:004595C5                 add     esp, 4
.text:004595C8                 mov     [esp+3Ch+nNumberOfBytesToWrite], 20A4h
.text:004595D0                 push    20A4h
.text:004595D5                 call    sub_4987E0
.text:004595DA                 add     esp, 4
.text:004595DD                 lea     edx, [esp+3Ch+nNumberOfBytesToWrite]
.text:004595E1                 mov     edi, eax
.text:004595E3                 push    0A4h
.text:004595E8                 push    offset dword_5D01A0
.text:004595ED                 push    edx
.text:004595EE                 push    edi
.text:004595EF                 call    sub_49C880
.text:004595F4                 add     esp, 10h
.text:004595F7                 lea     eax, [esp+3Ch+nNumberOfBytesToWrite]
.text:004595FB                 push    4               ; nNumberOfBytesToWrite
.text:004595FD                 push    eax             ; lpBuffer
.text:004595FE                 push    esi             ; NumberOfBytesWritten
.text:004595FF                 call    JazzWriteFile
.text:00459604                 mov     ecx, [esp+48h+nNumberOfBytesToWrite]
.text:00459608                 add     esp, 0Ch
.text:0045960B                 push    ecx             ; nNumberOfBytesToWrite
.text:0045960C                 push    edi             ; lpBuffer
.text:0045960D                 push    esi             ; NumberOfBytesWritten
.text:0045960E                 call    JazzWriteFile
.text:00459613                 add     esp, 0Ch
.text:00459616                 push    edi
.text:00459617                 call    sub_4987F0
.text:0045961C                 add     esp, 4
.text:0045961F                 push    4               ; nNumberOfBytesToWrite
.text:00459621                 push    offset dword_5FCCF8 ; lpBuffer
.text:00459626                 push    esi             ; NumberOfBytesWritten
.text:00459627                 call    JazzWriteFile
.text:0045962C                 mov     eax, dword_5FCCF8
.text:00459631                 mov     ebx, 1
.text:00459636                 add     esp, 0Ch
.text:00459639                 cmp     eax, ebx
.text:0045963B                 jle     short loc_459696
.text:0045963D                 mov     edi, 80h
.text:00459642
.text:00459642 loc_459642:                             ; CODE XREF: JazzSaveFile+2A4j
.text:00459642                 mov     edx, dword_58A8A0
.text:00459648                 mov     eax, [edx+edi]
.text:0045964B                 lea     ecx, [edx+edi]
.text:0045964E                 test    eax, eax
.text:00459650                 jz      short loc_45967A
.text:00459652                 sub     eax, offset nullsub_2
.text:00459657                 push    4               ; nNumberOfBytesToWrite
.text:00459659                 mov     [esp+40h+var_24], eax
.text:0045965D                 lea     eax, [esp+40h+var_24]
.text:00459661                 push    eax             ; lpBuffer
.text:00459662                 push    esi             ; NumberOfBytesWritten
.text:00459663                 call    JazzWriteFile
.text:00459668                 mov     ecx, dword_58A8A0
.text:0045966E                 add     esp, 0Ch
.text:00459671                 lea     edx, [ecx+edi+4]
.text:00459675                 push    7Ch
.text:00459677                 push    edx
.text:00459678                 jmp     short loc_45967D
.text:0045967A ; ---------------------------------------------------------------------------
.text:0045967A
.text:0045967A loc_45967A:                             ; CODE XREF: JazzSaveFile+260j
.text:0045967A                 push    4               ; nNumberOfBytesToWrite
.text:0045967C                 push    ecx             ; lpBuffer
.text:0045967D
.text:0045967D loc_45967D:                             ; CODE XREF: JazzSaveFile+288j
.text:0045967D                 push    esi             ; NumberOfBytesWritten
.text:0045967E                 call    JazzWriteFile
.text:00459683                 mov     eax, dword_5FCCF8
.text:00459688                 add     esp, 0Ch
.text:0045968B                 inc     ebx
.text:0045968C                 add     edi, 80h
.text:00459692                 cmp     ebx, eax
.text:00459694                 jl      short loc_459642
.text:00459696
.text:00459696 loc_459696:                             ; CODE XREF: JazzSaveFile+24Bj
.text:00459696                 mov     eax, dword_518E34
.text:0045969B                 mov     ebx, dword_518E20
.text:004596A1                 mov     ebp, [eax]
.text:004596A3                 lea     eax, [ebx+2000h]
.text:004596A9                 push    eax
.text:004596AA                 mov     [esp+40h+nNumberOfBytesToWrite], eax
.text:004596AE                 call    sub_4987E0
.text:004596B3                 add     esp, 4
.text:004596B6                 lea     ecx, [esp+3Ch+nNumberOfBytesToWrite]
.text:004596BA                 mov     edi, eax
.text:004596BC                 push    ebx
.text:004596BD                 push    ebp
.text:004596BE                 push    ecx
.text:004596BF                 push    edi
.text:004596C0                 call    sub_49C880
.text:004596C5                 add     esp, 10h
.text:004596C8                 lea     edx, [esp+3Ch+nNumberOfBytesToWrite]
.text:004596CC                 push    4               ; nNumberOfBytesToWrite
.text:004596CE                 push    edx             ; lpBuffer
.text:004596CF                 push    esi             ; NumberOfBytesWritten
.text:004596D0                 call    JazzWriteFile
.text:004596D5                 mov     eax, [esp+48h+nNumberOfBytesToWrite]
.text:004596D9                 add     esp, 0Ch
.text:004596DC                 push    eax             ; nNumberOfBytesToWrite
.text:004596DD                 push    edi             ; lpBuffer
.text:004596DE                 push    esi             ; NumberOfBytesWritten
.text:004596DF                 call    JazzWriteFile
.text:004596E4                 add     esp, 0Ch
.text:004596E7                 push    edi
.text:004596E8                 call    sub_4987F0
.text:004596ED                 mov     ebx, dword_5509C8
.text:004596F3                 mov     ebp, dword_514DC0
.text:004596F9                 add     esp, 4
.text:004596FC                 lea     eax, [ebx+2000h]
.text:00459702                 push    eax
.text:00459703                 mov     [esp+40h+nNumberOfBytesToWrite], eax
.text:00459707                 call    sub_4987E0
.text:0045970C                 add     esp, 4
.text:0045970F                 lea     ecx, [esp+3Ch+nNumberOfBytesToWrite]
.text:00459713                 mov     edi, eax
.text:00459715                 push    ebx
.text:00459716                 push    ebp
.text:00459717                 push    ecx
.text:00459718                 push    edi
.text:00459719                 call    sub_49C880
.text:0045971E                 add     esp, 10h
.text:00459721                 lea     edx, [esp+3Ch+nNumberOfBytesToWrite]
.text:00459725                 push    4               ; nNumberOfBytesToWrite
.text:00459727                 push    edx             ; lpBuffer
.text:00459728                 push    esi             ; NumberOfBytesWritten
.text:00459729                 call    JazzWriteFile
.text:0045972E                 mov     eax, [esp+48h+nNumberOfBytesToWrite]
.text:00459732                 add     esp, 0Ch
.text:00459735                 push    eax             ; nNumberOfBytesToWrite
.text:00459736                 push    edi             ; lpBuffer
.text:00459737                 push    esi             ; NumberOfBytesWritten
.text:00459738                 call    JazzWriteFile
.text:0045973D                 add     esp, 0Ch
.text:00459740                 push    edi
.text:00459741                 call    sub_4987F0
.text:00459746                 add     esp, 4
.text:00459749                 mov     [esp+3Ch+nNumberOfBytesToWrite], 2020h
.text:00459751                 push    2020h
.text:00459756                 call    sub_4987E0
.text:0045975B                 add     esp, 4
.text:0045975E                 lea     ecx, [esp+3Ch+nNumberOfBytesToWrite]
.text:00459762                 mov     edi, eax
.text:00459764                 push    20h
.text:00459766                 push    offset byte_5C68E0
.text:0045976B                 push    ecx
.text:0045976C                 push    edi
.text:0045976D                 call    sub_49C880
.text:00459772                 add     esp, 10h
.text:00459775                 lea     edx, [esp+3Ch+nNumberOfBytesToWrite]
.text:00459779                 push    4               ; nNumberOfBytesToWrite
.text:0045977B                 push    edx             ; lpBuffer
.text:0045977C                 push    esi             ; NumberOfBytesWritten
.text:0045977D                 call    JazzWriteFile
.text:00459782                 mov     eax, [esp+48h+nNumberOfBytesToWrite]
.text:00459786                 add     esp, 0Ch
.text:00459789                 push    eax             ; nNumberOfBytesToWrite
.text:0045978A                 push    edi             ; lpBuffer
.text:0045978B                 push    esi             ; NumberOfBytesWritten
.text:0045978C                 call    JazzWriteFile
.text:00459791                 add     esp, 0Ch
.text:00459794                 push    edi
.text:00459795                 call    sub_4987F0
.text:0045979A                 add     esp, 4
.text:0045979D                 push    esi
.text:0045979E                 call    sub_49A620
.text:004597A3                 add     esp, 4
.text:004597A6                 test    al, al
.text:004597A8                 jz      short loc_4597BF
.text:004597AA                 push    offset aWarningFileSav ; "Warning: file save error"
.text:004597AF                 call    sub_48FA80
.text:004597B4                 add     esp, 4
.text:004597B7                 mov     [esp+3Ch+var_2C], 0FFFFFFFEh
.text:004597BF
.text:004597BF loc_4597BF:                             ; CODE XREF: JazzSaveFile+3B8j
.text:004597BF                 push    esi             ; hMem
.text:004597C0                 call    sub_49A800
.text:004597C5                 mov     eax, [esp+40h+var_2C]
.text:004597C9                 add     esp, 4
.text:004597CC                 pop     edi
.text:004597CD                 pop     esi
.text:004597CE                 pop     ebp
.text:004597CF                 pop     ebx
.text:004597D0                 add     esp, 2Ch
.text:004597D3                 retn
.text:004597D4 ; ---------------------------------------------------------------------------
.text:004597D4
.text:004597D4 loc_4597D4:                             ; CODE XREF: JazzSaveFile+65j
.text:004597D4                 pop     edi
.text:004597D5                 mov     [esp+38h+var_2C], 0FFFFFFFFh
.text:004597DD                 mov     eax, [esp+38h+var_2C]
.text:004597E1                 pop     esi
.text:004597E2                 pop     ebp
.text:004597E3                 pop     ebx
.text:004597E4                 add     esp, 2Ch
.text:004597E7                 retn
.text:004597E7 JazzSaveFile    endp
.text:004597E7
.text:004597E7 ; ---------------------------------------------------------------------------
.text:004597E8               