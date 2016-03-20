import QtQuick 2.5
import QtQuick.Window 2.2
import QtQml.StateMachine 1.0
import QtWebSockets 1.0
import "imp.js" as P

WebSocket {
    id: socket
    url: "ws://localhost:3000"

    onTextMessageReceived: {
        P.parseServerResponse(message, events);
    }

    onStatusChanged: {
        console.log("Status:" + socket.status)
        if (socket.status == WebSocket.Error) {
            console.log("Error: " + socket.errorString)
        } else if (socket.status == WebSocket.Open) {
            events.serverConnected();
        } else if (socket.status == WebSocket.Closed) {
            console.log("Conencion closed")
        }
    }
    active: false
}
