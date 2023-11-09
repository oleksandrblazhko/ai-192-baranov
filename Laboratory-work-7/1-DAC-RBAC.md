1. Встановіть СКБД PostgreSQL, отримавши для вашої ОС інсталяційний пакет з https://www.postgresql.org/download/
2. Створіть термінальну консоль psql через утиліту командного рядка вашої ОС та встановіть з’єднання з БД postgres від імені користувача-адміністратора postgres.

![1-2](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/4eddbd0d-3da9-4b47-80aa-b8b574016f6d)

3. Зареєструйте нового користувача в СКБД PostgreSQL, назва якого співпадає з вашим прізвищем, наприклад blazhko, і довільним паролем.

![3](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/47faea5a-01a9-440a-99af-aa46ca1daca9)

4. Створіть роль в СКБД PostgreSQL (назва співпадає з вашим прізвищем латинськими літерами) і надайте новому користувачеві можливість наслідувати цю роль.

![4](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/c1fb4809-d166-4e84-a153-586583a637e4)

5. Створіть реляційну таблицю з урахуванням варіанту з таблиці 2.1 від імені користувача-адміністратора.

![5](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/a08ed6ab-a939-4286-9b57-2a0ff0e9750c)

6. Внесіть один рядок в таблицю, використовуючи команду insert into ..., відповідно до варіанту.

![6](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/ffd2f6cd-e5b8-485c-8216-ebddaf9cde3e)

7. Додатково створіть ще одну термінальну консоль psql та та встановіть з’єднання з БД postgres від імені нового користувача.

![7](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/02aa5312-1536-4bdc-808b-e225cd26ad2b)

8. Від імені нового користувача виконайте запит на отримання даних з таблиці (select * from таблиця). Запротоколюйте результат виконання команди.

![8](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/dd21aa98-b0e6-4b0b-a09e-8d881d134251)

Нам було відмовлено в доступі, адже в нового користувача немає повноваження на читання таблиці.

9. Встановіть повноваження на читання таблиці новому користувачеві.

![9](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/7aa8f2e4-5500-4f3d-bb6a-9898181c3f95)

10. Повторіть крок 8.

![10](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/f3b0439b-e18c-452c-b2a1-9358245c9832)

11. Зніміть повноваження на читання таблиці для нового користувача.

![11](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/f19cfcec-2605-4417-905c-ad5def3cc0b1)

12. Повторіть крок 8.

![12](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/339870d1-cf52-4ca5-8128-f3c47c8c5a0c)

13. Створіть команду оновлення даних таблиці (UPDATE) і виконайте її від імені нового користувача. Проаналізуйте результат виконання команди.

![13](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/1a4dd4ac-af4c-4c87-a38e-e3c454130f43)

Ми не змогли оновити дані, адже в нового користувача немає повноваження на оновлення даних таблиці. 

14. Встановіть повноваження на оновлення таблиці новому користувачу.

![14](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/1679e1df-2ce5-4083-9702-62507fced679)

15. Повторіть крок 13.

![15](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/384b6230-bdef-453e-b6a0-5bc968230324)

16. Створіть команду видалення запису таблиці (DELETE) і виконайте її від імені нового користувача. Проаналізуйте результат виконання команди.

![16](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/442c2efc-7bd4-4e1a-9acc-201857c97921)

Нам відмовили в видаленні, адже в нового користувача немає повноваження на видалення даних таблиці.

17. Встановіть повноваження на видалення таблиці новому користувачеві.

![17](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/e3849fbc-ab1f-4b03-a304-5680c7c862b3)

18. Повторіть крок 16.

![18](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/8c978096-27ff-4041-b6ce-e9fcd518d11b)

19. Зніміть всі повноваження з таблиці для нового користувача.

![19](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/1c1ea40e-4140-4a8f-8e14-a42f641d73db)

20. Створіть команду внесення запису в таблицю (INSERT) і виконайте її від імені нового користувача. Проаналізуйте результат виконання команди.

![20](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/b4783b19-60e6-461c-8dbe-dc1118dfb275)

Нам відмовили в операції запису в таблицю, адже в нового користувача немає повноваження на запис у таблицю.

21. Встановіть повноваження на внесення даних до таблиці для ролі.

![21](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/6db111f7-fd15-4044-93ce-289b7af4170d)

22. Повторіть крок 20.

![22](https://github.com/oleksandrblazhko/ai-192-baranov/assets/56040804/5c38dc68-c9ae-471c-bb8b-0f4a409d283f)

