---
tags: [SO wykład]
title: 5. System plików - przykłady implementacji
created: '2020-08-31T17:47:49.700Z'
modified: '2020-09-02T13:47:53.423Z'
---

# 5. System plików - przykłady implementacji
W tym wykładzie omówione zostaną pewne popularne systemy plików.

## CP/M
Na jednej partycji znajduje się jeden katalog. Katalog zawiera wpisy katalogowe (FCB), które identyfikują poszczególne pliki. Każdy taki wpis jest 32-bajtowy. Zawiera następujące pola:
  - właściciel (1 bajt)
  - nazwa pliku (8 bajtów)
  - typ pliku (3 bajty)
  - extent (1 bajt) - używane przy numeracji segmentów pliku, jeśli ten jest zbyt duży, by mógł zostać opisany przez jeden blok katalogowy
  - rozmiar pliku wyrażony w 128-bajtowych sektorach (jeżeli plik nie wypełnia ostatniego sektora w całości, stosuje się specjalny bajt aby to zaznaczyć)
  - numery bloków - jest ich szesnaście, każdy jednobajtowy - wskazują one numery bloków danych w których znajdują się kolejne fragmenty pliku

Dane znajdują się w 128 bajtowych sektorach, ale alokacji podlegają bloki o rozmiarach 1 KiB.

System plików był projektowany na potrzeby obsługi dyskietek o rozmiarze 180 KiB.

Do zarządzania wolną przestrzenią używany jest 23-bajtowy wektor bitowy.

## DOS
Na jednej partycji może znajdować się wiele katalogów (ich liczba jest precyzowana podczas formatowania), dodatkowo katalogi można w sobie zagnieżdżać.
Każdy wpis katalogowy jest opisywany przez 32 bajtową strukturę, która posiada nazwę (8 bajtów), typ (3 bajty), atrybuty (1 bajt) i tak dalej. Jeden z atrybutów określa, czy dany wpis dotyczy zwykłego pliku czy podkatalogu. FAT-32 wykorzystuje pola, nieużywane przez FAT-16 i FAT-12. Istotnym elementem jest indeks pierwszego bloku.

Podkatalogi są również plikami, wewnątrz których znajdują się 32 bajtowe rekordy, podobnie jak opisano wyżej.

Spis powiązań pomiędzy blokami znajduje się w tablicy FAT (File Allocation Table) - z reguły są dwie (jedna zapasowa), choć można to określić podczas formatowania. Znajdują się tam informacje o powiązaniach, końcu pliku, wolnym bloku albo uszkodzonym.

Wielkość jednostki alokacji musi być wielokrotnością sektora (512B).

Schemat partycji:
  1. blok nadrzędny
  2. tablice FATu
  3. katalog główny
  4. bloki z danymi i podkatalogami

## ISO 9660 (CD-ROM)
Dane na płycie CD nie są rozkładane w cylindrach, ale tworzą układ spiralny. Spirala taka jest dzielona na sektory o rozmiarze 2352 bajtów (w tym preambuły, kody korekcyjne itd.), a na same dane pozostaje 2048B. Liczby reprezentowane są na dwa sposoby: little i big endian. Maksymalny poziom zagnieżdżenia katalogów to 8.

Pliki organizowane są wg zasady przydziału ciągłego (płyty CD się nie modyfikuje), wpis katalogowy zawiera indeks pierwszej jednostki alokacji, a wpisy katalogowe są posortowane alfabetycznie. Rozmiar bloku określony jest w deskryptorze, zazwyczaj jest to 2048B, ale może być więcej, np. 4096 albo 8192). Wpisy katalogowe mają pola określające długość, co umożliwia rozszerzanie możliwości standardu. Wpis może mieć flagi:
  - bit odróżniający katalog od pliku
  - bit ukrycia wpisu na listingu zawartości
  - bit atrybutów rozszerzonych
  - bit oznaczający ostatni wpis w katalogu

Standard posiada rozszerzenia: *Rock Ridge*, *Joliet*.

