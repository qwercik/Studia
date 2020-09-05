---
tags: [SO, SO wykład]
title: 1. Systemy Operacyjne - wprowadzenie
created: '2020-06-19T15:17:51.287Z'
modified: '2020-06-19T16:35:33.879Z'
---

# 1. Systemy Operacyjne - wprowadzenie

## Problematyka
W tej lekcji omówiony został bardzo ogólny zarys systemu operacyjnego, jego rola i zadania, oraz podstawywa klasyfikacja.

## Definicja
System operacyjny ma za zadanie:
 - stanowić pewną warstwę abstrakcji, umożliwiającą wygodne użytkowanie komputera, niezależnie od sprzętu
 - obsługiwać zasoby systemu komputerowego i zwielakratniać je

System operacyjny pośredniczy pomiędzy oprogramowaniem użytkowym, a sprzętem.

## Zadania systemu operacyjnego
  - definiować interfejs użytkownika
  - udostępniać system plików
  - udostępniać środowisko do wykonywania programów użytkownika (ładowanie i uruchamianie programów oraz synchronizacja i komunikacja procesów)
  - sterowanie urządzeniami wejścia-wyjścia
  - obsługa podstawowej klasy błędów

## Zadania systemu związane z obsługą zasobów
  - przydział zasobów (proces może poprosić o przydzielenie wyłącznego dostępu do drukarki)
  - planowanie dostępu do zasobów (system musi przydzielać zasoby odpowiedniom procesom w odpowiednim momencie, tak aby ogólna wydajność systemu była możliwie najlepsza - w przypadku systemów multimedialnych, albo żeby określone zadania zostały wykonane w określonym terminie - w przypadku systemów czasu rzeczywistego)
  - ochrona i autoryzacja dostepu do zasobów (np. drukować mogą tylko uprawnieni użytkownicy)
  - odzyskiwanie zasobów (kiedy proces zakończy swoje działanie, to na przykład używana przez niego wcześniej pamięć powinna zostać przydzielona do puli wolnej pamięci)
  - rozliczanie (system może monitorować ile pamięci zużywają procesy danego użytkownika)

  Podstawowymi zasobami są: procesor, pamięć operacyjna, urządzenia wejścia-wyjścia (w tym urządzenia pamięci masowej) oraz informacje (to taki bardziej abstrakcyjny zasób).

## Klasyfikacja systemów operacyjnych
### Ze względu na sposób przetwarzania
  - systemy interakcyjne (przetwarzania bezpośredniego) - działają w sposób interaktywny, a operacje zlecone przez użytkownika są wykonwane natychmiast
  - systemy wsadowe (przetwarzania pośredniego) - występuje duża zwłoka czasowa pomiedzy przedłożeniem zadania, a rozpoczęciem jego wykonywania i użytkownik nie ma wpływ na to wykonywanie

### Ze względu na liczbę wykonywanych programów
  - jednozadaniowe - w danej chwili mogą wykonywać tylko jedno zadanie
  - wielozadaniowe - jednocześnie mogą wykonywać wiele zadań

### Ze względu na liczbę użytkowników
  - systemy dla jednego użytkownika - są przystosowane do użytku przez jednego użytkownika, brakuje im możliwości do ochrony danych i mechanizmów autoryzacji
  - systemy wielodostępne - z jednego systemu może korzystać wielu użytkowników, dlatego system posiada mechanizmy ochrony danych każdego użytkownika

### Inne
  - Systemy czasu rzeczywistego - dbają o to, żeby zadanie wykonało się w odpowiednim momencie - mogą więc zaniedbywać inne zadania kosztem jednego
  - Systemy sieciowe i rozproszone - łączą w całość zbiór rozproszonych komputerów i tworzą z nich pewną jednostkę przetwarzającą informacje (komputery te nie współdzielą zasobów fizycznie)
  - Systemy operacyjne komputerów naręcznych - systemy podlegające znacznym ograniczeniom zasobowym, skupione na przykład na oszczędzaniu energii itd.
