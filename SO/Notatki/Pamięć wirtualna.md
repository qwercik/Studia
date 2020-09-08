---
tags: [SO wykład]
title: 10. Pamięć wirtualna
created: '2020-09-05T11:53:12.728Z'
modified: '2020-09-05T19:30:36.515Z'
---

# 10. Pamięć wirtualna

## Problematyka
Pamięć wirtualna jest organizacją zasobów pamięci, zrealizowaną w oparciu o tzw. przestrzeń wymiany w pamięci drugiego rzędu (na dysku). Dzięki niej możemy wymieniać bloki danych pomiędzy pamięcią operacyjną, a dyskiem (zapisywać na dysku dane, które są aktualnie nieużywane, a ładować te potrzebne).

Celem wykładu jest przedstawienie zasady działania i problemów realizacji pamięci wirtualnej oraz omówienie algorytmów wymiany stron pomiędzy pamięcią operacyjną a pamięcią drugiego rzędu (obszarem wymiany).

## Stronnicowanie na żądanie
Pamięć wirtualna jest większa, niż pamięć operacyjna (gdyż rozszerza ona pamięć operacyjną o pamięć wymiany). W momencie, gdy dana strona nie byłaby załadowana do pamięci operacyjnej, a funkcjonowała w pamięci wymiany, system operacyjny musiałby sprowadzić ją na żądanie. Strona jest sprowadzana w momencie, gdy zgłoszony zostanie błąd strony (adres odwołuje się do nieistniejącej strony). Podczas jej sprowadzania istnieje potrzeba usunięcia z pamięci innej strony. Decyzji, którą stronę należy zastąpić, dokonuje algorytm wymiany.

Informacje o tym, czy strona jest poprawna (znajduje się w pamięci operacyjnej) zawiera tablica stron z bitem poprawności dla każdej pozycji (dodatkowo z bitem modyfikacji i odniesienia). Bit ten jest ustawiany po sprowadzeniu strony do pamięci operacyjnej. Po jej usunięciu jest resetowany

Wymiana stron pomiędzy pamięcią operacyjną, a pamięcią wymiany może nastąpić dopiero w momencie wystąpienia błędu strony (jest nazywana wtedy leniwą wymianą), ale może również się to stać wcześniej, na podstawie pewnej predykcji.

## Zastępowanie stron
Problem pojawia się wtedy, gdy w pamięci operacyjnej kończy się miejsce i nie wystarczy tylko sprowadzić strony z dysku - trzeba najpierw usunąć jakąś stronę z pamięci.

Jeżeli strona nie była modyfikowana, można ją po prostu usunąć; jeżeli była modyfikowana - trzeba ją ponownie zapisać w obszarze wymiany. To, czy ramka była modyfikowana, czy nie, determinuje bit modyfikacji.

Ramka, która jest użyta do wymiany, określona jest jako ramka ofiara (choć to raczej strona jest ofiarą).

Można przeprowadzić matematyczne rozważania na temat kosztu wymiany stron, jednak wniosek z nich jest prosty: sprowadzenie kilku stron w wyniku realizacji jednego żądania jest bardziej kosztowne, niż sprowadznie jednej strony, ale mniej kosztowne, niż sprowadzenie poszczególnych stron w wyniku osobnych żądań.

Koszt wymiany można aproksymować przy pomocy parametrów FN (liczba wygenerowanych błędów strony) oraz TN (liczba transmisji stron). Wniosek: należy minimalizować liczbę błędów strony i tym samym redukować czas realizacji wymiany, czyli koszt.

## Problemy zastępowania stron
Problematyczny jest wybór ramki - ofiary. Niewłaściwa decyzja może sprowadzić do zjawiska migotania, w którym często dochodzi do występowania odniesienia do właśnie usuniętej strony.

