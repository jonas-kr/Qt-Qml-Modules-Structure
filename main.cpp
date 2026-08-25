#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFont>

using namespace Qt::StringLiterals;

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setApplicationName("DashboardApp");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("DashboardApp");

    QQmlApplicationEngine engine;

    engine.loadFromModule("UI", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
