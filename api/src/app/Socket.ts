import * as socket from 'socket.io'


export default function (http, corsOptions) {
    var io = new socket.Server(http, {
        cors: corsOptions
    });
    io.on('connection', (s) => {
        console.log(s);
        s.emit('reverd', 'REVEEEEEEERD ALERT')
        s.disconnect();
    })
}