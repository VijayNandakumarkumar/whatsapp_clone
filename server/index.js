const { response } = require("express");
const express = require("express");
const http = require("http");
const app = express();
const port = process.env.PORT || 5000;
var server = http.createServer(app);
var io = require("socket.io")(server);


app.use(express.json());
// app.request(cors());
var clients = {};

io.on("connection", (socket) =>{
     console.log("Connected");
     socket.on("text", (msg) => {
         console.log(msg);
     });
     socket.on("signin", (id) => {
        clients[id] = socket;
    });
     socket.on("message", (msg) => {
        console.log(msg);
        let targetId = msg.targetId;
        if (clients[targetId]) {
            console.log("Target is present");
            clients[targetId].emit("message", msg.message);
        } else {
            console.log("Target is not present");
        }
    });
} );

app.route("/check").get((request, response) => {
    return response.json("Your app is running successfully.")
});

server.listen(port, "0.0.0.0", () => {
    console.log("Server started");
});
