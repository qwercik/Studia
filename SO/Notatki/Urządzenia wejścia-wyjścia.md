---
tags: [SO, SO wykład]
title: 6. Urządzenia wejścia-wyjścia
created: '2020-06-18T16:19:12.703Z'
modified: '2020-09-02T13:47:59.016Z'
---

# 6. Urządzenia wejścia-wyjścia

## Problematyka
Urządzenia wejścia-wyjścia są bardzo zróżnicowane i często się zmieniają. Z drugiej strony stanowią "zmysły" komputera i muszą być obsługiwane możliwie efektywnie.

## Klasyfikacja
Urządzenia wejścia-wyjścia są często bardzo różne. Możemy je podzielić na przykład tak:
  - urządzenia do składowania danych (dyski, napędy optyczne, taśmy, dyskietki) - są sterowane tylko przez zdarzenia wewnętrzne, czyli sygnały z jednostki centralnej
  - urządzenia do transmisji danych na odległość (karty sieciowe, modemy) - sterowane są przez zdarzenia wewnętrzne, ale różnież zdarzenia zewnętrzne (przekazanie danych od innego komputera)
  - urządzenia do komunikacji z człowiekiem (monitory, projektory, skanery, klawiatury, myszy) - również reagują zarówno na zdarzenia wewnętrzne i zewnętrzne

Klasyfikację można prowadzić również na inne sposoby. Poszczególne urządzenia mogę różnić się na przykład **trybem transmisji danych**. Wyróżnia się następujące tryby:
  - znakowy - przekazywanie danych odbywa się bajt po bajcie (np. port szeregowy)
  - blokowy - dane przekazuje się w większych porcjach, zwanych blokami (np. dysk twardy)

Urządzenia różnią się również **dostępem do danych**:
  - sekwencyjny - dane przekazywane są w postaci strumienia, czyli po kolei (np. napęd taśmowy, karta sieciowa)
  - swobodny (bezpośredni) - jednostka centralna ma w każdej chwili dostęp do dowolnego fragmentu danych (np. dysk twardy, pamięć operacyjna)

Urządzenia mogą różnić się **trybem pracy**:
  - synchroniczny - dane przekazywane są regularnie, w sposób zsynchronizowany; jednostka centralna wie, kiedy się ich spodziewać (np. dysk twardy, karta graficzna)
  - asynchroniczny - dane mogą być przekazywane w sposób mało przewidywalny, np. urządzenia są obsługiwane przez człowieka (klawiatura, karta sieciowa)

Urządzenia mogą się różnić też **trybem użytkowania**:
  - współdzielony - urządzenie może być w jednej chwili używane przez wiele różnych procesów (np. dysk)
  - wyłączny - w danej chwili może być użytkowane tylko przez jeden proces (np. drukarka)

Urządzenia różnią się **szybkością działania**:
  - bardzo wolne (np. drukarka, skaner)
  - stosunkowo szybkie (np. dysk twardy)

Urządzenia różnią się **kierunkiem przekazywania danych**:
  - urządzenia wejścia i wyjścia - możemy zarówno zapisywać, jak i odczytywać z nich informacje (np. dysk albo karta sieciowa)
  - urządzenia wejścia - możemy tylko odczytywać informacje (np. klawiatura, mysz)
  - urządzenia wyjścia - możemy tylko zapisywać informacje (np. monitor, drukarka)

## Struktura mechanizmu wejścia-wyjścia
Zadaniem systemu operacyjnego jest ujednolicenie interfejsu, wprowadzenie pewnej warstwy abstrakcji, umożliwiającej wygodne korzystanie z urządzeń peryferyjnych i ukrycie sprzętowej realizacji urządzenia.

Szczegółami działania poszczególnych urządzeń nie zajmuje się procesor jednostki centralnej, lecz każde takie urządzenie posiada swój własny sterownik, regulujący jego pracę. Procesor główny *dogaduje się* ze sterownikiem poprzez zapisywanie odpowiednich rejestrów sterownika.

Sterownik może być umieszczony na płycie głównej (np. dawniej - zintegrowana karta graficzna), albo na płytce samego urządzenia (dysk, drukarka). Sterownik na płycie głównej, albo część sterownika urządzenia, która zajmuje się komunikacją z jednostką centralną, nazywany jest **adapterem**.

