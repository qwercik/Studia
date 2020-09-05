---
tags: [SO wykład]
title: 4. System plików - warstwa fizyczna
created: '2020-08-30T14:09:16.547Z'
modified: '2020-09-02T13:47:47.511Z'
---

# 4. System plików - warstwa fizyczna

## Problematyka
w tej lekcji omówione zostaną aspekty implementacji systemu plików z fizycznego punktu widzenia.
Obsługa plików na poziomie sprzętowym wiąże się z wieloma problemami, aby informacje były zapisywane i pozyskiwane możliwie wydajnie, nie marnowało się miejsce, a wymiana danych pomiędzy komputerem a dyskiem była bezpieczna i zapewniała spójność i niezmienność danych.

Najważniejszą kwestią, poruszaną na tym wykładzie, jest organizacja przestrzeni na dysku, która obejmuje powiązanie pliku z pewną przestrzenią na dysku oraz zarządzanie blokami wolnymi. Istotna jest również implementacja katalogu, sposób realizacji operacji plikowych oraz zapewnienie możliwości współbieżnego dostępu do pliku.

## Organizacja fizyczna systemu plików

Dane na dysku są przechowywane w blokach, zwanych jednostkami alokacji lub klastrami i będących wielokrotnością sektorów dysku (512B).

### Przydział miejsca na dysku
Wyróżniamy następujące metody przydziału miejsca na dysku:
  - przydział ciągły - cały plik zajmuje ciąg kolejnych bajtów, jest identyfikowany wyłącznie przez adres początkowego bloku oraz rozmiar; plik jest umieszczony na dysku w zwartej postaci, nie jest rozrzucony we fragmentach - wpływa to pozytywnie na efektywność dostępu (nie trzeba skakać po całym dysku), bezpieczeństwo przechowywanych informacji, jednocześnie jednak powoduje problemy rozlokowywaniem kolejnych plików i sporą fragmentacją (tracimy miejsce, które moglibyśmy wykorzystać); dodatkowo, pliku często nie da się rozszerzyć, trzeba go wtedy przekopiować (znaleźć większą dziurę), albo z góry rezerwować nieco większą przestrzeń dla pliku - co jednak wiąże się z pewną stratą miejsca
  Podejście to można zastosować w systemach, w których dane się raczej odczytuje, a zapisywanie jest bardzo rzadkie lub nie występuje. W innym przypadku nie ma to sensu

  - przydział listowy - bloki pliku tworzą listę powiązaną, każdy z bloków wskazuje na lokalizację następnego bloku, albo zawiera informację, że jest ostatnim blokiem pliku; takie rozwiązanie likwiduje problem fragmentacji zewnętrznej i pozwala na prostą realizację dostępu sekwencyjnego; trudniej jest z dostępem dowolnym, do tego pojawia się problem zawodności - utrata jednego bloku powoduje utratę wszystkich danych
  Pewną odmianą jest FAT, czyli tablica alokacji plików. Listy powiązań są oddzielne od bloków z danymi. Dzięki temu można wczytać większy fragment łańcucha powiązań do pamięci w jednej operacji dostępu

  - przydział indeksowy - pliki z danymi wskazywane są przez pliki indeksowe, które mogą być zorganizowane w schemat listowy, wielopoziomowy, bądź kombinowany.
  W przypadku użyciu schematu listowego, w ostatnim elemencie bloku (pliku) indeksowego znajduje się wskaźnik do następnego bloku indeksowego tego pliku (jeżeli potrzebny, bo plik może być odpowiednio mały)
  W przypadku użycia schematu wielopoziomowego - blok indeksowy pierwszego poziomu zawiera wskaźnik do bloków drugiego poziomu
  W przypadku użyciu schematu kombinowanego można łączyć kilka drzew o różnych głębokościach
  Zaletą jest stosunkowo szybka lokalizacja dowolnego bloku pliku, łatwa realizacja dostępu bezpośredniego, brak problemu z fragmentacją zewnętrzną. Wadą jest konieczność przeznaczania pewnej przestrzeni dyskowej na bloki indeksowe oraz zawodność, gdyż utrata któregoś z bloku indeksowych grozi utratą części lub całości pliku.

