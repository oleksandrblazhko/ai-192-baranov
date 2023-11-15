1. Створіть у БД структури даних, необхідні для роботи повноважного керування доступом.

![1](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/00d5495a-b4cc-4212-a131-cc0b3abf19ac)

![1-2](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/66d8ce3d-5e28-4941-99e2-4691ef181ca4)

![1-3](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/8c80e720-c454-478c-8d38-335d5654fe3d)

![1-4](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/c02648f7-09dd-45a5-8948-0d91541dcd31)

2. Додайте до таблиці з даними стовпчик, який буде зберігати мітки конфіденційності. Визначте для кожного рядка таблиці мітки конфіденційності, які будуть різнитися (для кожного рядка своя мітка).

![2](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/40d70b89-9bbc-48b8-b2a3-e94bfdea5309)

3. Визначте для користувача його рівень доступу.

![3](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/c1f11fe2-30b8-4221-84eb-885d568b5b3a)

4. Створіть нову схему даних, назва якої співпадає з назвою користувача.

![4](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/7e189f47-46c0-4b3a-8a1c-18aa45b89b41)

5. Створіть віртуальну таблицю, назва якої співпадає з назвою реальної таблиці та яка забезпечує SELECT-правила повноважного керування доступом для користувача.

![5](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/6b8f7842-6858-46de-b63f-76c315a76aee)

6. Створіть INSERT/UPDATE/DELETE-правила повноважного керування доступом для користувача.

INSERT

![insert_rule](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/3372315f-b156-4b3b-8848-57153217f4fb)

UPDATE

![update_rule](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/31d62de9-574f-40fb-8eac-db537247e633)

DELETE

![delete_rule](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/0cfdd260-7a60-4c23-b015-ec37d5a7e768)

7. Встановіть з’єднання з СКБД від імені нового користувача.

![7](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/ae7c45f2-ec73-43f2-834f-2baa9659cff3)

8. Від імені нового користувача перевірте роботу механізму повноважного керування, виконавши операції SELECT, INSERT, UPDATE, DELETE

<br>Для початку змінемо значення стовпця "spot_conf" на 2 для того щоб користувач baranov міг їх побачити.

![8](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/520c5f9d-0f87-493d-aaf6-a2faf483be38)

SELECT

![select_res](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/9aa2470a-0250-4ad8-a3c7-61de64ec1141)

INSERT

Як бачимо, користувач baranov не бачить нового запису, адже мітка конфіденційності нового запису більша, ніж у користувача.

![insert_res](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/6a7170bf-98a3-4447-bbad-25b637b6187b)

Якщо виконати запит на перегляд таблиці від коритсувача postgres то бачимо що новий запис було успішно внесено в таблицю.

![insert_res1](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/f3f8523d-60d5-423d-8f12-cba649679c8d)



UPDATE

![update_res](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/8d105cac-a3f0-43d6-a48b-3c0277d03f02)

DELETE

![delete_res](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/0071308a-d8a6-40d0-8ee7-02b3676b4170)
