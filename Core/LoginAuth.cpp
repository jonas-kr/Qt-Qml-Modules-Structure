#include "LoginAuth.hpp"

void LoginAuth::login(QString email, QString password)
{
    setLoading(true);
    QUrl url("http://127.0.0.1:8000/login");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject payload;
    payload["email"] = email;
    payload["password"] = password;

    QJsonDocument doc(payload);

    QNetworkReply *reply = manager.post(request, doc.toJson());

    connect(reply, &QNetworkReply::finished, this, [this, reply]()
            {
        setLoading(false);
        if(reply -> error() == QNetworkReply::NoError){
            auto json = QJsonDocument::fromJson(reply->readAll()).object();  //transform to json
            m_token = json["token"].toString();
            if(rememberStatus){
                storeToken();
            }else{
                clearToken();
            }
            emit loginSuccessful();
            qInfo()<<m_token;
        }
        else{
            emit loginFailed();
        }
        reply->deleteLater(); });
}

void LoginAuth::fetchProfile()
{
    QUrl url("http://127.0.0.1:8000/profile");
    QNetworkRequest request(url);
    request.setRawHeader("Authorization", "Bearer " + m_token.toUtf8());

    QNetworkReply *reply = manager.get(request);

    connect(reply, &QNetworkReply::finished, this, [this, reply]()
            {
                if(reply -> error() == QNetworkReply::NoError){
                    auto json = QJsonDocument::fromJson(reply->readAll()).object();  //transform to json
                    QString user = json["user"].toString();
                    QString email = json["email"].toString();
                    emit loginSuccessful();
                    emit fetchProfileSuccessful(user,email);
                  //  qInfo()<<user + " " + email;
                }
                else{
                    emit fetchProfileFailed();
                }
                reply->deleteLater(); });
}

void LoginAuth::tryAutoLogin()
{
    getToken();
    if(!m_token.isEmpty()){
        fetchProfile();
    }
}

bool LoginAuth::loading()
{
    return m_loading;
}

void LoginAuth::setLoading(bool value)
{
    if (m_loading != value)
    {
        m_loading = value;
        emit loadingChanged();
    }
}

bool LoginAuth::remember()
{
    return rememberStatus;
}

void LoginAuth::setRemember(bool value)
{
    if (rememberStatus != value)
    {
        rememberStatus = value;
        emit rememberChanged();
    }
}

void LoginAuth::storeToken()
{
    QSettings token;
    token.setValue("auth/token", m_token);
}

void LoginAuth::clearToken()
{
    QSettings token;
    token.clear();
}

QString LoginAuth::getToken()
{
    QSettings token;
    return token.value("auth/token", "").toString();
}
