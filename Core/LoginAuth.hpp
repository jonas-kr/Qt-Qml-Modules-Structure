#ifndef LOGIN_AUTH_HPP
#define LOGIN_AUTH_HPP

#include <QObject>
#include <QNetworkAccessManager> //Network library
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrl>
#include <QJsonObject>
#include <QJsonDocument>
#include <QSettings>

class LoginAuth : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool loading READ loading WRITE setLoading NOTIFY loadingChanged)
    Q_PROPERTY(bool remember READ remember WRITE setRemember NOTIFY rememberChanged)
    // c++ code be ack MOC

public:
    Q_INVOKABLE void login(QString email, QString password); // send them to server
    Q_INVOKABLE void fetchProfile();
    Q_INVOKABLE void tryAutoLogin();

    // Q_INVOKABLE called inside Qml

    // getters and setters
    bool loading();
    void setLoading(bool value);
    bool remember();
    void setRemember(bool value);

    void storeToken();
    void clearToken();
    QString getToken();

private:
    bool m_loading = false;
    QNetworkAccessManager manager;
    QString m_token;
    bool rememberStatus = false;

signals:
    void loadingChanged();
    void loginSuccessful();
    void loginFailed();
    void rememberChanged();
    void fetchProfileSuccessful(const QString &user, const QString &email);
    void fetchProfileFailed();
};
#endif // LOGIN_AUTH_HPP
