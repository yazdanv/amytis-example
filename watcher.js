var fs = require('fs');
var argv = require('optimist').argv;
var bonjour = require('bonjour')()
var net = require('net');

var clients = [];



const viewFiles = ["amy", "html", "xml"];
const codeFiles = ["js", "ts", "javascript", "ac"];
const imageFiles = ["png", "jpg", "jpeg", "gif"];
const paramFiles = ["parameters", "params"];
const languageFiles = ["lang", "language"];

var path0 = argv.path;
var config = JSON.parse(fs.readFileSync(path0 + '/amytis.json', 'utf8'));
var path = path0 + config.path;
var imagePath = argv.imagePath;
if (path) {
    var port = parseInt(Math.random() * (8999 - 8001) + 8001);
    if (argv.port) {
        port = parseInt(argv.port);
    }
    bonjour.publish({ name: "AmytisWatcher", type: "amytis_" + config.id.replace(".", ""), port: port, txt: { name: config.name, port: port}})
    

    const Filehound = require('filehound');

    const subdirectories = Filehound.create()
        .path(path)
        .directory()
        .findSync();



    function broadcast(event, message) {
        var msg = { event: event, data: message };
        clients.forEach(function (client) {
            client.write(JSON.stringify(msg));
        });
    }


    var server = net.createServer(function (socket) {
        socket.name = socket.remoteAddress + ":" + socket.remotePort
        console.log(socket.name + " Joined\n");
        clients.push(socket);
        socket.write("Welcome " + socket.name + "\n");
        socket.on('data', function (data) {
            try {
                var jsn = JSON.parse(data);
                if (jsn) {
                    var event = jsn.event;
                    var info = jsn.data;
                    if (event) {
                        if (event == "image") {
                            if (info.image) {
                                require("fs").writeFile(socket.handshake.address + ".jpg", info.buffer, 'base64', function (err) { });
                            }
                        } else if (event == "requestImage") {
                            var filename = info;
                            subdirectories.forEach(function (dir) {
                                fs.readFile(dir + "/" + filename, function (err, data) {
                                    if (data) {
                                        const bit = new Buffer(data).toString('base64');
                                        socket.emit('saveImage', { "name": filename, "data": bit });
                                        // console.log(filename + " sent");
                                    }
                                });
                            });
                        } else if (event == "requestFiles") {
                            var filename = info;
                            viewFiles.forEach(function (ext) {
                                const files = Filehound.create().paths(path).ext(ext).findSync();
                                files.forEach(function (filename) {
                                    var parts = filename.split('.');
                                    fs.readFile(filename, 'utf8', function (err, data) {
                                        if (data) {
                                            broadcast('data', data.replace('class="local"', 'class="' + parts[parts.length - 2] + '"'));
                                        }
                                    });
                                });
                            })
                        } else if (event == "log") {
                            console.log(info);
                        }
                    }
                }
            } catch(e) {

            }
        });
        socket.on('end', function () {
            clients.splice(clients.indexOf(socket), 1);
        });
    });

    server.listen(port, '0.0.0.0');

    subdirectories.forEach(function(dir) {
        fs.watch(dir, function (eventType, filename) {
            if (filename) {
                // console.log(filename + " changed");
                var parts = filename.split('.');
                if (parts.length >= 2) {
                    const ext = parts[parts.length - 1]
                    if (viewFiles.includes(ext)) {
                        fs.readFile(dir + "/" + filename, 'utf8', function (err, data) {
                            if (data) {
                                broadcast('data', data.replace('class="local"', 'class="' + parts[0] + '"').replace('&&', '&amp;&amp;'));
                            }
                        });
                    } else if (imageFiles.includes(ext)) {
                        fs.readFile(dir + "/" + filename, function (err, data) {
                            if (data) {
                                const bit = new Buffer(data).toString('base64');
                                broadcast('saveImage', {"name": filename, "data": bit});
                            }
                        });
                    } else if (filename.includes("parameters.json")) {
                        fs.readFile(dir + "/" + filename, 'utf8', function (err, data) {
                            if (data) {
                                broadcast('parameters', data);
                                // io.emit('image', "");
                            }
                        });
                    } else if (filename.includes("language.json")) {
                        fs.readFile(dir + "/" + filename, 'utf8', function (err, data) {
                            if (data) {
                                broadcast('language', data);
                                // io.emit('image', "");
                            }
                        });
                    } else if (filename.includes("colors.json")) {
                        fs.readFile(dir + "/" + filename, 'utf8', function (err, data) {
                            if (data) {
                                broadcast('colors', data);
                                // io.emit('image', "");
                            }
                        });
                    }
                }
            }
        });
    });
    // console.log("app running on port " + port);
} else {
    console.log("please provide path")
}




