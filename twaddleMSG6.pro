TEMPLATE = app

QT += qml quick core

SOURCES += main.cpp \
    receiver.cpp \
    server/myserver.cpp \
    server/mythread.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    receiver.h \
    server/myserver.h \
    server/mythread.h
