#include <QObject>
#include "LoginAuth.hpp"

class AppController : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(bool remember READ remember WRITE setRemember NOTIFY rememberChanged)


public:
    AppController(QObject *parent = nullptr);

    Q_INVOKABLE void login(QString email, QString password);
    Q_INVOKABLE void setRemember(bool value);

signals:
    void rememberChanged();
    void loginSuccessful();

private:
    LoginAuth loginAuth;

};
