import QtQuick 2.5
import QtQuick.Window 2.2
import QtWebSockets 1.0
import QtQml.StateMachine 1.0

Window {
    visible: true
    QtObject {
        id: ev
        signal toExit
    }

    WebSocket {
        id: socket
        url: "ws://localhost:3000/"
    }


    StateMachine {
        id: stateMachine
        initialState: running
        running: true
        signal toExit
        State {
            id: running
            onEntered: console.log("entry")
            SignalTransition {
                targetState: exit
                signal: ev.toExit
            }
        }
        State {
            id: exit
            onEntered: {
                console.warn("exiting");
                Qt.quit();
            }
        }
    }

    MainForm {
        anchors.fill: parent
        mouseArea.onClicked: {
            ev.toExit();
        }
    }
}
