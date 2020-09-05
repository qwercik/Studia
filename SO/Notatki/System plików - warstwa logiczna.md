---
tags: [SO, SO wykład]
title: 3. System plików - warstwa logiczna
created: '2020-06-20T19:00:57.964Z'
modified: '2020-08-30T13:09:13.274Z'
---

# 3. System plików - warstwa logiczna
## Problematyka
W tej lekcji omówione zostanie pojęcie systemu plików, z perspektywy abstrakcyjnego obrazu informacji. Poznamy pojęcie pliku (i jego atrybuty), katalogu i ogólnie logiczną organizację plików.

## Plik

Trudno dokładnie zdefiniować pojęcie pliku, gdyż może być różnie rozumiane w zależności od punktu widzenia.
Plik to pewien abstrakcyjny, nazwany zbiór informacji, która jest przechowywana w systemie komputerowym. Jest to jednocześnie podstawowa jednostka logiczna magazynowania informacji.

Mówiąc bardziej intuicyjnie, to pewien ciąg danych, którego semantykę określa użytkownik.

System operacyjny ma na celu zapisać plik na dysku i móc go z niego odczytać. Dokładniej mówiąc, zadania systemu to:
  - identyfikacja pliku
  - udostępnienie interfejsu do operacji plikowych (API)
  - realizacja dostępu do plików, z uwzględnieniem bezpieczeństwa (synchronizacja, autoryzacja dostępu)

### Atrybuty pliku
Podstawowe atrybuty plików:
  - nazwa - podstawowy atrybut, który pozwala użytkownikowi zidentyfikować plik (SO ma wydajniejszy sposób, np. i-węzły w UNIXach)
  - typ - informacja o rodzaju przechowywanych danych
  - lokalizacja - informacja gdzie znajduje się plik (urządzenie i adres na tym urządzeniu)
  - rozmiar
  - ochrona - informacje o właścicielu, uprawnieniach itd.
  - czasy dostępów - czas utworzenia, ostatniej modyfikacji itd.

### Typ pliku
Typ pliku określa jakiego rodzaju dane są przechowywane (program binarny, plik z kodem języka C, biblioteka DLL itd.). Informacja o typie może być przechowywana w dedykowanym polu struktury definiującej plik, albo w samej nazwie pliku. System operacyjny może rozpoznawać typ, ale równie dobrze może pozostawiać użytkownikowi (lub programiście) pewną swobodę i nadawać dowolnym plikom dowolne typy.

System UNIX daje użytkownikowi zupełną dowolność w nadawaniu rozszerzeń, przy tym rozróżnia tylko kilka typów plików:
  - plik zwykły
  - katalog
  - dowiązanie symboliczne
  - urządzenie blokowe
  - urządzenie znakowe
  - łącze nazwane
  - gniazdo

Pliki z opcją wykonania powinny mieć odpowiednią strukturę np. (COFF lub ELF), aby proces mógł zostać uruchomiony.

### Struktura pliku
Mówiąc o strukturze pliku możemy mieć na myśli zarówno strukturę logiczną, jak i fizyczną. Logiczną jest ta abstrakcyjna, którą wyobraża sobie użytkownik. Jest to bowiem ciąg następujących po sobie bajtów o odpowiednich wartościach.

Istotna jest jednak również struktura fizyczna, która mówi o tym, w jaki sposób plik jest fizycznie przechowywany na urządzeniu (lub urządzeniach). Różne części pliku mogą być przechowywane na różnych częściach dysku. Ważne jednak, aby użytkownik "widział" plik jako całość. System operacyjny odwzorowuje jednostkę logiczną (np. rekord) na jednostkę fizyczną (np. sektor dysku). Ze strukturą fizyczną wiąże się pojęcie fragmentacji wewnętrznej (marnowane jest miejsce przydzielone tylko na jeden plik) oraz zewnętrznej (jeden plik jest rozrzucony po całym dysku).

### Metody dostępu do pliku
Metody dostępu określają sposób identyfikacji odczytywanego lub zapisywanego fragmentu pliku. Sposób dostępu może zależeć od systemu plików i od samego urządzenia.
Rodzaje:
  - dostęp sekwencyjny - informacje są przetwarzane rekord po rekordzie (można odczytać kolejny rekord, przesunąć wskaźnik pozycji na początek, albo o ileś jednostek do przodu lub do tyłu)
  - dostęp bezpośredni (swobodny) - lokalizacja rekordu jest podawana jako parametr operacji, możliwy jest dostęp do dowolnego miejsca (przydatne przy dużych zbiorach danych, np. w bazach danych)
  - dostęp indeksowy - rekord identyfikowany jest przez klucz, który jest odwzorowany na konkretny rekord w pliku stowarzyszonym przez plik indeksowy (stosuje się raczej w przypadku baz danych, niż bezpośrednio w systemie)

### Podstawowe operacje na plikach
Wyróżnia się następujące podstawowe operacje na plikach:
  - tworzenie pliku (trzeba określić jego podstawe atrybuty, znaleźć miejsce do zapisu i zarezerwować je, czyli zaewidencjonować)
  - zapis do pliku (trzeba określić co musimy zapisać i gdzie, w którym pliku i w jakiej jego części)
  - odczyt z pliku (trzeba powiedzieć ile danych, z jakiego pliku i z jakiego miejsca tego pliku)
  - usuwanie informacji z pliku (trzeba określić jaki fragment pliku chcemy usunąć; najczęściej można usunąć tylko końcówkę)
  - usuwanie pliku (trzeba powiedzieć jaki plik chcemy usunąć; usuwany jest wpis katalogowy)

