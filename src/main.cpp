#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>

int main(int argc, char *argv[]){
    QGuiApplication app(argc, argv);
    QGuiApplication::setOrganizationName("MayOS");
    QGuiApplication::setApplicationName("Clock");
    QGuiApplication::setWindowIcon(QIcon::fromTheme("applications-development"));
    app.setWindowIcon(QIcon(":/images/icon.png"));
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/Main.qml")));
    if (engine.rootObjects().isEmpty()) return -1;

    return app.exec();
}