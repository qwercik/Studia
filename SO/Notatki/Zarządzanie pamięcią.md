---
tags: [SO wykład]
title: 9. Zarządzanie pamięcią
created: '2020-09-04T14:47:56.117Z'
modified: '2020-09-04T16:08:39.315Z'
---

# Zarządzanie pamięcią

## Problematyka
Ten wykład zajmuje się problematyką organizacji pamięci operacyjnej w systemie operacyjnym.

Pamięć jest podstawowym zasobem, jest hierarchiczna. Zarządzanie pamięcią jest wsparte na poziomie architektury komputera. W tym wykładzie omówiono metody organizacji pamięci i przydzielania jej procesom.

Na szczególną uwagę zasługuje ochrona pamięci, by jeden proces nie mógł modyfikować, ani nawet przeglądać pamięci drugiego procesu (mógłby w przeciwnym wypadku podejrzeć np. hasło wpisywane w przeglądarce), a tym bardziej pamięci jądra.

Pamięć jest przyznawana poszczególnym procesom, ale musi również zostać odzyskana.

## Hierarchia pamięci
Z hierarchią pamięci związana jest *zasada okna*, zgodnie z którą dane na wyższym (szybszym i jednocześnie mniej pojemnym) poziomie stanowią fragment danych przechowyanych na niższym poziomie.

## Przestrzeń adresowa
Przestrzeń adresowa to zbiór wszystkich poprawnych adresów w pamięci. Wyróżniamy:
  - przestrzeń fizyczną - zbiór adresów przekazywanych do układów pamięci głównej (fizycznej)
  - przestrzeń logiczną - zbiór adresów generowanych przez procesor w kontekście aktualnie wykonywanego procesu

Adresy fizyczne są przekazywane szyną adresową magistrali systemowej do układów elektronicznych pamięci. Adresy logiczne trafiają do jednostki MMU, która dokonuje ich transformacji (przekształca na adres fizyczny). Jednostka MMU jest ściśle powiązana z procesorem.

Adresy przechowywane w rejestrach, wykorzystywane w różnych trybach adresowych (pośrednim, bazowym, indeksowym), czy w liczniku programu (IP) są adresami logicznymi.

W najprostszym przypadku transformacja adresu polega na dodaniu do adresu logicznego pewnej wartości, znajdującej się w rejestrze przemieszczenia MMU. W praktyce nie jest to jednak takie proste, gdyż trzeba zawsze sprawdzić, czy adres logiczny jest z poprawnego zakresu, aby dany proces nie ingerował w obszar innego procesu. Z reguły wystarczy jednak sprawdzić górny limit, gdyż dolny to 0, czyli naturalny ogranicznik. Gdy MMU wykryje niepoprawny adres, zgłasza przerwanie diagnostyczne.

## Podział pamięci
Pamięć można podzielić na następujące sposoby.

### Podział stały
Przydzielane jednostki są odgórnie wyznaczane na etapie konfiguracji systemu. Jest to łatwe w implementacji i zarządzaniu, ale mało efektywne (fragmentacja wewnętrzna).

Problemem jest też możliwa chęć zażądania od systemu większego obszaru, niż udostępniony w wyniku podziału. W przypadku danych można to przewidzieć wcześniej i dostosować struktury danych, a w przypadku programu można zastosować technikę nakładkowania (podział kodu na niezależne części i wymiana jednej z nich w miarę potrzeb). W programie wydziela się część stałą i nakładki, które wiąże się w tzw. sekcję nakładkowania.

Z nakładkami wiążą się jednak ograniczenia. Stan nakładki usuwanej z pamięci nie jest nigdzie zapisywany, nie może ona więc ulegać zmianie (może zawierać tylko kod i ewentualnie stałe), Ograniczone są możliwości przekazywania danych. Podział na nakładki wymaga dokładnej znajomości kodu i przepływu sterowania. Nakładkowanie jest trudne do zrealizowania i należy do autora programu, nie do autora jądra.

### Podział dynamiczny
Jednostki są definiowane z pewną dokładnością, stosowanie do potrzeb. Dzięki temu niwelujemy znaczenie fragmentacji wewnętrznej, jednak czyni to pamięć trudniejszą do zarządzania.

Tak zwany paragraf to 16 bajtów.

Przy podziale dynamicznym pojawia się problem wyboru bloku. Można go rozwiązać na kilka sposobów:
  - first fit - przydziela się pierwszy wolny obszar, który ma dziurę o wystarczającej wielkości
  - best fit - przydziela się najmniejszy dostatecznie duży wolny obszar
  - next fit - podobny jak first fit, ale poszukiwania rozpoczynamy od miejsca ostatniego przydziału
  - worst fit - przydziela się największy wolny obszar pamięci - rzadko się stosuje, ale dzięki temu pozostawiamy stosunkowo duże wolne obszary (zarządzanie małymi obszarami jest często nieefektywne)