Innym problemem jest problem wznawiania rozkazów - w przypadku wielokrotnego odniesienia do pamięci w jednym cyklu rozkazowym należy zapewnić, że wszystkie adresowane strony są jednocześnie dostępne w ramkach pamięci fizycznej.

## Wybór ofiary
Zakładając, że przyszły ciąg odniesień do pamięci nie jest znany, na podstawie historii odniesień należy wybrać taką ramkę, której prawdopodobieństwo odniesienia w przyszłości jest małe. Podstawowa własność programów, na podstawie której można szacować takie prowadopodobieństwo, jest nazywana lokalnością.

Lokalność czasowa to tendencja procesów do generowania, w stosunkowo długich przedziałach czasu, odniesień do niewielkiego podzbioru stron wirtualnych, zwanego zbiorem stron aktywnych.

Lokalność przestrzenna to tendencja procesu do generowania z dużym prawdopodobieństwem kolejnych odniesień do stron o zbliżonych numerach lub stron o numerach skojarzonych w trakcie przetwarzania.

## Klasyfikacja algorytmów wymiany
Klasyfikacja algorytmów wymiany ze względu na okliczności sprowadzania i usuwania stron:
  - algorytmy wymiany na żądanie (sprowadzamy stronę w przypadku błędu strony, tym samym usuwamy inną stronę)
  - algorytmy wymiany ze sprowadzaniem na żądanie (tylko sprowadzanie odbywa się na żądanie)
  - algorytmy wstępnego sprowadzania (sprowadzana jest strona żądana, a wraz z nią inne strony [lokalność przestrzenna])

Klasyfikacja algorytmów wymiany ze względu na sposób zastępowania stron:
  - zastępowanie lokalne (algorytm wymiany zastępuje tylko strony w ramkach przydzielonych procesowi, który spowodował błąd strony)
  - zastępowanie globalne (algorytm wymiany zastępuje strony znajdujące się w dostępnej puli ramek w całym systemie)

Klasyfikacja algorytmów wymiany ze względu na przydział ramek dla procesów:
  - przydział statyczny - liczba ramek przydzielonych procesowi jest ustalona i nie ulega zmianie w trakcie przetwarzania
  - przydział dynamiczny - liczba ramek przydzielonych procesowi może się zmienić w trakcie przetwarzania

Zastępowanie globalne w naturalny sposób prowadzi do przydziału dynamicznego, nie ma jednak sensu w przypadku przydziału statycznego.

## Dobór liczby ramek
Z przydziałem ramek wiąże się ustalanie ich liczby. Jest to szczególnie istotne w przydziale statycznym, ale dotyczy również początkowej liczby ramek w przydziale dynamicznym. Minimalna liczba ramek jest zdefiniowana przez architekturę komputera (zależna od maksymalnej liczby komórek adresownaych przez jeden rozkaz). Liczba ramek przydzielona do procesu:
  - podział równomierny
  - podział proporcjonalny
  - podział zależny od priorytetu procesu

## Algorytmy na żądanie
Można wymienić następujące algorytmy:
  - MIN - zastępowana jest strona, która najdłużej nie będzie używana (optymalny w tej klasie)
  - FIFO - zastępowana jest strona najwcześniej sprowadzona
  - LIFO - zastępowana jest strona ostatnio sprowadzona
  - LRU - zastępowana jest strona najdłużej nieużywana
  - LFU - zastępowana jest strona najrzadziej używana (najmniej odniesień od początku przetwarzania)
  - MFU - zastępowana jest strona najczęśćiej używana

Z algorytmami wymiany jest związana anomalia Belady'ego. Zwiększenie liczby ramek może, paradoksalnie, wpłynąć na zwiększenie liczby błędów.

## Zagadnienia implementacyjne

### Implementacja FIFO
Należy utrzymywać listę numerów stron w kolejności och sprowadzania do pamięci. Numer sprowadzanej strony umieszcza się na końcu listy, a z pamięci i listy usuwa się stronę, której numer znajduje się na początku listy.

