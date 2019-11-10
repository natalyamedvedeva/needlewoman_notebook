#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtSvg>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterSingletonType(QUrl("qrc:/utils/Units.qml"), "Units", 1, 0, "Units");
    qmlRegisterSingletonType(QUrl("qrc:/utils/Styles.qml"), "Styles", 1, 0, "Styles");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
