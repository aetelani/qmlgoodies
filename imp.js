.pragma library

function connectToServer(socket) {
    console.log("connecting to server")
    socket.active = true;
}

function connectToGame(socket) {
    socket.sendTextMessage('{"type": "join","teamName": "TeamAhma"}')
    console.log("connect send")
}

function serverConnected(ev) {
   ev.serverConnected();
}

function exitGame() {
    Qt.quit();
    console.log("Daisy, Daisy, give me your answer do. I'm half crazy all for the love of you. It won't be a stylish marriage, I can't afford a carriage. But you'll look sweet upon the seat of a bicycle built for two.");
}

function parseServerResponse(message, ev) {
    var res = JSON.parse(message);
    switch(res.type) {
    case "connected":
        ev.gameConnected();
        break;
    case "start":
        ev.setupGame(res);
        break;
    case "events":
        ev.gameEvent(message)
        break;
    case "end":
        ev.exitGame();
        break;
    case "error":
        console.log(message)
        break;
    default: console.log("unkown resp:"); console.log(message);
    }
}

