const compression = require('compression')
const express = require('express')
const ffmpeg = require('fluent-ffmpeg');
const  app = express();

app.use(compression({
    threshold : 0, // or whatever you want the lower threshold to be
    filter    : function(req, res) {
        var ct = res.get('content-type');
        return true;
    }
}));

app.use(express.static('files'));

const port = 3000
const baseURL= "/Users/alibabaoglu/CPD-Video-Player/backend";

function getThumbail(id) {
    ffmpeg(baseURL+'/files/videos/mp4/1080p.mp4')
        .on('filenames', function (filenames) {
            console.log('Will generate ' + filenames.join(', '))
        })
        .on('end', function () {
            console.log('Screenshots taken');
        })
        .screenshots({
            timestamps: [3.0],
            filename: "1080.png",
            folder: baseURL+'/files/videos/thumbail'
        });
}

app.get('/', (req, res) => {
    res.send('cpd-backend')
})
// server-sent event stream
app.get('/events', function (req, res) {
    res.setHeader('Content-Type', 'text/event-stream')
    res.setHeader('Cache-Control', 'no-cache')

    // send a ping approx every 2 seconds
    var timer = setInterval(function () {
        res.write('data: ping\n\n')

        // !!! this is the important part
        res.flush()
    }, 2000)

    res.on('close', function () {
        clearInterval(timer)
    })
})

app.get('/videos', (req, res) => {
    getThumbail("");
    res.json( {
        videoUrl:"http://localhost:3000/videos/master.m3u8",
        thumbnailUrl: "http://localhost:3000/videos/thumbail/1080.png",
        title: ".....",
        description: "......",
    });
    console.log(req);
})


app.listen(process.env.PORT || 3000, () => {
    console.log(`App listening at http://localhost:${port}`)
})