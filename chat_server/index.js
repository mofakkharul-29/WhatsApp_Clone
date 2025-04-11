const express = require('express');
var http = require('http');
const { userInfo } = require('os');
const port = process.env.PORT || 5000;
// const cors = require('cors');

const app = express();
var server = http.createServer(app);
var io = require('socket.io')(server);
var userSockets = {};

// middle ware
app.use(express.json());
// app.use(cors());

io.on('connection', (socket) =>{
    console.log(`Client connected with socket id: ${socket.id}`);

    socket.on('register_user', (data) =>{
      const {senderId, userId} = data;
        userSockets[userId] = {socketId: senderId, personalUserId: userId};
        console.log(userSockets);
        
    });

    socket.on("send_message", (data, callback) => {
      const { senderId, receiverId, message,senderPersonalId, } = data;
      // const senderSocketId = userSockets[senderPersonalId]?.socketId;
      // console.log(`inside server the sender id is : ${senderId} and socket is : ${senderSocketId}`);
      console.log( `receiver is : ${receiverId}`);
      console.log(`Message from ${senderId} to ${receiverId}: ${message}`);
      // const recipientId = userSockets[receiverId]?.socketId;
      const recipient = userSockets[receiverId];
      const recipientId = recipient?.socketId;
    

      if (recipientId) {
        // const recipientId = userSockets[receiverId].socketId;
        const textReceiver = recipientId;
        console.log(`receiver found: ${textReceiver}`);
        io.to(textReceiver).emit("receive_message", {
        //   message,
         message: message,
          sender: senderId,
        //   receiver: receiverId,
        replyReceiverId: senderPersonalId,
        });
        callback("Message delivered");
      } else {
        callback("Recipient not connected");
      }      
    });
    
    socket.on("disconnect", () => {
        // Remove user from the map when they disconnect
        for (let userId in userSockets) {
          if (userSockets[userId] === socket.id) {
            delete userSockets[userId];
            break;
          }
        }
        console.log("User disconnected");
      });
});



server.listen(port, '0.0.0.0',()=>{
    console.log(`server is started at port: ${port}`);
});