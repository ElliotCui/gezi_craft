a = new WebSocket("ws://0.0.0.0:8080/");
a.onmessage = function(a){console.log(a.data);};
a.send("{\"action\":\"get_position\"}");
a.send("{\"action\":\"get_heros\"}");