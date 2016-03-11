import QtQuick 2.5
import QtQuick.Window 2.2
import QtWebSockets 1.0
import QtQml.StateMachine 1.0

Window {
    visible: true
    QtObject {
        id: ev
        // Game control events
        signal toExit
        signal join

        // Game basic events
        signal actions
        signal move
        signal radar
        signal cannon

        // bOt modes
        signal flee
        signal attack
        signal patrol

        // Fleet modes
        signal teamAttack
    }

    WebSocket {
        id: socket
        url: "ws://echo.websocket.org"

        onTextMessageReceived: {
            var response = JSON.parse(message);
            console.log(response.type + ":" + response.teamName)
        }
        onStatusChanged: {
            console.log("Status:" + socket.status)
            if (socket.status == WebSocket.Error) {
                 console.log("Error: " + socket.errorString)
             } else if (socket.status == WebSocket.Open) {
                 socket.sendTextMessage('{"type": "join","teamName": "ATeam"}')
                 console.log("Send ping")
             } else if (socket.status == WebSocket.Closed) {
                 console.log("Connection Closed")
             }
        }
        active: true
    }

    StateMachine {
        id: sm
        initialState: running
        running: true
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
