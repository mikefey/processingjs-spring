$(document).ready(function() {
    var processingInstance;
    var initialSetupInterval = 0;

    function init() {
        $(window).bind('resize', onResize);

        setup();
        sizeCanvas();
    }

    function setup() {
        initialSetupInterval = setInterval(function() {
            processingInstance = Processing.getInstanceById('app');

            if (processingInstance) {
                clearInterval(initialSetupInterval);
            }
        }, 13);
    }

    function onResize() {
        if (processingInstance) {
            processingInstance.onResize();
        }

        sizeCanvas();
    }

    function sizeCanvas() {
        // get the canvas and context
        var canvas = document.getElementById('app');
        var context = canvas.getContext('2d');
        var devicePixelRatio = window.devicePixelRatio || 1;
        var backingStoreRatio = context.webkitBackingStorePixelRatio ||
            context.mozBackingStorePixelRatio ||
            context.msBackingStorePixelRatio ||
            context.oBackingStorePixelRatio ||
            context.backingStorePixelRatio || 1;

        var ratio = devicePixelRatio / backingStoreRatio;

        // upscale the canvas if the two ratios don't match
        if (devicePixelRatio !== backingStoreRatio) {
            var oldWidth = canvas.width;
            var oldHeight = canvas.height;

            canvas.width = oldWidth * ratio;
            canvas.height = oldHeight * ratio;

            canvas.style.width = oldWidth + 'px';
            canvas.style.height = oldHeight + 'px';

            // now scale the context to counter
            // the fact that we've manually scaled
            // our canvas element
            context.scale(ratio, ratio);
        }
    }

    init();
});