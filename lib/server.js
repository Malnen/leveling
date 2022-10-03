const admin = require('firebase-admin');
const serviceAccount = require('./leveling-mob-firebase-adminsdk-sit74-4e6da0a600.json');
const notification_options = {
    priority: 'high',
    timeToLive: 60 * 60 * 24
};
const express = require('express')
const app = express()
const port = 9970
const bp = require('body-parser')

app.use(bp.json())
app.use(bp.urlencoded({extended: true}))

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

app.post('/sendNotification', (req, res) => {
    const registrationToken = req.body.token
    const options = notification_options
    const message = {
        data: req.body.data
    }
    console.log(req.body)

    admin.messaging()
        .sendToDevice(registrationToken, message, options)
        .then((response) => {
            console.log('Successfully sent message:', response);
        })
        .catch((error) => {
            console.log('Error sending message:', error);
        });
})

app.listen(port, () => {
    console.log('Node.js web server at port ' + port + ' is running..')
})
