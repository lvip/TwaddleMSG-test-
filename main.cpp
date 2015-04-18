#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "receiver.h"
#include "server/myserver.h"



int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //QObject::connect(engine.QObject, SIGNAL(quit()), &app, SLOT(quit()));
    Receiver receiver;
    QQmlContext* ctx = engine.rootContext();
    ctx->setContextProperty("receiver", &receiver);
    engine.load(QUrl(QStringLiteral("qrc:/main2.qml")));
    MyServer server;
    server.startServer();
    return app.exec();
}