### Implementacja LRU
Można to zrobić na dwa sposoby:
  - licznik - przy każdym odniesieniu do pamięci zwiększana jest wartość pewnego licznika i wpisywana do odpowiedniej pozycji opisującej stronę w tablicy stron (lub oinnej specjalnej strukturze SO), z pamięci usuwana jest wówczas strona z najmniejszą wartością tego licznika, co wymaga przejrzenia całej tablicy stron
  - stos - numery stron, od których następuje odniesienie, odkładane są na szczycie stosu. Przed odłożeniem na szczycie, numer strony musi być wydobyty ze środka stosu, czyli z miejsca, gdzie był ostatnio odłożony. W tej implementacji usuwana z pamięci jest strona, która jest na dnie stosu

Należy zauważyć, że błąd strony występuje nieporównywalnie rzadziej, niż odniesienie do strony. Implementacja tego rozwiązania wymaga przekazania sterowania do programu jądra przy każdym odniesieniu do strony, co może znacznie spowolnić całość systemu. Aby to skutecznie realizować, potrzebne byłoby wsparcie na poziomie architektury komputera.

Metodę LRU można jednak przybliżyć - nie chodzi o wielką dokładność, ale bardziej o efektywność działania i ogólną skuteczność algorytmu. W tym przybliżeniu niezbędne jest wspomaganie na poziomie architektury:
  - bit odniesienia - ustawiany jest przy każdym odniesieniu do strony (zapis/odczyt)
  - bit modyfikacji - ustawiany jest przy każdym zapisie strony

Wykorzystując to sprzętowe wspomaganie, można zaimplementować poniższe algorytmy.
#### Algorytm dodatkowych bitów odniesienia
Przy odniesieniu się do stron ustawiany jest bit odniesienia. Bity odniesienia okresowo są kopiowane do specjalnej tablicy dodatkowych bitów odniesienia. Umieszczane są na pozycji najbardziej znaczącej, ale wcześniej bity w tablicy są przesuwane w prawo. Bity najmniej znaczące są tracone. Im mniejsza liczba wychodzi z danego wiersza tablicy bitów odniesienia, tym lepszym kandydatem na ofiarę będzie strona.

#### Algorytm drugiej szansy
Jest tak zwanym algorytmem zegarowym (wskazówkowym), w którym numery stron tworzą listę cykliczną, a wskazówka wskazuje stronę do usunięcia z pamięci w przypadku takiej konieczności. Jeżeli bit odniesienia jest ustawiony, jest kasowany, a strona dostaje drugą szansę. W przypadku napotkania strony z bitem odniesienia ustawionym na 0, stronę się usuwa.

Algorytm można ulepszyć, uwzględniając bit modyfikacji. Można po prostu unikać wymiany stron modyfikowanych. Bity odniesienia i modyfikacji (w takiej kolejności) tworzą pewną liczbę, im mniejsza ona jest, tym mniejsza strata w razie jej usunięcia.

## Algorytmy ze sprowadzaniem na żądanie
- VMIN - usuwane są strony, których koszt utrzymania w pamięci jest większy od kosztu ponownego sprowadzenia
- WS - usuwane są strony, do których nie było odniesień przez określony czas
- WSClock - przybliżona wersja WS, oparta na bicie odniesienia
- PFF, VSWS - przydział i zwalnianie ramek procesów realizowane jest na podstawie częstości zgłaszania błędów strony

Algorytm VMIN jest optymalny w tej klasie algorytmów, ale oparty na znajomości przyszłego ciągu odniesień do stron. Algorytm WS oparty jest na koncepcji zbioru roboczego (zbioru stron, do ktorych było odniesienie w ostatnim okresie czasu w przeszłości). Algorytmy PFF i VSWS dają podobny efekt do zbioru roboczego, przy czym są oparte na częstości generowania błędów strony.

