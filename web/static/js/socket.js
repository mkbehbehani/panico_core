// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("releases:all", {})
channel.join()
  .receive("ok", ({releases}) => {
    console.log("Joined successfully")
    releases.forEach(rel =>
      $(".container").append(`<p id="release_${rel.id}">From websocket: Name: ${rel.name}, Description: "${rel.description}", upvotes: ${rel.upvotes}, downvotes: ${rel.downvotes}</p>`)
    )
    console.log(releases)
  })
  .receive("error", resp => { console.log("Unable to join", resp) })

// channel.on("new_release", rel => { console.log("New release", rel) } )
channel.on("new_release", rel => {$(".container").append(`<p id="release_${rel.id}">From websocket: Name: ${rel.name}, Description: "${rel.description}", upvotes: ${rel.upvotes}, downvotes: ${rel.downvotes}</p>`)})
channel.on("updated_release", rel => {console.log('updated release');
  $(`#release_${rel.id}`).replaceWith(`<p id="release_${rel.id}">From websocket: Name: ${rel.name}, Description: "${rel.description}", upvotes: ${rel.upvotes}, downvotes: ${rel.downvotes}</p>`)})
channel.on("deleted_release", rel => {$(`#release_${rel.id}`).remove()})
// channel.on("deleted_release", id => {
//   const id = `release_${id}`;
//   console.log("Deletion request for " + id)
//   $(id).remove;
// })
export default socket