Może się zdarzyć, że sterownik nie jest zintegrowany z adapterem, a komunikacja odbywa się poprzez np. port USB. W takim przypadku CPU komunikuje się ze sterownikiem portu i jego rejestrami.

## Oprogramowanie obsługi wejścia-wyjścia
Na poziomie oprogramowania, obsługę wejścia-wyjścia możemy dość wyraźnie podzielić na dwie części.

Pierwszą z nich jest **podsystem wejścia-wyjścia**, który dostarcza pewien abstrakcyjny interfejs (API), który umożliwia wykonywanie operacji wejścia-wyjścia na różnych urządzeniach, niezależnie od ich konkretnej sprzętowej realizacji. Typowy interfejs obejmuje na przykład funkcje *read* i *write*.

Właściwą obsługą urządzeń konkretnego typu zajmuje się **moduł sterujący** (zwany potocznie sterownikiem). Przy dołączaniu dodatkowych urządzeń do komputera, trzeba dołączyć odpowiedni moduł sterujący. System operacyjny powinien radzić sobie z obsługą nowych modułów sterujących. Może to zrobić na kilka sposobów: wymagać rekompilacji jądra, ładować nowe sterowniki przy uruchomieniu systemu albo ładować je *w locie*, podczas jego pracy.

## Sterownik urządzenia (w znaczeniu hardware)
Procesor jednostki centralnej może komunikować się ze sterownikiem poprzez zestaw rejestrów (ma bezpośredni dostęp do rejestrów wszystkich sterowników, podłączonych do magistrali systemowej). Część z nich jest przeznaczona do odczytu, a część do zapisu. Wyróżniamy następujące rodzaje rejestrów:
  - rejestr stanu (*status register*) - jest czytany przez procesor:
    - bit gotowości - sygnalizuje, że ma gotowe dane dla procesora,
    - bit zajętości - sygnalizuje, że jeszcze pracuje (nie jest gotowy na nowe zlecenie, ani na przekazanie danych dla procesora)
    - bity kodu błędu - jeżeli coś pójdzie nie tak, można w ten sposób przekazać dokładne informacje o błędzie
  - rejestr sterowania (*control register*) - zawiera bity, które definiują tryb pracy urządzenia - są one najczęściej zapisywane przez procesor
  - rejestr danych wejściowych (*data-in register*) - jest czytany przez procesor w celu odbioru danych wejściowych
  - rejestr danych wyjściowych (*data-out register*) - jest czytany przez urządzenie

Procesor może komunikować się ze sterownikiem poprzez:
  - odizolowane wejście-wyjście (przestrzeń adresowa wejścia-wyjścia) - w architekturze x86 stosuje się instrukcje *in* oraz *out*
  - odwzorowanie w przestrzeni adresowej pamięci (np. karta graficzna i adres 0xB8000 do trybu tekstowego ;))

## Interakcja jednostki centralnej ze sterownikiem urządzenia I/O
Wyróżnia się trzy zasadnicze metody komunikacji CPU ze sterownikiem urządzenia I/O:
  - odpytywanie (*polling*) - procesor co jakiś czas *pyta* urządzenie, czy już skończyło swoją pracę i prosi o transfer danych
  - sterowanie przerwaniami (*interrupt-driven I/O*) - procesor podczas inicjalizacji pracy sterownika, prosi go o wykonanie przerwania w momencie zakończenia pracy. Obsługa informacji od urządzenia I/O odbywa się w momencie obsługi przerwania.
  - bezpośredni dostęp do pamięci (*DMA - direct memory access*) - procesor inicjalizuje specjalny układ *DMA*, który automatycznie zapisze otrzymane informacje pod wskazany adres i nie będzie angażował w tym celu procesora

### Odpytywanie - szczegóły realizacji
Procesor czeka, aż urządzenie będzie dostępne. Kiedy będzie, zapisuje rejestr z danymi wejściowymi i zleca zapis. Sterownik w tym momencie rozpoczyna odczyt danych wejściowych i wykonuje operację na urządzeniu I/O.

Gdy operacja zakończy się, bity gotowości i zajętości są odpowiednio ustawiane (w zależności od tego, czy się powiodła, czy nie). W tym czasie komputer co dany interwał czasu sprawdza, czy bit gotowości nie jest przypadkiem równy 1. W momencie gdy jest, zeruje go na przyszłość.

W przypadku operacji odczytu jest bardzo podobnie, z tym że procesor nie zapisuje danych przed zleceniem odczytu. Za to odczytuje dane w momencie, gdy urządzenie I/O zakończy swoją pracę.

