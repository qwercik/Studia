---
tags: [SO wykład]
title: 8. Planowanie przydziału procesora
created: '2020-04-29T12:31:55.435Z'
modified: '2020-09-02T13:48:08.667Z'
---

# Planowanie przydziału procesora


1. Komponenty jądra w planowaniu:
  - planista krótkoterminowy (cpu scheduler) - zajmuje się przydzielaniem czasu procesora procesom gotowym. Wyznacza wartości priorytetów i na tej podstawie wybiera proces o największym priorytecie
  - ekspedytor - zajmuje się przełączeniem kontekstu, czyli przekazaniem sterowania do procesu wybranego przez planistę

2. Ogólna koncepcja planowania:
  - funkcja priorytetu - zbiór wytycznych dla planisty. Wartość tej funkcji to jakaś liczba, określająca priorytet procesu. Na funkcję priorytetu składają się różne czynniki
  - tryb decyzji - określa okoliczności, w których oceniane i porównywane są priorytety procesów oraz dokonywany jest wybór procesu do wykonania

3. Tryb decyzji:
  - schemat niewywłaszczeniowy - czekamy, aż proces sam zakończy zadanie, albo się go zrzeknie (yield)
  - schemat wywłaszczeniowy - proces może zostać zatrzymany i umieszczony w kolejce procesów gotowych, a czas procesora zostanie przydzielony procesowi o wyższym lub równym priorytecie. Wywłaszczenie może nastąpić w przypadku: utworzenia nowego procesu, obudzenia innego procesu w wyniku otrzymania komunikatu lub sygnału wynikającego z synchronizacji, upłynięcia kwantu czasu odmierzanego przez czasomierz, wzrostu priorytetu innego procesu w stanie gotowym.

4. Funkcja priorytetu - jej argumentami są wybrane składowe stanu procesu i stanu systemu. Priorytet w każdej chwili jest wartością wynikową funkcji priorytetu w obecnej sytuacji.

5. Argumenty funkcji priorytetu:
  - czas oczekiwania (czas spędzony w stanie gotowości, nie oczekiwania na I/O!)
  - czas obsługi (czas przez który proces był wykonywany (wykorzystywał procesor))
  - rzeczywisty czas przebywania w systemie - czas spędzony w systemie od momentu przyjęcia (czas obsługi + czas oczekiwania + czas realizacji żądań zasobowych)
  - czasowa linia krytyczna - czas, po którym wartość wyników spada (dotyczy systemów czasu rzeczywistego)
  - priorytet zewnętrzny - składowa priorytetu, która pozwala wyróżnić procesy ze względu na klasy użytkowników lub rodzaj wykonywanych zadań
  - wymagania odnośnie wielkości przestrzeni adresowej pamięci
  - obciążenie systemu - liczba procesów przebywających w systemie i ubiegający się (potencjalnie) o przydział procesora lub innych zaosbów, zajętość pamięci

6. Reguła arbitrażu - jak mamy wybierać spośród procesów o identycznym priorytecie?
  - losowo
  - cyklicznie
  - chronologicznie
  - FIFO

7. Kryteria oceny uszeregowania:
  a) z punktu widzenia systemu:
    - efektywność: wykorzystanie czasu procesora (żeby nie było sytuacji, że żaden wątek nie jest wykonywany), przepustowość (liczba procesóœ kończonych w jednostce czasu)
    - sprawiedliwość
    - respektowanie zewnętrznych priorytetów
    - równoważenie obciążenia (wykorzystania) zasobów
  b) z puntku widzenia użytkownika:
    - czas cyklu przetwarzania - czas pomiędzy przedłożeniem zadania, a jego zakończeniem
    - czas odpowiedzi - czas pomiędzy przedłożeniem żądania, a rozpoczęciem przekazywania odpowiedzi
    - czas opóźnienia - czas od linii krytycznej do momentu zakończenia wykonywania
    - przewidywalność

