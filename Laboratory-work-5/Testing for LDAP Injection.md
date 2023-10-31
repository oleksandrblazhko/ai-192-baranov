## Тестування на LDAP ін'єкцію
| ID |
|:-:|
| WSTG-INPV-06 |

### Короткий опис

Полегшений протокол доступу до каталогів (LDAP) використовується для зберігання інформації про користувачів, хости та багато інших об'єктів. [Ін'єкція LDAP](https://wiki.owasp.org/index.php/LDAP_injection) - це атака на стороні сервера, яка може дозволити розкрити, змінити або вставити конфіденційну інформацію про користувачів та хости, представлену в структурі LDAP. Це відбувається шляхом маніпуляцій з вхідними параметрами, які потім передаються внутрішнім функціям пошуку, додавання та модифікації.

Веб-додаток може використовувати LDAP, щоб дозволити користувачам автентифікуватися або шукати інформацію інших користувачів всередині корпоративної структури. Метою атак на LDAP-ін'єкції є введення метасимволів пошукових фільтрів LDAP у запит, який буде виконуватися додатком.

[Rfc2254](https://www.ietf.org/rfc/rfc2254.txt) визначає граматику побудови пошукового фільтра на LDAPv3 і розширює [Rfc1960](https://www.ietf.org/rfc/rfc1960.txt) (LDAPv2).

Пошуковий фільтр LDAP будується в польській нотації, також відомій як [польська префіксна нотація](https://en.wikipedia.org/wiki/Polish_notation).

Це означає, що псевдокод умови для пошукового фільтра виглядає наступним чином:
``` 
find("cn=John & userPassword=mypass")
```
буде представлена як:
``` 
find("(&(cn=John)(userPassword=mypass))")
```
Булеві умови і групові об'єднання в фільтрі пошуку LDAP можуть бути застосовані за допомогою наступних метасимволів:
| Метасимвол | Значення |
|:-:|:-:|
| & | Булеве І |
| &#124; | Булеве АБО |
| ! | Булеве НЕ |
| = | Дорівнює |
| ~= | Приблизно |
| >= | Більше, ніж |
| <= | Менше, ніж |
| * | Будь-який символ |
| () | Дужки для групування |

Більш повні приклади побудови фільтру пошуку можна знайти у відповідному RFC.
Успішна експлуатація LDAP ін'єкційної уразливості може дозволити тестувальнику:
- Отримати доступ до несанкціонованого вмісту
- Уникнути обмежень додатку
- Збирати несанкціоновану інформацію
- Додати або змінити об'єкти в структурі дерева LDAP.

### Цілі тестування

- Визначити точки ін'єкції LDAP.
- Оцінити серйозність ін'єкції.

### Як протестувати
#### Приклад 1: Пошукові фільтри
Припустимо, що у нас є веб-додаток, який використовує фільтр пошуку, як показано нижче:
``` 
searchfilter="(cn="+user+")"
```
який викликається HTTP-запитом на кшталт цього:
``` 
http://www.example.com/ldapsearch?user=John
```
Якщо значення `John` замінити на `*`, відправивши запит
``` 
http://www.example.com/ldapsearch?user=*
```
фільтр буде виглядати так:
``` 
searchfilter="(cn=*)"
```
який відповідає кожному об'єкту з атрибутом 'cn', що дорівнює будь-чому.

Якщо програма вразлива до LDAP-ін'єкцій, вона відобразить деякі або всі атрибути користувача, в залежності від потоку виконання програми та дозволів користувача, який підключився через LDAP.

Тестувальник може використовувати метод спроб і помилок, вставляючи в параметр `(`, `|`, `&`, `*` та інші символи, щоб перевірити програму на наявність помилок.

#### Приклад 2: Вхід в систему
Якщо веб-додаток використовує LDAP для перевірки облікових даних користувача під час входу в систему і є вразливим до LDAP-ін'єкцій, можна обійти перевірку автентичності, ввівши завжди істинний LDAP-запит (подібно до SQL- та XPATH-ін'єкцій).

Припустимо, що веб-додаток використовує фільтр для пошуку пари LDAP-користувач/пароль.
``` 
searchlogin= "(&(uid="+user+")(userPassword={MD5}"+base64(pack("H*",md5(pass)))+"))";
```
Використовуючи наступні значення:
``` 
user=*)(uid=*))(|(uid=*
pass=password
```
фільтр пошуку видасть наступний результат:
``` 
searchlogin="(&(uid=*)(uid=*))(|(uid=*)(userPassword={MD5}X03MO1qnZdYdgyfeuILPmQ==))";
```
що є правильним і завжди істинним. Таким чином, тестувальник отримає статус першого користувача в дереві LDAP.