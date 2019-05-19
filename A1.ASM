; inicjalizacja zmiennych
SECTION .data
	time db 00b ; szybkosc
	collumn db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	seed dw 0 ; inicjalizacja word[seed] 
	temp dw 0 
 
SECTION .text
org     0100h  
  
MOV ah, 00h  ; okienko :  80x25
MOV al, 03h
INT 10h

MOV ch, 32   ; Ukrywanie kursora
MOV ah, 1       
INT 10h 
	
CALL rand_init	; Wylosowanie randomowej liczby
JMP loopR ; Skok do pętli 

; funkcja losująca randomową liczbę z przedziału 
;ref http://stackoverflow.com/questions/17855817/generating-a-random-number-within-range-of-0-9-in-x86-8086-assembly


rand_init: 

	MOV 	ah,00h 	; Pobierz czas systemowy
	INT 	1ah 	; CX:DX przechowuje czas
	MOV		word[seed],dx 
	;PUSH 	dx 
	;POP 	word[seed]    ;Move word[seed] to dx
	RET

	
		
;funkcja losująca randomowy znak w systemie ASCII od 33 do 126
 RAND:   ; funkcja wykorzystuje word[seed] z powyższej funkcji 
	MOV   ax, word[seed]
	ADD   word[seed],13
	XOR   dx, dx 	; Przenieś DX na 0 
	MOV   cx, 94  
	DIV   cx    ; DX przetrzymuje wartość z wylosowanym znakiem
	ADD   dl, 33  
	MOV   AX,DX
	MOV   word[seed],ax ;randomowy znak w systemie ASCII od 33 do 126
	RET  		

	
;  funkcja losująca ilość kolumn od 0 do 79 
randcol:  			; Randomowa kolumna z wykorzystaniem word[seed]
	MOV   ax, word[seed]
	ADD   word[seed],23
	XOR   dx, dx ;DX na 0
	MOV   cx, 80
	DIV   cx      	; dx zawiera pozostałą część podziału od 0 do 79
	MOV BX,DX
	RET  		; randomowy numer w AL


; funkcja czasu która przetrzymuje wartości w DL
timer:
	MOV  ah, 2Ch 	 ; Czas
	INT  21h  		 ; Zapisane w DL
	MOV  bh,dl
	MOV  bl,time


timer2:
	MOV  ah,2Ch	 ; Czas
	INT 21h
	CMP dl,bh		 ; Sprawdz timer
	JE timer2
	DEC bl
	MOV bh,dl
	CMP bl,0
	JNE timer2		 ; Dla czasu róznego od zera
	RET


printc: 			; Wypisywanie znaków
	MOV  ah, 09h	
	MOV  bh, 00h
	MOV  cx, 1
	INT  10h		;Wyświetlanie znaków
	RET


; ustaw pozycje
setpos:
	MOV bx,word[temp]
	MOV dx,word[temp]
	MOV dh, byte[collumn+bx]	; bx adres kolumny	
	DEC byte[collumn+bx]
	MOV bh,0
	MOV ah,02h
	INT 10h  		
		RET


printword:			 	; Funkcja rysująca
; bx = adres kolumny
; bl = kolor kodu
	CALL setpos
	CALL RAND
	MOV     bl, 0fh  	; Biały
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 0fh
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 0ah  	; Jasny zielony
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 0ah
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 0ah
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 0ah
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 0ah
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 0ah
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 02h  	; Ciemny zielony
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 02h
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 02h
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 02h
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 02h
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 02h
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 02h
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 02h
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 02h
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 02h
	CALL printc
	CALL setpos
	CALL RAND
	MOV     bl, 02h
	CALL printc
	MOV  al,' '  		; Delete last char
	MOV  	bl, 00h
	CALL printc
	MOV bx,word[temp]
	ADD byte[collumn+bx],20	; 20 | Spacja w kodzie ASCII
	CMP byte[collumn+bx],50
	JNE printword2
	MOV byte[collumn+bx],0	; Sprawdź granicę ekranu
	
 printword2:
		RET

startcol:   			; wybierz randomową kolumnę
	CALL randcol
	CMP byte[collumn+bx],0 	; sprawdz wiersz
	JNE startcol
	INC byte[collumn+bx]
		@C: RET
		@A: INC bx		


checkAndPrint:    	;sprawdz linie i wypisz wszystko
CMP bx,80
	JE @B
	CMP byte[collumn+bx],0
	JE @A
	MOV word[temp],bx
	CALL printword
	MOV bx,word[temp]
	JMP @A
	@B: RET


loopR:
CALL startcol
XOR bx,bx
CALL checkAndPrint
;CALL  	timer  			;opóźnienie
MOV ah, 0Bh         ;Press any key to exit
INT 21h
CMP al, 00h
JE loopR			; Wykonuj loopa dopóki nie nie wcisne

;funkcja która zakańcza funkcje main
terminate:
	MOV ax, 4c00h	
	INT 21h
    	RET ;koniec main

