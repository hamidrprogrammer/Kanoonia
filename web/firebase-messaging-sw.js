// importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js");
// importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js");

// // For Firebase JS SDK v7.20.0 and later, measurementId is optional
// const firebaseConfig = {
//   apiKey: "AIzaSyD6dz46y3hvIdUm8cjmAJSR088sNB1rxU8",
//   authDomain: "kanooniha-android.firebaseapp.com",
//   projectId: "kanooniha-android",
//   storageBucket: "kanooniha-android.appspot.com",
//   messagingSenderId: "390565445089",
//   appId: "1:495671824064:web:b4fade677302788cc56725",
//   measurementId: "G-DHD483FTQ5"
// };
// // firebase.initializeApp(firebaseConfig);

// // const messaging = firebase.messaging();

// // messaging.onBackgroundMessage((message) => {
// //   var payload = message.notification;
// //   var notificationTitle = payload.title;
// //   var notificationOptions = {
// //     body: payload.body,
// //     icon: payload.icon,
// //     image: payload.image,
// //     data: message.data.link,
// //   };

// //   return self.registration.showNotification(notificationTitle, notificationOptions);
// // });


// var onClick = function (event) {
//   event.notification.close();
//   const data = event.notification.data;
//   if (data) {
//     event.waitUntil(clients.openWindow(data));
//   }
// }

// self.addEventListener('notificationclick', onClick);
