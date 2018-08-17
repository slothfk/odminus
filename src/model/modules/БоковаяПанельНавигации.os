
Функция ОписаниеПанели() Экспорт

	Описание = Новый ДеревоЗначений;
	Описание.Колонки.Добавить("Тип");
	Описание.Колонки.Добавить("Активность", Новый ОписаниеТипов("Булево"));
	Описание.Колонки.Добавить("Адрес", Новый ОписаниеТипов("Строка"));
	Описание.Колонки.Добавить("Текст", Новый ОписаниеТипов("Строка"));

	Возврат Описание;

КонецФункции

Функция ДобавитьСсылку(Знач Описание, Знач Адрес, Знач Текст, Знач Активна = Ложь) Экспорт
	Стр = Описание.Строки.Добавить();
	Стр.Тип = ТипыЭлементовПанели().Ссылка;
	Стр.Адрес =Адрес;
	Стр.Текст = Текст;
	Стр.Активность = Активна;
	Возврат Стр;
КонецФункции

Функция ТипыЭлементовПанели() Экспорт
	Возврат Новый Структура("Ссылка,Разделитель", "Ссылка","Разделитель");
КонецФункции

Функция СформироватьНавигацию(Знач Маршрутизатор) Экспорт
	
	Описание = ОписаниеПанели();

	ПутьТекущегоЗапроса = Маршрутизатор.ЗапросHttp.Путь + Маршрутизатор.ЗапросHttp.СтрокаЗапроса;
	
	Если Маршрутизатор.ЗначенияМаршрута["controller"] = "agent-admins" Или Маршрутизатор.ЗначенияМаршрута["controller"] = "clusters" Тогда
		ДобавитьСсылкуАгента(Описание, Маршрутизатор, "clusters", "Кластеры серверов", ПутьТекущегоЗапроса);
		ДобавитьСсылкуАгента(Описание, Маршрутизатор, "agent-admins", "Администраторы", ПутьТекущегоЗапроса);
	Иначе
		Кластер = ИдентификаторКластера(Маршрутизатор.ЗапросHttp);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "cluster","Обзор кластера", ПутьТекущегоЗапроса);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "infobase","Информационные базы", ПутьТекущегоЗапроса);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "server","Рабочие серверы", ПутьТекущегоЗапроса);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "admins","Администраторы", ПутьТекущегоЗапроса);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "manager","Менеджеры кластера", ПутьТекущегоЗапроса);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "process","Рабочие процессы", ПутьТекущегоЗапроса);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "session","Сеансы", ПутьТекущегоЗапроса);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "connection","Соединения", ПутьТекущегоЗапроса);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "lock","Блокировки", ПутьТекущегоЗапроса);
		ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, "profile","Профили безопасности", ПутьТекущегоЗапроса);
	КонецЕсли;

	Возврат Описание;

КонецФункции

Процедура ДобавитьСсылкуАгента(Описание, Маршрутизатор, ИмяКонтроллера, Текст, ПутьТекущегоЗапроса)
	ПараметрыСсылки = Новый Структура;
	ПараметрыСсылки.Вставить("controller",ИмяКонтроллера);
	Строка = БоковаяПанельНавигации.ДобавитьСсылку(Описание, Маршрутизатор.АдресМаршрута("ПоАгенту", ПараметрыСсылки), Текст);
	Если Строка.Адрес = ПутьТекущегоЗапроса Тогда
		Строка.Активность = Истина;
	КонецЕсли;
КонецПроцедуры

Процедура ДобавитьСсылкуКластера(Описание, Кластер, Маршрутизатор, ИмяКонтроллера, Текст, ПутьТекущегоЗапроса)
	
	ПараметрыСсылки = Новый Структура;
	ПараметрыСсылки.Вставить("controller",ИмяКонтроллера);
	ПараметрыСсылки.Вставить("cluster"   ,Кластер);
	Строка = ДобавитьСсылку(Описание, Маршрутизатор.АдресМаршрута("ПоАгенту", ПараметрыСсылки), Текст);
	Если Строка.Адрес = ПутьТекущегоЗапроса Тогда
		Строка.Активность = Истина;
	КонецЕсли;

КонецПроцедуры

Функция ИдентификаторКластера(ЗапросHttp)
	Параметры = ЗапросHttp.ПараметрыЗапроса();
	Возврат Параметры["cluster"];
КонецФункции