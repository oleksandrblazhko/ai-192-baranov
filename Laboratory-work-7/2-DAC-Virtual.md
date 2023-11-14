1. Заповніть таблицю БД ще трьома рядками.

![1](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/596960d8-783b-455d-ae84-c35eaf7179a5)

2. Створіть схему даних користувача, назва якої співпадає з назвою користувача, та створіть віртуальну таблицю у цій схемі з правилами вибіркового керування доступом для користувача так, щоб він міг побачити тільки деякі з рядків таблиці з урахуванням одного значення її останнього стовпчика.

<br>Було створено роль "class_master" та надано їй права на виконання команд у таблиці "pupil".

![2](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/26515c05-222d-448a-9746-e62f01701aee)

Надано роль "class_master" користувачу baranov.

![3](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/b59b9302-b219-47f8-8593-d8c64b56cdc8)

Створено спеціальну таблицю "ROLE2PUPIL", надано доступ до неї усім користувачам та внесено до неї дані. Створено схему "baranov" та зроблено користувача baranov її власником.

![4](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/80a817c6-2384-4e54-bdb3-51beecd039b2)

Створено віртуальну таблицю контролю ролей RBAC-моделі.

![5](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/b7221cf4-0ac9-47df-a285-d03348238dfc)

3. Встановіть з’єднання з СКБД від імені нового користувача

![6](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/61718eaf-eb0d-499b-b76d-cda0ddb30d26)

4. Перевірте роботу механізму вибіркового керування, виконавши операцію SELECT до віртуальної таблиці.

<br>Як бачимо, користувач baranov має доступ лише до рядків таблиці, у яких значення останнього стовпчика таблиці (class) дорівнює 5А.

![7](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/4137e1e2-0bb0-424e-8f71-638520ff7bf0)

5. Створіть INSERT/UPDATE/DELETE-правила обробки операцій редагування віртуальної таблиці.

<br>На знімку екрана бачимо, що операції INSERT, UPDATE, DELETE виконати неможливо.

![8](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/de3ad79d-b25f-4769-ab40-24fa1d51dab7)

Тому створимо наступні правила.

INSERT

![insert_rule](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/fbd4d192-e2c5-442f-90fd-4fa4d6f0a737)

UPDATE

![update_rule](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/77fe0a22-91ad-46d6-96c8-309cf7f9ccea)

DELETE

![delete_rule](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/c6c08b98-a05c-41e0-8ff6-661b8f9c10e3)

6. Перевірте роботу механізму вибіркового керування, виконавши операції INSERT, UPDATE, DELETE до віртуальної таблиці.

INSERT

![insert_res1](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/bea796c0-b414-4758-b63a-a17f98106352)

![insert_res2](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/6e7aba6a-c187-4079-9d6e-1f6f1728e75a)

UPDATE

![update_res1](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/8e2095bf-8981-4948-b975-488868a1d128)

![update_res2](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/c690c5a1-e07d-4c07-8483-b1ac337b205f)

DELETE

![delete_res1](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/8a394c72-3626-4975-b843-d75d037dc255)

![delete_res2](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/752a6adc-a7f8-4c49-85e5-fcec0fc019ef)