### Zarządzanie wolną przestrzenią
Istnieją różne sposoby zarządzania wolną przestrzenią na dysku:
  - wektor bitowy - każdy bit odpowiada jednemu blokowi, jeżeli blok jest wolny to bit ma wartość 1
  - lista powiązana - każdy wolny blok zawiera indeks następnego bloku
  - grupowanie - niektóre wolne bloki są zapełnione w całości indeksami innych wolnych bloków; ostatni indeks wskazuje na kolejny blok zapełniony w całości indeksami
  - zliczanie - wykaz wolnych bloków obejmuje indeks pierwszego bloku oraz liczbę wolnych bloków zajmujących się za nim, stanawiących ciągły obszar

### Implementacja katalogu
Katalog to ciąg wpisów, które obejmują nazwę pliku i jego atrybuty. Znalezienie pliku w katalogu wiąże się z przeszukaniem liniowym - można to przyspieszyć utrzymując dane posortowane, ale jest to kosztowne. Można też użyć hashmapy, co wiąże się jednak z bardziej złożoną strukturą, gdyż mogą wystąpić pewne konflikty i należy je usunąć. Jeszcze innym pomysłem jest użycie struktury drzewiastej.

## Buforowanie
Aby zwiększyć wydajność operacji dyskowych i nie musieć wielokrotnie sprowadzać z dysku tych samych danych stosuje się bufory, zawierające ostatnio używane bloki dyskowe. Należy uważać na spójność danych, żeby nie okazało się że utracimy dane zapisane w buforze, a niezapisane jeszcze na dysku twardym.

Zapis danych do bufora odbywa się następująco: szukamy adresu bloku z danymi, kopiujemy go do bufora, a następnie kopiujemy z bufora do przestrzeni adresowej procesu, ilekroć jest to potrzebne.

Podczas odwrotnej operacji najpierw nadpisujemy bufor, a potem (natychmiast, lub z opóźnieniem) kopiujemy go na dysk. W skutek awarii pamięć podręczna może zostać zapisana na dysku tylko częściowo i pozostawić system plików w stanie niespójnym

Przejawy braku integralności:
  - brak bloku w wykazie bloków zaalokowanych i wolnych
  - obecność bloku w wykazie bloków zaalokowanych i wolnych
  - wielokrotne powtórzenie się bloku w wykazie bloków wolnych (duplikacja wolnego bloku)
  - wielokrotne powtórzenie się bloku w wykazie bloków zaalokowanych (duplikacja zaalokowanego bloku)
  - niespójność informacji we wpisach katalogowych (np. niespójność licznika dowiązań w systemie UNIX)

## Obsługa plików przez procesy współbieżne
Semantyka spójności określa w jaki sposób zmiany przeprowadzone w jednym procesie wpływają na obraz pliku w innych procesach.
  - semantyka UNIX - wszelkie zmiany są natychmiastowo dostępne, niezależnie od procesu
  - semantyka sesji - zmiany są wprowadzane po zamknięciu sesji (która jest otwierana w momencie otwarcia pliku). Aby inny proces miał dostęp do zmian, musi otworzyć plik dopiero po tym, gdy inny proces swój plik zamknie
  - semantyka stałych plików dzielonych - plik może być tylko czytany, to raczej obejście problemu, niż jego rozwiązanie

Do synchronizacji stosuje się blokady. Blokować można cały plik, lub jego fragmenty. Wyróżniamy:
  - blokadę współdzieloną - zakładana na czas odczytu i dopuszcza inne blokady
  - blokadę wyłączną - zakładana na czas modyfikacji i nie dopuszcza żadnych innych blokad
