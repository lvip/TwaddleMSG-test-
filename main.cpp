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
    MyServer server;
    server.startServer();
    QQmlContext* ctx = engine.rootContext();
    ctx->setContextProperty("receiver", &receiver);
    ctx->setContextProperty("myserver", &server);
    engine.load(QUrl(QStringLiteral("qrc:/main2.qml")));
    return app.exec();
}
