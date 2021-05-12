(function(){
    var mq = window.matchMedia('(max-width: 800px)');
    if (mq.matches) {
        document.body.classList.remove("has-sidenav");
    }
    mq.addEventListener('change', (e) => {
        if(mq.matches) {
            document.body.classList.remove("has-sidenav");
        }
    });
    var toggle = document.getElementById('toggle');
    toggle.addEventListener('click', (e) => {
        document.body.classList.toggle("has-sidenav");
    });
})();