Pierwsze 16 bloków jest do dyspozycji programisty - może tam być na przykład program rozruchowy, ładujący system z płyty, a mogą być metadane odnośnie autora płyty, wytwórcy, praw autorskich.


## UNIX
Z każdym plikiem związany jest i-węzeł, który przechowuje wszystkie atrybuty pliku, z wyjątkiem nazwy. Nazwa jest powiązana z numerem i-węzła we wpisach katalogowych. Katalogi mogą tworzyć wielopoziomową strukturę.
Dane znajdują się w blokach (jednostkach alokacji) o ustalonym rozmiarze, które są identyfikowane przy pomocy indeksu kombinowanego. Wolne bloki są zorganizowane w postaci grupowania. W pewnych odmianach stosuje się również wektor bitowy.

Struktura partycji wygląda tak, że składa się ona z bloku nadrzędnego, tablicy i-węzłów oraz bloku danych. Partycja może jednak, celem zwiększenia efektywności i niezawodności, zostać podzielona na kilka tego typu sekcji. I-węzły tworzą tablicę, której rozmiar limituje liczbę plików w systemie. Pierwszy węzeł (blok) z indeksami wolnych bloków jest zlokalizowany w całości w bloku nadrzędnym.

Każdy i-węzeł zawiera następujące atrybuty:
  - identyfikatory użytkownika i grupy
  - typ pliku
  - uprawnienia
  - czasy dostępu (czas modyfikacji pliku, czas modyfikacji i-węzła, czas dostępu)
  - licznik dowiązań
  - rozmiar w bajtach
  - indeksy bloków z danymi - część (10-12) wskazuje bezpośrednio na bloki z danymi, i po jednym na blok indeksowy 1-, 2- i 3-poziomowy

Struktura pliku katalogowego:
  - numer i-węzła (2 bajty)
  - nazwa pliku (14 bajtów) - obecnie dopuszcza się nawet 256 znaków

Istnieją dwa wpisy specjalne w każdym katalogu (poza głównym): `.` oraz `..`.

System kopiuje tablicę i-węzłów z partycji dyskowej w czasie, gdy jest ona zamontowana i tworzy pewną ilość dodatkowych atrybutów, np. licznik otwarć. Otwarcie oznacza, że dane należy prztransferować z partycji dyskowej do jądra  i utworzyć wpis w tablicy otwartych plików jądra. Jeżeli plik otwiera proces, to w jego deskryptorze pojawia się informacja o otwarciu pliku, która wskazuje na tablicę otwartych plików jądra. Deskryptor otwartego pliku jest indeksem w tablicy otwartych plików.

## NTFS
Plik jest zbiorem atrybutów (posiada również atrybut dane). Każdy plik ma swój wpis w MFT (Master File Table), indeks w tej tablicy jest składnikiem referencji. Tablica MFT jest również plikiem, jak każdy inny obiekt w obrębie systemu plików. Wolne bloki identyfikowane są poprzez wektor bitowy, również przechowywany w jednym z plików.

Partycja ma następujący format:
  - blok nadrzędny
  - MFT
  - strefa MFT
  - bloki danych
  - kopia pierwszych 16 rekordów MFT
  - bloki danych

Tablica MFT ma ustalone położenie na partycji, ale ponieważ sama jest plikiem, może być powiększana w ramach strefy MFT (może ona być również wykorzystywana dla bloków danych, ale dopiero wtedy, gdy na właściwym obszarze danych zabraknie miejsca). Dla bezpieczeństwa 16 pierwszych rekordów MFT, zawierających ważne dla systemu pliki, jest kopiowane do środkowej części partycji.

Przestrzeń dyskowa jest podzielona na bloki (jednostki alokacji, klastry, grupy) o rozmiarze z zakresu 512B - 64KiB (typowa wartość to 4KiB). Każdy blok jest identyfikowany przez pewien numer LCN, związany z fizyczną lokalizacją bloku.

