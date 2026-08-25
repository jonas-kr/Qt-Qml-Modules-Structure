#include "AppController.hpp"

AppController::AppController(QObject *parent)
{
    connect(&loginAuth, &LoginAuth::rememberChanged, this , &AppController::rememberChanged);
    connect(&loginAuth, &LoginAuth::loginSuccessful, this , &AppController::loginSuccessful);
}

void AppController::login(QString email, QString password)
{
    loginAuth.login(email,password);
}

void AppController::setRemember(bool value)
{
    loginAuth.setRemember(value);
}
