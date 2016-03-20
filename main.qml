import QtQuick 2.5
import QtQuick.Window 2.2
import QtQml.StateMachine 1.0
import QtWebSockets 1.0
import "imp.js" as P

Window {
    visible: true
    Socket {
        id: socket
    }
    Events {
        id: events
    }

    Game {
        id: game
    }

    MainForm {
        anchors.fill: parent
        mouseArea.onClicked: {
            Qt.quit();
        }
    }
}