Każdy rekord MFT ma ustalony rozmiar (1-4 KiB, ustalane na etapie formatowania), składa się z nagłówka i tabeli atrybutów. Każdy atrybut ma swój nagłówek (typ, nazwę, długość wartośći w bajtach, lokalizację wartości, flagi) oraz wartość. Wartość może znajdować się bezpośrednio w tabeli (atrybut rezydentny), albo w bloku danych. Nagłówek rekordu zawiera:
  - magiczną liczbę (do sprawdzania poprawności)
  - numer sekwencyjny (zwiększane o 1 za każdym razem, gdy rekord jest używany dla nowego pliku)
  - liczba odniesień do pliku
  - liczba wykorzystywanych bajtów przez rekord
  - identyfikator rekordu bazowego (referencja) w przypadku rekordu rozszerzeń

Wybrane atrybuty:
  - informacje standardowe ($STANDARD_INFORMATION) - obligatoryjny, przechowuje informacje o właścicielu, flagi, czasy, licznik dowiązań itd. jest rezydentny
  - nazwa pliku ($FILE_NAME) - przechowywana w UTF-16, może wystąpić kilka takich atrybutów w rekordzie. Jest rezydentny
  - dane ($DATA) - istnieje jakiś anonimowy, ale można utworzyć dodatkowy; katalogi nie posiadają
  - korzeń indeksu ($INDEX_ROOT) - wykorzystywane przez katalogi
  - alokacja indeksu ($INDEX_ALLOCATION) - wykorzystywane przez katalogi
  - mapa bitowa indeksu ($BITMAP) - wykorzystywane przez katalogi
  - lista atrybutów ($ATTRIBUTE_LIST) - zawiera listę atrybutów i ich lokalizację w rekordach rozszerzeń, jeżeli nie zmieszczą się w jednym rekordzie

Każdy rekord w MFT jest identyfikowany poprzez referencję. Górne 16 bitów to numer sekwencyjny, a dolne 48 to numer rekordu w tablicy MFT.

Jeżeli lista atrybutów pliku nie mieści się w jednym rekordzie, do pliku przydzielane są dodatkowe rekordy. Pierwszy rekord jest nazywany bazowym/podstawowym, a kolejne to rekordy rozszerzeń.

Bloki z danymi są opisywane przez listę przebiegów. Odwzorowują one VCN na LCN. Nagłówek takiej tabeli zawiera zakres numerów VCN objętych opisem w tabeli, a poszczególne pozycje zawierają opisy tzw przebiegów. Przebieg jest ciągiem kolejnych bloków wg numeracji LCN. Przykład: strumień danych pliku umieszczony jest w 30 blokach, porozkładanych w 3 przebiegach różnej wielkości. Pierwszy przebieg obejmuje 8 bloków zlokalizowanych pod numerami LCN 1500-1507, drugi 10 bloków o numerach 1700-1809, a trzeci 12 bloków o numerach 20000-2011. Numery VNC dla takiego pliku są z zakresu 0-29 i taka informacja znajdzie się w nagłówku tabeli. Pozycje z tej tabeli zawierają zatem: [(1500, 8), (1800, 10), (2000, 12)]

Katalogi zawierają sekwencje wpisów (rekordów), z których każdy odpowiada jednemu plikowi i obejmuje jego następujące atrybuty:
  - referencja
  - nazwa (wraz z długością)
  - rozmiar
  - czasy dostępów

Atrybuty pliku są kopiowane z tablicy MFT, celem przyspieszenia sporządzenia listingu. Implementacja małych katalogów jest listą, a dużych - strukturą indeksową (B+-drzewo).

Wybrane pliki metadanych:
  - $MFT - główna tablica plików
  - $MFTMIRR - kopia MFT
  - $LOGFILE - rejestr modyfikacji metadanych
  - $VOLUME - ogólne informacje o wolumenie (rozmiar, etykieta, wersja systemu plików)
  - $DEFATTR - zawiera definicję typów atrybutów, możliwych do stosowania w systemie plików
  - $ - opis korzenia drzewa katalogów
  - $BITMAP - mapa bitowa z informacją o wolnych i zajętych blokach dyskowych

Plik identyfikowany jest przez referencję, która jest indeksem rekordu w tablicy MFT, rekord zawiera atrybuty pliku (w szczególności dane) lub odnośniki do bloków z atrybutami