### Bloki bliźniacze (buddy)
Podział na bloki bliźniacze jest rozwiązaniem pośrednim pomiędzy podziałem statycznym a dynamicznym i polega na połowieniu większych (zbyt dużych) obszarów na mniejsze (o równej wielkości)

Z podziałem pamięci wiąże się pojęcie fragmentacji:
  - wewnętrzna - pozostawienie niewykorzystywanego fragmentu przestrzeni adresowej wewnatrz przydzielonego obszaru (formalnie jest zajęty, a faktycznie niewykorzystany)
  - zewnętrzna - podział obszaru pamięci na rozłączne fragmenty, które nie stanowią ciągłości w przestrzeni adresowej (dotyczy zarówno wolnych, jak i zajętych bloków)

## Obraz procesu w pamięci
Tworzenie obrazu procesu rozpoczyna się od programu źródłowego, który jest kompilowany do przemieszczalnego modułu wynikowego, a następnie łączony (konsolidowany) z modułami bibliotecznymi, do których są odwołania w kodzie. Konsolidację można jednak odłożyć do czasu ładowania, a nawet wykonywania kodu. Konsolidacja przed ładowaniem określana jest jako statyczna; w czasie ładowania lub wykonania - dynamiczna.

Każdemu etapowi tworzenia obrazu procesu w pamięci towarzyszy odpowiednie przekształcanie adresów, począwszy od etykiet i innych symboli, a skończywszy na fizycznych adresach komórek pamięci. W wyniku takiej translacji powstaje przemieszczalny moduł wynikowy, w którym wszystkie adresy są liczone względem adresu początku modułu.

W konsolidacji statycznej wszystkie przemieszczalne moduły są łączone w jeden program ładowalny (moduł absolutny), a do adresów przemieszczalnych są dodawane wartości, wynikające z przesunięcia danego modułu względem początku modułu absolutnego. Gdyby lokalizacja programu w pamięci była znana, na tym etapie mogłyby zostać wygenerowane adresy fizyczne, ale tak nie jest.

Kod może być ładowany na kilka sposobów:
  - absolutnie - program ładowany jest w ustalone miejsce w pamięci, znane w momencie tworzenia programu
  - relokowalne - fizyczna lokalizacja procesu ustalana jest przy ładowaniu do pamięci
  - dynamiczne - fizyczna lokalizacja może ulec zmianie w czasie wykonywania

## Inne

Pamięć może być niekiedy współdzielona w celu poprawy efektywności lub przekazywania informacji pomiędzy procesami (dostep do wspólnego obszaru pamięci, za pośrednictwem którego procesy przekazują sobie sygnały).

Pamięć musi być chroniona, zarówno pod względem poprawności adresu, jak i pod względem praw: zapisu, odczytu i wykonania.

## Stronnicowanie
Arbitralny podział pamięci fizycznej na ramki, w które są ładowane odpowiednie strony obrazu procesu. Zalety to brak problemu fragmentacji zewnętrznej i wspomaganie współdzielenia oraz ochrony pamięci. Wady to narzut czasowy i pamięciowy oraz niewielka fragmentacja wewnętrzna.

W systemach ze stronnicowaniem, adres logiczny składa się z dwóch części: numeru strony oraz przesunięcia wewnątrz strony. Numer strony jest mapowane później na adres ramki, przesunięcie się nie zmienia. Po mapowaniu uzyskujemy adres fizyczny, odpowiadający logicznemu.

Mapowanie to znajduje się w tzw. tablicy stron. Odwoływanie się do pamięci jest jednak kosztowne, więc wymyślono specjalną, szybką pamięć asocjacyjną, zwaną buforami TLB, w której ostatnio przechowuje się pobrane wpisy z tablicy stron. Kluczem jest numer strony, a wartością numer ramki.

Można zastosować stronnicowanie wielopoziomowe, w którym tablica stron jest przechowywana na wielu stronach.

## Segmentacja
Stronnicowanie jest oparte na stałym podziale pamięci, a segmentacja na dynamicznym. Obraz procesu dzielony jest na logiczne części, odpowiadające poszczególnym sekcjom programu (kod, dane, stos). Dla każdej z nich definiujemy osobny segment.

Każdy segment opisywany jest przez adres bazowy (początkowy), rozmiar, atrybuty (flaga tylko do odczytu, pierścień ochrony itd.), identyfikator.

Koniecznie należy sprawdzać, czy adres odwołuje się do odpowiedniego segmentu (np. czy nie próbujemy wykonywać kodu z segmentu danych albo stosu). Jeżeli wszystko jest poprawne, można dodać adres bazowy i uzyskać adres fizyczny. Jeżeli coś jest nie tak, zostanie wygenerowane przerwanie diagnostyczne.

Zalety stronicowania i segmentacji można z powodzeniem łączyć. W takim podejściu, pamięć traktujemy jako zbiór segmentów, które składają się z ramek. Przesunięcie względem segmentu traktujemy jako adres w pamięci stronnicowanej, czyli adres składający się z numeru strony i przesunięcia wewnątrz strony.


