(function () {
    var menuBtn = document.getElementById('menuBtn');
    var sidebar = document.getElementById('sidebar');
    var overlay = document.getElementById('sidebarOverlay');
    var mobileMq = window.matchMedia('(max-width: 1023.98px)');

    if (!menuBtn || !sidebar || !overlay) {
        return;
    }

    function setOpenState(isOpen) {
        sidebar.classList.toggle('open', isOpen);
        overlay.classList.toggle('active', isOpen);
        overlay.setAttribute('aria-hidden', isOpen ? 'false' : 'true');
        menuBtn.setAttribute('aria-expanded', isOpen ? 'true' : 'false');
        document.body.classList.toggle('app-shell-open', isOpen && mobileMq.matches);
    }

    function openSidebar() {
        if (!mobileMq.matches) {
            return;
        }
        setOpenState(true);
    }

    function closeSidebar() {
        setOpenState(false);
    }

    menuBtn.addEventListener('click', function () {
        if (!mobileMq.matches) {
            return;
        }
        setOpenState(!sidebar.classList.contains('open'));
    });

    overlay.addEventListener('click', closeSidebar);

    sidebar.addEventListener('click', function (event) {
        if (mobileMq.matches && event.target.closest('a')) {
            closeSidebar();
        }
    });

    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
            closeSidebar();
        }
    });

    if (typeof mobileMq.addEventListener === 'function') {
        mobileMq.addEventListener('change', function (event) {
            if (!event.matches) {
                closeSidebar();
            }
        });
    }

    window.appShell = {
        openSidebar: openSidebar,
        closeSidebar: closeSidebar
    };
})();