Dodatkowo, w celu wykonywania powyższych operacji, można jeszcze wyróżnić następujące:
  - otwieranie pliku
  - zamykanie pliku
  - przesuwanie wskaźnika pozycji

Wprowadzenie operacji otwierania i zamykania pliku niweluje potrzebę ciągłego wyszukiwania przez system, gdzie zlokalizowany jest plik o podanej nazwie (co jest czasochłonne) - dzięki temu, jest on identyfikowany natychmiast poprzez specjalny uchwyt.

### Interfejs dostępu do pliku w systemie Unix
Wyróżnia się następujące funkcje:

| Nazwa funkcji | Parametry wejściowe                                   | Wartość zwracana                                             | Uwagi                                                        |
| ------------- | ----------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| creat         | ścieżka do pliku; prawa dostępu                       | deskryptor pliku; -1 w przypadku błędu                       | Tworzy plik i otwiera go do zapisu                           |
| unlink        | ścieżka do pliku                                      | zwraca 0; -1 w przypadku błędu                               | Usuwa dowiązanie do pliku - jeżeli było to ostatnie dowiązanie, to usuwa plik |
| read          | deskryptor; adres; rozmiar                            | liczba odczytanych bajtów; -1 w przypadku błędu              | Odczytuje bajty z pliku; stosowany jest dostęp sekwencyjny   |
| write         | deskryptor; adres; rozmiar                            | liczba zapisanych bajtów; -1 w przypadku błędu               | Zapisuje bajty do pliku; również stosowany jest dostęp sekwencyjny; możliwe jest dopisywanie bajtów na koniec w przypadku zastosowania flagi O_APPEND |
| truncate      | ścieżka do pliku (lub deskryptor); nowy rozmiar pliku | zwraca 0; -1 w przypadku błędu                               | Skraca plik do podanego rozmiaru (ucina końcówkę)            |
| open          | ścieżka do pliku; tryb otwarcia                       | zwara deskryptor; -1 w przypadku błędu                       | Otwiera plik w podanym trybie. Wersja trzyargumentowa umożliwia tworzenie pliku                           |
| close         | deskryptor                                            | zwraca 0; -1 w przypadku błędu                               | Zamyka otwarty wcześniej plik                                |
| lseek         | deskryptor; offset; punkt odniesienia                 | wynikowa pozycja w pliku, liczona w bajtach od jego początku; -1 w przypadku błędu | Pozwala zmienić wskaźnik pozycji w pliku, względem pewnego punktu odniesienia (początek pliku, obecna pozycja, lub koniec pliku). Może być stosowana tylko w przypadku zwykłych plików; w przypadku plików sekwencyjnych typu potoki czy kolejki FIFO nie ma zastosowania |


## Organizacja logiczna systemu plików
Dane możemy dzielić na partycje (inaczej: strefy/wolumeny/woluminy/tomy). Każda partycja obejmuje częśc dysku, albo cały dysk, albo nawet kilka dysków. Strefa taka zawiera pliki oraz katalogi. Strefa pełni rolę wirtualnego urządzenia (dysku).

Pliki na danej partycji organizowane są w katalogi. Katalog to tablica, która kojarzy nazwy plików z wpisami katalogowymi. Katalogi mogą być jednopoziomowe, albo wielopoziomowe. Katalogi wielopoziomowe można organizować w różne struktury logiczne (drzewo, graf acykliczny, albo w ogóle dowolny graf).

Informacje odpowiednie do identyfikacji hierarchii katalogów i lokalizacji bloków z zawartością plików nazywa się metadanymi. Ich inicjalizacja nazywana jest formatowaniem logicznym, albo tworzeniem systemu plików.

Operacje na katalogach:
  - tworzenie katalogu
  - usuwanie katalogu
  - tworzenie wpisu katalogowego (dodanie pliku do katalogu; plik może mieć kilka alternatywnych nazw, każda z nich posiada swój osobny wpis)
  - usuwanie wpisu katalogowego
  - przemianowanie pliku (zmiana nazwy)
  - odnajdywanie wpisu katalogowego
  - tworzenie wykazu wpisów katalogowych (listing zawartości)

Katalogi na ogół częściej się przeszukuje, niż modyfikuje.

Można wyróżnić następujące rodzaje struktury logicznej katalogów:
  - jednopoziomowa - wszystkie wpisy znajdują się w tym samym katalogu (na tym samym poziomie - poważne ograniczenie w systemach wielodostępnych)
  - dwupoziomowa - wpisy znajdują się w różnych katalogach, ale katalogi nie mogą zawierać już innych katalogów (zastosowano to np. w CP/M)
  - drzewiasta - w katalogach można tworzyć podkatalogi oraz pliki
  - graf acykliczny - podkatalog lub plik może być umieszczony w wielu katalogach (stosowane w systemach unixowych, ale nie można dowiązywać wielokrotnie do katalogów; dowiązania muszą być na tej samej partycji)
  - graf ogólny - dopuszcza się cykl w powiązaniach pomiędzy katalogami







