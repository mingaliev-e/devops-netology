#!/usr/bin/env python3.8
import telebot
import requests
import os

bot_token = os.environ.get('BOT_TOKEN')

bot = telebot.TeleBot(bot_token)

zabbix_login = None
zabbix_password = None
api_token = None

zabbix_url = os.environ.get('ZABBIX_URL')


@bot.message_handler(commands=['start'])
def start_message(message):
    global zabbix_login
    global zabbix_password
    global api_token
    zabbix_login = None
    zabbix_password = None
    api_token = None
    bot.send_message(message.chat.id, "Для доступа к Zabbix API введите свой логин и пароль в формате: login:password")

@bot.message_handler(func=lambda message: True)
def check_zabbix_login_password(message):
    global zabbix_login
    global zabbix_password
    global api_token
    if ":" in message.text:
        zabbix_login, zabbix_password = message.text.split(':')
        api_token = get_api_token()
        if api_token:
            bot.send_message(message.chat.id, "API токен успешно получен!")
            main_menu(message)
        else:
            bot.send_message(message.chat.id, "Неправильный логин или пароль, попробуйте еще раз")
    else:
        bot.send_message(message.chat.id, "Для доступа к Zabbix API введите свой логин и пароль в формате: login:password")

def get_api_token():
    global zabbix_session
    global zabbix_url
    global zabbix_login
    global zabbix_password
    payload = {
        "jsonrpc": "2.0",
        "method": "user.login",
        "params": {
            "user": zabbix_login,
            "password": zabbix_password
        },
        "id": 1,
        "auth": None
    }
    try:
        response = zabbix_session.post(
            zabbix_url,
            json=payload
        )
        if response.status_code == 200:
            if 'result' in response.json():
                result = response.json()["result"]
                return result
        return None
    except requests.exceptions.RequestException:
        return None

@bot.message_handler(func=lambda message: True)
def main_menu(message):
    global api_token
    if api_token:
        keyboard = telebot.types.InlineKeyboardMarkup()
        groups = get_groups()
        if len(groups) > 0:
            for i in range(len(groups)):
                if i % 5 == 0:
                    keyboard.row()
                keyboard.add(telebot.types.InlineKeyboardButton(text=groups[i]['name'], callback_data='host_group-' + str(groups[i]['groupid'])))
            bot.send_message(message.chat.id, "Выберите группу хостов:", reply_markup=keyboard)
        else:
            bot.send_message(message.chat.id, "Не найдено ни одной группы хостов")
    else:
        check_zabbix_login_password(message)

@bot.callback_query_handler(func=lambda call: call.data.startswith('host_group-') or call.data.startswith('back_to_host_group-'))
def host_menu(call):
    global api_token
    keyboard = telebot.types.InlineKeyboardMarkup()
    groupid = call.data.split('-')[1]
    hosts = get_hosts(groupid)
    if call.data.startswith('host_group-'):
        if len(hosts) > 0:
            for i in range(len(hosts)):
                if i % 5 == 0:
                    keyboard.row()
                keyboard.add(telebot.types.InlineKeyboardButton(text=hosts[i]['name'], callback_data='host-' + str(hosts[i]['hostid']) + '-' + groupid))
                keyboard.add(telebot.types.InlineKeyboardButton(text="Назад", callback_data='back_to_host_group-'))
            bot.edit_message_text(chat_id=call.message.chat.id, message_id=call.message.message_id, text="Выберите хост:", reply_markup=keyboard)
        else:
            bot.answer_callback_query(callback_query_id=call.id, text="Для выбранной группы нет хостов")
    elif call.data.startswith('back_to_host_group-'):
        bot.answer_callback_query(callback_query_id=call.id, text="Назад")
        keyboard = telebot.types.InlineKeyboardMarkup()
        groups = get_groups()
        if len(groups) > 0:
            for i in range(len(groups)):
                if i % 5 == 0:
                    keyboard.row()
                keyboard.add(telebot.types.InlineKeyboardButton(text=groups[i]['name'], callback_data='host_group-' + str(groups[i]['groupid'])))
            bot.edit_message_text(chat_id=call.message.chat.id, message_id=call.message.message_id, text="Выберите группу хостов:", reply_markup=keyboard)
        else:
            bot.send_message(call.message.chat.id, "Не найдено ни одной группы хостов")
    else:
        return

