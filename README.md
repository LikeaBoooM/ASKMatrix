# Matrix Effect 
##### Assembler | Zaliczenie przedmiotu

##
##
##

> Animacja opiera się wygenerowaniu ranodmowych
> ciągów znaków, ułożenia ich w kolumnie, której 
> numer również został wylosowany.

## Wykorzystane operacje :
- MOV| Kopiowanie, przypisywanie
- JMP| CALL | modyfikuje wartość rejestru EIP
- JE | skok, jeśli równe
- JNE| skok, jeśli nie równe
- ADD| Dodawanie
- CMP| Porównywanie
- DIV | Dzielenie
- RET | Wracanie do wczesniejszej funkcji

### Funkcja rysująca : 
##
##
```sh
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
	MOV byte[collumn+bx],0	; Sprawdź granicę ekranu
```

#### Wygenerowany ciąg znaków zawiera :
##
- 2 białe znaki o kolorze ```0fh```
- 6 jasno zielone znaki o kolorze ```0ah``` 
- 12 ciemno zielonych znaków o kolorze ```02h```
- kolejno puste znaki aby zachować odstęp od kolejnego ciągu
#
#
## Funkcja losująca znak w systemie ASCII od 33 do 126 :
##
http://stackoverflow.com/questions/17855817/generating-a-random-number-within-range-of-0-9-in-x86-8086-assembly
```sh
 RAND:  
	MOV   ax, word[seed]
	ADD   word[seed],13
	XOR   dx, dx
	MOV   cx, 94  
	DIV   cx    ; DX przetrzymuje wartość z wylosowanym znakiem
	ADD   dl, 33  
	MOV   AX,DX
	MOV   word[seed],ax ;randomowy znak w systemie ASCII od 33 do 126
	RET  		
```
Wszystkie inne funkcje zostały oparte na tej samej metodzie.

## Funkcja delay 
W pierwszym namyśle, została stworzona funkcja delay, która opóźniała
działanie programu, czego skutkiem był powolne generowanie każdego znaku.
Ostatecznie zostało to zakomentwane, ponieważ efekt był inny niż
zamierzony.


##

### Efekt końcowy

Można zauważyć, że słowa w kodzie ułożone są na odwrót, niż są wyświetlane w konsoli.
Powód jest taki, że na stos wędruje wyszstko od drugiej strony. Przykładowo, pierwsze
dwa białe znaki znajdą się na samym dole ciągu znaków, które są wyświetlane