### Sterowanie przerwaniami - szczegóły realizacji
Procesor zleca wykonanie zadania. W momencie gdy zostanie ono wykonane, sterownik urządzenia I/O zgłasza przerwanie (poprzez kontroler przerwań).

Kontroler przerwań posiada kilka linii na wejściu i jedną na wyjściu, podpiętą do procesora. Linie wejściowe pozwalają rozróżniać przerwania.

Procesor może przetworzyć otrzymane dane już na etapie obsługi przerwania, albo zrobić to po czasie (dodać odpowiednie zadanie do kolejki).

Na czas wykonywania operacji wejścia-wyjścia, proces jest zablokowany (uśpiony, w oczekiwaniu na I/O).

Może się zdarzyć, że w momencie zlecenia zadania, urządzenie I/O nie jest dostępne. Wtedy zlecenie należy umieścić do pewnej kolejki, z której zostanie pobrane, jeżeli urządzenie się zwolni.

Proces zlecania operacji jest określany w module sterującym jako **górna połowa**. Proces obsługi przerwania określonego urządzenia jest określany jako **dolna połowa**.

Obsługa tej dolnej połowy polega na odczytaniu odpowiednich informacji z tablicy urządzeń, sprawdzenia stanu sterownika i przekazaniu informacji do procesu zlecającego. Jeżeli w kolejce urządzenia pozostają nadal jakieś akcje do wykonania, z kolejki pobierane jest nowe i ponownie zleca się operację I/O.

Procedurę obsługi przerwań należy wykonać szybko (by nie blokować innych przerwań), dlatego część operacji (przetwarzanie otrzymanych danych) można odroczyć. System Linux inaczej interpretuje terminy górna i dolna połowa: górną połową są czynności wykonywane bezpośrednio podczas obsługi przerwania, a dolną połową są czynności odroczone.

#### Obsługa przerwań wielokrotnych
Procesor często musi obsługiwać wiele urządzeń, które mogą zgłaszać różne przerwania. Ich obsługa jest kwestią stosunkowo istotną, ponieważ może zdarzyć się sytuacja, że podczas obsługi jednego przerwania pojawią się kolejne. Na przykład w czasie drukowania dokumentu, do karty sieciowej mogą przyjść kolejne pakiety. Istnieje kilka sposobów radzenia sobie z tym problemem:
  - obsługa sekwencyjna - kolejne przerwania obsługujemy dopiero, gdy skończymy obsługiwać obecne
  - obsługa zagnieżdżona - w przypadku pojawienia się nowego przerwania, to je obsługujemy, pozostawiając nieobsłużone to aktualnie obsługiwane
  - obsługa priorytetowa - wykonujemy przerwanie w danej chwili najbardziej istotne

#### Problemy współbieżnej obsługi wielu urządzeń
##### Identyfikacja źródła przerwania
Pierwszym problemem jest identyfikacja źródła przerwania. Procesor jest tylko informowany o tym, że jakieś przerwanie wystąpiło.
Rozwiązać ten problem można na kilka sposobów:
  - wiele linii przerwań - jest to niewygodne, ponieważ linii musiałoby być tyle, ile jest urządzeń, może ich być więc za dużo albo za mało - trudno to zrealizować w systemie ogólnego zastosowania
  - odpytywanie programowe - procesor musiałby zapytać każde urządzenie, czy to przypadkiem nie ono zgłosiło przerwanie. Jest to czasochłanne. Można byłoby to usprawnić, odpytując wyłącznie te urządzenia, co do których wiemy że zleciliśmy realizację operacji. Jednak i tak wymaga to przeglądania tablicy urządzeń i jest czasochłonne
  - odczyt wektora - urządzenie wystawia odpowiednie informacje na magistrali; robi to, gdy procesor potwierdzi otrzymanie przerwania. Sygnał potwierdzenia jest łańcuchowo propagowany do kolejnych urządzeń, aż odezwie się to, które zgłosiło przerwanie. Innym sposobem jest uzyskanie wyłączności dostępu do magistrali przez urządzenie i wystawienie odpowiedniego wektora przed zgłoszeniem przerwania (arbitraż na magistrali)

Hybrydowym podejściem do problemu jest użycie sterownika przerwań, który ma wiele wejść i jedno wyjście. Kiedy procesor otrzyma przerwanie, wystarczy że odpyta sterownik przerwań. Ma on jednak ten sam problem, co procesor - liczba wejść może być nieodpowiednia. Dlatego podejście to jest łączone z odpytywaniem programowym.