@bot.callback_query_handler(func=lambda call: call.data.startswith('host-') or call.data.startswith('back_to_hosts-'))
def show_info(call):
    global api_token
    data = call.data.split('-')
    if call.data.startswith('host-'):
        bot.answer_callback_query(callback_query_id=call.id, text="Выбран хост " + data[1])
        # Здесь можно отправлять информацию о хосте
        keyboard = telebot.types.InlineKeyboardMarkup()
        hostid = data[1] # получаем информацию о выбранном хосте
        keyboard.add(telebot.types.InlineKeyboardButton(text="Status", callback_data='status-' + hostid)) # первая кнопка Status с параметром hostid
        keyboard.add(telebot.types.InlineKeyboardButton(text="Disable", callback_data='disable-' + hostid)) # вторая кнопка Disable с параметром hostid
        keyboard.add(telebot.types.InlineKeyboardButton(text="Enable", callback_data='enable-' + hostid)) # третья кнопка Enable с параметром hostid
        keyboard.add(telebot.types.InlineKeyboardButton(text="Triggers", callback_data='triggers-')) # третья кнопка Назад
        keyboard.add(telebot.types.InlineKeyboardButton(text="Назад", callback_data='back_to_hosts-')) # третья кнопка Назад
        bot.edit_message_text(chat_id=call.message.chat.id, message_id=call.message.message_id, text="Выберите действие для хоста:", reply_markup=keyboard)
    elif call.data.startswith('back_to_hosts'):
        bot.answer_callback_query(callback_query_id=call.id, text="Назад")
        keyboard = telebot.types.InlineKeyboardMarkup()
    else:
        return

@bot.callback_query_handler(func=lambda call: call.data.startswith('status-'))
def show_status(call):
    hostid = call.data.split('-')[1]
    status = get_host_status(hostid)
    bot.answer_callback_query(callback_query_id=call.id, text="Хост " + hostid + " " + status)

@bot.callback_query_handler(func=lambda call: call.data.startswith('disable-'))
def disable_host(call):
    hostid = call.data.split('-')[1]
    result = disable_host(hostid)
    if result:
        bot.answer_callback_query(callback_query_id=call.id, text="Хост " + hostid + " деактивирован")
    else:
        bot.answer_callback_query(callback_query_id=call.id, text="Ошибка. Хост " + hostid + " не деактивирован")

@bot.callback_query_handler(func=lambda call: call.data.startswith('enable-'))
def enable_host(call):
    hostid = call.data.split('-')[1]
    result = enable_host(hostid)
    if result:
        bot.answer_callback_query(callback_query_id=call.id, text="Хост " + hostid + " активирован")
    else:
        bot.answer_callback_query(callback_query_id=call.id, text="Ошибка. Хост " + hostid + " не активирован")

def get_host_status(hostid):
    global zabbix_session
    global zabbix_url
    payload = {
        "jsonrpc": "2.0",
        "method": "host.get",
        "params": {
            "hostids": hostid,
            "selectInterfaces": "extend"
        },
        "auth": api_token,
        "id": 1
    }
    response = zabbix_session.post(
        zabbix_url,
        json=payload
    )
    if response.status_code == 200:
        result = response.json()["result"]
        if len(result) > 0:
            status = result[0]['status']

            if status == '1':
                return "отключен"
            elif status == '0':
                return "включен"
            else:
                return "неизвестно"
        else:
            return "не найден"

def disable_host(hostid):
    global zabbix_session
    global zabbix_url
    payload = {
        "jsonrpc": "2.0",
        "method": "host.update",
        "params": {
            "hostid": hostid,
            "status": 1
        },
        "auth": api_token,
        "id": 1
    }
    response = zabbix_session.post(
        zabbix_url,
        json=payload
    )
    if response.status_code == 200:
        result = response.json()["result"]
        return True
    else:
        return False

def enable_host(hostid):
    global zabbix_session
    global zabbix_url
    payload = {
        "jsonrpc": "2.0",
        "method": "host.update",
        "params": {
            "hostid": hostid,
            "status": 0
        },
        "auth": api_token,
        "id": 1
    }
    response = zabbix_session.post(
        zabbix_url,
        json=payload
    )
    if response.status_code == 200:
        result = response.json()["result"]
        return True
    else:
        return False

def host_triggers(hostid):
    global zabbix_session
    global zabbix_url
    payload = {
        "jsonrpc": "2.0",
        "method": "trigger.get",
        "params": {
            "output": "extend",
            "hostids": hostid,
            "expandDescription": True,
            "expandExpression": True
        },
        "auth": api_token,
        "id": 1
    }
    response = zabbix_session.post(
        zabbix_url,
        json=payload
    )
    if response.status_code == 200:
        result = response.json()["result"]
        return result
    else:
        return []

def get_groups():
    global zabbix_session
    global zabbix_url
    payload = {
        "jsonrpc": "2.0",
        "method": "hostgroup.get",
        "params": {
            "output": "extend",
            "sortfield": "name"
        },
        "auth": api_token,
        "id": 1
    }
    response = zabbix_session.post(
        zabbix_url,
        json=payload
    )
    if response.status_code == 200:
        result = response.json()["result"]
        return result
    else:
        return []

def get_hosts(groupid):
    global zabbix_session
    global zabbix_url
    payload = {
        "jsonrpc": "2.0",
        "method": "host.get",
        "params": {
            "output": "extend",
            "groupids": groupid,
            "sortfield": "name"
        },
        "auth": api_token,
        "id": 1
    }
    response = zabbix_session.post(
        zabbix_url,
        json=payload
    )
    if response.status_code == 200:
        result = response.json()["result"]
        return result
    else:
        return []

if __name__ == '__main__':
    zabbix_session = requests.Session()
    zabbix_url = os.environ.get('ZABBIX_URL')
    bot.polling()
