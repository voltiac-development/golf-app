import * as socket from 'socket.io'


export default function (http, corsOptions) {
    var io = new socket.Server(http, {
        cors: {
            origin: "*",
            methods: ["GET", "POST"]
        }
    });
    io.on('connection', (s) => {
        console.log(s);
        s.emit('reverb', 'REVEEEEEEERD ALERT')
        // s.disconnect();
    })
}