8. Algorytmy planowania niewywłaszczalnego:
  - FCFS - First Come First Served - naturalny dla banków, urzędów, kas biletowych
  - LCFS - Last Come First Served - raczej brak zastosowań
  - SJF (SJN, SPF, SPN) - Shortest Job/Process First/Next - ma sens w systemach masowej obsługi, ale problemem jest często określenie przyszłego zapotrzebowania na procesor

9. Algorytmy planowania wywłaszczalnego:
  - planowanie rotacyjne (RR, Round Robin)
  - SRT - Shortest Remaining Time - najpierw zadanie, które ma najkrótszy czas do zakończenia

10. Podstawowe algorytmy planowania, a funkcja priorytetu - potrzebne są następujące atrybuty czasowe procesów:
  - a - bieżący (dotychczasowy) czas obsługi,
  - r - rzeczywisty czas w systemie
  - t - całkowity wymagany czas obsługi (czas obsługi do momentu zakończenia)

11. Estymacja czasu obsługi dla algorytmów SFJ/SRT - średnia arytmetyczna/wykładnicza (postarzanie)

12. Algorytm RR - kwant czasu powinien być trochę większy, niż czas odpowiedzi (reakcji)

13. Inne algorytmy planowania:
 - planowanie priorytetowe (opieramy się na priorytecie zewnętrznym) - stosuje się raczej rozwiązania hybrydowe, dla których priorytet zewnętrzny jest tylko jedną ze składowych
 - planowanie wielokolejkowe - w systemie jest wiele procesów gotowych i każda z kolejek może być inaczej obsługiwana
 - planowanie przed liniami krytycznymi - zakończenie zadawania przed czasową linią krytyczną lub możliwie krótko po tej linii

14. Problem inwersji priorytetów - proces o wysokim priorytecie jest w stanie oczekiwania na zasób, przetrzymywany przez inny proces. Proces przetrzymujący krytyczny zasób jest gotowy, ale ma niski priorytet, więc jest pomijany przez planistę. Trzeba więc nadać równie wysoki priorytet (albo wyższy) procesowi gotowemu, żeby mógł uzyskać procesor, wykonać kolejny fragment przetwarzania, w wyniku którego zwolni zasób i umożliwi wykonywanie procesu wysokopriorytetowego

15. Szeregowanie procesów ograniczonych wejściem-wyjściem - właściwy byłby SJF lub SRT, aby zwalniać używane zasoby. Ale trzeba pamiętać, że bezwzględna preferencja procesów I/O-bound może powodować głodzenie procesów CPU-bound.
Rozwiązaniem może być zwiększenie preferencji dla procesów, które wchodzą w stan gotowości po zakończeniu oczekiwania na urządzenie zewnętrzne.
Tworzymy więc dwie kolejki: główną i pomocniczą. Główna jest dla procesów gotowych, pomocnicza dla oczekujących. Obsługujemy w pierwszej kolejności pomocniczą, ale procesom dajemy tylko tyle czasu, ile pozostało im niewykorzystanych z oryginalnego kwantu procesora.

16. Wielopoziomowe kolejki ze sprzężeniem zwrotnym - jest wiele poziomów kolejek, każdy odpowiada jednemu priorytetowi. Procesy mogą być przemieszczane pomiędzy poziomami. Wybieramy ten, z najwyższego poziomu.

17. Planista musi działać możliwie szybko, a przełączanie kontekstu musi być jednocześnie częste (żeby zapewnić wrażenie współbieżności), i rzadkie (żeby nie marnować cennego czasu na przełączanie kontekstu).

18. Implementacja algorytmu FCFS w oparciu o kolejkę FIFO. Nie jest to dokładna realizacja, ponieważ po wejściu w stan oczekiwania i ponownym uzyskaniu gotowości, proces jest dopisywany na koniec kolejki, choć model matematyczny definiuje funkcję priorytetu jako czas przebywania w systemie od momentu przyjęcia.

19. Kolejka priorytetowa.
Lokalizację pierwszej niepustej kolejki można przeprowadzić przy użyciu wektora bitowego i bardzo szybko wyszukać.





