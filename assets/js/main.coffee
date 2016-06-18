###
$        = require('zepto-browserify').$
fs       = require('fs')

photos =$('.photos')

# video switcher

titlebar = $('.video .stage h2')
iframe = $('.video .stage iframe')
thumbs = $('.more-videos .others li')

thumbs.on 'click', ->
  new_title = $(@).find('span').text()
  new_id = $(@).data('id')

  titlebar.text(new_title)
  iframe.attr('src', "http://www.youtube.com/embed/#{new_id}?hd=1&rel=0&autohide=1&showinfo=0&autoplay=1")

  thumbs.removeClass('active')
  $(@).addClass('active')
###

###
dirname = '/img/photos/use';
fs.stat(dirname, (err, stats) {
    if (err) {
        return console.error(err);
    }
    console.log(stats);
    console.log("Got file info successfully!");

    // Check file type
    console.log("isFile ? " + stats.isFile());
    console.log("isDirectory ? " + stats.isDirectory());
});
###
console.log 'You reached the website of Iain Arthur Ross Maitland, props for checking out the console!'
document.getElementById('footer').innerHTML += '<br>iainmaitland2016'