### Zbiór roboczy
Zbiór roboczy to zbiór stron, które zostały zaadresowane w ciągu ostatnich T odniesień do pamięci (w tzw. oknie zbioru roboczego). Zbiór roboczy w chwili t, przy rozmiarze okna T będzie oznaczony jako W(t, T). Algorytm usuwa z pamięci wszystkie strony, które nie należą do zbioru roboczego.

Liczba elementów może być mniejsza niż rozmiar okna, jeżeli były takie same.

Ze zbiorem roboczym jest taki sam problem jak z algorytmem LRU. Zaimplementowanie tej koncepcji dokładnie jest złożone obliczeniowo, dlatego stosuje się realizacje przybliżone. Wspomaganiem sprzętowym jest tutaj bit odniesienia. Okresowo (wyznaczone przez czasomierz) zwiększa się licznik reprezentujący upływ czasu wirtualnego i sprawdzenie bitu odniesienia dla każdej z ramek. Jeżeli bit odniesienia jest ustawiony, to skasowanie tego bitu i wpisanie bieżącej wartości licznika do odpowiedniej tablicy na pozycji odpowiadającej ramce. Jeżeli bit jest skasowany, to sprawdzenie różnicy pomiędzy bieżącą wartością licznika, a wartością na odpowiedniej pozycji w tablicy i usunięcie, gdy różnica jest większa niż rozmiar okna.

Upływ czasu wirtualnego musi być rejestrowany oddzielnie dla każdego procesu i tylko wówczas, gdy jest on wykonywany. Przerwanie zegarowe powinno więc zwiększać licznik tylko w tym procesie, w kontekście którego jest obsługiwane. Pomimo uniknięcia konieczności montorowania wszystkich odniesień do pamięci, implementacja tego algorytmu i tak jest kosztowna, gdyż po każdym przerwaniu zegarowym jest wymagane testowanie bitu odniesienia każdej ze stron procesu.

### Algorytm WSClock
Dla każdej ramki utrzymywany jest wirtualny (przybliżony) czas ostatniego odniesienia. Wszystkie ramki są powiązane w cykl (niezależnie od procesu). W wyniku wystąpienia błędu strony sprawdzany jest bit odniesienia do strony wskazywanej jako kolejna do usunięcia. Jeżeli jest ustawiony, zostaje on skasowany, po czym następuje wskazanie następnej ramki w cyklu i sprawdzenie bitu odniesienia.

Warto zwrócić uwagę, że lista cykliczna obejmuje wszystkie ramki w systemie (globalnie), próba usunięcia strony podejmowana jest w reakcji na błąd strony, co oznacza, że jest to właściwie algorytm wymiany na żądanie.

Jeżeli blok odniesienia jest skasowany, sprawdzana jest różnica pomiędzy wirutalnym czasem bieżącym, a czasem ostatniego odniesienia do wskazywanej strony. Jeżeli różnica jest większa od rozmiaru okna zbioru roboczego, następuje wymiana strony w ramce. W przeciwnym razie strona pozostaje i następuje  wskazanie i sprawdzenie ramki następnej.

W przypadku wykonania pełnego obiegu przez wskazówkę i stwierdzenia braku stron do wymiany następuje zawieszenie jakiegoś procesu

### Algorytm zegarowy dwuwskazówkowy
Wszystkie strony w pamięci powiązane są w listę cykliczną, któ©a jest okresowo przeglądana przez dwie wskazówki: wiodącą (przednią) która zeruje bit odniesienia, zamykającą (tylną) która wskazuje stronę do usunięcia.

Jeśli bit odniesienia przed nadejściem tylnej wskazówki zostanie ponownie ustawiony, strona pozostaje w pamięci, w przeciwnym wypadku jest usuwana. Algorytm jest sterowany parametrami: tempo przeglądania, rozstaw wskazówek.

Jest jeszcze kilka algorytmów, ale ich nie omawiałem, bo tego jest za dużo.

 
