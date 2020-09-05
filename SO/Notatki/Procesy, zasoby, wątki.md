---
tags: [SO wykład]
title: '7. Procesy, zasoby, wątki'
created: '2020-04-29T11:37:16.065Z'
modified: '2020-09-02T13:50:25.375Z'
---

# 7. Procesy, zasoby, wątki

1. Proces składa się z:
  - programu (nie zmienia się w czasie wykonania),
  - danych,
  - zasobów,
  - bloku kontrolnego (PCB, deskryptor), który opisuje bieżący stan.

2. Procesem jest cały kontekst, niezbędny do wykonywania programu.

3. Zasób to element sprzętowy lub programowy, którego brak może zablokować wykonywanie programu. Są zasoby wirtualne, które są czysto programowe, np. plik.

4. Podział operacji jądra w zarządzaniu procesami i zasobami:
  - operacje tworzenia i usuwania procesów oraz elementarna komunikacja międzyprocesowa
  - operacje przydziału i zwalniania jednostek zasobów
  - elementarne operacje wejścia-wyjścia
  - procedury obsługi przerwań

5. Zarządcy: procesów oraz zasobów.

6. Struktury danych:
  - deskryptor procesu (PCB) - informacje o procesie
  - deskryptor zasobu - przechowuje informacje o dostępnośći i zajętości jednostek danego typu zasobu

7. Deskryptor procesu
  - identyfikator
  - stan: (nowy, gotowy, oczekujący)
  - identyfikator właściciela
  - identyfikator przodka
  - lista zasobów przydzielonych
  - rejestry procesora
  - prawa dostępu
  - informacje na potrzeby zarządzania pamięcią
  - informacje na potrzeby planowania (np. priorytet)
  - informacje do rozliczeń
  - wskaźniki do kolejek porządkujących

8. Stany procesu: nowy, wykonywany, oczekujący, gotowy, zakończony

9. Deskryptor zasobu:
  - identyfikator
  - rodzaj
  - identyfikator twórcy
  - lista dostępnych jednostek
  - kolejka/lista procesów oczekujących na jednostki danego zasobu

10. Klasyfikacja zasobów:
  a) ze względu na sposób wykorzystania: odzyskiwalne, nieodzyskiwalne
  b) ze względu na sposób odzyskiwania: wywłaszczalne, niewywłaszczalne
  c) ze względu na tryb dostępu: współdzielone, wyłączne

11. Kolejki procesów:
  - kolejka zadań - wszystkie procesy systemu
  - kolejka procesów gotowych - procesy gotowe do działania, w pamięci głównej
  - kolejka do urządzenia - procesy czkeające na zakończenie I/O
  - kolejka procesów oczekujących na sygnał synchronizacji od innych procesów (np. kolejka procesów na semaforze)

12. Planista:
  - krótkoterminowy - przydział procesora do procesów gotowych
  - średnioterminowy - wymiana procesów pomiędzy pamięcią, a dyskiem
  - długoterminowy - ładowanie nowych programów do pamięci i kontrola liczby zadań w systemie

13. Rodzaje procesów:
  - ograniczone procesorem
  - ograniczone wejściem-wyjściem

14. Proces w pamięci to proces aktywny, proces na dysku to proces zawieszony
15. Wątek - lekki proces, posiada swój kontekst wykonawczy, ale współdzieli z innymi wątkami danego procesu zasoby, np. przestrzeń adresową

16. Wątki mogą być realizowane na poziomie systemu lub na poziomie użytkownka:
  - na poziomie użytkownika - tańszy koszt przełączania kontekstu, ale istnieje ryzyko głodzenia wątków albo całego procesu (wystarczy że jeden będzie miał jakąś operację I/O i cały proces jest oznaczony jako oczekujący),
  - na poziomie jądra - większy koszt przełączenia kontekstu, ale bardziej sprawiedliwy przydział czasu

17. Linux nie rozróżnia wątków i procesów. Przy tworzeniu procesu wybiera się, jakie zasoby mają być współdzielone, a jakie nie

18. Stany procesu: TASK_RUNNING, TASK_INTERRUPTABLE, TASK_UNINTERRUPTIBLE, TASK_ZOMBI, TASK_STOP. Warto zwrócić uwagę, że procesy wykonywane i gotowe nie są rozróżniane, rozróżniane są za to procesy oczekujące.

19. W Windowsie proces gromadzi zasoby na potrzeby wykonywania wątków, które wchodzą w jego skład. Procesy są zawarte w EPROCESS, którego częścią jest właściwy blok kontrolny KPROCESS. Zawartości tych struktur dostęþne są w trybie jądra. Część opisu procesu (PEB) znajduje się w części przestrzeni adresowej, dostępnej w trybie użytkownika.

20. W Windowsie wątki korzystają z zasobów przydzielonych procesom. Wątki (nie procesy) ubiegają się o przydział procesora i są szeregowane przez planistę krótkoterminowego. Informacja o wątku jest w ETHREAD, którego częścią jest blok kontrolny KTHREAD. Blok środowiska wątku (TEB) jest dostępny w trybie użytkownika.

21. Stany wątku w Windows: Inicjalizowany, Gotowy, Wykonywany, Czuwający (wybrany do wykonywania jako następny), zakończony, Przejście (oczekuje na sprowadzenie swojego stosu jądra z pliku wymiany), Unknown



