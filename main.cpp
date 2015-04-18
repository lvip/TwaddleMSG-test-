#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDateTime>
#include "receiver.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    //QObject::connect(engine.QObject, SIGNAL(quit()), &app, SLOT(quit()));
   // Receiver receiver;
   // QQmlContext* ctx = engine.rootContext();
   // ctx->setContextProperty("receiver", &receiver);
   // engine.rootContext()->setContextProperty("currentDateTime", QDateTime::currentDateTime());
    QDateTime curD = QDateTime::currentDateTime();
    engine.rootContext()->setContextProperty("currentDateTime", curD.toString("ddd.MMMM.d.yy   HH:MM"));
    engine.load(QUrl(QStringLiteral("qrc:/main2.qml")));
    return app.exec();
}