W praktyce, wiele urządzeń może zgłaszać przerwanie o tym samym numerze. Na początku identyfikuje się numer przerwania, a dopiero później odpytuje się wszystkie urządzenia, które zgłaszają przerwanie o takim numerze.

##### Problem priorytetów
W danym momencie powinno się obsługiwać przerwania w odpowiedniej kolejności. Za ustalenie tej kolejności odpowiadają priorytety.

Priorytety urządzeń wiążą się z priorytetami przerwań, które te urządzenia generują. Problem można jednak uogólnić na priorytety wszelkich zdarzeń, na jakie reaguje jądro. Na określonym poziomie pracy jądro reaguje tylko na zdarzenia o wyższym priorytecie. Tak więc obsługując jakieś przerwanie, podnosimy poziom pracy, a kończąc jego obsługę - obniżamy.

Przykładowo, w systemie UNIX stosuje się coś zbliżonego do tego:
  - poziom 0 - jądro reaguje na wszystkie zdarzenia
  - poziom 1 - jądro ignoruje żądania realizacji zadań okresowych (albo kolejkuje)
  - poziom 2 - jądro nie przetwarza danych protokołu sieciowego, ale pobiera jeszcze informacje od karty
  - poziom 3 - jądro nie obsługuje żądań terminala
  - poziom 4 - jądro nie obsługuje żądań dysku
  - poziom 5 - jądro nie obsługuje żądań karty sieciowej
  - poziom 6 - jądro nie reaguje na przerwania czasomierza
  - poziom 7 - jądro nie reaguje na żadne przerwania

W każdym systemie może jednak być inaczej. Przykładowo, w systemie Windows XP są 32 poziomy, a systemy Linux i Solaris stosują w ogóle inne podejście - wątki jądra, których priorytety decydują o realizacji procedury określonego przerwania.

### Efektywność interakcji procesora i sterownika
Oznaczenia:
  - T_c - czas przetwarzania przez procesor
  - T_d - czas realizacji operacji I/O przez sterowniki urządzeń
  - T_o - skumulowany narzut czasowy (zwłoka pomiędzy zgłoszeniem gotowości przez sterownik, a reakcją procesora)
  - T_t - całkowity czas realizacji przetwarzania

Dodatkowe oznaczenia dla trybu odpytywania (w tym trybie T_o  = T_p):
  - T_p - skumulowane opóźnienie w pętli odpytywania pomiędzy ustawieniem bitu gotowości, a odczytaniem rejestru stanu

Dodatkowe oznaczenia w trybie sterowania przerwaniami (w tym trybie T_o = T_b + T_h + T_r):
  - T_b - skumulowany czas oczekiwania na zwolnienie urządzenia
  - T_h - skumulowany czas obsługi przerwań
  - T_r - skumulowany czas oczekiwania na przydział procesora po zakończeniu operacji I/O

W systemie jednozadaniowym odpytywanie jest skuteczniejsze! I z punktu widzenia pojedynczego procesu zawsze jest wydajniejsze, ale jeżeli system wielozadaniowy ma byc sprawiedliwy i nie marnować czasu na oczekiwanie, wtedy sterowanie przerwaniem będzie po prostu skuteczniejsze.

W systemie wielozadaniowym liczy się suma czasów pracy wszystkich procesów. Żeby kwestionować zasadność obsługi urządzeń I/O poprzez przerwania, czas skumulowanej obsługi przerwań musiałby być naprawdę znaczący. Takie podejście mogłoby mieć sens tylko w przypadku bardzo szybkich urządzeń, realizujących operacje I/O w ciągu kilkunastu albo kilkudziesięciu cykli rozkazowych.


### Bezpośredni dostęp do pamięci
Trzecią metodą sterowania urządzeniami I/O jest układ DMA, który realizuje koncepcję bezpośredniego dostępu do pamięci. Działa on tak, że procesor zleca mu transmisję danych pomiędzy urządzeniem, a pamięcią, podając adres urządzenia, adres w pamięci oraz rozmiar bloku danych. W tym momencie układ DMA rozpoczyna pracę i automatycznie zapisuje dane w odpowiednim miejscu (przejmuje kontrolę nad magistralą, gdy procesor jej nie potrzebuje, albo wykrada procesorowi cykl magistrali aby zrealizować swoje zadanie). Gdy skończy pracę, sygnalizuje o tym procesor poprzez zgłoszenie przerwania.

