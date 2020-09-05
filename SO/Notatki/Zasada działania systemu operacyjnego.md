---
tags: [SO, SO wykład]
title: 2. Zasada działania systemu operacyjnego
created: '2020-06-19T16:35:42.706Z'
modified: '2020-06-19T18:32:48.338Z'
---

# 2. Zasada działania systemu operacyjnego

System operacyjny jest dość specyficznym programem, gdyż musi on monitorować działanie innych programów. Błędy w jądrze mogą destabilizować działanie całego systemu.

Architektura komputerowa jest wielowarstwowa. Możemy wyróżnić takie warstwy (począwszy od najniższej):
  1. Zjawiska fizyczne w półprzewodnikach
  2. Propagacja sygnałów logicznych na poziomie układów techniki cyfrowej
  3. Poziom mikroarchitektury (w przypadku procesorów CISC)
  4. Poziom maszynowy procesora | Poziom asemblera | Poziom systemu operacyjnego
  5. Poziom języka zorientowanego problemowo

## Architektura von Neumanna
Istotnym pojęciem jest architektura von Neumanna. Wprowadza ona bardzo istotną koncepcję: kod to dane. Tak więc kod programu może być przechowywany razem z danymi w tej samej pamięci. Rozkazy są wykonywane w takiej kolejności, w jakiej umieszczono je w programie (są sekwencyjne). Przełamanie tej kolejności może nastąpić tylko w momencie skoku (i instrukcjach powiązanych, typu skoki warunkowe, wywołanie, powrót itd.). Aby pobrać rozkaz z pamięci, procesor wystawia odpowiedni adres na magistrali adresowej.

## Cykl rozkazowy
Jest to cykl działań procesora i jego interakcji z pamięcią, związanych z realizacją rozkazu. Każdy cykl rozkazowy składa się z faz, zwanych cyklami maszynowymi. Typowe fazy cyklu rozkazowego to:
  - pobranie kodu rozkazu (odczyt pamięci)
  - pobranie operandu (odczyt pamięci)
  - składowanie operandu (zapis pamięci)

## Przekazywanie sterowania przez program użytkowy do jądra
Odbywa się to poprzez przerwanie. Procesor musi później zidentyfikować, co jest powodem przerwania i podjąć odpowiednią procedurę.

Stabilność pracy systemu wymaga ochrony jądra przed ingerecją użytkowników. Dlatego istotna jest ochrona pamięci (czy program użytkownika odwołuje się do adresów tylko z przyznanego mu zakresu). Procesy użytkownika są uruchamiane w trybie nieuprzywilejowanym, a jądro pracuje w uprzywilejowanym.

Przerwanie jest reakcją na asynchroniczne zdarzenie. Polega na automatycznym zapamiętaniu bieżącego stanu (kontekstu) procesora, w celu jego późniejszego odtworzenia, oraz przekazania sterowania do określonej procedury obsługi przerwania.

Źródła przerwań:
  - zewnętrzne (od urządzeń zewnętrznych) - zgłaszane przez urządzenia I/O po zakończeniu pracy, w tym też przez urządzenia blisko współpracujące z procesorem, np. czasomierz, układ DMA
  - programowe (wywołanie specjalnej instrukcji) - na procesorach x86 jest to **int**, na PowerPC **sc** (systemcall).
  - diagnostyczne (pułapki, błędy programowe i sprzętowe) - generuje je procesor, jeżeli wejdzie w odpowiedni stan (są skutkiem wykonania określonego ciągu rozkazów, który prowadzi do osiągnięcia tego stanu). Przykłady:
    - pułapki pojawiające się, jeżeli IC (licznik rozkazów) osiągnie odpowiednią wartość (używają tego debuggery)
    - błędy programowe, typu błąd dzielenia przez zero, naruszenie ochrony pamięci, nieprawidłowy format rozkazu procesora itd. W reakcji na to przerwanie jądro najczęściej usuwa proces
    - błędy sprzętowe, np. brak strony. Jądro musi doprowadzić system do takiego stanu, żeby wznowienie rozkazu nie spowodowało ponownie błędu

Rodzaje przerwań:
  - maskowalne (można je zignorować): procesor musi mieć przynajmniej jedno takie wejście
  - niemaskowalne (nie można ich zignorować): procesor ma jedno takie wejście

Ochrona pamięci polega na tym, że definiuje się pewne zakresy adresów, na których mogą operować programy. Jeżeli poza ten zakres się wykroczy, wtedy generowane jest przerwanie diagnostyczne z powodu naruszenia ochrony pamięci. Ważne, żeby chronić nie tylko pamięć jądra, ale też procesów przed wzajemną ingerencją.

Przerwanie zegarowe jest generowane przez czasomierz. Ustawia mu się pewną wartość inicjalną i co określony interwał czasu jest ona dekrementowana. W momencie osiągnięcia wartości zero generowane jest przerwanie zegarowe. Pozwala ono synchronizować pracę systemu i realizować jego okresowe zadania, polegające na wywłaszczaniu zadań.



