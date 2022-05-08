# Игра Alias (Командный челлендж по Swift марафону)
## Description
- [x] Минимум 4 экрана. (Главный экран, экран с правилами, экран выбора тематики карточек, экран отгадывания слов)
- [x] Слова появляющиеся на экране не должны повторяться минимум в течении 4х раундов которые длятся по одной минуте, минимум 60 слов без повтора.
- [x] На экране отгадывание слов должен быть таймер обратного отчёта (1 минута)
- [x] На экране отгадывания слов должно быть минимум 3 кнопки ( «Правильно», «Пропустить», «Сбросить» в случае правильного ответа + 1 бал, в случае если игрок пропускает – 1 бал. После правильного ответа и пропуска слова должен проигрываться звук, на каждой кнопке разный.
- [x] Еще случайно должно выпадать слово - действие за которое игрок либо получает 3 балла если выполняет, либо теряет если отказывается.
- [x] Экран выбора карточек должен содержать минимум 4 категории слов на ваше усмотрение
- [x] Приложение должно быть написано по модели MVC
- [x] После каждого раунда на экране должна отображаться шутка. Парсить отсюда [https://joke.deno.dev](https://joke.deno.dev/)
## Architecture
MVC + Coordinator + DIContainer (swinject)
## Frameworks
- UIKit
- SwipeCellKit
- Swinject

## Setup
```
$ cd .../AliasApp/
$ pod install
```
---
<img width="180" alt="Screenshot 2022-05-08 at 11 57 12" src="https://user-images.githubusercontent.com/16288991/167289551-e625833d-fd2e-4b22-bebe-8f76391dec70.png"><img width="180" alt="Screenshot 2022-05-08 at 11 57 14" src="https://user-images.githubusercontent.com/16288991/167289549-79422089-2c29-4d35-acba-35163fb14910.png"><img width="180" alt="Screenshot 2022-05-08 at 11 57 17" src="https://user-images.githubusercontent.com/16288991/167289548-7dc453cb-c5c7-4740-a644-7de7330c69b8.png"><img width="180" alt="Screenshot 2022-05-08 at 11 57 20" src="https://user-images.githubusercontent.com/16288991/167289546-73fc2c6a-113e-4110-91c2-65e6ddf54ab0.png">

<img width="180" alt="Screenshot 2022-05-08 at 11 57 30" src="https://user-images.githubusercontent.com/16288991/167289544-9e343856-61fd-44ba-86c3-4744a2f062da.png"><img width="180" alt="Screenshot 2022-05-08 at 11 57 38" src="https://user-images.githubusercontent.com/16288991/167289543-aa295102-a806-45c3-b24b-2e5f9367a619.png"><img width="180" alt="Screenshot 2022-05-08 at 11 58 19" src="https://user-images.githubusercontent.com/16288991/167289542-5b168094-97a6-4bd5-a674-eac821b1eac6.png"><img width="180" alt="Screenshot 2022-05-08 at 12 00 22" src="https://user-images.githubusercontent.com/16288991/167289540-43c3fe90-c98c-4510-b4a2-30bc12ea6ef1.png">