Praca takiego układu wiąże się z ograniczeniami, związanymi z dostępem do magistrali (potrzebny jest wyłączny dostęp w danej chwili), jednak daje to pewne korzyści. Jeżeli procesor miałby kopiować dane słowo po słowie, musiałby co chwilę obsługiwać kolejne przerwania - układ DMA nie musi tego robić, bo nie jest sterowany przerwaniami. Dodatkowo kopiowanie zaśmiecałoby pamięć podręczną procesora.

Układ DMA może być umiejscowiony w różny sposób:
  - podłączony do wspólnej magistrali z procesorem (musi wtedy z nim rywalizować o wyłączny dostęp, zarówno przy dostępie do pamięci, jak i do urządzeń I/O)
  - być zintegrowany z jednym lub z kilkoma urządzeniami
  - posiadać osobną magistralę dla urządzeń I/O.

## Buforowanie
Celem buforowania jest niwelowanie różnic pomiędzy urządzeniami:
  - w szybkości działania (komputer i drukarka)
  - w podstawowej jednostce danych (bajt i sektor)
Istotne jest też zapewnienie semantyki kopii, czyli zagwarantowanie niezmienności danych podczas wykonywania operacji I/O. Na przykład, jeżeli użytkownik zleci zapis pliku na dysk, i bezpośrednio po tym zleceniu zacznie go modyfikować, taka operacja mogłaby naruszyć integralność pliku. Dlatego podczas zlecenia zapisu, jego zawartość jest najpierw buforowana, a dopiero później rozpoczyna się właściwa procedura zapisu.

Stosuje się następujące rodzaje buforów:
  - pojedynczy (może być tylko czytany lub tylko zapisywany w jednej chwili)
  - podwójny (może być jednocześnie czytany i zapisywany)
  - cykliczny (przydaje się, gdy rozbieżności w szybkości pracy są duże - jedno z urządzeń cyklicznie zapisuje kolejne pozycje bufora, a drugie cyklicznie odczytuje; istotna jest blokada przed nadpisaniem jeszcze nieodczytanej pozycji)

Przechowywanie podręczne - szczególna forma buforowania, której celem jest wyłącznie poprawa efektywności. Zmniejsza czas dostępu i pozwala skumulować wyniki przez dłuższy czas i przekazać je na urządzenie zewnętrzne w wyniku jednej operacji wyjścia. Jest to stosowane np. w przypadku zapisu plików albo pamięci wirtualnej.

## Spooling
Nazwa jest akronimem od *Sequential Peripheral Operation On Line*, czyli *na bieżąco realizowana operacja sekwencyjna na urządzeniu wejścia-wyjścia*.

Typowym urządzeniem, do którego obsługi wykorzystuje się spooling, jest drukarka. Jest to urządzenie o wyłącznym trybie użytkowania - podczas drukowania danego dokumentu, tylko ten proces ma wyłączność do drukarki. Nie można sobie pozwolić na przeploty drukowania różnych dokumentów.

Spooling polega na tym, że strumień danych jest buforowany, i przekazywany do drukarki dopiero po zapamiętaniu całego strumienia. Objętość strumienia może być duża, dlatego buforowanie odbywa się najczęściej na dysku. Urządzenia ze spoolera do urządzenia przekazuje jeden proces (lub wątek), i zapewnia to sekwencyjność tej operacji.

Alternatywnym rozwiązaniem byłoby przydzielanie urządzenia tylko jednemu procesowi, ale tworzy to problem, jeżeli proces przekaże tylko część strumienia, resztę odłoży w czasie, a drukarka nie zostanie zwolniona. W przypadku spoolingu, aby drukowanie mogło się rozpocząć, cały strumień musi zostać zbuforowany, więc nie będzie ona przetrzymywana przez żaden proces.

## Wirtualne wejście-wyjście
To wszystko co było powyżej to absolutnie kluczowe zagadnienia dotyczące komunikacji komputera z urządzeniami peryferyjnymi. Jednak opisane zagadnienia są niskopoziomowe. Oprócz nich, system operacyjny musi także dostarczyć warstwę abstrakcji, która umożliwi wygodnie i bezpiecznie z nich korzystać, np. stos protokołów TCP/IP, czy system plików.

