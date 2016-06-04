$(document).ready(function() {
    function ranNum() {
       return Math.floor((Math.random() * 2300) + 1)
    };
    var rand = ranNum();
    $("#jquery_jplayer_1").jPlayer({
        ready: function () {
            $(this).jPlayer("setMedia", {
            title: "RainForest",
            mp3: "http://ec2-52-40-79-161.us-west-2.compute.amazonaws.com/audio/rainforest.mp3"
            }).jPlayer("play", rand);
        },
        ended: function() {
        $(this).jPlayer("play", rand);
        },
    cssSelectorAncestor: "#jp_container_1",
    swfPath: "/js",
    supplied: "mp3",
    useStateClassSkin: true,
    autoBlur: false,
    smoothPlayBar: true,
    keyEnabled: true,
    remainingDuration: true,
    toggleDuration: true
    }).hide();

    $('#image').on({
    'click': function(){

        var temp = $('#image').attr('src');
        if (temp === 'images/volume0.png') {
            $('#image').attr('src', 'images/volume1.png')
            $("#jquery_jplayer_1").jPlayer("volume", 0.75);
            }
        //
        if (temp === 'images/volume1.png') {
            $('#image').attr('src', 'images/volume2.png')
            $("#jquery_jplayer_1").jPlayer("volume", 0.50);
            }
        // 
        if (temp === 'images/volume2.png') {
            $('#image').attr('src', 'images/volume3.png')
            $("#jquery_jplayer_1").jPlayer("volume", 0.25);
            }
        //    
        if (temp === 'images/volume3.png') {
            $('#image').attr('src', 'images/volume0.png')
            $("#jquery_jplayer_1").jPlayer("volume", 0.99);
            }
        }
    });

    $('#circle').click(function () {
        var visible = $('#popupYoutube').css('visibility');
        if (visible === 'hidden') {
            $('#popupYoutube').css('visibility', 'visible').hide().fadeIn('slow').delay(5000).fadeOut('slow');
        } else if (visible === 'visible') {
            $('#popupYoutube').fadeOut('slow', function() {
                $('#popupYoutube').css('visibility', 'hidden')
            });

        }
    });

    $('#circleWhite').click(function () {
        var visible = $('#popupAbout').css('visibility');
        if (visible === 'hidden') {
            $('#popupAbout').css('visibility', 'visible').hide().fadeIn('slow').delay(7000).fadeOut('slow');
        } else if (visible === 'visible') {
            $('#popupAbout').fadeOut('slow', function() {
                $('#popupAbout').css('visibility', 'hidden')
            });
        }
    });
});